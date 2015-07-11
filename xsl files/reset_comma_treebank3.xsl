<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
                
                
                
                <sentence>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="word">
                        
                        <xsl:choose>
                            <xsl:when test="data(./@relation='AuxX')">
                                
                                <xsl:variable name="word_id" select="data(./@id)"/>
                                
                                <xsl:choose>
                                    <xsl:when test="(data(../word/@head)= $word_id)">
                                        
                                        <word_is_BAD_RELATION namely="bad AuxX" id="{./@id}" form="{./@form}" 
                                            lemma="{./@lemma}" postag="{./@postag}" relation="{./@relation}" head="{./@head}"
                                        cite="{./@id}"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:copy-of select="."/>
                                    </xsl:otherwise>
                                    
                                </xsl:choose>
                                
                            </xsl:when>
                            <xsl:otherwise>
                                
                                <xsl:copy-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each> 
                </sentence>
                
            </xsl:for-each>
        </treebank>
    </xsl:template>
    
</xsl:stylesheet>