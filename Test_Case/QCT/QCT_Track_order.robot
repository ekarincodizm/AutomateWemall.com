*** Settings ***
Test Teardown     Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           DateTime
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Product/Create_Product.robot
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
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track Order/keywords_ApiTrackOrder.robot
Resource          ${CURDIR}/../../Keyword/Features/Order/Keywords_Order_Tracking.robot
Library           ${CURDIR}/../../Python_Library/order_tracking.py
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variables ***
${CHECKOUT_TIMEOUT}    20s
${Text_Email}     flash@test.com
${Text_Name}      Flash test
${Text_Phone}     0918888888
${Text_Address}    test merchant type

*** Test Cases ***
Create Order Item merchant_type = reatil - Success
    [Tags]    QCT
    Insert collection
    ${pkey}=    Insert product with retail type
    ${order_id}    Create Order API - Guest buy single product success with COD
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${order_id}
    #${tracking_inventory_ids_list}=    Get inventory ids from tracking page
    ${order_shipment_items}=    Get order shipment items from DB    ${order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
