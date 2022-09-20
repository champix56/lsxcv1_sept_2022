<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4_PORTRAIT" page-width="210mm" page-height="297mm">
					<xsl:choose>
						<xsl:when test="photos/@theme">
							<fo:region-body background-image="{photos/@theme}" background-repeat="no-repeat" margin-bottom="7mm"/>
						</xsl:when>
						<xsl:otherwise>
							<fo:region-body/>
						</xsl:otherwise>
					</xsl:choose>
					<fo:region-before extent="50mm"/>
					<fo:region-after extent="7mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4_PORTRAITINTER" page-width="210mm" page-height="297mm">
					<xsl:choose>
						<xsl:when test="photos/@theme">
							<fo:region-body background-image="{photos/@theme}" background-repeat="no-repeat"/>
						</xsl:when>
						<xsl:otherwise>
							<fo:region-body/>
						</xsl:otherwise>
					</xsl:choose>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<xsl:if test="photos/couv">
				<fo:page-sequence master-reference="A4_PORTRAITINTER">
					<fo:flow flow-name="xsl-region-body">
						<fo:block text-align="center" margin-top="75mm">
							<fo:external-graphic scaling="uniform" src="{concat(photos/couv/image/@path,photos/couv/image/@href)}" content-height="120mm" content-width="120mm"/>
							<fo:block color="RED" font-size="60pt" text-align="center">
								<xsl:value-of select="/photos/titre"/>
							</fo:block>
						</fo:block>
					</fo:flow>
				</fo:page-sequence>
			</xsl:if>
			<xsl:if test="photos/@intercal and photos/photos/@intercal = 'true'">
				<fo:page-sequence master-reference="A4_PORTRAITINTER">
					<fo:flow flow-name="xsl-region-body">
						<fo:block text-align="center">
						 
					</fo:block>
					</fo:flow>
				</fo:page-sequence>
				<fo:page-sequence master-reference="A4_PORTRAITINTER">
					<fo:flow flow-name="xsl-region-body">
						<fo:block text-align="center">
						 
					
					</fo:block>
					</fo:flow>
				</fo:page-sequence>
			</xsl:if>
			<xsl:for-each select="photos/pages/page">
				<fo:page-sequence master-reference="A4_PORTRAIT">
					<fo:static-content flow-name="xsl-region-after">
						<fo:block color="BLUE" text-align="center" margin-bottom="20mm">
							<fo:basic-link external-destination="mailto:desorbaix@free.fr">desorbaix@free.fr - page <fo:page-number/>
							</fo:basic-link>
						</fo:block>
					</fo:static-content>
					<fo:flow flow-name="xsl-region-body">
						<xsl:choose>
							<xsl:when test="/photos/pages/@titre='true'">
								<fo:block color="RED" font-size="80pt" text-align="center">
									<xsl:value-of select="/photos/titre"/>
								</fo:block>
								<fo:block margin-left="4mm" margin-top="10mm">
									<xsl:apply-templates select="."/>
								</fo:block>
							</xsl:when>
							<xsl:otherwise>
								<fo:block margin-left="4mm" margin-top="30mm">
									<xsl:apply-templates select="."/>
								</fo:block>
							</xsl:otherwise>
						</xsl:choose>
					</fo:flow>
				</fo:page-sequence>
			</xsl:for-each>
		</fo:root>
	</xsl:template>
	<xsl:template match="/photos/pages/page">
		<fo:table width="20cm">
			<fo:table-body>
				<fo:table-row height="110mm">
					<fo:table-cell width="100mm">
						<fo:block text-align="center">
							<fo:external-graphic scaling="uniform" src="{concat(image[1]/@path,image[1]/@href)}" content-height="97mm" content-width="97mm"/>
							<xsl:if test="/photos/@OnlyComment = 'false'">
								<fo:block>
									<xsl:value-of select="image[1]/@href"/>
								</fo:block>
							</xsl:if>
							<fo:block>
								<xsl:value-of select="image[1]/text()"/>
							</fo:block>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell width="100mm">
						<fo:block text-align="center">
							<fo:external-graphic scaling="uniform" src="{concat(image[2]/@path,image[2]/@href)}" content-height="97mm" content-width="97mm"/>
							<xsl:if test="/photos/@OnlyComment = 'false'">
								<fo:block>
									<xsl:value-of select="image[2]/@href"/>
								</fo:block>
							</xsl:if>
							<fo:block>
								<xsl:value-of select="image[2]/text()"/>
							</fo:block>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row height="110mm">
					<fo:table-cell width="100mm">
						<fo:block text-align="center">
							<fo:external-graphic scaling="uniform" src="{concat(image[3]/@path,image[3]/@href)}" content-height="97mm" content-width="97mm"/>
							<xsl:if test="/photos/@OnlyComment = 'false'">
								<fo:block>
									<xsl:value-of select="image[3]/@href"/>
								</fo:block>
							</xsl:if>
							<fo:block>
								<xsl:value-of select="image[3]/text()"/>
							</fo:block>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell width="100mm">
						<fo:block text-align="center">
							<fo:external-graphic src="{concat(image[4]/@path,image[4]/@href)}" content-height="97mm" content-width="97mm"/>
							<xsl:if test="/photos/@OnlyComment = 'false'">
								<fo:block>
									<xsl:value-of select="image[4]/@href"/>
								</fo:block>
							</xsl:if>
							<fo:block>
								<xsl:value-of select="image[4]/text()"/>
							</fo:block>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
</xsl:stylesheet>