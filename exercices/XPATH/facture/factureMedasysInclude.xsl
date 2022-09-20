<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
	<!ENTITY euro "&#x20AC;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
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
			<fo:static-content flow-name="xsl-region-before">
				<fo:block text-align="center">
					<fo:external-graphic src="1.jpg" content-height="2cm" content-width="2cm" scaling="uniform"/>
					<fo:instream-foreign-object content-height="2cm" content-width="2cm" scaling="uniform">
						<svg width="1000px" height="1000px" viewBox="-20 -20 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
							<desc/>
							<defs>
								<symbol id="Axes">
									<line x1="20" y1="0" x2="20" y2="101" stroke="black" stroke-width="2"/>
									<polygon points="20,-1 25,5 15,5"/>
									<text x="112" y="115">X</text>
									<line x1="20" y1="100" x2="120" y2="100" stroke="black" stroke-width="2"/>
									<polygon points="121,100 115,95 115,105"/>
									<text x="5" y="10">Y</text>
									<rect x="40" y="97.5" width="1" height="5" style="fill:black"/>
									<text x="35" y="115">10</text>
									<rect x="70" y="97.5" width="1" height="5" style="fill:black"/>
									<text x="65" y="115">20</text>
									<rect x="100" y="97.5" width="1" height="5" style="fill:black"/>
									<text x="95" y="115">30</text>
									<rect x="18.5" y="20" width="5" height="1" style="fill:black"/>
									<text x="3" y="25">10</text>
									<rect x="18.5" y="50" width="5" height="1" style="fill:black"/>
									<text x="3" y="55">20</text>
									<rect x="18" y="80" width="5" height="1" style="fill:black"/>
									<text x="3" y="85">30</text>
								</symbol>
								<linearGradient id="effetArrondiVertical" x1="0%" x2="100%" y1="20%" y2="0">
									<stop offset="0%" stop-color="#B7CA79"/>
									<stop offset="80%" stop-color="#677E52"/>
								</linearGradient>
							</defs>
							<rect x="15" y="-0.000000000000014210854715202004" width="20" height="100.00000000000001" fill="url(#effetArrondiVertical)"/>
							<circle r="2" cx="25" cy="66.66666666666666" fill="#FF5900"/>
							<line x1="25" y1="66.66666666666666" x2="55" y2="66.66666666666666" stroke="#FF5900" stroke-width="1"/>
							<rect x="45" y="66.66666666666666" width="20" height="33.333333333333336" fill="url(#effetArrondiVertical)"/>
							<circle r="2" cx="55" cy="66.66666666666666" fill="#FF5900"/>
							<line x1="55" y1="66.66666666666666" x2="85" y2="-11.111111111111128" stroke="#FF5900" stroke-width="1"/>
							<rect x="75" y="55.81239530988274" width="20" height="44.18760469011726" fill="url(#effetArrondiVertical)"/>
							<circle r="2" cx="85" cy="-11.111111111111128" fill="#FF5900"/>
							<line x1="85" y1="-11.111111111111128" x2="115" y2="0" stroke="#FF5900" stroke-width="1"/>
							<rect x="105" y="14.921273031825791" width="20" height="85.07872696817421" fill="url(#effetArrondiVertical)"/>
							<circle r="2" cx="115" cy="0" fill="#FF5900"/>
							<line x1="115" y1="0" x2="145" y2="33.33333333333333" stroke="#FF5900" stroke-width="1"/>
							<rect x="135" y="66.49916247906196" width="20" height="33.50083752093803" fill="url(#effetArrondiVertical)"/>
							<circle r="2" cx="145" cy="33.33333333333333" fill="#FF5900"/>
							<use xlink:href="#Axes" x="-15" y="0"/>
						</svg>
					</fo:instream-foreign-object>
				</fo:block>
			</fo:static-content>
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
