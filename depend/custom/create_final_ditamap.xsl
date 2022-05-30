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
  
  <!-- This script takes the considated ditamap created earlier and expands it to create links to all of the newly generated topics. -->
  
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
  
 <!-- <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//OASIS//DTD DITA 1.2 Map//EN" doctype-system="map.dtd"/>-->
  
  <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA Map//EN" doctype-system="dtd/atmelMap.dtd"/>
  
  <xsl:template match="/">
    
    <!-- now process the current map itself --> 
    <xsl:message>Path to project: <xsl:value-of select="$STARTING-DIR-VAR"/></xsl:message>
    <xsl:message>Path to output: <xsl:value-of select="$OUTPUT-DIR-VAR"/></xsl:message>
    <xsl:message>FILENAME: <xsl:value-of select="$FILENAME"/></xsl:message>
    
    <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $FILENAME)}">
      <xsl:element name="map">
        <xsl:apply-templates></xsl:apply-templates>
      </xsl:element>    
    </xsl:result-document>    
  </xsl:template> 
  
  <xsl:template match="bookmap | map">   
    <xsl:apply-templates/>   
  </xsl:template>
  
  <xsl:template match="title">
    <xsl:element name="title">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>   
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="bookmeta | frontmatter"></xsl:template>
  
  <xsl:template match="topichead">
    <xsl:element name="topichead">
      <xsl:attribute name="navtitle"><xsl:value-of select="@navtitle"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="topicref[@navtitle][not(@href)] | chapter[@navtitle][not(@href)] | appendix[@navtitle][not(@href)] ">
    <xsl:element name="topichead">
      <xsl:attribute name="navtitle"><xsl:value-of select="@navtitle"/></xsl:attribute>
      <xsl:if test="@ishcondition"><xsl:attribute name="ishcondition"><xsl:value-of select="@ishcondition"/></xsl:attribute></xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="topicref | chapter | appendix" name="topicref">  
    <xsl:choose>  
      <xsl:when test="count(document(@href)//reg-def) &gt; 1">
        <xsl:message>Found a reg-def</xsl:message>
        <xsl:element name="topichead">
          <xsl:attribute name="navtitle"><xsl:value-of select="document(@href)/*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"/></xsl:attribute>
          <xsl:if test="@ishcondition"><xsl:attribute name="ishcondition"><xsl:value-of select="@ishcondition"/></xsl:attribute></xsl:if>
          <xsl:call-template name="create-topicrefs">
          <xsl:with-param name="href"><xsl:value-of select="@href"/></xsl:with-param>                  
        </xsl:call-template>
        </xsl:element>
      </xsl:when>  
      <xsl:when test="count(document(@href)//reg-def) = 1">
        <xsl:message>Found a reg-def</xsl:message>      
          <xsl:call-template name="create-topicrefs">
            <xsl:with-param name="href"><xsl:value-of select="@href"/></xsl:with-param>                        
          </xsl:call-template>
      </xsl:when>  
      <xsl:when test="count(document(@href)//address-map) &gt; 1">
        <xsl:message>Found an address-map</xsl:message>
        <xsl:element name="topichead">
          <xsl:attribute name="navtitle"><xsl:value-of select="document(@href)/*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"/></xsl:attribute>
          <xsl:if test="@ishcondition"><xsl:attribute name="ishcondition"><xsl:value-of select="@ishcondition"/></xsl:attribute></xsl:if>       
        <xsl:call-template name="create-topicrefs">
          <xsl:with-param name="href"><xsl:value-of select="@href"/></xsl:with-param>                   
        </xsl:call-template>
        </xsl:element>
      </xsl:when>     
      <xsl:when test="count(document(@href)//address-map) = 1">
        <xsl:message>Found an address-map</xsl:message>               
          <xsl:call-template name="create-topicrefs">
            <xsl:with-param name="href"><xsl:value-of select="@href"/></xsl:with-param>                   
          </xsl:call-template>
      </xsl:when>     
      <xsl:otherwise>
        <xsl:message>No reg-def  or address-map found</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template name="create-topicrefs">
    <xsl:param name="href"></xsl:param>  
    <xsl:variable name="input-directory" select="concat($STARTING-DIR-VAR, $href)"/>   
    <xsl:variable name="document" select="document($input-directory)"/>
    <xsl:variable name="path-out">
      <xsl:choose>
        <xsl:when test="contains($href, '/')">
          <xsl:if test="contains($href, '/')">
            <xsl:value-of select="translate(substring($href,1, index-of(string-to-codepoints($href), string-to-codepoints('/'))[last()] -1),'/','')"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>   
      </xsl:choose>       
    </xsl:variable>
    <xsl:variable name="topicref-id">
      <xsl:choose>
        <xsl:when test="contains($href, '/')">     
          <xsl:variable name="href-values" select="tokenize($href, '/')"/>
          <xsl:value-of select="$href-values[last()]"/>          
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$href"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:for-each select="$document//table[descendant::reg-def]">      
      <xsl:variable name="reg-file-name"  select="concat(@id, '_', $topicref-id)"/>  
      <xsl:message>REG-DEF: <xsl:value-of select="@id"/></xsl:message>      
      <xsl:element name="topicref">   
        <xsl:call-template name="filtering-attribute-management"/>    
        <xsl:if test="@ishcondition"><xsl:attribute name="ishcondition"><xsl:value-of select="@ishcondition"/></xsl:attribute></xsl:if>
        <xsl:choose>
          <xsl:when test="string-length($path-out) &gt; 0"><xsl:attribute name="href" select="concat($path-out,'/', $reg-file-name)"/></xsl:when>
          <xsl:otherwise><xsl:attribute name="href" select="concat($path-out, $reg-file-name)"/></xsl:otherwise>
        </xsl:choose>
      </xsl:element>     
    </xsl:for-each>  
    <xsl:for-each select="$document//table[descendant::address-map]">      
      <xsl:variable name="reg-file-name"  select="concat(@id, '_', $topicref-id)"/>  
      <xsl:message>ADDRESS-MAP: <xsl:value-of select="@id"/> </xsl:message>
      <xsl:element name="topicref">
        <xsl:call-template name="filtering-attribute-management"/>    
        <xsl:if test="@ishcondition"><xsl:attribute name="ishcondition"><xsl:value-of select="@ishcondition"/></xsl:attribute></xsl:if>
        <xsl:choose>
          <xsl:when test="string-length($path-out) &gt; 0"><xsl:attribute name="href" select="concat($path-out, '/', $reg-file-name)"/></xsl:when>
          <xsl:otherwise><xsl:attribute name="href" select="concat($path-out, $reg-file-name)"/></xsl:otherwise>
        </xsl:choose>       
      </xsl:element>     
    </xsl:for-each>  
  </xsl:template>
    
</xsl:stylesheet>
