*** Settings ***
Test Teardown     Close All Browsers
Library           Selenium2Library
Resource          ${CURDIR}/../../Resource/Init.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../Keyword/Features/Sanity_Test/Keywords_Sanity_production.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Receipt/WebElement_Receipt.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Library           ${CURDIR}/../../Python_Library/DatabaseData.py
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variables ***
${CHECKOUT_TIMEOUT}    20s
${Text_Email}     flash@test.com
${Text_Name}      Flash test
${Text_Phone}     0918888888
${Text_Address}    test merchant type
# normal item stock type = 1
${sku_id1}        INAAC1112411
# freebie
${sku_id2}        JHAAA1111211
# item for PC1,PC3
${sku_id3}        LAAAB1114411
# normal item stock type = 4
${sku_id4}        8380
${PC1-code}       PC1CG
${PC3-code}       PC3CG

*** Test Cases ***
Reciept Item Order merchant_type = retail - Success
    [Tags]    QCT
    Insert collection
    ${pkey}=    Insert product with retail type
    ${order_id}    Create Order API - Guest buy single product success with COD
    Login PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${tracking_inventory_ids_list}=    Get inventory ids from tracking page
    Comment    Change All Items Status To Pending Shipment    ${order_id}
    Run PCMS Order
    Go to order reciept page    ${order_id}
    Run PCMS Order
    Go to order reciept page    ${order_id}
    Receipt - Seach order reciept    ${order_id}
    Click expand order detail
    ${order_shipment_items}=    Get order shipment items from DB    ${order_id}
    ${together_order_items}=    Get together order items from DB    ${order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[0][1]}    R
    ${receipt_inventory_merchant_dicts_list}=    Get inventory ids and merchant from receipt page
    Check inventory ids and merchant type case same merchant type    ${tracking_inventory_ids_list}    ${receipt_inventory_merchant_dicts_list}    Retail

*** Keywords ***
Make an order
    Display Full Cart
    User Click Next Process On Full Cart
    Display Checkout Step1 Page
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Click Next
    Checkout1 - Wait Loading
    Display Checkout Step2 Page
    Checkout2 - Input Name    ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Checkout2 - Click Next
    Checkout3 - Display Checkout Step3 Page
    User Click Payment Channel CCW Tab
    Checkout 3 - User Enter Valid Data Master Card As Member
    ${get_order_id}=    Thankyou - Get order id
    [Return]    ${get_order_id}
