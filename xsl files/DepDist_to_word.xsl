<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <treebank>
        <xsl:copy-of select="@*"/>
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="sentence">
                <sentence id="{./@id}" document_id="{./@document_id}" subdoc="{./@subdoc}"
                    span="{./@span}">
                    
                    <xsl:for-each select="word">
                        <word><xsl:copy-of select="@*"/><xsl:attribute name="DepDist">
                            <xsl:choose>
                                <xsl:when test="./@head != '0'">
                                    <xsl:value-of select="abs(./@head - ./@id)"/>
                                </xsl:when>
                            </xsl:choose>
                            
                        </xsl:attribute></word>
                    </xsl:for-each>
                    
                </sentence>
            </xsl:for-each>
        </treebank>   
    </xsl:template>
</xsl:stylesheet>