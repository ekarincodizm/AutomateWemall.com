*** Settings ***
Library           Selenium2Library
Resource          WebElement_RegisterPage.robot

*** Variables ***

*** Keywords ***
Go to register page
    Wait Until Element Is Visible    ${Register_mainpage_regisPge}    20s
    Click Element    ${Register_mainpage_regisPge}

Display Register Page
    Wait Until Element Is Visible   ${form_register}
    Element Should Be Visible       ${form_register}

Enter register information
    [Arguments]    ${Text_Username}    ${Text_Displayname}    ${Text_Password}    ${Text_ConfirmPassword}
    Wait Until Element Is Visible    ${Input_username_regisPge}    20s
    Input Text    ${Input_username_regisPge}    ${Text_Username}
    Input Text    ${Input_displayname_regisPge}    ${Text_Displayname}
    Input Text    ${Input_password_regisPge}    ${Text_Password}
    Input Text    ${Input_confirmpassword_regisPge}    ${Text_ConfirmPassword}

Check on aeccept criteria checkbok
    Wait Until Element Is Visible    ${Checkbox_accept_regisPge}    20s
    Click Element    ${Checkbox_accept_regisPge}

Click submit registration
    Wait Until Element Is Visible    ${Submit_register_regisPge}    20s
    Click Element    ${Submit_register_regisPge}

Click popup OK
    Wait Until Element Is Visible    ${btn_popup_ok}    20s
    Click Element    ${btn_popup_ok}

Click Register TrueID user on LoginPage
    Wait Until Element Is Visible    ${RegisterBtn_loginPge}    20s
    Click Element    ${RegisterBtn_loginPge}

Get Error message from PopupMessage
    Wait Until Element Is Visible    ${PopupMessage_RegisPge}    20s
    ${errorMessage}=    Get Text    ${PopupMessage_RegisPge}
    Return from Keyword    ${errorMessage}
