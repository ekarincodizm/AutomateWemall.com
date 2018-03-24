*** Settings ***
Force Tags    WLS_Wemall_Mobile
# Suite Setup       Open Portal Main Page
# Suite Teardown    Close Browser
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/keyword_mobile.robot
Resource          ${CURDIR}/../../Keyword/Features/Portal_Main_Page_Mobile/resource_mobile.robot

Test Setup   Start Test Case
Test TearDown   Close Browser
*** Keywords ***
Start Test Case
	keyword_mobile.Initialize Suite Variable    TestData

*** Test Cases ***
########################################## brand/samsung-6931849325692.html ############################################
TC_ITMWM_04334 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04334  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04335 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04335  Ready    Portal-Mobile   Sprint7   rebrand5    WLS_Low
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04336 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04336  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04337 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04337  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04338 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04338  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand5
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04340 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04340  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04341 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04341  Ready   Regression   Portal-Mobile   Sprint7   rebrand5
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04343 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04343  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04344 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04344  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Login iTruemart And Go To Portal rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04345 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04345  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Login iTruemart And Go To Portal rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04346 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04346  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04347 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04347  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04348 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04348  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04349 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04349  Ready   Regression    Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04350 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04350  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04351 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04351  Ready    Portal-Mobile   Sprint7   rebrand5    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04352 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04352  Ready    Portal-Mobile   Sprint7   rebrand5    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04353 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04353   Portal-Mobile       Regression   Ready   Sprint7   rebrand5    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04354 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04354   Portal-Mobile       Regression   Ready   Sprint7   rebrand5    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04355 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04355   Portal-Mobile       Regression   Ready   Sprint7   rebrand5    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    brand/samsung-6931849325692.html
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    brand/samsung-6931849325692.html

TC_ITMWM_04356 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04356  Ready   Regression    Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    brand/samsung-6931849325692.html
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04357 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04357  Ready   Regression   Portal-Mobile   Sprint7   rebrand5    WLS_Medium
	Login iTruemart And Go To Portal rebrand    brand/samsung-6931849325692.html
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header
