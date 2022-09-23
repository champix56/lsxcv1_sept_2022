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
				<fo:simple-page-master master-name="A4PortraitNoExternalBody" page-width="210mm" page-height="297mm">
					<fo:region-body/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<!--mon/ma sequence de contenu de page-->
			<xsl:call-template name="sommaire"/>
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
					 - page <fo:page-number/> / <fo:page-number-citation ref-id="end_doc"/>
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
				<xsl:if test="position()=last()">
					<fo:block id="end_doc"/>
				</xsl:if>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<xsl:template match="image">
		<fo:table-cell id="{generate-id()}">
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
	<xsl:template name="sommaire">
		<fo:page-sequence master-reference="A4PortraitNoExternalBody">
			<fo:flow flow-name="xsl-region-body">
				<fo:block>
					<fo:block text-align="center" font-size="20pt" text-decoration="underline">
						SOMMAIRE
					</fo:block>
					<fo:list-block margin-left="1cm">
						<xsl:for-each select="//page">
							<fo:list-item>
								<fo:list-item-label end-indent="label-end()">
									<fo:block>
										<fo:instream-foreign-object content-height="mm" content-width="7mm" scaling="uniform">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="-2 -2 108 108">
												<g>
													<circle r="50" cx="52" cy="52" fill="skyblue" stroke="black" stroke-width="5"/>
												</g>
											</svg>
										</fo:instream-foreign-object>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>page N° <xsl:value-of select="position()"/>
										<fo:list-block>
											<xsl:for-each select="image">
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>
															<fo:instream-foreign-object content-height="5mm" content-width="5mm" scaling="uniform">
																<svg xmlns="http://www.w3.org/2000/svg" viewBox="-2 -2 108 108">
																	<g>
																		<circle r="50" cx="52" cy="52" fill="tomato" stroke="black" stroke-width="5"/>
																	</g>
																</svg>
															</fo:instream-foreign-object>
														</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block text-decoration="underline" color="blue"><fo:basic-link internal-destination="{generate-id()}"><xsl:value-of select="@href"/></fo:basic-link></fo:block>
													</fo:list-item-body>
												</fo:list-item>
											</xsl:for-each>
										</fo:list-block>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:for-each>
					</fo:list-block>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
</xsl:stylesheet>
