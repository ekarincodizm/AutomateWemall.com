*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           Selenium2Library    browser_breath_delay=2
Resource          WebElement_LoginMCHPage.robot

*** Variables ***

*** Keywords ***
Log-in via MCH
    [Arguments]    ${merchant_username}    ${merchant_password}
    Selenium2Library.Wait Until Element Is Visible    ${username_locator}
    Selenium2Library.Input Text    ${username_locator}    ${merchant_username}
    Selenium2Library.Input Text    ${password_locator}    ${merchant_password}
    Selenium2Library.Click Element    ${loginBtn_locator}