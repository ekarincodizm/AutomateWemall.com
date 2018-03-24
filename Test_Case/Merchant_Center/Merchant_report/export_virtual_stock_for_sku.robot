*** Settings ***
Library          Selenium2Library
Library          ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Library          ${CURDIR}/../../../Python_Library/xlsx_library.py
Library          ${CURDIR}/../../../Python_Library/DatabaseData.py
Resource         ${CURDIR}/../../../Resource/init.robot
Resource         ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Common.robot
Resource         ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Merchant_Bar/Keywords_MCHBar.robot
Resource         ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Mass_Upload_Virtual_Stock.robot
Resource         ${CURDIR}/../../../Keyword/Portal/Merchant_Center/WebElement_MCH_Mass_Upload_Virtual_Stock.robot
# Test Setup       MCH Common - Open Merchant Center Page And Login    ${username_can_access}    ${password}
Test Teardown    Close All Browsers

*** Variables ***
${username_can_access}    phoenix
${password}               12345
${filename}    ${CURDIR}/../../../Resource/TestData/Merchant_center/Upload_stock/upload_stock_excel_template.xlsx

*** Test Cases ***
TC_ITMWM_06150 Mass upload to replace stock for sku: download template of Mass upload to replace stock for sku - success
    [Tags]     TC_ITMWM_06150    regression    phoenix
    MCH Common - Open Merchant Center Page And Login    ${username_can_access}    ${password}
    MCH Common - Go To Merchant Center Report Page
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page
    ${filename}=    Download template
    Check template is correctly    ${filename}