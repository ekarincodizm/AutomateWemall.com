*** Settings ***
Force Tags    WLS_Wemall_Mobile
# Suite Setup       Open Portal Main Page
# Suite Teardown    Close Browser
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/keyword_mobile.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/resource_mobile.robot

Test Setup   Start Test Case
Test Tear Down   Close Browser
*** Keywords ***
Start Test Case
	keyword_mobile.Initialize Suite Variable    TestData

*** Test Cases ***
####################################################### cart ###########################################################
TC_ITMWM_04358 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04358  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    cart

TC_ITMWM_04359 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04359  Ready    Portal-Mobile   Sprint7   rebrand6    WLS_Low
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04360 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04360  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04361 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04361  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04362 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04362  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand6
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    cart
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS


TC_ITMWM_04364 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04364  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04365 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04365  Ready   Regression   Portal-Mobile   Sprint7   rebrand6
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    cart
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS



TC_ITMWM_04367 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04367  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04368 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04368  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Login iTruemart And Go To Portal rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04369 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04369  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Login iTruemart And Go To Portal rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04370 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04370  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04371 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04371  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04372 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04372  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04373 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04373  Ready   Regression    Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04374 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04374  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04375 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04375  Ready    Portal-Mobile   Sprint7   rebrand6    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    cart

TC_ITMWM_04376 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04376  Ready    Portal-Mobile   Sprint7   rebrand6    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    cart
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    cart

TC_ITMWM_04377 Verify Search have auto suggestion when type keyword on Search field
	[Tags]   TC_ITMWM_04377   Portal-Mobile       Regression   Ready   Sprint7   rebrand6    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    cart
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04378 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04378   Portal-Mobile       Regression   Ready   Sprint7   rebrand6    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    cart
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04379 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04379   Portal-Mobile       Regression   Ready   Sprint7   rebrand6    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    cart
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    cart

TC_ITMWM_04380 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04380  Ready   Regression    Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    cart
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04381 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04381  Ready   Regression   Portal-Mobile   Sprint7   rebrand6    WLS_Medium
	Login iTruemart And Go To Portal rebrand    cart
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header