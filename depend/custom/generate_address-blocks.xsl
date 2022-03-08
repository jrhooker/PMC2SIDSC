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

  <xsl:param name="STARTING-DIR"/>

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

  <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA SIDSC Address Block//EN" doctype-system="atmel-sidsc-addressBlock.dtd"/>

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
      <xsl:variable name="ids" select="$document//@id"/>
      <xsl:variable name="address-map-name" select="concat('/', @id, '_', $topicref-id, '.xml')"/>
      <xsl:message>address-block: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $address-map-name)}">
        <xsl:element name="addressBlock">
          <xsl:attribute name="id" select="@id"/>
          <xsl:element name="addressBlockName">
            <xsl:value-of select="title"/>
          </xsl:element>
          <xsl:element name="registerNameMore">
            <xsl:element name="registerNameFull">
              <xsl:value-of select="title/reg-name-main"/>
            </xsl:element>
            <xsl:element name="registerNameBriefDescription">
              <xsl:value-of select="title/reg-name-desc"/>
            </xsl:element>
          </xsl:element>
          <xsl:element name="registerBody">
            <xsl:element name="registerDescription">[registerDescription]</xsl:element>
            <xsl:element name="registerProperties">
              <xsl:element name="registerPropSet">
                <xsl:element name="addressOffset">0x0</xsl:element>
                <xsl:element name="registerSize">32</xsl:element>
                <xsl:element name="registerAccess">RW/RO/ETC. how to calculate?</xsl:element>
                <xsl:element name="registerResetValue"><xsl:call-template name="calc-reset-value"/></xsl:element>
                <xsl:element name="bitOrder">little endian/big endian</xsl:element>
                <xsl:element name="resetTrig"/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
          <xsl:for-each select="tgroup/reg-def/field">
          <xsl:element name="bitField">
           <xsl:element name="bitFieldName"><xsl:value-of select="field-name"/></xsl:element>
            <xsl:element name="bitFieldBriefDescription"><xsl:value-of select="field-desc/p[1]"/></xsl:element>
            <xsl:element name="bitFieldBody">
              <xsl:element name="bitFieldDescription"><xsl:apply-templates select="field-desc" mode="field-desc"/></xsl:element>
              <xsl:element name="bitFieldProperties">
                <xsl:element name="bitFieldPropset">
                  <xsl:element name="bitwidth"><xsl:call-template name="calc-bitwidth"></xsl:call-template></xsl:element>
                  <xsl:element name="bitFieldAccess"><xsl:value-of select="field-type"/><xsl:if test="field-type/@sticky = 'yes'"> - [STICKY]</xsl:if></xsl:element>
                </xsl:element>
              </xsl:element>
              <xsl:if test="field-desc/field-enum-list">
              <xsl:element name="bitFieldValues">
                <xsl:for-each select="field-desc/field-enum-list/field-enum">
                  <xsl:element name="bitFieldValueGroup">
                    <xsl:element name="bitFieldValue"><xsl:value-of select="field-enum-value"/></xsl:element>
                    <xsl:element name="bitFieldValueName"><xsl:value-of select="field-enum-def"/></xsl:element>
                    <xsl:element name="bitFieldValueDescription"><xsl:value-of select="field-enum-desc"/></xsl:element>                    
                  </xsl:element>
                </xsl:for-each>
              </xsl:element>
              </xsl:if>
            </xsl:element>
          </xsl:element>  
          </xsl:for-each>
        </xsl:element>
      </xsl:result-document>
    </xsl:for-each>
    
    <xsl:for-each select="$document//table[descendant::address-map]">
      <xsl:variable name="ids" select="$document//@id"/>
      <xsl:variable name="reg-file-name" select="concat('/', @id, '_', $topicref-id, '.xml')"/>
      <xsl:message>ADDRESS-MAP: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $reg-file-name)}">
        <xsl:element name="topic">
          <xsl:attribute name="id">
            <xsl:choose>
              <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:element name="title">ADDRESS-MAP: <xsl:value-of select="title"/></xsl:element>
          <xsl:element name="body">
            <xsl:copy>
              <xsl:copy-of select="@*"/>
              <xsl:attribute name="id">
                <xsl:value-of select="concat('table_', @id)"/>
              </xsl:attribute>
              <xsl:apply-templates mode="copy-address-table"/>
            </xsl:copy>
          </xsl:element>
        </xsl:element>
      </xsl:result-document>
    </xsl:for-each>
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

  <xsl:template name="create-topic">
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
    <xsl:for-each select="$document//table[descendant::reg-def]">
      <xsl:variable name="ids" select="$document//@id"/>
      <xsl:variable name="reg-file-name" select="concat('/', @id, '_', $topicref-id, '.xml')"/>
      <xsl:message>REG-DEF: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $reg-file-name)}">
        <xsl:element name="topic">
          <xsl:attribute name="id">
            <xsl:choose>
              <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:element name="title">REG-DEF: <xsl:value-of select="title"/>
          </xsl:element>
          <xsl:element name="body">
            <xsl:copy>
              <xsl:copy-of select="@*"/>
              <xsl:attribute name="id">
                <xsl:value-of select="concat('table_', @id)"/>
              </xsl:attribute>
              <xsl:apply-templates mode="copy"/>
            </xsl:copy>
          </xsl:element>
        </xsl:element>
      </xsl:result-document>
    </xsl:for-each>
    <xsl:for-each select="$document//table[descendant::address-map]">
      <xsl:variable name="ids" select="$document//@id"/>
      <xsl:variable name="reg-file-name" select="concat('/', @id, '_', $topicref-id, '.xml')"/>
      <xsl:message>ADDRESS-MAP: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $reg-file-name)}">
        <xsl:element name="topic">
          <xsl:attribute name="id">
            <xsl:choose>
              <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:element name="title">ADDRESS-MAP: <xsl:value-of select="title"/></xsl:element>
          <xsl:element name="body">
            <xsl:copy>
              <xsl:copy-of select="@*"/>
              <xsl:attribute name="id">
                <xsl:value-of select="concat('table_', @id)"/>
              </xsl:attribute>
              <xsl:apply-templates mode="copy-address-table"/>
            </xsl:copy>
          </xsl:element>
        </xsl:element>
      </xsl:result-document>
    </xsl:for-each>
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
            <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:element name="title">
          <xsl:value-of select="title"/>
        </xsl:element>
      </xsl:element>
    </xsl:result-document>
  </xsl:template>

  <xsl:template name="create-files">
    <xsl:param name="href"/>
    <xsl:variable name="input-directory" select="concat($STARTING-DIR-VAR, $href)"/>
    <xsl:message>INPUT DIRECTORY: <xsl:value-of select="$input-directory"/></xsl:message>
    <xsl:variable name="document" select="document($input-directory)"/>
    <xsl:variable name="path-out">
      <xsl:call-template name="process-path">
        <xsl:with-param name="href" select="$href"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:for-each select="$document//table[descendant::reg-def]">
      <xsl:variable name="reg-file-name" select="concat('/', @id, '.xml')"/>
      <xsl:message>REG-DEF: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $reg-file-name)}">
        <xsl:element name="topic">
          <xsl:attribute name="id">
            <xsl:choose>
              <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:element name="title">
            <xsl:value-of select="title"/>
          </xsl:element>
        </xsl:element>
      </xsl:result-document>
    </xsl:for-each>
    <xsl:for-each select="$document//table[descendant::address-map]">
      <xsl:variable name="reg-file-name" select="concat('/', @id, '.xml')"/>
      <xsl:message>ADDRESS-MAP: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $reg-file-name)}">
        <xsl:element name="topic">
          <xsl:attribute name="id">
            <xsl:choose>
              <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:element name="title">
            <xsl:value-of select="title"/>
          </xsl:element>
        </xsl:element>
      </xsl:result-document>
    </xsl:for-each>
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
