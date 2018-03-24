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
############################## auth/login?continue=${WEMALL_MOBILE}/cart ###############################
TC_ITMWM_04382 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04382  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand incase auth/login    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04383 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04383  Ready    Portal-Mobile   Sprint7   rebrand7    WLS_Low
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04384 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04384  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04385 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04385  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04386 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04386  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand7
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04388 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04388  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04389 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04389  Ready   Regression   Portal-Mobile   Sprint7   rebrand7
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04391 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04391  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04392 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04392  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Login iTruemart And Go To Portal rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04393 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04393  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Login iTruemart And Go To Portal rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04394 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04394  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04395 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04395  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04396 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04396  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04397 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04397  Ready   Regression    Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TTC_ITMWM_04398 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04398  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04399 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04399  Ready    Portal-Mobile   Sprint7   rebrand7    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04400 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04400  Ready    Portal-Mobile   Sprint7   rebrand7    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04401 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04401   Portal-Mobile       Regression   Ready   Sprint7   rebrand7    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04402 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04402   Portal-Mobile       Regression   Ready   Sprint7   rebrand7    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04403 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04403   Portal-Mobile       Regression   Ready   Sprint7   rebrand7    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    auth/login?continue=${WEMALL_MOBILE}/cart

TC_ITMWM_04404 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04404  Ready   Regression    Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04405 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04405  Ready   Regression   Portal-Mobile   Sprint7   rebrand7    WLS_Medium
	Login iTruemart And Go To Portal rebrand    auth/login?continue=${WEMALL_MOBILE}/cart
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header