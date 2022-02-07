<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:date="http://exslt.org/dates-and-times">
    
    <xsl:param name="STARTING-DIR"></xsl:param>
    
    <xsl:variable name="STARTING-DIR-VAR">
        <xsl:choose>
            <xsl:when test="contains($STARTING-DIR, 'c:')">
                <xsl:value-of select="translate(substring-after($STARTING-DIR, 'c:'), '\', '/')"/>
            </xsl:when>
            <xsl:when test="contains($STARTING-DIR, 'C:')">
                <xsl:value-of select="translate(substring-after($STARTING-DIR, 'C:'), '\', '/')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="translate($STARTING-DIR, '\', '/')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>
    
    <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
        doctype-public="-//OASIS//DTD DITA 1.2 Topic//EN" doctype-system="topic.dtd"/>
    
    <xsl:template match="/">
        <xsl:message><xsl:value-of select="$STARTING-DIR-VAR"/></xsl:message>
        <xsl:variable name="path"><xsl:value-of select="translate($STARTING-DIR-VAR, '\', '/')"/></xsl:variable>
        
        <xsl:for-each select="collection(concat($path, 'registers/', '?select=*.xml'))">
            <xsl:variable name="filename" select="tokenize(document-uri(.), '/')[last()]"/> 
            <xsl:variable name="document" select="document(concat($path, 'registers/', $filename))" />     
            <xsl:for-each select="$document//table[descendant::reg-def]">
                <xsl:variable name="pathname"><xsl:value-of select="concat($path, 'registers/', @id, '.xml')"/></xsl:variable>
                <xsl:message>Current File: <xsl:value-of select="concat($path, 'registers/', $filename)"/></xsl:message>     
                <xsl:message>Document created <xsl:value-of select="$pathname"/></xsl:message>
                <xsl:result-document href="{$pathname}">
                    <xsl:call-template name="create-register"></xsl:call-template>
                </xsl:result-document>         
            </xsl:for-each> 
            
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="create-register">
        <xsl:element name="register">
            <xsl:copy-of select="@*"/>
            <xsl:element name="registerName"><xsl:value-of select="title/reg-name-main"/></xsl:element>
            <xsl:element name="registerNameMore">
                <xsl:element name="registerNameFull"><xsl:value-of select="title/reg-name-main"/></xsl:element>
                <xsl:element name="registerNameDescription"><xsl:value-of select="title/reg-desc"/></xsl:element>
            </xsl:element>
            
            <xsl:element name="registerBody">
                <xsl:element name="registerNameDescription"><xsl:value-of select="title/reg-desc"/></xsl:element>
                <xsl:element name="registerProperties">
                    <xsl:element name="addressOffset"></xsl:element>
                    <xsl:element name="registerSize"><xsl:call-template name="find-reg-size"/></xsl:element>
                    <xsl:element name="registerAccess"></xsl:element>
                    <xsl:element name="registerResetValue"></xsl:element>
                    <xsl:element name="bitOrder"></xsl:element>
                    <xsl:element name="resetTrig"></xsl:element>
                    <xsl:element name="dimension">
                        <xsl:element name="dimensionValue"></xsl:element>
                        <xsl:element name="dimensionIncrement"></xsl:element>
                        <xsl:element name="unitQualifier"></xsl:element>
                        <xsl:element name="namePattern"></xsl:element>                        
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            
            
            <xsl:for-each select="field">
                <xsl:element name="bitfield">
                    <xsl:element name="bitFieldDescription"></xsl:element>
                    <xsl:element name="bitFieldBody">
                        <xsl:element name="bitFieldDescriptions"></xsl:element>
                        <xsl:element name="bitFieldProperties">
                            <xsl:element name="bitWidth"></xsl:element>
                            <xsl:element name="bitOffset"></xsl:element>
                            <xsl:element name="bitFieldAccess"></xsl:element>
                            <xsl:element name="bitFieldReset">
                                <xsl:element name="bitFieldResetValue"></xsl:element>
                            </xsl:element>
                            <xsl:element name="bitFieldValues">
                                <xsl:element name="bitFieldValue"></xsl:element>
                                <xsl:element name="bitFieldValueName"></xsl:element>
                                <xsl:element name="bitFieldValueDescription"></xsl:element>
                            </xsl:element>
                            <xsl:element name="bitFieldValueGroup">
                                <xsl:element name="bitFieldValue"></xsl:element>
                                <xsl:element name="bitFieldValueName"></xsl:element>
                                <xsl:element name="bitFieldValueDescription"></xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template name="find-reg-size">
        <xsl:variable name="bit-values" select="reg-def//msb | reg-def//single"/>
        <xsl:choose>            
            <xsl:when test="contains($bit-values, '255')">256</xsl:when>
            <xsl:when test="contains($bit-values, '127')">128</xsl:when>
            <xsl:when test="contains($bit-values, '63')">64</xsl:when>
            <xsl:when test="contains($bit-values, '31')">32</xsl:when>
            <xsl:when test="contains($bit-values, '15')">16</xsl:when>
            <xsl:when test="contains($bit-values, '7')">8</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
