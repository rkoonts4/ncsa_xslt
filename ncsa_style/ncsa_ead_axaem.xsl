<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="ead xsi xlink"
    version="2">
    

    <xsl:output method="xhtml" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" use-character-maps="no-control-characters" omit-xml-declaration="yes"/>
    <xsl:variable name="coll_id" select="ead:ead/ead:eadheader/ead:eadid"/>
    <xsl:variable name="box_id" select="ead:ead/ead:archdesc/ead:did"/>
   
        <xsl:character-map name="no-control-characters">
            <xsl:output-character character="&#127;" string=" "/>
            <xsl:output-character character="&#128;" string="?"/>
            <xsl:output-character character="&#129;" string=" "/>
            <xsl:output-character character="&#130;" string=","/>
            <xsl:output-character character="&#131;" string=" "/>
            <xsl:output-character character="&#132;" string=" "/>
            <xsl:output-character character="&#133;" string=" "/>
            <xsl:output-character character="&#134;" string=" "/>
            <xsl:output-character character="&#135;" string=" "/>
            <xsl:output-character character="&#136;" string=" "/>
            <xsl:output-character character="&#137;" string=" "/>
            <xsl:output-character character="&#138;" string=" "/>
            <xsl:output-character character="&#139;" string=" "/>
            <xsl:output-character character="&#140;" string=" "/>
            <xsl:output-character character="&#141;" string=" "/>
            <xsl:output-character character="&#142;" string=" "/>
            <xsl:output-character character="&#143;" string=" "/>
            <xsl:output-character character="&#144;" string=" "/>
            <xsl:output-character character="&#145;" string="'"/>
            <xsl:output-character character="&#146;" string="'"/>
            <xsl:output-character character="&#147;" string='"'/>
            <xsl:output-character character="&#148;" string='"'/>
            <xsl:output-character character="&#149;" string=" "/>
            <xsl:output-character character="&#150;" string="-"/>
            <xsl:output-character character="&#151;" string="--"/>
            <xsl:output-character character="&#152;" string="~"/>
            <xsl:output-character character="&#153;" string=" "/>
            <xsl:output-character character="&#154;" string=" "/>
            <xsl:output-character character="&#155;" string=" "/>
            <xsl:output-character character="&#156;" string=" "/>
            <xsl:output-character character="&#157;" string=" "/>
            <xsl:output-character character="&#158;" string=" "/>
            <xsl:output-character character="&#159;" string=" "/>
        </xsl:character-map>

    <xsl:template match="/">
        <head>
        <style>
	 <xsl:value-of select="unparsed-text('find_aid.css')" disable-output-escaping="yes"/>
	 <xsl:value-of select="unparsed-text('findingaids-grid-1200.css')" disable-output-escaping="yes"/>
        </style>
        </head>
                <div id="bodyWrapper" typeof="schema:CollectionPage">
                    <div class="container_16" id="wholePage">
                        <div class="grid_16" id="wrapper">
                            <div id="mainContent" class="grid_12 alpha maincontent">
                                <span class="menuLink dontPrint"><a href="#menu" class="button">Menu</a></span>
                                <h1 class="mainTitle" property="schema:name"><xsl:apply-templates select="//ead:frontmatter//ead:titleproper"/></h1>
				<xsl:if test="//ead:abstract">
                                <a id="abstract"></a>
                                <div class="abstract">
                                    <h2 class="mainheading">
<a name="abstract"/>
Abstract</h2>
        <div id="{generate-id()}" class="section" property="schema:description" style="display: block;">
                                    <xsl:apply-templates select="//ead:abstract"/>
                                    </div>
                                </div>
				</xsl:if>
                                <div class="grid_6 alpha">
                                    <xsl:call-template name="DS"/>
                                </div>
                                <a name="series"></a>
                                <div class="grid_6 omega">
                                    <xsl:call-template name="SQL"/>
                                </div>
                                <div class="clear"></div>
                                <xsl:call-template name="CO"/>
                                <xsl:call-template name="AN"/>
                                <xsl:call-template name="RoA"/>
                                <div class="clear"></div>
                                <xsl:call-template name="CC"/>
                                <xsl:if test="//ead:bioghist">
                                    <xsl:call-template name="HN"/>                                    
                                </xsl:if>
                                <xsl:call-template name="SH"/>
				<xsl:if test="//ead:prefercite">
                                   <xsl:call-template name="PC"/>
				</xsl:if>
				<xsl:if test="//ead:acqinfo">
                                   <xsl:call-template name="AQ"/>
				</xsl:if>
                                <xsl:call-template name="PVN"/>
                <xsl:if test="//ead:processinfo">
                                  <xsl:call-template name="PI"/>                  
                </xsl:if>
                                <xsl:call-template name="SM"/>
				<xsl:if test="//ead:relatedmaterial">
                                <xsl:call-template name="RM"/>
				</xsl:if>
                            </div>
                        </div>
                    </div>
                </div>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="ead:abstract">
            <p dir="auto"><xsl:apply-templates/></p>  
    </xsl:template>
    
    <xsl:template match="ead:frontmatter//ead:titleproper">
        <xsl:value-of select="text()"/><xsl:text> </xsl:text><xsl:value-of select="ead:date"/><xsl:text> (</xsl:text><xsl:value-of select="ead:num"/><xsl:text>)</xsl:text>
    </xsl:template>
    
    <xsl:template name="DS">
	<xsl:for-each select="//ead:archdesc/ead:did">
        <h2 id="descriptivesummary" class="mainheading">Descriptive Summary</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
            <dl>
                <dt>Call Number</dt>
                <dd><xsl:value-of select="ead:unitid[1]"/></dd>
                <dt>Title</dt>
                <dd><xsl:value-of select="ead:unittitle"/></dd>
                <dt>Date</dt>
                <dd><xsl:value-of select="ead:unitdate"/></dd>
                <dt>Creator</dt>
                <dd property="schema:creator"><xsl:value-of select="ead:origination[@label='creator']"/></dd>
                <dt>Extent</dt>
		<xsl:for-each select="ead:physdesc">
		<xsl:choose>
                <xsl:when test="child::ead:extent">
                    <dd>
                        <xsl:for-each select="ead:extent">
                         <xsl:value-of select="."/><xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                            <xsl:if test="following-sibling::ead:extent">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </dd>
		</xsl:when>
		<xsl:otherwise/>
		</xsl:choose>		
		</xsl:for-each>
                <dt>Repository</dt>
                <dd><xsl:value-of select="ead:repository"/></dd>
<!--
                <dt>Language</dt>
                <dd><xsl:value-of select="ead:langmaterial"/></dd>
-->
            </dl>
        </div>
	</xsl:for-each>
    </xsl:template>

    <xsl:template name="SQL">
        <h2 class="mainheading">Series Quick Links</h2>
<a name="sql"/>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
            <ol>
                <xsl:call-template name="SeriesLink"/>
            </ol>
        </div>
    </xsl:template>
    
    <xsl:template name="SeriesLink">
        <xsl:for-each select="//ead:c01">
            <li><a href="#c01_{position()}"><xsl:value-of select="ead:did/ead:unittitle"/>
                <xsl:if test="following-sibling::ead:unitdate">
                    , <xsl:value-of select="ead:did/ead:unitdate"/>
                </xsl:if>
            </a></li>
        </xsl:for-each>
    </xsl:template>
 
    <xsl:template name="CO">
<xsl:for-each select="//ead:archdesc/ead:scopecontent[1]">
<xsl:choose>
<xsl:when test="ead:p">
<a name="collectionoverview"/>
        <h2 class="mainheading">
Collection Overview</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
                <xsl:for-each select="//ead:archdesc/ead:scopecontent/ead:p">
                    <p dir="auto"><xsl:apply-templates/></p>
                </xsl:for-each>
            </div> 
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
        </xsl:for-each>
    </xsl:template>
 
    <xsl:template name="AN">
<xsl:for-each select="//ead:archdesc/ead:arrangement">
<xsl:choose>
<xsl:when test="ead:p">
<a name="arrangementnote"/>
        <h2 class="mainheading">Arrangement Note</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
                <xsl:for-each select="//ead:archdesc/ead:arrangement/ead:p">
                    <p dir="auto"><xsl:apply-templates/></p>
                </xsl:for-each>
            </div> 
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="RoA">
        <xsl:if test="//ead:archdesc/ead:accessrestrict">
<a name="restrictions"/>
        <h2 class="mainheading">
	Restrictions on Access &amp; Use</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
                <div class="grid_6 alpha">
                    <h3>Access Restrictions</h3>
                    <div>
                        <xsl:for-each select="//ead:archdesc/ead:accessrestrict/ead:p">
                            <p dir="auto"><xsl:apply-templates/></p> 
                        </xsl:for-each>
                    </div>
                </div>
                <div class="grid_6 omega" id="userestrict">
                    <h3>Use Restrictions</h3>
                    <div>
                        <xsl:for-each select="//ead:archdesc/ead:userestrict/ead:p">
                            <p dir="auto"><xsl:apply-templates/></p>
                        </xsl:for-each>
                    </div>
                </div>
            </div> 
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="CC">
<a name="contents"/>
        <h2 class="mainheading"><a href="{generate-id()}" >Contents of the Collection</a></h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
            <xsl:call-template name="contents"/>
        </div>
    </xsl:template>
    
    <xsl:template name="contents">
        <xsl:for-each select="//ead:c01">
            <a name="c01_{position()}"></a>
            <h2 class="mainheading">
                <strong><xsl:value-of select="position()"/><xsl:text>. </xsl:text></strong> <xsl:value-of select="ead:did/ead:unittitle"/>
                 <xsl:if test="following-sibling::ead:unitdate">, <xsl:value-of select="ead:did/ead:unitdate"/></xsl:if>
            </h2>
            <div id="{generate-id()}" class="section sectionSubSeries showhide" style="display: block;">
                <div class="title c01 c01_title_row">
                <xsl:if test="ead:scopecontent">
                    <p dir="auto"><b><xsl:value-of select="ead:scopecontent/ead:head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="ead:scopecontent/ead:p"/></p>
                </xsl:if>
                <xsl:if test="ead:arrangement">
		    <p dir="auto"><b><xsl:value-of select="ead:arrangement/ead:head"/><xsl:text>: </xsl:text></b>
                    <xsl:apply-templates select="ead:arrangement/ead:p"/></p>
                </xsl:if>
                <xsl:if test="ead:accessrestrict">
		    <p dir="auto"><b><xsl:value-of select="ead:accessrestrict/ead:head"/><xsl:text>: </xsl:text></b>
                    <xsl:apply-templates select="ead:accessrestrict/ead:p"/></p>
                </xsl:if>
                <xsl:if test="ead:processinfo">
		    <p dir="auto"><b><xsl:value-of select="ead:processinfo/ead:head"/><xsl:text>: </xsl:text></b>
                    <xsl:apply-templates select="ead:processinfo/ead:p"/></p>
             </xsl:if>
                    <xsl:if test="not(ead:did/ead:container/@parent)">
                        <xsl:call-template name="cr_containers"/>
                    </xsl:if>
            <xsl:for-each select="descendant::ead:c02|descendant::ead:c03|descendant::ead:c04|descendant::ead:c05">
                <xsl:choose>
                    <xsl:when test="@level='subseries' or @level='subgrp'">
                        <div class="section sectionSubSeries">
                            <div class="title {name()} {name()}_title_row">
                                <h3><span><xsl:value-of select="ead:did/ead:unittitle"/>, <xsl:value-of select="ead:did/ead:unitdate"/></span></h3>
                                <xsl:if test="ead:scopecontent">
                                    <p dir="auto"><b><xsl:value-of select="ead:scopecontent/ead:head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="ead:scopecontent/ead:p"/></p>
                                </xsl:if>
                                <xsl:if test="ead:arrangement">
                                    <p dir="auto"><b><xsl:value-of select="ead:arrangement/ead:head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="ead:arrangement/ead:p"/></p>
                                </xsl:if>
                                <xsl:if test="ead:accessrestrict">
                                    <p dir="auto"><b><xsl:value-of select="ead:accessrestrict/ead:head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="ead:accessrestrict/ead:p"/></p>
                                </xsl:if>
                                <xsl:if test="ead:processinfo">
                                    <p dir="auto"><b><xsl:value-of select="ead:processinfo/ead:head"/><xsl:text>: </xsl:text></b><xsl:apply-templates select="ead:processinfo/ead:p"/></p>
                                </xsl:if>
                                <xsl:if test="not(ead:did/ead:container/@parent)">
                                    <xsl:call-template name="cr_containers"/>
                                </xsl:if>
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
                    <span><xsl:value-of select="ead:did/ead:unittitle"/>, <xsl:value-of select="ead:did/ead:unitdate"/></span>
                <xsl:if test="ead:accessrestrict">
                    <p dir="auto"><b><xsl:value-of select="ead:accessrestrict/ead:head"/><xsl:text>: </xsl:text></b>
                    <xsl:apply-templates select="ead:accessrestrict/ead:p"/></p>
                </xsl:if>
                <xsl:if test="ead:processinfo">
                    <p dir="auto"><b><xsl:value-of select="ead:processinfo/ead:head"/><xsl:text>: </xsl:text></b>
                    <xsl:apply-templates select="ead:processinfo/ead:p"/></p>
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
                    <span><xsl:value-of select="ead:did/ead:unittitle"/>, <xsl:value-of select="ead:did/ead:unitdate"/></span>
                <xsl:if test="ead:accessrestrict">
                    <p dir="auto"><b><xsl:value-of select="ead:accessrestrict/ead:head"/><xsl:text>: </xsl:text></b>
                    <xsl:apply-templates select="ead:accessrestrict/ead:p"/></p>
                </xsl:if>
                <xsl:if test="ead:processinfo">
                    <p dir="auto"><b><xsl:value-of select="ead:processinfo/ead:head"/><xsl:text>: </xsl:text></b>
                    <xsl:apply-templates select="ead:processinfo/ead:p"/></p>
                </xsl:if>
                </div>
            </div>
                <xsl:call-template name="sa_containers"/>
 
        </div>
        <div class="clear"></div>
    </xsl:template>
    
    <xsl:template name="sa_containers">
        <div class="faid_containers">
            <xsl:variable name="parent" select="ead:did/ead:container/@parent"/>
            <xsl:variable name="box_num">
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:did/ead:container">
                    <xsl:if test="@id = $parent">
                        <xsl:value-of select="@label"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <span class="container_item box">Box <xsl:value-of select="$box_num"/></span> 
        </div>  
    </xsl:template>
    
    <xsl:template name="cr_containers">
        <div class="faid_containers">
            <xsl:for-each select="ead:did/ead:container">
                <xsl:if test="position() mod 2=0">
                    <span class="container_item box">Box <xsl:value-of select="@label"/></span> 
                </xsl:if>
                <xsl:if test="position() mod 2!=0">
                    <span class="container_item box fa_odd">Box <xsl:value-of select="@label"/></span> 
                </xsl:if>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="HN">
        <xsl:for-each select="//ead:archdesc/ead:bioghist">
<xsl:choose>
<xsl:when test="contains(ead:head,'His')">
<a name="historical"/>
</xsl:when>
<xsl:when test="contains(ead:head,'Bio')">
<a name="biographical"/>
</xsl:when>
</xsl:choose>
        <h2 class="mainheading"><xsl:value-of select="ead:head"/></h2>
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
    
    
    <xsl:template name="SH">
        <xsl:for-each select="//ead:archdesc/ead:controlaccess">
	<a name="subjectheadings"/>
	<h2 class="mainheading">
Subject Headings</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
        <xsl:for-each select="ead:controlaccess/child::ead:*">
                <li><a href="search-faids?query='{normalize-space(node())}'"><xsl:value-of select="."/></a></li> 
        </xsl:for-each>
        </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="PC">
        <xsl:for-each select="//ead:archdesc/ead:prefercite/ead:p">
<a name="preferredcitation"/>
        <h2 class="mainheading">
Preferred Citation</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;"><p dir="auto"><xsl:apply-templates/></p></div>      
        </xsl:for-each>
    </xsl:template>
    

    <xsl:template name="AQ">
        <xsl:for-each select="//ead:archdesc/ead:acqinfo/ead:p">
<a name="acquisitioninfo"/>
        <h2 class="mainheading">
Acquisitions Information</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;"><p dir="auto"><xsl:apply-templates/></p></div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="PVN">
        <h2 class="mainheading">Provenance</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
        <xsl:for-each select="//ead:archdesc/ead:custodhist/ead:p">
        <li><xsl:apply-templates/></li>             
        </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template name="PI">
        <h2 class="mainheading">Processing Information</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;">
            <xsl:for-each select="//ead:archdesc/ead:processinfo/ead:p">
             <li><xsl:apply-templates/></li>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="SM">
        <xsl:for-each select="//ead:archdesc/ead:separatedmaterial">
	<a name="separatedmaterial"/>
        <h2 class="mainheading">Separated Material</h2>
        <div id="{generate-id()}" class="section showhide" style="display: block;"><p dir="auto"><xsl:apply-templates select="ead:p"/></p></div> 
	<xsl:if test="child::ead:list">
	<xsl:apply-templates select="child::ead:list"/>
	</xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="RM">
        <xsl:for-each select="//ead:archdesc/ead:relatedmaterial[1]">
	<a name="related"/>
        <h2 class="mainheading">Related Material</h2>
    <div id="{generate-id()}" class="section showhide" style="display: block;">
    <xsl:if test="ead:archref">
    <xsl:for-each select="ead:archref">
        <p dir="auto"><xsl:value-of select="ead:unittitle"/> - <xsl:value-of select="ead:repository"/></p>
            </xsl:for-each>
	<xsl:for-each select="following-sibling::ead:relatedmaterial">
<p dir="auto"><xsl:value-of select="ead:archref/ead:unittitle"/> - <xsl:value-of select="ead:archref/ead:repository"/></p>
</xsl:for-each>
</xsl:if>
<xsl:if test="ead:p">
 <xsl:apply-templates select="ead:p"/>
</xsl:if>
<xsl:if test="ead:list">
<ul>
<xsl:for-each select="ead:list/ead:item">
<li><xsl:apply-templates/></li>
</xsl:for-each>
</ul>
</xsl:if>
</div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="ead:unittitle|ead:unitdate|ead:persname|ead:subject|ead:corpname|ead:genreform|ead:p">
        <xsl:text> </xsl:text><xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ead:head">
	<xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ead:list">
     <ul>
	<xsl:apply-templates/>
     </ul>
     </xsl:template>

    <xsl:template match="ead:item">
     <li><xsl:apply-templates/></li>
     </xsl:template>

    <xsl:template match="ead:emph">
     <xsl:if test="@render='bold'">
      <b><xsl:apply-templates/></b>
     </xsl:if>
     <xsl:if test="@render='italics'">
      <i><xsl:apply-templates/></i>
     </xsl:if>
     </xsl:template>

	<xsl:template match="ead:lb">
	   <br />
	</xsl:template>

    <xsl:template match="*|@*"/>


</xsl:stylesheet>
