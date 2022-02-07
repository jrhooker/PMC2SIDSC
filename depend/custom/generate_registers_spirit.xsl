<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:db="http://docbook.org/ns/docbook" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:svg="http://www.w3.org/2000/svg" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:dbx="http://sourceforge.net/projects/docbook/defguide/schema/extra-markup"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:spirit="http://www.spiritconsortium.org/XMLSchema/SPIRIT/1685-2009"
    xmlns:snps="http://www.synopsys.com/SPIRIT-snps"
    exclude-result-prefixes="xsl db xlink svg mml dbx xi html">

    <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
        doctype-public="-//OASIS//DTD DITA 1.2 Topic//EN" doctype-system="topic.dtd"/>

    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="registers" select="//table[descendant::reg-def]"/>
        <xsl:for-each select="$registers">
        <xsl:variable name="filename" select="@id"/>
        <xsl:result-document href="$filename">
            <topic>
                <title><xsl:value-of select="title"/></title>
                <body>
                    <p>There should be a register here.</p>
                </body>
            </topic>
        </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="table[descendant::reg-def]">
        
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
                    <xsl:element name="registerSize">
                    </xsl:element>
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

       
</xsl:stylesheet>
