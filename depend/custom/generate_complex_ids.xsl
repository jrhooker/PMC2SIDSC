<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
      <!-- This template is divided into two stages so that we can treat camelcase or full caps variables differently than we treat underscore or special character cases -->
    
  <!--  <xsl:template name="generate-IDs">
        <xsl:param name="entry" select="''"/>
        <xsl:message>Entry1: <xsl:value-of select="$entry"/></xsl:message>
        <xsl:choose>
            <xsl:when test="$id-being-generated = ''">
                <xsl:value-of select="$entry"/>
            </xsl:when>
            <xsl:when test="string-length($entry) &gt; 1">
                <xsl:variable name="char" select="substring($entry, 1, 1)"/>
                <xsl:value-of select="$char"/>               
              
                <xsl:call-template name="generate-IDs">
                    <xsl:with-param name="entry" select="substring($entry, 2)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Entry2: <xsl:value-of select="$entry"/></xsl:message>
                <xsl:value-of select="$entry"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template> -->
    
    <xsl:template name="generate-IDs">
        <xsl:param name="entry" select="''"/>
        <xsl:variable name="id-being-generated.chars">,/&amp;;:0123456789~`@#$%^*-()+={}[]&gt;&lt;! </xsl:variable>
        <xsl:value-of select="translate($entry, $id-being-generated.chars, '_')"/>
    </xsl:template>
    
    <xsl:param name="id-being-generated.chars">,/&amp;;:0123456789~`@#$%^*-()+={}[]&gt;&lt;! </xsl:param>
    <xsl:param name="id-being-generated">_</xsl:param>
    
    <xsl:template name="generate-IDsCAPS">
        <xsl:param name="entry" select="''"/>
        <xsl:choose>
            <xsl:when test="$id-being-generatedCAPS = ''">
                <xsl:value-of select="$entry"/>
            </xsl:when>
            <xsl:when test="string-length($entry) &gt; 1">
                <xsl:variable name="char" select="substring($entry, 1, 1)"/>
                <xsl:value-of select="$char"/>
                <xsl:if test="contains($id-being-generated.charsCAPS, $char)">
                    <!-- Do not hyphen in-between // -->
                    <xsl:if test="not($char = '/' and substring($entry,2,1) = '/')">
                        <xsl:copy-of select="$id-being-generatedCAPS"/>
                    </xsl:if>
                </xsl:if>
                <!-- recurse to the next character -->
                <xsl:call-template name="generate-IDsCAPS">
                    <xsl:with-param name="entry" select="substring($entry, 2)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$entry"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:param name="id-being-generated.charsCAPS">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
    <xsl:param name="id-being-generatedCAPS">_​</xsl:param>
       
    <xsl:template match="*[contains(@class, ' topic/entry ')]//text() | *[contains(@class, ' topic/stentry ')]//text()">
        <xsl:variable name="stage1">
            <xsl:call-template name="generate-IDs">
                <xsl:with-param name="entry" select="."/>
            </xsl:call-template>
        </xsl:variable>
      
        <xsl:call-template name="generate-IDsCAPS">
            <xsl:with-param name="entry" select="$stage1"/>
        </xsl:call-template>
      
    </xsl:template>
</xsl:stylesheet>