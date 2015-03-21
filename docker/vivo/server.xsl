<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="DOC_BASE"/>

    <xsl:template match="@* | node()">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()"/>
      </xsl:copy>
   </xsl:template>

    <xsl:template match="Host">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <Context path=""
                     docBase="{$DOC_BASE}"
                     reloadable="true"
                     cookies="true" >

                <Manager pathname="" />
            </Context>
            <xsl:copy-of select="node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
