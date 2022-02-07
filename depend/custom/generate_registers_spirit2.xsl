<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:db="http://docbook.org/ns/docbook" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:svg="http://www.w3.org/2000/svg" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:dbx="http://sourceforge.net/projects/docbook/defguide/schema/extra-markup"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:spirit="http://www.spiritconsortium.org/XMLSchema/SPIRIT/1685-2009"
    xmlns:snps="http://www.synopsys.com/SPIRIT-snps"
    exclude-result-prefixes="xsl db xlink svg mml dbx xi html">

    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:element name="topic">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Remove processing instructions -->

    <xsl:template match="processing-instruction()"/>

    <xsl:template match="table[descendant::reg-def]">
        <xsl:element name="register">
            <xsl:element name="registerName">
                <xsl:value-of select="title/reg-name-main"/>
            </xsl:element>
            <xsl:element name="registerNameMore">
                <xsl:value-of select="title/reg-desc"/>
            </xsl:element>
            <xsl:element name="registerBriefDescription">
                <xsl:value-of select="title/reg-desc"/>
            </xsl:element>
            <xsl:element name="registerBody">
                <xsl:element name="registerDescription">
                    <xsl:value-of select="title/reg-desc"/>
                </xsl:element>
                <xsl:element name="registerProperties">
                    <xsl:element name="addressOffset"/>
                    <xsl:element name="registerSize"><xsl:call-template name="register-size"/></xsl:element>
                    <xsl:element name="registerAccess"/>
                    <xsl:element name="registerResetValue"/>
                    <xsl:element name="bitOrder"/>
                    <xsl:element name="resetTrig"/>
                    <xsl:element name="dimension">
                        <xsl:element name="dimensionValue"/>
                        <xsl:element name="dimensionIncrement"/>
                        <xsl:element name="unitQualifier"/>
                        <xsl:element name="namePattern"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:for-each select="tgroup/reg-def/field">
                <xsl:element name="bitField">
                    <xsl:element name="bitFieldName">
                        <xsl:value-of select="field-name"/>
                    </xsl:element>
                    <xsl:element name="bitFieldBriefDescription"/>
                    <xsl:element name="bitFieldBody">
                        <xsl:element name="bitFieldDescription">
                            <xsl:apply-templates select="field-desc"/>
                        </xsl:element>
                        <xsl:element name="bitFieldProperties">
                            <xsl:element name="bitFieldPropset">
                                <xsl:element name="bitWidth">
                                    <xsl:call-template name="calculate-bit-width"/>
                                </xsl:element>
                                <xsl:element name="bitOffset">
                                    <xsl:call-template name="calculate-bit-offset"/>
                                </xsl:element>
                                <xsl:element name="bitFieldAccess">
                                    <xsl:value-of select="field-type"/>
                                </xsl:element>
                                <xsl:element name="bitFieldReset">
                                    <xsl:element name="bitFieldResetValue">
                                        <xsl:value-of select="field-default"/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="bitFieldValues">
                            <xsl:element name="bitFieldValueGroup">
                                <xsl:element name="bitFieldValue"/>
                                <xsl:element name="bitFieldValueName"/>
                                <xsl:element name="bitFieldValueDescription"/>
                            </xsl:element>
                            <xsl:element name="bitFieldValueGroup">
                                <xsl:element name="bitFieldValue"/>
                                <xsl:element name="bitFieldValueName"/>
                                <xsl:element name="bitFieldValueDescription"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="register-size">       
        <xsl:variable name="bits" select="tgroup/reg-def/field/field-bits/double/msb | tgroup/reg-def/field/field-bits/double/lsb | tgroup/reg-def/field/field-bits/single" />
        <xsl:choose>
           <xsl:when test="number($bits[1]) &gt; 250">254</xsl:when>
            <xsl:when test="number($bits[1]) &gt; 120">128</xsl:when>
            <xsl:when test="number($bits[1]) &gt; 60">64</xsl:when>
            <xsl:when test="number($bits[1]) &gt; 30">32</xsl:when>
            <xsl:when test="number($bits[1]) &gt; 14">16</xsl:when>
       </xsl:choose> 
    </xsl:template>
    
    <xsl:template name="calculate-bit-width">
        <xsl:choose>
            <xsl:when test="field-bits/single">1</xsl:when>
            <xsl:otherwise><xsl:value-of select="number(field-bits/double/msb) - number(field-bits/double/lsb) + 1"/></xsl:otherwise>
        </xsl:choose>       
    </xsl:template>

    <xsl:template name="calculate-bit-offset">
        <xsl:choose>
            <xsl:when test="field-bits/single"><xsl:value-of select="field-bits/single"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="field-bits/double/lsb"/></xsl:otherwise>
        </xsl:choose>       
    </xsl:template>

    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
