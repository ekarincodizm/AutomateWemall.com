*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/xlsx_library.py
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/WebElement_MCH_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Merchant_Bar/Keywords_MCHBar.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Mass_Upload_Virtual_Stock.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/WebElement_MCH_Mass_Upload_Virtual_Stock.robot

*** Variables ***
${username_can_access}         phoenix_MD
${username_can_not_access}     phoenix_no
${password}                    12345
${error_message}               You don't have permission to access merchant center report.
${message_success_template}    Uploaded ??number?? SKU successfully

*** Test Cases ***
TC_ITMWM_06178 Mass upload to replace stock for sku: user can upload to replace virtual stock for sku - success
    [Tags]    TC_ITMWM_06178    regression    phoenix
    MCH Common - Open Merchant Center Page And Login    ${username_can_access}    ${password}
    MCH Common - Go To Merchant Center Report Page
    MCH Common - Upload stock menu is visible
    @{data_value1}=    Create List    ACAAA1114111    100
    @{data_value2}=    Create List    ACAAA1114211    200
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU         B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_data_value2}=    Create List    3    @{data_value2}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}    @{file_ver_data_value2}
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}
    [TearDown]    Run Keywords    MCH Mass Upload Virtual Stock - Roll Back Stock Sum For Each Sku    AND    Close All Browsers

TC_ITMWM_06179 Mass upload to replace stock for sku: user cannot upload to replace virtual stock for sku - success
    [Tags]     TC_ITMWM_06179    regression    phoenix
    MCH Common - Open Merchant Center Page And Login    ${username_can_not_access}    ${password}
    Element Should Not Be Visible    ${ReportMainBtn_locator}
    [TearDown]     Close All Browsers