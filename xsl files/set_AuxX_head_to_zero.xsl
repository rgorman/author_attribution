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
                <xsl:choose>
                    <xsl:when test="./word/@relation = 'AuxX'">
                       <sentence>
                           <xsl:copy-of select="@*"/>
                           <xsl:for-each select="word">
                               <xsl:choose>
                                   <xsl:when test="./@relation = 'AuxX'">
                                       <xsl:choose>
                                           <xsl:when test="./@insertion_id">
                                               <word id="{./@id}" insertion_id="{./@insertion_id}"  
                                                   atificial="{./@artificial}"  form="{./@form}" lemma="{./@lemma}"
                                                   postag="{./@postag}" relation="{./@relation}"
                                                   head="0" cite="{./@cite}"/>
                                           </xsl:when>
                                           <xsl:otherwise>
                                               <word id="{./@id}" form="{./@form}" lemma="{./@lemma}"
                                                   postag="{./@postag}" relation="{./@relation}"
                                                   head="0" cite="{./@cite}"/>
                                           </xsl:otherwise>
                                       </xsl:choose>
                                       
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
                
                
                
                
            </xsl:for-each>
        </treebank>
    </xsl:template>
    
</xsl:stylesheet>