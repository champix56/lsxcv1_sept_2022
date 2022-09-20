<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" omit-xml-declaration="yes" indent="yes" encoding="iso-8859-1"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Facture en date du <xsl:value-of select="/factures/@dateeditionXML"/>
				</title>
				<script type="text/css"/>
			</head>
			<body>
				<h1>Factures : </h1>
				<ul>
					<xsl:for-each select="//facture">
						<xsl:sort select="@numfacture"/>
						<li>
							<a href="#F-{@numfacture}">Facture N°<xsl:value-of select="@numfacture"/>
							</a>
						</li>
					</xsl:for-each>
				</ul>
				<hr/>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture[contains(@type,'evis')]">
Voici un devis
	</xsl:template>		
	<xsl:template match="facture">
		<div id="F-{@numfacture}" style="border:0.3mm solid black;height:27cm;">
			<div class="adresse-emeteur"></div>
			<div class="adresse-client"></div>
			<div class="numero-facture" style="margin-left:30%width:40%;text-align:center;border:0.3mm solid black">
					Facture N° <xsl:value-of select="@numfacture"/><br/>
					le : <xsl:value-of select="@datefacture"/>
			</div>
			<table>
				<tr>
					<th>une cell de tableau</th>
				</tr>
			</table>
		</div>
	</xsl:template>	
</xsl:stylesheet>
