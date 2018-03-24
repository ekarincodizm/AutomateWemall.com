*** Settings ***
Resource          ${CURDIR}/web_element_login.robot
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/env_config.robot
Library           Selenium2Library

*** Keywords ***
Login Pcms
    [Arguments]    ${Text_Email}=${PCMS_USERNAME}    ${Text_Password}=${PCMS_PASSWORD}
    Open Browser    ${PCMS_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${xpath-login-email}
    Input Text    ${xpath-login-email}    ${Text_Email}
    Input Text    ${xpath-login-password}    ${Text_Password}
    Click Element    ${xpath-login-button}
    Wait Until Element Is Visible    ${xpath-link-logout}    30s

Logout Pcms
    Go To    ${PCMS_URL}/auth/logout
    #    Wait Until Element Is Visible    ${xpath-link-logout}    30s
    #    Click Element    ${xpath-link-logout}

Get display name in top menu
    ${text_display_name}=    Set Variable    //*[@id="mws-username"]
    ${get_text_display_name}=    Get Text    ${text_display_name}
    ${display_name_top_bar}=    Replace String    ${get_text_display_name}    Hello,    ${EMPTY}
    ${display_name_top_bar_strip} =    Strip String    ${display_name_top_bar}
    Log To Console    user top bar=${display_name_top_bar_strip}
    [Return]    ${display_name_top_bar_strip}

Login Pcms Browser Existing
    [Arguments]    ${Text_Email}=${PCMS_USERNAME}    ${Text_Password}=${PCMS_PASSWORD}
    Go To    ${PCMS_URL}
    Maximize Browser Window
    Wait Until Element Is Visible    ${xpath-login-email}
    Input Text    ${xpath-login-email}    ${Text_Email}
    Input Text    ${xpath-login-password}    ${Text_Password}
    Click Element    ${xpath-login-button}
    Wait Until Element Is Visible    ${xpath-link-logout}    30s