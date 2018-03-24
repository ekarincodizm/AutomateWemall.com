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
########################################### /member/profile #############################################################
TC_ITMWM_00677 Verify Mega Menu - “Register” is available
    [Tags]   TC_ITMWM_00677  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Open Portal iTrueMart Mobile rebrand    auth/login?continue=${WEMALL_MOBILE}/member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Login link For Test iTruemart Header rebrand incase auth/login    auth/login?continue=${WEMALL_MOBILE}/member/profile

TC_ITMWM_00678 Verify Mega Menu - “Main Page” is available
    [Tags]   TC_ITMWM_00678  Ready    Portal-Mobile   Sprint14   rebrand11   WLS_Low
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Home link For Test iTruemart Header

TC_ITMWM_00679 Verify Mega Menu - Everyday Wow is available
    [Tags]   TC_ITMWM_00679  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Everyday Wow link For Test iTruemart Header

TC_ITMWM_00680 Verify Mega Menu - Category is available
  [Tags]   TC_ITMWM_00680  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
  Login iTruemart And Go To Portal rebrand    member/profile
  Click Main Menu In WeMall Mobile Sites
  Verify Category Main Link For Test iTruemart Header

# TC_ITMWM_00681 Verify Mega Menu - "Category" display follow PCMS config
#   [Tags]   TC_ITMWM_00681  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/profile
#   Compare Mega Menu Category In WeMall Mobile Site with PCMS

TC_ITMWM_00683 Verify Tab Menu - Promotion is available
  [Tags]   TC_ITMWM_00683  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
  Login iTruemart And Go To Portal rebrand    member/profile
  Click Main Menu In WeMall Mobile Sites
  Verify Promotion Main Link For Test iTruemart Header

# TC_ITMWM_00684 Verify Mega Menu - "Promotion" display follow PCMS config
#   [Tags]   TC_ITMWM_00684  Ready   Regression   Portal-Mobile   Sprint14   rebrand11
#   Open PCMS iTruemart
#   Verify Category Level 1
#   Login iTruemart And Go To Portal rebrand    member/profile
#   Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS

TC_ITMWM_00686 Verify Tab Menu - iTruemart is available
    [Tags]   TC_ITMWM_00686  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Itruemart link For Test iTruemart Header

TC_ITMWM_00687 Verify Tab Menu - Cart is available
    [Tags]   TC_ITMWM_00687  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Cart link For Test iTruemart Header

TC_ITMWM_00688 Verify Tab Menu - Order Tracking is available
    [Tags]   TC_ITMWM_00688  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Order Tracking link For Test iTruemart Header

TC_ITMWM_00689 Verify Tab Menu - Return Policy is available
    [Tags]   TC_ITMWM_00689  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Return Policy link For Test iTruemart Header

TC_ITMWM_00690 Verify Tab Menu - Shipment Policy is available
    [Tags]   TC_ITMWM_00690  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Shipment Policy link For Test iTruemart Header

TC_ITMWM_00691 Verify Tab Menu - Refund Policy is available
    [Tags]   TC_ITMWM_00691  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Refund Policy link For Test iTruemart Header

TC_ITMWM_00692 Verify Tab Menu - Discount Code is available
    [Tags]   TC_ITMWM_00692  Ready   Regression    Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Discount Code link For Test iTruemart Header

TC_ITMWM_00693 Verify Tab Menu - Contact Us is available
    [Tags]   TC_ITMWM_00693  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Contact Us link For Test iTruemart Header

TC_ITMWM_00694 Verify Tab Menu - Select THAI language is available
    [Tags]   TC_ITMWM_00694  Ready    Portal-Mobile   Sprint14   rebrand11    WLS_Low
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify Thai language For Test iTruemart Header rebrand    member/profile

TC_ITMWM_00695 Verify Tab Menu - Select ENGLISH language is available
    [Tags]   TC_ITMWM_00695  Ready    Portal-Mobile   Sprint14   rebrand11    WLS_Low
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Main Menu In WeMall Mobile Sites
    Verify English language For Test iTruemart Header rebrand    member/profile

TC_ITMWM_00696 Verify Search have auto suggestion when type keyword on Search field
    [Tags]  TC_ITMWM_00696   Portal-Mobile       Regression   Ready   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Search Icon To Go To Search Function
    Verify Search Auto Suggestion

TC_ITMWM_00697 Verify Search Function when not found item
    [Tags]  TC_ITMWM_00697   Portal-Mobile       Regression   Ready   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Search Icon To Go To Search Function
    Verify Search When No Data Found

TC_ITMWM_00698 Verify Cancle Button In Search Page
    [Tags]  TC_ITMWM_00698   Portal-Mobile       Regression   Ready   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Click Search Icon To Go To Search Function
    Click Cancel Button On Search Page
    Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand    member/profile

TC_ITMWM_00699 Verify WeMall icon Button
    [Tags]   TC_ITMWM_00699  Ready   Regression    Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header

TC_ITMWM_00700 Verify Header shop cart Button
    [Tags]   TC_ITMWM_00700  Ready   Regression   Portal-Mobile   Sprint14   rebrand11    WLS_Medium
    Login iTruemart And Go To Portal rebrand    member/profile
    Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header