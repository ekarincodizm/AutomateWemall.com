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
################################ category/mobile-tablet-accessories-3713634511853.html #################################
TC_ITMWM_04262 Verify Mega Menu - “Register” is available
	[Tags]   TC_ITMWM_04262  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Login link For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04263 Verify Mega Menu - “Main Page” is available
	[Tags]   TC_ITMWM_04263  Ready    Portal-Mobile   Sprint7   rebrand2    WLS_Low
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Home link For Test iTruemart Header

TC_ITMWM_04264 Verify Mega Menu - Everyday Wow is available
	[Tags]   TC_ITMWM_04264  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04265 Verify Mega Menu - Category is available
	[Tags]   TC_ITMWM_04265  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04266 Verify Mega Menu - "Category" display follow PCMS config
# 	[Tags]   TC_ITMWM_04266  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand2
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
# 	Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04268 Verify Tab Menu - Promotion is available
	[Tags]   TC_ITMWM_04268  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04269 Verify Mega Menu - "Promotion" display follow PCMS config
# 	[Tags]   TC_ITMWM_04269  Ready   Regression   Portal-Mobile   Sprint7   rebrand2
# 	Open PCMS iTruemart
# 	Verify Category Level 1
# 	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
# 	Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04271 Verify Tab Menu - iTruemart is available
	[Tags]   TC_ITMWM_04271  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04272 Verify Tab Menu - Cart is available
	[Tags]   TC_ITMWM_04272  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Login iTruemart And Go To Portal rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Cart link For Test iTruemart Header

TC_ITMWM_04273 Verify Tab Menu - Order Tracking is available
	[Tags]   TC_ITMWM_04273  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Login iTruemart And Go To Portal rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04274 Verify Tab Menu - Return Policy is available
	[Tags]   TC_ITMWM_04274  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04275 Verify Tab Menu - Shipment Policy is available
	[Tags]   TC_ITMWM_04275  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04276 Verify Tab Menu - Refund Policy is available
	[Tags]   TC_ITMWM_04276  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04277 Verify Tab Menu - Discount Code is available
	[Tags]   TC_ITMWM_04277  Ready   Regression    Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04278 Verify Tab Menu - Contact Us is available
	[Tags]   TC_ITMWM_04278  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04279 Verify Tab Menu - Select THAI language is available
	[Tags]   TC_ITMWM_04279  Ready    Portal-Mobile   Sprint7   rebrand2    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify Thai language For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04280 Verify Tab Menu - Select ENGLISH language is available
	[Tags]   TC_ITMWM_04280  Ready    Portal-Mobile   Sprint7   rebrand2    WLS_Low
	Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
	Click Main Menu In WeMall Mobile Sites
	Verify English language For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04281 Verify Search have auto suggestion when type keyword on Search field
	[Tags]  TC_ITMWM_04281   Portal-Mobile       Regression   Ready   Sprint7   rebrand2    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04282 Verify Search Function when not found item
	[Tags]  TC_ITMWM_04282   Portal-Mobile       Regression   Ready   Sprint7   rebrand2    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04283 Verify Cancle Button In Search Page
	[Tags]  TC_ITMWM_04283   Portal-Mobile       Regression   Ready   Sprint7   rebrand2    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    category/mobile-tablet-accessories-3713634511853.html
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    category/mobile-tablet-accessories-3713634511853.html

TC_ITMWM_04284 Verify WeMall icon Button
	[Tags]   TC_ITMWM_04284  Ready   Regression    Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Open Portal iTrueMart Mobile rebrand    category/mobile-tablet-accessories-3713634511853.html
	Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04285 Verify Header shop cart Button
	[Tags]   TC_ITMWM_04285  Ready   Regression   Portal-Mobile   Sprint7   rebrand2    WLS_Medium
	Login iTruemart And Go To Portal rebrand    category/mobile-tablet-accessories-3713634511853.html
	Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header