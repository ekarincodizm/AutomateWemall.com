*** Settings ***
Library           Selenium2Library
Library           DatabaseLibrary
Resource          ${CURDIR}/../../Resource/Init.robot
Library           ${CURDIR}/../../Python_Library/product.py
Resource          ${CURDIR}/../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot    # Resource    ${CURDIR}/../../Resource/init.robot    # Resource    ${CURDIR}/../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot    # Resource    ${CURDIR}/../../Keyword/Portal/PCMS/Manage_Price_Plan/WebElement_Manage_PricePlan.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTruemart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Common/keywords_date.robot    #Resource    ${CURDIR}/../../Keyword/Portal/iTrueMart/Checko/keywords_full_cart.robot    # Resource    ${CURDIR}/../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot    # Resource    ${CURDIR}/../../Keyword/Common/Keywords_Common.robot

*** Test Cases ***
Test AAD
    [Tags]    poc_aad
    ${token}=    AAD Login And Get Token
    # Test
    #    [Tags]    poc_bundle_keyword
    #    Prepare TruemoveH Product Bundle On PCMS
    # Test Login Keyword
    #    [Tags]    poc_login_keyword
    #    Open Browser    ${ITM_URL}    ${BROWSER}
    #    User Login From Header Bar

Test POC
    [Tags]    POC
    Login Pcms
    Go To    http://thor-pcms.itruemart-dev.com:81/orders/detail/3000495
    Wait Until Element Is Visible    //div[@id="document-file-before-delete-1"]/div/input
    Choose File    //div[@id="document-file-before-delete-1"]/div/input    ${CURDIR}/../../Resource/TestData/Capture.PNG

POC Checkout keyword
    [Tags]    checkout_keyword
    Open Browser    http://www.itruemart-dev.com/products/irobot-roomba-650-2242881474285.html    ${BROWSER}
    #Click Element    //a[@data-style-option="21446917465915"]
    #Wait Until Ajax Loading Is Not Visible
    Sleep    3s
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Enter Valid Data As Member On Checkout2
    Checkout 3 - User Enter Valid Data Master Card As Member
    # [Teardown]    Close Browser

POC Database Library
    Execute Sql

POC Date
    [Tags]    date_keyword
    Helper Date - Get Holidays

Add_To_Cart
    ${inventory_id}    product.Get Inventory Normal
    Level D - Open Level D Using Invtory Id    ${inventory_id}
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    User Select Style Options Using Inventory Id    ${inventory_id}
    Level D - User Click Add To Cart Button

