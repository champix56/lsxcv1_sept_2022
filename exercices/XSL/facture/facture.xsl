<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output encoding="utf-8" omit-xml-declaration="yes" method="html"/>
	<xsl:template match="/">
		<xsl:variable name="cl" select="document('clients.xml')//client"/>
		<html>
			<head>
				<title/>
			</head>
			<body>
				<xsl:for-each select="//facture">
				<div style="page-break-after:always;height:200mm;">
					<xsl:variable name="idcl" select="./@idclient"/>
					<xsl:call-template name="adresseETS"/>
					<xsl:apply-templates select="./@idclient">
						<xsl:with-param name="client" select="$cl[./@id=$idcl]"/>
					</xsl:apply-templates>
					<xsl:call-template name="factureOrDevis">
						<xsl:with-param name="factureNode" select="./node()"/>
					</xsl:call-template>
					<div style="height:130mm">
					<xsl:apply-templates select="./lignes"/></div>
					<div style="margin-bottom :0px;text-align:center;" class="mentionlegal">Ste Eco-nome SA au capital de ....</div>
					<hr/>
					</div>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="factureOrDevis">
		<xsl:param name="factureNode"/>
		<div style="width:50%;margin-left:25%;text-align:center;border: 2px solid black;background-color:lightgrey;">
			<xsl:choose>
				<xsl:when test="./@type='devis'">DEVIS</xsl:when>
				<xsl:otherwise>FACTURE</xsl:otherwise>
			</xsl:choose>	numero : <xsl:value-of select="./@numfacture"/>
			<br/>
du : <xsl:value-of select="@datefacture"/>
		</div>
	</xsl:template>
	<xsl:template match="@idclient">
		<xsl:param name="client"/>
		<div style="display:block;margin-left:80%;margin-top:5em;">
			<xsl:value-of select="$client/rs"/>
			<br/>
			<xsl:value-of select="$client/destinataire"/>
			<br/>
			<xsl:value-of select="$client/adr1"/>
			<br/>
			<xsl:value-of select="$client/adr2"/>
			<br/>
			<xsl:value-of select="$client/cp"/>-<xsl:value-of select="$client/ville"/>
		</div>
	</xsl:template>
	<xsl:template name="adresseETS">
		<div class="adresseETS" style="margin-left:10px;display:block;">
			<img alt="" src="{/factures/@logourl}"/>
			<div style="color:green;">
				<xsl:value-of select="/factures/@rsets"/>
			</div>
			<div>
				<xsl:value-of select="/factures/@adr1ets"/>
			</div>
			<div>
				<xsl:value-of select="/factures/@adr2ets"/>
			</div>
			<div>
				<xsl:value-of select="/factures/@cpets"/>-<xsl:value-of select="/factures/@villeets"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="lignes">
		<table   align="center" style="font-size:0.9em;width:80%; margin-left:auto;margin-right:auto;margin-top:20px;">
			<tr>
				<th>Ref</th>
				<th>Désignation</th>
				<th>Surface</th>
				<th>Prix Unitaire</th>
				<th>Nb unités</th>
				<th>Total ligne</th>
			</tr>
			<xsl:apply-templates select="./ligne"/>
			<xsl:call-template name="total">
				<xsl:with-param name="factureNode" select="./parent::node()"/>
			</xsl:call-template>
		</table>
		<div style="height:5em;"> </div>
	</xsl:template>
	<xsl:template match="ligne">
		<tr>
			<td style="border:1px solid black;">
				<xsl:value-of select="./ref"/>
			</td>
			<td  style="border:1px solid black;text-align:center;">
				<xsl:value-of select="./designation"/>
			</td>
			<td style="border:1px solid black;text-align:right;"><xsl:value-of select="./surface"/>
				<xsl:if test="not(./surface)">X</xsl:if>
			</td >
			<td  style="border:1px solid black;text-align:right;">
				<xsl:value-of select="./phtByUnit"/>
			</td>
			<td style="border:1px solid black;text-align:right;">
				<xsl:value-of select="./nbUnit"/>
			</td>
			<td style="border:1px solid black;text-align:right;">
				<xsl:choose>
					<xsl:when test="./surface">
						<xsl:value-of select="floor(./surface * ./phtByUnit * ./nbUnit *100) div 100 "/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="floor(./phtByUnit * ./nbUnit * 100) div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="total">
		<xsl:param name="factureNode"/>
		<tr>
			<th colspan="6"/>
		</tr>
		<tr>
			<td colspan="4" style="border:0;"/>
			<td>Sous-total HT</td>
			<td>
				<xsl:call-template name="calculSomLignes">
					<xsl:with-param name="LastValue" select="0"/>
					<xsl:with-param name="Ligne" select="$factureNode/lignes/ligne[1]"/>
					<xsl:with-param name="position" select="1"/>
				</xsl:call-template>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border:0;"/>
			<td>Montant TVA 19.6%</td>
			<td><xsl:call-template name="calculSomLignestva"><xsl:with-param name="LastValue" select="0"/><xsl:with-param name="Ligne" select="$factureNode/lignes/ligne[1]"/><xsl:with-param name="position" select="1"/> </xsl:call-template></td>
		</tr>
		<tr>
			<td colspan="4" style="border:0;"/>
			<td>Total  TTC</td>
			<td><xsl:call-template name="calculSomLignesttc"><xsl:with-param name="LastValue" select="0"/><xsl:with-param name="Ligne" select="$factureNode/lignes/ligne[1]"/><xsl:with-param name="position" select="1"/> </xsl:call-template></td>
		</tr>
	</xsl:template>
	
	
	
	<xsl:template name="calculSomLignesttc">
		<xsl:param name="LastValue"/>
		<xsl:param name="position"/>
		<xsl:param name="Ligne"/>
 
		<xsl:choose>
			<xsl:when test="$Ligne[./surface]">
				
				<xsl:variable name="stotligne" select="floor($Ligne/nbUnit * $Ligne/phtByUnit * $Ligne/surface * 100) div 100"/>
			
				<xsl:choose>
					<xsl:when test="$position &lt; count($Ligne/parent::lignes/ligne)">
						<xsl:call-template name="calculSomLignesttc">
							<xsl:with-param name="LastValue" select="$LastValue + $stotligne"/>
							<xsl:with-param name="Ligne" select="$Ligne/following-sibling::ligne"/>
							<xsl:with-param name="position" select="$position+1"/>
					 
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="floor((floor( ($LastValue + $stotligne) * 100) div 100)*1.196 *100)div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="stotligne" select="floor($Ligne/nbUnit * $Ligne/phtByUnit * 100) div 100"/>
				<xsl:choose>
					<xsl:when test="$position &lt; count($Ligne/parent::lignes/ligne)">
						<xsl:call-template name="calculSomLignesttc">
							<xsl:with-param name="LastValue" select="$LastValue + $stotligne"/>
							<xsl:with-param name="Ligne" select="$Ligne/following-sibling::ligne"/>
							<xsl:with-param name="position" select="$position+1"/>
						
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="floor((floor( ($LastValue + $stotligne) * 100) div 100)*1.196 *100)div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!--	-->
	</xsl:template>

	
	<xsl:template name="calculSomLignestva">
		<xsl:param name="LastValue"/>
		<xsl:param name="position"/>
		<xsl:param name="Ligne"/>
 
		<xsl:choose>
			<xsl:when test="$Ligne[./surface]">
				
				<xsl:variable name="stotligne" select="floor($Ligne/nbUnit * $Ligne/phtByUnit * $Ligne/surface * 100) div 100"/>
			
				<xsl:choose>
					<xsl:when test="$position &lt; count($Ligne/parent::lignes/ligne)">
						<xsl:call-template name="calculSomLignestva">
							<xsl:with-param name="LastValue" select="$LastValue + $stotligne"/>
							<xsl:with-param name="Ligne" select="$Ligne/following-sibling::ligne"/>
							<xsl:with-param name="position" select="$position+1"/>
					 
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
				<xsl:value-of select="floor((floor( ($LastValue + $stotligne) * 100) div 100)*0.196 *100)div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="stotligne" select="floor($Ligne/nbUnit * $Ligne/phtByUnit * 100) div 100"/>
				<xsl:choose>
					<xsl:when test="$position &lt; count($Ligne/parent::lignes/ligne)">
						<xsl:call-template name="calculSomLignestva">
							<xsl:with-param name="LastValue" select="$LastValue + $stotligne"/>
							<xsl:with-param name="Ligne" select="$Ligne/following-sibling::ligne"/>
							<xsl:with-param name="position" select="$position+1"/>
						
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
				<xsl:value-of select="floor((floor( ($LastValue + $stotligne) * 100) div 100)*0.196 *100)div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!--	-->
	</xsl:template>

	
	<xsl:template name="calculSomLignes">
		<xsl:param name="LastValue"/>
		<xsl:param name="position"/>
		<xsl:param name="Ligne"/>
 
		<xsl:choose>
			<xsl:when test="$Ligne[./surface]">
				
				<xsl:variable name="stotligne" select="floor($Ligne/nbUnit * $Ligne/phtByUnit * $Ligne/surface * 100) div 100"/>
			
				<xsl:choose>
					<xsl:when test="$position &lt; count($Ligne/parent::lignes/ligne)">
						<xsl:call-template name="calculSomLignes">
							<xsl:with-param name="LastValue" select="$LastValue + $stotligne"/>
							<xsl:with-param name="Ligne" select="$Ligne/following-sibling::ligne"/>
							<xsl:with-param name="position" select="$position+1"/>
					 
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="floor( ($LastValue + $stotligne) * 100) div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="stotligne" select="floor($Ligne/nbUnit * $Ligne/phtByUnit * 100) div 100"/>
				<xsl:choose>
					<xsl:when test="$position &lt; count($Ligne/parent::lignes/ligne)">
						<xsl:call-template name="calculSomLignes">
							<xsl:with-param name="LastValue" select="$LastValue + $stotligne"/>
							<xsl:with-param name="Ligne" select="$Ligne/following-sibling::ligne"/>
							<xsl:with-param name="position" select="$position+1"/>
						
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="floor(( $LastValue + $stotligne) * 100) div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!--	-->
	</xsl:template>
</xsl:stylesheet>
