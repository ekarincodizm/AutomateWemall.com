*** Settings ***
Resource          ../../../Common/keywords_itruemart_common.robot
Library           String
Library           HttpLibrary.HTTP
Library           Selenium2Library
Resource          ../../../Database/PCMS/keyword_pcms.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          ../Stock/keywords_stock.robot
Resource          ../../../Features/Create_Order/Create_order.txt

*** Keywords ***
Create Order API - Guest buy single product success with CS
    [Arguments]    ${inventory_id}=${default_inventoryID_cs}    ${qty}=1
    ${Customer_Type}    Set Variable    non-user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    153213837979857    #{CS}
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    ${Customer_ref_id}    Create Order API Get Customer ref id
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}    ${qty}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Log To Console    ${order_id}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Guest buy 1 item for retail and 1 item for market place and pay successfully with COD
    [Arguments]    ${inv1}=${default_inventoryID_retail}    ${inv2}=${default_inventoryID_market_place}    ${qty}=1
    ${Customer_Type}    Set Variable    non-user
    ${inventory_id}    Set Variable    ${inv1}
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155613837979771    #{COD}
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inv1}
    Stock - Increase Stock By Inventory Id    ${inv2}
    ${Customer_ref_id}    Create Order API Get Customer ref id
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inv1}    ${qty}
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inv2}    ${qty}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Log To Console    ${order_id}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Guest buy single product success with COD
    [Arguments]    ${inventory_id}=${default_inventoryID_cod}     ${qty}=1
    ${Customer_Type}    Set Variable    non-user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155613837979771
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    ${Customer_ref_id}    Create Order API Get Customer ref id
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}    ${qty}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Log To Console    ${order_id}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Guest buy multi product success with CS
    [Arguments]    ${inventory_id_1}=${default_inventoryID_cs}    ${inventory_id_2}=${default_inventoryID_cs}     ${qty}=1
    ${Customer_Type}    Set Variable    non-user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    153213837979857    #{CS}
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id_1}
    Stock - Increase Stock By Inventory Id    ${inventory_id_2}
    ${Customer_ref_id}    Create Order API Get Customer ref id
    Create Order API Add Multi product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id_1}    ${qty}    ${inventory_id_2}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Log To Console    ${order_id}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Guest buy multi product success with COD
    [Arguments]    ${inventory_id_1}=${default_inventoryID_cod}    ${inventory_id_2}=${default_inventoryID_cod}    ${qty}=1
    ${Customer_Type}    Set Variable    non-user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155613837979771
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id_1}
    Stock - Increase Stock By Inventory Id    ${inventory_id_2}
    ${Customer_ref_id}    Create Order API Get Customer ref id
    Create Order API Add Multi product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id_1}    ${qty}    ${inventory_id_2}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Log To Console    ${order_id}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Member buy single product success with CS
    [Arguments]    ${inventory_id}=${default_inventoryID_cs}    ${qty}=1
    ${Existing_User_Email}    Set Variable    Loki@Loki.com
    ${Customer_Type}    Set Variable    user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    153213837979857
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    ${Customer_ref_id}    Create Order API Get Customer ref id from DB - Existing User    ${Existing_User_Email}
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}    ${qty}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Member buy single product success with COD
    [Arguments]    ${inventory_id}=${default_inventoryID_cod}    ${qty}=1
    ${Existing_User_Email}    Set Variable    Loki@Loki.com
    ${Customer_Type}    Set Variable    user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155613837979771
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    ${Customer_ref_id}    Create Order API Get Customer ref id from DB - Existing User    ${Existing_User_Email}
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}    ${qty}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Member buy multi product success with CS
    [Arguments]    ${inventory_id_1}=${default_inventoryID_cs}    ${inventory_id_2}=${default_inventoryID_cs}     ${qty}=1
    ${Existing_User_Email}    Set Variable    Loki@Loki.com
    ${Customer_Type}    Set Variable    user
    ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    153213837979857
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id_1}
    Stock - Increase Stock By Inventory Id    ${inventory_id_2}
    ${Customer_ref_id}    Create Order API Get Customer ref id from DB - Existing User    ${Existing_User_Email}
    Create Order API Add Multi product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id_1}    ${qty}    ${inventory_id_2}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Member buy multi product success with COD
    [Arguments]    ${inventory_id_1}=${default_inventoryID_cod}    ${inventory_id_2}=${default_inventoryID_cod}    ${qty}=1
    ${Existing_User_Email}    Set Variable    Loki@Loki.com
    ${Customer_Type}    Set Variable    user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155613837979771    #{COD}
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id_1}
    Stock - Increase Stock By Inventory Id    ${inventory_id_2}
    ${Customer_ref_id}    Create Order API Get Customer ref id from DB - Existing User    ${Existing_User_Email}
    Create Order API Add Multi product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id_1}    ${qty}    ${inventory_id_2}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    ${order_id}=    Create Order API Create Order bypass Payment Gateway    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    [Teardown]    close browser
    [Return]    ${order_id}

Create Order API - Guest buy single product success with CCW
    [Arguments]    ${inventory_id}=${default_inventoryID_cs}      ${qty}=1
    [Documentation]    API create product with CCW not pass payment gateway (Hack database and change payment status to success)
    ${Customer_Type}    Set Variable    non-user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}=    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155413837979192
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    ${Customer_ref_id}    Create Order API Get Customer ref id
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}    ${qty}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    Create Order API Create Order hack DB    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    ${order_id}=    Create Order API get order from DB    ${Customer_ref_id}
    log    ${order_id[0][0]}
    Create_order.Set Payment Success For CS    ${order_id[0][0]}
    [Teardown]    close all browsers
    [Return]    ${order_id[0][0]}

Create Order API - Guest buy multi product success with CCW
    [Arguments]    ${inventory_id_1}=${default_inventoryID_cod}    ${inventory_id_2}=${default_inventoryID_cod}     ${qty}=1
    [Documentation]    API create product with CCW not pass payment gateway (Hack database and change payment status to success)
    ${Customer_Type}    Set Variable    non-user
    # ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    Loki
    ${Customer_Address}    Set Variable    Loki Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Email}    Set Variable    Loki@Loki.com
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155413837979192
    ${Coupon_Code}    Set Variable    IT894
    Stock - Increase Stock By Inventory Id    ${inventory_id_1}
    Stock - Increase Stock By Inventory Id    ${inventory_id_2}
    ${Customer_ref_id}    Create Order API Get Customer ref id
    Create Order API Add Multi product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id_1}    ${qty}    ${inventory_id_2}
    Create Order API Add Customer Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Order API Set Billing Info    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Order API Set Payment Method    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Comment    Create Order API Apply Coupon Code    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    Create Order API Create Order hack DB    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    ${order_id}=    Create Order API get order from DB    ${Customer_ref_id}
    log    ${order_id[0][0]}
    Create_order.Set Payment Success For CS    ${order_id[0][0]}
    [Teardown]    close all browsers
    [Return]    ${order_id[0][0]}

Create Order API Get Customer ref id
    Open Browser    ${ITM_URL}/test/user    chrome
    Wait Until Element Is Visible    //i[1]
    ${group}=    Get Text    //i[1]
    Log to console    ${group}
    ${idx}=    Set Variable If    ${group} == "guest"    2    3
    ${user_type}=    Set Variable If    ${group} == "guest"    non-user    user
    ${user_id}=    Get Text    //i[${idx}]
    ${Customer_ref_id}=    Remove String    ${user_id}    "
    Log To Console    ${Customer_ref_id}
    [Return]    ${Customer_ref_id}

Create Order API Add Single product to Cart
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}    ${qty}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    inventory_id=${inventory_id}&type=normal&qty=${qty}
    HttpLibrary.HTTP.POST    /api/v2/${PCMS_APP_KEY}/cart/add-item?customer_type=${Customer_Type}&customer_ref_id=${Customer_ref_id}
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Create Order API Add Multi product to Cart
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id_1}    ${qty}    ${inventory_id_2}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    inventory_id=${inventory_id_1}&type=normal&qty=${qty}
    HttpLibrary.HTTP.POST    /api/v2/${PCMS_APP_KEY}/cart/add-item?customer_type=${Customer_Type}&customer_ref_id=${Customer_ref_id}
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    inventory_id=${inventory_id_2}&type=normal&qty=${qty}
    HttpLibrary.HTTP.POST    /api/v2/${PCMS_APP_KEY}/cart/add-item?customer_type=${Customer_Type}&customer_ref_id=${Customer_ref_id}
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Create Order API Add Customer Info
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Customer_Name}    ${Customer_Address}    ${Customer_District_id}
    ...    ${Customer_City_id}    ${Customer_Province_id}    ${Customer_Postcode}    ${Customer_Tel}    ${Customer_Email}    ${Customer_Address_id}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    customer_ref_id=${Customer_ref_id}&customer_type=${Customer_Type}&customer_name=${Customer_Name}&customer_address=${Customer_Address}&customer_district_id=${Customer_District_id}&customer_city_id=${Customer_City_id}&customer_province_id=${Customer_Province_id}&customer_postcode=${Customer_Postcode}&customer_tel=${Customer_Tel}&customer_email=${Customer_Email}&customer_address_id=${Customer_Address_id}
    HttpLibrary.HTTP.POST    /api/${PCMS_APP_KEY}/checkout/set-customer-info
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Create Order API Set Billing Info
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    customer_ref_id=${Customer_ref_id}&customer_type=${Customer_Type}
    HttpLibrary.HTTP.POST    /api/${PCMS_APP_KEY}/cart/convert-shipping-to-bill
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Create Order API Set Payment Method
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Payment_Method}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    customer_ref_id=${Customer_ref_id}&customer_type=${Customer_Type}&payment_method=${Payment_Method}
    HttpLibrary.HTTP.POST    /api/${PCMS_APP_KEY}/checkout/set-payment-info
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Create Order API Apply Coupon Code
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}    ${Coupon_Code}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    customer_ref_id=${Customer_ref_id}&customer_type=${Customer_Type}&code=${Coupon_Code}
    HttpLibrary.HTTP.POST    /api/${PCMS_APP_KEY}/cart/apply-coupon
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Create Order API Create Order bypass Payment Gateway
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    customer_ref_id=${Customer_ref_id}&customer_type=${Customer_Type}
    HttpLibrary.HTTP.POST    /api/${PCMS_APP_KEY}/checkout/create-order
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    ${is_html}=    Run Keyword And Return Status    Get Json Value    ${result}    /data/postUrl
    ${response2}=    Run Keyword If    ${is_html}==True    Get Json Value    ${result}    /data/postUrl
    ${order1}=    Run Keyword If    ${is_html}==True    Get Regexp Matches    ${response2}    order_id\=[0-9]*
    ${is_postURL}=    Run Keyword And Return Status    Get Json Value    ${result}    /data/html
    ${response1}=    Run Keyword If    ${is_postURL}==True    Get Json Value    ${result}    /data/html
    ${order2}=    Run Keyword If    ${is_postURL}==True    Get Regexp Matches    ${response1}    order_id\=[0-9]*
    ${Order_id}=    Run Keyword If    ${order1} != None    Get From List    ${order1}    0
    ...    ELSE    Get From List    ${order2}    0
    ${Order_id}=    Replace String    ${Order_id}    order_id=    ${EMPTY}
    [Return]    ${Order_id}

Create Order API Create Order hack DB
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_ref_id}    ${Customer_Type}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    customer_ref_id=${Customer_ref_id}&customer_type=${Customer_Type}
    HttpLibrary.HTTP.POST    /api/${PCMS_APP_KEY}/checkout/create-order
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    ${Order_id}    Create Order API Update payment status to success    ${Customer_ref_id}
    [Return]    ${Order_id}

Create Order API Get Customer ref id from DB - Existing User
    [Arguments]    ${Existing_User_Email}
    Connect DB ITM
    ${Customer_ref_id}=    Query    SELECT sso_id FROM `members` where email = "${Existing_User_Email}"
    log    ${Customer_ref_id[0][0]}
    [Return]    ${Customer_ref_id[0][0]}

Create Order API Get Inventory ID
    [Arguments]    ${inventory_id}=random
    ${inv_id}=    Run Keyword If    'random' == '${inventory_id}'    Get Inventory ID
    ...    ELSE    Set Variable    ${inventory_id}
    [Return]    ${inv_id}

Create Order API Update payment status to success
    [Arguments]    ${Customer_ref_id}
    Connect DB ITM
    Query    UPDATE `order_shipment_items` SET payment_status = "success" WHERE order_id in (SELECT id FROM `orders` where customer_ref_id = "${Customer_ref_id}")

Create Order API get order from DB
    [Arguments]    ${Customer_ref_id}
    Connect DB ITM
    ${order_id}    Query    SELECT id FROM `orders` where customer_ref_id = "${Customer_ref_id}"
    [Return]    ${order_id}

Get Customer ref id for add product to cart
    Open Browser    ${ITM_URL}    chrome
    Go To    ${ITM_URL}/test/user
    Wait Until Element Is Visible    //i[1]
    ${group}=    Get Text    //i[1]
    Log to console    ${group}
    ${idx}=    Set Variable If    ${group} == "guest"    2    3
    ${user_type}=    Set Variable If    ${group} == "guest"    non-user    user
    ${user_id}=    Get Text    //i[${idx}]
    ${Customer_ref_id}=    Remove String    ${user_id}    "
    Log To Console    ${Customer_ref_id}
    [Return]    ${Customer_ref_id}

Guest add multiple products until checkout3
    [Arguments]    ${Text_Email}    ${inventory_id_1}=${default_inventoryID_cod}    ${inventory_id_2}=${default_inventoryID_cod}
    ${Customer_Type}    Set Variable    non-user
    ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    itruemartQA
    ${Customer_Address}    Set Variable    itruemart Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155413837979192
    Stock - Increase Stock By Inventory Id    ${inventory_id_1}
    Stock - Increase Stock By Inventory Id    ${inventory_id_2}
    ${Customer_ref_id}    Get Customer ref id for add product to cart
    Create Order API Add Multi product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id_1}    ${qty}    ${inventory_id_2}
    Go To     ${ITM_URL}/checkout/step1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Checkout2 - Input Name    ${Customer_Name}
    Checkout2 - Input Phone    ${Customer_Tel}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Customer_Address}
    Checkout2 - Click Next
    [Return]    ${Customer_ref_id}

Guest add single product until checkout3 return Customer Ref Id
    [Arguments]    ${Text_Email}    ${inventory_id}=${default_inventoryID_cod}
    ${Customer_Type}    Set Variable    non-user
    ${qty}    Set Variable    1
    ${Customer_Name}    Set Variable    itruemartQA
    ${Customer_Address}    Set Variable    itruemart Zone 19 floor
    ${Customer_District_id}    Set Variable    184
    ${Customer_City_id}    Set Variable    7
    ${Customer_Province_id}    Set Variable    1
    ${Customer_Postcode}    Set Variable    10400
    ${Customer_Tel}    Set Variable    0919199191
    ${Customer_Address_id}    Set Variable    ${EMPTY}
    ${Payment_Method}    Set Variable    155413837979192
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    ${Customer_ref_id}    Get Customer ref id for add product to cart
    Create Order API Add Single product to Cart    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}    ${qty}
    Go To     ${ITM_URL}/checkout/step1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Checkout2 - Input Name    ${Customer_Name}
    Checkout2 - Input Phone    ${Customer_Tel}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Customer_Address}
    Checkout2 - Click Next
    [Return]    ${Customer_ref_id}