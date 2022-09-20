<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
	<!ENTITY euro "&#x20AC;">
]>
<!--factureMedasysInclude-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes" omit-xml-declaration="no"/>

<!--redefinition du template presents dans l'include -->
	<xsl:include href="factureMedasysInclude.xsl"/>
	
<xsl:template match="clients/client">
		Un client lambda
</xsl:template>	
	
	
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<!--formats de pages-->
				<fo:simple-page-master master-name="A4Portrait" page-height="297mm" page-width="210mm">
					<fo:region-body margin-top="2cm"/>
					<fo:region-before extent="2cm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<!--definition de(des) sequence(s) de page(s)-->
			<xsl:apply-templates select="/factures/facture[position() &lt;= 3]"/>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
