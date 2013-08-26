<!---This function helps to sort array structures. In my case by Name, Price, etc.--->
<cffunction name="ArrayOfStructSort" returntype="array" access="public">
  <cfargument name="base" type="array" required="yes" />
  <cfargument name="sortType" type="string" required="no" default="text" />
  <cfargument name="sortOrder" type="string" required="no" default="ASC" />
  <cfargument name="pathToSubElement" type="string" required="no" default="" />
  <cfset var tmpStruct = StructNew()>
  <cfset var returnVal = ArrayNew(1)>
  <cfset var i = 0>
  <cfset var keys = "">
  <cfloop from="1" to="#ArrayLen(base)#" index="i">
    <cfset tmpStruct[i] = base[i]>
  </cfloop>
  <cfset keys = StructSort(tmpStruct, sortType, sortOrder, pathToSubElement)>
  <cfloop from="1" to="#ArrayLen(keys)#" index="i">
    <cfset returnVal[i] = tmpStruct[keys[i]]>
  </cfloop>
  <cfreturn returnVal>
</cffunction>
<!------>


<cfset eachProductArray = ArrayNew(1) />
<cfset eachProductArraySome = ArrayNew(1) />
<cfset eachBrandArray = ArrayNew(1) />
<cfset eachConcernArray = ArrayNew(1) />
<cfset eachSpecialArray = ArrayNew(1) />
<cfset initialProductIDArray = ArrayNew(1) />
<cfset secondProductIDArray = ArrayNew(1) />
<cfset priceRangeArray = ArrayNew(1) />

<cfparam name="q" default="">
<cfparam name="numberonpage" type="integer" default="30">
<cfparam name="startpage" type="numeric" default="0">
<cfparam name="productstart" type="integer" default="1">
<cfparam name="productend" type="integer" default="30">
<cfparam name="brandfilter" type="string" default="0">
<cfparam name="concernfilter" type="string" default="0">
<cfparam name="specialsfilter" type="string" default="0">
<cfparam name="productidfilter" type="string" default="0">
<cfparam name="sort" type="string" default="nameaz">
<cfparam name="pricerange" type="string" default="5,15"><!---replace temporary value with 0--->

<cfset priceRangeArray = ListToArray(pricerange)>

<cfquery name="GetInitialProductData" datasource="#Application.ds#">
  SELECT p.ProductID, p.BrandID, p.Title, p.instockflag, p.strapline, p.ServingSize, p.listprice, p.ourprice, p.featuredproductflag, p.featuredproductflag2, p.imagebig, p.description, p.Tablets
  FROM Products p
  Where p.Display = 1                      
  AND
    (p.Description like '%#q#%'
    OR
    p.Title like '%#q#%'
    OR
    p.ProductID = #val(q)#
    OR
    p.UPC like '%#q#%'
    )    
  ORDER BY p.Title ASC
</cfquery>

<cfif GetInitialProductData.Recordcount EQ 0>
  <!---output JSON data if no results found--->
  {
  "found_products": false
  }
<cfelse>


<cfquery name="GetSecondProductData" datasource="#Application.ds#">
  SELECT DISTINCT p.ProductID, p.BrandID, p.Title, p.instockflag, p.strapline, p.ServingSize, p.listprice, p.ourprice, p.featuredproductflag, p.featuredproductflag2, p.imagebig, p.description, p.Tablets
  FROM Products p, Product_Formula_Map pfm
  WHERE p.ProductID = pfm.ProductID
  AND p.Display = 1
                        
<cfif brandfilter NEQ 0>
    AND p.BrandID IN (#URLDecode(brandfilter)#)
</cfif>

<cfif concernfilter NEQ 0>
    AND pfm.FORMULATYPEID IN (#URLDecode(concernfilter)#)
</cfif>
    
<cfif productidfilter NEQ 0>
    AND p.ProductID IN (#URLDecode(productidfilter)#)
<cfelse>
  AND
  (p.Description like '%#q#%'
   OR
   p.Title like '%#q#%'
   OR
   p.ProductID = #val(q)#
   OR
  p.UPC like '%#q#%'
   )    
</cfif>  

<cfif sort EQ "nameza">
    ORDER BY p.Title DESC
<cfelse>
    ORDER BY p.Title ASC
</cfif>

</cfquery>

<cfset productstart = Ceiling((startpage*numberonpage)+1)>
<cfset productend = Ceiling(productstart + (numberonpage-1))>


<cfloop query="GetInitialProductData">
  <cfset ArrayAppend(initialProductIDArray, #ProductID#)>
</cfloop>

<cfloop query="GetSecondProductData">
  <cfset ArrayAppend(secondProductIDArray, #ProductID#)>
</cfloop>


<cfloop query="GetSecondProductData" startrow="#productstart#" endrow="#productend#">
  
    <!---check if product is buy 1 get 1 free--->
    <cfquery name="GetDataSubc" datasource="#Application.ds#" maxrows=1>
  Select DISTINCT Category.categoryID, Category, SubCategory.subcategoryid, subcategory
  From Category , SubCategory, Product_SUBCategory_Map
  Where Product_SUBCategory_Map.SubCategoryID = SubCategory.SubCategoryID
  AND SubCategory.CategoryID = 54
  AND Product_SUBCategory_Map.ProductID = #ProductID#
</cfquery>


<cfquery name="GetMinOrderQty" datasource="#Application.ds#">
  SELECT b.MIN, p.BrandID, b.BrandID    
  FROM Products p, Brands b
  WHERE p.BrandID = b.BrandID
  AND p.ProductID = #ProductID#
</cfquery>
    <cfset minimum_order_qty = #GetMinOrderQty.MIN#>
    <cfinclude template="/dealquery.cfm">
    <cfif newprice neq 0>
      <cfset youSave = val(listprice)-val(newprice)>
      <cfset youSavePcnt = round(Evaluate(    ((val(listprice)-val(newprice))/val(listprice)) *100))>
    </cfif>
    <!---this code sets image url--->
    <cfhttp url="http://www.maxvite.com/images/#imagebig#" timeout="45" result="result" throwOnError="no">
    </cfhttp>
    <cfif listFind(result.statuscode, "200"," ") neq 0>
      <cfset imageURL = "/images/#URLEncodedFormat(imagebig)#">
      <cfelse>
      <cfset imageURL = "/images/coming_soon-2.jpg">
    </cfif>
    <!------>
    <cfset eachProductStruct = StructNew() />
    <cfset eachProductStruct["product_id"] = #ProductID# />
    <cfset eachProductStruct["name"] = "#Title#" />
    <cfset eachProductStruct["instock"] = #instockflag# />
    <cfset eachProductStruct["form"] = "#Tablets#" />
    
    <!---<cfset newstrapline = PreserveSingleQuotes(strapline)>--->
        <cfset eachProductStruct["strap_line"] = "#strapline#" />

    <cfset eachProductStruct["serving_size"] = "#ServingSize#" />
    <cfset eachProductStruct["image_url"] = "#imageURL#" />
    <cfset eachProductStruct["product_url"] = "/#ProductID#/#ReReplace(title,"[^0-9a-zA-Z]+","-","ALL")#/product.html" />
    <cfif minimum_order_qty GT 2>
      <cfset eachProductStruct["show_min_qty_list"] = true />
      <cfelse>
      <cfset eachProductStruct["show_min_qty_list"] = false />
    </cfif>
    <!---check if product is buy 1 get 1 free--->
    <cfif GetDataSubc.SubCategoryID eq 554>
      <cfset eachProductStruct["bogo"] = 1 />
      <cfset eachProductStruct["list_price"] = #DollarFormat(ListPrice)# />
<cfset finalPrice = #ourprice# />      
      <cfset eachProductStruct["dollars_saved"] = #DollarFormat(youSave)# />
      <cfset eachProductStruct["percent_saved"] = "#youSavePcnt#" />
      <cfelse>
      <cfif #ListPrice# GT #newprice# AND #newprice# GT 0>
        <cfset eachProductStruct["list_price"] = #DollarFormat(ListPrice)# />
        <cfelse>
        <cfset eachProductStruct["just_price"] = true />
<cfset finalPrice = #ListPrice# />      
        
      </cfif>
      <cfif newprice neq 0>
        <cfif #youSavePcnt# GT 0>
<cfset finalPrice = #newprice# />              
          <cfset eachProductStruct["dollars_saved"] = #DollarFormat(youSave)# />
          <cfset eachProductStruct["percent_saved"] = "#youSavePcnt#" />
        </cfif>
      </cfif>
    </cfif>
    <cfset eachProductStruct["rating_grid"] = "<script>var rating#ProductID# = document.getElementById('pr_snippet_category_#ProductID#');POWERREVIEWS.display.snippet({write : function(content){rating#ProductID#.innerHTML = rating#ProductID#.innerHTML + content;}},{pr_page_id: '#ProductID#', pr_snippet_min_reviews : '1'})</script>" />
    <cfset eachProductStruct["rating_list"] = "<script>var rating#ProductID# = document.getElementById('pr_snippet_category#ProductID#');POWERREVIEWS.display.snippet({write : function(content){rating#ProductID#.innerHTML = rating#ProductID#.innerHTML + content;}},{pr_page_id: '#ProductID#', pr_snippet_min_reviews : '1'})</script>" />
    <cfset eachProductStruct["final_price"] = #DollarFormat(finalPrice)# />
    <cfset eachProductStruct["final_price_rounded"] = #Round(finalPrice)# />


<cfif IsDefined("finalMinPrice")>
	<cfif finalPrice LT finalMinPrice>
		<cfset finalMinPrice = #Round(finalPrice)# /> 
	</cfif>  
<cfelse>
	<cfset finalMinPrice = #Round(finalPrice)# />
</cfif>

<cfif IsDefined("finalMaxPrice")>
	<cfif finalPrice GT finalMaxPrice>
		<cfset finalMaxPrice = #Round(finalPrice)# /> 
	</cfif>  
<cfelse>
	<cfset finalMaxPrice = #Round(finalPrice)# />
</cfif>



    <cfset ArrayAppend(eachProductArray,eachProductStruct) />

       
</cfloop><!---end GetSecondProductData--->

<!---<cfloop from="#productstart#" to="#productend#" index="i">
<cfset ArrayAppend(eachProductArraySome, eachProductArray[i])>
</cfloop>--->

<!---<cfset eachProductArray = arraySlice(eachProductArray, #productstart#, #productend#) />--->

<cfif sort EQ "pricelowhigh">
      <cfset eachProductArray = ArrayOfStructSort(eachProductArray, "Numeric", "asc", "final_price_rounded")>
</cfif>

<cfif sort EQ "pricehighlow">
      <cfset eachProductArray = ArrayOfStructSort(eachProductArray, "Numeric", "desc", "final_price_rounded")>
</cfif>

<cfif pricerange NEQ "">
	<cfset eachProductArray = ArrayOfStructSort(eachProductArray, "Numeric", "desc", "final_price_rounded")>
  <!---To Do: get position whose final_price_rounded value = 5--->
<!---	<cfset posone = 5 >     
	<cfset eachProductArray = arraySlice(eachProductArray, 5, 50) />    --->
</cfif>
<!---	<cfset eachProductArray = ArrayOfStructSort(eachProductArray, "Numeric", "desc", "final_price_rounded")>
	<cfset eachProductArray = arraySlice(eachProductArray, 5, 50) /> ---> 

<cfset initialProductIDList = ArrayToList(initialProductIDArray, ",")>

<cfset secondProductIDList = ArrayToList(secondProductIDArray, ",")>


<cfquery name="GetBrandData" datasource="#Application.ds#">
  SELECT b.Brand, p.Description, p.BrandID, p.ProductID, COUNT(*) as "product_count"
  FROM Products p, Brands b
  WHERE p.BrandID = b.BrandID
  AND p.Display = 1

<cfif concernfilter NEQ 0 OR specialsfilter NEQ 0>
  AND p.ProductID IN (#secondProductIDList#)
<cfelse>
  AND p.ProductID IN (#initialProductIDList#)
</cfif>
            
  Group by p.BrandID
  Order by b.Brand ASC
</cfquery>
 
  <cfloop query="GetBrandData">
    <cfset eachBrandStruct = StructNew() />
    <cfset eachBrandStruct["brand_id"] = #BrandID# />
    <cfset eachBrandStruct["brand_name"] = "#Brand#" />
    <cfset eachBrandStruct["count"] = #product_count# />
    <cfset eachBrandStruct["selected"] = #product_count# />
    <cfset  brandFilterArray = ListToArray(brandfilter)>
    <cfset hasBrand = ArrayContains(brandFilterArray, BrandID)>
    <cfif hasBrand EQ "YES">
      <!---If one of brandfilters value equals to BrandID then set selected to true--->
      <cfset eachBrandStruct["selected"] = true />
      <cfelse>
      <cfset eachBrandStruct["selected"] = false />
    </cfif>
    <cfset ArrayAppend(eachBrandArray,eachBrandStruct) />
  </cfloop>

<cfquery name="GetConcernsData" datasource="#Application.ds#">
	Select f.FormulaType, f.FormulaTypeID, COUNT(m.ProductID) as "product_count"
	from Product_Formula_Map m, FormulaTypes f
	Where m.FormulaTypeID = f.FormulaTypeID

  <cfif secondProductIDList NEQ 0>
  AND m.ProductID IN (#secondProductIDList#)  
  <cfelse>
  AND m.ProductID IN (#initialProductIDList#)  
  </cfif>     
    
    Group by f.FormulaType
</cfquery>

  <cfloop query="GetConcernsData">
    <cfset eachConcernStruct = StructNew() />
    <cfset eachConcernStruct["concern_id"] = #FormulaTypeID# />
    <cfset eachConcernStruct["concern_name"] = "#FormulaType#" />
    <cfset eachConcernStruct["count"] = #product_count# />
       
    <cfset eachConcernStruct["selected"] = #product_count# />
    <cfset  concernFilterArray = ListToArray(concernfilter)>
    <cfset hasConcern = ArrayContains(concernFilterArray, FormulaTypeID)>
    <cfif hasConcern EQ "YES">
      <cfset eachConcernStruct["selected"] = true />
      <cfelse>
      <cfset eachConcernStruct["selected"] = false />
    </cfif>    
    
    <cfset ArrayAppend(eachConcernArray,eachConcernStruct) />
  </cfloop>


  <!---<cfset specialFilterList = ( specialsfilter NEQ 0 )? "#specialsfilter#" : "554,865,313" />--->
  <cfset specialFilterList = "554,865,313" />
  <!---query only Weekly Specials, Buy 1 get 1 Free and Super Deals--->

<cfquery name="GetSpecials" datasource="#Application.ds#">
  SELECT sm.SUBCATEGORYID, sc.SUBCATEGORY, group_concat(sm.ProductID) as "product_id_list", COUNT(*) as "specials_count"
  FROM SubCategory sc, Product_SUBCategory_Map sm, Products p
  WHERE sm.SUBCATEGORYID IN (#specialFilterList#)
  AND sm.SUBCATEGORYID = sc.SUBCATEGORYID
  AND sm.ProductID = p.ProductID      

  <cfif productidfilter NEQ 0>
  AND sm.ProductID IN (#productidfilter#)
  <cfelseif brandfilter NEQ 0 or concernfilter NEQ 0>
  AND sm.ProductID IN (#secondProductIDList#)    
  <cfelse>
  AND sm.ProductID IN (#initialProductIDList#)  
  </cfif>  
    
  Group by sm.SUBCATEGORYID
</cfquery>

  <cfif GetSpecials.RecordCount GT 0>
    <cfset showSpecials = true>
    <cfelse>
    <cfset showSpecials = false>
  </cfif>
  <cfloop query="GetSpecials">
    <cfset eachSpecialStruct = StructNew() />
    <cfset eachSpecialStruct["special_id"] = #SUBCATEGORYID# />
    <cfset eachSpecialStruct["product_id_list"] = "#product_id_list#" />
    <cfset eachSpecialStruct["special_name"] = "#SUBCATEGORY#" />
    <cfset eachSpecialStruct["count"] = #specials_count# />
    <cfset  specialFilterArray = ListToArray(specialsfilter)>
    <cfset hasSpecial = ArrayContains(specialFilterArray, SUBCATEGORYID)>
    <cfif hasSpecial EQ "YES">
      <!---If one of specialsfilter value equals to SUBCATEGORYID then set selected to true--->
      <cfset eachSpecialStruct["selected"] = true />
      <cfelse>
      <cfset eachSpecialStruct["selected"] = false />
    </cfif>
    <cfset ArrayAppend(eachSpecialArray,eachSpecialStruct) />
  </cfloop>
  
  
  
  
  <cfset NumProducts = Ceiling(GetSecondProductData.Recordcount)>
  <cfset NumPages = Ceiling(GetSecondProductData.Recordcount/numberonpage)>
  <cfset currentPage = (startpage+1)>
  <cfset lastPageID = (NumPages-1)>
  <cfset lastPage = (currentPage EQ NumPages) ? true : false>
  <cfset firstPage = (startpage EQ 0) ? true : false>
  <cfset prevPage = (startpage EQ 0) ? 0 : (startpage-1)>
  <cfif productend GT NumProducts>
    <cfset productend = Ceiling(NumProducts)>
  </cfif>
  <cfif NumProducts GT 30>
    <cfset productsperpage = true>
    <cfelse>
    <cfset productsperpage = false>
  </cfif>
  <cfset perPageArray = [] />
  <cfif NumProducts GT 30>
    <cfset perPageArray[1] = {
"products" = 30,
"selected" = ((numberonpage EQ 30) ? true : false)
} />
    <cfset perPageArray[2] = {
"products" = 60,
"selected" = ((numberonpage EQ 60) ? true : false)
} />
    <cfset perPageArray[3] = {
"products" = 90,
"selected" = ((numberonpage EQ 90) ? true : false)
} />
  </cfif>
  <cfset sortArray = [] />
  <cfset sortArray[1] = {
"sort_value" = "nameaz",
"sort_title" = "Name: A to Z",
"selected" = ((sort EQ "nameaz") ? true : false)
} />
  <cfset sortArray[2] = {
"sort_value" = "nameza",
"sort_title" = "Name: Z to A",
"selected" = ((sort EQ "nameza") ? true : false)
} />
  <cfset sortArray[3] = {
"sort_value" = "pricelowhigh",
"sort_title" = "Price Low-High",
"selected" = ((sort EQ "pricelowhigh") ? true : false)
} />
  <cfset sortArray[4] = {
"sort_value" = "pricehighlow",
"sort_title" = "Price High-Low",
"selected" = ((sort EQ "pricehighlow") ? true : false)
} />
  <!---Output json--->
  <cfset brandsSelected = ( brandfilter NEQ 0 )? true : false />
  <cfset specialsSelected = ( specialsfilter NEQ 0 )? true : false />
  <cfset concernsSelected = ( concernfilter NEQ 0 )? true : false />
<cfif brandfilter NEQ 0 OR specialsfilter NEQ 0 OR concernfilter NEQ 0>
<cfset filterUsed = true>
<cfelse>
<cfset filterUsed = false>
</cfif>
  
  <!---output JSON data if found results--->
<cfcontent type="application/json">

  <cfoutput> {
    "found_products": true,
    "total_products": #GetSecondProductData.Recordcount#,
    "first_page": #firstPage#,
    "prev_page": #prevPage#,
    "is_last_page": #lastPage#,
    "filter_used": #filterUsed#,
    "show_specials": #showSpecials#,
    "brands_selected": #brandsSelected#,
    "specials_selected": #specialsSelected#,
    "concerns_selected": #concernsSelected#,            
    "next_page": #currentPage#,
    "last_page_id": #lastPageID#,
    "current_page": #currentPage#,
    "product_start": #productstart#,
    "product_end": #productend#,
    "min_price": #finalMinPrice#,
    "max_price": #finalMaxPrice#,    
    "show_per_page": #productsperpage#,
    "products_per_page": #serializeJSON(perPageArray)#,
    "products_sort": #serializeJSON(sortArray)#,
    "brands": #serializeJSON(eachBrandArray)#,
    "concerns": #serializeJSON(eachConcernArray)#,    
    "specials": #serializeJSON(eachSpecialArray)#,                            
    "products" : #serializeJSON(eachProductArray)# } 
	</cfoutput>
</cfif>
