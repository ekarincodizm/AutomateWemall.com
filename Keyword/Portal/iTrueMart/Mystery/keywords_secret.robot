*** Settings ***
Resource    ${CURDIR}/web_element_secret.robot

*** Keywords ***
Mystery Secret - [Web] Open Secret Code Page
    Open Browser                ${ITM_URL}/mystery-begins/secret-code           ${BROWSER}
    Set Window Size             ${1500}          ${800}

Mystery Secret - [Web] Submit Code
    Wait Until Element Is Visible       ${MysterySecret_btn_submit}          15s
    Click Element                       ${MysterySecret_btn_submit}

Mystery Secret - [Web] Input Wrong Code
    Input Text      ${MysterySecret_input}      ${secret_code_false}
    Mystery Secret - [Web] Submit Code
    Wait Until Element Is Visible       ${MysterySecret_span_error_msg}          15s
    Element Should Be Visible           ${MysterySecret_span_error_msg}

Mystery Secret - [Web] Input Correct Code
    Input Text      ${MysterySecret_input}      ${var_mystery_secret_code}
    Mystery Secret - [Web] Submit Code
    Wait Until Element Is Visible       ${MysterySecret_code_detail}          15s
    Element Should Be Visible           ${MysterySecret_code_detail}