<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes" version="1.0"/>
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!--def. formats de papiers-->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4Portrait" page-width="210mm" page-height="297mm">
					<fo:region-body background-image="file:///{photos/@theme}" margin-bottom="5mm"/>
					<fo:region-after extent="5mm"/>
					<!--<fo:region-before extent="2cm"/>-->
				</fo:simple-page-master>
			</fo:layout-master-set>
			<!--mon/ma sequence de contenu de page-->
			<xsl:apply-templates select="//page"/>
		</fo:root>
	</xsl:template>
	<xsl:template match="page">
		<fo:page-sequence master-reference="A4Portrait">
			<fo:static-content flow-name="xsl-region-after">
				<fo:block text-align="center">
					<fo:inline color="blue" text-decoration="underline">
						<fo:basic-link external-destination="mailto:{/photos/signature}">
							<xsl:value-of select="/photos/signature"/>
						</fo:basic-link>
					</fo:inline>
				</fo:block>
			</fo:static-content>
			<fo:flow flow-name="xsl-region-body">
				<fo:block text-align="center">
					<xsl:if test="parent::pages/@titre='true'">
						<fo:block text-align="center" font-weight="700" font-size="24pt" color="tomato" border-bottom="0.5mm solid grey" margin-left="10mm" margin-right="10mm" margin-bottom="5mm">
							<xsl:value-of select="/photos/titre"/>
						</fo:block>
					</xsl:if>
					<fo:table width="100%">
						<fo:table-column column-width="50%"/>
						<fo:table-column column-width="50%"/>
						<fo:table-body>
							<fo:table-row height="110mm">
								<xsl:apply-templates select="image[position()&lt;=2]"/>
							</fo:table-row>
							<xsl:if test="count(image)>2">
								<fo:table-row height="110mm">
									<xsl:apply-templates select="image[position()&gt;2]"/>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<xsl:template match="image">
		<fo:table-cell>
			<fo:block text-align="center" margin-top="5mm">
				<fo:external-graphic src="file:///{concat(@path,@href)}" scaling="uniform" content-height="97mm" content-width="97mm"/>
				<fo:block/>
				<xsl:value-of select="."/>
				<xsl:if test="/photos/@OnlyComment='false'">
					<fo:block/>
					<xsl:value-of select="@href"/>
				</xsl:if>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
</xsl:stylesheet>
