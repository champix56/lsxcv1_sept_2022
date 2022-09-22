<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hello="urn:orsys:test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:param="urn:xsl:param:facture" exclude-result-prefixes="hello param"  >
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<!--inclusion avec capacité de redef.-->
	<xsl:include href="lib.xslt"/>
	
	<!--

template d'exclusion de traitement generiques

	-->
	<!--template ne faisant rien-->
	<xsl:template match="ligne/nbUnit/@helloAttrib"/>
	<!--template de traitement exclusif particulier-->
	<xsl:template match="ligne/nbUnit[. &lt; 1]">
		<xsl:element name="{name()}-rmp">
			<xsl:apply-templates select="@*"/>
		</xsl:element>
	</xsl:template>
	<!--template de gestion de correction du type-->
	<xsl:template match="@type">
		<xsl:attribute name="type"><!--translation de caracteres vers d'autre caracteres--><xsl:value-of select="translate(.,'acdefistuv', 'ACDEFISTUV')"/><!--<xsl:choose>
				<xsl:when test="contains(.,'evis')">DEVIS</xsl:when>
				<xsl:otherwise>FACTURE</xsl:otherwise>
			</xsl:choose>--></xsl:attribute>
	</xsl:template>
	<xsl:template name="calcul-total-facture">
		<xsl:param name="baseNode" select="."/>
		<total>
			<xsl:value-of select="sum($baseNode//stotligne)"/>
		</total>
	</xsl:template>
	<xsl:template match="facture">
		<xsl:element name="facture">
			<xsl:apply-templates select="@*|*|processing-instruction()|comment()|text()"/>
			<xsl:call-template name="calcul-total-facture"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="phtByUnit">
		<xsl:param name="devise">&#x20AC;</xsl:param>	
		<xsl:element name="{name()}">
			<xsl:value-of select="."/>
			<xsl:value-of select="$devise"/>
		</xsl:element>
	</xsl:template>
	<xsl:param name="paramGobal" >
		<param:ligne xmlns:param="urn:xsl:param:facture">
			<xsl:for-each select="//ref">
				<param:ref>restruct-<xsl:value-of select="."/></param:ref>
			</xsl:for-each>
		</param:ligne>
	</xsl:param>
	<xsl:template match="param:ref">
		<reference><xsl:value-of select="."/></reference>
	</xsl:template>
	<xsl:template match="listeDesRef">
		<voiciLaListeDesRef><xsl:copy-of select="./*"/></voiciLaListeDesRef>
	</xsl:template>
	<xsl:template match="/">
		<xsl:apply-templates select="processing-instruction()|comment()"/>
		<xsl:element name="factures">
			<xsl:apply-templates select="factures/@*|factures/*"/>
			<xsl:call-template name="calcul-total-facture">
				<xsl:with-param name="baseNode" select="factures/facture[contains(@type,'acture')]"/>
			</xsl:call-template>
			<paramValue><xsl:value-of select="$paramGobal"/></paramValue>
			<xsl:apply-templates select="$paramGobal/*"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
