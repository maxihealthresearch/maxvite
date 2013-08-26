<cfset eachProductArray = ArrayNew(1) />
<cfset initialProductIDArray = ArrayNew(1) />
<cfset secondProductIDArray = ArrayNew(1) />

<cfparam name="q" default="">
<cfparam name="numberonpage" type="integer" default="30">
<cfparam name="startpage" type="numeric" default="0">
<cfparam name="productstart" type="integer" default="1">
<cfparam name="productend" type="integer" default="30">
<cfparam name="productidfilter" type="string" default="0">


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
  SELECT DISTINCT p.ProductID
  FROM Products p, Product_Formula_Map pfm
  WHERE p.ProductID = pfm.ProductID
  AND p.Display = 1
                        
    AND p.ProductID IN (#URLDecode(productidfilter)#)

 
<!---<cfif productidfilter NEQ 0>
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
</cfif>  --->

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


<cfloop query="GetSecondProductData" startrow="1" endrow="30">


    <cfset eachProductStruct = StructNew() />
    <cfset eachProductStruct["product_id"] = #ProductID# />

    <!---check if product is buy 1 get 1 free--->
 
    <cfset ArrayAppend(eachProductArray,eachProductStruct) />

  </cfloop>

<cfset initialProductIDList = ArrayToList(initialProductIDArray, ",")>

<cfset secondProductIDList = ArrayToList(secondProductIDArray, ",")>


  <!---output JSON data if found results--->
  <cfoutput> {
  "secondProductIDList": "#initialProductIDList#",  
  "secondProductIDList": "#secondProductIDList#",
    "found_products": true,
    "total_products": #GetSecondProductData.Recordcount#,
    "products" : #serializeJSON(eachProductArray)# } </cfoutput>
</cfif>
