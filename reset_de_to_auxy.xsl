<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <treebank version="1.5" xml:lang="grc" direction="ltr" format="aldt">
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="sentence">
                <xsl:choose>
                      <xsl:when test="./word[@relation = 'PRED_CO']">
                        
                        <xsl:variable name="predicates">
                           <xsl:value-of select="count(./word[@relation = 'PRED_CO'])"/>
                        </xsl:variable>
                        <xsl:variable name="id_of_pred">
                            <xsl:value-of select="./word[@relation = 'PRED_CO']/@id"/>
                        </xsl:variable>
                        <xsl:choose>                            
                            <xsl:when test="$predicates = 1">
                                <sentence id="{./@id}" >
                                <xsl:for-each select="word">
                                   <xsl:choose>
                                       <xsl:when test="./@lemma = 'δέ1' and ./@head = '0'">
                                           <word id="{./@id}" form="{./@form}" lemma="{./@lemma}" 
                                               postag="{./@postag}" relation="AuxY"
                                           head="{$id_of_pred}" cite="{./@cite}"/>
                                       </xsl:when>
                                       <xsl:when test="./@relation = 'PRED_CO'">
                                           <word id="{./@id}" form="{./@form}" lemma="{./@lemma}" 
                                               postag="{./@postag}" relation="PRED"
                                               head="0" cite="{./@cite}"/>
                                       </xsl:when>
                                       <xsl:otherwise>
                                           <xsl:copy-of select="."/>
                                       </xsl:otherwise>
                                   </xsl:choose>
                                </xsl:for-each>
                                </sentence>
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
        </treebank>
    </xsl:template>
</xsl:stylesheet>