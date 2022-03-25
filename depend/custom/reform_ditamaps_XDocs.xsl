<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times">

  <xsl:import href="conversionFunctions.xsl"/>

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

<!--  <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA Map//EN" doctype-system="atmelMap.dtd"/> -->


  <xsl:template match="/">
    <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $FILENAME)}">
      <xsl:element name="map">
        <xsl:element name="topichead">
          <xsl:attribute name="navtitle">Address Maps</xsl:attribute>
          <xsl:apply-templates mode="addresses"/>
        </xsl:element>
        <xsl:element name="topichead">
          <xsl:attribute name="navtitle">Registers</xsl:attribute>
          <xsl:apply-templates mode="registers"/>
        </xsl:element>
      </xsl:element>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="bookmap | map" mode="addresses">
    <xsl:apply-templates mode="addresses"/>
  </xsl:template>
  
  <xsl:template match="bookmap | map" mode="registers">
    <xsl:apply-templates mode="registers"/>
  </xsl:template>

  <xsl:template match="title" mode="#all"/>

  <xsl:template match="*" mode="addresses">   
    <xsl:apply-templates mode="addresses"/>
  </xsl:template>

  <xsl:template match="*" mode="registers">   
    <xsl:apply-templates mode="registers"/>
  </xsl:template>
  

  <xsl:template match="topicref | chapter | appendix | topichead" mode="addresses">
    <xsl:if test="document(@href)//register-reference">
      <xsl:message>Found an address-map</xsl:message>
      <xsl:element name="topicref">
        <xsl:attribute name="href" select="@href"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="topicref | chapter | appendix | topichead" mode="registers">
    <xsl:if test="document(@href)//reg-def">
      <xsl:message>Found a register</xsl:message>
      <xsl:element name="topicref">
        <xsl:attribute name="href" select="@href"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
