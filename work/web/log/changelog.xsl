<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output cdata-section-elements="script"/>

  <xsl:template match="/">

    <html>
      <head>
        <title>Facets Changelog</title>
        <link REL='SHORTCUT ICON' HREF="../img/ruby-sm.png" />
        <style>
          td { font-family: sans-serif;  padding: 0px 10px; }
        </style>
      </head>
      <body>
      <div class="container">
        <h1>Facets ChangeLog</h1>
        <table style="width: 100%;">
          <xsl:apply-templates />
        </table>
        <br/><br/>
        <div class='copyright'>
          Copyright &#x00A9; 2001-2006 Psi Tau Corporation<br/>
          Changelog is pure XML/XSLT.<br/>
        </div>
      </div>
      </body>
    </html>

  </xsl:template>

  <xsl:template match="logentry">
      <tr>
        <td><b><pre><xsl:value-of select="msg"/></pre></b></td>
        <td><xsl:value-of select="author"/></td>
        <td><xsl:value-of select="date"/></td>
      </tr>
  </xsl:template>

</xsl:stylesheet>
