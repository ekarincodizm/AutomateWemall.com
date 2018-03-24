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
########################################### Level D #############################################################
TC_ITMWM_04430 Verify Mega Menu - “Register” is available
    [Tags]   TC_ITMWM_04430  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Login link For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04431 Verify Mega Menu - “Main Page” is available
    [Tags]   TC_ITMWM_04431  Ready    Portal-Mobile   Sprint7   rebrand9    WLS_Low
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Home link For Test iTruemart Header

TC_ITMWM_04432 Verify Mega Menu - Everyday Wow is available
    [Tags]   TC_ITMWM_04432  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04433 Verify Mega Menu - Category is available
  [Tags]   TC_ITMWM_04433  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
  Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
  Click Main Menu In WeMall Mobile Sites
  Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04434 Verify Mega Menu - "Category" display follow PCMS config
#   [Tags]   TC_ITMWM_04434  Ready   Regression   Portal-Mobile   Sprint7   Waitfortest   rebrand9
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
#   Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04436 Verify Tab Menu - Promotion is available
  [Tags]   TC_ITMWM_04436  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
  Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
  Click Main Menu In WeMall Mobile Sites
  Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04437 Verify Mega Menu - "Promotion" display follow PCMS config
#   [Tags]   TC_ITMWM_04437  Ready   Regression   Portal-Mobile   Sprint7   rebrand9
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
#   Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04439 Verify Tab Menu - iTruemart is available
    [Tags]   TC_ITMWM_04439  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04440 Verify Tab Menu - Cart is available
    [Tags]   TC_ITMWM_04440  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Login iTruemart And Go To Portal rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Cart link For Test iTruemart Header

TC_ITMWM_04441 Verify Tab Menu - Order Tracking is available
    [Tags]   TC_ITMWM_04441  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Login iTruemart And Go To Portal rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04442 Verify Tab Menu - Return Policy is available
    [Tags]   TC_ITMWM_04442  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04443 Verify Tab Menu - Shipment Policy is available
    [Tags]   TC_ITMWM_04443  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04444 Verify Tab Menu - Refund Policy is available
    [Tags]   TC_ITMWM_04444  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04445 Verify Tab Menu - Discount Code is available
    [Tags]   TC_ITMWM_04445  Ready   Regression    Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04446 Verify Tab Menu - Contact Us is available
    [Tags]   TC_ITMWM_04446  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04447 Verify Tab Menu - Select THAI language is available
    [Tags]   TC_ITMWM_04447  Ready    Portal-Mobile   Sprint7   rebrand9    WLS_Low
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify Thai language For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04448 Verify Tab Menu - Select ENGLISH language is available
    [Tags]   TC_ITMWM_04448  Ready    Portal-Mobile   Sprint7   rebrand9    WLS_Low
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Main Menu In WeMall Mobile Sites
    Verify English language For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04449 Verify Search have auto suggestion when type keyword on Search field
    [Tags]  TC_ITMWM_04449   Portal-Mobile       Regression   Ready   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04450 Verify Search Function when not found item
    [Tags]  TC_ITMWM_04450   Portal-Mobile       Regression   Ready   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04451 Verify Cancle Button In Search Page
    [Tags]  TC_ITMWM_04451   Portal-Mobile       Regression   Ready   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile without resize rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html

TC_ITMWM_04452 Verify WeMall icon Button
    [Tags]   TC_ITMWM_04452  Ready   Regression    Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04453 Verify Header shop cart Button
    [Tags]   TC_ITMWM_04453  Ready   Regression   Portal-Mobile   Sprint7   rebrand9    WLS_Medium
    Login iTruemart And Go To Portal rebrand    products/infothink-avengers-captain-america-8-gb-2951108269824.html
    Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header