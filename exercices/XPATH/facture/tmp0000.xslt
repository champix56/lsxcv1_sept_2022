<?xml version="1.0" encoding="ISO-8859-1"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#x20AC;">
	<!ENTITY signature "je suis Alexandre">
	<!ENTITY documentTXT SYSTEM "mondoc.txt">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="ISO-8859-1" indent="yes"/>
	<xsl:template match="facture[contains(@type,'evis')]" mode="sommaire">
		<li class="une-puce-de-liste">
			<a class="un-lien" href="#facture-{@numfacture}">
				Devis n°<xsl:value-of select="@numfacture"/>
			</a>
		</li>
	</xsl:template>
	<xsl:template match="facture" mode="sommaire">
		<li class="une-puce-de-liste">
			<a class="un-lien" href="#facture-{@numfacture}">
				Facture	n°<xsl:value-of select="@numfacture"/>
			</a>
		</li>
	</xsl:template>
	<!--comportement par def. si pas de specification du mode -->
	<xsl:template match="facture">
		<div class="facture" id="facture-" style="height:27cm;width:20cm;page-break-after:always;border:1px solid blue">
			<div class="expediteur" style="border:1px solid green;width:100mm;height:50mm;">ECO-NOME<br/>rue leopold 4<br/>1000 BRUXELLE</div>
			<div class="destinataire" style="border:1px solid violet;width:100mm;height:50mm;margin-top:2mm; margin-left:80mm">Jean BON <br/>route de la reine 14<br/>7500 tournai</div>
			<div class="numero-facture" style="border:1px solid pink;margin-top:5mm; width:70%;margin-left:15%;text-align:center;">Facture N° 55555</div>
			<table class="lignes" cellspacing="0" style="width:90%;margin-left:5%;margin-top:8mm;" border="1">
				<tr style="background-color:lightgrey">
					<th>Ref.</th>
					<th>Designation</th>
					<th>&euro;/Unit</th>
					<th>Quant.</th>
					<th>Total</th>
				</tr>
				<tr class="ligne">
					<td>REF-1234</td>
					<td>Produit 1</td>
					<td>10.00</td>
					<td>5</td>
					<th>50.00</th>
				</tr>
				<tr class="total-ht">
					<td colspan="2"/>
					<th colspan="2">Montant HT</th>
					<th>50.00&euro;</th>
				</tr>
				<tr class="total-tva">
					<td colspan="2"/>
					<th colspan="2">Montant TVA 21%</th>
					<th>1.50&euro;</th>
				</tr>
				<tr class="total-ttc">
					<td colspan="2"/>
					<th colspan="2">Montant TTC</th>
					<th>51.50&euro;</th>
				</tr>
			</table>
		</div>
	</xsl:template>
	<xsl:template match="/">
		<html>
			<head>
				<title>Factures éditiées en date du : <xsl:value-of select="/factures/@dateeditionXML"/>
				</title>
			</head>
			<body style="font-size:16pt;">
				<ul class="list-puces">
					<xsl:apply-templates select="//facture" mode="sommaire"/>
					<!--<xsl:for-each select="//facture">
						<li class="une-puce-de-liste">
							<a class="un-lien" href="#facture-{@numfacture}">
								-->
					<!--une structure conditionnelle avec cas principale & complémentaire-->
					<!--
								<xsl:choose>
									<xsl:when test="contains(@type,'evis')">Devis</xsl:when>
									<xsl:otherwise>Facture</xsl:otherwise>
								</xsl:choose> 
							n°<xsl:value-of select="@numfacture"/>
							</a>
						</li>
					</xsl:for-each>-->
				</ul>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
