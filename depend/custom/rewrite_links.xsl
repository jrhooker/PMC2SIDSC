<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times"
  >

  <xsl:variable name="quot">"</xsl:variable>
  <xsl:variable name="apos">'</xsl:variable>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="db:*">
    <xsl:copy>
      <xsl:for-each select="@*">
       <xsl:choose>
         <xsl:when test="name(.) = 'id'"></xsl:when>
         <xsl:otherwise><xsl:copy></xsl:copy></xsl:otherwise>
       </xsl:choose>
      </xsl:for-each>     
     <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="db:xref">  
    <xsl:variable name="target"><xsl:value-of select="@linkend"/></xsl:variable>
    <xsl:variable name="linkend"><xsl:value-of select="//*[@id = $target]/@xml:id | //*[@id = concat('section_', $target)]/@xml:id | //*[@id = concat('orderedlist_', $target)]/@xml:id  | //*[@id = concat('itemizedlist_', $target)]/@xml:id  | //*[@id = concat('listitem_', $target)]/@xml:id | //*[@id = concat('table_', $target)]/@xml:id | //*[@id = concat('informaltable_', $target)]/@xml:id | //*[@id = concat('figure_', $target)]/@xml:id | //*[@id = concat('procedure_', $target)]/@xml:id"/></xsl:variable> 
    <xsl:message>xml:id = <xsl:value-of select="$linkend"/></xsl:message>
    <xsl:copy>
      <xsl:for-each select="@*">
        <xsl:choose>
          <xsl:when test="name(.) = 'id'"></xsl:when>
          <xsl:otherwise><xsl:copy></xsl:copy></xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>    
      <xsl:choose>
        <xsl:when test="string-length($linkend[1]) = 0"><xsl:attribute name="linkend"><xsl:value-of select="@linkend"/></xsl:attribute> </xsl:when>
        <xsl:otherwise><xsl:attribute name="linkend"><xsl:value-of select="$linkend[1]"/></xsl:attribute>  </xsl:otherwise>
      </xsl:choose>      
      <xsl:apply-templates/>
    </xsl:copy>          
  </xsl:template>
 
</xsl:stylesheet>
