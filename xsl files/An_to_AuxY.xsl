<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <treebank version="1.5" xml:lang="grc" direction="ltr" format="aldt">
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        <xsl:for-each select="./annotator">
            <xsl:copy-of select="."/>
        </xsl:for-each>
        
        <xsl:for-each select="sentence">
            <sentence id="{./@id}" document_id="{./@document_id}" subdoc="{./@subdoc}">
                <xsl:for-each select="word">
                    <xsl:choose>
                        <xsl:when test="./@lemma='ἄν1'">
                            <word id="{./@id}" form="{./@form}" lemma="{./@lemma}" 
                                postag="{./@postag}" relation="AuxY" head="{./@head}"/>
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