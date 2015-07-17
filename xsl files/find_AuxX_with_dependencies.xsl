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
                            <xsl:when test="./@relation='AuxX'">
                                
                                <xsl:variable name="word_id" select="data(./@id)"/>
                                
                                <xsl:choose>
                                    <xsl:when test="(data(../word/@head)= $word_id)">
                                        <xsl:choose>
                                            <xsl:when test="./@insertion_id">
                                                <word id="{./@id}"
                                                    insertion_id="{./@insertion_id}"
                                                    artificial="{./@artificial}"
                                                    form="{./@form}"
                                                    lemma="{./@lemma}"
                                                    postag="{./@postag}"
                                                    relation="{./@relation}"
                                                    head="{./@head}"
                                                    cite="{./@cite}"
                                                    bad_AuxX="has dependency"></word>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <word id="{./@id}"
                                                    
                                                    form="{./@form}"
                                                    lemma="{./@lemma}"
                                                    postag="{./@postag}"
                                                    relation="{./@relation}"
                                                    head="{./@head}"
                                                    cite="{./@cite}"
                                                    bad_AuxX="has dependency"></word>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        
                                        
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="./@insertion_id">
                                                <word id="{./@id}"
                                                    insertion_id="{./@insertion_id}"
                                                    artificial="{./@artificial}"
                                                    form="{./@form}"
                                                    lemma="{./@lemma}"
                                                    postag="{./@postag}"
                                                    relation="{./@relation}"
                                                    head="{./@head}"
                                                    cite="{./@cite}"
                                                    ></word>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <word id="{./@id}"
                                                    
                                                    form="{./@form}"
                                                    lemma="{./@lemma}"
                                                    postag="{./@postag}"
                                                    relation="{./@relation}"
                                                    head="{./@head}"
                                                    cite="{./@cite}"
                                                    ></word>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                    
                                </xsl:choose>
                                
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="./@insertion_id">
                                        <word id="{./@id}"
                                            insertion_id="{./@insertion_id}"
                                            artificial="{./@artificial}"
                                            form="{./@form}"
                                            lemma="{./@lemma}"
                                            postag="{./@postag}"
                                            relation="{./@relation}"
                                            head="{./@head}"
                                            cite="{./@cite}"
                                            ></word>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <word id="{./@id}"
                                            
                                            form="{./@form}"
                                            lemma="{./@lemma}"
                                            postag="{./@postag}"
                                            relation="{./@relation}"
                                            head="{./@head}"
                                            cite="{./@cite}"
                                            ></word>
                                    </xsl:otherwise>
                                </xsl:choose>
                                
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each> 
                </sentence>
                
            </xsl:for-each>
        </treebank>
    </xsl:template>
    
</xsl:stylesheet>