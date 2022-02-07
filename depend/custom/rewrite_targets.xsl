<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times">

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
      <xsl:copy-of select="@*"/>
      <xsl:if test="@id and not(@xml:id)"><xsl:attribute name="xml:id"><xsl:value-of select="@id"></xsl:value-of></xsl:attribute></xsl:if>
     <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
 
</xsl:stylesheet>
