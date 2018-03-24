*** Settings ***
Resource          web_element_login.robot
Library           Selenium2Library


*** Keywords ***
Open Brower Point CMS Login Page
    Open Browser    ${POINT_URL}    ${BROWSER}

Login To Point CMS
    [Arguments]    ${username}=    ${password}=
    Open Brower Point CMS Login Page
    Wait Until Element Is Visible    ${point_textbox_username}    20s
    Wait Until Element Is Visible    ${point_textbox_password}    20s
    Input Text    ${point_textbox_username}    ${username}
    Input Text    ${point_textbox_password}    ${password}
    Click Element    ${point_btn_login}

Expect Log In Success
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${point_lable_accountUsername}    20s
    ${point_lable_accountUsername_value}=    Get Text    ${point_lable_accountUsername}
    Should Be Equal    ${point_lable_accountUsername_value}    ${username}

Expect Log In Not Input Username Or Password
    [Arguments]    ${msg_error}
    Wait Until Element Is Visible    ${msg_error_require_user_and_pass}    20s
    ${msg_error_none_user_and_pass_value}=    Get Text    ${msg_error_require_user_and_pass}
    Should Be Equal    ${msg_error_none_user_and_pass_value}    ${msg_error}

Expect Log In Incorrect Password
    [Arguments]    ${msg_error}
    Wait Until Element Is Visible    ${msg_error_incorrect_login}    20s
    ${msg_error_incorrect_login_value}=    Get Text    ${msg_error_incorrect_login}
    Should Be Equal    ${msg_error_incorrect_login_value}    ${msg_error}
