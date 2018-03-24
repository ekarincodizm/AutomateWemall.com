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
################################################ search2?q=iphone ######################################################
TC_ITMWM_04286 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04286  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04287 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04287  Ready    Portal-Mobile   Sprint7   rebrand3    WLS_Low
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04288 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04288  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04289 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04289  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04290 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04290  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand3
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04292 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04292  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04293 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04293  Ready   Regression   Portal-Mobile   Sprint7   rebrand3
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04295 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04295  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04296 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04296  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Login iTruemart And Go To Portal rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04297 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04297  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Login iTruemart And Go To Portal rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04298 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04298  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04299 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04299  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04300 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04300  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04301 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04301  Ready   Regression    Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04302 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04302  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04303 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04303  Ready    Portal-Mobile   Sprint7   rebrand3    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04304 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04304  Ready    Portal-Mobile   Sprint7   rebrand3    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04305 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04305   Portal-Mobile       Regression   Ready   Sprint7   rebrand3    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    search2?q=iphone
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04306 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04306   Portal-Mobile       Regression   Ready   Sprint7   rebrand3    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    search2?q=iphone
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04307 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04307   Portal-Mobile       Regression   Ready   Sprint7   rebrand3    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    search2?q=iphone
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    search2?q=iphone

TC_ITMWM_04308 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04308  Ready   Regression    Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    search2?q=iphone
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04309 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04309  Ready   Regression   Portal-Mobile   Sprint7   rebrand3    WLS_Medium
	Login iTruemart And Go To Portal rebrand    search2?q=iphone
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header