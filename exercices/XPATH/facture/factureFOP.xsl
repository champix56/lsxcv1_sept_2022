<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY euro "&#x20ac;">
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes" version="1.0" encoding="utf-8"/>
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!--formats de pages-->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4PORTRAIT" page-height="297mm" page-width="210mm">
					<fo:region-body/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<!--declaration des formats de pages-->
			<fo:page-sequence master-reference="A4PORTRAIT">
				<fo:flow flow-name="xsl-region-body">
					<!--block pour factures-->
					<fo:block>
						<!--block pour facture-->
						<fo:block>
							<!--block expediteur-->
							<fo:block>
								adr expediteur
							</fo:block>
							<!--block expediteur-->
							<!--block destinataire-->
							<fo:block>
								adr destinataire
							</fo:block>
							<!--block destinataire-->
							<!--block Numero de facture-->
							<fo:block>
								Facture N°
							</fo:block>
							<!--block numero de facture-->
							<!--Tableau de lignes-->
							<fo:table margin-left="1cm" margin-right="1cm">
								<fo:table-header>
									<fo:table-row border-bottom="0.5mm solid black">
										<fo:table-cell>
											<fo:block>Ref.</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>Designation</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>&#x20ac; / Unit.</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>Quant.</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>S-Total</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>
								<fo:table-body>
									<fo:table-row border-bottom="0.3mm solid black">
										<fo:table-cell><fo:block/></fo:table-cell>
										<fo:table-cell><fo:block/></fo:table-cell>
										<fo:table-cell><fo:block/></fo:table-cell>
										<fo:table-cell><fo:block/></fo:table-cell>
										<fo:table-cell><fo:block/></fo:table-cell>
									</fo:table-row>
									<fo:table-row border-top="0.5mm solid black">
										<fo:table-cell number-columns-spanned="2">
											<fo:block/>
										</fo:table-cell>
										<fo:table-cell number-columns-spanned="2">
											<fo:block>Total HT</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block font-weight="900">100.00&euro;</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
						<!--fin block facture-->
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
