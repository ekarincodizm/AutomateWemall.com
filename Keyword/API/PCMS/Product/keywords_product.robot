*** Settings ***
Library    ${CURDIR}/../../../../Python_Library/product.py

*** Keyword ***
Call API Get Product Detail
	[Arguments]    ${product_pkey}
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    HttpLibrary.HTTP.GET    /api/45311375168544/products/${product_pkey}
    ${response}=    Get Response Body
    [Return]    ${response}

Get Normal Product Pkey
	${product_data}=    py_get_product_level_d_has_style
    ${product_pkey}=    Get From Dictionary    ${product_data}    product_pkey
    [Return]    ${product_pkey}

Get Merchant Data By Product Pkey
	[Arguments]    ${product_pkey}
	${result}=    py_get_merchant_data_by_product_pkey    ${product_pkey}
	[Return]    ${result}  #Example result {'merchant_id': 322963, 'merchant_code': 'ITM', 'merchant_name', 'ITRUEMART'}

Get Merchant Policy By Merchant ID
	[Arguments]    ${merchant_id}
	${result}=    py_get_merchant_policy_by_merchant_id    ${merchant_id}
	[Return]    ${result}  #Dictionary {'policy_map':'xxx', 'policy_translate':'yyy'}

Get Merchant Data By Inventory ID
	[Arguments]    ${inventory_id}
	${result}=    py_get_shop_id_and_name_by_inventory_id    ${inventory_id}
	[Return]    ${result}

Prepare Product Merchant Alias
    [Arguments]    ${alias_merchant_name}    ${alias_merchant_code}
    ${product}=    py_get_product_without_alias
    ${product_id}=    Get From List    ${product}    0
    ${product_pkey}=    Get From List    ${product}    1
    ${merchant_alias_id}=    py_insert_merchant_alias    ${alias_merchant_name}    ${alias_merchant_code}
    py_insert_product_merchant_alias    ${product_id}    ${merchant_alias_id}
    Log To Console    Product=${product}

    Wemall Common - Assign Value To Test Variable    product_id    ${product_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    ${product_pkey}
    Wemall Common - Assign Value To Test Variable    merchant_alias_id    ${merchant_alias_id}

Prepare Product Merchant Alias With Product ID
    [Arguments]    ${alias_merchant_name}    ${alias_merchant_code}
    ${product_id}=    Set Variable    ${var.product_id}
    ${product_pkey}=    product.get_product_pkey    ${var.inventory_id}

    ${merchant_alias_id}=    py_insert_merchant_alias    ${alias_merchant_name}    ${alias_merchant_code}
    py_insert_product_merchant_alias    ${product_id}    ${merchant_alias_id}

    Log To Console    alias_merchant_name....${alias_merchant_name}
    Log To Console    alias_merchant_code....${alias_merchant_code}
    Log To Console    product_id....${product_id}
    Log To Console    product_pkey....${product_pkey}
    Log To Console    merchant_alias_id....${merchant_alias_id}

    Wemall Common - Assign Value To Test Variable    product_id    ${product_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    ${product_pkey}
    Wemall Common - Assign Value To Test Variable    merchant_alias_id    ${merchant_alias_id}

Prepare Product Merchant Alias To Mutiple Product ID
    [Arguments]    ${alias_merchant_name}    ${alias_merchant_code}
    ${merchant_alias_id}=    py_insert_merchant_alias    ${alias_merchant_name}    ${alias_merchant_code}
    ${count}=   Get Length   ${var.product_id}
    ${product_pkey_list}=    Create List
    :For   ${x}  IN RANGE   ${count}
    \   ${product_id}=      Set Variable    @{var.product_id}[${x}]
    \   ${product_pkey}=    product.get_product_pkey    @{var.inventory_id}[${x}]
    \   py_insert_product_merchant_alias    ${product_id}    ${merchant_alias_id}
    \   Append To List    ${product_pkey_list}   ${product_pkey}

    Wemall Common - Assign Value To Test Variable    product_id      ${var.product_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    ${product_pkey_list}
    Wemall Common - Assign Value To Test Variable    merchant_alias_id    ${merchant_alias_id}

Prepare Product Without Alias Merchant
    ${product}=    py_get_product_without_alias
    ${product_id}=    Get From List    ${product}    0
    ${product_pkey}=    Get From List    ${product}    1

    Wemall Common - Assign Value To Test Variable    product_id    ${product_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    ${product_pkey}


Delete Merchant Alias And Product
    ${merchant_alias_id}=    Wemall Common - Get Value From Test Variable    merchant_alias_id
    Log to Console   merchant_alias_id=${merchant_alias_id}
    py_delete_merchant_alias_and_product    ${merchant_alias_id}

Expect Product Alias Merchant
    [Arguments]    ${expect_merchant_code}
    ${product_pkey}=    Wemall Common - Get Value From Test Variable    product_pkey
    ${product_detail}=    Call API Get Product Detail    ${product_pkey}
    ${actual_merchant_code}=   Get Json Value  ${product_detail}  /data/alias_merchant_code

    Should be Equal    "${expect_merchant_code}"    ${actual_merchant_code}

Expect Product Without Alias Merchant
    [Arguments]    ${expect_merchant_code}
    ${product_pkey}=    Wemall Common - Get Value From Test Variable    product_pkey
    ${product_detail}=    Call API Get Product Detail    ${product_pkey}
    ${actual_merchant_code}=   Get Json Value  ${product_detail}  /data/alias_merchant_code

    Should be Equal    ${expect_merchant_code}    ${actual_merchant_code}

Get Product Detail By Product Pkey
    [Arguments]    ${product_pkey}
    ${response}=    Call API Get Product Detail    ${product_pkey}
    ${products}=    Get Json Value and Convert to List    ${response}    /data
    Return From Keyword     ${products}

Get Remaining Stock By Inventory ID
    [Arguments]    ${inventory_id}
    Create Http Context    ${PCMS_API_URL}    http
    HttpLibrary.HTTP.GET    /api/45311375168544/inventories/${inventory_id}/remaining
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Price By Inventory ID
    [Arguments]    ${inventory_id}
    Create Http Context    ${PCMS_API_URL}    http
    HttpLibrary.HTTP.GET    /api/45311375168544/inventories/${inventory_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}
