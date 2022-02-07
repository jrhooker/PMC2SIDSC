<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times">

  <xsl:import href="process-address-maps.xsl"/>

  <xsl:param name="memoryMapTable" select="false()"/>

  <xsl:param name="STARTING-DIR"/>

  <xsl:template match="xref">
    <xsl:variable name="filename">
      <xsl:call-template name="generate-target">
        <xsl:with-param name="href" select="@href"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="xref">
      <xsl:attribute name="href" select="$filename"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:variable name="STARTING-DIR-VAR">
    <xsl:choose>
      <xsl:when test="contains($STARTING-DIR, 'c:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'c:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($STARTING-DIR, 'C:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'C:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($STARTING-DIR, 'd:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'd:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($STARTING-DIR, 'D:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'D:'), '\', '/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate($STARTING-DIR, '\', '/')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:param name="OUTPUT-DIR"/>

  <xsl:variable name="OUTPUT-DIR-VAR">
    <xsl:choose>
      <xsl:when test="contains($OUTPUT-DIR, 'c:')">
        <xsl:value-of select="translate(substring-after($OUTPUT-DIR, 'c:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($OUTPUT-DIR, 'C:')">
        <xsl:value-of select="translate(substring-after($OUTPUT-DIR, 'C:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($OUTPUT-DIR, 'd:')">
        <xsl:value-of select="translate(substring-after($OUTPUT-DIR, 'd:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($OUTPUT-DIR, 'D:')">
        <xsl:value-of select="translate(substring-after($OUTPUT-DIR, 'D:'), '\', '/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate($OUTPUT-DIR, '\', '/')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:param name="FILENAME"/>

  <!--<xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA SIDSC Memory Map//EN"
    doctype-system="atmel-sidsc-memoryMap.dtd"/>-->

  <xsl:output method="xml" media-type="text/xml" indent="no" encoding="UTF-8"
    doctype-public="-//OASIS//DTD DITA 1.2 Topic//EN" doctype-system="topic.dtd"/>

  <xsl:template match="/">
    <!-- We're going to be processing the linked resources separately, so pull them into variables -->

    <!-- now process the current map itself -->
    <xsl:message>Path to project: <xsl:value-of select="$STARTING-DIR-VAR"/></xsl:message>
    <xsl:message>Path to output: <xsl:value-of select="$OUTPUT-DIR-VAR"/></xsl:message>
    <xsl:message>FILENAME: <xsl:value-of select="$FILENAME"/></xsl:message>

    <xsl:apply-templates/>

  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="topicref" name="topicref">
    <xsl:param name="href-prefix"/>
    <xsl:variable name="topicref-id" select="generate-id()"/>
    <xsl:element name="topicref">
      <xsl:copy-of select="@*"/>
      <xsl:choose>
        <xsl:when test="document(@href)//address-map">
          <xsl:message>Found an address map</xsl:message>
          <xsl:call-template name="create-address-map-topic">
            <xsl:with-param name="href">
              <xsl:value-of select="@href"/>
            </xsl:with-param>
            <xsl:with-param name="href-prefix">
              <xsl:value-of select="$href-prefix"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="contains(@href, '.ditamap')">
          <xsl:message>Found a ditamap</xsl:message>
          <xsl:call-template name="process-ditamap">
            <xsl:with-param name="href">
              <xsl:value-of select="@href"/>
            </xsl:with-param>
            <xsl:with-param name="href-prefix">
              <xsl:value-of select="$href-prefix"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>No reg-def found</xsl:message>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="create-address-map-topic">
    <xsl:param name="href"/>
    <xsl:param name="href-prefix"/>
    <xsl:variable name="input-directory" select="concat($STARTING-DIR-VAR, $href-prefix, $href)"/>
    <xsl:variable name="document" select="document($input-directory)"/>
    <xsl:variable name="path-out">
      <xsl:choose>
        <xsl:when test="contains($href, '/')">
          <xsl:value-of
            select="translate(substring($href, 1, index-of(string-to-codepoints($href), string-to-codepoints('/'))[last()] - 1), '/', '')"
          />
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="topicref-id">
      <xsl:choose>
        <xsl:when test="contains($href, '/')">
          <xsl:variable name="href-values" select="tokenize($href, '/')"/>
          <xsl:value-of select="$href-values[last()]"/>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>
    <xsl:for-each select="$document//table[descendant::address-map]">
      <xsl:variable name="ids" select="@id"/>
      <xsl:variable name="memory-map-name" select="concat('/', @id, '_', $topicref-id)"/>
      <xsl:message>address-block: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $memory-map-name)}">
        <xsl:choose>
          <xsl:when test="$memoryMapTable">
            <xsl:element name="memoryMap">
              <xsl:element name="memoryMapName">
                <xsl:value-of select="title"/>
              </xsl:element>
              <xsl:element name="memoryMapBody">
                <xsl:element name="bitsInLau"/>
                <xsl:element name="memoryMapClass"/>
              </xsl:element>
              <xsl:for-each select="tgroup/address-map/register-reference">
                <xsl:element name="addressBlock">
                  <xsl:element name="addressBlockName">
                    <xsl:value-of select="addr-element/addr-mnemonic"/>
                    <xsl:value-of select="addr-element/addr-prefix"/>
                  </xsl:element>
                  <xsl:element name="addressBlockBody">
                    <xsl:element name="addressBlockProperties">
                      <xsl:element name="addressBlockPropSet">
                        <xsl:element name="baseAddress">
                          <xsl:value-of select="address"/>
                        </xsl:element>
                        <xsl:element name="range">[RANGE]</xsl:element>
                        <xsl:element name="width">[WIDTH]</xsl:element>
                        <xsl:element name="byteOrder">[BYTEORDER]</xsl:element>
                      </xsl:element>

                      <xsl:if test="addr-element/instances">
                        <xsl:for-each select="addr-element/instances">
                          <xsl:element name="instanceParameters">
                            <xsl:element name="instancesNumber">
                              <xsl:value-of
                                select="number(instance/instance-stop) - number(instance/instance-start) + 1"
                              />
                            </xsl:element>
                            <xsl:element name="instanceOffsets">
                              <xsl:value-of select="instance/instance-start"/>
                            </xsl:element>
                            <xsl:element name="unitQualifier">unitQualifier</xsl:element>
                            <xsl:element name="namePattern">
                              <xsl:choose>
                                <xsl:when test="parent::addr-element/addr-mnemonic">
                                  <xsl:value-of
                                    select="substring-before(substring-after(parent::addr-element/addr-mnemonic, '['), ']')"
                                  />
                                </xsl:when>
                                <xsl:when test="parent::addr-element/addr-prefix"><xsl:value-of
                                    select="substring-before(substring-after(parent::addr-element/addr-prefix, '['), ']')"
                                  />></xsl:when>
                              </xsl:choose>
                            </xsl:element>
                          </xsl:element>
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:element>
                  </xsl:element>
                  <xsl:element name="register">
                    <xsl:value-of select="(address-details//xref/@href, '/')"/>
                  </xsl:element>
                </xsl:element>
              </xsl:for-each>
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="topic">
              <xsl:attribute name="id">
                <xsl:choose>
                  <xsl:when test="@id">
                    <xsl:value-of select="@id"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="generate-id()"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:element name="title">
                <xsl:value-of select="title"/>
              </xsl:element>
              <xsl:element name="body">
                <xsl:element name="table">
                  <xsl:attribute name="outputclass"> ADDRESS_TABLE </xsl:attribute>
                  <xsl:element name="title">
                    <xsl:value-of select="title"/>
                  </xsl:element>
                  <xsl:element name="tgroup">
                    <xsl:attribute name="cols">3</xsl:attribute>
                    <xsl:element name="colspec">
                      <xsl:attribute name="colname">_1</xsl:attribute>
                      <xsl:attribute name="colwidth">148*</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="colspec">
                      <xsl:attribute name="colname">_2</xsl:attribute>
                      <xsl:attribute name="colwidth">218*</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="colspec">
                      <xsl:attribute name="colname">_3</xsl:attribute>
                      <xsl:attribute name="colwidth">634*</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="thead">
                      <xsl:element name="row">
                        <xsl:element name="entry">Base Address</xsl:element>
                        <xsl:element name="entry">Functional Unit</xsl:element>
                        <xsl:element name="entry">Functional Unit Description</xsl:element>
                      </xsl:element>
                    </xsl:element>
                    <xsl:element name="tbody">
                      <xsl:for-each select="tgroup/address-map/register-reference">
                        <xsl:element name="row">
                          <xsl:element name="entry">
                            <xsl:value-of select="address"/>
                          </xsl:element>
                          <xsl:element name="entry">
                            <xsl:element name="p">
                              <xsl:choose>
                                <xsl:when test="addr-element/address-prefix"> Prefix: <xsl:element
                                    name="ph">
                                    <xsl:attribute name="outputclass"> PREFIX </xsl:attribute>
                                    <xsl:value-of select="addr-element/address-prefix"/>
                                  </xsl:element>
                                </xsl:when>
                                <xsl:when test="addr-element/addr-mnemonic"> Mnemonic: <xsl:element
                                    name="ph">
                                    <xsl:attribute name="outputclass"> MNEMONIC </xsl:attribute>
                                    <xsl:value-of select="addr-element/addr-mnemonic"/>
                                  </xsl:element>
                                </xsl:when>
                              </xsl:choose>
                            </xsl:element>

                            <xsl:for-each select="addr-element/instances/instance">
                              <xsl:element name="p">START: <xsl:element name="ph">
                                  <xsl:attribute name="outputclass"> START </xsl:attribute>
                                  <xsl:value-of select="instance-start"/>
                                </xsl:element>
                              </xsl:element>
                              <xsl:element name="p">STOP: <xsl:element name="ph">
                                  <xsl:attribute name="outputclass"> STOP </xsl:attribute>
                                  <xsl:value-of select="instance-stop"/>
                                </xsl:element>
                              </xsl:element>
                            </xsl:for-each>
                          </xsl:element>
                          <xsl:element name="entry">
                            <xsl:apply-templates select="address-details"/>
                          </xsl:element>
                        </xsl:element>
                      </xsl:for-each>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="address-details">
    <xsl:apply-templates/>
  </xsl:template>

<xsl:template match="p">
  <xsl:element name="p">
    <xsl:apply-templates></xsl:apply-templates>
  </xsl:element>
</xsl:template>

  <xsl:template name="calc-bitwidth">
    <xsl:choose>
      <xsl:when test="field-bits/single">1</xsl:when>
      <xsl:when test="field-bits/double">
        <xsl:variable name="lsb" select="field-bits/double/lsb"/>
        <xsl:variable name="msb" select="field-bits/double/msb"/>
        <xsl:value-of select="number($msb) - number($lsb) + 1"/>
      </xsl:when>
      <xsl:otherwise>InvalidBitValue</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="copy">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="copy"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="copy-address-table">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="copy-address-table"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template name="process-ditamap">
    <xsl:param name="href"/>
    <xsl:param name="href-prefix"/>
    <xsl:variable name="reg-file-name" select="concat('/', @id, '.xml')"/>
    <xsl:variable name="input-directory" select="concat($STARTING-DIR-VAR, $href-prefix, $href)"/>
    <xsl:message>INPUT DIRECTORY: <xsl:value-of select="$input-directory"/></xsl:message>
    <xsl:variable name="document" select="document($input-directory)"/>
    <xsl:variable name="path-out">
      <xsl:variable name="path-out">
        <xsl:call-template name="process-path">
          <xsl:with-param name="href" select="$href"/>
        </xsl:call-template>
      </xsl:variable>
    </xsl:variable>
    <xsl:message>TITLE2: <xsl:value-of select="@id"/>
    </xsl:message>
    <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $reg-file-name)}">
      <xsl:element name="topic">
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="@id">
              <xsl:value-of select="@id"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="generate-id()"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:element name="title">
          <xsl:value-of select="title"/>
        </xsl:element>
      </xsl:element>
    </xsl:result-document>
  </xsl:template>

  <xsl:template name="process-path">
    <xsl:param name="href"/>
    <xsl:choose>
      <xsl:when test="contains($href, '/')">
        <xsl:value-of
          select="translate(substring($href, 1, index-of(string-to-codepoints($href), string-to-codepoints('/'))[last()] - 1), '/', '')"
        />
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>



</xsl:stylesheet>
