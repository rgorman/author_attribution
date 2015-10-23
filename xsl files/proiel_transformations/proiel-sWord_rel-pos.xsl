<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="proiel">
        <stoken_document>
            <xsl:for-each select="//annotation">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="//metaData">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="//sentence">
                <sentence>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="token">
                        <xsl:variable name="head_1" select="./@head-id"/>
                        <xsl:variable name="head_2"
                            select="parent::sentence/token[@id = $head_1]/@head-id"/>
                        <xsl:variable name="head_3"
                            select="parent::sentence/token[@id = $head_2]/@head-id"/>
                        <xsl:variable name="head_4"
                            select="parent::sentence/token[@id = $head_3]/@head-id"/>
                        <xsl:variable name="head_5"
                            select="parent::sentence/token[@id = $head_4]/@head-id"/>
                        <xsl:variable name="head_6"
                            select="parent::sentence/token[@id = $head_5]/@head-id"/>
                        <xsl:variable name="head_7"
                            select="parent::sentence/token[@id = $head_6]/@head-id"/>
                        <xsl:variable name="head_8"
                            select="parent::sentence/token[@id = $head_7]/@head-id"/>
                        <xsl:variable name="head_9"
                            select="parent::sentence/token[@id = $head_8]/@head-id"/>
                        <xsl:variable name="head_10"
                            select="parent::sentence/token[@id = $head_9]/@head-id"/>
                        <xsl:variable name="head_11"
                            select="parent::sentence/token[@id = $head_10]/@head-id"/>
                        <xsl:variable name="head_12"
                            select="parent::sentence/token[@id = $head_11]/@head-id"/>
                        <xsl:variable name="head_13"
                            select="parent::sentence/token[@id = $head_12]/@head-id"/>
                        <xsl:variable name="head_14"
                            select="parent::sentence/token[@id = $head_13]/@head-id"/>
                        <xsl:variable name="head_15"
                            select="parent::sentence/token[@id = $head_14]/@head-id"/>
                        <xsl:variable name="head_16"
                            select="parent::sentence/token[@id = $head_15]/@head-id"/>
                        <sWord>
                            <xsl:copy-of select="@*"/>#-<xsl:value-of select="string-join((
                                parent::sentence/token[@id = $head_15]/@relation,
                                parent::sentence/token[@id = $head_15]/@part-of-speech,
                                parent::sentence/token[@id = $head_14]/@relation,
                                parent::sentence/token[@id = $head_14]/@part-of-speech,
                                parent::sentence/token[@id = $head_13]/@relation,
                                parent::sentence/token[@id = $head_13]/@part-of-speech,
                                parent::sentence/token[@id = $head_12]/@relation,
                                parent::sentence/token[@id = $head_12]/@part-of-speech,
                                parent::sentence/token[@id = $head_11]/@relation,
                                parent::sentence/token[@id = $head_11]/@part-of-speech,
                                parent::sentence/token[@id = $head_10]/@relation,
                                parent::sentence/token[@id = $head_10]/@part-of-speech,
                                parent::sentence/token[@id = $head_9]/@relation,
                                parent::sentence/token[@id = $head_9]/@part-of-speech,
                                parent::sentence/token[@id = $head_8]/@relation,
                                parent::sentence/token[@id = $head_8]/@part-of-speech,
                                parent::sentence/token[@id = $head_7]/@relation,
                                parent::sentence/token[@id = $head_7]/@part-of-speech,
                                parent::sentence/token[@id = $head_6]/@relation,
                                parent::sentence/token[@id = $head_6]/@part-of-speech,
                                parent::sentence/token[@id = $head_5]/@relation,
                                parent::sentence/token[@id = $head_5]/@part-of-speech,
                                parent::sentence/token[@id = $head_4]/@relation,
                                parent::sentence/token[@id = $head_4]/@part-of-speech,
                                parent::sentence/token[@id = $head_3]/@relation,
                                parent::sentence/token[@id = $head_3]/@part-of-speech,
                                parent::sentence/token[@id = $head_2]/@relation,
                                parent::sentence/token[@id = $head_2]/@part-of-speech,                                
                                parent::sentence/token[@id = $head_1]/@relation,
                                parent::sentence/token[@id = $head_1]/@part-of-speech,
                                ./@relation,
                                ./@part-of-speech), '*') "/>
                        </sWord>
                    </xsl:for-each>
                </sentence>
            </xsl:for-each>
        </stoken_document>

    </xsl:template>

</xsl:stylesheet>
