<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output cdata-section-elements="script"/>

  <xsl:template match="/">

    <html>

    <head>
      <title>Ruby Facets</title>

      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

      <!-- google verification-->
      <meta name="verify-v1" content="p14vW7GGMohDo2YKUHm0SXXTL+tzyPbKxxp35/WIQLA=" />

      <META NAME="DESCRIPTION"
            CONTENT="Ruby Facets is a large collection of libraries for the Ruby programming lanaguage."/>

      <link rel="icon" href="img/favicon.ico" type="image/x-icon" />
      <link rel="stylesheet" href="style.css" type="text/css" />

      <script src="js/rdocs.js" type="text/javascript"></script>
    </head>

    <body>

    <div id="sidebar">
    </div>

    <div id="whole">

      <div id="menu">
        <a href="index.xml">Overview</a> |
        <a href="download.xml">Download</a> |
        <a href="learn.xml">Documentation</a> |
        <a href="love.xml">Endorsements</a> |
        <a href="weblog.xml">Weblog</a> |
        <!-- <img style="width: 80px; height: 1px;" src="img/clear.gif"/> -->
        <a href="community.xml">Community</a> |
        <a href="source.xml">Source</a>
        <img style="width: 20px; height: 1px;" src="img/clear.gif"/>
      </div>

      <div id="head">
        <img id="logo" src="img/RubyFacets.png" align="middle" />
      </div>

      <!-- <div id="drop_shadow"></div> -->

      <div id="content">
        <xsl:apply-templates />
      </div>
    </div>

    <div id="copyright">
      <img src="img/abc1.png"/>

      <br/><br/><br/>

      Copyright (c) 2005-2008 Thomas Sawyer &amp; Contributors <br/><br/>

      Ruby Facets was created by Thomas Sawyer (7rans), either written by hand or
      collected from a variety of Ruby resources. The system continues
      to be extended and improved by a diverse cast of open-source contributors.<br/><br/>

      Facets is released under the terms of the Ruby license, just like Ruby.<br/>
      The Ruby license is a dual GPLv2 license.<br/><br/>

      "Facets", "Ruby Facets" and "All Base Common" are trademarks of Thomas Sawyer. All rights reserved.

      <br/><br/>

      THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
      IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
      WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
      PURPOSE.
    </div>

    <script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
    </script>
    <script type="text/javascript">
    _uacct = "UA-2883355-2";
    urchinTracker();
    </script>

    </body>
    </html>

  </xsl:template>

  <xsl:template match="content">
    <xsl:copy-of select="."/>
  </xsl:template>

</xsl:stylesheet>

