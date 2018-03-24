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
######################################################  portal/page1 ################################################################
TC_ITMWM_04238 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04238  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04239 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04239  Ready    Portal-Mobile   Sprint7   rebrand1    WLS_Low
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04240 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04240   Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04241 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04241  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04242 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04242  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand1
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04244 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04244  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04245 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04245  Ready   Regression   Portal-Mobile   Sprint7   rebrand1
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04247 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04247  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04248 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04248  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Login iTruemart And Go To Portal rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04249 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04249  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Login iTruemart And Go To Portal rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04250 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04250  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04251 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04251  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04252 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04252  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04253 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04253  Ready   Regression    Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04254 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04254  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04255 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04255  Ready    Portal-Mobile   Sprint7   rebrand1    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04256 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04256  Ready    Portal-Mobile   Sprint7   rebrand1    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    portal/page1
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04257 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04257   Portal-Mobile       Regression   Ready   Sprint7   rebrand1    WLS_High
    Open Portal iTrueMart Mobile rebrand    portal/page1
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04258 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04258   Portal-Mobile       Regression   Ready   Sprint7   rebrand1    WLS_High
    Open Portal iTrueMart Mobile rebrand    portal/page1
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04259 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04259   Portal-Mobile       Regression   Ready   Sprint7   rebrand1    WLS_High
    Open Portal iTrueMart Mobile without resize rebrand    portal/page1
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    portal/page1

TC_ITMWM_04260 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04260  Ready   Regression    Portal-Mobile   Sprint7   rebrand1    WLS_High
	Open Portal iTrueMart Mobile rebrand    portal/page1
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04261 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04261  Ready   Regression   Portal-Mobile   Sprint7   rebrand1    WLS_High
	Login iTruemart And Go To Portal rebrand    portal/page1
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header

