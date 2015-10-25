<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="stoken_document">
        <wordOrderDocument>

            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotation">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="metaData">
                <xsl:copy-of select="."/>
            </xsl:for-each>

            <xsl:for-each select="sentence">
                <sentence>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="sWord">
                        <word><xsl:copy-of select="@*"/>
                            <xsl:value-of select="./@relation"/>-<xsl:value-of
                                select="./@part-of-speech"/>
                        </word>



                    </xsl:for-each>
                </sentence>
            </xsl:for-each>
        </wordOrderDocument>
    </xsl:template>

</xsl:stylesheet>
