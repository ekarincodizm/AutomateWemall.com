*** Settings ***
Library           Selenium2Library
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_registration.robot
Resource          ../../../../Resource/Config/${env}/env_config.robot

*** Keywords ***
Register New Account
    [Arguments]    ${Text_new_email}    ${Text_new_displayed_name}    ${Text_new_password}    ${ITM_URL}
    Open Browser    ${ITM_URL}/users/register    chrome
    Wait Until Element is ready and type    ${input_new_email}    ${Text_new_email}    20s
    Wait Until Element is ready and type    ${input_new_displayname}    ${Text_new_displayed_name}    20s
    Wait Until Element is ready and type    ${input_new_password}    ${Text_new_password}    20s
    Wait Until Element is ready and type    ${input_confirm_password}    ${Text_new_password}    20s
    Select Checkbox    ${checkbox_accept}
    Log To Console    ${Button_register}
    Wait Until Element is ready and click    ${Button_register}    60s
    ${Popup_displayed}    Run Keyword And Return Status    Element Should Be Visible    ${promotion_popup}
    Run Keyword If    ${Popup_displayed}    Close promotion popup
    Wait Until Element Is Visible    ${Assert_displayed_name}    60s
    ${displayed_name}    Get Text    ${Assert_displayed_name}
    Should Be Equal    ${displayed_name}    ${Text_new_displayed_name}

Close promotion popup
    Wait Until Element is ready and click    ${promotion_popup}    60s
