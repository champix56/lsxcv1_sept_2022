<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output media-type="xml" encoding="utf-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:param name="clientsNode" select="document('clients.xml')/clients"/>
		<xsl:element name="facturation">
			<xsl:attribute name="dateTransfert" select="current-date()"/>
				<xsl:element name="statFile">
				<xsl:element name="facturesStat">
					<xsl:element name="avgNbUnitFacture">
						<xsl:attribute name="refproduits" select="//ligne[contains(upper-case( parent::lignes/parent::facture/@type),'FACTURE')]/ref" separator=";"/>
						<xsl:value-of select="avg(//ligne[contains(upper-case( parent::lignes/parent::facture/@type),'FACTURE')]/nbUnit)"/>
					</xsl:element>
				
					<xsl:element name="ligneAvgFact">
						<xsl:value-of select="avg(//ligne[contains(upper-case( parent::lignes/parent::facture/@type),'FACTURE')]/stotligne)"/>
					</xsl:element>
					<xsl:element name="nbLignesFact">
						<xsl:value-of select="count(//ligne[contains(upper-case( parent::lignes/parent::facture/@type),'FACTURE')])"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
	<xsl:element name="factures">
				<xsl:for-each select="factures/facture">
					<xsl:if test="contains( upper-case(@type) , 'FACTURE') ">
						<xsl:element name="facture">
							<xsl:attribute name="idfacture" select="@numfacture"/>
							<xsl:variable name="idclfact" select="@idclient"/>
							<xsl:attribute name="nomClient" select=" $clientsNode/client[@id=$idclfact]/destinataire"/>
							<xsl:element name="prixAvgArticle">
								<xsl:attribute name="refproduits" select="lignes/ligne/ref" separator=";"/>
								<xsl:value-of select="avg(lignes/ligne/nbUnit)"/>
							</xsl:element>
							<xsl:element name="ligneAvg">
								<xsl:value-of select="avg(lignes/ligne/stotligne)"/>
							</xsl:element>
							<xsl:element name="nbLignes">
								<xsl:value-of select="count(lignes/ligne)"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
			</xsl:element>
			</xsl:element>
	</xsl:template>
</xsl:stylesheet>
