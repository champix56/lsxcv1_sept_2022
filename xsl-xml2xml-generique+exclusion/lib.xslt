<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:param="urn:xsl:param:facture" >
<!--
	lib de template pour usage commun a plusieurs feuilles xsl
-->
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
</xsl:stylesheet>
