<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <treebank version="1.5" xml:lang="grc" direction="ltr" format="aldt">
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="sentence">
                
                
                <xsl:variable name="doc" select="./@document_id"/>
                <xsl:variable name="subdoc" select="./@subdoc"></xsl:variable>
                <sentence id="{./@id}" document_id="{$doc}" subdoc="{$subdoc}" span="{./@span}">
                    <xsl:for-each select="word">
                        
                        <xsl:choose>
                            <xsl:when test="data(./@relation='AuxX')">
                                
                                <xsl:variable name="word_id" select="data(./@id)"/>
                                <xsl:variable name="form" select="./@form"/>
                                <xsl:variable name="lemma" select="./@lemma"/>
                                <xsl:variable name="postag" select="./@postag"/>
                                <xsl:variable name="relation" select="./@relation"/>
                                <xsl:variable name="head" select="./@head"/>
                                <xsl:choose>
                                    <xsl:when test="(data(../word/@head)= $word_id)">
                                        
                                        <word_is_BAD_RELATION namely="bad AuxX" id="{$word_id}" form="{$form}" lemma="{$lemma}" postag="{$postag}" relation="{$relation}" head="{./@head}"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <word id="{$word_id}" form="{$form}" lemma="{$lemma}" postag="{$postag}" relation="{$relation}" head="0"/>
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