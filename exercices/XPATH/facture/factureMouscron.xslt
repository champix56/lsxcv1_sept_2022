<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#x20AC;">
	<!ENTITY nbsp "&#160;">
	<!ENTITY signature "je suis Alexandre">
	<!ENTITY documentTXT SYSTEM "mondoc.txt">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:decimal-format name="cur_eur" decimal-separator="," grouping-separator=" " />
	<xsl:output method="html" encoding="ISO-8859-1" indent="yes"/>
	<xsl:template name="total-facture">
		<xsl:param name="inputNode" select="."/>
		<xsl:variable name="montantHT" select="sum($inputNode//stotligne)"/>
		<xsl:variable name="montantTVA" select="$montantHT*0.21"/>
		<tr class="total-ht">
			<td colspan="2"/>
			<th colspan="2">Montant HT</th>
			<th> 
				<xsl:value-of select="format-number($montantHT,'0,##&euro;', 'cur_eur')"/></th>
		</tr>
		<tr class="total-tva">
			<td colspan="2"/>
			<th colspan="2">Montant TVA 21%</th>
			<th>
				<xsl:value-of select="$montantTVA"/>&euro;</th>
		</tr>
		<tr class="total-ttc">
			<td colspan="2"/>
			<th colspan="2">Montant TTC</th>
			<th>
				<xsl:value-of select="$montantHT+$montantTVA"/> &euro;</th>
		</tr>
	</xsl:template>
	<xsl:template match="facture/@numfacture">
		<div class="numero-facture" style="border:1px solid pink;margin-top:5mm; width:70%;margin-left:15%;text-align:center;">
			Facture N° <xsl:value-of select="."/>
			<xsl:if test="parent::facture/@refdevis">
				<br/>en ref. au devis N°<xsl:value-of select="parent::facture/@refdevis"/>
			</xsl:if>
		</div>
	</xsl:template>
	<xsl:template match="facture[contains(@type,'evis')]/@numfacture">
		<div class="numero-facture" style="border:1px solid pink;margin-top:5mm; width:70%;margin-left:15%;text-align:center;">
			Devis N° <xsl:value-of select="."/>
		</div>
	</xsl:template>
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
		<div class="facture" id="facture-{@numfacture}" style="height:27cm;width:20cm;page-break-after:always;border:1px solid blue">
			<div class="expediteur" style="border:1px solid green;width:100mm;height:50mm;">
				<xsl:value-of select="/factures/@rsets"/>
				<br/>
				<xsl:value-of select="/factures/@adr1ets"/>
				<br/>
				<xsl:if test="string-length(/factures/@adr2ets) > 0">
					<xsl:value-of select="/factures/@adr2ets"/>
					<br/>
				</xsl:if>
				<xsl:value-of select="/factures/@cpets"/>
				<xsl:text>                           </xsl:text>
				<xsl:value-of select="/factures/@villeets"/>
			</div>
			<div class="destinataire" style="border:1px solid violet;width:100mm;height:50mm;margin-top:2mm; margin-left:80mm">Jean BON <br/>route de la reine 14<br/>7500 tournai</div>
			<xsl:apply-templates select="@numfacture"/>
			<table class="lignes" cellspacing="0" style="width:90%;margin-left:5%;margin-top:8mm;" border="1">
				<tr style="background-color:lightgrey">
					<th>Ref.</th>
					<th>Designation</th>
					<th>&euro;/Unit</th>
					<th>Quant.</th>
					<th>Total</th>
				</tr>
				<xsl:apply-templates select=".//ligne"/>
				<xsl:call-template name="total-facture"/>
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
					<xsl:apply-templates select="//facture" mode="sommaire">
						<xsl:sort select="@type"/>
						<xsl:sort select="@numfacture"/>
					</xsl:apply-templates>
				</ul>
				<hr style="page-break-after:always"/>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="ligne">
		<tr class="ligne">
			<xsl:apply-templates select="./*"/>
		</tr>
	</xsl:template>
	<xsl:template match="ligne/*">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
	<xsl:template match="ligne/surface"/>
</xsl:stylesheet>
