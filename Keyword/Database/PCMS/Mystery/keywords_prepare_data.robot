*** Settings ***
Library                 Selenium2Library
Library                 Collections
Library                 String
Library                 ${CURDIR}/../../../../Python_Library/Mystery.py
Library                 ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Mystery Data - Get Prediction List
    ${predictions}=             py_get_predition_list
    Set Test Variable           ${var_mystery_prediction_list}          ${predictions}
#    : FOR    ${prediction}    IN    @{prediction_list}
#    \           ${id}=              Get From Dictionary         ${predictions}       id
#    \           Log To Console              ${id}

Mystery Data - Get Prefix EDM
    ${prefix}=      py_get_id_by_prefix     ${prefix_landing}
    ${prefix_id}=        Get From Dictionary        ${prefix}      id
    Set Test Variable       ${var_mystery_landing_edm_id}        ${prefix_id}

Mystery Data - Update Status Prediction to Active
    py_update_prediction_status               color           Y

Mystery Data - Update Status Prediction to Inactive
    py_update_prediction_status               color           N

Mystery Data - Get Secret Code
    ${secret_code}=         py_get_secret_code
    ${code}=                Get From Dictionary        ${secret_code}      code
    Set Test Variable       ${var_mystery_secret_code}        ${code}

Mystery Data - Delete Automate Data
    ${prefix}=      py_delete_automate_data_on_angpao_members     ${var_data_email}

Mystery Data - Get Prediction Item
    ${prediction_data}=         py_get_predition_item
    ${prediction_id}=           Get From Dictionary         ${prediction_data}          id
    ${name_th}=                 Get From Dictionary         ${prediction_data}          name_th
    ${img_thumb}=               Get From Dictionary         ${prediction_data}          img_thumb
    ${img_thumb_hover}=         Get From Dictionary         ${prediction_data}          img_thumb_hover
    ${short_desc_th}=           Get From Dictionary         ${prediction_data}          short_desc_th
    ${long_desc_th}=            Get From Dictionary         ${prediction_data}          long_desc_th
    Set Test Variable           ${var_mystery_prediction_item_id}                       ${prediction_id}
    Set Test Variable           ${var_mystery_prediction_item_name_th}                  ${name_th}
    Set Test Variable           ${var_mystery_prediction_item_img_thumb}                ${img_thumb}
    Set Test Variable           ${var_mystery_prediction_item_img_thumb_hover}          ${img_thumb_hover}
    Set Test Variable           ${var_mystery_prediction_item_short_desc_th}            ${short_desc_th}
    Set Test Variable           ${var_mystery_prediction_item_long_desc_th}             ${long_desc_th}

Mystery Data - Get Prediction Sub By Prediction Item Id
    [Arguments]         ${prediction_id}
    ${prediction_sub}=              py_get_predition_sub_by_id              ${prediction_id}
    Set Test Variable               ${var_mystery_prediction_sub}           ${prediction_sub}

Mystery Data - Get register data from database
    ${status}=      py_get_detail_coupon        ${var_data_email}  ${var_data_firstname}  ${var_data_lastname}  ${var_data_tel}  ${var_data_gender}
    ${var_status}=          Get From Dictionary         ${status}           status
    Set Test Variable           ${var_mystery_register_privilege_status}                       ${var_status}
