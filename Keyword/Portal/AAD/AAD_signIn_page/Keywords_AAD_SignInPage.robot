*** Settings ***
Library           Selenium2Library
Resource          ../../../../Resource/Env_config.robot
Library           String
Resource          ../../../../Resource/WebElement/ADD/User_List.robot
Resource          ../../../../Resource/WebElement/ADD/Login_Page.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_AAD_SignInPage.robot

*** Keywords ***
AAD Login
    [Arguments]    ${Input_Username}    ${Input_Password}
    Wait Until Element is ready and type    ${Username}    ${Input_Username}    10
    Wait Until Element Is Visible    ${Password}    5
    Input Password    ${Password}    ${Input_Password}
    Click Button    ${SignIn_bttn}

Assert AAD sigin error message
    [Arguments]    ${error_message}
    Wait Until Element Is Visible    ${SignIn_error_message}
    ${actaul}    Get Text    ${SignIn_error_message}
    Should Be Equal    ${actaul.trim}    ${error_message.trim}
