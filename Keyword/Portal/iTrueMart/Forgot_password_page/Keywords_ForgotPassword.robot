*** Settings ***
Library           Selenium2Library
Resource          WebElement_LoginPage.robot

*** Variables ***

*** Keywords ***
Go To Forgot Password Page
    Wait Until Element Is Visible    ${ForgotPassword_LoginPge_locator}    20s
    Click Element    ${ForgotPassword_LoginPge_locator}
