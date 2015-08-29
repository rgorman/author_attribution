<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <wordOrderDocument>
            <xsl:copy-of select="@*"/>
            
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            
            <xsl:for-each select="sentence">
                <sentence>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="word">
                        <xsl:choose>
                            <xsl:when test="./@relation != 'AuxX'">
                                <xsl:choose>
                                    <xsl:when test="./@DepDist > 0">
                                        <word><xsl:copy-of select="@*"/>
                                            <xsl:value-of select="./@relation"/>-<xsl:value-of select="substring(./@postag, 1, 1)"/>-<xsl:value-of select="./@DepDist"/>
                                        </word>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <word><xsl:copy-of select="@*"/>
                                            <xsl:value-of select="./@relation"/>-<xsl:value-of select="substring(./@postag, 1, 1)"/>
                                        </word> 
                                    </xsl:otherwise>
                                </xsl:choose>
                                
                                
                            </xsl:when>
                        </xsl:choose>
                        
                    </xsl:for-each>
                </sentence>
            </xsl:for-each>
        </wordOrderDocument>
    </xsl:template>
    
</xsl:stylesheet>