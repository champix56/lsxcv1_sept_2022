<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"/>
	<xsl:template match="/">Factures en date du : <xsl:value-of select="/factures/@dateeditionXML"/>
date facture;numfacture;type;total
<xsl:for-each select="//facture">
			<xsl:value-of select="@datefacture"/>;<xsl:value-of select="@numfacture"/>;<xsl:value-of select="@type"/>;<xsl:value-of select="sum(//facture//stotligne)"/>
			<xsl:text>
</xsl:text>
		</xsl:for-each>
-------------------------------
liste des lignes de factures avec contenu
numfacture;<xsl:for-each select="//facture[.//ligne[count(*)=6]][1]//ligne[count(*)=6][1]/*[name()!='information' and not(starts-with(name(),'balise'))]">
			<xsl:value-of select="name()"/>
			<xsl:choose>
				<!--cas jusqu'a l'avant dernier-->
				<xsl:when test="position()!=last()">;</xsl:when>
				<!--cas du dernier element dans le parent-->
				<xsl:otherwise>
					<xsl:text>
</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="//ligne">
			<xsl:value-of select="ancestor::facture/@numfacture"/>;<xsl:for-each select="*">
			<xsl:if test="name()='phtByUnit' and not(../surface)">;</xsl:if>
				<xsl:value-of select="."/>
				<xsl:choose>
					<!--cas jusqu'a l'avant dernier-->
					<xsl:when test="position()!=last()">;</xsl:when>
					<!--cas du dernier element dans le parent-->
					<xsl:otherwise>
						<xsl:text>
</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
