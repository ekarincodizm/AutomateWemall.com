*** Settings ***
Library                 ${CURDIR}/../../../../Python_Library/truemoveh_library.py

*** Variables ***
${EQUAL_OR_MORE_THAN}          >=
${EQUAL_OR_LESS_THAN}          <=
${LESS_THAN}                    <
${MERCHANT_ITRUEMART}          IS NULL

*** Keywords ***
TMVH Commission Report DB - Get Commission Report Data
    [Arguments]          ${type}        ${download_operation}=${EQUAL_OR_MORE_THAN}     ${merchant_rule}=${MERCHANT_ITRUEMART}
    ${commission_report}=       py_get_commission_report_data               ${type}             ${download_operation}       ${merchant_rule}
    Set Test Variable           ${var_tmvh_commission_report_data}          ${commission_report}
    Commission Report Data - Set Variable

TMVH Commission Report DB - Get Commission Report Data Mnp
    ${commission_report}=       py_get_commission_report_data_mnp
    Set Test Variable           ${var_tmvh_commission_report_data}          ${commission_report}
    Commission Report Data - Set Variable

TMVH Commission Report DB - Get Commission Report Data with Activate Date
    [Arguments]          ${type}        ${activate_operation}=${EQUAL_OR_MORE_THAN}         ${download_operation}=${EQUAL_OR_MORE_THAN}     ${merchant_rule}=${MERCHANT_ITRUEMART}
    ${commission_report}=       py_get_commission_report_with_activated_date            ${type}         ${download_operation}        ${activate_operation}      ${merchant_rule}
    Set Test Variable           ${var_tmvh_commission_report_data}          ${commission_report}
    Commission Report Data - Set Variable

Commission Report Data - Set Variable
    ${pcms_order_id}=           Get From Dictionary                         ${var_tmvh_commission_report_data}        pcms_order_id
    ${bundle_type}=             Get From Dictionary                         ${var_tmvh_commission_report_data}        bundle_type
    ${download_count}=          Get From Dictionary                         ${var_tmvh_commission_report_data}        download_count
    ${type_val}=                Run Keyword If          '${bundle_type}' == 'sim'               Convert To String           1
     ...                        ELSE IF                 '${bundle_type}' == 'bundle'            Convert To String           2
     ...                        ELSE IF                 '${bundle_type}' == 'mnp'               Convert To String           3
     ...                        ELSE IF                 '${bundle_type}' == 'mnp_device'        Convert To String           4
    Set Test Variable           ${var_tmvh_commission_pcms_order_id}        ${pcms_order_id}
    Set Test Variable           ${var_tmvh_commission_bundle_type}          ${bundle_type}
    Set Test Variable           ${var_tmvh_commission_bundle_type_value}    ${type_val}
    Set Test Variable           ${var_tmvh_commission_download_count}       ${download_count}
    Log To Console              pcms_order_id=${var_tmvh_commission_pcms_order_id}