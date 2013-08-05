/*global jQuery, Handlebars */

/*jslint plusplus: true, vars: true, browser: true */

jQuery(function ($) {
    'use strict';

    var Listpage = {
        request_url: "search-query.cfm?q=" + Searchkeywords.query,
        view: "grid",
        startpage: 0,
        numberonpage: 30,
        brand_id_list: [],
        specials_id_list: [],
        product_id_filter_list: [],
        sort: "nameaz",
        init: function () {
            this.cacheElements();
            this.getData();
            this.bindEvents();
            this.render();
        },
        cacheElements: function () {
            this.listTpl = Handlebars.compile($('#listTpl').html());
            this.filterTpl = Handlebars.compile($('#filterTpl').html());
            this.$filterSection = $("#filterSection");
            this.$filterModule = this.$filterSection.find(".filter-module");
            this.$listProductsWrap = $('#listProductsWrap');
            this.$viewsWrap = this.$listProductsWrap.find(".listpage-toolbar-view");
            this.$filterSlider = $("#filterPriceSlider");
        },
        bindEvents: function () {
            this.$filterSection.on("click", ".filter-module-toggler", this.moduleSlideToggle);
            this.$filterSection.on("click", ".filter-module-clear", this.resetClear); //Reset Clear for any filter module
            this.$filterSection.on("click", ".filter-module .checkbox-list li", this.toggleFilters);
            this.$filterSlider.on("mousedown", ".filter-price-handle-min", this.slide)
                .on("mouseUp", ".filter-price-handle-max", this.slide)
            this.$listProductsWrap.on("click", ".paginator li a", this.paginate);
            this.$listProductsWrap.on("submit", ".additemform", this.addToCart);
            this.$listProductsWrap.on("click", ".listpage-toolbar-view li", this.toggleView);
            this.$listProductsWrap.on("change", ".listpage-toolbar-numberonpage select", this.togglePerPage);
            this.$listProductsWrap.on("change", ".listpage-toolbar-sortby select", this.toggleSort);
        },
        slide: function (e) {
            var el = e.pageX;
            alert(el);
        },
        toggleSort: function (e) {
            var $el = $(e.target).find(":selected").val();
            Listpage.sort = $el;
            Listpage.getData();
        },
        togglePerPage: function (e) {
            var $el = $(e.target).find(":selected").val();
            localStorage.setItem('numberonpage', $el);
            Listpage.getData();
        },
        addToCart: function (e) {
            e.preventDefault();
            $(e.target).closest(".additemform").sitePlugins('additem');
        },
        checkView: function () {
            //Get display view from local storage & render page accordingly			
            if (localStorage.getItem("view") === "list") {
                Listpage.setView("list");
            }
        },
        setView: function (val) {
            var $view = Listpage.$listProductsWrap.find(".listpage-toolbar-view li");
            $view.removeClass('listpage-toolbar-view-selected');
            $view.filter("." + val + "-view").addClass('listpage-toolbar-view-selected');
            Listpage.$listProductsWrap.find(".items").removeClass("block").addClass("hidden");
            $(".items-" + val).addClass('block').removeClass('hidden');

        },
        toggleView: function (e) {
            var $view = $(e.target).data("view");
            localStorage.setItem("view", $view);
            Listpage.setView($view);
            $("body,html").scrollTop(100); // go all the way to the top.            
        },
        paginate: function (e) {
            e.preventDefault();
            Listpage.startpage = $(e.target).attr('href');
            Listpage.getData();
        },
        moduleSlideToggle: function (e) {
            $(e.target).toggleClass("filter-module-toggler-plus")
                .closest(".filter-module").find(".filter-module-main").slideToggle();
        },
        toggleFilters: function () {
            var $module = $(this).closest(".filter-module").data("module");
            var $brandID = $(this).data("brandid");
            var $specialID = $(this).data("specialid");            
            var $productIDs = $(this).data("productids");

            if ($(this).hasClass("checkbox-list-selected")) {
                if ($module === "brand") {
                    Listpage.brand_id_list.splice(Listpage.brand_id_list.indexOf($brandID), 1); //remove brandid from brand_id_list property
                }
                if ($module === "specials") {
                    Listpage.specials_id_list.splice(Listpage.specials_id_list.indexOf($specialID), 1); //remove specials from specials_id_list property
                    Listpage.product_id_filter_list.splice(Listpage.product_id_filter_list.indexOf($productIDs), 1); //remove product id from product_id_filter_list property
                }

            } else {

                if ($module === "brand") {
                    Listpage.brand_id_list.push($brandID); //add brandid to brand_id_list property
                }
                if ($module === "specials") {
                    Listpage.specials_id_list.push($specialID); //add specials id to specials_id_list property
                    Listpage.product_id_filter_list.push($productIDs); //add product id to product_id_filter_list property

                }
            }
            Listpage.startpage = 0;
            Listpage.getData();

        },
        resetClear: function (e) {
            e.preventDefault();
            var $module = $(this).closest(".filter-module").data("module");
            if ($module === "brand") {
                Listpage.brand_id_list.length = 0;
            }
            if ($module === "specials") {
                Listpage.specials_id_list.length = 0;
                Listpage.product_id_filter_list.length = 0;
            }
            Listpage.startpage = 0;
            Listpage.getData();
        },
        render: function (response) {
            var listHTML = Listpage.listTpl(response);
            var filterHTML = Listpage.filterTpl(response);

            Listpage.$listProductsWrap.html(listHTML);
            Listpage.$filterSection.html(filterHTML);
            Listpage.insertSeparator();
            Listpage.checkView();
        },
        insertSeparator: function () {
            //Insert separator lines for grid view
            Listpage.$listProductsWrap.find(".items-grid").find(".items-grid-node")
                .filter(function (index) {
                return index % 3 == 2;
            })
                .after("<li class='items-grid-separator'></li>");
        },
        blockContent: function () {
            $('.content').block({
                message: '<img src="/img/spinner78x78.gif">',
                overlayCSS: {
                    backgroundColor: '#fff'
                },
                centerY: 0,
                css: {
                    width: '88px',
                    border: '1px solid #ddd',
                    top: '300px'
                }
            });
        },
        buildUrl: function () {
            //Create a script that adds checkbox to all brands inside of data-module="brand" based on values taken from brand_id_list 
            var url = Listpage.request_url;

            if (localStorage.getItem("numberonpage") !== null) {
                Listpage.numberonpage = localStorage.getItem("numberonpage");
                url = url + "&numberonpage=" + Listpage.numberonpage;
            }
            if (Listpage.startpage > 0) {
                url = url + "&startpage=" + Listpage.startpage;
            }
            if (Listpage.brand_id_list.length > 0) {
                url += "&brandfilter=" + Listpage.brand_id_list.toString();
            }
            if (Listpage.specials_id_list.length > 0) {
                url += "&specialsfilter=" + Listpage.specials_id_list.toString();
            }
            if (Listpage.product_id_filter_list.length > 0) {
                url += "&productidfilter=" + Listpage.product_id_filter_list.toString();
            }
            url = url + "&sort=" + Listpage.sort;

            return url;
        },
        ajaxSuccess: function (response) {
            //remove spinner
            if (response.found_products === true) {
                Listpage.render(response);
                $('body,html').scrollTop(0); // go all the way to the top. especially useful when using dashboard at the bottom of the page   
            } else {
                $('#listProductsWrap').html('No products found');
            }
        },
        getData: function () {            
            var requestURL = Listpage.buildUrl();

            var jqxhr = $.ajax({
                dataType: "json",
                url: requestURL,
                cache: false,
                timeout: 10000,
                beforeSend: function () {
                    Listpage.blockContent();
                }
            })
                .done(function (response) {
                Listpage.ajaxSuccess(response);
            })
                .fail(function (jqxhr, textStatus, error) {
                var err = textStatus + ', ' + error;
                ajaxFail(err);
            })
                .always(function () {
                $('.content').unblock();
            });

            function ajaxFail(err) {
                $('#listProductsWrap').html("Request Failed: " + err);
            }

        }

    };

    //Initial product load
    Listpage.init();

});