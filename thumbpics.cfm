<cfparam name="FormulaFilter" type="integer" default=0>
<cfparam name="BrandFilter" type="integer" default=0>
<cfparam name = "numberonpage" type="integer" default="30">
<cfparam name="APPENDURL" default="">
<cfif ListFindNoCase("S,BR,FT",SearchType) eq 0>
      <cflocation url="http://www.maxvite.com" addToken="false">
</cfif>


<cfset MT = "">
<cfset MD = "">
<cfset MK = "">
<cfset v_sublist = "">
<cfset v_bread = "">
<cfset baseurl = "http://www.maxvite.com/thumbpics.cfm">

<cfswitch expression="#SearchType#">

	<!--- KeywordSearch --->
	<cfcase value="S">
    


						<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, instockflag, strapline, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, Tablets, ServingSize, SubCategory.Subcategoryid, SubCategory.Categoryid, Category.Categoryid, Category.Visible, SubCategory, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Product_SUBCategory_Map, SubCategory, Category
						Where Products.ProductID = Product_SUBCategory_Map.ProductID
						AND Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
						and Product_SUBCategory_Map.SubCategoryID = <cfqueryparam value="#SubCategoryID#" cfsqltype="cf_sql_integer">
    AND SubCategory.SubCategoryID = <cfqueryparam value="#SubCategoryID#" cfsqltype="cf_sql_integer">
    AND SubCategory.CategoryID = Category.CategoryID
    AND Category.Visible = 1
	AND Display = 1
	Order by Title
						</CFQUERY>

						<cfquery name="GetData2" datasource="#Application.ds#">
						SELECT * from SubCategory,Category
						Where SubCategory.categoryid = Category.categoryid
						and SubCategory.Subcategoryid = <cfqueryparam value="#SubCategoryID#" cfsqltype="cf_sql_integer">
                        and Category.Visible = 1
						</CFQUERY>

						<cfquery name="GetData3" datasource="#Application.ds#" maxrows="5">
						SELECT * from Products, Product_SUBCategory_Map
						Where Products.ProductID = Product_SUBCategory_Map.ProductID
						and Product_SUBCategory_Map.SubCategoryID = <cfqueryparam value="#SubCategoryID#" cfsqltype="cf_sql_integer">
						</CFQUERY>
						<cfloop query="getdata3">
						<cfset v_sublist = ListAppend(v_sublist,title)>
						</cfloop>
                        
						<cfset APPENDURL = "&amp;CategoryID=#CategoryID#&amp;SubCategoryID=#SubCategoryID#&amp;SearchType=#SearchType#">
                        


	</cfcase>
	<cfcase value="BR">
<!---					<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, strapline, instockflag, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, description, Tablets, ServingSize, brand, (Select top 1 Subcategoryid from Product_SUBCategory_Map where Product_SUBCategory_Map.ProductID = ProductID) as Subcategoryid, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Brands
						Where Products.BrandID = Brands.BrandID
						AND Products.BrandID = #BrandID#
						AND Display = 1
						<cfif FormulaFilter NEQ 0>
						AND Products.ProductID IN
						(
							SELECT Products.ProductID
							From Products, Product_Formula_Map
							Where Products.ProductID = Product_Formula_Map.ProductID
							AND Product_Formula_Map.FormulaTypeID = #FormulaFilter#
						)
						</cfif>
						Order by Title
					</CFQUERY>--->
					<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, strapline, instockflag, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, description, Tablets, ServingSize, brand, (Select  Subcategoryid from Product_SUBCategory_Map where Product_SUBCategory_Map.ProductID = ProductID LIMIT 1) as Subcategoryid, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Brands
						Where Products.BrandID = Brands.BrandID
						AND Products.BrandID = <cfqueryparam value="#BrandID#" cfsqltype="cf_sql_integer">
						AND Products.Display = 1
                        AND Brands.Display = 1
						<cfif FormulaFilter NEQ 0>
						AND Products.ProductID IN
						(
							SELECT Products.ProductID
							From Products, Product_Formula_Map
							Where Products.ProductID = Product_Formula_Map.ProductID
							AND Product_Formula_Map.FormulaTypeID = #FormulaFilter#
						)
						</cfif>
						Order by Title
					</CFQUERY>
					
					<cfset LookinProducts = ValueList(GetData1.ProductID, ",")>

					<cfquery name="GetCategoryID" datasource="#Application.ds#">
							Select DISTINCT Category, Category.categoryID, Category.Visible
						From Category , SubCategory, Product_SUBCategory_Map
						Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
						AND SubCategory.CategoryID = Category.CategoryID
						<cfif GetData1.Recordcount GT 0>
							AND Product_SUBCategory_Map.ProductID IN (#LookinProducts#)
						<cfelse>
							AND 1=2
						</cfif>
						AND Category.Visible = 1
					</CFQUERY>

					<cfquery name="GetData2" datasource="#Application.ds#">
						SELECT * from Brands Where brandID = <cfqueryparam value="#BrandID#" cfsqltype="cf_sql_integer">
					</CFQUERY>
					<cfquery name="GetData5" datasource="#Application.ds#">
						SELECT Distinct Brands.Brand, FormulaTypes.FormulaTypeID, FormulaTypes.FormulaType
						From Products, Product_Formula_Map, FormulaTypes, Brands
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND Products.BrandID = Brands.brandID
						AND Products.brandID = <cfqueryparam value="#BrandID#" cfsqltype="cf_sql_integer">
						AND Products.Display = 1
                        AND FormulaTypes.Sortid = 1
						Order by FormulaTypes.FormulaType
					</CFQUERY>

						<cfquery name="GetData3" datasource="#Application.ds#" maxrows="5">
						SELECT * from Products, Brands
						Where Products.BrandID = Brands.BrandID
						AND Products.BrandID = <cfqueryparam value="#BrandID#" cfsqltype="cf_sql_integer">
						</CFQUERY>
						<cfloop query="getdata3">
						<cfset v_sublist = ListAppend(v_sublist,title)>
						</cfloop>
				<cfset APPENDURL = "&amp;BrandID=#BrandID#&amp;SearchType=#SearchType#">
	</cfcase>
	<cfcase value="FT">
					<cfquery name="GetData1" datasource="#Application.ds#">
						SELECT Products.ProductID, Title, strapline, instockflag, listprice, ourprice, featuredproductflag, featuredproductflag2, Products.imagesmall, Products.imagebig, description, Tablets, ServingSize, FormulaType, FormulaTypes.Metatitle, FormulaTypes.METADESC, FormulaTypes.BOTTOMDESC, FormulaTypes.METAKEYWORDS, (Select SubCategoryID From Product_SUBCategory_Map Where Product_SUBCategory_Map.ProductID = ProductID limit 1) AS Subcategoryid, Products.MetaTitle, Products.MetaKeywords, Products.MetaDesc
						FROM Products, Product_Formula_Map, FormulaTypes
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND FormulaTypes.FormulaTypeID = #FormulaTypeID#
						AND Display = 1
						<cfif BrandFilter NEQ 0>
						AND Products.ProductID IN
						(
							SELECT Products.ProductID
							From Products, Brands, Product_Formula_Map
							Where Products.BrandID = Brands.BrandID
							AND Products.ProductID = Product_Formula_Map.ProductID
							AND Product_Formula_Map.FormulaTypeID = #FormulaTypeID#
							AND Brands.BrandID = #BrandFilter#
						)
						</cfif>
						Order by Title
					</CFQUERY>

					<cfquery name="GetData5" datasource="#Application.ds#">
						SELECT Distinct Brands.BrandID, Brands.Brand
						From Products, Product_Formula_Map, FormulaTypes, Brands
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND Products.BrandID = Brands.brandID
						AND FormulaTypes.FormulaTypeID = #FormulaTypeID#
						AND Products.Display = 1
						Order By Brands.brand
					</CFQUERY>
                    
						<cfquery name="GetData3" datasource="#Application.ds#" maxrows="5">
						SELECT * from Products, Product_Formula_Map, FormulaTypes
						Where Products.ProductID = Product_Formula_Map.ProductID
						AND Product_Formula_Map.FormulaTypeID = FormulaTypes.FormulaTypeID
						AND FormulaTypes.FormulaTypeID = #FormulaTypeID#
						</CFQUERY>
						<cfloop query="getdata3">
						<cfset v_sublist = ListAppend(v_sublist,title)>
						</cfloop>

				<cfset APPENDURL = "&amp;FormulaTypeID=#FormulaTypeID#&amp;SearchType=#SearchType#">
	</cfcase>
</cfswitch>
<cfset APPENDURL = APPENDURL & "&amp;FormulaFilter=#FormulaFilter#&amp;BrandFilter=#BrandFilter#">


<!--- Page Count Variables --->
<cfparam name="StartPage" type="numeric" default="0">
<cfset NumProducts = Ceiling(GetData1.Recordcount)>
<cfset NumPages = Ceiling(GetData1.Recordcount/numberonpage)>
<cfset WS = Ceiling((StartPage*numberonpage)+1)>
<cfset WE = Ceiling(WS+(numberonpage-1))>
<cfif WE GT NumProducts>
	<cfset WE = Ceiling(NumProducts)>
</cfif>

<cfset First_Rec_num = (StartPage * numberonpage)+1>
<cfset Last_Rec_num = First_Rec_num+(numberonpage-1)>
<cfif Last_Rec_num GT GetData1.Recordcount>
	<cfset Last_Rec_num = GetData1.Recordcount>
</cfif>


<cfswitch expression="#SearchType#">
	<cfcase value="S">
		<cfset displaytitle = "#GetData1.SubCategory#">
		<cfset displaydesc = "">
			<cfif getdata2.MetaTitle EQ "">
				<cfset MT ="#getdata2.subcategory# - #getdata2.category# - Buy Discount #getdata2.subcategory#, #getdata2.category# - Buy Discount #getdata2.subcategory#, Online Vitamins, Supplements Pills, Capsules, Tablets, Softgels, Natural, Organic, Herbal Products.">
			<cfelse>
				<cfset MT ="#getdata2.MetaTitle#">
			</cfif>

			<cfif getdata2.MetaKeywords EQ "">
				<cfset MK ="#getdata2.subcategory#, #getdata2.category#, discounted #v_sublist#">
			<cfelse>
				<cfset MK ="#getdata2.MetaKeywords#">
			</cfif>

			<cfif getdata2.MetaDesc EQ "">
				<cfset MD ="#getdata2.subcategory# - Buy discounted #getdata2.subcategory# and other #getdata2.category# at MaxVite.com. In our #getdata2.category# section you will find #v_sublist#. Buy discount brand name #getdata2.subcategory# vitamins, supplements, pills, capsules, softgels and tablets. Find natural, herbal, organic and healthy #getdata2.subcategory# products.">
			<cfelse>
				<cfset MD ="#getdata2.MetaDesc#">
			</cfif>
	</cfcase>
	<cfcase value="BR">
		<cfset displaytitle = "#GetData1.Brand#">
		<cfset displaydesc = "">
			<cfset MT =	"#GetData1.Brand# - Buy Discount #GetData1.Brand# Products, #GetData1.Brand# Vitamins, Supplements, Pills, Capsules, Tablets, Softgels, Natural, Organic, Herbal Products.">
			<cfset MD ="#GetData1.Brand# - Buy discounted #GetData1.Brand#. In our #GetData1.Brand# section you will find #v_sublist#. #GetData1.Brand# vitamins, supplements, pills, capsules, softgels and tablets. Find natural, herbal, organic and healthy #GetData1.Brand# products.">
			<cfset MK ="#v_sublist#">
	</cfcase>
	<cfcase value="FT">
		<cfset displaytitle = "#GetData1.FormulaType#">
		<cfset displaydesc = "">
			<cfset MT =	"#GetData1.METATITLE#">
			<cfset MD ="#GetData1.METADESC#">
			<cfset MK ="#GetData1.METAKEYWORDS#">
	</cfcase>
</cfswitch>


<!---<cfquery name="GetDataM" datasource="#Application.ds#">
Select * from Products, Brands
Where Products.BrandID = Brands.BrandID
AND ProductID = #ProductID#
</cfquery>--->
<cf_doctype>
<cf_html>
<head>
<title><cfoutput>#MT#</cfoutput></title>
	<cfoutput>
	<meta name="description" content="#MD#">
	<meta name="keywords" content="#MK#">
	<!--- beware! Hardcode here! please remove it in future ---->
	<cfif SearchType EQ "FT" AND FormulaTypeID EQ 13>
	<meta name='robots' content='noindex, nofollow' />
	</cfif>
	<!--- end of ugly coding --->
	</cfoutput>
<cf_metacustom>
    <cf_listscripts>
</head>

<body>
<div class="wrapper">
<cf_header>

<div class="content">
 
<div class="primary">
<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>

<a name="topOfPage"></a>

<!--- Breadcrumb --->
<cfif searchtype eq "S">

<cfif GetData2.Recordcount EQ 0>
<div align="center"><h1>Subcategory Not Available</h1></div>
<cfelse>
<p class="breadcrumbs"><a href="/">Vitamins</a><cfoutput><a href="http://www.maxvite.com/#getdata2.CategoryID#/#replace(replace(replace(getdata2.Category," ", "_", "all"),",","","all"),"&","","all")#/subcategory.html">#GetData2.Category#</a><span class="bread-product">#getdata2.subcategory#</span></cfoutput></p>
  <cfif getdata2.SubCategoryID eq 1149>
      <cflocation url="http://www.maxvite.com/deal_of_the_day.cfm" addToken="false">
  </cfif>
  <cfif getdata2.SubCategoryID eq 555>
      <cflocation url="http://www.maxvite.com/brandspecials.cfm" addToken="false">
  </cfif>
</cfif>  
  
</cfif>
<cfif searchtype eq "FT">
<p class="breadcrumbs"><a href="/">Vitamins</a><cfoutput><span class="bread-product">#displaytitle#</span></cfoutput></p>
</cfif>
<cfif searchtype eq "BR">
<p class="breadcrumbs"><a href="/">Vitamins</a><cfoutput><span class="bread-product">#displaytitle#</span></cfoutput></p>
</cfif>
<h1><cfoutput>#displaytitle#</cfoutput></h1>


<cfif GetData1.Recordcount EQ 0>
<div><h2>There are no products for your selection!</h2></div><div><cfoutput><p>#displaydesc#</p></cfoutput></div>
<cfelseif searchtype eq "BR" and GetCategoryID.RecordCount EQ 0>
<div><h2>There are no products for your selection!</h2></div><div><cfoutput><p>#displaydesc#</p></cfoutput></div>
<cfelse>

<cfswitch expression="#SearchType#">
	<cfcase value="S">
    <cfif getdata2.subdesc neq "">
	<cfoutput><p>#getdata2.subdesc#*</p></cfoutput>
    </cfif>
    </cfcase>
    
	<cfcase value="BR">
    <cfif getdata2.BottomDesc neq "">
	<cfoutput><p>#getdata2.BottomDesc#*</p></cfoutput>
    </cfif>
    </cfcase>
</cfswitch>


	<cfif SearchType EQ "BR">
	<cfoutput>
	<div class="sortlist">
	<form name="filter" action=""><label for="FormulaFilter">Sort by Health Concern:</label>
	<select name="FormulaFilter" onChange="window.location.assign(this.value); ">
				<option value="http://www.maxvite.com/thumbpics.cfm?BrandID=#BrandID#&SearchType=BR&numberonpage=#numberonpage#">All</option>
	<cfloop query="GetData5">
			<cfif getdata5.formulatypeid eq formulafilter>
				<option value="http://www.maxvite.com/thumbpics.cfm?BrandID=#BrandID#&SearchType=BR&FormulaFilter=#FormulaTypeID#&numberonpage=#numberonpage#" selected>#FormulaType#</option>
			<cfelse>
				<option value="http://www.maxvite.com/thumbpics.cfm?BrandID=#BrandID#&SearchType=BR&FormulaFilter=#FormulaTypeID#&numberonpage=#numberonpage#">#FormulaType#</option>
			</cfif>
	</cfloop>
	</select>
	</form>
    </div>
	</cfoutput>
	</cfif>

	<cfif SearchType EQ "FT">
	<cfoutput>
    <p>#GetData1.BOTTOMDESC#</p>
	<div class="sortlist">
	<form name="filter" action=""><label for="BrandFilter">Sort by Brand:</label>
	<select name="BrandFilter" onChange="window.location.assign(this.value); ">
				<option value="http://www.maxvite.com/thumbpics.cfm?FormulaTypeID=#FormulaTypeID#&SearchType=FT&FormulaFilter=#FormulaFilter#&numberonpage=#numberonpage#">All</option>
	<cfloop query="GetData5">
			<cfif getdata5.brandid eq brandfilter>
				<option value="http://www.maxvite.com/thumbpics.cfm?FormulaTypeID=#FormulaTypeID#&SearchType=FT&FormulaFilter=#FormulaFilter#&BrandFilter=#BrandID#&numberonpage=#numberonpage#" selected>#brand#</option>
			<cfelse>
				<option value="http://www.maxvite.com/thumbpics.cfm?FormulaTypeID=#FormulaTypeID#&SearchType=FT&FormulaFilter=#FormulaFilter#&BrandFilter=#BrandID#&numberonpage=#numberonpage#">#Brand#</option>
			</cfif>
	</cfloop>
	</select>
	</form>
    </div>
	</cfoutput>
	</cfif>

<!---	<cfif SearchType EQ "S">
	<cfoutput>
	<div class="sortlist">
	<form name="filter" action=""><label for="BrandFilter">Sort by Brand:</label>
	<select name="BrandFilter" onChange="window.location.assign(this.value); ">
				<option value="http://www.maxvite.com/thumbpics.cfm?CategoryID=#getdata2.CategoryID#SearchType=S&BrandFilter=1&numberonpage=#numberonpage#">All</option>
                
	</select>
	</form>
    </div>
    #getdata2.CategoryID##getdata2.SubCategoryID#
	</cfoutput>
	</cfif>--->
    
<cfinclude template="productsgrid.cfm"><!--used both on list and search pages-->




</cfif>
<br><p class="small">*These statements have not been evaluated by the Food and Drug Administration. These products is not intended to diagnose, treat, cure, or prevent any diseases.</p>
</div> <!--end primary-->
<cf_secondary>

 
</div> 
<!--end content-->
 
 <cf_footer>
 
</div><!--end wrapper-->


</body>
</html>