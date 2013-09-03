  <cfquery name="GetDataUser" datasource="#Application.ds#">
			SELECT Firstname, Lastname, LevelID
			FROM Users
			WHERE UserID = #Session.UserID#
</CFQUERY>
<cfquery name="GetHomeData" datasource="#Application.ds#">
	SELECT HomeText, holidayflag FROM AboutUs 
</cfquery>
<header id="topHeader">
  <div id="hdrNav">
    <ul id="hdrAccount">
      <cfif session.logon EQ "TRUE">
        <li id="hdrAccountUser"><a href="https://www.maxvite.com/myaccount.cfm"><cfoutput>
            <cfif #GetDataUser.LevelID# EQ 1>
              Admin
              <cfelse>
              #GetDataUser.Firstname# #GetDataUser.Lastname#
            </cfif>
          </cfoutput></a></li>
        <li><a href="https://www.maxvite.com/myaccount.cfm">My Account</a></li>
        <li><a href="https://www.maxvite.com/logoff.cfm">Log Out</a></li>
        <cfelse>
        <li id="hdrAccountSignIn"><a href="#">Sign In</a>
          <div>
            <h3>Sign In</h3>
            <form action="https://www.maxvite.com/userverifylo.cfm" method="post" name="LOGIN" id="signinForm" class="hdrForm">
              <ol>
                <li>
                  <input type="text" id="menuUsername" name="username" size="20" maxlength="100" title="Invalid Email" placeholder=" Email">
                </li>
                <li>
                  <input type="password" id="menuPassword" name="password" size="20" title="Invalid Password" placeholder=" Password">
                </li>
              </ol>
     <a href="https://www.maxvite.com/forgot.cfm" class="forgot-password">Forgot password?</a>
              <button class="btn bigButton" type="submit">SIGN IN</button>
            </form>
            <h3>Create maxvite.com Account</h3>
            <p>Create an account for benefits like faster checkout to make shopping maxvite.com even easier.</p>
            <a class="btn" href="https://www.maxvite.com/Register.html">Create an Account</a> </div>
        </li>
        <li><a href="https://www.maxvite.com/Register.html">Create an Account</a></li>
      </cfif>
      <li id="hdrAccountTrack"><a href="#">Track Order</a>
        <div>
          <form id="trackOrderForm" class="hdrForm">
            <ol>
              <li>
                <input type="text" name="orderid" placeholder=" Order ID">
              </li>
              <li>
                <input type="text" name="orderemail" placeholder=" Email">
              </li>
            </ol>
            <button type="submit" class="btn bigButton">Track Order</button>
          </form>
          <p id="trackMsgPost"></p>
        </div>
      </li>
      <li><a href="/customer.html">Contact Us</a></li>
    </ul>
    <ul id="hdrCartList">
      <li><a href="/viewcart.html"><img src="/img/cart-icon.png" alt="View Shopping Cart"></a></li>
      <li><a href="/viewcart.html"><span class="storeItemsQty">0</span>item(s)&nbsp;</a></li>
      <li id="hdrCartListCheckoutBtn"><a class="btn" href="https://www.maxvite.com/checkout0.cfm?CHECKOUT=">Checkout</a></li>
      <li id="hdrCartListShowMiniCart"><span></span>
        <div id="cartPreviewItemsBox"></div>
      </li>
    </ul>
  </div>
  <section id="branding"> <a href="/"><img src="/img/header-newlogo.png" alt="MaxVite" id="headerLogo"></a>
    <div id="chatBtn">
<!-- BEGIN ProvideSupport.com Graphics Chat Button Code -->
<div id="ciIIpH" style="z-index:100;position:fixed"></div><div id="scIIpH" style="display:inline"></div><div id="sdIIpH" style="display:none"></div><script type="text/javascript">var seIIpH=document.createElement("script");seIIpH.type="text/javascript";var seIIpHs=(location.protocol.indexOf("https")==0?"https":"http")+"://image.providesupport.com/js/0wnmq8k9gr9sr184wwmnvnrt2d/safe-standard.js?ps_h=IIpH&ps_t="+new Date().getTime();setTimeout("seIIpH.src=seIIpHs;document.getElementById('sdIIpH').appendChild(seIIpH)",1)</script><noscript><div style="display:inline"><a href="http://www.providesupport.com?messenger=0wnmq8k9gr9sr184wwmnvnrt2d">Customer Support Chat</a></div></noscript>
<!-- END ProvideSupport.com Graphics Chat Button Code -->
    </div>
    <a href="/customer.html"><img src="/img/phone.png" id="headerPhone" alt="Order by phone 877-525-1700" title="Order by phone 877-525-1700"></a>
    <form action="/emailoptin.cfm" method="post" id="headerEmailWrpr">
      <table>
        <tr>
          <td><img src="/img/yellow-email-icon.png" id="headerEmail" alt="" title=""></td>
          <td><span id="offersMotto">Sign up for email offers & save big!</span>
            <input type="text" size="30" name="email" id="headerOffersInput" placeholder=" Enter Email">
            <button class="btn btn-red" name="addtocart">SIGN UP</button></td>
        </tr>
      </table>
    </form>
  </section>
  <!--end branding-->
  <!--end topnav bar-->
  <nav role="navigation">
    <div id="searchWrpr">
<form method="get" action="/search.html" id="KEYSEARCH" name="searchform">
        <fieldset id="searchFieldset">
<input name="q" id="primarySearch" type="text" placeholder="Keyword or Item number" autocomplete="off" value="" required="">          
<button type="submit" class="header-search-btn"><i></i></button>
        </fieldset>
	</form>    
      <form>
        <fieldset id="pulldown-fieldset">
        </fieldset>
      </form>
    </div>
    <img src="/img/holiday-schedule.png" id="holidaySchedule">
    <div id="holidayDialog" title="MaxVite Holiday Schedule" style="display:none;"></div>
    <ul id="hdrTabs">
      <li><a href="/healthconcerns.html">Health Concerns</a>
        <div class="mega-menu">
          <ul id="concernMegaMenuList">
            <cf_health-mega-menu>
          </ul>
        </div>
      </li>
      <li class="brand"><a href="/brands.html">Brands</a>
        <div id="brandMegaMenu" class="mega-menu">
          <cf_brand-mega-menu>
        </div>
      </li>
      <li class="specials"><a href="/54/Specials/subcategory.html">Specials</a>
        <div class="mega-menu">
          <ul class="sdbrBulletList">
            <li><a href="/brandspecials.html">Brand Specials</a></li>
            <li><a href="/54/313/S/Weekly-Specials/items.html">Weekly Specials</a></li>
            <li><a href="/54/865/S/Super-Deals/items.html">Super Deals</a></li>
            <li><a href="/54/554/S/Buy-One-Get-One-Free/items.html">Buy One Get One Free</a></li>
            <li><a href="/54/552/S/Protein-Specials/items.html">Protein Specials</a></li>
          </ul>
        </div>
      </li>
      </a>
      </li>
    </ul>
  </nav>
</header>