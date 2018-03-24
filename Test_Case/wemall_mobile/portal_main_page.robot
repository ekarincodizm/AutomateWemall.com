*** Settings ***
Force Tags    WLS_Wemall_Mobile
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/keyword_mobile.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/resource_mobile.robot


Test Setup   Start Test Case

Test TearDown   Close All Browsers

*** Keywords ***
Start Test Case
	keyword_mobile.Initialize Suite Variable    TestData
*** Variables ***
${pkey1}        2951108269824
${pkey2}        2742068370846
${pkey3}        2623344958442
*** Test Cases ***
TC_ITMWM_04155 Verify Menu Bar retrieve data from CMS WeMall
	[Tags]   TC_ITMWM_04155    mobile    lyra    regression    s6    WLS_Medium
	Login CMS WeMall To Verify Category Number In Manage Portal - Menu Bar
	Open Portal Main Page without resize
	Compare Menubar In WeMall Mobile Site with CMS

# TC_ITMWM_04156 Verify Infinite Skirt on Menu Bar Is Infinite Skirt
# 	[Tags]   TC_ITMWM_04156    mobile    lyra    needfix
# 	Login CMS WeMall To Verify Category Number In Manage Portal - Menu Bar
# 	Open Portal Main Page
# 	Compare Menubar In WeMall Mobile Site Is Infinite Skirt

TC_ITMWM_04157 Verify Main Page highlights Picture and content
	[Tags]   TC_ITMWM_04157    mobile    lyra    regression    s6    WLS_Medium
	Login CMS WeMall To Verify Highlights Section In Main Page
	Open Portal Main Page without resize
	Compare Highlights Picture In WeMall Mobile Site with CMS

# TC_ITMWM_04159 Verify Main page “EveryDay Wow” picture and content incase Product more than 8 unit
#     [Tags]   TC_ITMWM_04159    mobile    lyra    needfix
#     Login PCMS To Verify Promotion - Discount Promotion Product
#     Open Portal Main Page without resize
#     Compare Everyday Wow In Wemall Mobile SIte with PCMS


TC_ITMWM_04160 Verify Merchant Zone picture to display on mobile site
	[Tags]   TC_ITMWM_04160    mobile    lyra    regression    s6    WLS_Medium
	Login CMS WeMall To Verify Picture In Manage Portal - Merchantzone
	Open Portal Main Page
	Compare MerchantZone In WeMall Mobile Site with CMS

TC_ITMWM_04161 Verify Showroom Category display on mobile site
	[Tags]   TC_ITMWM_04161    mobile    lyra    regression    s6    WLS_Medium
	Login CMS WeMall To Verify Category Number In Manage Portal - Showroom
	Open Portal Main Page
	Compare Showroom Name In WeMall Mobile Site with CMS

TC_ITMWM_04162 Verify Showroom picture to display on mobile site
	[Tags]   TC_ITMWM_04162    mobile    lyra    regression    s6    WLS_Medium
	Login CMS WeMall To Verify Manage Picture In Manage Portal - Showroom
	Open Portal Main Page without resize
	Compare Showroom Picture In WeMall Mobile Site with CMS


TC_ITMWM_04163 Verify Showroom brand picture to display on mobile site incase Showroom Brand less than 4 picture
	[Tags]   TC_ITMWM_04163    mobile    lyra    regression    s6    WLS_Medium
	Login CMS WeMall To Verify Manage Brand Picture In Manage Portal - Showroom
	Open Portal Main Page without resize
	Compare Showroom Manage Brand Picture In WeMall Mobile Site with CMS

TC_ITMWM_04165 Verify View More Button
	[Tags]   TC_ITMWM_04165    mobile    lyra    regression    s6    WLS_Medium
	Open Portal Main Page without resize
	Verify View More Button In WeMall Mobile Site


TC_ITMWM_04166 Verify Category Name of Promotion page
    [Tags]   TC_ITMWM_04166    mobile    lyra    regression    s6    WLS_Medium
    Login CMS WeMall To Verify Category Number In Manage Portal - Mega Menu
    Close Browser
    Open Portal Main Page without resize
    Compare Mega Menu In WeMall Mobile Site - Promotion Page with CMS

TC_ITMWM_04167 Verify picture of Promotion page
    [Tags]   TC_ITMWM_04167    mobile    lyra    regression    s6    WLS_Medium
    Login CMS WeMall To Verify Category Picture In Manage Portal - Mega Menu
    Open Portal Main Page without resize
    Compare Mega Menu Promotion Picture In WeMall Mobile Site with PCMS

TC_ITMWM_04215 Verify Shop in Shop Logo is retrieve from storefront
    [Tags]   TC_ITMWM_04215    mobile    lyra    regression    s13    WLS_High
    Open storefront CMS
    Get Mobile Shop Logo 130x130    Canon
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Verify Shop In Shop Logo

TC_ITMWM_04216 Verify Shop in Shop Header is retrieve from storefront
    [Tags]   TC_ITMWM_04216    mobile    lyra    regression    s13    WLS_High
    Open storefront CMS
    Get Mobile Shop Header Attribute    Canon
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Verify Shop In Shop Header

TC_ITMWM_04217 Verify Shop in Shop Banner is retrieve from storefront
    [Tags]   TC_ITMWM_04217    mobile    lyra    regression    s13    WLS_High
    Open storefront CMS
    Get Mobile Shop Banner    Canon
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Verify Shop In Shop Banner

TC_ITMWM_04218 Verify Shop in Shop Burger Menu is retrieve from storefront
    [Tags]   TC_ITMWM_04218    mobile    lyra    regression    s13    WLS_High
    Open storefront CMS
    Get Mobile Shop Menu Category Name    Canon
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Verify Shop In Shop Menu

TC_ITMWM_04566 Verify Cart page can go back to Level D by click product picture or product name
    [Tags]   TC_ITMWM_04566    mobile    lyra    regression    s13    WLS_Medium
    Buy Product And Go To Cart Page    ${pkey1}    ${pkey2}
    Verify Cart Page Product Picture and Name Can Redirect To Level D

TC_ITMWM_04568 Verify Thankyou page display product that user buy
    [Tags]   TC_ITMWM_04568    mobile    lyra    regression    s13    WLS_High
    Buy Product And Go To Cart Page    ${pkey1}    ${pkey2}
    Click Checkout Button
    Checkout Step1 By Guest
    Checkout Step2 By Guest
    Checkout Step3 Payment By CCW
    Verify Thankyou Page Mobile Site
    Close All Browsers

    Buy Product And Go To Cart Page    ${pkey1}    ${pkey2}
    Click Checkout Button
    Checkout Step1 By Member
    Checkout Step2 By Member
    Checkout Step3 Payment By CCW
    Verify Thankyou Page Mobile Site

TC_ITMWM_04571 Verify Shop in Shop Burger Menu display at the top right of screen
    [Tags]   TC_ITMWM_04571    mobile    lyra    s13    WLS_Low
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Verify Shop In Shop Burger Menu


TC_ITMWM_04572 Verify Shop in Shop Burger Menu can close popup
    [Tags]   TC_ITMWM_04572    mobile    lyra    s13    WLS_Low
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Click Burger Menu On Mobile Shop In Shop
    Close Burger Menu On Mobile Shop In Shop

TC_ITMWM_04573 Verify Shop in Shop Burger Menu display new button and button is available
    [Tags]   TC_ITMWM_04573    mobile    lyra    regression    s13    WLS_High
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Verify Burger Menu Short Cut - Back To WeMall
    Go To    ${WEMALL_MOBILE}/${home}
    Verify Burger Menu Short Cut - Go To Cart
    Go To    ${WEMALL_MOBILE}/${home}
    Verify Burger Menu Short Cut - Search
    Go To    ${WEMALL_MOBILE}/${home}
    Verify Burger Menu Short Cut - Language

TC_ITMWM_04574 Verify Shop in Shop Back button display at the top left of screen
    [Tags]   TC_ITMWM_04574    mobile    lyra    s13    WLS_Low
    Open Portal iTrueMart Mobile rebrand     shop/canon
    Verify Shop In Shop Back button

# TC_ITMWM_04575 Verify Back button will go to previous page when user click from another page to go to Shop page
#     [Tags]   TC_ITMWM_04575    mobile    lyra    s13    Automatable

# TC_ITMWM_04576 Verify Back button will go to previous page when user go to Shop page by enter URL
#     [Tags]   TC_ITMWM_04576    mobile    lyra    s13    Automatable




TC_ITMWM_00668 Level D display out of stock when select variant type that not related each other
    [Tags]   TC_ITMWM_00668    mobile    lyra    S14    regression    WLS_High
    Open iTruemart Web    products/dinosaur-driver-flashdrive--2795192875130.html?no-cache=1
    Verify Variant Type not related each other will display out of stock

TC_ITMWM_00669 Level D can buy product with old variant type
    [Tags]   TC_ITMWM_00669    mobile    lyra    S14    regression    WLS_High
    Open iTruemart Web    products/headphones-skullcandy-crusher-2721838642686.html?no-cache=1
    Buy product with old variant type

TC_ITMWM_00670 Level D can buy product with new variant type
    [Tags]   TC_ITMWM_00670    mobile    lyra    S14    regression    WLS_High
    Open iTruemart Web    products/sherman-j-1111-2515084686327.html?nocache=1
    Buy product with new variant type

TC_ITMWM_00671 Level D can buy product with old and new variant type
    [Tags]   TC_ITMWM_00671    mobile    lyra    S14    regression    WLS_High
    Open iTruemart Web    products/dinosaur-driver-flashdrive--2795192875130.html?no-cache=1
    Buy product with old and new variant type

TC_ITMWM_00672 Level D will check stock after select variant type
    [Tags]   TC_ITMWM_00672    mobile    lyra    S14    regression    WLS_High
    Open iTruemart Web    products/dinosaur-driver-flashdrive--2795192875130.html?no-cache=1
    Verify Level D Check Stock After Select Variant Type

TC_ITMWM_00673 Level D can buy product that not set any variant type in Product > Manage variant
    [Tags]   TC_ITMWM_00673    mobile    lyra    S14    regression    WLS_High
    Open iTruemart Web    products/infothink-avengers-captain-america-8-gb-2951108269824.html?no-cache=1
    Verify Buy Button Is Enable

TC_ITMWM_00701 iTM Profile can add new Address
    [Tags]   TC_ITMWM_00701    mobile    lyra    S14    WLS_Low
    Login iTruemart And Go To Portal rebrand    member/profile
    Create New Profile Address
    Verify New Profile Address
TC_ITMWM_00702 iTM Profile can Edit Address
    [Tags]   TC_ITMWM_00702    mobile    lyra    S14    WLS_Low
    Login iTruemart And Go To Portal rebrand    member/profile
    Edit Profile Addess
    Verify Edit Address Is Success
TC_ITMWM_00703 ITM Profile link Order tracking is available
    [Tags]   TC_ITMWM_00703    mobile    lyra    S14    regression    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Order Tracking Link
TC_ITMWM_00704 ITM Profile link Cart is available
    [Tags]   TC_ITMWM_00704    mobile    lyra    S14    regression    WLS_High
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Cart Link



























