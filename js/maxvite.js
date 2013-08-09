//////////////////////////
//The scripts on this page are for non-checkout pages only
//

function disableEnterKey(e)
{
     var key;
     if(window.event)
          key = window.event.keyCode; //IE
     else
          key = e.which; //firefox

     return (key != 13);
}

function validateFields() {
  if (document.nutritionistForm.email.value.indexOf('@') < 0) {
  alert('Please Enter a Valid E-Mail Address');
  return false;
  }
return true;
}

function addToCart(qtyName) {
 var currentQty = document.getElementById(qtyName);
  if (currentQty.value == '' || (isNaN(currentQty.value)))
	{
		alert('Please enter a qty!!');
		return false;
	}
  if (currentQty.value < 1)
	  {
		  alert('The minimum qty for this item is 1');
		  return false;
	  }
return true;
}

// make link "Read x Review" go to "Reviews" tab
		function reviewstab() {
		$('#productTabs').tabs('select', 'reviewsContent');// switch to reviews tab
		var productTabs = $("#productTabs");
		var tabPosition = productTabs.position();		
		window.scrollTo(0,tabPosition.top);
  		}
		
//****** jQuery - Execute scripts after DOM is loaded
$(function(){ 
// Autocomple start


	    function submitSearchForm() {
	        $('#searchform')
	            .submit();
	    }

	    $("#primarySearch")
	        .autocomplete({
	        source: "/autocomplete_query5.cfm",
	        minLength: 3,
	        focus: function () {
	            // prevent value inserted on focus
	            return false;
	        },
	        select: function (event, ui) {
	            window.location.href = "/itemdetail.cfm?ProductID=" + ui.item.value;
	            return false;
	        },
	        open: function (event, ui) {
	            $("ul.ui-autocomplete, ul.ui-autocomplete li a")
	                .removeClass("ui-corner-all");
	            $('<li id="other-search"><a href="/thumbpics2.cfm?SearchType=K&as_values_MYKEYWORD&searchkeywords=' + $('#primarySearch')
	                .val() + '">See all results for "' + $('#primarySearch')
	                .val() + '"</a></li>')
	                .appendTo('ul.ui-autocomplete.ui-menu');
	        }
	    })
	        .data("autocomplete")
	        ._renderItem = function (ul, item) {
	        return $("<li></li>")
	            .data("item.autocomplete", item)
	            .append("<a><ul id='autocomleteItem'><li><img src='" + escape(item.icon) + "'></li><li>" + item.label + "<br><span class='price'>" + item.price + "</span></li></ul></a>")
	            .appendTo(ul);
	    }

//Autocomplete end 

//Customer feedback
//Disabled feedback code until further notice from Berish
/*if (localStorage.getItem("feedback") === null) {
  $('#feedbackLink').show();
}
  $('#feedbackLink').click(function(ev){
	popUp(this.href, 600, 400);

	return false;
  });*/


//header tab flyout function
$('.headerTab').click(function() {
var $parent = $(this).parent();							   
//hide other flyouts							   
$('#signinFlyout, #cartPreviewItemsBox').hide();
$('#hdrAccount li, #cartPreviewTab').removeClass("active");
$parent.siblings().children('.topNavFlyout').hide();
$parent.siblings().removeClass("active");
//main function
$parent.toggleClass("active").children(".topNavFlyout").slideToggle(100);
	return false;
})


// toggle categories on product page
$(".xpandList").show();
var $moreCats = $(".xpandList li").not(":first-child");
$moreCats.hide();
$(".formulaHead, .categoryHead").click(function(){
$(this).next().find($moreCats).slideToggle(100);
})
.toggle( function() {
    $(this).children("span").empty().append("<img src='/img/list-minus.gif'>");
}, function() {
    $(this).children("span").empty().append("<img src='/img/list-plus.gif'>");
}); 


 		// Email a Friend Popup
		$("#emailProductDialog").dialog({ autoOpen: false })	   
		$('ul#productTools li.productToolEmail a').click(function() {
 		$("#emailProductDialog").dialog('open')
		// prevent the default action, e.g., following a link
		return false;
		});

		// tab menu on product page
		$("#productTabs").tabs();
		//remove some default jquery ui classes
		$('#productTabs').removeClass('ui-corner-all ui-widget-content');
		$('#productTabs ul').removeClass('ui-corner-all ui-widget-header');
		$('#productTabs div').removeClass('ui-tabs-panel ui-corner-bottom');
		$('#productTabs li').removeClass('ui-corner-top');


// regular popup window function
function popUp(url, width, height) {
    var page = url;
    var width = width;
    var height = height;
    var windowprops = "toolbar=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width="+width+", height="+height+"";
    window.open(page, 'PopupName', windowprops);
}
//
$('.productToolEmail a').click(function(ev){
popUp(this.href, 600, 400);
return false;
})

var ajax_load = "<img class='loading' src='/img/spinner.gif' alt='loading...' />";

function rollDown() {
	$("#hdrCartListShowMiniCart span").addClass("active");
	setTimeout(function() { $("#cartPreviewItemsBox").slideDown("slow");}, 400);
}
function rollUp() {
   	$("#cartPreviewItemsBox").slideUp("200");
	$("#hdrCartListShowMiniCart span").removeClass("active");
}

// AJAX
$.ajaxSetup ({
	cache: false
/*	,
	error:function(x,e){
		if(x.status==404){
		alert('Requested URL not found.');
		}else if(x.status==500){
		alert('Internel Server Error.');
		}else if(e=='parsererror'){
		alert('Error.\nParsing JSON Request failed.');
		}else if(e=='timeout'){
		alert('Request Time out.');
		}
	}
*/
});
	
function minicart() {
    var loadMinicart = "/minicart_process.cfm";


    $.ajax({
        type: "GET",
        url: '/ajax/store_items2.cfc',
        dataType: "json",
        data: {
            method: "GetStoreItemsCount"
        },
        success: storeItemsResponse
    });

    function storeItemsResponse(data) {
        //var obj = jQuery.parseJSON(data);

        if (data.STOREITEMS >= 1) {
            $('#emptyCartList').hide();
            $('#cartHeaderNav').show();
        } else {
            $('#emptyCartList').show();
        }
        $('.storeItemsQty').html(data.STOREITEMS);
    }

    $("#cartPreviewItemsBox").html(ajax_load).load(loadMinicart);

}

minicart();

$(".additemform").submit(addItem);

  function addItem() {
	  //$(this).find(":button").hide();
	  $(":button", this).hide();
	  $('.addingItemMsg', this).show();

	  var allFields = $(this).serialize();
		$.ajax({
		type: 'POST',
		url: '/additem.cfm',
		data: allFields,
		success: minicart,
	  	complete: function(){
		$('.addingItemMsg').hide();
		$(":button").show();
		$( 'html, body' ).animate( { scrollTop: 0 }, 'slow' );
		rollDown();
		setTimeout(rollUp, 7000);
   		}
		
	  });
	  return false;
  }
// end cart preview code

// Start header section

//Add watermarks to usernmame & password. Works in conjunction with jquery.watermark.min.js
        $("#trackOrderForm input[name='orderid']").watermark("Order ID");
        $("#trackOrderForm input[name='orderemail']").watermark("Email");
        $("#menuUsername").watermark("Email");
        $("#menuPassword").watermark("Password");

$("#signinForm").validate({
	rules: {
		username: {
			required: true,
			email:true
		},
		password: {
			required: true,
			minlength: 5
		}
	}
});

//track-order
    $("#trackOrderForm").submit(function() {
        $.post("/callback-tracker.cfm", $("#trackOrderForm").serialize(), function(data) {
            if (data.orderid_isvalid == 'validorderid') {
                if (data.orderid_isfound == 'foundorderid') {

                    if (data.orderemail_isvalid == 'validorderemail') {
                        if (data.orderemail_isfound == 'foundorderemail') {

                            if (data.shipurl != '') {
                                window.open( data.shipurl, "trackWin" );
                            } else {
                                
							if (data.tracking_isavailable == 'notyet') {
                                $("#trackMsgPost").html("Tracking number is not available yet. Please check back later.");
                            } else {
                                $("#trackMsgPost").html("No tracking information is available. Please call 718-645-7074 if you have any questions.");
                            }
								
								
                            }

                        } else {
                            $("#trackMsgPost").html("Your order number and email don't match. Please try again.");
                        }



                    } else {
                        $("#trackMsgPost").html("Invalid email. Please try again.");
                    }


                } else {
                    $("#trackMsgPost").html("The above order number cannot be found. Please try again.");
                }
            } else {
                $("#trackMsgPost").html("Incorrect order ID. Please try again.");
            }
        }, "json");

        return false;

    });
//	

//prevent link from redirecting to url specified in <a> tag
$("#hdrAccountSignIn > a, #hdrAccountTrack > a").click(function (e) {
        e.preventDefault();
});

    $("#hdrTabs li, #hdrAccount li").hoverIntent(

    function () {
        var div = $(this).children("div");
        div.stop(true, true);
        div.slideDown(500);
    }, function () {
        var div = $(this).children("div");
        div.stop(true, true);
        div.slideUp(500);
    });

    $("#hdrCartListShowMiniCart").hoverIntent(

    function () {
        $("#cartPreviewItemsBox").slideDown(1000);
        $("#hdrCartListShowMiniCart span").addClass("active");
    }, function () {
        $("#cartPreviewItemsBox").slideUp(1000);
        $("#hdrCartListShowMiniCart span").removeClass("active");
    });

    // Break Health Concerns and Brands header flyouts into columns. requires columnizer.js
    $('#concernMegaMenuList').makeacolumnlists({
        cols: 5,
        colWidth: 0,
        equalHeight: false,
        startN: 1
    });
    $('.hdrBrandListWrpr ul').makeacolumnlists({
        cols: 3,
        colWidth: 0,
        equalHeight: false,
        startN: 1
    });

		$('#hdrAlphaList li:first-child').addClass("active"); // add class to alphabet list in header brands
		
    $('#hdrAlphaList li').not('.all').click(function (e) {
        e.preventDefault();
		$('#hdrAlphaList li').removeClass("active");
		$(this).addClass("active");
        $(".hdrBrandListWrpr").hide();
        myurl = $('a', this).attr("href");
        $('.' + myurl).show();

    });

// end header section


});

// Start plugin functions
(function( $ ){

  var methods = {
    init : function( options ) { 
      // THIS 
    },
    test : function( ) {
      alert('test');
    },
	rollDown : function( ) {
	$("#hdrCartListShowMiniCart span").addClass("active");
	setTimeout(function() { $("#cartPreviewItemsBox").slideDown("slow");}, 400);
	},
	rollUp : function( ) {
   	$("#cartPreviewItemsBox").slideUp("200");
	$("#hdrCartListShowMiniCart span").removeClass("active");
	},
	
    additem : function( ) {

	  //$(this).find(":button").hide();
	  $(":button", this).hide();
	  $('.addingItemMsg', this).show();

	  var allFields = $(this).serialize();
		$.ajax({
		type: 'POST',
		url: '/additem.cfm',
		data: allFields,
		success: function() {
		$('.addingItemMsg').hide();
		$(":button").show();			
		},
	  	complete: function(){
		methods.minicart()
		$( 'html, body' ).animate( { scrollTop: 0 }, 'slow' );
		methods.rollDown();
		setTimeout(methods.rollUp, 7000);
   		}
		
	  });
	  return false;

    },
    minicart : function() {
var request = $.ajax({
  url: "/ajax/store_items2.cfc?method=GetStoreItemsCount",
  type: "GET",
  dataType: "json"
});
 
request.done(function(data) {
      if (data.STOREITEMS >= 1) {
            $('#emptyCartList').hide();
            $('#cartHeaderNav').show();
        } else {
            $('#emptyCartList').show();
        }
        $('.storeItemsQty').html(data.STOREITEMS);
});

    $("#cartPreviewItemsBox").html(globals.spinner).load("/minicart_process.cfm");

    }
  };

  $.fn.sitePlugins = function( method ) {
    
    // Method calling logic
    if ( methods[method] ) {
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof method === 'object' || ! method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  method + ' does not exist on jQuery.sitePlugins' );
    }    
  
  };

})( jQuery );
// end plugin functions
		