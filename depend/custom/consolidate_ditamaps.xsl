<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times">

  <xsl:import href="filtering-attribute-resolver.xsl"/>

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
    doctype-public="-//OASIS//DTD DITA 1.2 Map//EN" doctype-system="map.dtd"/>

  <!-- <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA Map//EN" doctype-system="dtd/atmelMap.dtd"/> -->

  <xsl:template match="/">

    <!-- now process the current map itself -->
    <xsl:message>Path to project: <xsl:value-of select="$STARTING-DIR-VAR"/></xsl:message>
    <xsl:message>Path to output: <xsl:value-of select="$OUTPUT-DIR-VAR"/></xsl:message>
    <xsl:message>FILENAME: <xsl:value-of select="$FILENAME"/></xsl:message>

    <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $FILENAME)}">
      <xsl:element name="map">     
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:result-document>

  </xsl:template>

  <xsl:template match="bookmap | map">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="title">
    <xsl:element name="title">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="bookmeta | frontmatter"/>

  <xsl:template match="topichead">
    <xsl:element name="topichead">
      <xsl:attribute name="navtitle">
        <xsl:value-of select="@navtitle"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template
    match="topicref[@navtitle][not(@href)] | chapter[@navtitle][not(@href)] | appendix[@navtitle][not(@href)]">
    <xsl:element name="topichead">
      <xsl:attribute name="navtitle">
        <xsl:value-of select="@navtitle"/>           
      </xsl:attribute>
      <xsl:call-template name="filtering-attribute-management"/>    
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="topicref | chapter | appendix">
    <xsl:param name="href-prefix"/>
    <xsl:choose>
      <xsl:when test="contains(@href, '.ditamap')">
        <xsl:call-template name="process-ditamap">
          <xsl:with-param name="href-prefix">
            <xsl:value-of select="$href-prefix"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="topicref">
          <xsl:call-template name="filtering-attribute-management"/>              
          <xsl:if test="@navtitle">
            <xsl:attribute name="navtitle">
              <xsl:value-of select="@navtitle"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:variable name="corrected-href">
            <xsl:call-template name="correct-href-levels">
              <xsl:with-param name="href-in"><xsl:value-of select="concat($href-prefix, @href)"/></xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="@href">
            <xsl:attribute name="href">
              <xsl:value-of select="$corrected-href"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="process-ditamap">
    <xsl:param name="href-prefix"/>
    
    <xsl:variable name="local-path">
      <xsl:variable name="temp">
      <xsl:call-template name="process-path">
        <xsl:with-param name="href">
          <xsl:value-of select="@href"/>
        </xsl:with-param>
      </xsl:call-template>
      </xsl:variable>      
      <xsl:choose>
        <xsl:when test="string-length($temp) &gt; 0"><xsl:value-of select="concat($temp, '/')"/></xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>      
    </xsl:variable>

    <xsl:variable name="input-directory" select="concat($STARTING-DIR-VAR, $href-prefix)"/>   

    <xsl:apply-templates select="document(concat($input-directory, $href-prefix, @href))" mode="second-level">
      <xsl:with-param name="href-prefix" tunnel="yes" select="concat($href-prefix, $local-path)"/>
    </xsl:apply-templates>

  </xsl:template>
  
  <xsl:template match="map | bookmap" mode="second-level">
    <xsl:param name="href-prefix" tunnel="yes"></xsl:param> 
    <xsl:apply-templates mode="second-level">
      <xsl:with-param name="href-prefix" select="$href-prefix"></xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="title" mode="second-level"></xsl:template>
  
  <xsl:template match="topichead" mode="second-level">
    <xsl:param name="href-prefix"></xsl:param>
    <xsl:element name="topichead">
      <xsl:attribute name="navtitle"><xsl:value-of select="@navtitle"/></xsl:attribute>
      <xsl:call-template name="filtering-attribute-management"/>          
      <xsl:apply-templates mode="second-level">
        <xsl:with-param name="href-prefix" select="$href-prefix"></xsl:with-param>
      </xsl:apply-templates>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="topicref | chapter | appendix" mode="second-level">
    <xsl:param name="href-prefix"></xsl:param>
    <xsl:message>href-prefix: <xsl:value-of select="$href-prefix"/></xsl:message>
    <xsl:choose>
      <xsl:when test="not(@href)">
        <xsl:element name="topichead">
          <xsl:if test="@navtitle"><xsl:attribute name="navtitle"><xsl:value-of select="@navtitle"/></xsl:attribute></xsl:if>
          <xsl:call-template name="filtering-attribute-management"/>
          <xsl:apply-templates mode="second-level">
            <xsl:with-param name="href-prefix" select="$href-prefix"></xsl:with-param>
          </xsl:apply-templates>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="corrected-href">
          <xsl:call-template name="correct-href-levels">
            <xsl:with-param name="href-in"><xsl:value-of select="concat($href-prefix, @href)"/></xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:element name="topicref">
          <xsl:if test="@navtitle"><xsl:attribute name="navtitle"><xsl:value-of select="@navtitle"/></xsl:attribute></xsl:if>
          <xsl:call-template name="filtering-attribute-management"/>
          <xsl:if test="@href"><xsl:attribute name="href"><xsl:value-of select="$corrected-href"/></xsl:attribute></xsl:if>
          <xsl:apply-templates mode="second-level">
            <xsl:with-param name="href-prefix" select="$href-prefix"></xsl:with-param>
          </xsl:apply-templates>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
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

  <!-- this template is designed to take the path to an embedded ditamap and turn it into a parameter so that when the ditamap itself is 
    processed, this path can be concatenated onto the local paths -->

  <xsl:template name="create-href-prefix">
    <xsl:param name="href-in"/>
    <xsl:param name="href-out"/>
    <xsl:param name="count" select="1"/>

    <xsl:message>Creating an href-prefix: <xsl:value-of select="$href-in"/></xsl:message>

    <xsl:variable name="translate" select="translate($href-in, '\', '/')"/>
    <xsl:variable name="tokenized" select="tokenize($translate, '/')"/>
    <xsl:choose>
      <xsl:when test="$count &lt; count($tokenized)">
        <xsl:message>token1: <xsl:value-of select="$tokenized[$count]"/></xsl:message>
        <xsl:call-template name="create-href-prefix">
          <xsl:with-param name="href-out">
            <xsl:value-of
              select="concat(normalize-space($href-out), normalize-space($tokenized[$count]), '/')"
            />
          </xsl:with-param>
          <xsl:with-param name="href-in" select="$href-in"/>
          <xsl:with-param name="count" select="$count + 1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$href-out"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- This template is designed to strip the ../ from any resoruce paths in the topicref href elements. This is because while the 
    parsers are in general fine with this, they break the XSLT document() function which we need for reading the contents of the 
    topic. Therefore, when we're building the path we always look one token ahead for a ../ and if we find it we skip that token and the next one. -->

  <xsl:template name="correct-href-levels">
    <xsl:param name="href-in"/>
    <xsl:param name="href-out"/>
    <xsl:param name="count" select="1"/>

    <xsl:message>Correcting href levels: <xsl:value-of select="$href-in"/></xsl:message>

    <xsl:variable name="translate" select="translate($href-in, '\', '/')"/>
    <xsl:variable name="tokenized" select="tokenize($translate, '/')"/>

    <xsl:choose>
      <xsl:when test="$count &lt; count($tokenized)">
        <xsl:choose>
          <xsl:when test="contains($tokenized[$count + 1], '..')">
            <xsl:call-template name="correct-href-levels">
              <xsl:with-param name="href-in" select="$href-in"/>
              <xsl:with-param name="href-out" select="$href-out"/>
              <xsl:with-param name="count" select="$count + 1"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="contains($tokenized[$count], '..')">
            <xsl:call-template name="correct-href-levels">
              <xsl:with-param name="href-in" select="$href-in"/>
              <xsl:with-param name="href-out" select="$href-out"/>
              <xsl:with-param name="count" select="$count + 1"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="correct-href-levels">
              <xsl:with-param name="href-in" select="$href-in"/>
              <xsl:with-param name="href-out" select="concat($href-out, $tokenized[$count], '/')"/>
              <xsl:with-param name="count" select="$count + 1"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$count = count($tokenized)">
        <xsl:call-template name="correct-href-levels">
          <xsl:with-param name="href-in" select="$href-in"/>
          <xsl:with-param name="href-out" select="concat($href-out, $tokenized[$count])"/>
          <xsl:with-param name="count" select="$count + 1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$href-out"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
