*** Settings ***
Library                 Selenium2Library
Library                 Collections
Library                 String
Library                 ${CURDIR}/../../../../Python_Library/truemoveh_library.py
Library                 ${CURDIR}/../../../../Python_Library/mnp_util.py
Library                 ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Get Normal Product For TruemoveH Device
    # ${start}=    Evaluate    random.randint(5, 30)    modules=random
    # ${data_product}=    py_get_product_level_d_has_style    ${start}
    #### Comment because Data in Database is missing then close random.randint for select first row of data
    ${data_product}=    py_get_product_level_d_has_style
    Log To Console    ${data_product}
    ${inventory_id}=    Get From Dictionary    ${data_product}    inventory_id
    ${pkey}=    Get From Dictionary    ${data_product}    product_pkey
    ${product_id}=    Get From Dictionary    ${data_product}    product_id
    ${variant_id}=    Get From Dictionary    ${data_product}    variant_id
    Set Test Variable    ${var_tmh_product_device_inventory_id}    ${inventory_id}
    Set Test Variable    ${var_tmh_product_device_pkey}    ${pkey}
    Set Test Variable    ${var_tmh_product_device_product_id}    ${product_id}
    Set Test Variable    ${var_tmh_product_device_variant_id}    ${variant_id}
    Log To Console    pkey=${pkey}
    Log to console    product_inv=${var_tmh_product_device_inventory_id}
    Log to console    product_pkey=${var_tmh_product_device_pkey}
    Log to console    product_id=${var_tmh_product_device_product_id}
    Log to console    product_vri=${var_tmh_product_device_variant_id}

Get Any Normal Product For TruemoveH Device
    ${data_product}=    py_get_any_product_level_d_has_style
    ${inventory_id}=    Get From Dictionary    ${data_product}    inventory_id
    ${pkey}=    Get From Dictionary    ${data_product}    product_pkey
    ${product_id}=    Get From Dictionary    ${data_product}    product_id
    ${variant_id}=    Get From Dictionary    ${data_product}    variant_id
    Set Test Variable    ${var_tmh_product_device_inventory_id}    ${inventory_id}
    Set Test Variable    ${var_tmh_product_device_pkey}    ${pkey}
    Set Test Variable    ${var_tmh_product_device_product_id}    ${product_id}
    Set Test Variable    ${var_tmh_product_device_variant_id}    ${variant_id}
    Log to console    product_inv=${var_tmh_product_device_inventory_id}
    Log to console    product_pkey=${var_tmh_product_device_pkey}
    Log to console    product_id=${var_tmh_product_device_product_id}
    Log to console    product_vri=${var_tmh_product_device_variant_id}

Add Product To TruemoveH Device
    ${pkey}=    Convert To String    ${var_tmh_product_device_pkey}
    ${product_id}=    Convert To Integer    ${var_tmh_product_device_product_id}
    ${data}=    py_insert_truemoveh_device    ${pkey}    ${product_id}
    ${device_id}=    Get From Dictionary    ${data}    device_id
    Set Test Variable    ${var_tmh_device_id}    ${device_id}
    Log to console    var_tmh_device_id=${var_tmh_device_id}a

Get TruemoveH Device Sub
    ${data_device}=    py_get_truemoveh_device_types
    ${device_type_id}=    Get From Dictionary    ${data_device}    id
    ${inventory_id}=    Get From Dictionary    ${data_device}    inventory_id
    Set Test Variable    ${var_tmh_device_sub_id}    ${device_type_id}
    Set Test Variable    ${var_tmh_device_sub_inventory_id}    ${inventory_id}
    Log to console    var_tmh_device_sub_id=${var_tmh_device_sub_id}
    Log to console    var_tmh_device_sub_inventory_id=${var_tmh_device_sub_inventory_id}

Get TruemoveH Parent Proposition For Bundle From Mobile
    ${start}=    Evaluate    random.randint(0, 20)    modules=random
    ${data_mobile}=    py_get_truemoveh_mobile    ${start}
    ${proposition_id}=    Get From Dictionary    ${data_mobile}    proposition_id
    ${mobile_type}=    Get From Dictionary    ${data_mobile}    mobile_type
    ${province_id}=    Get From Dictionary    ${data_mobile}    province_id
    Set Test Variable    ${var_tmh_parent_proposition_id}    ${proposition_id}
    Set Test Variable    ${var_tmh_mobile_type}    ${mobile_type}
    Set Test Variable    ${var_tmh_mobile_province_id}    ${province_id}
    Log to console    var_tmh_parent_proposition_id=${var_tmh_parent_proposition_id}
    Log to console    var_tmh_mobile_type=${var_tmh_mobile_type}
    Log to console    var_tmh_mobile_province_id=${var_tmh_mobile_province_id}

Get TruemoveH Parent Proposition For MNP Device From Mobile
    ${start}=    Evaluate    random.randint(0, 20)    modules=random
    ${data_mobile}=    py_get_truemoveh_mobile    ${start}
    ${proposition_id}=    Get From Dictionary    ${data_mobile}    proposition_id
    ${mobile_type}=    Get From Dictionary    ${data_mobile}    mobile_type
    ${province_id}=    Get From Dictionary    ${data_mobile}    province_id
    Set Test Variable    ${var_tmh_parent_proposition_id}    ${proposition_id}
    Set Test Variable    ${var_tmh_mobile_type}    ${mobile_type}
    Set Test Variable    ${var_tmh_mobile_province_id}    ${province_id}
    Log to console    var_tmh_parent_proposition_id=${var_tmh_parent_proposition_id}
    Log to console    var_tmh_mobile_type=${var_tmh_mobile_type}
    Log to console    var_tmh_mobile_province_id=${var_tmh_mobile_province_id}

Get TruemoveH Data For Search Available Mobile Number Sim
    ${start}=    Evaluate    random.randint(0, 20)    modules=random
    ${data_mobile}=    py_get_truemoveh_mobile_sim    ${start}
    ${mobile_type}=    Get From Dictionary    ${data_mobile}    mobile_type
    ${price_plan_id}=    Get From Dictionary    ${data_mobile}    price_plan_id
    ${province_id}=    Get From Dictionary    ${data_mobile}    province_id
    ${inventory_id_sim}=    py_get_truemoveh_inventory_id_sim
    Set Test Variable    ${var_tmh_sim_mobile_type}    ${mobile_type}
    Set Test Variable    ${var_tmh_sim_mobile_price_plan_id}    ${price_plan_id}
    Set Test Variable    ${var_tmh_sim_mobile_province_id}    ${province_id}
    Set Test Variable    ${var_tmh_sim_inventory_id}    ${inventory_id_sim}
    Log to console    var_tmh_sim_mobile_type=${var_tmh_sim_mobile_type}
    Log to console    var_tmh_sim_mobile_price_plan_id=${var_tmh_sim_mobile_price_plan_id}
    Log to console    var_tmh_sim_mobile_province_id=${var_tmh_sim_mobile_province_id}
    Log to console    var_tmh_sim_inventory_id=${var_tmh_sim_inventory_id}

Add TruemoveH Proposition For Sim
    ${result}=    py_insert_truemoveh_proposition    sim
    ${proposition_id}=    Get From Dictionary    ${result}    proposition_id
    Set Test Variable    ${var_tmh_proposition_id}    ${proposition_id}
    Log to console    var_tmh_proposition_id_for_sim=${var_tmh_proposition_id}

Add TruemoveH Proposition For Bundle
    ${parent_proposition_id}=    Convert To Integer    ${var_tmh_parent_proposition_id}
    ${result}=    py_insert_truemoveh_proposition    bundle    ${parent_proposition_id}
    ${proposition_id}=    Get From Dictionary    ${result}    proposition_id
    Set Test Variable    ${var_tmh_proposition_id}    ${proposition_id}
    Log to console    var_tmh_proposition_id_for_bundle=${var_tmh_proposition_id}

Add TruemoveH Proposition For MNP
    ${result}=    py_insert_truemoveh_proposition    mnp
    ${proposition_id}=    Get From Dictionary    ${result}    proposition_id
    Set Test Variable    ${var_tmh_proposition_id}    ${proposition_id}
    Log to console    var_tmh_proposition_id_for_mnp=${var_tmh_proposition_id}

Add TruemoveH Proposition For MNP Device
    ${result}=    py_insert_truemoveh_proposition    mnp_device
    ${proposition_id}=    Get From Dictionary    ${result}    proposition_id
    Set Test Variable    ${var_tmh_proposition_id}    ${proposition_id}
    Log to console    var_tmh_proposition_id_for_mnp_device=${var_tmh_proposition_id}

Add TruemoveH Price Plan For MNP Device
    ${price_plan_code}=    Set Variable    ROBOTMNPDEVICE99
    ${result}=    py_insert_truemoveh_price_plan    Y    N    ${price_plan_code}
    ${price_plan_id}=    Get From Dictionary    ${result}    price_plan_id
    Set Test Variable    ${var_tmh_price_plan_id}    ${price_plan_id}
    Set Test Variable    ${var_tmh_price_plan_code}    ${price_plan_code}
    Log to console    var_tmh_price_plan_id=${var_tmh_price_plan_id}
    Log to console    var_tmh_price_plan_code=${var_tmh_price_plan_code}

Add TruemoveH Price Plan
    [Arguments]    ${priceplan_status}=Y
    ${result}=    py_insert_truemoveh_price_plan    ${priceplan_status}
    ${price_plan_id}=    Get From Dictionary    ${result}    price_plan_id
    Set Test Variable    ${var_tmh_price_plan_id}    ${price_plan_id}
    Log to console    var_tmh_price_plan_id=${var_tmh_price_plan_id}

Add TruemoveH Price Plan With Parameters
    [Arguments]    ${status}    ${recommend}    ${pp_code}    ${sub_description}
    ${result}=    py_insert_truemoveh_price_plan    ${status}    ${recommend}    ${pp_code}    ${sub_description}
    ${price_plan_id}=    Get From Dictionary    ${result}    price_plan_id
    Set Test Variable    ${var_tmh_price_plan_id}    ${price_plan_id}
    Set Test Variable    ${var_tmh_price_plan_code}    ${pp_code}
    Log to console    var_tmh_price_plan_id=${var_tmh_price_plan_id}
    Log to console    var_tmh_price_plan_code=${var_tmh_price_plan_code}
    Log to console    price_plan_desc=${sub_description}
    [Return]    ${price_plan_id}

Add TruemoveH Proposition Groups
    ${result}=    py_insert_truemoveh_proposition_group
    ${proposition_group_id}=    Get From Dictionary    ${result}    proposition_group_id
    Set Test Variable    ${var_tmh_proposition_group_id}    ${proposition_group_id}
    Log to console    var_tmh_proposition_group_id=${var_tmh_proposition_group_id}

Add TruemoveH Mobile
    [Arguments]    ${number}=0    ${mobile_type}=4    ${hold_expired_date}=2016-10-10 10:00:00    ${used}=N    ${status}=Y    ${expired_date}=3000-10-10 10:00:00
    Delete TruemoveH Mobile    ${number}
    Run Keyword If    '${hold_expired_date}'=='null'    py_insert_truemoveh_mobile_hold_expired_date_is_null    ${number}    ${mobile_type}    ${used}    ${status}    ${expired_date}
    ...    ELSE    py_insert_truemoveh_mobile    ${number}    ${mobile_type}    ${hold_expired_date}    ${used}    ${status}    ${expired_date}

Map TruemoveH Device And Device Sub
    ${device_id}=    Convert To Integer    ${var_tmh_device_id}
    ${device_sub_id}=    Convert To Integer    ${var_tmh_device_sub_id}
    ${data}=    py_truemoveh_map_device_and_device_sub    ${device_id}    ${device_sub_id}
    ${map_id}=    Get From Dictionary    ${data}    sub_device_id
    Set Test Variable    ${var_tmh_map_sub_device_id}    ${map_id}
    Log to console    var_tmh_map_sub_device_id=${var_tmh_map_sub_device_id}

Map TruemoveH Proposition And Price Plan
    ${proposition_id}=    Convert To Integer    ${var_tmh_proposition_id}
    ${price_plan_id}=    Convert To Integer    ${var_tmh_price_plan_id}
    ${result}=    py_truemoveh_map_proposition_and_price_plan    ${proposition_id}    ${price_plan_id}
    ${proposition_map_id}=    Get From Dictionary    ${result}    proposition_map_id
    Set Test Variable    ${var_tmh_proposition_map_id}    ${proposition_map_id}
    Log to console    var_tmh_proposition_map_id=${var_tmh_proposition_map_id}

Map TruemoveH Proposition And Price Plan With Parameters
    [Arguments]    ${price_plan_id}
    ${proposition_id}=    Convert To Integer    ${var_tmh_proposition_id}
    ${price_plan_id}=    Convert To Integer    ${price_plan_id}
    ${result}=    py_truemoveh_map_proposition_and_price_plan    ${proposition_id}    ${price_plan_id}
    ${proposition_map_id}=    Get From Dictionary    ${result}    proposition_map_id
    #Set Test Variable    ${var_tmh_proposition_map_id}    ${proposition_map_id}
    #Log to console    var_tmh_proposition_map_id=${var_tmh_proposition_map_id}
    [Return]    ${proposition_map_id}

Map TruemoveH Proposition Groups And Proposition
    ${proposition_group_id}=    Convert To Integer    ${var_tmh_proposition_group_id}
    ${proposition_id}=    Convert To Integer    ${var_tmh_proposition_id}
    ${result}=    py_truemoveh_map_group_proposition_and_proposition    ${proposition_group_id}    ${proposition_id}
    ${proposition_group_map_id}=    Get From Dictionary    ${result}    proposition_group_map_id
    Set Test Variable    ${var_tmh_proposition_group_map_id}    ${proposition_group_map_id}
    Log to console    var_tmh_proposition_group_map_id=${var_tmh_proposition_group_map_id}

Map TruemoveH Device And Proposition Groups
    ${device_id}=    Convert To String    ${var_tmh_device_id}
    ${variant_id}=    Convert To String    ${var_tmh_product_device_variant_id}
    ${inventory_id}=    Convert To String    ${var_tmh_product_device_inventory_id}
    ${group_id}=    Convert To String    ${var_tmh_proposition_group_id}
    ${result}=    py_truemoveh_map_device_and_proposition_group    ${device_id}    ${variant_id}    ${group_id}    ${inventory_id}
    ${device_proposition_group_map_id}=    Get From Dictionary    ${result}    device_proposition_group_map_id
    Set Test Variable    ${var_tmh_device_proposition_group_map_id}    ${device_proposition_group_map_id}
    Log to console    var_tmh_device_proposition_group_map_id=${var_tmh_device_proposition_group_map_id}

Delete Product From TruemoveH Device
    py_delete_truemoveh_device    ${var_tmh_device_id}
    Log to console    Table=truemoveh_device:${var_tmh_device_id}

Delete Map TruemoveH Device And Device Sub
    py_delete_truemoveh_sub_device    ${var_tmh_map_sub_device_id}
    Log to console    Table=truemoveh_sub_device:${var_tmh_map_sub_device_id}

Delete TruemoveH Proposition
    py_delete_truemoveh_propositions    ${var_tmh_proposition_id}
    Log to console    Table=truemoveh_propositions:${var_tmh_proposition_id}

Delete TruemoveH Price Plan
    [Arguments]    ${price_plan_id}=${var_tmh_price_plan_id}
    py_delete_truemoveh_price_plans    ${price_plan_id}
    Log to console    Table=truemoveh_price_plans:${price_plan_id}

Delete TruemoveH Proposition And Price Plan
    [Arguments]    ${proposition_map_id}=${var_tmh_proposition_map_id}
    py_delete_truemoveh_proposition_maps    ${proposition_map_id}
    Log to console    Table=truemoveh_proposition_maps:${proposition_map_id}

Delete TruemoveH Proposition Groups
    py_delete_truemoveh_proposition_groups    ${var_tmh_proposition_group_id}
    Log to console    Table=truemoveh_proposition_groups:${var_tmh_proposition_group_id}

Delete TruemoveH Proposition Groups And Proposition
    py_delete_truemoveh_proposition_group_maps    ${var_tmh_proposition_group_map_id}
    Log to console    Table=truemoveh_proposition_group_maps:${var_tmh_proposition_group_map_id}

Delete TruemoveH Device And Proposition Groups
    py_delete_truemoveh_device_proposition_group_maps    ${var_tmh_device_proposition_group_map_id}
    Log to console    Table=truemoveh_device_proposition_group_maps:${var_tmh_device_proposition_group_map_id}

Delete TruemoveH Mobile
    [Arguments]    ${number}=0
    py_delete_truemoveh_mobile    ${number}

Prepare TruemoveH Normal Product Bundle On PCMS
    Get Any Normal Product For TruemoveH Device
    Add Product To TruemoveH Device
    Get TruemoveH Device Sub
    Map TruemoveH Device And Device Sub
    Get TruemoveH Parent Proposition For Bundle From Mobile
    Add TruemoveH Proposition For Bundle
    Add TruemoveH Price Plan
    Map TruemoveH Proposition And Price Plan
    Add TruemoveH Proposition Groups
    Map TruemoveH Proposition Groups And Proposition
    Map TruemoveH Device And Proposition Groups

Prepare TruemoveH Product Bundle On PCMS
    [Arguments]    ${priceplan_status}=Y
    Get Normal Product For TruemoveH Device
    Add Product To TruemoveH Device
    Get TruemoveH Device Sub
    Map TruemoveH Device And Device Sub
    Get TruemoveH Parent Proposition For Bundle From Mobile
    Add TruemoveH Proposition For Bundle
    Add TruemoveH Price Plan    ${priceplan_status}
    Map TruemoveH Proposition And Price Plan
    Add TruemoveH Proposition Groups
    Map TruemoveH Proposition Groups And Proposition
    Map TruemoveH Device And Proposition Groups

Prepare TruemoveH Product Bundle On PCMS Two Priceplans
    [Arguments]    ${priceplan_1_status}=Y    ${priceplan_2_status}=Y    ${price_plan_1_code}=PP01    ${price_plan_2_code}=PP02    ${priceplan_1_short_desc}=Priceplan 1 Short Description    ${priceplan_2_short_desc}=Priceplan 2 Short Description
    Get Normal Product For TruemoveH Device
    Add Product To TruemoveH Device
    Get TruemoveH Device Sub
    Map TruemoveH Device And Device Sub
    Get TruemoveH Parent Proposition For Bundle From Mobile
    Add TruemoveH Proposition For Bundle
    ${priceplan_1}=    Add TruemoveH Price Plan With Parameters    ${priceplan_1_status}    ${priceplan_1_status}    ${price_plan_1_code}    ${priceplan_1_short_desc}
    ${priceplan_2}=    Add TruemoveH Price Plan With Parameters    ${priceplan_2_status}    ${priceplan_2_status}    ${price_plan_2_code}    ${priceplan_2_short_desc}
    ${proposition_map_1}=    Map TruemoveH Proposition And Price Plan With Parameters    ${priceplan_1}
    ${proposition_map_2}=    Map TruemoveH Proposition And Price Plan With Parameters    ${priceplan_2}
    Add TruemoveH Proposition Groups
    Map TruemoveH Proposition Groups And Proposition
    Map TruemoveH Device And Proposition Groups
    ${dict}=    Create Dictionary    priceplan_1=${priceplan_1}    priceplan_2=${priceplan_2}    proposition_map_1=${proposition_map_1}    proposition_map_2=${proposition_map_2}
    [Return]    ${dict}

Delete TruemoveH Product Bundle On PCMS
    Delete Product From TruemoveH Device
    Delete Map TruemoveH Device And Device Sub
    Delete TruemoveH Proposition
    Delete TruemoveH Price Plan
    Delete TruemoveH Proposition And Price Plan
    Delete TruemoveH Proposition Groups
    Delete TruemoveH Proposition Groups And Proposition
    Delete TruemoveH Device And Proposition Groups

Delete TruemoveH Product Bundle On PCMS Two Priceplans
    [Arguments]    ${data}
    ${priceplan_1}=    Get From Dictionary    ${data}    priceplan_1
    ${priceplan_2}=    Get From Dictionary    ${data}    priceplan_2
    ${proposition_map_1}=    Get From Dictionary    ${data}    proposition_map_1
    ${proposition_map_2}=    Get From Dictionary    ${data}    proposition_map_2
    Delete Product From TruemoveH Device
    Delete Map TruemoveH Device And Device Sub
    Delete TruemoveH Proposition
    Delete TruemoveH Price Plan    ${priceplan_1}
    Delete TruemoveH Price Plan    ${priceplan_2}
    Delete TruemoveH Proposition And Price Plan    ${proposition_map_1}
    Delete TruemoveH Proposition And Price Plan    ${proposition_map_2}
    Delete TruemoveH Proposition Groups
    Delete TruemoveH Proposition Groups And Proposition
    Delete TruemoveH Device And Proposition Groups

Delete TruemoveH Product On PCMS
    Delete Product From TruemoveH Device
    Delete Map TruemoveH Device And Device Sub
    Delete TruemoveH Proposition
    Delete TruemoveH Price Plan
    Delete TruemoveH Proposition And Price Plan
    Delete TruemoveH Proposition Groups
    Delete TruemoveH Proposition Groups And Proposition
    Delete TruemoveH Device And Proposition Groups

Delete TruemoveH Product On PCMS Two Priceplans
    [Arguments]    ${priceplan_1}    ${priceplan_2}    ${proposition_map_1}    ${proposition_map_2}
    Delete Product From TruemoveH Device
    Delete Map TruemoveH Device And Device Sub
    Delete TruemoveH Proposition
    Delete TruemoveH Price Plan    ${priceplan_1}
    Delete TruemoveH Price Plan    ${priceplan_2}
    Delete TruemoveH Proposition And Price Plan    ${proposition_map_1}
    Delete TruemoveH Proposition And Price Plan    ${proposition_map_2}
    Delete TruemoveH Proposition Groups
    Delete TruemoveH Proposition Groups And Proposition
    Delete TruemoveH Device And Proposition Groups

Prepare TruemoveH Product MNP Device On PCMS
    Get Normal Product For TruemoveH Device
    Add Product To TruemoveH Device
    Get TruemoveH Device Sub
    Map TruemoveH Device And Device Sub
    Get TruemoveH Parent Proposition For MNP Device From Mobile
    Add TruemoveH Proposition For MNP Device
    Add TruemoveH Price Plan For MNP Device
    Map TruemoveH Proposition And Price Plan
    Add TruemoveH Proposition Groups
    Map TruemoveH Proposition Groups And Proposition
    Map TruemoveH Device And Proposition Groups

Prepare TruemoveH Product MNP Device On PCMS One Priceplan
    [Arguments]    ${status}=Y    ${pp_code}=ROBOTMNPDEVICE01    ${recommend}=N    ${sub_description}=Robot Price Plan Status=${status}
    Get Normal Product For TruemoveH Device
    Add Product To TruemoveH Device
    Get TruemoveH Device Sub
    Map TruemoveH Device And Device Sub
    Get TruemoveH Parent Proposition For MNP Device From Mobile
    Add TruemoveH Proposition For MNP Device
    Add TruemoveH Price Plan With Parameters    ${status}    ${recommend}    ${pp_code}    ${sub_description}
    Map TruemoveH Proposition And Price Plan
    Add TruemoveH Proposition Groups
    Map TruemoveH Proposition Groups And Proposition
    Map TruemoveH Device And Proposition Groups

Prepare TruemoveH Product MNP Device On PCMS Two Priceplan
    [Arguments]    ${pp_1_status}=Y    ${pp_2_status}=Y    ${pp_1_code}=ROBOTMNPDEVICE11    ${pp_2_code}=ROBOTMNPDEVICE12    ${pp_1_desc}=Robot PP 1 Status=${pp_1_status}    ${pp_2_desc}=Robot PP 2 Status=${pp_2_status}
    ...    ${recommend_1}=N    ${recommend_2}=N
    Get Normal Product For TruemoveH Device
    Add Product To TruemoveH Device
    Get TruemoveH Device Sub
    Map TruemoveH Device And Device Sub
    Get TruemoveH Parent Proposition For MNP Device From Mobile
    Add TruemoveH Proposition For MNP Device
    ${priceplan_1}=    Add TruemoveH Price Plan With Parameters    ${pp_1_status}    ${recommend_1}    ${pp_1_code}    ${pp_1_desc}
    ${priceplan_2}=    Add TruemoveH Price Plan With Parameters    ${pp_2_status}    ${recommend_2}    ${pp_2_code}    ${pp_2_desc}
    ${proposition_map_1}=    Map TruemoveH Proposition And Price Plan With Parameters    ${priceplan_1}
    ${proposition_map_2}=    Map TruemoveH Proposition And Price Plan With Parameters    ${priceplan_2}
    Add TruemoveH Proposition Groups
    Map TruemoveH Proposition Groups And Proposition
    Map TruemoveH Device And Proposition Groups
    ${dict}=    Create Dictionary    priceplan_1=${priceplan_1}    priceplan_2=${priceplan_2}    proposition_map_1=${proposition_map_1}    proposition_map_2=${proposition_map_2}
    [Return]    ${dict}

TruemoveH - Get Product MNP Sim
    ${mnp_inventory_id}=         get_inventory_mnp
    Set Test Variable           ${var_tmh_mnp_sim_inventory_id}        ${mnp_inventory_id}
    Log To Console              mnp_inventory_id=${var_tmh_mnp_sim_inventory_id}

TruemoveH - Get Price Plan MNP Sim
    ${price_plan}=              py_get_price_plan_mnp_sim
    Set Test Variable           ${var_tmh_price_plan_mnp_sim}       ${price_plan}
    Log To Console              mnp_price_plan=${var_tmh_price_plan_mnp_sim}

TruemoveH - Delete TruemoveH Order Verifys By Mobile Number
    [Arguments]         ${mobile_number}
    ${result}=          py_delete_truemoveh_order_verifys_by_mobile     ${mobile_number}
    Log To Console      delete_order_verifys_mobile_${mobile_number}=${result}

TruemoveH - Get Mobile Number Hold By Customer
    [Arguments]         ${mobile_number}            ${customer_ref_id}
    ${hold_data}=       py_get_mobile_is_hold_by_customer       ${mobile_number}            ${customer_ref_id}
    ${hold_expired_date}=       Get From Dictionary             ${hold_data}        hold_expired_date
    Set Test Variable           ${var_tmh_mobile_hold_expired_date}       ${hold_expired_date}
    [Return]            ${hold_expired_date}

TruemoveH - Get Truemvoeh Data For Buy Bundle
    ${bundle_data}=         py_get_data_for_buy_bundle
    ${product_pkey}=                    Get From Dictionary     ${bundle_data}     product_pkey
    ${product_inventory_id}=            Get From Dictionary     ${bundle_data}     product_inventory_id
    ${product_sim_inventory_id}=        Get From Dictionary     ${bundle_data}     product_sim_inventory_id
    ${price_plan_id}=                   Get From Dictionary     ${bundle_data}     price_plan_id
    ${pp_code}=                         Get From Dictionary     ${bundle_data}     pp_code
    ${parent_id}=                       Get From Dictionary     ${bundle_data}     parent_id
    Set Test Variable                   ${var_data_bundle_product_pkey}                     ${product_pkey}
    Set Test Variable                   ${var_data_bundle_product_inventory_id}             ${product_inventory_id}
    Set Test Variable                   ${var_data_bundle_product_sim_inventory_id}         ${product_sim_inventory_id}
    Set Test Variable                   ${var_data_bundle_price_plan_id}                    ${price_plan_id}
    Set Test Variable                   ${var_data_bundle_pp_code}                          ${pp_code}
    Set Test Variable                   ${var_data_bundle_proposition_parent_id}            ${parent_id}
    Log To Console                      bundle_pkey=${var_data_bundle_product_pkey}
    Log To Console                      bundle_product_inventory_id=${var_data_bundle_product_inventory_id}
    Log To Console                      bundle_sim_inventory_id=${var_data_bundle_product_sim_inventory_id}
    Log To Console                      bundle_price_plan_id=${var_data_bundle_price_plan_id}
    Log To Console                      bundle_pp_code=${var_data_bundle_pp_code}
    Log To Console                      bundle_parent=${var_data_bundle_proposition_parent_id}

TruemoveH - Get Truemvoeh Data For Buy Mnp Deice
    ${mnp_device_data}=                 py_get_data_for_buy_mnp_device
    ${product_pkey}=                    Get From Dictionary     ${mnp_device_data}     product_pkey
    ${product_inventory_id}=            Get From Dictionary     ${mnp_device_data}     product_inventory_id
    ${product_sim_inventory_id}=        Get From Dictionary     ${mnp_device_data}     product_sim_inventory_id
    ${price_plan_id}=                   Get From Dictionary     ${mnp_device_data}     price_plan_id
    ${pp_code}=                         Get From Dictionary     ${mnp_device_data}     pp_code
    Set Test Variable                   ${var_mnp_device_product_pkey}                     ${product_pkey}
    Set Test Variable                   ${var_mnp_device_product_inventory_id}             ${product_inventory_id}
    Set Test Variable                   ${var_mnp_device_product_sim_inventory_id}         ${product_sim_inventory_id}
    Set Test Variable                   ${var_mnp_device_price_plan_id}                    ${price_plan_id}
    Set Test Variable                   ${var_mnp_device_pp_code}                          ${pp_code}
    Set Test Variable                   ${var_mnp_device_proposition_parent_id}            ${parent_id}
    Log To Console                      bundle_pkey=${var_mnp_device_product_pkey}
    Log To Console                      bundle_product_inventory_id=${var_mnp_device_product_inventory_id}
    Log To Console                      bundle_sim_inventory_id=${var_mnp_device_product_sim_inventory_id}
    Log To Console                      bundle_price_plan_id=${var_mnp_device_price_plan_id}
    Log To Console                      bundle_pp_code=${var_mnp_device_pp_code}
    Log To Console                      bundle_parent=${var_mnp_device_proposition_parent_id}

TruemoveH - Get Mobile By Proposition Id
    [Arguments]         ${proposition_id}
    ${mobile_data}=         py_get_mobile_by_proposition_id            ${proposition_id}
    ${mobile_id}=           Get From Dictionary     ${mobile_data}     mobile_id
    ${mobile_number}=       Get From Dictionary     ${mobile_data}     mobile_number
    Set Test Variable                   ${var_data_mobile_id}                 ${mobile_id}
    Set Test Variable                   ${var_data_mobile_number}             ${mobile_number}
    Log To Console                      mobile_id=${var_data_mobile_id}
    Log To Console                      mobile_number=${var_data_mobile_number}

TruemoveH - Get Pcms Order Id By Mobile and IdCard
    [Arguments]         ${mobile}       ${idcart}
    ${pcms_order_id}=           py_get_pcms_order_id_by_mobile_and_idcard           ${mobile}           ${idcart}
    Set Test Variable           ${var_tmh_pcms_order_id}         ${pcms_order_id}
    Log To Console              pcms_order_id=${var_tmh_pcms_order_id}

TruemoveH - [MNP Device] Prepare Mnp Order Verify
    [Arguments]         ${idcard}       ${mobile_number}        ${customer_fname}=None       ${customer_lname}=None

    ${datetime_now}=            Get Current Date            result_format=datetime
    ${datetime_now_2}=	        Add Time To Date	        ${datetime_now}	            2 days
    ${datetime_now_7}=	        Add Time To Date	        ${datetime_now}	            7 days
    ${created_at}=              Convert Date	            ${datetime_now}             exclude_millis=yes
    ${activate_date}=           Convert Date	            ${datetime_now_2}           exclude_millis=yes
    ${mnp1_success_date}=       Convert Date	            ${datetime_now_7}           exclude_millis=yes

    ${customer_fname}=          Run Keyword If          '${customer_fname}' == 'None'               Convert To String           Test_FName
     ...                        ELSE                    Convert To String           ${customer_fname}
    ${customer_lname}=          Run Keyword If          '${customer_lname}' == 'None'               Convert To String           Test_LName
     ...                        ELSE                    Convert To String           ${customer_lname}

    ${data}=         py_insert_truemoveh_order_verify       ${idcard}
    ...     ${mobile_number}
    ...     ${customer_fname}
    ...     ${customer_lname}
    ...     Y
    ...     mnp
    ...     success
    ...     ${activate_date}                # activate_date Ex. 2016-07-15 00:00:00
    ...     success
    ...     ${mnp1_success_date}            # mnp1_success_date ไม่เกิน 30 วัน  นับจากวันที่ปัจจุบัน Ex. 2016-07-30 00:00:00
    ...     0
    ...     ${created_at}                   # createed_at Ex. 2016-01-15 13:13:27
    Log To Console          ${data}

TruemoveH - Get Pcms Order By Dealer
    [Arguments]         ${dealer_id}
    ${pcms_order_data}=         py_get_pcms_truemove_order_id_and_dealer_name          ${dealer_id}
    ${pcms_order_id}=           Get From Dictionary     ${pcms_order_data}     pcms_order_id
    ${merchant_name}=           Get From Dictionary     ${pcms_order_data}     name
    ${created_at}=              Get From Dictionary     ${pcms_order_data}     created_at
    ${transaction_time}=        Get From Dictionary     ${pcms_order_data}     transaction_time
    ${payment_status}=          Get From Dictionary     ${pcms_order_data}     payment_status
    ${status}=                  Get From Dictionary     ${pcms_order_data}     status
    ${item_status}=             Get From Dictionary     ${pcms_order_data}     item_status
    ${activate_status}=         Get From Dictionary     ${pcms_order_data}     activate_status
    ${mobile_no}=               Get From Dictionary     ${pcms_order_data}     mobile_no
    ${item_id}=                 Get From Dictionary     ${pcms_order_data}     item_id
    Set Test Variable           ${var_tmh_pcms_merchant_order_id}                ${pcms_order_id}
    Set Test Variable           ${var_tmh_pcms_merchant_merchant_name}           ${merchant_name}
    Set Test Variable           ${var_tmh_pcms_merchant_created_at}              ${created_at}
    Set Test Variable           ${var_tmh_pcms_merchant_transaction_time}        ${transaction_time}
    Set Test Variable           ${var_tmh_pcms_merchant_payment_status}          ${payment_status}
    Set Test Variable           ${var_tmh_pcms_merchant_status}                  ${status}
    Set Test Variable           ${var_tmh_pcms_merchant_item_status}             ${item_status}
    Set Test Variable           ${var_tmh_pcms_merchant_activate_status}         ${activate_status}
    Set Test Variable           ${var_tmh_pcms_merchant_mobile_no}               ${mobile_no}
    Set Test Variable           ${var_tmh_pcms_merchant_item_id}                 ${item_id}

TruemoveH - Get Pcms Order By TruemoveH
    ${pcms_order_data}=         py_get_pcms_truemove_order_id_and_dealer_null
    ${pcms_order_id}=           Get From Dictionary     ${pcms_order_data}     pcms_order_id
    ${merchant_name}=           Get From Dictionary     ${pcms_order_data}     name
    ${created_at}=              Get From Dictionary     ${pcms_order_data}     created_at
    ${transaction_time}=        Get From Dictionary     ${pcms_order_data}     transaction_time
    ${payment_status}=          Get From Dictionary     ${pcms_order_data}     payment_status
    ${status}=                  Get From Dictionary     ${pcms_order_data}     status
    ${item_status}=             Get From Dictionary     ${pcms_order_data}     item_status
    ${activate_status}=         Get From Dictionary     ${pcms_order_data}     activate_status
    ${mobile_no}=               Get From Dictionary     ${pcms_order_data}     mobile_no
    ${item_id}=                 Get From Dictionary     ${pcms_order_data}     item_id
    Set Test Variable           ${var_tmh_pcms_itruemart_order_id}                ${pcms_order_id}
    Set Test Variable           ${var_tmh_pcms_itruemart_merchant_name}           ${merchant_name}
    Set Test Variable           ${var_tmh_pcms_itruemart_created_at}              ${created_at}
    Set Test Variable           ${var_tmh_pcms_itruemart_transaction_time}        ${transaction_time}
    Set Test Variable           ${var_tmh_pcms_itruemart_payment_status}          ${payment_status}
    Set Test Variable           ${var_tmh_pcms_itruemart_status}                  ${status}
    Set Test Variable           ${var_tmh_pcms_itruemart_item_status}             ${item_status}
    Set Test Variable           ${var_tmh_pcms_itruemart_activate_status}         ${activate_status}
    Set Test Variable           ${var_tmh_pcms_itruemart_mobile_no}               ${mobile_no}
    Set Test Variable           ${var_tmh_pcms_itruemart_item_id}                 ${item_id}


#Delete Device By Name
#    [Arguments]         ${device_name}
#    py_delete_truemoveh_device_by_name          ${device_name}
#
#Delete Device All Mapping By Name
#    [Arguments]         ${device_name}
#    ${a}=           py_delete_truemoveh_device_proposition_group_maps_by_device_name        ${device_name}
#    Log To Console          ${a}