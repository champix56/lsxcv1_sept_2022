<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#8364;">
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="fn xs myfn" xmlns:myfn="urn:orsys:factures:mesfonctions">
	
<xsl:include href="lib.sommaire.xslt"/>	
<xsl:include href="lib.facture.html.xslt"/>	
	<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
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
	
	
</xsl:stylesheet>
