<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:myfn="urn:orsys:factures:mesfonctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:function name="myfn:calculTVA">
		<xsl:param name="nodes"/>
		<xsl:value-of select="myfn:roundCent(sum($nodes) *0.2 ) "/>
	</xsl:function>
	<xsl:function name="myfn:roundCent" as="xs:decimal">
		<xsl:param name="value" as="xs:numeric"/>
		<xsl:value-of select="fn:round($value * 100) div 100"/>
	</xsl:function>
</xsl:stylesheet>
