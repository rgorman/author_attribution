<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <sWord_document>
            <xsl:copy-of select="@*"/>
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
                        <sWord><xsl:copy-of select="@*"/>
                            
                            <xsl:variable name="head_1" select="./@head"/>
                            <xsl:variable name="head_2" select="parent::sentence/word[@id = $head_1]/@head"/>
                            <xsl:variable name="head_3" select="parent::sentence/word[@id = $head_2]/@head"/>
                            <xsl:variable name="head_4" select="parent::sentence/word[@id = $head_3]/@head"/>
                            <xsl:variable name="head_5" select="parent::sentence/word[@id = $head_4]/@head"/>
                            <xsl:variable name="head_6" select="parent::sentence/word[@id = $head_5]/@head"/>
                            <xsl:variable name="head_7" select="parent::sentence/word[@id = $head_6]/@head"/>
                            <xsl:variable name="head_8" select="parent::sentence/word[@id = $head_7]/@head"/>
                            <xsl:variable name="head_9" select="parent::sentence/word[@id = $head_8]/@head"/>
                            <xsl:variable name="head_10" select="parent::sentence/word[@id = $head_9]/@head"/>
                            <xsl:variable name="head_11" select="parent::sentence/word[@id = $head_10]/@head"/>
                            <xsl:variable name="head_12" select="parent::sentence/word[@id = $head_11]/@head"/>
                            <xsl:variable name="head_13" select="parent::sentence/word[@id = $head_12]/@head"/>
                            <xsl:variable name="head_14" select="parent::sentence/word[@id = $head_13]/@head"/>
                            <xsl:variable name="head_15" select="parent::sentence/word[@id = $head_14]/@head"/>
                            <xsl:variable name="head_16" select="parent::sentence/word[@id = $head_15]/@head"/>
                            
                            <xsl:value-of select="string-join((./@relation, 
                                parent::sentence/word[@id = $head_1]/@relation,
                                parent::sentence/word[@id = $head_2]/@relation, 
                                parent::sentence/word[@id = $head_3]/@relation,
                                parent::sentence/word[@id = $head_4]/@relation,
                                parent::sentence/word[@id = $head_5]/@relation,
                                parent::sentence/word[@id = $head_6]/@relation,
                                parent::sentence/word[@id = $head_7]/@relation,
                                parent::sentence/word[@id = $head_8]/@relation,
                                parent::sentence/word[@id = $head_9]/@relation,
                                parent::sentence/word[@id = $head_10]/@relation,
                                parent::sentence/word[@id = $head_11]/@relation,
                                parent::sentence/word[@id = $head_12]/@relation,
                                parent::sentence/word[@id = $head_13]/@relation,
                                parent::sentence/word[@id = $head_14]/@relation,
                                parent::sentence/word[@id = $head_15]/@relation,
                                parent::sentence/word[@id = $head_16]/@relation,
                                '#'), '-')"/>
                            
                        </sWord>
                    </xsl:for-each>
                    
                </sentence>
            </xsl:for-each>
        </sWord_document>
    </xsl:template>
</xsl:stylesheet>