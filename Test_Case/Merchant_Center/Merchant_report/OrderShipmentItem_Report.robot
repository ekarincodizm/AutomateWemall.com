*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           Selenium2Library    browser_breath_delay=2
#Test Teardown     Selenium2Library.Close Browser
Resource          ${CURDIR}/../../../Resource/Config/alpha/Env_config.robot
Resource          ${CURDIR}/../../../Resource/Config/alpha/database.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Login/Keywords_loginMCHPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Merchant_Bar/Keywords_MCHBar.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Order_Item_Report/Keywords_OrderShipmentItem_Report.robot


*** Variables ***
${merchant_username}    Test
${merchant_password}    password


*** Test Cases ***
TEMPA
    [TAGS]    TEMPA
    ${MchReportOrderNo_Text}    Set Variable   3004457
    ${MchReportSkuName_Text}    Set Variable   Product
    ${MchReportSkuNumber_Text}    Set Variable   ACAAC1113511
    Selenium2Library.Open browser    ${LOGIN-PAGE}    chrome
    Log-in via MCH    ${merchant_username}    ${merchant_password}
    Go To Merchant Report FirstPage
    Input Text Into OrderNo SearchBox    ${MchReportOrderNo_Text}
    Input Text Into SkuName SearchBox    ${MchReportSkuName_Text}
    Input Text Into SkuNumber SearchBox    ${MchReportSkuNumber_Text}
    Search OrderShipmentItem