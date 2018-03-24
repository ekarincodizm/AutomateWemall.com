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
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Order_Item_Report/Keywords_OrderItem_Report.robot
Resource          ../../../Keyword/API/FMS/keywords_fms_create_supplier.robot
Resource          ../../../Keyword/API/FMS/FMS_Create_SKU.robot


*** Variables ***
${merchant_username}    Test
${merchant_password}    password


*** Test Cases ***
TEMPTEN
    [TAGS]    TEMPTEN
    ${supplier_code}    Set Variable    TH3492
    ${SKUName}    Set Variable    THANOSPRODUCT2
    ${BrandCode}    Set Variable    APAAA
    FMS create sku with marketplace     ${supplier_code}    ${SKUName}    ${BrandCode}

TEMPX
    [TAGS]    TEMPX
    Selenium2Library.Open browser    ${LOGIN-PAGE}    chrome
    Log-in via MCH    ${merchant_username}    ${merchant_password}
    Go To Merchant Report FirstPage

TEMPA
    [TAGS]    TEMPA
    ${Text_OrderNumber}    Set Variable   1234
    Selenium2Library.Open browser    ${LOGIN-PAGE}    chrome
    Log-in via MCH    ${merchant_username}    ${merchant_password}
    Go To Merchant Report FirstPage
    Input Text Into Order No Search Box    ${Text_OrderNumber}