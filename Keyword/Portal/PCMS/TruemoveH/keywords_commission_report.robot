*** Settings ***
Resource          web_element_commission_report.robot
Library           ${CURDIR}/../../../../Python_Library/truemoveh_super_number.py

*** Keywords ***
TMVH Commission Report - Login PCMS
    [Arguments]     ${Text_Email}=${PCMS_USERNAME}    ${Text_Password}=${PCMS_PASSWORD}
    Open Browser                        ${PCMS_URL}         ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible       ${xpath-login-email}
    Input Text                          ${xpath-login-email}        ${Text_Email}
    Input Text                          ${xpath-login-password}     ${Text_Password}
    Click Element                       ${xpath-login-button}
    Wait Until Element Is Visible       ${xpath-link-logout}    30s

TMVH Commission Report - Go To TruemoveH Commission Report
    Go To                               ${PCMS_URL}/truemoveh/commission-report
    Wait Until Element Is Visible       ${tmvh_commission_button_search}                       30s

TMVH Commission Report - Select Type
    [Arguments]         ${bundle_type}
    Wait Until Element Is Visible       ${tmvh_cbo_type}        30s
    Select From List                    ${tmvh_cbo_type}        ${bundle_type}

TMVH Commission Report - Select Activated
    [Arguments]         ${activated}
    Wait Until Element Is Visible       ${tmvh_cbo_activated}        30s
    Select From List                    ${tmvh_cbo_activated}        ${activated}

TMVH Commission Report - Select Downloaded
    [Arguments]         ${downloaded}
    Wait Until Element Is Visible       ${tmvh_cbo_downloaded}        30s
    Select From List                    ${tmvh_cbo_downloaded}        ${downloaded}

TMVH Commission Report - Activated has value
    [Arguments]         ${activated_value}
    Wait Until Element Is Visible       ${tmvh_cbo_activated}        30s
    Element Should Be Visible           ${tmvh_cbo_activated}/option[@value="${activated_value}"]

TMVH Commission Report - Downloaded has value
    [Arguments]         ${downloaded_value}
    Wait Until Element Is Visible       ${tmvh_cbo_downloaded}        30s
    Element Should Be Visible           ${tmvh_cbo_downloaded}/option[@value="${downloaded_value}"]

TMVH Commission Report - Activated Display Default Value
    [Arguments]         ${activated_default_value}
    Wait Until Element Is Visible       ${tmvh_cbo_activated}        30s
    Element Should Be Visible           ${tmvh_cbo_activated}/option[@value="${activated_default_value}" and @selected="selected"]

TMVH Commission Report - Downloaded Display Default Value
    [Arguments]         ${downloaded_default_value}
    Wait Until Element Is Visible       ${tmvh_cbo_downloaded}        30s
    Element Should Be Visible           ${tmvh_cbo_downloaded}/option[@value="${downloaded_default_value}" and @selected="selected"]

TMVH Commission Report - Start Date Display Default Value
   [Arguments]    ${default_value}
   Wait Until Element Is Visible        ${tmvh_txt_start_date}    30s
   Element Should Be Visible            ${tmvh_txt_start_date}
   ${txt_order_value}=                  Get Text                    ${tmvh_txt_start_date}
   Should Be Equal                      ${txt_order_value}          ${default_value}

TMVH Commission Report - End Date Display Default Value
   [Arguments]    ${default_value}
   Wait Until Element Is Visible       ${tmvh_txt_end_date}    30s
   Element Should Be Visible           ${tmvh_txt_end_date}
   ${txt_order_value}=                 Get Text                    ${tmvh_txt_end_date}
   Should Be Equal                     ${txt_order_value}          ${default_value}

TMVH Commission Report - Display textbox Search By Order ID
    Wait Until Element Is Visible       ${tmvh_txt_order_id}        30s
    Element Should Be Visible           ${tmvh_txt_order_id}
    ${txt_order_value}=                 Get Text                    ${tmvh_txt_order_id}
    Should Be Equal                     ${txt_order_value}          ${EMPTY}

TMVH Commission Report - Display Search Button
    Wait Until Element Is Visible       ${tmvh_commission_button_search}        30s
    Element Should Be Visible           ${tmvh_commission_button_search}

TMVH Commission Report - Display Reset Button
    Wait Until Element Is Visible       ${tmvh_button_reset}        30s
    Element Should Be Visible           ${tmvh_button_reset}

TMVH Commission Report - Click Search Button
    Wait Until Element Is Visible       ${tmvh_commission_button_search}        30s
    Click Element                       ${tmvh_commission_button_search}

TMVH Commission Report - Click Reset Button
    Wait Until Element Is Visible       ${tmvh_button_reset}        30s
    Click Element                       ${tmvh_button_reset}

TMVH Commission Report - Input Start Date
   [Arguments]    ${start_date}
   Wait Until Element Is Visible            ${tmvh_txt_start_date}    30s
   Input Text    ${tmvh_txt_start_date}     ${start_date}

TMVH Commission Report - Input End Date
   [Arguments]    ${end_date}
   Wait Until Element Is Visible            ${tmvh_txt_end_date}    30s
   Input Text    ${tmvh_txt_end_date}       ${end_date}

TMVH Commission Report - Input Order ID
   [Arguments]    ${order_id}
   Wait Until Element Is Visible            ${tmvh_txt_order_id}    30s
   Input Text    ${tmvh_txt_order_id}       ${order_id}

TMVH Commission Report - Display Row Data
   [Arguments]    ${order_id}
   Wait Until Element Is Visible            //*[@data-order-id="${order_id}"]       30s
   Element Should Be Visible                //*[@data-order-id="${order_id}"]

TMVH Commission Report - No Row Data Is Displayed
   [Arguments]    ${order_id}
   Sleep   3
   Element Should Not Be Visible                //*[@data-order-id="${order_id}"]

TMVH Commission Report - Display Download Count
   [Arguments]    ${count}
   Wait Until Element Is Visible            ${tmvh_label_download_count}       30s
   ${txt_download_count}=                   Get Text            ${tmvh_label_download_count}
   Should Be Equal                          ( จำนวนครั้งที่ดาวน์โหลด ${count} ครั้ง )                   ${txt_download_count}

TMVH Commission Report - Select Dealer
    [Arguments]         ${merchant_type}
    Wait Until Element Is Visible       ${tmvh_commission_merchant_type}        30s
    Select From List                    ${tmvh_commission_merchant_type}        ${merchant_type}

TMVH Commission Report - Get Dealer List From DB
    @{tmh_merchant_type_db_raw_data}=       get_tmh_merchant_type
    [return]    @{tmh_merchant_type_db_raw_data}

TMVH Commission Report - Check Dealer List Match With DB
    [Arguments]         ${dealer_list_ui}    ${dealer_list_db}
    ${dealer_list_length_ui}=    Get Length    ${dealer_list_ui}
    ${dealer_list_length_db}=    Get Length    ${dealer_list_db}
    ${dealer_list_length_db}=    Evaluate    ${dealer_list_length_db}+1
    Should Be Equal      ${dealer_list_length_ui}       ${dealer_list_length_db}
    :for    ${index}    in range    0     ${dealer_list_length_ui}-1
    \       Run Keyword If    ${index} == 0    Should Be Equal As Strings    ${dealer_list_ui[${index}]}      iTrueMart
    \       ...    ELSE    TMVH Commission Report - Compare Dealer Value        ${dealer_list_ui[${index}]}     ${dealer_list_db[${index}-1][0]}

TMVH Commission Report - Compare Dealer Value
    [Arguments]     ${dealer_list_ui}       ${dealer_list_db}
    ${dealer_ui}=               Convert To Lowercase        ${dealer_list_ui}
    ${dealer_db}=               Convert To Lowercase        ${dealer_list_db}
    ${dealer_db_replace}=       Replace String              ${dealer_db}      _     ${SPACE}
    Should Be Equal As Strings      ${dealer_ui}       ${dealer_db_replace}

TMVH Commission Report - Check Dealer Default Value
    ${selected_merchant_value}=    Get Selected List Value         ${tmvh_commission_merchant_type}
    ${selected_merchant_label}=    Get Selected List Label         ${tmvh_commission_merchant_type}
    Should Be Equal As Strings    ${selected_merchant_value}    0
    Should Be Equal As Strings    ${selected_merchant_label}    iTrueMart
####################################################
# TMVH Commission Report - Input Search By Order ID
#     [Arguments]    ${order_id}
#     Wait Until Element Is Visible    ${tmvh_textbox_search_by_order}    30s
#     Input Text    ${tmvh_textbox_search_by_order}    ${order_id}

# TMVH Commission Report - Click Search Button On Order Tracker Page
#     Click Element    ${tmvh_button_search}

# TMVH Commission Report - Click View Shipment Detail
#     [Arguments]    ${order_id}
#     Wait Until Element Is Visible    jquery=a[href$='/orders/detail/${order_id}']    10s
#     Click Element    jquery=a[href$='/orders/detail/${order_id}']
#     Select Window    url=${PCMS_URL}/orders/detail/${order_id}
#     Wait Until Element Is Visible    ${tmvh_icon_truck}    10s

# TMVH Commission Report - Click Verify Thai ID
#     [Arguments]    ${order_id}
#     Wait Until Element Is Visible    jquery=a[href$='/truemoveh/verify?pcms_order_id=${order_id}']    10s
#     Click Element    jquery=a[href$='/truemoveh/verify?pcms_order_id=${order_id}']
#     Select Window    url=${PCMS_URL}/truemoveh/verify?pcms_order_id=${order_id}
#     Wait Until Element Is Visible    jquery=a[href$='/truemoveh/verify/display?pcms_order_id=${order_id}']    10s

# TMVH Verify Thai ID - Click Approve
#     Wait Until Element Is Visible    jquery=a[href$='/truemoveh/verify/success']    30s
#     Click Element    jquery=a[href$='truemoveh/verify/success']
#     Wait Until Element Is Visible    ${tmvh_confirm_ok}    15s
#     Click Element    ${tmvh_confirm_ok}
