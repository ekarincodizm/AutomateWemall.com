*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           Selenium2Library    browser_breath_delay=2
Resource          WebElement_MCHBar.robot

*** Variables ***

*** Keywords ***
Check user details on MCH top bar
    [Arguments]    ${merchant_firstname1}    ${merchant_lastname1}    ${shopname1}
    Selenium2Library.Wait Until Element Is Visible    ${displayname_locator}    30s
    Selenium2Library.Element Should Contain    ${displayname_locator}    ${merchant_firstname1} ${merchant_lastname1}
    Selenium2Library.Wait Until Element Is Visible    ${currentShopname_locator}    30s
    Selenium2Library.Element Should Contain    ${currentShopname_locator}    ${shopname1}

Check if button should be invisible
    [Arguments]    ${button1}    ${button2}    ${button3}
    Run Keyword If    '${button1}'=='${test1_locator}'    Element Should Not Be Visible    ${test1_locator}
    ...    ELSE IF    '${button1}'=='${test2_locator}'    Element Should Not Be Visible    ${test2_locator}
    ...    ELSE IF    '${button1}'=='${administration_locator}'    Element Should Not Be Visible    ${administration_locator}
    Run Keyword If    '${button2}'=='${test1_locator}'    Element Should Not Be Visible    ${test1_locator}
    ...    ELSE IF    '${button2}'=='${test2_locator}'    Element Should Not Be Visible    ${test2_locator}
    ...    ELSE IF    '${button2}'=='${administration_locator}'    Element Should Not Be Visible    ${administration_locator}
    Run Keyword If    '${button3}'=='${test1_locator}'    Element Should Not Be Visible    ${test1_locator}
    ...    ELSE IF    '${button3}'=='${test2_locator}'    Element Should Not Be Visible    ${test2_locator}
    ...    ELSE IF    '${button3}'=='${administration_locator}'    Element Should Not Be Visible    ${administration_locator}

Go To Merchant Report FirstPage
    Selenium2Library.Wait Until Element Is Visible   ${ReportMainBtn_locator}
    Selenium2Library.Click Element   ${ReportMainBtn_locator}
    Selenium2Library.Wait Until Element Is Visible   ${MCHReport_submenu_locator}
    Selenium2Library.Click Element   ${MCHReport_submenu_locator}