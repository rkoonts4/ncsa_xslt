<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="urn:isbn:1-931666-22-9"
    exclude-result-prefixes="xsi xlink"
    version="2">
    
    <!-- conversions for none standard characters created during Axaem import/export -->
    <xsl:include href="characters.xsl"/>
    
    <!-- stylesheet containing addresses for the repositories -->
    <xsl:include href="address.xsl"/>
    
    <xsl:output method="xhtml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" use-character-maps="no-control-characters" omit-xml-declaration="yes"/>
    <!-- setting collection and box id variables to be called later in stylesheet -->
    
    <xsl:variable name="coll_id" select="ead/eadheader/eadid"/>
    <xsl:variable name="box_id" select="ead/archdesc/did"/>
    <xsl:variable name="county_no" select="substring-after(ead/eadheader/eadid,'CR.')"/>
    <xsl:variable name="cno" select="concat($county_no,'.')"/>
    
   <!-- external control file to normalize labels across collections -->
    <xsl:variable name="LOOKUP" select="document('../build/includes/labels.xml', /)"/>
    
    <!-- Jeremy's original code.  If above doesn't work, delete and uncomment these lines.
        Change the following select attribute to the domain (path) your xslt folder is located-->
    <xsl:variable name="DOMAIN" select="'https://axaem.archives.ncdcr.gov'"></xsl:variable>
    <xsl:variable name="JS" select="concat($DOMAIN,'/findingaids/state_archives/js')"></xsl:variable>
    <xsl:variable name="STYLE" select="concat($DOMAIN,'/findingaids/state_archives/style')"></xsl:variable>
    <xsl:variable name="FONT" select="concat($DOMAIN,'/findingaids/state_archives/font')"></xsl:variable>
    <xsl:variable name="IMG" select="concat($DOMAIN,'/findingaids/state_archives/img')"></xsl:variable>
	<!--<xsl:variable name="Labels">
        <xsl:value-of select="concat($DOMAIN, '/build/includes/labels.xml')"/>
    </xsl:variable>
        <xsl:variable name="LOOKUP" select="document($Labels, /)"></xsl:variable>
    -->
    
    <!-- title variable -->
    <xsl:variable name="local_title">
        <xsl:for-each select="//titlestmt/titleproper">
            <xsl:value-of select="text()"/><xsl:text>, </xsl:text><xsl:value-of select="child::num"/>
        </xsl:for-each>
    </xsl:variable>
    <xsl:template match="/">
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
                <meta name="author" content="{normalize-space(/ead/archdesc/did/repository)}"></meta>
                <meta name="description" content="{/ead/archdesc/did/abstract}"></meta>
                
                <xsl:comment>XSL Stylesheet Version: SANC_2.2</xsl:comment>       
                <xsl:comment>CSS Version: SANC_1.2</xsl:comment>
                <!-- keep these
                <link href="{$DOMAIN}/build/css/sanc_v_1_2.css" rel="stylesheet"></link>
                <link href="{$DOMAIN}/build/css/normalize.css" rel="stylesheet"></link>
                -->
                <!-- delete these -->
                <link href="{$STYLE}/sanc_v_1_2.css" rel="stylesheet"></link>
                <link href="{$STYLE}/normalize.css" rel="stylesheet"></link>
                <link href="{$STYLE}/find_aid.css" rel="stylesheet"></link>
                <link href="{$STYLE}/findingaids-grid-1200.css" rel="stylesheet"></link>
                <!-- XSL GEN TITLE -->
                <title><xsl:value-of select="$local_title" /></title>
                
                <!--[if lt IE 9]>
                <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
                <![endif]-->
                
                <!-- jQuery (necessary for Bootstrap's JavaScript plugins) 
                <script src="{$DOMAIN}/build/js/jquery-2.1.1.min.js"></script> -->
                <!-- keep above delete below -->
                <script src="{$JS}/jquery-2.1.1.min.js"></script>
            </head>
            <body>
                <xsl:call-template name="nav_bar"/>
                <h3><xsl:value-of select="$local_title"/></h3>
                <div id="bodyWrapper">
                    <div class="container_16" id="wholePage">
                        <div class="grid_16" id="wrapper">
                            <div id="mainContent" class="grid_12 alpha maincontent">
                                <span class="menuLink dontPrint"><a href="#menu" class="button">Menu</a></span>
                                <h1 class="mainTitle" property="schema:name"><xsl:value-of select="$local_title"/></h1>
                                <xsl:if test="//abstract">
                                    <div class="abstract">
                                        <h2 class="mainheading">
                                            <a name="abstract" class="anchor"/>
                                            Abstract</h2>
                                        <div id="{generate-id()}" class="section" property="schema:description" style="display: block;">
                                            <xsl:apply-templates select="//archdesc/did/abstract"/>
                                        </div>
                                    </div>
                                </xsl:if>
                                <div class="grid_6 alpha">
                                    <xsl:call-template name="DS"/>
                                </div>
                                <a name="series" class="anchor"></a>
                                <div class="grid_6 omega">
                                    <xsl:call-template name="SQL"/>
                                </div>
                                <div class="clear"></div>
                                <xsl:if test="//accessrestrict">
                                    <xsl:call-template name="RoA"/>
                                </xsl:if>
                                <xsl:if test="//prefercite">
                                    <xsl:call-template name="PC"/>                                    
                                </xsl:if>
                                <xsl:call-template name="CO"/>
                                <xsl:call-template name="AN"/>
                                <xsl:if test="//bioghist">
                                    <xsl:call-template name="HN"/>                                    
                                </xsl:if>
                                <div class="clear"></div>
                                <xsl:call-template name="CC"/>
                                <div class="clear"></div>
                                <xsl:call-template name="SH"/>
                                <xsl:if test="//acqinfo">
                                    <xsl:call-template name="AQ"/>
                                </xsl:if>
                                <xsl:if test="//processinfo">
                                    <xsl:call-template name="PI"/>                  
                                </xsl:if>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="{$JS}/bootstrap.min.js"></script>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="nav_bar">
        <div id="navigation">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                    </button>
                    <xsl:for-each select="ead/archdesc/did/repository">
                        <xsl:variable name="location" select="corpname"/>
                        <xsl:choose>
                            <xsl:when test="starts-with($location,'State')">
                                <xsl:call-template name="ncsa"/>
                            </xsl:when>
                            <xsl:when test="starts-with($location,'West')">
                                <xsl:call-template name="wra"/>
                            </xsl:when>
                            <xsl:when test="starts-with($location,'Outer')">
                                <xsl:call-template name="obhc"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </div>
                
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="#">Top of Page</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Finding Aid Sections<span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu"><xsl:call-template name="menu"/></ul>
                        </li>
                    </ul>
                    <xsl:if test="//c02">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <!-- If Search URL changes, update here -->
                                <a href="https://axaem.archives.ncdcr.gov/solr/axaem/Series">New Search</a>
                            </li>
                        </ul>
                    </xsl:if>
                </div>
            </div>
        </nav>
        </div>
    </xsl:template>
    
 
    <xsl:template name="menu">
        <xsl:if test="//abstract">
            <li><a href="#abstract">Abstract</a></li>
        </xsl:if>
        <li><a href="#sql">Series Quick Links</a></li>
        <li><a href="#collectionoverview">Collection Overview</a></li>
        <xsl:if test="//archdesc/arrangement">
            <li><a href="#arrangementnote">Arrangement Note</a></li>
        </xsl:if>
        <xsl:if test="//archdesc/userestrict">
            <li><a href="#restrictions">Restrictions on Access &amp; Use</a></li>		
        </xsl:if>
        <xsl:if test="//archdesc/prefercite">
            <li><a href="#preferredcitation">Preferred Citation</a></li>		
        </xsl:if>
        <li><a href="#contents">Contents of the Collection</a></li>
        <xsl:for-each select="//archdesc/bioghist">
            <xsl:choose>
                <xsl:when test="contains(head,'His')">
                    <li><a href="#historical">Historical Note</a></li>
                </xsl:when>
                <xsl:when test="contains(head,'Bio')">
                    <li><a href="#biographical">Biographical Note</a></li>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
        <li><a href="#subjectheadings">Subject Headings</a></li>
        <xsl:if test="//archdesc/acqinfo">
            <li><a href="#acquisitioninfo">Acquisitons Information</a></li>
        </xsl:if>
      </xsl:template>
    
    <xsl:template match="abstract">
        <p dir="auto"><xsl:apply-templates/></p>  
    </xsl:template>
    
    <!-- Descriptive Summary block of finding aid, left side -->
    <xsl:template name="DS">
        <xsl:for-each select="//archdesc/did">
            <h2 id="descriptivesummary" class="mainheading">Descriptive Summary</h2>
            <div id="{generate-id()}" class="section showhide" style="display: block;">
                <dl>
                    <dt>Title</dt>
                    <dd><xsl:value-of select="unittitle"/></dd>
                    <dt>Call Number</dt>
                    <dd><xsl:value-of select="unitid[1]"/></dd>
                    <dt>Creator</dt>
                    <dd property="schema:creator"><xsl:value-of select="origination[@label='creator']"/></dd>
                    <xsl:if test="unitdate">
                        <dt>Date</dt>
                        <dd><xsl:value-of select="unitdate"/></dd>
                    </xsl:if>
                    <xsl:if test="physdesc/extent">
                    <dt>Extent</dt>
                    <xsl:for-each select="physdesc">
                        <xsl:choose>
                            <xsl:when test="child::extent/attribute::label='Estimated Extent'">
                                <dd>
                                    <xsl:for-each select="extent">
                                        <xsl:value-of select="."/><xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                                        <xsl:if test="following-sibling::extent">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each>
                                </dd>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>		
                    </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="langmaterial">
                        <dt>Language</dt>
                        <dd><xsl:value-of select="langmaterial"/></dd>                      
                    </xsl:if>
                     <dt>Repository</dt>
                    <dd><xsl:value-of select="repository"/></dd>
                </dl>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="SQL">
 
         <a name="sql" class="anchor"/>
        <h2 class="mainheading">Series Quick Links</h2>

        <div id="{generate-id()}" class="section showhide" style="display: block;">
            <ol>
                <xsl:call-template name="SeriesLink"/>
            </ol>
        </div>
            
    </xsl:template>

    <xsl:template name="SeriesLink">
        <xsl:for-each select="//c01[1]">
            <xsl:choose>
                <xsl:when test="@level='series'">
                    <xsl:call-template name="SL_series"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="SL_no_series"/>                 
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="SL_series">
        <xsl:for-each select="//c01">
            <li><a href="#c01_{position()}"><xsl:value-of select="did/unittitle"/>
                <xsl:if test="did/unitdate">
                    <xsl:if test="ends-with(did/unittitle,',')"> </xsl:if>
                    <xsl:if test="not(ends-with(did/unittitle,','))">, </xsl:if>
                    <xsl:value-of select="did/unitdate"/>
                </xsl:if>
            </a></li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="SL_no_series">
        <li><a name="#contents" class="anchor"/>Collection Contents</li>
        
    </xsl:template>
    
    <!-- Restrictions on Access -->
    <xsl:template name="RoA">
        <xsl:if test="//archdesc/accessrestrict">
            <a name="restrictions" class="anchor"/>
            <h2 class="mainheading">
                Restrictions on Access &amp; Use</h2>
            <div id="{generate-id()}" class="section showhide" style="display: block;">
                <div class="grid_6 alpha">
                    <h3>Access Restrictions</h3>
                    <div>
                        <xsl:for-each select="//archdesc/accessrestrict/p">
                            <p dir="auto"><xsl:apply-templates/></p> 
                        </xsl:for-each>
                    </div>
                </div>
                <div class="grid_6 omega" id="userestrict">
                    <h3>Use Restrictions</h3>
                    <div>
                        <xsl:for-each select="//archdesc/userestrict/p">
                            <p dir="auto"><xsl:apply-templates/></p>
                        </xsl:for-each>
                    </div>
                </div>
            </div> 
        </xsl:if>
    </xsl:template>
    
    <!-- Collection Overview -->
    <xsl:template name="CO">
        <xsl:for-each select="//archdesc/scopecontent[1]">
            <xsl:choose>
                <xsl:when test="p">
                    <a name="collectionoverview" class="anchor"/>
                    <h2 class="mainheading">
                        Collection Overview</h2>
                    <div id="{generate-id()}" class="section showhide" style="display: block;">
                        <xsl:for-each select="//archdesc/scopecontent/p">
                            <p dir="auto"><xsl:apply-templates/></p>
                        </xsl:for-each>
                    </div> 
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Arragement -->
    <xsl:template name="AN">
        <xsl:for-each select="//archdesc/arrangement[1]">
            <xsl:choose>
                <xsl:when test="p">
                    <a name="arrangementnote" class="anchor"/>
                    <h2 class="mainheading">Arrangement Note</h2>
                    <div id="{generate-id()}" class="section showhide" style="display: block;">
                        <xsl:for-each select="//archdesc/arrangement/p">
                            <p dir="auto"><xsl:apply-templates/></p>
                        </xsl:for-each>
                    </div> 
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Prefered Citation -->
    <xsl:template name="PC">
        <xsl:for-each select="//archdesc/prefercite">
            <xsl:choose>
                <xsl:when test="p">
                    <a name="preferredcitation" class="anchor"/>
                    <h2 class="mainheading">Preferred Citation</h2>
                    <div id="{generate-id()}" class="section showhide" style="display: block;">
                        <xsl:for-each select="//archdesc/prefercite/p">
                            <p dir="auto"><xsl:apply-templates/></p>
                        </xsl:for-each>
                    </div> 
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Biographical/Historical -->
    <xsl:template name="HN">
        <xsl:for-each select="//archdesc/bioghist">
            <xsl:choose>
                <xsl:when test="contains(head,'His')">
                    <a name="historical" class="anchor"/>
                </xsl:when>
                <xsl:when test="contains(head,'Bio')">
                    <a name="biographical" class="anchor"/>
                </xsl:when>
            </xsl:choose>
            <h2 class="mainheading"><xsl:value-of select="head"/></h2>
            <div id="{generate-id()}" class="section showhide" style="display: block;">
                <xsl:for-each select="child::*">
                    <xsl:choose>
                        <xsl:when test="name() = 'head'"/>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Subject Headings -->
    <xsl:template name="SH">
        <xsl:for-each select="//archdesc/controlaccess">
            <a name="subjectheadings" class="anchor"/>
            <h2 class="mainheading">
                Subject Headings</h2>
            <div id="{generate-id()}" class="section showhide" style="display: block;">
                <xsl:for-each select="controlaccess/child::*">
                    <li><xsl:value-of select="."/></li> 
                </xsl:for-each>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Acquisition Information -->
    <xsl:template name="AQ">
        <xsl:for-each select="//archdesc/acqinfo[1]">
            <a name="acquisitioninfo" class="anchor"/>
            <h2 class="mainheading">
                Acquisitions Information</h2>
                <div id="{generate-id()}" class="section showhide" style="display: block;"><p dir="auto"><xsl:value-of select="p"/><xsl:if test="following-sibling::acqinfo">, <xsl:value-of select="following-sibling::acqinfo/p"/></xsl:if></p></div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Processing Information -->
    
    <xsl:template name="PI">
        <h2 class="mainheading">Processing Information</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
            <xsl:for-each select="//archdesc/processinfo/p">
                <li><xsl:apply-templates/></li>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <!-- Collection Content area -->
    
    <xsl:template name="CC">
        <a name="contents" class="anchor"/>
        <h2 class="mainheading">Contents of the Collection</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
            <xsl:call-template name="contents"/>
        </div>
    </xsl:template>
    

    
    <xsl:template name="contents">
        <xsl:for-each select="//c01[1]">
            <xsl:choose>
               <xsl:when test="@level='series'">
                    <xsl:call-template name="series"/>
               </xsl:when> 
                <xsl:otherwise>
                    <a name="contents" class="anchor"/>
                    <strong>Collection Contents</strong>
                    <xsl:call-template name="contents_ns"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Content creation for Collections without series -->
    <xsl:template name="contents_ns">
        <a name="photos" class="anchor"/>
        <xsl:for-each select="//c01">
            <xsl:if test="position() mod 2 = 0">
                <xsl:call-template name="even_ns"/>
            </xsl:if>
            <xsl:if test="position() mod 2 != 0">
                <xsl:call-template name="odd_ns"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="odd_ns">
        <div id="{@id}" class="c_row {name()} {name()}_row grid_12 alpha fa_odd">
            <a class="row-option sharing-link tipTip" href="#{@id}" title="Link to this row"></a>
            <div class='component_info'>
                <div class='component_title'>
                    <span><xsl:value-of select="did/unittitle"/><xsl:if test="did/unitdate"><xsl:if test="ends-with(did/unittitle,',')"> </xsl:if><xsl:if test="not(ends-with(did/unittitle,','))">, </xsl:if><xsl:value-of select="did/unitdate[1]"/></xsl:if></span>
                </div>
            </div>
            <xsl:call-template name="ns_containers"/>
            <xsl:if test="scopecontent">
                <div>
                    <xsl:apply-templates select="scopecontent"/>
                </div> 
            </xsl:if>
        </div>
        <div class="clear"></div>
    </xsl:template>
    
    <xsl:template name="even_ns">
        <div id="{@id}" class="c_row {name()} {name()}_row grid_12 alpha">
            <a class="row-option sharing-link tipTip" href="#{@id}" title="Link to this row"></a>
            <div class='component_info'>
                <div class='component_title'>
                    <span><xsl:value-of select="did/unittitle"/><xsl:if test="did/unitdate"><xsl:if test="ends-with(did/unittitle,',')"> </xsl:if><xsl:if test="not(ends-with(did/unittitle,','))">, </xsl:if><xsl:value-of select="did/unitdate[1]"/></xsl:if></span>
                </div>
            </div>
            <xsl:call-template name="ns_containers"/>
            <xsl:if test="scopecontent">
                <div>
                    <xsl:apply-templates select="scopecontent"/>
                </div> 
            </xsl:if>
        </div>
        <div class="clear"></div>
    </xsl:template>
    
    <xsl:template name="ns_containers">
        <xsl:for-each select="did/unitid">
            <xsl:choose>
                <xsl:when test="following-sibling::container">
                    <div class="faid_containers">
                        <span class="container_item box"><xsl:value-of select="following-sibling::container"/></span> 
                    </div>  
                </xsl:when>
                <xsl:otherwise>
                    <div class="faid_containers">
                        <span class="container_item box"><xsl:value-of select="."/></span> 
                    </div>  
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Content creation for Collections with Series -->
    <xsl:template name="series">
        <xsl:for-each select="//c01">
            <a name="c01_{position()}" class="anchor"></a>
        <h2 class="mainheading">
            <strong><xsl:value-of select="position()"/><xsl:text>. </xsl:text></strong> <xsl:value-of select="did/unittitle"/>
            <xsl:if test="did/unitdate"><xsl:if test="ends-with(did/unittitle,',')"> </xsl:if><xsl:if test="not(ends-with(did/unittitle,','))">, </xsl:if><xsl:value-of select="did/unitdate"/></xsl:if>
        </h2>
            <div id="{generate-id()}" class="section sectionSubSeries showhide" style="display: block;">
                <div class="title c01 c01_title_row">
                    <xsl:if test="scopecontent">
                        <p dir="auto"><b><xsl:value-of select="scopecontent/head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="scopecontent/p"/></p>
                    </xsl:if>
                    <xsl:if test="arrangement">
                        <p dir="auto"><b><xsl:value-of select="arrangement/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="arrangement/p"/></p>
                    </xsl:if>
                    <xsl:if test="accessrestrict">
                        <p dir="auto"><b><xsl:value-of select="accessrestrict/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="accessrestrict/p"/></p>
                    </xsl:if>
                    <xsl:if test="processinfo">
                        <p dir="auto"><b><xsl:value-of select="processinfo/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="processinfo/p"/></p>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="not(did/container)"/>
                        <xsl:otherwise>
                            <xsl:if test="not(did/container/@parent)">
                                <xsl:call-template name="cr_containers"/>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:for-each select="descendant::c02|descendant::c03|descendant::c04|descendant::c05|descendant::c06|descendant::c07|descendant::c08">
                        <!-- remove this outter choose statement once microfilm is included in the finding aids -->
                        <xsl:choose>
                            <xsl:when test="did/unitid[contains(@label,'CMicro')]"/>
                            <xsl:otherwise>
                            <xsl:choose>                           
                            <xsl:when test="@level='subseries' or @level='subgrp' or @level='series'">
                                <div class="section sectionSubSeries">
                                    <div class="title {name()} {name()}_title_row">
                                        <h3><span><xsl:value-of select="did/unittitle"/><xsl:if test="did/unitdate"><xsl:if test="ends-with(did/unittitle,',')"> </xsl:if><xsl:if test="not(ends-with(did/unittitle,','))">, </xsl:if><xsl:value-of select="did/unitdate"/></xsl:if></span></h3>
                                        <xsl:if test="scopecontent">
                                            <p dir="auto"><b><xsl:value-of select="scopecontent/head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="scopecontent/p"/></p>
                                        </xsl:if>
                                        <xsl:if test="arrangement">
                                            <p dir="auto"><b><xsl:value-of select="arrangement/head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="arrangement/p"/></p>
                                        </xsl:if>
                                        <xsl:if test="accessrestrict">
                                            <p dir="auto"><b><xsl:value-of select="accessrestrict/head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="accessrestrict/p"/></p>
                                        </xsl:if>
                                        <xsl:if test="processinfo">
                                            <p dir="auto"><b><xsl:value-of select="processinfo/head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="processinfo/p"/></p>
                                        </xsl:if>
                                        <xsl:choose>
                                            <xsl:when test="not(did/container)"/>
                                            <xsl:otherwise>
                                                <xsl:call-template name="cr_containers"/>                                       
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                </div>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="position() mod 2 = 0">
                                    <xsl:call-template name="even"/>
                                </xsl:if>
                                <xsl:if test="position() mod 2 != 0">
                                    <xsl:call-template name="odd"/>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="odd">
        <div id="{@id}" class="c_row {name()} {name()}_row grid_12 alpha fa_odd">
            <a class="row-option sharing-link tipTip" href="#{@id}" title="Link to this row"></a>
            <div class='component_info'>
                <div class='component_title'>
                    <span><xsl:value-of select="did/unittitle"/><xsl:if test="did/unitdate"><xsl:if test="ends-with(did/unittitle,',')"> </xsl:if><xsl:if test="not(ends-with(did/unittitle,','))">, </xsl:if><xsl:value-of select="did/unitdate[1]"/></xsl:if></span>
                    <xsl:if test="accessrestrict">
                        <p dir="auto"><b><xsl:value-of select="accessrestrict/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="accessrestrict/p"/></p>
                    </xsl:if>
                    <xsl:if test="processinfo">
                        <p dir="auto"><b><xsl:value-of select="processinfo/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="processinfo/p"/></p>
                    </xsl:if>
                    <xsl:if test="scopecontent">
                        <p dir="auto"><b><xsl:value-of select="scopecontent/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="scopecontent/p"/></p>
                    </xsl:if>
                </div>
            </div>
            <xsl:call-template name="sa_containers"/>
        </div>
        <div class="clear"></div>
    </xsl:template>
    
    <xsl:template name="even">
        <div id="{@id}" class="c_row {name()} {name()}_row grid_12 alpha">
            <a class="row-option sharing-link tipTip" href="#{@id}" title="Link to this row"></a>
            <div class='component_info'>
                <div class='component_title'>
                    <span><xsl:value-of select="did/unittitle"/><xsl:if test="did/unitdate"><xsl:if test="ends-with(did/unittitle,',')"> </xsl:if><xsl:if test="not(ends-with(did/unittitle,','))">, </xsl:if><xsl:value-of select="did/unitdate[1]"/></xsl:if></span>
                    <xsl:if test="accessrestrict">
                        <p dir="auto"><b><xsl:value-of select="accessrestrict/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="accessrestrict/p"/></p>
                    </xsl:if>
                    <xsl:if test="processinfo">
                        <p dir="auto"><b><xsl:value-of select="processinfo/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="processinfo/p"/></p>
                    </xsl:if>
                    <xsl:if test="scopecontent">
                        <p dir="auto"><b><xsl:value-of select="scopecontent/head"/><xsl:text>: </xsl:text></b>
                            <xsl:apply-templates select="scopecontent/p"/></p>
                    </xsl:if>
                </div>
            </div>
            <xsl:call-template name="sa_containers"/>
        </div>
        <div class="clear"></div>
    </xsl:template>
    <!-- State Agency containers -->
    <xsl:template name="sa_containers">
        <xsl:choose>
            <xsl:when test="did/container">
                <xsl:variable name="parent" select="did/container/@parent"/>
                <div class="faid_containers">
                    <xsl:choose>
                        <xsl:when test="not($parent)">
                            <span class="container_item box"><xsl:value-of select="did/container/@type"/><xsl:text> </xsl:text><xsl:value-of select="did/container"/></span> 
                        </xsl:when>
                        <xsl:otherwise>      
                            <xsl:variable name="box_num">
                                <xsl:for-each select="/ead/archdesc/did/container">
                                    <xsl:if test="@id = $parent">
                                        <xsl:value-of select="@label"/>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="contains($box_num,'Box')">
                                    <span class="container_item box"><xsl:value-of select="$box_num"/></span> 
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="container_item box">Box <xsl:value-of select="$box_num"/></span> 
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>  
            </xsl:when> 
            <xsl:when test="not(did/container)">
                <span class="container_item box"><xsl:value-of select="did/unitid[@type='local ID']"/></span> 
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- County Records containers -->
    
    <xsl:template name="cr_containers">
        <xsl:variable name="cr" select="count(did/container[starts-with(@label,'CR')])"/>
        <xsl:variable name="T" select="count(did/container[starts-with(@label,'T')])"/>
        <xsl:variable name="reel" select="count(did/container[starts-with(@label,$county_no)])"/>
        <xsl:choose>
            <xsl:when test="$county_no = ''"/>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$cr >= 1">
                        <div class="faid_containers">
                            <b> <xsl:value-of select="$cr"/> Box(es)</b>
                            <span class="container_item box fa_odd">
                                <xsl:for-each select="did/container[starts-with(@label,'CR')]">
                                    <xsl:if test="position() = 1">
                                        <xsl:value-of select="@label"/>
                                    </xsl:if>
                                    <xsl:if test="$cr > 1">
                                        <xsl:if test="position() = last()">
                                            -  <xsl:value-of select="@label"/>
                                        </xsl:if>
                                    </xsl:if>
                                </xsl:for-each>
                            </span>
                        </div>
                    </xsl:when>
                    <xsl:when test="$T >= 1">
                        <div class="faid_containers">
                            <b> <xsl:value-of select="$T"/> Unprocessed Box(es)</b>
                            <span class="container_item box fa_odd">
                                <xsl:for-each select="did/container[starts-with(@label,'T')]">
                                    <xsl:if test="position() = 1">
                                        <xsl:value-of select="@label"/>
                                    </xsl:if>
                                    <xsl:if test="$T > 1">
                                        <xsl:if test="position() = last()">
                                            -  <xsl:value-of select="@label"/>
                                        </xsl:if>
                                    </xsl:if>
                                </xsl:for-each>
                            </span>
                        </div>
                    </xsl:when>
                    <xsl:when test="$reel >= 1">
                        <div class="faid_containers">
                            <b> <xsl:value-of select="$reel"/> Reel(s)</b>
                            <span class="container_item box fa_odd">
                                <xsl:for-each select="did/container[starts-with(@label,$county_no)]">
                                    <xsl:if test="position() = 1">
                                        <xsl:value-of select="@label"/>
                                    </xsl:if>
                                    <xsl:if test="$reel > 1">
                                        <xsl:if test="position() = last()">
                                            -  <xsl:value-of select="@label"/>
                                        </xsl:if>
                                    </xsl:if>
                                </xsl:for-each>
                            </span>
                        </div>
                    </xsl:when>                 
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
    <!-- comment calls can edit out if not needed -->
    
    <xsl:template match="item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="emph">
        <xsl:if test="@render='bold'">
            <b><xsl:apply-templates/></b>
        </xsl:if>
        <xsl:if test="@render='italics'">
            <i><xsl:apply-templates/></i>
        </xsl:if>
        <xsl:if test="@render='italic'">
            <i><xsl:apply-templates/></i>
        </xsl:if>
        <xsl:if test="@render='underline'">
            <u><xsl:apply-templates/></u>
        </xsl:if>
        <xsl:if test="@render='super'">
            <sup><xsl:apply-templates/></sup>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="lb">
        <br />
    </xsl:template>
    
    <xsl:template match="scopecontent">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    
    <xsl:template match="extref">
        <a href="{@href}"><xsl:apply-templates/></a>
    </xsl:template>
    
    <!-- leave this, it suppresses anything not specifically called -->
    <xsl:template match="*|@*"/>
    
</xsl:stylesheet>
