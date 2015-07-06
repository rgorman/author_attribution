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
            <xsl:variable name="reference">
                <xsl:value-of select="//comment"/>
            </xsl:variable>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="sentence">
                <sentence id="{./@id}" document_id="{./@document_id}" subdoc="{./@subdoc}">
                    <xsl:for-each select="word">
                        <xsl:copy-of select="."/>
                    </xsl:for-each>        
                </sentence>
            </xsl:for-each>
        </treebank>
    </xsl:template>
</xsl:stylesheet>