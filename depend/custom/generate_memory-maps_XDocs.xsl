<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times">

  <xsl:import href="process-address-maps_XDocs.xsl"/>

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

  <!--  <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA SIDSC Memory Map//EN"
    doctype-system="atmel-sidsc-memoryMap.dtd"/> -->

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
        <xsl:when test="document(@href)//table[contains(@outputclass, 'register-ADDRESS_TABLE')]">
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
          <xsl:message>No address table found</xsl:message>
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
    <xsl:variable name="filename">
      <xsl:choose>
        <xsl:when test="contains($href, '/')">
          <xsl:variable name="href-values" select="tokenize($href, '/')"/>
          <xsl:value-of select="$href-values[last()]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@href"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:for-each select="$document//table[contains(@outputclass, 'register-ADDRESS_TABLE')]">
      <xsl:variable name="ids" select="@id"/>
      <xsl:variable name="memory-map-name" select="concat('/', $filename)"/>
      <xsl:message>address-block: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $memory-map-name)}">
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
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
              </xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tgroup">
    <xsl:element name="tgroup">
      <xsl:attribute name="cols">
        <xsl:value-of select="count(tbody/row[1]/entry)"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="title">
    <xsl:element name="title">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="colspec">
    <xsl:element name="colspec">
      <xsl:attribute name="colname">
        <xsl:value-of select="@colname"/>
      </xsl:attribute>
      <xsl:attribute name="colwidth">
        <xsl:value-of select="@colwidth"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="thead">
    <xsl:element name="thead">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tbody">
    <xsl:element name="address-map">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="row">
    <xsl:choose>
      <xsl:when test="ancestor::thead">
        <xsl:element name="row">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="register-reference">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="entry">
    <xsl:choose>
      <xsl:when test="ancestor::thead">
        <xsl:element name="entry">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="reform-address-entry"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="reform-address-entry">
    <xsl:choose>
      <xsl:when test="count(following-sibling::entry) = 2">
        <xsl:element name="address">
          <xsl:value-of select="."/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="count(following-sibling::entry) = 1">
        <xsl:element name="addr-element">
          <xsl:call-template name="addr-element"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="count(following-sibling::entry) = 0">
        <xsl:element name="address-details">
          <xsl:element name="p">
            <xsl:call-template name="address-details"/>
          </xsl:element>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="addr-element">
    <xsl:if test="descendant::ph[contains(@outputclass, 'register-MNEMONIC')]">
      <xsl:element name="addr-mnemonic">
        <xsl:value-of select="descendant::ph[contains(@outputclass, 'register-MNEMONIC')]"/>
      </xsl:element>
    </xsl:if>

    <xsl:if test="descendant::ph[contains(@outputclass, 'register-PREFIX')]">
      <xsl:element name="address-prefix">
        <xsl:value-of select="descendant::ph[contains(@outputclass, 'register-PREFIX')]"/>
      </xsl:element>
    </xsl:if>

    <xsl:if test="descendant::ph[contains(@outputclass, 'register-START')]">
      <xsl:element name="instances">
        <xsl:element name="instance-start">
          <xsl:value-of select="descendant::ph[contains(@outputclass, 'register-START')]"/>
        </xsl:element>
        <xsl:element name="instance-stop">
          <xsl:value-of select="descendant::ph[contains(@outputclass, 'register-STOP')]"/>
        </xsl:element>
      </xsl:element>
    </xsl:if>

  </xsl:template>

  <xsl:template name="address-details">
    <xsl:for-each select="descendant-or-self::xref">
      <xsl:element name="xref">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:for-each>

  </xsl:template>

  <xsl:template match="p">
    <xsl:element name="p">
      <xsl:apply-templates/>
    </xsl:element>
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
