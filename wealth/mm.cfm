<cfinclude template="isuserok.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>

<HEAD>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html;CHARSET=iso-8859-1">
	<TITLE>Main Menu</TITLE>
	<script language="JavaScript">
	<!--
	function load(url,cc)
	{
	alert(cc)
	if (cc == TRUE)
	    parent.framedata.location.href= 'logon.cfm'
	else
	    parent.framedata.location.href= url
	}

	function clearwindow()
	{
	parent.framedata.location.href = "Frame797377.htm", "Frame797377","width=350,height=420,status=no,toolbar=no,menubar=no";
	}
	// -->
	</script>
</HEAD>

<BODY>
<b><u>Main Menu</u></b><BR><BR>
<hr>
<font face="" size="-1">
<b><u>Maintain</u></b><br>
<A HREF="customer-main.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">User Maintenance</a><BR>
<A HREF="category-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Categories</a><BR>
<A HREF="category-main.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Sub-Categories</a><BR>
<A HREF="brand-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Brands</a><BR>
<A HREF="ft-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Health Concern</a><BR>
<A HREF="products-main.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Products</a><BR>
<A HREF="products-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>&IMPORT=TRUE&FEATURED=FALSE&SCATEGORYID=-99&SSUBCATEGORYID=-99&KEYWORD=" target="framedata">Show Last Product Import Feed</a><BR>
<A HREF="duplicate-upc-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Duplicate UPC w/out 0</a><BR>
<A HREF="homeimage-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Homepage Images</a><BR>
<A HREF="brandspecial-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Brand Specials</a><BR>
<A HREF="email-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Emails</a><BR>
<A HREF="so-d.cfm?Process=M&Action=M&<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">System Options</a><BR>
<A HREF="st-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Shipping Types</a><BR>
<A HREF="stp-menu.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Shipping Prices</a><BR>
<A HREF="coupons-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Coupons</a><BR>
<A HREF="autosuggest-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Autosuggest</a><BR>
<A HREF="ProductDeal-l.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Deal</a><BR>
<A HREF="ordermenu.cfm?UserID=1&Action=M&<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Orders</a><BR>
<A HREF="ordersmenu-amazon.cfm?UserID=1&Action=M&<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Amazon Orders</a><BR>

<!---<A HREF="amazon-buyers-emails.cfm?UserID=1&Action=M&<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Amazon Buyers Emails</a><BR>--->

<A HREF="billing-main.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">QB Export</a><BR>
<A HREF="hometext.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Home Text</a><BR>
<A HREF="aboutus.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata"> About Us</a><BR>
<A HREF="GoogleSiteMaster.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata"> Create Google Site Master</a><BR>
<A HREF="GoogleBase.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata"> Create Google Base Upload</a><BR>
<A HREF="Living1.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Upload Living Naturally File</a><BR>

<A HREF="orderexport.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="_blank">Export Orders Last 30 Days</a><BR>
<A HREF="schedulefeed-d.cfm" target="framedata">Power Review Feed</a><BR>
<BR>
<A HREF="errorlog.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="framedata">Error Log</a><BR>
<BR>
<A HREF="logout.cfm?<cfoutput>CFID=#client.CFID#&CFTOKEN=#client.CFTOKEN#</cfoutput>" target="_top">Logout</a><BR>

<HR>
<br>
</font>
</BODY>

</HTML>