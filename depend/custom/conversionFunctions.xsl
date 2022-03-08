<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str  = "http://exslt.org/strings" 
    xmlns:math = "http://exslt.org/math" 
    version="1.0"
    exclude-result-prefixes="str math">
    
    <xsl:variable name="str:digits"     select="'0123456789'"
    />
    <xsl:variable name="str:alphabet"
        select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="str:ALPHABET"
        select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
    <xsl:variable name="math:base-list" select="concat($str:digits,
        $str:alphabet, $str:ALPHABET)"/>
    
    <xsl:template name="math:base-convert">
        <xsl:param name="from-base"/>
        <xsl:param name="to-base"/>
        <xsl:param name="value"/>
        <xsl:call-template name="math:decimal-to-base">
            <xsl:with-param name="base" select="$to-base"/>
            <xsl:with-param name="value">
                <xsl:call-template name="math:base-to-decimal">
                    <xsl:with-param name="base" select="$from-base"/>
                    <xsl:with-param name="value">
                        <xsl:choose>
                            <xsl:when test="$from-base &gt; 36">
                                <xsl:value-of select="$value"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="translate($value, $str:ALPHABET,
                                    $str:alphabet)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="math:base-to-decimal">
        <xsl:param name="base"/>
        <xsl:param name="value"/>
        <xsl:variable name="base-recurse">
            <xsl:choose>
                <xsl:when test="string($value)">
                    <xsl:call-template name="math:base-to-decimal">
                        <xsl:with-param name="base" select="$base"/>
                        <xsl:with-param name="value" select="substring($value, 1,
                            string-length($value) - 1)"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="string-length(substring-before($math:base-list,
            substring($value, string-length($value)))) + $base * $base-recurse"/>
    </xsl:template>
    
    <xsl:template name="math:decimal-to-base">
        <xsl:param name="base"/>
        <xsl:param name="value" select="0"/>
        <xsl:if test="number($value)">
            <xsl:call-template name="math:decimal-to-base">
                <xsl:with-param name="base" select="$base"/>
                <xsl:with-param name="value" select="floor($value div $base)"/>
            </xsl:call-template>
            <xsl:value-of select="substring($math:base-list, ($value mod $base) +
                1, 1)"/>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>