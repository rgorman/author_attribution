<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
       <treebank><xsl:copy-of select="@*"/>
            <xsl:copy-of select="date"/>
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
                        <xsl:choose>
                            <xsl:when test="./@lemma = 'ξομμα1'">
                                <word id="{./@id}" form="{./@form}" lemma="comma1" postag="{./@postag}"
                                    relation="{./@relation}" head="{./@head}" cite="{./@cite}"/>
                            </xsl:when>
                            <xsl:when test="./@lemma = 'πυνξ1'">
                                <word id="{./@id}" form="{./@form}" lemma="punc1" postag="{./@postag}"
                                    relation="{./@relation}" head="{./@head}" cite="{./@cite}"/>
                            </xsl:when>
                            <xsl:when test="./@lemma ='περιοδ1'">
                                <word id="{./@id}" form="{./@form}" lemma="period1" postag="{./@postag}"
                                    relation="{./@relation}" head="{./@head}" cite="{./@cite}"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="./@insertion_id ">
                                        <word id="{./@id}" insertion_id="{./@insertion_id}"
                                            artificial="{./@artificial}"
                                            form="{./@form}" lemma="{./@lemma}" 
                                            postag="{./@postag}"
                                            relation="{./@relation}" head="{./@head}" cite="{./@cite}"/>
                                        
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <word id="{./@id}"                                             
                                            form="{./@form}" lemma="{./@lemma}" 
                                            postag="{./@postag}"
                                            relation="{./@relation}" head="{./@head}" cite="{./@cite}"/>
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