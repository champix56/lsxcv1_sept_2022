<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#8364;">
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="fn xs myfn" xmlns:myfn="urn:orsys:factures:mesfonctions">
<xsl:import href="lib.money.xslt"/>
<xsl:template match="factures">
		<ul>
			<xsl:apply-templates select=".//facture" mode="#current"/>
		</ul>
	</xsl:template>
	<xsl:template match="facture" mode="sommaire">
		<li><a href="#F-{fn:generate-id()}"><xsl:apply-templates select="@type" mode="#current"/>&nbsp;<xsl:value-of select="@numfacture"/>-Total :<xsl:value-of select="myfn:roundCent(sum(.//stotligne))"/></a></li>
	</xsl:template>
	
</xsl:stylesheet>
