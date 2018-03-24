*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           Selenium2Library    browser_breath_delay=2
Resource          WebElement_OrderItem_report.robot

*** Variables ***

*** Keywords ***
Input Text Into Order No Search Box
    [Arguments]    ${Text_OrderNumber}
    Selenium2Library.Wait Until Element Is Visible    ${Input_OrderNo_Textbox_locator}    20s
    Selenium2Library.Input Text    ${Input_OrderNo_Textbox_locator}    ${Text_OrderNumber}