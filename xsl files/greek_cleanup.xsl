<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
   
   <xsl:template match="/">
      <xsl:apply-templates select="*"/>
       
   </xsl:template>

<xsl:template match="*">
  <xsl:copy>
      <xsl:for-each select="@*">
          
      </xsl:for-each>
      <xsl:apply-templates/>
  </xsl:copy>  
  
</xsl:template>
    
<xsl:template match="bibl"/>
    <xsl:template match="note"/>

</xsl:stylesheet>