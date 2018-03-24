*** Settings ***
Library      Selenium2Library
Library      Collections
Library      String

*** Keywords ***
Open Level D Main Product
    Go To          ${ITM_URL}/products/item-${var_freebie_main_level_d_pkey}.html

Open Level D Main2 Product
    Go To          ${ITM_URL}/products/item-${var_freebie_main2_level_d_pkey}.html

Open Level D Free Product
    Go To          ${ITM_URL}/products/item-${var_freebie_free_level_d_pkey}.html

Open Level D Main Product No Cache
    Go To          ${ITM_URL}/products/item-${var_freebie_main_level_d_pkey}.html
    Sleep        3
    ${current_url}=                 Log Location
    Go To          ${current_url}?no-cache=1

Open Level D Main2 Product No Cache
    Go To          ${ITM_URL}/products/item-${var_freebie_main2_level_d_pkey}.html
    Sleep        3
    ${current_url}=                 Log Location
    Go To          ${current_url}?no-cache=1

Open Level D Main3 Product No Cache
    Go To          ${ITM_URL}/products/item-${var_freebie_main3_level_d_pkey}.html
    Sleep        3
    ${current_url}=                 Log Location
    Go To          ${current_url}?no-cache=1

Open Level D Free Product No Cache
    Go To          ${ITM_URL}/products/item-${var_freebie_free_level_d_pkey}.html
    Sleep        3
    ${current_url}=                 Log Location
    Go To          ${current_url}?no-cache=1

Open Level D Normal Product
    Go To          ${ITM_URL}/products/item-${var_freebie_normal_level_d_pkey}.html

Open Level D Normal2 Product
    Go To          ${ITM_URL}/products/item-${var_freebie_normal2_level_d_pkey}.html

Check Current Stock Level D Main Product
    ${stock}=    Check Stock By Sku    ${var_freebie_main_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining/${var_freebie_main_level_d_inventory}
    ${hold}=    Get Json Value    ${stock}    /hold/${var_freebie_main_level_d_inventory}
    Set Test Variable    ${var_freebie_main_product_remaining_old}    ${remaining}
    Set Test Variable    ${var_freebie_main_product_hold_old}    ${hold}
    Log to console    main:${var_freebie_main_product_remaining_old}

Check Current Stock Level D Main2 Product
    ${stock}=    Check Stock By Sku    ${var_freebie_main2_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining/${var_freebie_main2_level_d_inventory}
    ${hold}=    Get Json Value    ${stock}    /hold/${var_freebie_main2_level_d_inventory}
    Set Test Variable    ${var_freebie_main2_product_remaining_old}    ${remaining}
    Set Test Variable    ${var_freebie_main2_product_hold_old}    ${hold}

Check Current Stock Level D Main3 Product
    ${stock}=    Check Stock By Sku    ${var_freebie_main3_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining/${var_freebie_main3_level_d_inventory}
    ${hold}=    Get Json Value    ${stock}    /hold/${var_freebie_main3_level_d_inventory}
    Set Test Variable    ${var_freebie_main3_product_remaining_old}    ${remaining}
    Set Test Variable    ${var_freebie_main3_product_hold_old}    ${hold}

Check Current Stock Level D Free Product
    ${stock}=    Check Stock By Sku    ${var_freebie_free_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining/${var_freebie_free_level_d_inventory}
    ${hold}=    Get Json Value    ${stock}    /hold/${var_freebie_free_level_d_inventory}
    Set Test Variable    ${var_freebie_free_product_remaining_old}    ${remaining}
    Set Test Variable    ${var_freebie_free_product_hold_old}    ${hold}
    Log to console    free:${var_freebie_free_product_remaining_old}

Check Current Stock Level D Normal Product
    ${stock}=    Check Stock By Sku    ${var_freebie_normal_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining/${var_freebie_normal_level_d_inventory}
    ${hold}=    Get Json Value    ${stock}    /hold/${var_freebie_normal_level_d_inventory}
    Set Test Variable    ${var_freebie_normal_product_remaining_old}    ${remaining}
    Set Test Variable    ${var_freebie_normal_product_hold_old}    ${hold}
    # Log to console    normal:${var_freebie_normal_product_remaining_old}

Check Current Stock Level D Normal2 Product
    ${stock}=    Check Stock By Sku    ${var_freebie_normal2_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining/${var_freebie_normal2_level_d_inventory}
    ${hold}=    Get Json Value    ${stock}    /hold/${var_freebie_normal2_level_d_inventory}
    Set Test Variable    ${var_freebie_normal2_product_remaining_old}    ${remaining}
    Set Test Variable    ${var_freebie_normal2_product_hold_old}    ${hold}
    # Log to console    normal2:${var_freebie_normal2_product_remaining_old}

Set Remaining Level D Main Product
    [Arguments]    ${main_stock}=0
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${main_stock}

Set Remaining Level D Main2 Product
    [Arguments]    ${main_stock}=0
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main2_level_d_inventory}    ${main_stock}

Set Remaining Level D Main3 Product
    [Arguments]    ${main_stock}=0
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main3_level_d_inventory}    ${main_stock}

Set Remaining Level D Free Product
    [Arguments]    ${free_stock}=0
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${free_stock}

Set Remaining Level D Normal Product
    [Arguments]    ${normal_stock}=0
    Adjust Stock Remaining By Inventory ID    ${var_freebie_normal_level_d_inventory}    ${normal_stock}

Set Remaining Level D Normal2 Product
    [Arguments]    ${normal_stock}=0
    Adjust Stock Remaining By Inventory ID    ${var_freebie_normal2_level_d_inventory}    ${normal_stock}

Rebuild Stock More Than 1Variant
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK}?product_pkey=${var_freebie_main_level_d_pkey}&option_pkey[0]=${var_freebie_main_level_d_style1}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Rebuild Stock No Variant
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK-NO-VARIANT}?product_pkey=${var_freebie_main_level_d_pkey}&data_inv_id=${var_freebie_main_level_d_inventory}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Rebuild Stock No Variant Main2
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK-NO-VARIANT}?product_pkey=${var_freebie_main2_level_d_pkey}&data_inv_id=${var_freebie_main2_level_d_inventory}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Rebuild Stock More Than 1Variant Normal
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK}?product_pkey=${var_freebie_normal_level_d_pkey}&option_pkey[0]=${var_freebie_normal_level_d_style1}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Rebuild Stock More Than 1Variant Normal2
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK}?product_pkey=${var_freebie_normal2_level_d_pkey}&option_pkey[0]=${var_freebie_normal2_level_d_style1}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Choose Style Option Main Level D Main Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}             30s
    ${main_style}=              Convert To String               ${var_freebie_main_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^     ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Choose Style Option Main Level D Main2 Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}
    ${main_style}=              Convert To String               ${var_freebie_main2_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^   ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Choose Style Option Main Level D Main3 Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}
    ${main_style}=              Convert To String               ${var_freebie_main3_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^   ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Choose Style Option Normal Level D Main Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}
    ${main_style}=              Convert To String               ${var_freebie_normal_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^   ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Choose Style Option Normal2 Level D Main Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}
    ${main_style}=              Convert To String               ${var_freebie_normal2_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^   ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Button Add To Cart Enable
    Wait Until Element Is Not Visible          ${LvD_LoadingStock}                 15s
    Element Should Be Visible                  ${XPATH_LEVEL_D.btn_add_to_cart_enable}

Button Add To Cart Disabled
    Wait Until Element Is Not Visible          ${LvD_LoadingStock}                 15s
    Element Should Be Visible                  ${XPATH_LEVEL_D.btn_add_to_cart_disable}

Set Freebie On Camp Level D
    [Arguments]    ${quantity_main}=None    ${quantity_free}=None
    ${start_timestamp}=    Convert Date To Time Stamp    -30
    ${end_timestamp}=    Convert Date To Time Stamp    60
    ${path_json}=    Convert To String    ${CURDIR}/../../../Resource/json/Freebie/camp_json_1main_1free.json
    #    ${path_json}=    Convert To String    ${EXECDIR}/../../../Resource/json/Freebie/camp_json_1main_1free.json
    ${response_camp}=    Create Promotion Freebie On Camp    ${var_freebie_main_level_d_inventory}    ${quantity_main}    ${var_freebie_free_level_d_inventory}    ${quantity_free}    None
    ...    None    None    None    None    None    None
    ...    ${path_json}    ${FREEBIE-CAMPAIGN-ID}    ${start_timestamp}    ${end_timestamp}
    ${prodmotion_id}=    Get Json Value    ${response_camp}    /data/id
    Log to console    ${prodmotion_id}
    Set Test Variable    ${var_freebie_promotion_id}    ${prodmotion_id}

Set Freebie On Camp Level D Two Main Product
    [Arguments]    ${quantity_main}=None    ${quantity_free}=None
    ${start_timestamp}=    Convert Date To Time Stamp    -30
    ${end_timestamp}=    Convert Date To Time Stamp    60
    ${path_json}=    Convert To String    ${CURDIR}/../../../Resource/json/Freebie/camp_json_2main_1free.json
    #    ${path_json}=    Convert To String    ${EXECDIR}/../../../Resource/json/Freebie/camp_json_2main_1free.json
    ${response_camp}=    Create Promotion Freebie On Camp    ${var_freebie_main_level_d_inventory}    ${quantity_main}    ${var_freebie_free_level_d_inventory}    ${quantity_free}    ${var_freebie_main2_level_d_inventory}
    ...    None    None    None    None    None    None
    ...    ${path_json}    ${FREEBIE-CAMPAIGN-ID}    ${start_timestamp}    ${end_timestamp}
    ${prodmotion_id}=    Get Json Value    ${response_camp}    /data/id
    Log to console    ${prodmotion_id}
    Set Test Variable    ${var_freebie_promotion_id}    ${prodmotion_id}

Restore Remaining Main Product Level D
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}

Restore Remaining Main2 Product Level D
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main2_level_d_inventory}    ${var_freebie_main2_product_remaining_old}

Restore Remaining Main3 Product Level D
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main2_level_d_inventory}    ${var_freebie_main2_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main3_level_d_inventory}    ${var_freebie_main3_product_remaining_old}

Restore Remaining And Promotion Level D
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${var_freebie_free_product_remaining_old}
    Delete Promotion Freebie On Camp    ${var_freebie_promotion_id}

Restore Remaining And Promotion Level D Main2
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main2_level_d_inventory}    ${var_freebie_main2_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${var_freebie_free_product_remaining_old}
    Delete Promotion Freebie On Camp    ${var_freebie_promotion_id}

Create Campagin Freebie On Camp Level D
    [Arguments]    ${start_period}=0    ${end_period}=30    ${enable}=None    ${campaign_name}=None
    ${start_timestamp}=    Convert Date To Time Stamp    ${start_period}
    ${end_timestamp}=    Convert Date To Time Stamp    ${end_period}
    ${path_json}=    Convert To String    ${CURDIR}/../../../Resource/json/Freebie/create_campaign_freebie.json
    ${response_camp}=    Create Campaign Freebie On Camp    ${start_timestamp}    ${end_timestamp}    ${enable}    ${campaign_name}    ${path_json}
    ${campaign_id}=    Get Json Value    ${response_camp}    /data/id
    ${campaign_name}=    Get Json Value    ${response_camp}    /data/name
    Set Test Variable    ${var_freebie_campaign_id}    ${campaign_id}
    Set Test Variable    ${var_freebie_campaign_name}    ${campaign_name}
    Log to console    campaign_id:${var_freebie_campaign_id}

Set Freebie On Camp Level D By Campaign Id
    [Arguments]    ${quantity_main}=None    ${quantity_free}=None    ${start_period}=0    ${end_period}=30    ${enable}=true    ${note}=Freebie-Note
    ${start_timestamp}=    Convert Date To Time Stamp    ${start_period}
    ${end_timestamp}=    Convert Date To Time Stamp    ${end_period}
    ${path_json}=    Convert To String    ${CURDIR}/../../../Resource/json/Freebie/camp_json_1main_1free.json
    ${response_camp}=    Create Promotion Freebie On Camp    ${var_freebie_main_level_d_inventory}    ${quantity_main}    ${var_freebie_free_level_d_inventory}    ${quantity_free}    None
    ...    None    None    None    None    None    ${note}
    ...    ${path_json}    ${var_freebie_campaign_id}    ${start_timestamp}    ${end_timestamp}    ${enable}
    ${prodmotion_id}=    Get Json Value    ${response_camp}    /data/id
    Log to console    prodmotion_id:${prodmotion_id}
    Set Test Variable    ${var_freebie_promotion_id}    ${prodmotion_id}

Set Freebie On Camp Level D Two Main Product By Campaign Id
    [Arguments]    ${quantity_main}=None    ${quantity_free}=None    ${start_period}=0    ${end_period}=30    ${enable}=true    ${note}=Freebie-Note
    ${start_timestamp}=    Convert Date To Time Stamp    ${start_period}
    ${end_timestamp}=    Convert Date To Time Stamp    ${end_period}
    ${path_json}=    Convert To String    ${CURDIR}/../../../Resource/json/Freebie/camp_json_2main_1free.json
    ${response_camp}=    Create Promotion Freebie On Camp    ${var_freebie_main_level_d_inventory}    ${quantity_main}    ${var_freebie_free_level_d_inventory}    ${quantity_free}    ${var_freebie_main2_level_d_inventory}
    ...    None    None    None    None    None    ${note}
    ...    ${path_json}    ${var_freebie_campaign_id}    ${start_timestamp}    ${end_timestamp}    ${enable}
    ${prodmotion_id}=    Get Json Value    ${response_camp}    /data/id
    Log to console    prodmotion_id:${prodmotion_id}
    Set Test Variable    ${var_freebie_promotion_id}    ${prodmotion_id}

Set Freebie On Camp Level D Main2 By Campaign Id
    [Arguments]    ${quantity_main}=None    ${quantity_free}=None    ${start_period}=0    ${end_period}=30    ${enable}=true    ${note}=Freebie-Note
    ${start_timestamp}=    Convert Date To Time Stamp    ${start_period}
    ${end_timestamp}=    Convert Date To Time Stamp    ${end_period}
    ${path_json}=    Convert To String    ${CURDIR}/../../../Resource/json/Freebie/camp_json_1main_1free.json
    ${response_camp}=    Create Promotion Freebie On Camp    ${var_freebie_main2_level_d_inventory}    ${quantity_main}    ${var_freebie_free_level_d_inventory}    ${quantity_free}    None
    ...    None    None    None    None    None    ${note}
    ...    ${path_json}    ${var_freebie_campaign_id}    ${start_timestamp}    ${end_timestamp}    ${enable}
    ${prodmotion_id}=    Get Json Value    ${response_camp}    /data/id
    Log to console    prodmotion_id:${prodmotion_id}
    Set Test Variable    ${var_freebie_main2_promotion_id}    ${prodmotion_id}

Set Freebie On Camp Level D Main3 By Campaign Id
    [Arguments]    ${quantity_main}=None    ${quantity_free}=None    ${start_period}=0    ${end_period}=30    ${enable}=true    ${note}=Freebie-Note
    ${start_timestamp}=    Convert Date To Time Stamp    ${start_period}
    ${end_timestamp}=    Convert Date To Time Stamp    ${end_period}
    ${path_json}=    Convert To String    ${CURDIR}/../../../Resource/json/Freebie/camp_json_1main_1free.json
    ${response_camp}=    Create Promotion Freebie On Camp    ${var_freebie_main3_level_d_inventory}    ${quantity_main}    ${var_freebie_free_level_d_inventory}    ${quantity_free}    None
    ...    None    None    None    None    None    ${note}
    ...    ${path_json}    ${var_freebie_campaign_id}    ${start_timestamp}    ${end_timestamp}    ${enable}
    ${prodmotion_id}=    Get Json Value    ${response_camp}    /data/id
    Log to console    prodmotion_id:${prodmotion_id}
    Set Test Variable    ${var_freebie_main3_promotion_id}    ${prodmotion_id}

Restore Remaining And Promotion And Campaign Level D
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${var_freebie_free_product_remaining_old}
    Delete Promotion Freebie On Camp    ${var_freebie_promotion_id}
    Delete Campaign    ${var_freebie_campaign_id}

Restore Remaining And Promotion And Campaign Level D Main2
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main2_level_d_inventory}    ${var_freebie_main2_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${var_freebie_free_product_remaining_old}
    Delete Promotion Freebie On Camp    ${var_freebie_promotion_id}
    Delete Campaign    ${var_freebie_campaign_id}

Restore Remaining And Promotion And Campaign Level D 2Main
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main2_level_d_inventory}    ${var_freebie_main2_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${var_freebie_free_product_remaining_old}
    Delete Promotion Freebie On Camp    ${var_freebie_promotion_id}
    Delete Campaign    ${var_freebie_campaign_id}

Restore Remaining And Promotion And Campaign Level D 3Main
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main2_level_d_inventory}    ${var_freebie_main2_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main3_level_d_inventory}    ${var_freebie_main2_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${var_freebie_free_product_remaining_old}
    Delete Promotion Freebie On Camp    ${var_freebie_promotion_id}
    Delete Campaign    ${var_freebie_campaign_id}

Restore Remaining 1Main 1Free 2Normal And Promotion And Campaign Level D
    Adjust Stock Remaining By Inventory ID    ${var_freebie_main_level_d_inventory}    ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_free_level_d_inventory}    ${var_freebie_free_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_normal_level_d_inventory}    ${var_freebie_normal_product_remaining_old}
    Adjust Stock Remaining By Inventory ID    ${var_freebie_normal2_level_d_inventory}    ${var_freebie_normal2_product_remaining_old}
    Delete Promotion Freebie On Camp    ${var_freebie_promotion_id}

Freebie Promotion Note TH Display
    Wait Until Element Is Visible       ${XPATH_LEVEL_D.lbl_freebie_note_th}   30s
    Element Should Be Visible           ${XPATH_LEVEL_D.lbl_freebie_note_th}

Freebie Promotion Note EN Display
    Wait Until Element Is Visible       ${XPATH_LEVEL_D.lbl_freebie_note_en}   30s
    Element Should Be Visible           ${XPATH_LEVEL_D.lbl_freebie_note_en}

Freebie Promotion Note TH Not Display
    Wait Until Element Is Not Visible       ${XPATH_LEVEL_D.lbl_freebie_note_th}   30s
    Element Should Not Be Visible           ${XPATH_LEVEL_D.lbl_freebie_note_th}

Freebie Promotion Note EN Not Display
    Wait Until Element Is Not Visible       ${XPATH_LEVEL_D.lbl_freebie_note_en}   30s
    Element Should Not Be Visible           ${XPATH_LEVEL_D.lbl_freebie_note_en}

Freebie Promotion Note TH Display Main
    ${element}=    Replace String   ${XPATH_LEVEL_D.lbl_freebie_id_note_th}   ^^promotion_id^^   ${var_freebie_promotion_id}
    Wait Until Element Is Visible       ${element}         30s
    Element Should Be Visible           ${element}

Freebie Promotion Note EN Display Main
    ${element}=    Replace String   ${XPATH_LEVEL_D.lbl_freebie_id_note_en}   ^^promotion_id^^   ${var_freebie_promotion_id}
    Wait Until Element Is Visible       ${element}         30s
    Element Should Be Visible           ${element}

Freebie Promotion Note TH Display Main2
    ${element}=    Replace String   ${XPATH_LEVEL_D.lbl_freebie_id_note_th}   ^^promotion_id^^   ${var_freebie_main2_promotion_id}
    Wait Until Element Is Visible       ${element}         30s
    Element Should Be Visible           ${element}

Freebie Promotion Note EN Display Main2
    ${element}=    Replace String   ${XPATH_LEVEL_D.lbl_freebie_id_note_en}   ^^promotion_id^^   ${var_freebie_main2_promotion_id}
    Wait Until Element Is Visible       ${element}         30s
    Element Should Be Visible           ${element}

Freebie Promotion Note TH Display Main3
    ${element}=    Replace String   ${XPATH_LEVEL_D.lbl_freebie_id_note_th}   ^^promotion_id^^   ${var_freebie_main3_promotion_id}
    Wait Until Element Is Visible       ${element}         30s
    Element Should Be Visible           ${element}

Freebie Promotion Note EN Display Main3
    ${element}=    Replace String   ${XPATH_LEVEL_D.lbl_freebie_id_note_en}   ^^promotion_id^^   ${var_freebie_main3_promotion_id}
    Wait Until Element Is Visible       ${element}         30s
    Element Should Be Visible           ${element}

Freebie Image Web TH Display
    Wait Until Element Is Visible       ${XPATH_LEVEL_D.img_freebie_th}   30s
    Element Should Be Visible           ${XPATH_LEVEL_D.img_freebie_th}

Freebie Image Web EN Display
    Wait Until Element Is Visible       ${XPATH_LEVEL_D.img_freebie_en}   30s
    Element Should Be Visible           ${XPATH_LEVEL_D.img_freebie_en}

Freebie Image Web TH Not Display
    Wait Until Element Is Not Visible       ${XPATH_LEVEL_D.img_freebie_th}   30s
    Element Should Not Be Visible           ${XPATH_LEVEL_D.img_freebie_th}

Freebie Image Web EN Not Display
    Wait Until Element Is Not Visible       ${XPATH_LEVEL_D.img_freebie_en}   30s
    Element Should Not Be Visible           ${XPATH_LEVEL_D.img_freebie_en}

Freebie Image Web TH Display Main
    ${element}=    Replace String   ${XPATH_LEVEL_D.img_freebie_id_th}   ^^promotion_id^^   ${var_freebie_promotion_id}
    Wait Until Element Is Visible       ${element}   30s
    Element Should Be Visible           ${element}

Freebie Image Web EN Display Main
    ${element}=    Replace String   ${XPATH_LEVEL_D.img_freebie_id_en}   ^^promotion_id^^   ${var_freebie_promotion_id}
    Wait Until Element Is Visible       ${element}   30s
    Element Should Be Visible           ${element}

Freebie Image Web TH Display Main2
    ${element}=    Replace String   ${XPATH_LEVEL_D.img_freebie_id_th}   ^^promotion_id^^   ${var_freebie_main2_promotion_id}
    Wait Until Element Is Visible       ${element}   30s
    Element Should Be Visible           ${element}

Freebie Image Web EN Display Main2
    ${element}=    Replace String   ${XPATH_LEVEL_D.img_freebie_id_en}   ^^promotion_id^^   ${var_freebie_main2_promotion_id}
    Wait Until Element Is Visible       ${element}   30s
    Element Should Be Visible           ${element}

Freebie Image Web TH Display Main3
    ${element}=    Replace String   ${XPATH_LEVEL_D.img_freebie_id_th}   ^^promotion_id^^   ${var_freebie_main3_promotion_id}
    Wait Until Element Is Visible       ${element}   30s
    Element Should Be Visible           ${element}

Freebie Image Web EN Display Main3
    ${element}=    Replace String   ${XPATH_LEVEL_D.img_freebie_id_en}   ^^promotion_id^^   ${var_freebie_main3_promotion_id}
    Wait Until Element Is Visible       ${element}   30s
    Element Should Be Visible           ${element}

Check Remaining Main Product
    [Arguments]    ${expect_qty}
    ${stock}=    Check Stock By Sku    ${var_freebie_main_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining
    Should Be Equal As Integers    ${remaining}    ${expect_qty}

Check Remaining Free Product
    [Arguments]    ${expect_qty}
    ${stock}=    Check Stock By Sku    ${var_freebie_free_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining
    Should Be Equal As Integers    ${remaining}    ${expect_qty}

Check Remaining Normal Product
    [Arguments]    ${expect_qty}
    ${stock}=    Check Stock By Sku    ${var_freebie_normal_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining
    Should Be Equal As Integers    ${remaining}    ${expect_qty}

Check Remaining Normal2 Product
    [Arguments]    ${expect_qty}
    ${stock}=    Check Stock By Sku    ${var_freebie_normal_level_d_inventory}
    ${remaining}=    Get Json Value    ${stock}    /remaining
    Should Be Equal As Integers    ${remaining}    ${expect_qty}
