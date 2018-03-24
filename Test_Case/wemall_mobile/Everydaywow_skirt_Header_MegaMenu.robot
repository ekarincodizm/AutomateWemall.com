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
#################################################### everyday-wow ######################################################
TC_ITMWM_04310 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04310  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04311 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04311  Ready    Portal-Mobile   Sprint7   rebrand4    WLS_Low
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04312 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04312  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04313 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04313  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04314 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04314  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand4
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04316 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04316  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04317 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04317  Ready   Regression   Portal-Mobile   Sprint7   rebrand4
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04319 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04319  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04320 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04320  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Login iTruemart And Go To Portal rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04321 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04321  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Login iTruemart And Go To Portal rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04322 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04322  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04323 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04323  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04324 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04324  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04325 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04325  Ready   Regression    Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04326 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04326  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04327 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04327  Ready    Portal-Mobile   Sprint7   rebrand4    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04328 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04328  Ready    Portal-Mobile   Sprint7   rebrand4    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04329 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04329   Portal-Mobile       Regression   Ready   Sprint7   rebrand4    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    everyday-wow
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04330 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04330   Portal-Mobile       Regression   Ready   Sprint7   rebrand4    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    everyday-wow
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04331 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04331   Portal-Mobile       Regression   Ready   Sprint7   rebrand4    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    everyday-wow
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    everyday-wow

TC_ITMWM_04332 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04332  Ready   Regression    Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    everyday-wow
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04333 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04333  Ready   Regression   Portal-Mobile   Sprint7   rebrand4    WLS_Medium
	Login iTruemart And Go To Portal rebrand    everyday-wow
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header