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
########################################### member/orders #############################################################
TC_ITMWM_04454 Verify Mega Menu - “Register” is available
    [Tags]   TC_ITMWM_04454  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Login link For Test iTruemart Header rebrand incase auth/login    auth/login?continue=${WEMALL_MOBILE}/member/orders

TC_ITMWM_04455 Verify Mega Menu - “Main Page” is available
    [Tags]   TC_ITMWM_04455  Ready    Portal-Mobile   Sprint13   rebrand10    WLS_Low
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Home link For Test iTruemart Header

TC_ITMWM_04456 Verify Mega Menu - Everyday Wow is available
    [Tags]   TC_ITMWM_04456  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_04457 Verify Mega Menu - Category is available
  [Tags]   TC_ITMWM_04457  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
  Login iTruemart And Go To Portal rebrand    member/orders
  Click Main Menu In WeMall Mobile Sites
  Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_04458 Verify Mega Menu - "Category" display follow PCMS config
#   [Tags]   TC_ITMWM_04458  Ready   Regression   Portal-Mobile   Sprint13   Waitfortest   rebrand10
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/orders
#   Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_04460 Verify Tab Menu - Promotion is available
  [Tags]   TC_ITMWM_04460  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
  Login iTruemart And Go To Portal rebrand    member/orders
  Click Main Menu In WeMall Mobile Sites
  Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_04461 Verify Mega Menu - "Promotion" display follow PCMS config
#   [Tags]   TC_ITMWM_04461  Ready   Regression   Portal-Mobile   Sprint13   rebrand10
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/orders
#   Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_04463 Verify Tab Menu - iTruemart is available
    [Tags]   TC_ITMWM_04463  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Itruemart link For Test iTruemart Header

TC_ITMWM_04464 Verify Tab Menu - Cart is available
    [Tags]   TC_ITMWM_04464  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Cart link For Test iTruemart Header

TC_ITMWM_04465 Verify Tab Menu - Order Tracking is available
    [Tags]   TC_ITMWM_04465  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_04466 Verify Tab Menu - Return Policy is available
    [Tags]   TC_ITMWM_04466  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Return Policy link For Test iTruemart Header

TC_ITMWM_04467 Verify Tab Menu - Shipment Policy is available
    [Tags]   TC_ITMWM_04467  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_04468 Verify Tab Menu - Refund Policy is available
    [Tags]   TC_ITMWM_04468  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_04469 Verify Tab Menu - Discount Code is available
    [Tags]   TC_ITMWM_04469  Ready   Regression    Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Discount Code link For Test iTruemart Header

TC_ITMWM_04470 Verify Tab Menu - Contact Us is available
    [Tags]   TC_ITMWM_04470  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Contact Us link For Test iTruemart Header

TC_ITMWM_04471 Verify Tab Menu - Select THAI language is available
    [Tags]   TC_ITMWM_04471  Ready    Portal-Mobile   Sprint13   rebrand10    WLS_Low
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify Thai language For Test iTruemart Header rebrand    member/orders

TC_ITMWM_04472 Verify Tab Menu - Select ENGLISH language is available
    [Tags]   TC_ITMWM_04472  Ready    Portal-Mobile   Sprint13   rebrand10    WLS_Low
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Main Menu In WeMall Mobile Sites
    Verify English language For Test iTruemart Header rebrand    member/orders

TC_ITMWM_04473 Verify Search have auto suggestion when type keyword on Search field
    [Tags]  TC_ITMWM_04473   Portal-Mobile       Regression   Ready   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_04474 Verify Search Function when not found item
    [Tags]  TC_ITMWM_04474   Portal-Mobile       Regression   Ready   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_04475 Verify Cancle Button In Search Page
    [Tags]  TC_ITMWM_04475   Portal-Mobile       Regression   Ready   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    member/orders

TC_ITMWM_04476 Verify WeMall icon Button
    [Tags]   TC_ITMWM_04476  Ready   Regression    Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_04477 Verify Header shop cart Button
    [Tags]   TC_ITMWM_04477  Ready   Regression   Portal-Mobile   Sprint13   rebrand10    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/orders
    Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header