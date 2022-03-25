<?xml version='1.0'?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	  xmlns:c="urn:oasis:names:tc:entity:xmlns:xml:catalog"
>

<!-- example:
  <public publicId="-//IBM//DTD DITA Concept//EN" uri="dita-ibm/1.3.2/concept.dtd"/>

PUBLIC "-//IBM//DTD DITA Concept//EN" "dita-ibm/1.3.2/concept.dtd"

-->

<xsl:output
	method="text"
	indent="yes"
	encoding="ISO-8859-1"
	/>

<xsl:template match="/">
	<xsl:text>-- Catalog file generated by catalog-to-text.xsl --</xsl:text>
	<xsl:apply-templates />
</xsl:template>

<!-- convert comments -->
<xsl:template match="comment()">
	<xsl:value-of select="concat('--', . ,'--')" />
</xsl:template>

<!-- remove indenting -->
<xsl:template match="text()[normalize-space(.) = '']">
	<xsl:value-of select="translate(., ' &#9;', '')" />
</xsl:template>

<xsl:template match="c:public">
	<xsl:variable name="quot"><xsl:text>"</xsl:text></xsl:variable>
	
	<xsl:value-of select="concat('PUBLIC ', $quot, @publicId, $quot, ' ', $quot, @uri, $quot)" />
	
</xsl:template>

<xsl:template match="c:nextCatalog">
<!--xsl:value-of select="concat('&#xA;- - Process &lt;nextCatalog&gt; ', @catalog, ' - -')" /-->

	<!--xsl:apply-templates select="document(@catalog)/*/node()" /-->
	<xsl:text>CATALOG "</xsl:text>
	<xsl:value-of select="substring-before(@catalog, '.xml')" />
	<xsl:text>"</xsl:text>
</xsl:template>

</xsl:stylesheet>