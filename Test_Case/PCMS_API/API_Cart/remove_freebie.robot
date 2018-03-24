*** Settings ***
Force Tags        WLS_API_PCMS
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot

Test Setup       Init Test
Test Teardown    Close All Browsers

*** Variables ***
${itm_email}                    robotautomate@gmail.com
${itm_password}                 true1234

*** Keywords ***
Init Test
    Open Browser    ${ITM_URL}/cart    ${BROWSER}
    User Login From login page    ${itm_email}    ${itm_password}
    Clear Cart Current User
    Set Test Variable    ${customer_type}      ${TV_user_type}
    Set Test Variable    ${customer_ref_id}    ${TV_user_id}
    Close Browser

*** Test Cases ***
Remove product with freebie campaign that free item is out of stock
    [Tags]   ITMA-3310   freebie   remove-item   api   ready   regression
    # A+B   ==>  B is out of stock  ==>  remove#2
    # C+D                           ==>  remove#1
    # expect response from api will success and can remove item (cart's items_count and cart_details will decrease)

    Stock - Increase Stock By Inventory Id   ${default_inventoryID_A_with_freebie}   100
    Stock - Increase Stock By Inventory Id   ${default_inventoryID_C_with_freebie}   100
    Stock - Increase Stock By Inventory Id   ${default_inventoryID_B_freebie_for_inv_A}   100
    Stock - Increase Stock By Inventory Id   ${default_inventoryID_D_freebie_for_inv_C}   100

    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${customer_type}    ${customer_ref_id}    ${default_inventoryID_A_with_freebie}    1
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${customer_type}    ${customer_ref_id}    ${default_inventoryID_C_with_freebie}    1

    Stock - Increase Stock By Inventory Id   ${default_inventoryID_B_freebie_for_inv_A}   0

    User Login From login page    ${itm_email}    ${itm_password}
    Go To    ${ITM_URL}/cart

    ${remove_product_C_response}=   API Cart - Remove Single product from Cart       ${PCMS_APP_KEY}    ${customer_type}    ${customer_ref_id}    ${default_inventoryID_C_with_freebie}
    API Cart - Cart Response Should Have Total Item In Cart    ${remove_product_C_response.body}   1
    API Cart - Cart Response Should Has Inventory Id           ${remove_product_C_response.body}   ${default_inventoryID_A_with_freebie}
    API Cart - Cart Response Should Not Has Inventory Id       ${remove_product_C_response.body}   ${default_inventoryID_C_with_freebie}
    # Go To    ${ITM_URL}/cart

    ${remove_product_A_response}=   API Cart - Remove Single product from Cart       ${PCMS_APP_KEY}    ${customer_type}    ${customer_ref_id}    ${default_inventoryID_A_with_freebie}
    API Cart - Cart Response Should Have Total Item In Cart    ${remove_product_A_response.body}   0
    API Cart - Cart Response Should Not Has Inventory Id       ${remove_product_A_response.body}   ${default_inventoryID_A_with_freebie}
    API Cart - Cart Response Should Not Has Inventory Id       ${remove_product_C_response.body}   ${default_inventoryID_C_with_freebie}
    # Go To    ${ITM_URL}/cart

