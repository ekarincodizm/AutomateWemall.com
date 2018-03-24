*** Settings ***
Resource          ${CURDIR}/../../../../Keyword/Portal/iTrueMart/TruemoveH/keywords_common.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ${CURDIR}/../../../../Keyword/API/common/api_keywords.robot

*** Keywords ***
TruemoveH Bundle - Add Bundle To Cart
	[Arguments]        ${customer_ref_id}
	...     ${customer_type}
	...     ${idcard}=None
	...     ${customer_email}=None
	...     ${customer_tel}=None

    ${customer_type}=    Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${customer_email}=   Run Keyword If   '${customer_email}' == 'None'   Convert To String   robotautomate@mail.com
    ...     ELSE   Convert To String   ${customer_email}
    ${customer_tel}=     Run Keyword If   '${customer_tel}' == 'None'     Convert To String   081234500
    ...     ELSE   Convert To String   ${customer_tel}

    TruemoveH - Get Truemvoeh Data For Buy Bundle
    Create Bundle Promotion On Camp                 ${var_data_bundle_product_inventory_id}   ${var_data_bundle_product_sim_inventory_id}       ${BUNDLE-CAMPAIGN-ID}
    TruemoveH - Get Mobile By Proposition Id        ${var_data_bundle_proposition_parent_id}

    ${path_json}=               Convert To String           ${CURDIR}/../../../../Resource/json/add_bundle_to_cart.json
    ${device_inventory_id}=     Convert To String           ${var_data_bundle_product_inventory_id}
    ${sim_inventory_id}=        Convert To String           ${var_data_bundle_product_sim_inventory_id}
    ${customer_ref_id}=         Convert To String           ${customer_ref_id}
    ${customer_type}=           Convert To String           ${customer_type}
    ${mobile_id}=               Convert To String           ${var_data_mobile_id}
    ${idcard}=                  Convert To String           ${idcard}
    ${price_plan_id}=           Convert To String           ${var_data_bundle_price_plan_id}

    TruemoveH Bundle - Call Api Add Bundle      ${device_inventory_id}
    ...     ${sim_inventory_id}
    ...     ${customer_ref_id}
    ...     ${customer_type}
    ...     ${mobile_id}
    ...     ${idcard}
    ...     ${price_plan_id}
    ...     ${customer_email}
    ...     ${customer_tel}
    ...     ${path_json}

TruemoveH Bundle - Add Bundle To Cart Fixed Data
    [Arguments]   ${device_inventory_id}
    ...     ${sim_inventory_id}
    ...     ${customer_ref_id}
    ...     ${customer_type}
    ...     ${mobile_id}
    ...     ${idcard}
    ...     ${price_plan_id}
    ...     ${customer_email}=None
    ...     ${customer_tel}=None

    ${device_inventory_id}=     Convert To String           ${device_inventory_id}
    ${sim_inventory_id}=        Convert To String           ${sim_inventory_id}
    ${customer_ref_id}=         Convert To String           ${customer_ref_id}
    ${customer_type}=           Convert To String           ${customer_type}
    ${customer_type}=           Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${mobile_id}=               Convert To String           ${mobile_id}
    ${idcard}=                  Convert To String           ${idcard}
    ${price_plan_id}=           Convert To String           ${price_plan_id}
    ${path_json}=               Convert To String           ${CURDIR}/../../../../Resource/json/add_bundle_to_cart.json

    TruemoveH Bundle - Call Api Add Bundle      ${device_inventory_id}
    ...     ${sim_inventory_id}
    ...     ${customer_ref_id}
    ...     ${customer_type}
    ...     ${mobile_id}
    ...     ${idcard}
    ...     ${price_plan_id}
    ...     ${customer_email}
    ...     ${customer_tel}
    ...     ${path_json}

TruemoveH Bundle - Call Api Add Bundle
    [Arguments]   ${inventory_id}=None
    ...     ${inventory_id2}=None
    ...     ${customer_ref_id}=None
    ...     ${customer_type}=None
    ...     ${mobile_id}=None
    ...     ${idcard}=None
    ...     ${price_plan_id}=None
    ...     ${customer_email}=None
    ...     ${customer_tel}=None
    ...     ${path_json}=None

    ${idcard}=    Run Keyword If    ${id_card} == None    TruemoveH Common - Random Id Card
    ...     ELSE    Convert To String     ${idcard}
    ${customer_email}=   Run Keyword If   '${customer_email}' == 'None'   Convert To String   robotautomate@mail.com
    ...     ELSE   Convert To String   ${customer_email}
    ${customer_tel}=     Run Keyword If   '${customer_tel}' == 'None'     Convert To String   081234500
    ...     ELSE   Convert To String   ${customer_tel}

    ${content}=    Get File          ${path_json}    utf-8
    ${content}=    Replace String    ${content}     ^^inventory_id^^        ${inventory_id}
    ${content}=    Replace String    ${content}     ^^inventory_id2^^       ${inventory_id2}
    ${content}=    Replace String    ${content}     ^^customer_ref_id^^     ${customer_ref_id}
    ${content}=    Replace String    ${content}     ^^customer_type^^       ${customer_type}
    ${content}=    Replace String    ${content}     ^^mobile_id^^           ${mobile_id}
    ${content}=    Replace String    ${content}     ^^idcard^^              ${idcard}
    ${content}=    Replace String    ${content}     ^^price_plan_id^^       ${price_plan_id}
    ${content}=    Replace String    ${content}     ^^customer_email^^      ${customer_email}
    ${content}=    Replace String    ${content}     ^^customer_tel^^        ${customer_tel}
    Log To Console                  content-after-replace=${content}
    HTTP Post Request               ${PCMS_API_URL}         http            ${truemoveh-registerinfo-save}          ${content}
    ${response}=                    Get Response Body
    Log To Console                  res_api_add_bundle=${response}
    [return]    ${response}
