*** Settings ***
Library    ${CURDIR}/../../../../Python_Library/shop_library.py
Library    HttpLibrary.HTTP

Resource    keywords_policy.robot
*** Keyword ***
API Shop - Create Shop
    [Arguments]    ${shop_code}    ${shop_name}
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    {"shop_code":"${shop_code}","shop_name":"${shop_name}"}
    HttpLibrary.HTTP.POST    /api/v4/shop/create
    ${result}=    Get Response Body
    [Return]    ${result}

Delete Shop By Shop Code
    [Arguments]    ${shop_code}
    ${result}=    delete_shop_from_tbl_shops    ${shop_code}
    [Return]    ${result}

Count All Shop
    ${result}=    count_shop_from_tbl_shops
    [Return]    ${result}

Get Merchant ID By Merchant Code
    [Arguments]    ${merchant_code}
    ${merchant_id}=    py_get_merchant_id_by_merchant_code    ${merchant_code}
    [Return]    ${merchant_id}

Get Shop Id By Inventory Id
    ${shop_id}=    get_shop_id_by_inv_id    ${var.product_inventory_id}
    Set test variable    ${var.shop_id}    ${shop_id}
    Log To Console    var.shop_id=${var.shop_id}

Create 2 Shops
    Set Test Variable    ${var.shop_code1}    ROBOTSHOPCODE1
    Set Test Variable    ${var.shop_name1}    ROBOT_SHOPNAME_1
    Set Test Variable    ${var.shop_code2}    ROBOTSHOPCODE2
    Set Test Variable    ${var.shop_name2}    ROBOT_SHOPNAME_2
    Delete 2 Shops
    ${res1}=    API Shop - Create Shop    ${var.shop_code1}    ${var.shop_name1}
    ${res2}=    API Shop - Create Shop    ${var.shop_code2}    ${var.shop_name2}

Create 2 Shops Version 2
    Set Test Variable    ${var.shop_code1}    ROBOTSHOPCODE1v2
    Set Test Variable    ${var.shop_name1}    ROBOT_SHOPNAME_1_v2
    Set Test Variable    ${var.shop_code2}    ROBOTSHOPCODE2v2
    Set Test Variable    ${var.shop_name2}    ROBOT_SHOPNAME_2_v2
    Delete 2 Shops
    ${res1}=    API Shop - Create Shop    ${var.shop_code1}    ${var.shop_name1}
    ${res2}=    API Shop - Create Shop    ${var.shop_code2}    ${var.shop_name2}

Create 2 Shops Version 3
    Set Test Variable    ${var.shop_code1}    ROBOTSHOPCODE1v3
    Set Test Variable    ${var.shop_name1}    ROBOT_SHOPNAME_1_v3
    Set Test Variable    ${var.shop_code2}    ROBOTSHOPCODE2v3
    Set Test Variable    ${var.shop_name2}    ROBOT_SHOPNAME_2_v3
    Delete 2 Shops
    ${res1}=    API Shop - Create Shop    ${var.shop_code1}    ${var.shop_name1}
    ${res2}=    API Shop - Create Shop    ${var.shop_code2}    ${var.shop_name2}
    Log TO console   ====== res1=${res1} :::: resp2=${res2} ======



Delete 2 Shops
    Delete Shop By Shop Code    ${var.shop_code1}
    Delete Shop By Shop Code    ${var.shop_code2}

Prepare Two Shops
    Create 2 Shops

    ${shop_id_1}=    Get Merchant ID By Merchant Code    ${var.shop_code1}
    ${shop_id_2}=    Get Merchant ID By Merchant Code    ${var.shop_code2}
    ${shop_id_1}=    Get From List    ${shop_id_1}    0
    ${shop_id_2}=    Get From List    ${shop_id_2}    0

    Set Test Variable    ${var.shop_id_1}    ${shop_id_1}
    Set Test Variable    ${var.shop_id_2}    ${shop_id_2}

    Create 2 Shop Policies


Prepare Two Shops Version 2
    Create 2 Shops Version 2

    ${shop_id_1}=    Get Merchant ID By Merchant Code    ${var.shop_code1}
    ${shop_id_2}=    Get Merchant ID By Merchant Code    ${var.shop_code2}
    ${shop_id_1}=    Get From List    ${shop_id_1}    0
    ${shop_id_2}=    Get From List    ${shop_id_2}    0

    Set Test Variable    ${var.shop_id_1}    ${shop_id_1}
    Set Test Variable    ${var.shop_id_2}    ${shop_id_2}

    Create 2 Shop Policies

Prepare Two Shops Version 3
    Create 2 Shops Version 3

    ${shop_id_1}=    Get Merchant ID By Merchant Code    ${var.shop_code1}
    ${shop_id_2}=    Get Merchant ID By Merchant Code    ${var.shop_code2}
    ${shop_id_1}=    Get From List    ${shop_id_1}    0
    ${shop_id_2}=    Get From List    ${shop_id_2}    0

    Set Test Variable    ${var.shop_id_1}    ${shop_id_1}
    Set Test Variable    ${var.shop_id_2}    ${shop_id_2}

    Create 2 Shop Policies