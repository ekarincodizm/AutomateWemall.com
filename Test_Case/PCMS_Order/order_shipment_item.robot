*** Settings ***
Force Tags    WLS_PCMS_Order
Library           Selenium2Library
Library           Collections
Resource          ${CURDIR}/../../Keyword/Database/PCMS/keyword_merchant.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/keyword_policy.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/Keywords_Orders.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/keywords_track_orders.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/keywords_order_detail.robot
Resource          ${CURDIR}/../../Keyword/Portal/CAMPS/CAMPS_Common/Keywords_CAMPS_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/iTruemart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../Resource/Config/${env}/database.robot
Resource          ${CURDIR}/../../Resource/TestData/${env}/test_data.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Test Cases ***
TC_iTM_03449 Verify Header at Shipment table
    [Tags]    TC_iTM_03449    ready    regression    WLS_Medium
    ${today}=    Get Current Date
    ${last_90_day}=    Add Time To Date    ${today}    -90 day
    ${date}=    Convert Date    ${last_90_day}    exclude_millis=yes    result_format=%Y-%m-%d
    ${date_time}=    Set Variable    ${date} 00:00
    Login Pcms
    Track Orders - Go To Order Tracker
    Track Orders - Input Search By Order Date From    ${date_time}
    Track Orders - Click Search Button On Order Tracker Page
    Sleep    5
    ${order_id}=    Get Text From Table    DataTables_Table_0    2    1
    Order - Go to Order Detail Page    ${order_id}
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    1
    Should Be Equal    ${data}    Sale order / Item No.
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    2
    Should Be Equal    ${data}    Material ID / Inventory ID
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    3
    Should Be Equal    ${data}    Item
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    4
    Should Be Equal    ${data}    Quantity
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    5
    Should Be Equal    ${data}    Price
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    6
    Should Be Equal    ${data}    Package ID
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    7
    Should Be Equal    ${data}    Serial/IMEI
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    8
    Should Be Equal    ${data}    Payment Status
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    9
    Should Be Equal    ${data}    Item Status
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    10
    Should Be Equal    ${data}      Cancel Reason
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    11
    Should Be Equal    ${data}    Merchant Code/Name
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    12
    Should Be Equal    ${data}    Delivery Time (Day(s))
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    13
    Should Be Equal    ${data}    Estimated Delivery Date
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    14
    Should Be Equal    ${data}    Tracking Number
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    15
    Should Be Equal    ${data}    3PL
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    16
    Should Be Equal    ${data}    Operation Status
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    17
    Should Be Equal    ${data}    Operation SLA
    ${data}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    1    18
    Should Be Equal    ${data}    Stock Type
    [Teardown]    Close All Browsers

TC_iTM_03450 Verify Merchant Name and Merchant Code at Shipment table
    [Tags]    TC_iTM_03450    ready    regression    WLS_Medium
    ${pKey}=    Set Variable    @{STARK_PRODUCTS}[0]
    ${order}=    Member Buy Product(s) on iTruemart with CCW payment    ${ITM_USERNAME}    ${ITM_PASSWORD}    none    ${pKey}
    Login Pcms
    Order - Go to Order Detail Page    ${order}
    ${inventory_id}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    2    2
    @{inventory_id}=    Split String    ${inventory_id}    /
    ${inventory_id}=    Remove String    @{inventory_id}[1]    ${SPACE}
    ${merchant_code_and_name}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    2    10
    ${delivery_time}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    2    11
    ${estimated_delivery_date}=    Get Table Cell    ${ORDER-DETAIL-TABLE}    2    12
    ${merchant_code_db}    ${merchant_name_db}=    Get Merchant Code and Name from DB by Product pkey    ${pKey}
    Should Be Equal    ${merchant_code_and_name}    ${merchant_code_db}/${merchant_name_db}
    ${merchant_id_db}=    Get Shop ID from DB by Product pkey    ${pKey}
    ${delivery_min_day_db}    ${delivery_max_day_db}=    Get Policy Data from DB by Shop ID    ${merchant_id_db}
    Should Be Equal    ${delivery_time}    ${delivery_min_day_db}-${delivery_max_day_db}
    Should Match Regexp    ${estimated_delivery_date}    ^[0-3][0-9] (ม.ค.|ก.พ.|มี.ค.|เม.ย.|พ.ค.|มิ.ย.|ก.ค.|ส.ค.|ก.ย.|ต.ค.|พ.ย.|ธ.ค.) [0-9]{2} - [0-3][0-9] (ม.ค.|ก.พ.|มี.ค.|เม.ย.|พ.ค.|มิ.ย.|ก.ค.|ส.ค.|ก.ย.|ต.ค.|พ.ย.|ธ.ค.) [0-9]{2}$
    [Teardown]    Close All Browsers
