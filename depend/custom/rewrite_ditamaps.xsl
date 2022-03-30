<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:date="http://exslt.org/dates-and-times">

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

    <!-- <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA Map//EN" doctype-system="dtd/atmelMap.dtd"/> -->

    <xsl:template match="/">

        <!-- now process the current map itself -->
        <xsl:message>Path to project: <xsl:value-of select="$STARTING-DIR-VAR"/></xsl:message>
        <xsl:message>Path to output: <xsl:value-of select="$OUTPUT-DIR-VAR"/></xsl:message>
        <xsl:message>FILENAME: <xsl:value-of select="$FILENAME"/></xsl:message>

        <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $FILENAME)}">
            <xsl:element name="map">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="bookmap | map">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="title">
        <xsl:element name="title">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="bookmeta | frontmatter"/>

    <xsl:template match="topicref | chapter | appendix | topichead">
        <!-- this is the first level of the map, so there's no need for the href-prefix parameter -->
        <xsl:message>First pass through the topicref template</xsl:message>
        <xsl:choose>
            <xsl:when test="contains(@href, '.ditamap')">
                <xsl:message>Found a ditamap</xsl:message>
                <xsl:variable name="href-prefix">
                    <xsl:call-template name="create-href-prefix">
                        <xsl:with-param name="href-in" select="@href"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:call-template name="process-ditamap">
                    <xsl:with-param name="href">
                        <xsl:value-of select="@href"/>
                    </xsl:with-param>
                    <xsl:with-param name="href-prefix" select="$href-prefix"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="@href">
                <xsl:element name="topicref">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@href"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template name="process-ditamap">
        <xsl:param name="href"/>
        <xsl:param name="href-prefix"/>
        <xsl:message>Process ditamap template: <xsl:value-of select="$href-prefix"/></xsl:message>
        <xsl:for-each select="document(@href)//*[contains(@class, ' map/topicref ')]">
            <xsl:choose>
                <xsl:when test="contains(@href, '.ditamap')">
                    <xsl:message>Found a ditamap3</xsl:message>
                    <xsl:call-template name="process-ditamap">
                        <xsl:with-param name="href">
                            <xsl:value-of select="@href"/>
                        </xsl:with-param>
                        <xsl:with-param name="href-prefix">
                            <xsl:value-of select="$href-prefix"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="@href">
                    <xsl:element name="topicref">
                        <xsl:variable name="final-href">
                            <xsl:call-template name="correct-href-levels">
                                <xsl:with-param name="href-in">
                                    <xsl:value-of select="concat($href-prefix, @href)"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:variable>
                       <xsl:attribute name="href">
                            <xsl:value-of select="$final-href"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="create-href-prefix">
        <xsl:param name="href-in"/>
        <xsl:param name="href-out"/>
        <xsl:param name="count" select="1"/>

        <xsl:message>Creating an href-prefix: <xsl:value-of select="$href-in"/></xsl:message>

        <xsl:variable name="translate" select="translate($href-in, '\', '/')"/>
        <xsl:variable name="tokenized" select="tokenize($translate, '/')"/>
        <xsl:choose>
            <xsl:when test="$count &lt; count($tokenized)">
                <xsl:message>token1: <xsl:value-of select="$tokenized[$count]"/></xsl:message>
                <xsl:call-template name="create-href-prefix">
                    <xsl:with-param name="href-out">
                        <xsl:value-of
                            select="concat(normalize-space($href-out), normalize-space($tokenized[$count]), '/')"
                        />
                    </xsl:with-param>
                    <xsl:with-param name="href-in" select="$href-in"/>
                    <xsl:with-param name="count" select="$count + 1"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$href-out"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="correct-href-levels">
        <xsl:param name="href-in"/>
        <xsl:param name="href-out"/>
        <xsl:param name="count" select="1"/>

        <xsl:message>Correcting href levels: <xsl:value-of select="$href-in"/></xsl:message>

        <xsl:variable name="translate" select="translate($href-in, '\', '/')"/>
        <xsl:variable name="tokenized" select="tokenize($translate, '/')"/>

        <xsl:choose>
            <xsl:when test="$count &lt; count($tokenized)">
                <xsl:choose>
                    <xsl:when
                        test="contains($tokenized[$count + 1], '..')">
                        <xsl:call-template name="correct-href-levels">
                            <xsl:with-param name="href-in" select="$href-in"/>
                            <xsl:with-param name="href-out" select="$href-out"/>
                            <xsl:with-param name="count" select="$count + 1"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="contains($tokenized[$count], '..')">
                        <xsl:call-template name="correct-href-levels">
                            <xsl:with-param name="href-in" select="$href-in"/>
                            <xsl:with-param name="href-out" select="$href-out"/>
                            <xsl:with-param name="count" select="$count + 1"/>
                        </xsl:call-template>
                    </xsl:when>                    
                    <xsl:otherwise>
                        <xsl:call-template name="correct-href-levels">
                            <xsl:with-param name="href-in" select="$href-in"/>
                            <xsl:with-param name="href-out" select="concat($href-out, $tokenized[$count], '/')"/>
                            <xsl:with-param name="count" select="$count + 1"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$count = count($tokenized)">
                <xsl:call-template name="correct-href-levels">
                    <xsl:with-param name="href-in" select="$href-in"/>
                    <xsl:with-param name="href-out"
                        select="concat($href-out, $tokenized[$count])"/>
                    <xsl:with-param name="count" select="$count + 1"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$href-out"/>
            </xsl:otherwise>
        </xsl:choose>
   </xsl:template>


</xsl:stylesheet>
