*** Settings ***
Resource          ${CURDIR}/../../../../Keyword/Portal/iTrueMart/TruemoveH/keywords_common.robot

*** Keywords ***
TruemoveH Sim - Add Sim To Cart
    [Arguments]   ${customer_ref_id}   ${customer_type}   ${id_card}=None

    ${thai_id}=    Run Keyword If    ${id_card} == None    TruemoveH Common - Random Id Card
    ...    ELSE    Convert To String     ${id_card}

    Get TruemoveH Data For Search Available Mobile Number Sim
    Get TruemoveH Mobile Id For Sim     ${var_tmh_sim_mobile_province_id}   ${var_tmh_sim_mobile_type}
    ${mobile_id}=        Convert To String              ${var_tmh_sim_mobile_id}
    ${price_plan}=       Convert To String              ${var_tmh_sim_mobile_price_plan_id}
    ${thai_id}=          Convert To String              ${thai_id}
    ${customer_type}=    Convert To String              ${customer_type}
    ${customer_type}=    Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${path_json}=        Convert To String              ${CURDIR}/../../../../Resource/json/add_sim_to_cart.json
    ${response}=   API Cart - Add Sim    ${var_tmh_sim_inventory_id}   ${customer_ref_id}   ${customer_type}   ${mobile_id}   ${thai_id}   ${price_plan}   None   None   ${path_json}
    Set Test Variable     ${var_response_add_sim_to_cart}     ${response}

TruemoveH Sim - Add Sim To Cart II
    [Arguments]   ${sim_inventory_id}   ${customer_ref_id}   ${customer_type}   ${mobile_id}   ${thai_id}   ${price_plan}
    ${sim_inventory_id}=    Convert To String              ${sim_inventory_id}
    ${customer_ref_id}=     Convert To String              ${customer_ref_id}
    ${customer_type}=       Convert To String              ${customer_type}
    ${customer_type}=       Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${mobile_id}=           Convert To String              ${mobile_id}
    ${thai_id}=             Convert To String              ${thai_id}
    ${price_plan}=          Convert To String              ${price_plan}
    ${path_json}=           Convert To String              ${CURDIR}/../../../../Resource/json/add_sim_to_cart.json
    ${response}=   API Cart - Add Sim    ${sim_inventory_id}   ${customer_ref_id}   ${customer_type}   ${mobile_id}   ${thai_id}   ${price_plan}   None   None   ${path_json}
    Set Test Variable     ${var_response_add_sim_to_cart}     ${response}

TruemoveH Sim - Hold Cancel Mobile Number
    [Arguments]     ${mobile_id}        ${customer_ref_id}      ${thai_id}
    ${mobile_id}=           Convert To String              ${mobile_id}
    ${customer_ref_id}=     Convert To String              ${customer_ref_id}
    ${thai_id}=             Convert To String              ${thai_id}
    ${content}=             Convert To String              {"mobile_id": "${mobile_id}","customer_ref_id": "${customer_ref_id}","thai_id": "${thai_id}"}
    Log To Console                  content-hold-cancel=${content}
    Log to console                  ${PCMS_API_URL}${PCMS_PKEY}/truemoveh/mobile/hold-cancel
    Create Http Context             ${PCMS_API_URL}    http
    Set Request Header              Content-type     application/json
    Set Request Body                ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST           ${PCMS_PKEY}/truemoveh/mobile/hold-cancel
    ${response}=                    Get Response Body
    Log To Console                  res_api_hold_cancel=${response}
    [return]    ${response}
