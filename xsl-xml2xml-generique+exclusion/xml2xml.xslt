<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hello="urn:orsys:test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="hello">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="processing-instruction()">
		<xsl:processing-instruction name="{name()}">
			<xsl:value-of select="."/>
		</xsl:processing-instruction>
	</xsl:template>
	<xsl:template match="comment()">
		<xsl:comment>
			<xsl:value-of select="."/>
		</xsl:comment>
	</xsl:template>
	<!--
	deja def. dans le core de xsl et ayant la meme action que ce template 
<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>-->
	<xsl:template match="*">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*|*|text()|processing-instruction()|comment()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:variable name="n" select="name()"/>
		<xsl:message>
			<xsl:value-of select="$n"/>
		</xsl:message>
		<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
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
		<total><xsl:value-of select="sum($baseNode//stotligne)"/></total>
	</xsl:template>
	<xsl:template match="facture">
		<xsl:element name="facture">
			<xsl:apply-templates select="@*|*|processing-instruction()|comment()|text()"/>
			<xsl:call-template name="calcul-total-facture"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/">
		<xsl:apply-templates select="processing-instruction()|comment()"/>
		<xsl:element name="factures">
			<xsl:apply-templates select="factures/@*|factures/*"/>
			<xsl:call-template name="calcul-total-facture">
				<xsl:with-param name="baseNode" select="factures/facture[contains(@type,'acture')]"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
