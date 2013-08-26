<cfparam name="q" default="">
<cfparam name="startpage" type="numeric" default="0">
<cf_doctype>
<cf_html>
<head>
	<title><cfoutput>#q#</cfoutput> - Search Results: MaxVite</title>
	<cf_meta10>
    

<link rel="stylesheet" href="/css/listpage.css">
<link rel="stylesheet" href="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/pr_styles_review.css" type="text/css" id="prBaseStylesheet">
<link rel="stylesheet" href="http://cdn.powerreviews.com/aux/14165/636016/css/express.css" type="text/css" id="prMerchantOverrideStylesheet">
</head>


<body>
<div class="wrapper">
<cf_header>

<div class="content">
 
<div class="primary">


<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>

<a name="topOfPage"></a>



<h1>Search Results for: "<cfoutput>#q#</cfoutput>"</h1>
<br />






    <p></p>


<div id="listProductsWrap">Loading Products...</div>
<br><p class="small">*These statements have not been evaluated by the Food and Drug Administration. These products is not intended to diagnose, treat, cure, or prevent any diseases.</p>


</div> <!--end primary-->
<section id="filterSection"></section>
 
</div> 
<!--end content-->


  <script id="filterTpl" type="text/x-handlebars-template">
{{#if found_products}}
<ul id="refineResults">
  <li>Refine Results</li>
  <li class="refine-results-clearall hidden"><a href="clear all">Clear All</a></li>
</ul>

<div class="filter-module filter-module-brand" data-module="brand">
<ul class="filter-module-title">
  <li>Brand</li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear {{#unless brands_selected}}hidden{{/unless}}"><a href="clear">Clear</a></li>
</ul>

<ul class="checkbox-list filter-module-main">
{{#each brands}}
<li data-brandid="{{brand_id}}" {{#if selected}}class="checkbox-list-selected"{{/if}}>
<span class="filter-module-checkbox">&nbsp;</span>
<label alt="{{brand_name}}" for="{{brand_id}}">{{brand_name}} <span class="filter-module-checkbox-count">({{count}})</span></label>
</li>
{{/each}}
</ul>

</div>


<div class="filter-module filter-module-concern" data-module="concern">
<ul class="filter-module-title">
  <li>Health Concern</li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear {{#unless concerns_selected}}hidden{{/unless}}"><a href="clear">Clear</a></li>
</ul>

<ul class="checkbox-list filter-module-main">
{{#each concerns}}
<li data-concernid="{{concern_id}}" {{#if selected}}class="checkbox-list-selected"{{/if}}>
<span class="filter-module-checkbox">&nbsp;</span>
<label alt="{{concern_name}}" for="{{concern_id}}">{{concern_name}} <span class="filter-module-checkbox-count">({{count}})</span></label>
</li>
{{/each}}
</ul>

</div>



{{#if show_specials}}
<div class="filter-module filter-module-specials" data-module="specials">
<ul class="filter-module-title">
  <li>Specials</li>
  <li class="filter-module-toggler">Show/Hide</li>
  <li class="filter-module-clear {{#unless specials_selected}}hidden{{/unless}}"><a href="clear">Clear</a></li>
</ul>

<ul class="checkbox-list filter-module-main">
{{#each specials}}
<li data-specialid="{{special_id}}" data-productids="{{product_id_list}}" {{#if selected}}class="checkbox-list-selected"{{/if}}>
<span class="filter-module-checkbox">&nbsp;</span>
<!---<input type="checkbox" class="checkbox-list-option" value="{{special_id}}" {{#if selected}}checked="true"{{/if}}>--->
<label alt="{{special_name}}" for="{{special_id}}">{{special_name}} <span class="filter-module-checkbox-count">({{count}})</span></label></li>
{{/each}}     
</ul>

</div>
{{/if}}

{{/if}}
</script>

<script id="listTpl" type="text/x-handlebars-template">
{{#if found_products}}
<cf_listpage-toolbar>			
<ol class="items items-list hidden">
{{#each products}}  
      <li>
        
        <dl>
          <dd><a href="{{product_url}}"><span></span><img alt="{{name}}" src="{{image_url}}"></a></dd>
          <dd class="items-list-info">
            <p class="items-list-info-title"><a href="{{product_url}}">{{name}}</a></p>
            <p><a href="{{product_url}}">{{{strap_line}}}</a></p>
            <dl class="items-list-sizeform">
              
                <dt>Serving Size:</dt>
                <dd>{{serving_size}}</dd>
              
                <dt>Size/Form:</dt>
                <dd>{{form}}</dd>
              
            </dl>
          </dd>
          <dd class="items-list-pricing">
              
{{#if bogo}}
			  <p class="items-list-ourprice">Get Two For Only ${{list_price}}<br>Buy 1 Get 1 Free</p>
			  <p>Get 1 for ${{final_price}}&nbsp;&nbsp;&nbsp;<span class="items-list-pricing-usave">You Save: ${{dollars_saved}} ({{percent_saved}})%</span></p>
{{/if}}
              
{{#if list_price}}
			  	{{#unless bogo}}
				<p class="items-list-ourprice">Our Price: ${{final_price}}</p>
				<p><span class="items-list-listprice">List Price: <span class="strike">${{list_price}}</span></span>&nbsp;&nbsp;&nbsp;<span class="items-list-pricing-usave">You Save: ${{dollars_saved}} ({{percent_saved}})%</span></p>
				{{/unless}}
{{/if}}              
			  {{#if just_price}}<p class="items-list-ourprice">Price: ${{final_price}}</p>{{/if}}
          
            {{#unless instock}}<p><a class="btn btn-muted" href="{{product_url}}">Out of Stock</a></p>{{/unless}}
			{{#if instock}}
              <form class="additemform">
                                <input type="hidden" value="{{product_id}}" name="ProductID">
								<ul class="items-list-qty-box">
								<li>Quantity</li>
								<li>cf_listpage-product-qty></li>
								<li><button class="btn bigButton" name="addtocart" type="submit">Add To Cart</button><span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span></li>
								</ul>                
              </form>
              {{/if}}
			  
			  {{#if show_min_qty_list}}<p class="small">Minimum Order Qty: 3</p>{{/if}}
			
			<div class="pr_snippet_category" id="pr_snippet_category{{product_id}}">
              {{{rating_list}}}
            </div>

          </dd>
        </dl>
        <div class="clear"></div>
      </li>
{{/each}}

</ol>

<ol class="items items-grid block">


{{#each products}}  
      <li class="items-grid-node">
        <dl style="display: block;">
          <dd class="items-grid-thumb"><a href="{{product_url}}"><span></span><img alt="{{name}}" src="{{image_url}}"></a></dd>
          <dt class="items-grid-title"><a href="{{product_url}}">{{name}}</a></dt>
          <dd class="items-grid-form">{{form}}</dd>
 			  {{#if bogo}}
			  <dd class="items-grid-bogo">Get Two For Only ${{list_price}}<br>Buy 1 Get 1 Free</dd>
			  <dd>Get 1 for ${{final_price}}</dd>
			  {{/if}}
         
              {{#if list_price}}
			  	{{#unless bogo}}
			  	<dd class="items-grid-listprice">
				<ul><li>List Price:&nbsp;</li><li class="strike">${{list_price}}</li></ul>				
				</dd>
                <dd class="items-grid-bigprice"><span class="green">Our Price:</span> ${{final_price}}</dd>
				{{/unless}}
                <dd>You Save:&nbsp;${{dollars_saved}} ({{percent_saved}})%</dd>
			  {{/if}}
              
			  {{#just_price}}<dd class="items-grid-bigprice">Price: ${{final_price}}</dd>{{/just_price}}
			  

              
          <dd class="addToCartBox">
                        {{#unless instock}}<a class="btn btn-muted" href="{{product_url}}">Out of Stock</a>{{/unless}}
			{{#if instock}}
              <form class="additemform">
                                <input type="hidden" value="{{product_id}}" name="ProductID">
								<ul class="items-list-qty-box">
								<li>Qty.</li>
								<li><cf_listpage-product-qty></li>
								<li><button name="addtocart" class="btn">Add To Cart</button><span class="addingItemMsg"><img src="/img/spinner.gif"> Adding To Cart</span></li>
								</ul>                
              </form>
			{{/if}}
			  {{#if show_min_qty_list}}<p class="small">Minimum Order Qty: 3</p>{{/if}}
			
			<div class="pr_snippet_category" id="pr_snippet_category_{{product_id}}">
              {{{rating_grid}}}
            </div>
			
          </dd>
        </dl>
        
        <div class="clear"></div>
      </li>
{{/each}}

</ol>

<!---product-grid end--->

<cf_listpage-toolbar>			
{{/if}}
</script>

<script>
<cfoutput>
var Searchkeywords = {
	query: "search-query.cfm?q=#q#"
}
</cfoutput>
</script>
 
 <cf_footer>
 
</div><!--end wrapper-->

<script type="text/javascript">
var pr_style_sheet="http://cdn.powerreviews.com/aux/14165/636016/css/express.css";
</script>
<script type="text/javascript" src="http://cdn.powerreviews.com/repos/14165/pr/pwr/engine/js/full.js"></script>
<script src="http://malsup.github.com/jquery.blockUI.js"></script>
<script src="/js/handlebars.js"></script>      
<script src="/js/searchcontroller.js"></script>
</body>
</html>
