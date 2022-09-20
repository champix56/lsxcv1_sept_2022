<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
	<!ENTITY euro "&#x20AC;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:include href="commonMedasys.xsl"/>	
	<!--Template name pour afficher les totaux car pas de noeuds pour faire un match qui contiendrais les totaux dans le fichier XML-->
	<xsl:template name="totaux_facture">
		<xsl:param name="laFactureEnCoursDeTraitement" select=".."/>
		<xsl:param name="tauxTVA" select="0.25"/>
		<xsl:variable name="ht" select="round(sum($laFactureEnCoursDeTraitement//stotligne) * 100) div 100"/>
		<xsl:variable name="tva" select="round($ht * $tauxTVA * 100) div 100"/>
		<fo:table-row>
			<fo:table-cell number-columns-spanned="3">
				<fo:block/>
			</fo:table-cell>
			<fo:table-cell number-columns-spanned="2">
				<fo:block text-align="right">Total H.T.</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="format-number($ht,'0,00','monnaie')"/>&euro;</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block/>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell number-columns-spanned="3">
				<fo:block/>
			</fo:table-cell>
			<fo:table-cell number-columns-spanned="2">
				<fo:block text-align="right">T.V.A.</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="format-number($tva,'# ##0,00','monnaie')"/>&euro;</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block/>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell number-columns-spanned="3">
				<fo:block/>
			</fo:table-cell>
			<fo:table-cell number-columns-spanned="2">
				<fo:block text-align="right">Total T.T.C.</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="$ht + $tva"/>&euro;</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block/>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	<!--template qui traite le noeud client dans clients (present sur le fichier clients.xml loader par 'document()'  )-->
	<xsl:template match="clients/client">
		<xsl:value-of select="destinataire"/>
		<fo:block/>
		<xsl:value-of select="adr1"/>
		<fo:block/>
		<xsl:value-of select="adr2"/>
		<fo:block/>
		<xsl:value-of select="cp"/>&nbsp;<xsl:value-of select="ville"/>
	</xsl:template>
	<!--template pour annihiler le mode par default-->
	<xsl:template match="text()|@*" priority="1"/>
	<!--template specifique pour tous les noueds <facture> dont le type contient acture donc une facture
	<xsl:template match="facture[contains(@type,'acture')]">
		<fo:page-sequence master-reference="A4Portrait">
			<fo:flow flow-name="xsl-region-body">
				<fo:block>facture</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template> -->
	<!--template generique pour tous les noeuds <facture>-->
	<xsl:template match="facture">
		<fo:page-sequence master-reference="A4Portrait">
			<fo:flow flow-name="xsl-region-body">
				<!--block du page sequence-->
				<fo:block>
					<!--block de l'expediteur-->
					<fo:block border="0.5mm solid black" margin-right="12cm" margin-left="1cm" margin-top="1cm">
						<xsl:value-of select="/factures/@rsets"/>
						<fo:block/>
						<xsl:value-of select="/factures/@adr1ets"/>
						<fo:block/>
						<xsl:value-of select="/factures/@adr2ets"/>
						<fo:block/>
						<xsl:value-of select="/factures/@cpets"/>&nbsp;<xsl:value-of select="/factures/@villeets"/>
						<fo:block/>
					</fo:block>
					<!--block destinataire-->
					<fo:block border="0.5mm solid black" margin-right="1cm" margin-left="12cm" margin-top="1cm">
						<!--variable de stockage de l'@idclient pour reinjection de la valeur dans le filtre XPath du la variable suivante-->
						<xsl:variable name="idc" select="@idclient"/>
						<!--variable global de stockage du document clients.xml-->
						<xsl:variable name="docClient" select="document('clients.xml')/clients/client[@id=$idc]"/>
						<xsl:apply-templates select="$docClient"/>
					</fo:block>
					<!--block de l'entete-->
					<fo:block border="0.5mm solid black" margin-left="20%" margin-right="20%" margin-top="1.5cm" text-align="center" margin-bottom="1.5cm">
						<xsl:choose>
							<xsl:when test="contains(@type,'acture')">Facture</xsl:when>
							<xsl:otherwise>Devis</xsl:otherwise>
						</xsl:choose>N°<xsl:value-of select="@numfacture"/>
						<fo:block/>
						<xsl:if test="@refdevis">En reference au Devis N° <xsl:value-of select="@refdevis"/>
						</xsl:if>
					</fo:block>
					<xsl:apply-templates select="lignes"/>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	
	
	<xsl:template match="lignes">
		<!--<fo:block margin-left="8cm" >-->
		<fo:table>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell border="0.5mm solid black" background-color="lightgrey">
						<fo:block>Ref</fo:block>
					</fo:table-cell>
					<fo:table-cell border="0.5mm solid black" background-color="lightgrey">
						<fo:block>Designation</fo:block>
					</fo:table-cell>
					<fo:table-cell border="0.5mm solid black" background-color="lightgrey">
						<fo:block>&euro;/unit.</fo:block>
					</fo:table-cell>
					<fo:table-cell border="0.5mm solid black" background-color="lightgrey">
						<fo:block>Quant.</fo:block>
					</fo:table-cell>
					<fo:table-cell border="0.5mm solid black" background-color="lightgrey">
						<fo:block>Sous-total</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-body>
				<xsl:apply-templates select="ligne"/>
				<xsl:call-template name="totaux_facture">
					<!--<xsl:with-param name="tauxTVA" select="0.1"/>-->
				</xsl:call-template>
			</fo:table-body>
		</fo:table>
		<!--</fo:block>-->
	</xsl:template>
	<xsl:template match="ligne">
		<xsl:variable name="bgColor">
			<xsl:choose>
				<xsl:when test="position() mod 2 = 0">lightgrey</xsl:when>
				<xsl:otherwise>lightgreen</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:table-row>
			<!-- background-color="{$bgColor}">-->
			<fo:table-cell>
				<fo:block/>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="ref"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="designation"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="center">
				<fo:block>
					<xsl:value-of select="phtByUnit"/>&euro;</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="center">
				<fo:block>
					<xsl:value-of select="nbUnit"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="center">
				<fo:block>
					<xsl:value-of select="format-number(stotligne,'0,00','monnaie')"/>
					<fo:inline color="blue"> &euro;</fo:inline>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block/>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>	
	
	
</xsl:stylesheet>
