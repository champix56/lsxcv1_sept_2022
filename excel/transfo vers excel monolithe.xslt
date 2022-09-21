<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<!--	<xsl:variable name="docclient" select="document('clients.xml')"/>-->
	<xsl:template match="facture">
		<Row ss:Height="16.5">
			<Cell ss:Index="2">
				<Data ss:Type="String"><xsl:value-of select="@numfacture"/></Data>
			</Cell>
			<Cell ss:StyleID="s16">
				<Data ss:Type="DateTime"><xsl:value-of select="@datefacture"/>T00:00:00.000</Data>
			</Cell>
			<Cell>
				<Data ss:Type="String">
					<xsl:variable name="idcl" select="@idclient"/>
					<!--<xsl:variable name="unClient" select="document('clients.xml')/clients/client[@id=$idcl]"/>
					<xsl:value-of select="$unClient/destinataire"/>-->
					<xsl:value-of select="$idcl"/>
				</Data>
			</Cell>
			<Cell>
				<Data ss:Type="String"><xsl:value-of select="@type"/></Data>
			</Cell>
			<Cell>
				<Data ss:Type="String"><xsl:value-of select=".//ref"/></Data>
			</Cell>
			<Cell ss:StyleID="s22">
				<Data ss:Type="Number"><xsl:value-of select="sum(.//stotligne)"/></Data>
			</Cell>
		</Row>
	</xsl:template>
	<!--<xsl:template match="facture[contains(@type,'evis')]">
		
	</xsl:template>-->
	<xsl:template match="/">
		<xsl:processing-instruction name="mso-application">progid="Excel.Sheet"</xsl:processing-instruction>
		<!--<?mso-application progid="Excel.Sheet"?>-->
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>orsys</Author>
				<LastAuthor>orsys</LastAuthor>
				<Created>2022-09-21T12:18:05Z</Created>
				<LastSaved>2022-09-21T12:30:02Z</LastSaved>
				<Version>16.00</Version>
			</DocumentProperties>
			<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
				<AllowPNG/>
			</OfficeDocumentSettings>
			<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
				<WindowHeight>7140</WindowHeight>
				<WindowWidth>24000</WindowWidth>
				<WindowTopX>0</WindowTopX>
				<WindowTopY>0</WindowTopY>
				<ProtectStructure>False</ProtectStructure>
				<ProtectWindows>False</ProtectWindows>
			</ExcelWorkbook>
			<Styles>
				<Style ss:ID="Default" ss:Name="Normal">
					<Alignment ss:Vertical="Bottom"/>
					<Borders/>
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>
					<Interior/>
					<NumberFormat/>
					<Protection/>
				</Style>
				<Style ss:ID="m1882456572692">
					<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Dash" ss:Weight="2"/>
						<Border ss:Position="Left" ss:LineStyle="Dash" ss:Weight="2"/>
						<Border ss:Position="Right" ss:LineStyle="Dash" ss:Weight="2"/>
						<Border ss:Position="Top" ss:LineStyle="Dash" ss:Weight="2"/>
					</Borders>
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FF0000"/>
					<Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>
				</Style>
				<Style ss:ID="s16">
					<NumberFormat ss:Format="Short Date"/>
				</Style>
				<Style ss:ID="s17">
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#2F75B5"/>
				</Style>
				<Style ss:ID="s18">
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#548235"/>
				</Style>
				<Style ss:ID="s19">
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#ED7D31"/>
				</Style>
				<Style ss:ID="s20">
					<Alignment ss:Vertical="Center"/>
				</Style>
				<Style ss:ID="s21">
					<Alignment ss:Vertical="Center"/>
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Color="#000000" ss:Bold="1"/>
					<NumberFormat ss:Format="#,##0.00\ &quot;€&quot;"/>
				</Style>
				<Style ss:ID="s22">
					<NumberFormat ss:Format="#,##0.00\ &quot;€&quot;"/>
				</Style>
				<Style ss:ID="s24">
					<Alignment ss:Vertical="Center"/>
					<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>
					</Borders>
				</Style>
				<Style ss:ID="s26">
					<Alignment ss:Vertical="Center"/>
					<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>
					</Borders>
					<NumberFormat ss:Format="#,##0.00\ &quot;€&quot;"/>
				</Style>
				<Style ss:ID="s27">
					<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Double" ss:Weight="3"/>
					</Borders>
				</Style>
				<Style ss:ID="s31">
					<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
				</Style>
				<Style ss:ID="s35">
					<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
					<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>
					</Borders>
					<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#000000"/>
				</Style>
			</Styles>
			<Worksheet ss:Name="Feuil1">
				<Table ss:ExpandedColumnCount="8" ss:ExpandedRowCount="{5+count(//facture)}" x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="60" ss:DefaultRowHeight="15">
					<Column ss:AutoFitWidth="0" ss:Width="9"/>
					<Column ss:Width="114.75"/>
					<Column ss:Width="100.5"/>
					<Column ss:Width="85.5"/>
					<Column ss:Width="73.5"/>
					<Column ss:Width="78"/>
					<Column ss:Width="114"/>
					<Column ss:AutoFitWidth="0" ss:Width="12.75"/>
					<Row ss:AutoFitHeight="0" ss:Height="9">
						<Cell ss:Index="3" ss:StyleID="s17">
							<Data ss:Type="String">si &gt; 100€</Data>
						</Cell>
						<Cell ss:StyleID="s18">
							<Data ss:Type="String">si &gt; 200€</Data>
						</Cell>
						<Cell ss:StyleID="s19">
							<Data ss:Type="String">si &gt; 500€</Data>
						</Cell>
					</Row>
					<Row ss:Height="15.75">
						<Cell ss:Index="2" ss:MergeAcross="5" ss:StyleID="m1882456572692">
							<Data ss:Type="String">statistique des factures</Data>
						</Cell>
					</Row>
					<Row ss:Height="24">
						<Cell ss:Index="2" ss:StyleID="s20">
							<Data ss:Type="String">Montant Total factures :</Data>
						</Cell>
						<Cell ss:StyleID="s21">
							<Data ss:Type="Number">
								<xsl:value-of select="sum(//facture[contains(@type,'acture')]//stotligne)"/>
							</Data>
						</Cell>
						<Cell ss:StyleID="s20"/>
						<Cell ss:MergeAcross="1" ss:StyleID="s31">
							<Data ss:Type="String">Montant total des devis :</Data>
						</Cell>
						<Cell ss:StyleID="s21">
							<Data ss:Type="Number">
								<xsl:value-of select="sum(//facture[contains(@type,'evis')]//stotligne)"/>
							</Data>
						</Cell>
					</Row>
					<Row ss:Height="16.5">
						<Cell ss:Index="2" ss:StyleID="s27">
							<Data ss:Type="String">Numero de facture</Data>
						</Cell>
						<Cell ss:StyleID="s27">
							<Data ss:Type="String">date de facture</Data>
						</Cell>
						<Cell ss:StyleID="s27">
							<Data ss:Type="String">destinataire client</Data>
						</Cell>
						<Cell ss:StyleID="s27">
							<Data ss:Type="String">etat de facture</Data>
						</Cell>
						<Cell ss:StyleID="s27">
							<Data ss:Type="String">refs des articles</Data>
						</Cell>
						<Cell ss:StyleID="s27">
							<Data ss:Type="String">montant total facture</Data>
						</Cell>
					</Row>
					<xsl:apply-templates select="//facture"/>
					<Row ss:Height="19.5" ss:StyleID="s20">
						<Cell ss:Index="2" ss:StyleID="s24"/>
						<Cell ss:StyleID="s24"/>
						<Cell ss:StyleID="s24"/>
						<Cell ss:MergeAcross="1" ss:StyleID="s35">
							<Data ss:Type="String">SOMME DES LIGNES</Data>
						</Cell>
						<Cell ss:StyleID="s26" ss:Formula="=SUM(R[-1]C:R[-{count(//facture)}]C)">
							<Data ss:Type="Number"><xsl:value-of select="sum(//stotligne)"/></Data>
						</Cell>
					</Row>
				</Table>
				<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
					<PageSetup>
						<Header x:Margin="0.3"/>
						<Footer x:Margin="0.3"/>
						<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
					</PageSetup>
					<Print>
						<ValidPrinterInfo/>
						<PaperSizeIndex>9</PaperSizeIndex>
						<HorizontalResolution>600</HorizontalResolution>
						<VerticalResolution>600</VerticalResolution>
					</Print>
					<Selected/>
					<Panes>
						<Pane>
							<Number>3</Number>
							<ActiveRow>12</ActiveRow>
							<ActiveCol>6</ActiveCol>
						</Pane>
					</Panes>
					<ProtectObjects>False</ProtectObjects>
					<ProtectScenarios>False</ProtectScenarios>
				</WorksheetOptions>
			</Worksheet>
		</Workbook>
	</xsl:template>
</xsl:stylesheet>
