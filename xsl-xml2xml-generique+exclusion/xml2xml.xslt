<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hello="urn:orsys:test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!--<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>-->
	<xsl:template match="*">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*|*|text()"/>
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
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
