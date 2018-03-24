*** Settings ***
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot
Resource          ${CURDIR}/../../../Keyword/Features/Discount_campaign/crud_everyday_wow.robot
Suite Setup       Clear Data Before Campaign    ${campaingn_name_period}    ${campaingn_name_detail}
Suite Teardown    Close All Browsers

*** Variables ***
${campaingn_name_period}    POKEMON1
${campaingn_name_detail}    POKEMON2
${start_date}    2016-01-01 09:20
${end_date}    2019-01-01 19:55
${ex_start_date}    2016-01-01 09:20:00
${ex_end_date}    2019-01-01 19:55:00

*** Keywords ***
Clear Data Before Campaign
    [Arguments]    ${name_period}    ${name_detail}
    promotion.Remove Campaign    ${name_period}    1
    promotion.Remove Campaign    ${name_detail}    1

Delete Campaign By Campaign Name
    [Arguments]    ${name_campaign}
    promotion.Remove Campaign    ${name_campaign}    1

*** Test Cases ***

TC_ITMWM_05821 Create campaign and Change Period.
    [Tags]    regression
    Promotion - Create Campaign    ${campaingn_name_period}    No
    Click Element    jquery=tr:contains(${campaingn_name_period}) i.icon-edit
    Execute Javascript    document.getElementById('start_datepicker').value = '${start_date}';
    Execute Javascript    document.getElementById('end_datepicker').value = '${end_date}';
    Click Element    jquery=.mws-button-row input

    ${start_td}=    Get Text    jquery=tr:contains(${campaingn_name_period}) td:eq(4) div:eq(0)
    ${end_td}=    Get Text    jquery=tr:contains(${campaingn_name_period}) td:eq(4) div:eq(1)

    Should Be Equal        ${start_td}     ${ex_start_date}
    Should Be Equal        ${end_td}     ${ex_end_date}

    Click Element    jquery=tr:contains(${campaingn_name_period}) i.icon-edit
    ${ex_start}=    Get Value    jquery=#start_datepicker
    ${ex_end}=    Get Value    jquery=#end_datepicker
    Should Be Equal        ${start_td}     ${ex_start_date}
    Should Be Equal        ${end_td}     ${ex_end_date}

    Close All Browsers
    [Teardown]    Delete Campaign By Campaign Name    ${campaingn_name_period}

TC_ITMWM_05822 Edit period time of Edit Detail.
    [Tags]    regression
    Promotion - Create Campaign    ${campaingn_name_detail}    No
    Click Element    jquery=tr:contains(${campaingn_name_detail}) i.icon-edit
    Execute Javascript    document.getElementById('start_datepicker').value = '${start_date}';
    Execute Javascript    document.getElementById('end_datepicker').value = '${end_date}';
    Click Element    jquery=.mws-button-row input
    Click Element    jquery=tr:contains(${campaingn_name_detail}) i.icon-edit
    Click Element    jquery=.mws-form-item input[value='deactivate']
    Click Element    jquery=#start_datepicker
    ${text_start}=    Get Text    jquery=#ui-datepicker-div .ui_tpicker_time
    Click Element    jquery=#end_datepicker
    ${text_end}=    Get Text    jquery=#ui-datepicker-div .ui_tpicker_time
    Click Element    jquery=.mws-button-row input
    ${start_td}=    Get Text    jquery=tr:contains(${campaingn_name_detail}) td:eq(4) div:eq(0)
    ${end_td}=    Get Text    jquery=tr:contains(${campaingn_name_detail}) td:eq(4) div:eq(1)
    Should Be Equal        ${start_td}     ${ex_start_date}
    Should Be Equal        ${end_td}     ${ex_end_date}
    Should Be Equal        09:20     ${text_start}
    Should Be Equal        19:55     ${text_end}
    Close All Browsers
    [Teardown]    Delete Campaign By Campaign Name    ${campaingn_name_detail}

