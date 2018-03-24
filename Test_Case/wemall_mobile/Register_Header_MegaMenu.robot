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
########################################### users/register #############################################################
TC_ITMWM_04406 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04406  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand incase auth/login    users/register

TC_ITMWM_04407 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04407  Ready    Portal-Mobile   Sprint7   rebrand8    WLS_Low
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04408 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04408  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04409 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04409  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04410 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04410  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand8
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    users/register
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04412 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04412  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04413 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04413  Ready   Regression   Portal-Mobile   Sprint7   rebrand8
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    users/register
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04415 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04415  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04416 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04416  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Login iTruemart And Go To Portal rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04417 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04417  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Login iTruemart And Go To Portal rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04418 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04418  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04419 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04419  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04420 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04420  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04421 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04421  Ready   Regression    Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04422 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04422  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04423 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04423  Ready    Portal-Mobile   Sprint7   rebrand8    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    users/register

TC_ITMWM_04424 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04424  Ready    Portal-Mobile   Sprint7   rebrand8    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    users/register
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    users/register

TC_ITMWM_04425 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04425   Portal-Mobile       Regression   Ready   Sprint7   rebrand8    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    users/register
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04426 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04426   Portal-Mobile       Regression   Ready   Sprint7   rebrand8    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    users/register
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04427 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04427   Portal-Mobile       Regression   Ready   Sprint7   rebrand8    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    users/register
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    users/register

TC_ITMWM_04428 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04428  Ready   Regression    Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    users/register
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04429 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04429  Ready   Regression   Portal-Mobile   Sprint7   rebrand8    WLS_Medium
	Login iTruemart And Go To Portal rebrand    users/register
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header