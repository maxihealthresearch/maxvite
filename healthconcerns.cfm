<cfquery name="GetHealthType" datasource="#Application.ds#">
	SELECT * from FormulaTypes Where FormulaTypeID <> 26 AND SortID = 1
	ORDER BY FormulaType
</CFQUERY>
<cf_doctype>
<cf_html>
<head>
	<title>Health Concerns</title>
<cf_commonmetas>


<cf_styles> 
      <script type="text/javascript">
//jQuery.noConflict();
jQuery(document).ready(function($){
	$('#concernsPageMenuList').makeacolumnlists({cols: 3, colWidth: 0, equalHeight: 'ul', startN: 1});
});
</script>
</head>


<body>
<div class="wrapper">
<cf_header>

<div class="content">
 
<div class="primary">



<h1>Health Concerns</h1>

        <div class="split-box">
          <ul id="concernsPageMenuList">
<cfoutput query="GetHealthType">
<li><a href="/#FormulaTypeID#/FT/#replace(replace(replace(URL," ", "_", "all"),",","","all"),"&","","all")#/items.html">#FormulaType#</a></li>
</cfoutput>
          </ul>
        </div>




</div> <!--end primary-->
<cf_secondary>

 
</div> 
<!--end content-->
 
 <cf_footer>
 
</div><!--end wrapper-->
</body>
</html>
