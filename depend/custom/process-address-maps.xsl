<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:date="http://exslt.org/dates-and-times">

    <xsl:template name="generate-path">
        <xsl:param name="href-values"/>
        <xsl:param name="count" select="1"/>
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="$count = count($href-values)">
                <xsl:value-of select="$path"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="generate-path">
                    <xsl:with-param name="href-values" select="$href-values"/>
                    <xsl:with-param name="count" select="$count + 1"/>
                    <xsl:with-param name="path" select="concat($path, $href-values[$count], '/')"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="generate-target">
        <xsl:param name="href"/>
        <xsl:variable name="path-to-file">
            <xsl:variable name="temp_1" select="substring-before($href, '.xml')"/>
            <xsl:choose>
                <xsl:when test="contains($temp_1, '/')">
                    <xsl:variable name="href-values" select="tokenize($temp_1, '/')"/>
                    <xsl:value-of select="$href-values[last()]"/>
                    <xsl:if test="count($href-values) &gt; 1">
                        <xsl:call-template name="generate-path">
                            <xsl:with-param name="href-values" select="$href-values"/>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="filename">
            <xsl:variable name="temp_1" select="substring-before($href, '.xml')"/>
            <xsl:choose>
                <xsl:when test="contains($temp_1, '/')">
                    <xsl:variable name="href-values" select="tokenize($temp_1, '/')"/>
                    <xsl:value-of select="$href-values[last()]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$temp_1"/>
                </xsl:otherwise>
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
        <xsl:value-of select="concat($topicref-id, '_', $filename, '.xml')"/>
    </xsl:template>

    <xsl:template name="generate-target-without-id">
        <xsl:param name="href"/>                
        <xsl:variable name="filename">
            <xsl:value-of select="document($href)//table[descendant::address-map]/@id"/>
        </xsl:variable>
       <xsl:value-of select="concat($filename, '_', $href)"/>
    </xsl:template>

    <xsl:template name="generate-link-text">
        <xsl:param name="href-prefix"/>
        <xsl:message>generate-link-text: <xsl:value-of select="$href-prefix"/></xsl:message>
        <xsl:variable name="file">
            <xsl:choose>
                <xsl:when test="contains(@href, '#')">
                    <xsl:value-of select="concat($STARTING-DIR-VAR, substring-before(@href, '#'))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($STARTING-DIR-VAR, @href)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="target">
            <xsl:choose>
                <xsl:when test="contains(@href, '/')">
                    <xsl:variable name="href-values" select="tokenize(@href, '/')"/>
                    <xsl:value-of select="$href-values[last()]"/>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length($target) &gt; 0">
                <xsl:message>Href: <xsl:value-of select="@href"/></xsl:message>
                <xsl:message>Href prefix: <xsl:value-of select="$href-prefix"/></xsl:message>
                <xsl:value-of select="document($file)//*[@id = $target]/title/reg-name-main"/><xsl:if test="string-length(document($file)//*[@id = $target]/title/reg-desc) &gt; 2"> - <xsl:value-of select="document($file)//*[@id = $target]/title/reg-desc"/></xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="document($file)//title[1]/reg-name-main"/><xsl:if test="string-length(document($file)//title[1]/reg-desc) &gt; 2"> - <xsl:value-of select="document($file)//title[1]/reg-desc"/></xsl:if>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>
</xsl:stylesheet>
