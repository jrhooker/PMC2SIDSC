<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str  = "http://exslt.org/strings" 
    xmlns:math = "http://exslt.org/math" 
    version="1.0"
    exclude-result-prefixes="str math">
    
    <xsl:template name="calc-reset-value">
        <xsl:param name="current-value"></xsl:param>
        <xsl:param name="field-count" select="1"/>     
             
        <xsl:choose>
            <xsl:when test="tgroup/reg-def/field[$field-count]">           
             
                               
                <xsl:variable name="width">
                    <xsl:choose>
                        <xsl:when test="tgroup/reg-def/field[$field-count]/field-bits/double">
                            <xsl:value-of select="number(tgroup/reg-def/field[$field-count]/field-bits/double/msb) - number(tgroup/reg-def/field[$field-count]/field-bits/double/lsb) + 1"/>
                        </xsl:when>
                        <xsl:otherwise><xsl:value-of select="number(1)"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
           
                <xsl:variable name="default-value">
                    <xsl:choose>
                        <xsl:when test="contains(tgroup/reg-def/field[$field-count]/field-default, '0x')">
                            <xsl:call-template name="math:base-convert">
                                <xsl:with-param name="from-base" select="16"/>
                                <xsl:with-param name="to-base" select="2"/>
                                <xsl:with-param name="value" select="translate(substring-after(tgroup/reg-def/field[$field-count]/field-default, '0x'), '_ ', '')"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="contains(tgroup/reg-def/field[$field-count]/field-default, 'Ox')">
                            <xsl:call-template name="math:base-convert">
                                <xsl:with-param name="from-base" select="16"/>
                                <xsl:with-param name="to-base" select="2"/>
                                <xsl:with-param name="value" select="substring-after(tgroup/reg-def/field[$field-count]/field-default, 'Ox')"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                    </xsl:choose>                   
                </xsl:variable>
              
                <xsl:variable name="field-value">
                    <xsl:choose>
                        <xsl:when test="$width &lt; string-length($default-value)">
                            <xsl:message>Value Out Of Range</xsl:message>
                            [ValueOutOfRange<xsl:value-of select="string-length($default-value)"/>]
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="padding-values">
                                <xsl:with-param name="field-width" select="$width"/>
                                <xsl:with-param name="string-width" select="string-length($default-value)"/>
                                <xsl:with-param name="string" select="$default-value"></xsl:with-param>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                   
                </xsl:variable>     
              
                
                <xsl:call-template name="calc-reset-value">
                    <xsl:with-param name="field-count" select="$field-count + 1"/>
                    <xsl:with-param name="current-value" select="concat($field-value, $current-value)"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="hex-value">
                    <xsl:choose>
                        <xsl:when test="contains($current-value, '1')">
                            <xsl:call-template name="math:base-convert">
                                <xsl:with-param name="from-base" select="2"/>
                                <xsl:with-param name="to-base" select="16"/>
                                <xsl:with-param name="value"><xsl:value-of select="$current-value"/></xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                    </xsl:choose>                    
                </xsl:variable>
               <xsl:value-of select="concat('0x', $hex-value)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- This template just exists so that the default value of the field takes up the same
    number of binary spaces as the field width -->
    <xsl:template name="padding-values">
        <xsl:param name="field-width"></xsl:param>
        <xsl:param name="string-width"></xsl:param>
        <xsl:param name="string"></xsl:param>
        <xsl:choose>
            <xsl:when test="$field-width &lt;= $string-width">
                <xsl:value-of select="$string"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="padding-values">
                    <xsl:with-param name="field-width" select="$field-width"/>
                    <xsl:with-param name="string-width" select="$string-width + 1"/>
                    <xsl:with-param name="string" select="concat('0', $string)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
</xsl:stylesheet>