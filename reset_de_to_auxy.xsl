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
                <xsl:variable name="pred-id" select="word[@relation ='PRED_CO']/@id"></xsl:variable>
                <sentence id="{./@id}" document_id="{./@document_id}" subdoc="{./@subdoc}"
                    span="{./@span}">
                    <xsl:for-each select="word">
                        <xsl:choose>
                            <xsl:when test="data(./@lemma) = 'δέ1' and data(./@head) = '0'">
                                <word id="{./@id}" form="{./@form}" 
                                    lemma="{./@lemma}" postag="{./@postag}" 
                                    relation="AuxY" head="{$pred-id}" cite="{./@cite}"/>
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