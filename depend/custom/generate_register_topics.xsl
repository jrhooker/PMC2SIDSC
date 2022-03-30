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

  <xsl:import href="conversionFunctions.xsl"/>

  <xsl:import href="calculateReset.xsl"/>

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
    doctype-public="-//Atmel//DTD DITA SIDSC Register//EN" doctype-system="atmel-sidsc-register.dtd"/>
  
  <!--  <xsl:output method="xml" media-type="text/xml" indent="no" encoding="UTF-8"
    doctype-public="-//OASIS//DTD DITA 1.2 Topic//EN" doctype-system="topic.dtd"/>  -->

  <xsl:template match="/">

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
        <xsl:when test="document(@href)//reg-def">
          <xsl:message>Found a reg-def</xsl:message>
          <xsl:call-template name="create-register-topic">
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

  <xsl:template name="create-register-topic">
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
      <xsl:variable name="reg-file-name" select="concat('/', @id, '_', $topicref-id)"/>
      <xsl:message>REG-DEF1: <xsl:value-of select="@id"/>
      </xsl:message>
      <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $path-out, $reg-file-name)}">
        <xsl:element name="register">
          <xsl:attribute name="id" select="@id"/>
          <xsl:if test="title/reg-name-main/@verilog">
            <xsl:attribute name="outputclass">
              <xsl:value-of select="concat('register-verilog-', title/reg-name-main/@verilog)"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:element name="registerName">
            <xsl:value-of select="title/reg-name-main"/>
          </xsl:element>
          <xsl:element name="registerNameMore">
            <xsl:element name="registerNameFull">
              <xsl:value-of select="title/reg-name-main"/>
            </xsl:element>
            <xsl:element name="registerBriefDescription"></xsl:element>
          </xsl:element>
          <xsl:element name="registerBody">
            <xsl:element name="registerDescription">
              <xsl:value-of select="title/reg-desc"/>
            </xsl:element>
            <xsl:element name="registerProperties">
              <xsl:element name="registerPropset">
                <xsl:element name="addressOffset">0x0</xsl:element>
                <xsl:element name="registerSize">
                  <xsl:call-template name="calc-reg-size"/>
                </xsl:element>
                <xsl:element name="registerResetValue">
                  <xsl:call-template name="calc-reset-value"/>
                </xsl:element>
                <xsl:element name="bitOrder">
                  <xsl:call-template name="find-bitorder"/>
                </xsl:element>
                <xsl:element name="resetTrig"/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
          <xsl:for-each select="tgroup/reg-def/field">
            <xsl:element name="bitField">
              <xsl:attribute name="id" select="generate-id()"/>
              <xsl:if test="field-name/@verilog">
                <xsl:attribute name="outputclass">
                  <xsl:value-of select="concat('register-verilog-', field-name/@verilog)"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:element name="bitFieldName">
                <xsl:value-of select="field-name"/>
              </xsl:element>
              <xsl:element name="bitFieldBriefDescription"></xsl:element>
              <xsl:element name="bitFieldBody">
                <xsl:element name="bitFieldDescription">
                  <xsl:apply-templates select="field-desc/*" mode="field-desc"/>
                </xsl:element>
                <xsl:element name="bitFieldProperties">
                  <xsl:element name="bitFieldPropset">
                    <xsl:element name="bitWidth">
                      <xsl:call-template name="calc-bitwidth"/>
                    </xsl:element>
                    <xsl:element name="bitOffset">
                      <xsl:call-template name="calc-bitoffset"/>
                    </xsl:element>
                    <xsl:element name="bitFieldAccess">
                      <xsl:value-of select="field-type"/>
                      <xsl:if test="field-type/@sticky = 'yes'"> - [STICKY]</xsl:if>
                    </xsl:element>
                    <xsl:element name="bitFieldReset">
                      <xsl:element name="bitFieldResetValue">
                        <xsl:value-of select="field-default"/>
                      </xsl:element>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
                <xsl:if test="field-desc/field-enum-list">
                  <xsl:element name="bitFieldValues">
                    <xsl:for-each select="field-desc/field-enum-list/field-enum">
                      <xsl:element name="bitFieldValueGroup">
                        <xsl:element name="bitFieldValue">
                          <xsl:value-of select="field-enum-value"/>
                        </xsl:element>
                        <xsl:element name="bitFieldValueName">
                          <xsl:value-of select="field-enum-def"/>
                        </xsl:element>
                        <xsl:element name="bitFieldValueDescription">
                          <xsl:value-of select="field-enum-desc"/>
                        </xsl:element>
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
      <xsl:variable name="reg-file-name" select="concat('/', @id, '_', $topicref-id)"/>
      <xsl:message>ADDRESS-MAP: <xsl:value-of select="@id"/>
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

  <xsl:template name="calc-bitoffset">
    <xsl:choose>
      <xsl:when test="field-bits/single"><xsl:value-of select="field-bits/single"/></xsl:when>
      <xsl:when test="field-bits/double"><xsl:value-of select="field-bits/double/lsb"/></xsl:when>
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
      <xsl:variable name="reg-file-name" select="concat('/', @id, '_', $topicref-id)"/>
      <xsl:message>REG-DEF2: <xsl:value-of select="@id"/>
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
          <xsl:element name="title">REG-DEF3: <xsl:value-of select="title"/>
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
      <xsl:message>REG-DEF4: <xsl:value-of select="@id"/>
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

  <xsl:template name="calc-reg-size">
    <xsl:variable name="values1" select="tgroup/reg-def/field/field-bits/single"/>
    <xsl:variable name="values2" select="tgroup/reg-def/field/field-bits/double/msb"/>

    <!-- It turns out that some engineers were a little lazy about filling in all the necessary bit fields, so instead of being able to check
  for the exact right width we need to check to make sure that the field is too big to be anything less than the next size up. Make sense? -->

    <xsl:choose>
      <xsl:when test="max($values2) &gt; 511 or max($values1) &gt; 511">1024</xsl:when>
      <xsl:when test="max($values2) &gt; 255 or max($values1) &gt; 255">512</xsl:when>
      <xsl:when test="max($values2) &gt; 127 or max($values1) &gt; 127">256</xsl:when>
      <xsl:when test="max($values2) &gt; 63 or max($values1) &gt; 63">128</xsl:when>
      <xsl:when test="max($values2) &gt; 31 or max($values1) &gt; 31">64</xsl:when>
      <xsl:when test="max($values2) &gt; 15 or max($values1) &gt; 15">32</xsl:when>
      <xsl:when test="max($values2) &gt; 7 or max($values1) &gt; 7">16</xsl:when>
      <xsl:when test="max($values2) &gt; 0 or max($values1) &gt;= 0"/>
      <xsl:otherwise>Something Wrong with Reg Size Calculation:<xsl:value-of select="max($values1)"
          />::<xsl:value-of select="max($values2)"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="find-bitorder">
    <xsl:variable name="bitwidth">
      <xsl:variable name="temp">
        <xsl:call-template name="calc-reg-size"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="not(contains($temp, 'Something'))">
          <xsl:value-of select="number($temp)"/>
        </xsl:when>
        <xsl:otherwise>100000000</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="values1" select="tgroup/reg-def/field/field-bits/single"/>
    <xsl:variable name="values2" select="tgroup/reg-def/field/field-bits/double/msb"/>
    <xsl:choose>
      <xsl:when
        test="number($values2[1]) = number($bitwidth - 1) or number($values1[1]) = number($bitwidth - 1)"
        >decrement</xsl:when>
      <xsl:when test="number($values2[1]) = 0 or number($values1[1]) = 0">increment</xsl:when>
      <xsl:otherwise>
        <xsl:message>Something Wrong With Bitorder Calculation</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="desc-title" mode="field-desc">
    <xsl:element name="p">
      <xsl:element name="b">
        <xsl:apply-templates mode="field-desc"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum-list" mode="field-desc">
    <xsl:element name="dl">
      <xsl:apply-templates mode="field-desc"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum" mode="field-desc">
    <xsl:element name="dlentry">
      <xsl:apply-templates mode="field-desc"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum-value" mode="field-desc">
    <xsl:element name="dt">
      <xsl:apply-templates mode="field-desc"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum-def" mode="field-desc">
    <xsl:element name="dd">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*" mode="field-desc">
    <xsl:copy copy-namespaces="no">
      <xsl:if test="@cols">
        <xsl:attribute name="cols">
          <xsl:value-of select="@cols"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates mode="field-desc"/>
    </xsl:copy>
  </xsl:template>

  <!-- RDA tables?? Really?? What the heck!! Ah, well, convert, convert, convert... -->

  <xsl:template match="table_info" mode="field-desc">
    <xsl:element name="table">
      <xsl:apply-templates mode="field-desc"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="table_name" mode="field-desc">
    <xsl:element name="title">
      <xsl:apply-templates mode="field-desc"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="table[parent::table_info]" mode="field-desc">
    <xsl:element name="tgroup">
      <xsl:attribute name="cols">
        <xsl:choose>
          <xsl:when test="child::two_col_table">2</xsl:when>
          <xsl:when test="child::three_col_table">3</xsl:when>
          <xsl:when test="child::four_col_table">4</xsl:when>
          <xsl:when test="child::five_col_table">5</xsl:when>
          <xsl:when test="child::six_col_table">6</xsl:when>
          <xsl:when test="child::seven_col_table">7</xsl:when>
          <xsl:when test="child::eight_col_table">8</xsl:when>
          <xsl:when test="child::nine_col_table">9</xsl:when>
          <xsl:when test="child::ten_col_table">10</xsl:when>
          <xsl:when test="child::eleven_col_table">11</xsl:when>
          <xsl:when test="child::twelve_col_table">12</xsl:when>
        </xsl:choose>
      </xsl:attribute>
      <xsl:element name="tbody">
        <xsl:apply-templates mode="field-desc"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="two_col_table | three_col_table | four_col_table | five_col_table | six_col_table | seven_col_table | eight_col_table | nine_col_table | ten_col_table | eleven_col_table | twelve_col_table " mode="field-desc">   
      <xsl:apply-templates mode="field-desc"/>    
  </xsl:template>

  <xsl:template match="two_col_row | three_col_row | four_col_row | five_col_row | six_col_row | seven_col_row | eight_col_row | nine_col_row | ten_col_row | eleven_col_row | twelve_col_row " mode="field-desc">
    <xsl:element name="row">
      <xsl:apply-templates mode="field-desc"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="td" mode="field-desc">
    <xsl:element name="entry">
      <xsl:apply-templates mode="field-desc"/>
    </xsl:element>
  </xsl:template>
  

</xsl:stylesheet>
