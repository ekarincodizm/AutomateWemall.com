*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../Resource/Env_config.robot
Resource          ../../Common/Keywords_Common.robot
Resource          ../../../Resource/WebElement/MerchantCenter/Login_page.robot

*** Keywords ***
Login Merchant center
    [Arguments]    ${usrname}    ${password}
    Comment    sleep    5
    Wait Until Element is ready and type    ${username_inputbox}    ${usrname}    15
    Wait Until Element is ready and type    ${password_inputbox}    ${password}    15
    Wait Until Element is ready and click    ${login_btn}    5

Assert Merchant center sigin error message
    [Arguments]    ${error_message}
    Wait Until Element Is Visible    ${login_error_message}
    ${actaul}    Get Text    ${login_error_message}
    Should Be Equal    ${actaul.strip()}    ${error_message.strip()}
