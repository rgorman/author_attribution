<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <proiel>
            <xsl:for-each select="//annotation">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <metaData>
                <title>The Greek New Testament</title>
                <citation-part>GNT</citation-part>
                <principal>Dag Trygve Truslew Haug</principal>
                <funder>Research Council of Norway</funder>
                <distributor>Department of Philosophy, Classics, History of Arts and
                    Ideas</distributor>
                <distributor-address>PO Box 1020 Blindern, N-0315 Oslo</distributor-address>
                <date>25 July 2015</date>
                <license>CC BY-NC-SA 3.0</license>
                <license-url>http://creativecommons.org/licenses/by-nc-sa/3.0/us/</license-url>
                <reference-system>Standard biblical reference system</reference-system>
                <editor>Dag Haug</editor>
                <annotator>Dagmar Wodtko (7570 sentences), Marek Majer (760 sentences), Bergthora
                    Aegisdottir (698 sentences), Pål Rykkja Gilbert (643 sentences), Michael
                    Frotscher (365 sentences), Dag Haug (346 sentences), Eirik Welo (342 sentences),
                    Per Kristen Teigen (301 sentences), David Sobey (217 sentences), Hanne Eckhoff
                    (182 sentences), Þorsteinn Vilhjálmsson (153 sentences), Corinna Scheungraber
                    (120 sentences), Angelika Müth (96 sentences), Jana Beck (41 sentences), Sergej
                    Munkvold (4 sentences), and Dag Haug (1 sentence)</annotator>
                <reviewer>Dag Haug (4936 sentences), Marek Majer (4145 sentences), Þorsteinn
                    Vilhjálmsson (1095 sentences), Eirik Welo (941 sentences), and Hanne Eckhoff
                    (144 sentences)</reviewer>
                <electronic-text-editor>Ulrik Sandborg-Petersen</electronic-text-editor>
                <electronic-text-title>Tischendorf 8th GNT with morphology and
                    lemmatization</electronic-text-title>
                <electronic-text-version>2.0 (Tischendorf-2.0.zip with MD5 sum
                    f1732e0f66d9ca9565de4dc48e5b2b2b)</electronic-text-version>
                <electronic-text-publisher>Ulrik Sandborg-Petersen</electronic-text-publisher>
                <electronic-text-date>19 January 2008</electronic-text-date>
                <electronic-text-original-url>https://github.com/morphgnt/tischendorf</electronic-text-original-url>
                <electronic-text-license>Public domain</electronic-text-license>
                <electronic-text-license-url>http://en.wikipedia.org/wiki/Public_domain</electronic-text-license-url>
                <printed-text-editor>Constantin von Tischendorf</printed-text-editor>
                <printed-text-title>Novum Testamentum Graece</printed-text-title>
                <printed-text-edition>Editio octava critica maior</printed-text-edition>
                <printed-text-publisher>Gieseche &amp; Devrient</printed-text-publisher>
                <printed-text-place>Leipzig</printed-text-place>
                <printed-text-date>1869</printed-text-date>
            </metaData>
            <xsl:for-each select="//div">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </proiel>

    </xsl:template>

</xsl:stylesheet>
