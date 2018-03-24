*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           Selenium2Library    browser_breath_delay=2
Resource          WebElement_OrderShipmentItem_Report.robot

*** Variables ***

*** Keywords ***
Input Text Into OrderNo SearchBox
    [Arguments]    ${MchReportOrderNo_Text}
    Selenium2Library.Wait Until Element Is Visible    ${MchReportOrderNo_Locator}    20s
    Selenium2Library.Input Text    ${MchReportOrderNo_Locator}    ${MchReportOrderNo_Text}

Input Text Into SkuName SearchBox
    [Arguments]    ${MchReportSkuName_Text}
    Selenium2Library.Wait Until Element Is Visible    ${MchReportSkuName_Locator}    20s
    Selenium2Library.Input Text    ${MchReportSkuName_Locator}    ${MchReportSkuName_Text}

Input Text Into SkuNumber SearchBox
    [Arguments]    ${MchReportSkuNumber_Text}
    Selenium2Library.Wait Until Element Is Visible    ${MchReportSkuNumber_Locator}    20s
    Selenium2Library.Input Text    ${MchReportSkuNumber_Locator}    ${MchReportSkuNumber_Text}

Input Text Into TrackingNumber SearchBox
    [Arguments]    ${MchReportTrackingNumber_Text}
    Selenium2Library.Wait Until Element Is Visible    ${MchReportTrackingNumber_Locator}    20s
    Selenium2Library.Input Text    ${MchReportTrackingNumber_Locator}    ${MchReportTrackingNumber_Text}

Search OrderShipmentItem
    Selenium2Library.Click Element    ${MchReportSearchBtn_Locator}