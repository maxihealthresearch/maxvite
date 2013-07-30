<cfquery name="GetDataImage" datasource="#Application.ds#">
	SELECT * from homeimages
	ORDER BY SortID
</CFQUERY>
<cfquery name="GetHomeText" datasource="#Application.ds#">
	SELECT HomeText FROM AboutUs 
</cfquery>
<cfinclude template="/doctype.cfm">
<cfinclude template="/html.cfm">
<head>
<title>Skin Vitamins & Supplements, Best Vitamins for Hair, Eyes, Muscles &ndash; Maxvite.com</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="author" content="MaxVite">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="verify-v1" content="2qEa0Zn/k8w/fd2pxQAwdb9yha3hU4n9+BqQBX6s0Es=">
<meta name="google-site-verification" content="sR8zeesYO7SREK3XvoIsriGxwaTDWg2GHtJjkTW1b1o" />
<meta name="y_key" content="2703e6bd2dca9b8c">
<meta name="Description" content="skin vitamins, best vitamins for hair, eye vitamins, bone vitamin, antioxidant supplements, stress vitamins, Cholesterol vitamins, brain vitamins, muscle supplements, vitamins for energy">
<meta name="Keywords" content="Skin Vitamins, Best Vitamins For Hair">
<meta name="msvalidate.01" content="5781438C69C354528E4218C2C8FFD0B5">
<link rel="shortcut icon" type="image/ico" href="favicon.ico" />
<cf_styles>
<link rel="stylesheet" href="/css/home.min.css?v=<cfoutput>#Rand('SHA1PRNG')#</cfoutput>" media="screen">
</head>
<body>
<cfinclude template="/header.cfm">
<section id="middleArea"> 
<section id="primary">
<a href="/shipping.html" id="freeShipBnr"><img src="/img/free-ship-bnr.gif" alt=""></a>
      <div id="adgroup">
        <div id="slides">
          <cfset iCounter=0>
          <cfoutput query="GetDataImage">
            <cfset iCounter=iCounter+1>
            <div id="#iCounter#"> <a href="#LinkURL#"><img title="#ImageName#" src="/img/featured-ads/#FileName#" width="716" height="318" /> </a> </div>
          </cfoutput> </div>
      </div>

<img src="/img/home-featured-bnr.png" alt="featured brands" usemap="#brandsmap">

      <map name="brandsmap">
        <area shape="rect" coords="0,0,130,63" href="/1/Maxi-Health/Brand.html" alt="Maxi Health">
        <area shape="rect" coords="130,0,211,63" href="/3/TwinLab/Brand.html" alt="Twinlab">
        <area shape="rect" coords="211,0,273,63" href="/6/Solgar/Brand.html" alt="Solgar">
        <area shape="rect" coords="273,0,355,63" href="/5/Natures-Answer/Brand.html" alt="Nature's Answer">
        <area shape="rect" coords="355,0,441,63" href="/23/Natrol/Brand.html" alt="Natrol">
        <area shape="rect" coords="441,0,513,63" href="/4/Natures-Way/Brand.html" alt="Nature's Way">
        <area shape="rect" coords="513,0,653,63" href="/119/American-Health/Brand.html" alt="American Health">
        <area shape="rect" coords="653,0,718,63" href="/181/Bach/Brand.html" alt="Bach">
      </map>
      <!-- hometabs -->
      <ul class="hometabs">
        <li id="homeWaysTab"><a href="#homeWaysContent">Ways To Shop</a></li>
        <li id="homeSpecialsTab"><a href="#homeSpecialsContent">Specials</a></li>
      </ul>
      <div class="tab_container">
        <div id="homeWaysContent" class="tab_content">
    <div class="left-col"><a href="/healthconcerns.html" title="">&nbsp;</a></div>
    <div class="right-col"><a href="/thumbpics2.cfm?SearchType=K&searchkeywords=chewable&as_values_MYKEYWORD" class="age" title="">&nbsp;</a></div>
    <div class="left-col"><a href="/ingredients.html" class="ingredients" title="">&nbsp;</a></div>
    <div class="right-col"><a href="/brands.html" class="brand" title="">&nbsp;</a></div>
    <div class="left-col"><a href="/14/FT/Mens-Health/items.html" class="men" title="">&nbsp;</a></div>
    <div class="right-col"><a href="/23/FT/Womens-Health/items.html" class="women" title="">&nbsp;</a></div>
        </div>
<!---        <div id="homeSpecialsContent" class="tab_content"><cfinclude template="/home-specials.cfm"></div>--->
        <div id="homeSpecialsContent" class="tab_content"></div>
      </div>
      <!--end tab menu-->


 
   <cfoutput query="GetHomeText"><div class="clear">#HomeText#</div></cfoutput>



</section><cfinclude template="/secondary.cfm"></section> <!--end middleArea-->
<cfinclude template="/footer.cfm">
<script src="//ajax.aspnetcdn.com/ajax/jquery.cycle/2.99/jquery.cycle.all.min.js"></script>
<script src="/js/home.min.js"></script> 
</body>
</html>