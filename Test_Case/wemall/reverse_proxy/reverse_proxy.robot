*** Settings ***
Resource        ${CURDIR}/../../../Resource/init.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall/keywords_common_for_wemall.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_c_page/keyword_level_c.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Brand_page/Keywords_BrandPage.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Category_Page/Keywords_CategoryPage.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Search_Page/Keywords_SearchPage.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Everyday_wow/keywords_everyday_wow.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Register_Page/Keywords_RegisterPage.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Policy/keywords_policy.robot
Resource        ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Footer/keywords_footer.robot
Resource        ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Policy/keywords_policy.robot
Resource        ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot
Resource        ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_c_page/lv_c.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Payment_Manual/keywords_payment_manual.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall/lv_d/lv_d.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall-mobile/portal_page_keywords.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall-mobile/portal/keywords_portal.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall-mobile/login/keywords_login.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource        ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Full_cart/keywords_full_cart_mobile.robot
Resource        ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_1/keywords_checkout1_mobile.robot
Resource        ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_2/keywords_checkout2_mobile.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall/lv_d/keywords_level_d.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Home/keywords_home.robot
Library         ${CURDIR}/../../../Python_Library/collection_library.py
Library         ${CURDIR}/../../../Python_Library/brand_library.py
Library         ${CURDIR}/../../../Python_Library/mnp_util.py
Library         ${CURDIR}/../../../Python_Library/product.py
Library         ${CURDIR}/../../../Python_Library/storefronts_library.py

Library     Collections
Library     OperatingSystem
Library     String

Test Teardown   Selenium2Library.Close All Browsers

*** Keywords ***
Display Storefront Merchant As Prepared
	Selenium2Library.Wait Until Element Is Visible    //*[@id="content-storefront-test"]   20
	Selenium2Library.Element Should Be Visible        //*[@id="content-storefront-test"]

Display EN Storefront Merchant As Prepared
	Selenium2Library.Wait Until Element Is Visible    //*[@id="content-storefront-test-en"]   20
	Selenium2Library.Element Should Be Visible        //*[@id="content-storefront-test-en"]

Delete Storefront Shop Data
	Delete Shop and All Storefront Data    ${suite_merchant_id}
	py_delete_storefront_shop_by_slug      ${merchant_slug}

*** Test Cases ***
TC_iTM_02371 Display URL as wemall.com/itruemart/en for entering www.itruemart.com/en
	[Tags]  TC1  TC_iTM_02371  ready  redirect_url  ITMA-3013  web  portal
	When Open iTrueMart Portal       en
	Then Display Wemall Portal Page  en
	And Display Wemall Header And Footer
	 And Display Hilight Banner
	 And Display Accordion Banner
	 And Display Showroom

TC_iTM_02372 Display URL wemall.com/shop/[abc] for entering itruemart.com/shop/[abc]
	[Tags]  TC2  TC_iTM_02372  ready  redirect_url  ITMA-3013  web  storefront
	Set Suite Variable  ${suite_merchant_id}  RPX666
	Set Test Variable   ${merchant_slug}      robot-rpx
	${merchant_id}=     Set Variable          ${suite_merchant_id}
	${merchant_name}=   Set Variable          RPX Robot Merchant Name
	Given Prepare Data for Storefront API    ${merchant_id}    ${merchant_name}    ${merchant_slug}    active
	 When Selenium2Library.Open Browser   ${ITM_URL}/shop/${merchant_slug}   ${BROWSER}
	 Then Display Wemall Location
	  And Display Storefront Merchant As Prepared
	[Teardown]   Run Keywords   Delete Storefront Shop Data
	 ...		 AND            Selenium2Library.Close All Browsers

TC_iTM_02373 Display URL wemall.com/products/[name][pkey].html for entering itruemart level D (EN)
	[Tags]  TC3  TC_iTM_02373  ready  redirect_url  ITMA-3013  web  lv_d  level_d
	When Level D - Open Level D With Any Product  en
	Then Display Wemall Location  en
	 And Level D Display Level D Page

TC_iTM_02374 Display URL wemall.com/[level c] for entering itruemart level C (TH)
	[Tags]  TC4  TC_iTM_02374  ready  redirect_url  ITMA-3013  web  lv_c  level_c  everyday_wow  search  brand  category
	${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
	${cat_slug_pkey}=      Py Get Category Collection Slug Pkey Text
	When Category - Open ITM Catagory With Category Slug-Pkey   ${cat_slug_pkey}  th  ${cat_query_string}
	Then Display Wemall Location
	 And Display Level C Page

	When Open ITM Everyday Wow Page  en
	Then Display Wemall Location  en
	 And Display Everyday Wow Page

	${brand_query_string}=   Set Variable   ?page=1&orderBy=discount&order=desc
	${brand_slug_pkey}=      Py Get Brand Slug Pkey Text
	When Brand - Open ITM Brand With Brand Slug-Pkey   ${brand_slug_pkey}  th  ${brand_query_string}
	Then Display Wemall Location
	 And Display Level C Page

	When Open ITM Search With Search String  iphone  en
	Then Display Wemall Location  en
	 And Display Search Page

TC_iTM_02510 Get URL wemall.com/login for iTM login page
	[Tags]  TC7  TC_iTM_02510  ready  redirect_url  ITMA-3013  web  login
	When Selenium2Library.Open Browser   ${ITM_URL}   ${BROWSER}
	 And Click My Account To Login
	Then Display Wemall SSL Location With URI   /auth/login?continue=${WEMALL_URL}
	 And Login Page - Display Login Page

	${uri}=    Set Variable   /auth/login?continue=${ITM_URL_SSL}/auth/login
	When Selenium2Library.Open Browser   ${ITM_URL_SSL}${uri}   ${BROWSER}
	Then Display Wemall SSL Location With URI   ${uri}
	 And Login Page - Display Login Page

TC_iTM_02511 Get URL wemall.com/register for iTM registration page
	[Tags]  TC8  TC_iTM_02511  ready  redirect_url  ITMA-3013  web  register
	When Selenium2Library.Open Browser   ${ITM_URL}   ${BROWSER}
	 And Switch to EN Language With Selenium2Library
	 And Click My Account To Login
	 And User Click Register Button
	Then Display Wemall SSL Location With URI   /users/register   en
	 And Display Register Page

TC_iTM_02512 Get URL wemall.com/checkout/step1 for iTM Checkout1
	[Tags]  TC_iTM_02512  ready  redirect_url  checkout  checkout_step1  web
	Given Database Product - Get Sku Normal
	When Home - Open Browser Itruemart
	Then Wemall Portal - Wemall Portal Is Displayed

	When Wemall Level D - URL Redirect To Level D
	and Level D - User Select Style Options
	and Level D - User Click Add To Cart Button
	and Display Full Cart
	and User Click Next Process On Full Cart

	Then Display Checkout Step1 Page
	and Display Form Login At Checkout1
	and Checkout 1 - Username Box Is Displayed
	and User Select Buy As Member
	and Checkout 1 - Password Box Is Displayed
	and Checkout 1 - Select Login Type Is Displayed
	and Checkout 1 - Next Button Is Displayed

TC_iTM_02513 Get URL wemall.com/checkout/step2 for iTM Checkout2
	[Tags]  TC_iTM_02513  ready  redirect_url   checkout  checkout_step2  web
	Given Database Product - Get Sku Normal

	When Home - Open Browser Itruemart
	Then Wemall Portal - Wemall Portal Is Displayed

	When Wemall Level D - URL Redirect To Level D

	and Level D - User Select Style Options
	and Level D - User Click Add To Cart Button
	and Display Full Cart
	and User Click Next Process On Full Cart
	and Display Checkout Step1 Page
	and User Enter Valid Data As Member On Checkout1
	Then Display Checkout Step2 Page
	and Checkout 2 - Address List Is Displayed


TC_iTM_02514 Get URL wemall.com/checkout/step3 for iTM Checkout3
	[Tags]  TC_iTM_02514  ready  redirect_url  checkout  checkout_step3  web

	Given Database Product - Get Sku Normal

	When Home - Open Browser Itruemart
	Then Wemall Portal - Wemall Portal Is Displayed

	When Wemall Level D - URL Redirect To Level D

	and Level D - User Select Style Options
	and Level D - User Click Add To Cart Button
	and Display Full Cart
	and User Click Next Process On Full Cart
	and Display Checkout Step1 Page
	and User Enter Valid Data As Member On Checkout1
	and Display Checkout Step2 Page
	and User Enter Valid Data As Member On Checkout2
	Then Checkout3 - Display Checkout Step3 Page



TC_iTM_02515 Get URL wemall.com/thank you for iTM Thank You
	[Tags]  TC_iTM_02515  ready  redirect_url  checkout  thankyou  web
	Given Database Product - Get Sku Normal

	When Home - Open Browser Itruemart
	Then Wemall Portal - Wemall Portal Is Displayed

	When Wemall Level D - URL Redirect To Level D
	and Level D - User Select Style Options
	and Level D - User Click Add To Cart Button
	and Display Full Cart
	and User Click Next Process On Full Cart
	and Display Checkout Step1 Page
	and User Enter Valid Data As Member On Checkout1
	and Display Checkout Step2 Page
	and User Enter Valid Data As Member On Checkout2
	and Checkout3 - Display Checkout Step3 Page
	and Checkout 3 - User Enter Valid Data Master Card As Member
	Then Display Thankyou Page


TC_iTM_02520 Display URL as wemall.com/itruemart/en for entering m.itruemart.com [Home/Mobile/TH]
	[Tags]  TC_iTM_02520  ready  redirect_url  ITMA-3013  mobile  portal
	When Selenium2Library.Open Browser   ${ITM_MOBILE_URL}   ${BROWSER}
	Then Display Wemall Mobile Location
	 And WM Mobile Portal - Display Header And Footer
	 And WM Mobile Portal - Display Hilight Banner
	 And WM Mobile Portal - Display Showroom

TC_iTM_02521 Display URL wemall.com/shop/[abc] for entering itruemart.com/shop/[abc] [Shop/Mobile/EN]
	[Tags]  TC_iTM_02521  ready  redirect_url  ITMA-3013  mobile  storefront
	Set Suite Variable  ${suite_merchant_id}  RPX666
	Set Test Variable   ${merchant_slug}      robot-rpx
	${merchant_id}=     Set Variable          ${suite_merchant_id}
	${merchant_name}=   Set Variable          RPX Robot Merchant Name
	Given Prepare Data for Storefront API    ${merchant_id}    ${merchant_name}    ${merchant_slug}    active
	 When Selenium2Library.Open Browser   ${ITM_MOBILE_URL}/en/shop/${merchant_slug}   ${BROWSER}
	 Then Display Wemall Mobile Location  en
	  And Display EN Storefront Merchant As Prepared
	[Teardown]   Run Keywords   Delete Storefront Shop Data
	 ...		 AND            Selenium2Library.Close All Browsers

TC_iTM_02522 Display URL m.wemall.com/products/[name][pkey].html for entering itruemart level D (Mobile/TH)
	[Tags]  TC_iTM_02522  ready  redirect_url  ITMA-3013  mobile  lv_d  level_d
	When Level D Mobile - Open Level D With Any Product
	Then Display Wemall Mobile Location
	 And Level D Mobile - Content Is Displayed

TC_iTM_02523 Display URL wemall.com/[level c] for entering itruemart level C (Mobile/Brand,Category,Search,Wow/EN)
	[Tags]  TC_iTM_02523  ready  redirect_url  ITMA-3013  mobile  lv_c  level_c
	${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
	${cat_slug_pkey}=      Py Get Category Collection Slug Pkey Text
	${cat_pkey}=           Py Get Category Collection Pkey
	When Mobile Level C - Open ITM Catagory With Category Slug-Pkey   ${cat_slug_pkey}  en  ${cat_query_string}
	Then Display Wemall Mobile Location  en
	 And Mobile Level C - Display Catagory Page  ${cat_pkey}

	When Mobile Level C - Open ITM Everyday Wow Page  en
	Then Display Wemall Mobile Location  en
	 And Mobile Level C - Display Everyday Wow Page

	${brand_query_string}=   Set Variable   ?page=1&orderBy=discount&order=desc
	${brand_slug_pkey}=      Py Get Brand Slug Pkey Text
	${brand_pkey}=           Py Get Brand Pkey
	When Mobile Level C - Open ITM Brand With Brand Slug-Pkey   ${brand_slug_pkey}  en  ${brand_query_string}
	Then Display Wemall Mobile Location  en
	 And Mobile Level C - Display Brand Page  ${brand_pkey}

	When Mobile Level C - Open ITM Search With Search String  iphone  en
	Then Display Wemall Mobile Location  en
	 And Mobile Level C - Display Search Page

TC_iTM_02524 Display wemall.com/policy for clicking policy tabs (Web/EN)
	[Tags]  TC_iTM_02524  ready  redirect_url  ITMA-3013  web  policy
	${return_policy_uri}=      Set Variable  /policy/returnpolicy
	${delivery_policy_uri}=    Set Variable  /policy/freedelivery
	${moneyback_policy_uri}=   Set Variable  /policy/moneyback

	When Selenium2Library.Open Browser   ${ITM_URL}/en   ${BROWSER}
	 And Portal - Click Return Policy
	 And Policy - Select Return Policy Page  en  ${WEMALL_URL}
	Then Display Wemall Location  en
	 And Policy - Display Policy Page

	When Selenium2Library.Open Browser   ${ITM_URL}/en   ${BROWSER}
	 And Portal - Click Delivery Policy
	 And Policy - Select Delivery Policy Page  en  ${WEMALL_URL}
	Then Display Wemall Location  en
	 And Policy - Display Policy Page

	When Selenium2Library.Open Browser   ${ITM_URL}/en   ${BROWSER}
	 And Portal - Click Money Back Policy
	 And Policy - Select Money Back Policy Page  en  ${WEMALL_URL}
	Then Display Wemall Location  en
	 And Policy - Display Policy Page

TC_iTM_02526 Get URL wemall.com/login for iTM login page [Mobile/EN]
	[Tags]  TC_iTM_02526  ready  redirect_url  ITMA-3013  mobile  login
	# When Selenium2Library.Open Browser   ${ITM_MOBILE_URL}   ${BROWSER}
	#  And WM Mobile Portal - Click Switch Language To EN
	#  And WM Mobile Portal - Click Menu To Login
	When Selenium2Library.Open Browser   ${ITM_MOBILE_URL}/en/auth/login?continue=${ITM_MOBILE_URL}   ${BROWSER}
	Then Display Wemall Mobile SSL Location With URI   /auth/login?continue=${ITM_MOBILE_URL}  en
	# Then Display Wemall Mobile SSL Location With URI   /auth/login?continue=${WEMALL_MOBILE_URL_SSL}  en
	 And WM Mobile Login - Display Login Page

TC_iTM_02527 Get URL wemall.com/register for iTM registration page [Mobile/TH]
	[Tags]  TC_iTM_02527  ready  redirect_url  ITMA-3013  mobile  register
	# When Selenium2Library.Open Browser   ${ITM_MOBILE_URL}   ${BROWSER}
	#  And WM Mobile Portal - Click Menu To Login
	#  And WM Mobile Login - Click Register Button
	When Selenium2Library.Open Browser   ${ITM_MOBILE_URL}/users/register   ${BROWSER}
	Then Display Wemall Mobile SSL Location With URI   /users/register
	 And Display Register Page

TC_iTM_02528 Get URL wemall.com/checkout/step1 for iTM Checkout1 (Mobile/EN)
	[Tags]  TC_iTM_02528  ready  redirect_url   checkout1  mobile  en  ready
	Given Database Product - Get Sku Normal
	When Level D Mobile - Open Browser Level D From Test Variable With No Cache
	and Level D Mobile - User Select Style Options
	and Level D Mobile - User Click Add To Cart Button
	Then Full Cart Mobile - Full Cart Is Displayed

	When Full Cart Mobile - User Click Next Process On Cart Page
	Then Checkout 1 Mobile - Wemall Checkout 1 URL Is Displayed


TC_iTM_02529 Get URL wemall.com/checkout/step2 for iTM Checkout2 (Mobile/EN)
	[Tags]  TC_iTM_02529  ready  edirect_url  checkout2   mobile  en  ready
	Given Database Product - Get Sku Normal
	When Level D Mobile - Open Browser Level D From Test Variable With No Cache
	and Level D Mobile - User Select Style Options
	and Level D Mobile - User Click Add To Cart Button
	and Full Cart Mobile - Full Cart Is Displayed

	and Full Cart Mobile - User Click Next Process On Cart Page

	and Checkout 1 Mobile - User Enter Valid Data As Member On Checkout1
	Then Checkout 2 Mobile - Wemall Checkout 2 URL Is Displayed


TC_iTM_02782 Get URL m.wemall.com/en/checkout/no-item for iTM Checkout1 without any items in cart (MobileEN) (Web/TH)
	[Tags]  TC_iTM_02782  ready  redirect_url  no_item  ready  mobile
	Given Selenium2Library.Open Browser   ${ITM_MOBILE_URL}   ${BROWSER}
	When Selenium2Library.Go To   ${ITM_MOBILE_URL_SSL}/en/checkout/step1
	Then Selenium2Library.Location Should Contain   ${WEMALL_MOBILE_URL}/en/checkout/no-item
	When Selenium2Library.Go To   ${ITM_URL_SSL}/checkout/step1
	Then Selenium2Library.Location Should Be   ${WEMALL_URL}/checkout/no-item

