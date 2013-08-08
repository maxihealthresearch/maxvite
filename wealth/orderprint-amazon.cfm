<cftry>

<cfinclude template="isuserok.cfm">

<cfset OrderID = URL.amazonId>

<cfif isDefined("Process")>
	<cfif #Process# eq "CS">
		<!--- Update Print Status --->
        <cfquery name="UpdatePrintStatus" datasource="#Application.dso#">
            UPDATE amazon_orders
            SET isPrinted = <cfqueryparam value="Printed" cfsqltype="cf_sql_varchar">
            WHERE amazon_order_id = <cfqueryparam value="#OrderID#" cfsqltype="cf_sql_varchar">
        </cfquery>
    </cfif>
</cfif>

<cfquery name="GetData" datasource="#Application.dso#">
	SELECT * FROM amazon_orders
	WHERE amazon_order_id = <cfqueryparam value="#OrderID#" cfsqltype="cf_sql_varchar">
</CFQUERY>

<HTML> 

<HEAD>
<TITLE></TITLE>
<style>
body, table, td {margin:0; padding:0; }
body, table, td, tr {
	line-height: 1.4em; word-spacing:1px; letter-spacing:0.2px; font: 12px Arial, Helvetica,"Lucida Grande", serif; color: #000;
}

</style>
	<!--<LINK HREF="http://www.maxvite.com/style.css" TYPE="text/css" REL="stylesheet">-->
</HEAD>
<BODY bgcolor="#FFFFFF" text="#000000" link="#CC0033" vlink="#CC0033" alink="#CC0033" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="10" onLoad="javascript:window.opener.location.reload();">				
	<cfoutput query="GetData">
	
	<img src="https://www.maxvite.com/images/hearty-logo.jpg" width="197" height="76" border="0">
   
   
   	 <table border="0" cellpadding="0" cellspacing="3">
			<tr> 
				<td colspan="2" class="orderform"><b>ORDER NUMBER: #OrderID#<br>Order Placed on:  #DateFormat(ORDERDATE)#</b><p></td>
			</tr>
			</table>
			
	
	 <table border="0" cellpadding="0" cellspacing="3">
     	
        	<tr> 
				<td colspan="2" class="orderform">
                	<img src="http://www.barcodesinc.com/generator/image.php?code=#OrderID#&style=197&type=C128B&width=200&height=50&xres=1&font=3" alt="the barcode printer: free barcode generator" border="0">
                </td>
			</tr>
            
            
			<tr> 
				<td colspan="2" class="orderform"><b>SHIPPING INFORMATION</b><hr width="80%" align="left"></td>
			</tr>
            
            <tr> 
                <td class="orderform"><b>Name: </b></td>
                <td  class="orderform" width="256">#NAME#</td>
            </tr>
            <tr> 
                <td class="orderform"><b>Address: </b></td>
                <td  class="orderform" width="256">#ADDRESS#</td>
            </tr>
            <tr> 
                <td class="orderform"><b>City: </b></td>
                <td  class="orderform" width="256">#CITY#</td>
            </tr>
            <tr> 
                <td	class="orderform"><b>State: </b></td>
                <td  class="orderform" width="256">#STATE#</td>
            </tr>
            <tr> 
                <td class="orderform"><b>Zip Code:</b></td>
            <td  class="orderform" width="256">#ZIPCODE#</td>
            </tr>
            <tr> 
                <td class="orderform"><b>Country Code:</b></td>
            	<td  class="orderform" width="256">#COUNTRYCODE#</td>
            </tr>
            <tr> 
                <td class="orderform"><b>Phone: </b></td>
                <td  class=orderform width="256">#PHONE#</td>
            </tr>
            <tr> 
                <td class="orderform"><b>E-Mail: </b></td>
                <td class="orderform" width="256">#BUYEREMAIL#</td>
            </tr>
            <tr> 
                <td class="orderform"><b>Payment Method:</b></td>
                <td class="orderform" width="256">#ORDERPAYMENTMETHOD#</td>
            </tr>
		</table>
	

   
   
             <table border="0" cellpadding="0" cellspacing="3" width="600">
                <tr>
                    <td  colspan="2">&nbsp;</td>
                </tr>
			
			</cfoutput>		
			<tr> 
				<td colspan="2" class="orderform"><b>ORDER INFORMATION</b><hr></td>
			</tr>		
			
			
						<tr> 
				<td colspan="2" class="orderform">
                 <cfquery name="GetData1" datasource="#Application.dso#">
                        SELECT * FROM amazon_order_items
                        WHERE OrderId = <cfqueryparam value="#OrderID#" cfsqltype="cf_sql_varchar">
                 </CFQUERY>

                <table>
                    <tr valign="top">
            
                        <td width="10%" class="linksproducts">
                        <b><u>ItemID: </u></b></td>
            
            
                        <td width="60%" class="linksproducts">
                        <b><u>Item: </u></b></td>
                        <td align=middle width="15%"  class="linksproducts">
                            <b><u>Quantity: </u></b></td>
                        <td width="15%"  class="linksproducts">
                            <b><u>Price: </u></b>
                        </td>
                        <td align=left width="15%" class="linksproducts"><b><u>Total: </u></b></td>
                    </tr>				
                

                        
					<CFOUTPUT QUERY="GetData1">
                        <tr valign="top">
                    
                    		<!--- Item ID --->
                            <td width="10%" class="orderform">#OrderItemId#
                            <br>
                            <img src="http://www.barcodesinc.com/generator/image.php?code=#SellerSKU#&style=197&type=C128B&width=200&height=50&xres=1&font=3" alt="the barcode printer: free barcode generator" border="0">
                            </td>
                    		
                            <!--- Item Title --->
                            <td width="60%" class="orderform">                            	
                                <a target="_blank" href="http://www.amazon.com/gp/product/#ITEMASIN#">#ItemTitle#</a>                    
                            </td>
                    		<!--- Item Quantity --->
                            <td align=middle width="15%" class="orderform">
                                #QuantityOrdered#
                            </td>
                            <!--- Item Price --->
                            <td width="15%" class="orderform">
                                <font color=##990000>#NumberFormat((ItemPrice/QuantityOrdered),"999.99")# </font>
                            </td>
                            <!--- Item Total Price --->
                            <td align=left width="15%" class="orderform">
                                <font color=##990000>#NumberFormat(ItemPrice,"999.99")#</font>
                            </td>
                            <td><img src="/img/invoice-checkbox.gif" style="margin-left:20px; border:0;"></div></td>
                        </tr>
                        
                        
                    </CFOUTPUT>
                </table>
		
		</td>
			</tr>	
			</table>
			

			
<cfquery name="GetData" datasource="#Application.dso#">
    SELECT * FROM amazon_orders
	WHERE amazon_order_id = <cfqueryparam value="#OrderID#" cfsqltype="cf_sql_varchar">
</CFQUERY>
<cfquery name="GetitemsData" datasource="#Application.dso#">
    SELECT ShippingPrice, ShippingTax FROM amazon_order_items
	WHERE OrderId = <cfqueryparam value="#OrderID#" cfsqltype="cf_sql_varchar">
    LIMIT 0,1
</CFQUERY>
	<cfoutput query="GetData">
	<table cellspacing="2" cellpadding="5" border="0" width="625">
			 <tr>
                  <td class="orderform"><b>SubTotal</b> </td>
					<td  width="15%" align="center"  class="orderform">#DollarFormat(ORDERTOTALAMOUNT)#</td>
			 </tr>
			 <tr>
                  <td  class="orderform"><b>Shipping</b> - #ORDERPAYMENTMETHOD# </td>
					<td   align="center" class="orderform">$#NumberFormat(GetitemsData.ShippingPrice,"999.99")#</td>
			 </tr>
              <tr>
                  <td  class="orderform"><b>Tax</b> </td>
					<td   align="center" class="orderform">$#NumberFormat(GetitemsData.ShippingTax,"999.99")#</td>
			 </tr>
			<!--- <tr>
                  <td  class="orderform"><b>Shipping Status : </b> </td>
					<td   align="center" class="orderform">#ORDERSTATUS#</td>
			 </tr>--->
			 <!---<tr>
                  <td  class="orderform"><b>No. of shipped Items : </b> </td>
					<td   align="center" class="orderform"><b>#NUMBEROFSHIPPEDITEMS#</b></td>
			 </tr>--->			 			
             <tr>
                  <td  class="orderform"><b>No. of UnShipped Items :</b> </td>
					<td   align="center" class="orderform"><b>#NUMBEROFUNSHIPPEDITEMS#</b></td>
			 </tr>			 			
			</table>
</cfoutput>
<br>
<!---<hr>--->
			
<!---<div style="color:#666">
<strong>Ruturns are easy & simple</strong>
<br><br>
Follow these simple steps to return your purchase:
<br>
<ol>
<li>On the invoice, check the checkbox next to item(s) you're returning.</li>
<li>Pack your return securely, in the original package if possible, and include your completed invoice.</li>
<li>Use the mailing address below to address your return shipment</li>
</ol>
<br>
MaxVite.com<br>
1305 Avenue U<br>
Brooklyn, NY 11229<br>
Attn: Returns Department
<br><br> 

Returns are accepted 45 days price date of purchase & must be unopened & in sellable condition. It is advisable to send with proper tracking we are not responsible for items shipped without tracking. Allow 7 business days for us to process your credit.
</div>--->
</BODY>

</HTML>



<cfcatch>
	<cfdump var="#cfcatch#">
</cfcatch>
</cftry>