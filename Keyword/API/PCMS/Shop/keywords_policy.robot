*** Settings ***
Resource    ${CURDIR}/../../../../Keyword/API/PCMS/Shop/keywords_shop.robot

Library    ${CURDIR}/../../../../Python_Library/policy_library.py
Library    ${CURDIR}/../../../../Python_Library/shop_library.py
Library    ${CURDIR}/../../../../Python_Library/order_history_library.py

Library    HttpLibrary.HTTP


*** Keyword ***
Get Merchant Policy
    [Arguments]     ${args_min}=3
    ...             ${args_max}=4
    ...             ${shop_code}=WEMALLGLOBAL

    ${policy_global}=    get_policy_global    ${shop_code}
    ${items}=    Get Length    ${policy_global}
    ${dict}=   Create Dictionary   start=1

    :FOR  ${index}  IN RANGE  0  ${items}
    \  ${row}=      Get From List   ${policy_global}   ${index}
    \  ${min}=      Get From List   ${row}   ${args_min}
    \  ${max}=      Get From List   ${row}   ${args_max}
    \  ${lang}=     Get From List   ${row}   5
    \  ${slug}=     Get From List   ${row}   6
    \  ${detail}=   Get From List   ${row}   7
    \  Set To Dictionary   ${dict}   ${slug}_${lang}=${detail}
    Set TO Dictionary   ${dict}   min=${min}
    Set TO Dictionary   ${dict}   max=${max}

    [Return]    ${dict}

Back Up Merchant Policy
    [Arguments]    ${merchant_id}
    ${backup_data}=    py_get_merchant_policy_by_merchant_id    ${merchant_id}
    [Return]    ${backup_data}

Delete Merchant Policy By Merchant ID
    [Arguments]    ${merchant_id}
    py_delete_merchant_policy_by_merchant_id    ${merchant_id}

Insert Merchant Policy
    [Arguments]    ${backup_policy}
    py_insert_policy    ${backup_policy}

Update Delivery By Merchant id
    [Arguments]    ${merchant_id}    ${delivery_min}    ${delivery_max}
    ${return}=   update_delivery_by_merchant    ${merchant_id}    ${delivery_min}    ${delivery_max}
    [return]   ${return}

Prepare Product Delivery Day
    [Arguments]    ${delivery_min}    ${delivery_max}
    Get shop id by inventory id
    Backup shop delivery day
    Change shop delivery day    ${delivery_min}    ${delivery_max}

Expect Delivery Day
    Should Be Equal    ${expect.delivery_min_day}    ${actual.delivery_min_day}
    Should Be Equal    ${expect.delivery_max_day}    ${actual.delivery_max_day}
    Log to console     expectmin=${expect.delivery_min_day}=> actualmin=${actual.delivery_min_day}
    Log to console     expectmax=${expect.delivery_max_day}=> actualmax=${actual.delivery_max_day}

Expect Delivery Text
    Should Be Equal    ${expect.delivery_text}       ${actual.delivery_text}
    Log to console     expecttext=${expect.delivery_text}=> actualtext=${actual.delivery_text}

Backup Shop Delivery Day
    ${backed_up_data}=    py_backup_delivery_day    shops    ${var.shop_id}
    Set test variable    ${var.backed_up_data}    ${backed_up_data}
    Log To Console    var.backed_up_data=${var.backed_up_data}

Change Shop Delivery Day
    [Arguments]    ${min_day}
    ...            ${max_day}
    Log To Console    ==== keyword_policy.Change Shop Delivery Day : delivery min_day==== ${min_day}
    Log To Console    ==== keyword_policy.Change Shop Delivery Day : delivery max_day==== ${max_day}
    ${return_update_delivery_day}=    py_update_delivery_day    shops    ${var.shop_id}    ${min_day}    ${max_day}
    # ${return_update_delivery_day}=    py_update_delivery_day    shops    10000735    ${min_day}    ${max_day}
    # Log To Console    ${var.shop_id} / ${min_day} / ${max_day}
    # Log To Console    return_update_delivery_day = ${return_update_delivery_day}

Restore Shop Delivery Day
    ${backup_min_day}=    Get from dictionary    ${var.backed_up_data}    delivery_min_day
    ${backup_max_day}=    Get from dictionary    ${var.backed_up_data}    delivery_max_day
    py_update_delivery_day    shops    ${var.shop_id}    ${backup_min_day}    ${backup_max_day}

Delete Prepared Order
    delete_order    ${var.order_id}
    Log To Console   keyword_policy::delete_order=${var.order_id}
    delete_order_shipment    ${var.order_id}
    delete_order_shipment_item    ${var.order_id}

Prepare Data for Insert Refund Policy
    [Arguments]    ${merchant_id}

    &{policy_maps}=    Create Dictionary    product_key=${product_id}    category_ids=${category_id}    flashsale_variants=${variant_list}

Prepare Data for Insert Delivery Policy
    [Arguments]    ${merchant_id}

    &{policy_maps}=    Create Dictionary    product_key=${product_id}    category_ids=${category_id}    flashsale_variants=${variant_list}

Test Case Merchant Delivery
    [Arguments]   ${delivery_min}
    ...           ${delivery_max}
    ...           ${expected_delivery_min}
    ...           ${expected_delivery_max}

    Given Merchant Data For Test

    When Merchant Delivery Min Is  ${delivery_min}
    And Merchant Delivery Max Is   ${delivery_max}
    And Api Return Data  ${merchant_id}

    Then Api Return Expected Merchant
    And Api Return Expected Delivery Min Is  ${expected_delivery_min}
    And Api Return Expected Delivery Max Is  ${expected_delivery_max}
    And Api Return Expected Policy

    [Teardown]  Rollback Merchant Policy Data

Prepare Global Merchant Data
    ${g}=    py_get_merchant_id_by_shop_code  WEMALLGLOBAL
    #Log TO Console  global_merchant_id=${global_merchant_id}
    Set Test Variable  ${global_merchant_id}   ${g}

Rollback Merchant Policy Data
    Delete Merchant Policy By Merchant ID  ${merchant_id}
    Insert Merchant Policy  ${backup_policy}

Merchant Data For Test
    Prepare Data From DB
    Backup Merchant  ${merchant_id}

    Prepare Merchant Policy  ${merchant_id}

Merchant Data TH Only For Test
    Prepare Data From DB
    Backup Merchant  ${merchant_id}
    Prepare Merchant Policy DB TH Only    ${merchant_id}

Merchant Delivery Min Is
    [Arguments]         ${delivery_min}
    Log to console   test-min=${delivery_min}
    Py Update Delivery  shops  ${merchant_id}  delivery_min_day  ${delivery_min}
    Set Test Variable   ${delivery_min}

Merchant Delivery Max Is
    [Arguments]         ${delivery_max}
    Py Update Delivery  shops  ${merchant_id}  delivery_max_day  ${delivery_max}
    Set Test Variable   ${delivery_max}

Api Return Data
    [Arguments]     ${_merchant_id}

    Get Merchant Policy From DB  ${_merchant_id}
    Get Merchant Policy From API.Product

Api Return Expected Merchant
    Expected String Equal      ${merchant_code}   ${actual_merchant_code}

Api Return Expected Delivery Min Is
    [Arguments]                ${expected_delivery_min}
    Expected String Equal      ${expected_delivery_min}   ${actual_map["delivery_time_min"]}

Api Return Expected Delivery Max Is
    [Arguments]                ${expected_delivery_max}
    Expected String Equal      ${expected_delivery_max}   ${actual_map["delivery_time_max"]}

Api Return Expected Policy
    Expected String Equal      ${expected_translate["delivery.title-th_TH"]}    ${actual_translate["delivery.title-th_TH"]}
    Expected String Equal      ${expected_translate["delivery.detail-th_TH"]}   ${actual_translate["delivery.detail-th_TH"]}
    Expected String Equal      ${expected_translate["return.title-th_TH"]}      ${actual_translate["return.title-th_TH"]}
    Expected String Equal      ${expected_translate["return.detail-th_TH"]}     ${actual_translate["return.detail-th_TH"]}
    Expected String Equal      ${expected_translate["refund.title-th_TH"]}      ${actual_translate["refund.title-th_TH"]}
    Expected String Equal      ${expected_translate["refund.detail-th_TH"]}     ${actual_translate["refund.detail-th_TH"]}

Api Return Expected Policy TH Same EN
    Expected String Equal      ${actual_translate["delivery.title-en_US"]}    ${actual_translate["delivery.title-th_TH"]}
    Expected String Equal      ${actual_translate["delivery.detail-en_US"]}   ${actual_translate["delivery.detail-th_TH"]}
    Expected String Equal      ${actual_translate["return.title-en_US"]}      ${actual_translate["return.title-th_TH"]}
    Expected String Equal      ${actual_translate["return.detail-en_US"]}     ${actual_translate["return.detail-th_TH"]}
    Expected String Equal      ${actual_translate["refund.title-en_US"]}      ${actual_translate["refund.title-th_TH"]}
    Expected String Equal      ${actual_translate["refund.detail-en_US"]}     ${actual_translate["refund.detail-th_TH"]}


Prepare Data From DB
    ${product_pkey}=    Get Normal Product Pkey

    ${merchant_data}=   Get Merchant Data By Product Pkey  ${product_pkey}
    #Log To Console   merchant_data=${merchant_data}
    ${merchant_id}=     Get From Dictionary  ${merchant_data}  merchant_id
    ${merchant_code}=   Get From Dictionary  ${merchant_data}  merchant_code

    Set Test Variable   ${product_pkey}
    Set Test Variable   ${merchant_id}
    Set Test Variable   ${merchant_code}

Prepare Merchant Policy
    [Arguments]         ${merchant_id}
    ${policy_map_id}=   py_insert_merchant_policy_data  ${merchant_id}
    Set Test Variable   ${policy_map_id}

Prepare Merchant Policy DB TH Only
    [Arguments]     ${merchant_id}    ${delivery_min}=2    ${delivery_max}=10

    ${policy_map_id}=  insert_merchant_policy_data_th_only     ${merchant_id}    ${delivery_min}    ${delivery_max}

    Set Test Variable   ${policy_map_id}


Get Merchant Policy From DB
    [Arguments]     ${_merchant_id}

    ${expected_map}     Py Get Policy Map  ${_merchant_id}
    Log to console  expected_map=${expected_map}

    Set To Dictionary   ${expected_map}  delivery_time_min  ${expected_map["delivery_min_day"]}
    Set To Dictionary   ${expected_map}  delivery_time_max  ${expected_map["delivery_max_day"]}

    ${expected_translate}   Py Get Policy Translate  ${expected_map["id"]}

    Set Test Variable   ${expected_map}
    Set Test Variable   ${expected_translate}

Get Merchant Policy From API.Product
    ${product_detail}=      Call API Get Product Detail    ${product_pkey}

    Log to console  product_detail=${product_detail}


    ${delivery_time_min}=   Get Json Value  ${product_detail}  /data/delivery_time_min
    ${delivery_time_max}=   Get Json Value  ${product_detail}  /data/delivery_time_max

    Log to console   delivery_time_min=${delivery_time_min}
    Log to console   delivery_time_max=${delivery_time_max}


    ${actual_map}=        Create Dictionary
    Set To Dictionary     ${actual_map}  delivery_time_min  ${delivery_time_min}
    Set To Dictionary     ${actual_map}  delivery_time_max  ${delivery_time_max}

    ${actual_merchant_code}=    GetStringFromJson    ${product_detail}    /data/merchant_code

    ${policy_0_type}=     GetStringFromJson    ${product_detail}    /data/policies/0/type_name
    ${policy_0_title}=    GetStringFromJson    ${product_detail}    /data/policies/0/title
    ${policy_0_detail}=   GetStringFromJson    ${product_detail}    /data/policies/0/description
    ${policy_1_type}=     GetStringFromJson    ${product_detail}    /data/policies/1/type_name
    ${policy_1_title}=    GetStringFromJson    ${product_detail}    /data/policies/1/title
    ${policy_1_detail}=   GetStringFromJson    ${product_detail}    /data/policies/1/description
    ${policy_2_type}=     GetStringFromJson    ${product_detail}    /data/policies/2/type_name
    ${policy_2_title}=    GetStringFromJson    ${product_detail}    /data/policies/2/title
    ${policy_2_detail}=   GetStringFromJson    ${product_detail}    /data/policies/2/description

    ${policy_0_title_en}=    GetStringFromJson    ${product_detail}    /data/policies/0/translates/en_US/title
    ${policy_0_detail_en}=   GetStringFromJson    ${product_detail}    /data/policies/0/translates/en_US/description
    ${policy_1_title_en}=    GetStringFromJson    ${product_detail}    /data/policies/1/translates/en_US/title
    ${policy_1_detail_en}=   GetStringFromJson    ${product_detail}    /data/policies/1/translates/en_US/description
    ${policy_2_title_en}=    GetStringFromJson    ${product_detail}    /data/policies/2/translates/en_US/title
    ${policy_2_detail_en}=   GetStringFromJson    ${product_detail}    /data/policies/2/translates/en_US/description

    ${actual_translate}=  Create Dictionary
    Set To Dictionary     ${actual_translate}  ${policy_0_type}.title-th_TH   ${policy_0_title}
    Set To Dictionary     ${actual_translate}  ${policy_0_type}.detail-th_TH  ${policy_0_detail}
    Set To Dictionary     ${actual_translate}  ${policy_1_type}.title-th_TH   ${policy_1_title}
    Set To Dictionary     ${actual_translate}  ${policy_1_type}.detail-th_TH  ${policy_1_detail}
    Set To Dictionary     ${actual_translate}  ${policy_2_type}.title-th_TH   ${policy_2_title}
    Set To Dictionary     ${actual_translate}  ${policy_2_type}.detail-th_TH  ${policy_2_detail}

    Set To Dictionary     ${actual_translate}  ${policy_0_type}.title-en_US   ${policy_0_title_en}
    Set To Dictionary     ${actual_translate}  ${policy_0_type}.detail-en_US  ${policy_0_detail_en}
    Set To Dictionary     ${actual_translate}  ${policy_1_type}.title-en_US   ${policy_1_title_en}
    Set To Dictionary     ${actual_translate}  ${policy_1_type}.detail-en_US  ${policy_1_detail_en}
    Set To Dictionary     ${actual_translate}  ${policy_2_type}.title-en_US   ${policy_2_title_en}
    Set To Dictionary     ${actual_translate}  ${policy_2_type}.detail-en_US  ${policy_2_detail_en}

    Set Test Variable     ${actual_merchant_code}
    Set Test Variable     ${actual_translate}
    Set Test Variable     ${actual_map}

Backup Merchant
    [Arguments]     ${merchant_id}

    Log To console   merchant_id=${merchant_id}
    ${backup_policy}=   Back Up Merchant Policy  ${merchant_id}
    #Log To Console   backup_policy=${backup_policy}

    Delete Merchant Policy By Merchant ID  ${merchant_id}

    Set Test Variable   ${backup_policy}

Create 2 Shop Policies

    Prepare Merchant Policy DB TH Only    ${var.shop_id1}    2    7
    Prepare Merchant Policy DB TH Only    ${var.shop_id2}    3    5

Delete 2 Shop Policies

    Delete Merchant Policy By Merchant ID    ${var.shop_id1}
    Delete Merchant Policy By Merchant ID    ${var.shop_id2}

Expect Delivery Text Different Merchant And SKU
    # Set Create order date = 6 jun 2026
    ${actual_delivery1}=    Get Text    ${deliverydate1}
    ${actual_delivery2}=    Get Text    ${deliverydate2}

    # Date format in Thai
    ${expect_delivery1}=    Set Variable    09 มิ.ย. 69 - 16 มิ.ย. 69
    ${expect_delivery2}=    Set Variable    10 มิ.ย. 69 - 12 มิ.ย. 69

    Should Be Equal        ${actual_delivery1}     ${expect_delivery1}
    Should Be Equal        ${actual_delivery2}     ${expect_delivery2}
    Should Not Be Equal    ${expect_delivery1}     ${expect_delivery2}

    Log To Console   ====== Expect Delivery Text 1 ====== ${expect_delivery1}
    Log To Console   ====== Expect Delivery Text 2 ====== ${expect_delivery2}
    Log To Console   ====== Actual Delivery Text 1 ====== ${actual_delivery1}
    Log To Console   ====== Actual Delivery Text 2 ====== ${actual_delivery2}
