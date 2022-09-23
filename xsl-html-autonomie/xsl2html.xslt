<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#8364;">
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="fn xs myfn" xmlns:myfn="urn:orsys:factures:mesfonctions">
	<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
	<xsl:decimal-format name="euro" decimal-separator="," grouping-separator=" "/>
	<xsl:template match="/">
		<html>
			<head>
				<title/>
				<style type="text/css">
					.entete-liste-factures h2{
						text-align:center;
						text-decoration: underline blue;
					}
					.entete-liste-factures{
						
					}
					.facture{
						page-break-before:always;
						height:270mm;
						width:200mm;
					}
					.destinataire{
						margin-left:80%;margin-top:5em;margin-bottom:2cm;
					}
					.emeteur{
					margin-left:10px;
					}
					.numfacture{
					width:50%;margin-left:25%;text-align:center;border: 2px solid black;background-color:lightgrey;
					}
					.lignes{
					width:80%; margin-left:10%;margin-right:10%;margin-top:1cm;margin-bottom:1cm;
					}
					.footer{text-align:center;}
				</style>
			</head>
			<body>
				<div class="entete-liste-factures">
					<h2>Liste des factures<br/> en date du : <xsl:value-of select="/factures/@dateeditionXML"/></h2>
					<xsl:apply-templates select="factures" mode="sommaire"/>
					<hr/>
				</div>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="@type"><xsl:apply-templates select="text()" mode="#current"/></xsl:template>
	<xsl:template match="factures" mode="sommaire">
		<ul>
			<xsl:apply-templates select=".//facture" mode="#current"/>
		</ul>
	</xsl:template>
	<xsl:template match="facture" mode="sommaire">
		<li><a href="#F-{fn:generate-id()}"><xsl:apply-templates select="@type" mode="#current"/>&nbsp;<xsl:value-of select="@numfacture"/></a></li>
	</xsl:template>
	<xsl:template match="facture">
		<div class="facture" id="F-{fn:generate-id()}">
			<xsl:apply-templates select="/factures/@rsets"/>
			<xsl:apply-templates select="@idclient"/>
			<xsl:apply-templates select="@numfacture"/>
			<xsl:apply-templates select="lignes"/>
			<xsl:call-template name="footer"/>
		</div>
	</xsl:template>
	<xsl:template match="@rsets">
		<div class="emeteur">
			<table>
				<tbody>
					<tr>
						<td>
							<img alt="" src="{/factures/@logourl}"/>
						</td>
						<td>
							<xsl:value-of select="."/>
							<br/>
							<xsl:value-of select="/factures/@adr1ets"/>
							<br/>
							<xsl:value-of select="/factures/@adr2ets"/>
							<br/>
							<xsl:value-of select="/factures/@cpets"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="/factures/@villeets"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</xsl:template>
	<xsl:template match="@numfacture">
		<div class="numfacture">
			<xsl:choose>
				<xsl:when test="contains(../@type,'evis')">DEVIS </xsl:when>
				<xsl:otherwise>FACTURE</xsl:otherwise>
			</xsl:choose> N° <xsl:value-of select="."/>
			<br/>En date du : <i>
				<b>
					<xsl:value-of select="../@datefacture"/>
				</b>
			</i>
			<xsl:if test="../@refdevis">
				<br/>
				<i>En reference au devis n° <xsl:value-of select="../@refdevis"/>
				</i>
			</xsl:if>
		</div>
	</xsl:template>
	<xsl:template match="@idclient">
		<xsl:variable name="idcli" select="."/>
		<xsl:variable name="unClient" select="fn:document('clients.xml')//client[@id=$idcli]"/>
		<xsl:apply-templates select="$unClient"/>
	</xsl:template>
	<xsl:template match="clients/client">
		<div class="destinataire">
			<xsl:value-of select="rs"/>
			<br/>
			<xsl:value-of select="destinataire"/>
			<br/>
			<xsl:value-of select="adr1"/>
			<br/>
			<xsl:value-of select="adr2"/>
			<br/>
			<xsl:value-of select="cp"/>&nbsp;<xsl:value-of select="ville"/>
		</div>
	</xsl:template>
	<xsl:template match="lignes">
		<table class="lignes">
			<thead>
				<tr>
					<th>ref</th>
					<th>design.</th>
					<th>surface</th>
					<th>euro/Unit.</th>
					<th>quant</th>
					<th>Sous-total</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="ligne"/>
			</tbody>
			<tfoot>
				<xsl:call-template name="totaux"/>
			</tfoot>
		</table>
	</xsl:template>
	<xsl:template match="ligne">
		<tr>
			<td>
				<xsl:value-of select="ref"/></td>
			<td><xsl:value-of select="designation"/></td>
			<td><xsl:value-of select="surface"/></td>
			<td><xsl:value-of select="phtByUnit"/></td>
			<td>
				<xsl:value-of select="nbUnit"/>
			</td>
			<td>
				<xsl:value-of select="fn:format-number(stotligne,'0,00&euro;','euro')"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="footer">
		<div class="footer">
			<hr/>
			<xsl:value-of select="/factures/@rsets"/>
		</div>
	</xsl:template>
	<xsl:template name="totaux">
		<tr>
			<td colspan="4">
				<xsl:text> </xsl:text>
			</td>
			<td>Total HT</td>
			<td>
				<xsl:value-of select="fn:format-number(myfn:roundCent(xs:decimal(sum(.//stotligne))),'0,00&euro;','euro')"/>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<xsl:text> </xsl:text>
			</td>
			<td>Total TVA</td>
			<td>
				<xsl:value-of select="fn:format-number(myfn:calculTVA(.//stotligne),'0,00&euro;','euro')"/>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<xsl:text> </xsl:text>
			</td>
			<td>Total TVA</td>
			<td>
				<xsl:value-of select="fn:format-number(myfn:calculTVA(.//stotligne) + myfn:roundCent(sum(.//stotligne)),'0,00&euro;','euro')"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:function name="myfn:calculTVA">
		<xsl:param name="nodes"/>
		<xsl:value-of select="myfn:roundCent(sum($nodes) *0.2 ) "/>
	</xsl:function>
	<xsl:function name="myfn:roundCent" as="xs:decimal">
		<xsl:param name="value" as="xs:numeric"/>
		<xsl:value-of select="fn:round($value * 100) div 100"/>
	</xsl:function>
</xsl:stylesheet>
