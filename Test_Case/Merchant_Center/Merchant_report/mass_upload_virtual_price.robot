*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           DateTime
Library           String
Library           BuiltIn
Library           ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/xlsx_library.py
Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Price/keywords_price.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/WebElement_MCH_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Mass_Upload_Virtual_Price.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/WebElement_MCH_Mass_Upload_Virtual_Stock.robot
Test Teardown     Close All Browsers

## Should add keyword to re-stock for test sku in tear down step

*** Variables ***
@{MD_skus}         PRAAF1115811    PRAAF1115711    PRAAF1115611
@{FAIL_skus}         Z1Z2Z7    Z1Z2Z8    Z1Z2Z9
@{CAMP_FAIL_skus}         TRAAA1111411    TRAAA1111811


${message_success_template}       Uploaded ??number?? SKU successfully
${message_fail_template}          ??number?? row(s) failed
${invalid_header}              Invalid Header
${choose_file}                 Please choose file to upload
${invalid_file_format}         Invalid file format
${wait_time}    40

*** Test Cases ***
TC_ITMWM_07410
    [Documentation]    Mass upload to update price for sku: update price to multiple sku via mass upload - success
    [tags]    Regression
    Go To Mass Upload Price
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    500.00    400.00
    @{data_value2}=    Create List    @{MD_skus}[1]    400.00    300.00
    @{data_value3}=    Create List    @{MD_skus}[2]    300.00    200.00
    Sleep    5
    Wait Until Element Is Visible    //*[@id="uploadPrice"]/a    ${wait_time}
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    Normal price                  C1    Special price
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]             C2    @{data_value1}[2]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]             C3    @{data_value2}[2]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]             C4    @{data_value3}[2]
    ${full_path_file}=    MCH Mass Upload Virtual Price - Set SKU and Price in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Price - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Price - Click Upload Button

    # ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Price - Verify Alert For File Verification Result    ${message_success}

    # # ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    ...   2    @{data_value1}    success
    ...   3    @{data_value2}    success
    ...   4    @{data_value3}    success
    MCH Mass Upload Virtual Price - Verify File Verification Result    ${file_ver_result}

    # # ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Price - Verify Price From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Price - Verify Price From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Price - Verify Price From PCMS Remaining API    @{data_value3}

    Click Element    //*[@id="uploadPriceHistory"]/a
    Sleep    2
    Wait Until Element Is Visible    //*[@id="file-review-table"]/tbody/tr[1]    ${wait_time}
    Element Should Contain    //*[@id="file-review-table"]/tbody/tr[1]/td[2]    mass_upload_virtual_price.xlsx
    Wait Until Element Is Visible    //*[@id="file-review-table"]/tbody/tr[1]/td[2]/a    ${wait_time}
    Click Element    //*[@id="file-review-table"]/tbody/tr[1]/td[2]/a
    # ${arr_data}=    Execute Javascript  return $('tbody tr td a').eq(0).attr('href').split('/')
    # ${key}=    Execute Javascript  return $('tbody tr td a').eq(0).attr('href').split('/').length-1
    # ${history_file_name}=    Set Variable    @{arr_data}[${key}]
    # ${history_file_name}=    Replace String    ${history_file_name}    "    ${EMPTY}
    # ${sheet_history}=    Read Price In History    C:\Downloads\${history_file_name}
    # MCH Mass Upload Virtual Price - Verify File Verification Result From History File    ${sheet_history}

TC_ITMWM_07412
    [Documentation]    Mass upload to update price for sku: update special price less than normal price to sku via mass upload - success
    [tags]    Regression
    Go To Mass Upload Price
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    400.44    300.33
    @{data_value2}=    Create List    @{MD_skus}[1]    300.33    200.22
    @{data_value3}=    Create List    @{MD_skus}[2]    200.22    100.11
    Sleep    5
    Wait Until Element Is Visible    //*[@id="uploadPrice"]/a    ${wait_time}
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

    # ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    Normal price                  C1    Special price
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]             C2    @{data_value1}[2]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]             C3    @{data_value2}[2]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]             C4    @{data_value3}[2]
    ${full_path_file}=    MCH Mass Upload Virtual Price - Set SKU and Price in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Price - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Price - Click Upload Button

    # ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Price - Verify Alert For File Verification Result    ${message_success}

    # # ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    ...   2    @{data_value1}    success
    ...   3    @{data_value2}    success
    ...   4    @{data_value3}    success
    MCH Mass Upload Virtual Price - Verify File Verification Result    ${file_ver_result}

    # # ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Price - Verify Price From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Price - Verify Price From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Price - Verify Price From PCMS Remaining API    @{data_value3}

    Click Element    //*[@id="uploadPriceHistory"]/a
    Sleep    2
    Wait Until Element Is Visible    //*[@id="file-review-table"]/tbody/tr[1]    ${wait_time}
    Element Should Contain    //*[@id="file-review-table"]/tbody/tr[1]/td[2]    mass_upload_virtual_price.xlsx
    Wait Until Element Is Visible    //*[@id="file-review-table"]/tbody/tr[1]/td[2]/a    ${wait_time}
    Click Element    //*[@id="file-review-table"]/tbody/tr[1]/td[2]/a
    # ${arr_data}=    Execute Javascript  return $('tbody tr td a').eq(0).attr('href').split('/')
    # ${key}=    Execute Javascript  return $('tbody tr td a').eq(0).attr('href').split('/').length-1
    # ${history_file_name}=    Set Variable    @{arr_data}[${key}]
    # ${history_file_name}=    Replace String    ${history_file_name}    "    ${EMPTY}
    # ${sheet_history}=    Read Price In History    C:\Downloads\${history_file_name}
    # MCH Mass Upload Virtual Price - Verify File Verification Result From History File    ${sheet_history}


TC_ITMWM_07418
    [Documentation]    Mass upload to update price for sku: sku was deleted - fail
    [tags]    Regression
    Go To Mass Upload Price
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{FAIL_skus}[0]    400.44    300.33
    @{data_value2}=    Create List    @{FAIL_skus}[1]    300.33    200.22
    @{data_value3}=    Create List    @{FAIL_skus}[2]    200.22    100.11
    Sleep    5
    Wait Until Element Is Visible    //*[@id="uploadPrice"]/a    ${wait_time}
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

    # ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    Normal price                  C1    Special price
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]             C2    @{data_value1}[2]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]             C3    @{data_value2}[2]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]             C4    @{data_value3}[2]
    ${full_path_file}=    MCH Mass Upload Virtual Price - Set SKU and Price in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Price - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Price - Click Upload Button

    # ##.. Verify message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Price - Verify Alert For File Verification Result    ${message_fail}

    # # ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    ...   2    @{data_value1}    SKU does not exist in merchant owner
    ...   3    @{data_value2}    SKU does not exist in merchant owner
    ...   4    @{data_value3}    SKU does not exist in merchant owner
    MCH Mass Upload Virtual Price - Verify File Verification Result    ${file_ver_result}

TC_ITMWM_07429
    [Documentation]    Mass upload to update price for sku: normal price equal to special price to sku via mass upload - fail
    [tags]    Regression
    Go To Mass Upload Price
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{FAIL_skus}[0]    400.44    400.44
    @{data_value2}=    Create List    @{FAIL_skus}[1]    300.33    300.33
    @{data_value3}=    Create List    @{FAIL_skus}[2]    200.22    200.22
    Sleep    5
    Wait Until Element Is Visible    //*[@id="uploadPrice"]/a    ${wait_time}
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

    # ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    Normal price                  C1    Special price
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]             C2    @{data_value1}[2]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]             C3    @{data_value2}[2]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]             C4    @{data_value3}[2]
    ${full_path_file}=    MCH Mass Upload Virtual Price - Set SKU and Price in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Price - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Price - Click Upload Button

    # ##.. Verify message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Price - Verify Alert For File Verification Result    ${message_fail}

    # # ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    ...   2    @{data_value1}    Normal price should be greater than Special price
    ...   3    @{data_value2}    Normal price should be greater than Special price
    ...   4    @{data_value3}    Normal price should be greater than Special price
    MCH Mass Upload Virtual Price - Verify File Verification Result    ${file_ver_result}

TC_ITMWM_07433
    [Documentation]    Mass upload to update price for sku: special price is zero - fail
    [tags]    Regression
    Go To Mass Upload Price
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{FAIL_skus}[0]    400.44    0
    @{data_value2}=    Create List    @{FAIL_skus}[1]    300.33    0
    @{data_value3}=    Create List    @{FAIL_skus}[2]    200.22    0
    Sleep    5
    Wait Until Element Is Visible    //*[@id="uploadPrice"]/a    ${wait_time}
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

    # ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    Normal price                  C1    Special price
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]             C2    @{data_value1}[2]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]             C3    @{data_value2}[2]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]             C4    @{data_value3}[2]
    ${full_path_file}=    MCH Mass Upload Virtual Price - Set SKU and Price in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Price - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Price - Click Upload Button

    # ##.. Verify message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Price - Verify Alert For File Verification Result    ${message_fail}

    # # ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    ...   2    @{data_value1}    Special Price should be greater than zero
    ...   3    @{data_value2}    Special Price should be greater than zero
    ...   4    @{data_value3}    Special Price should be greater than zero
    MCH Mass Upload Virtual Price - Verify File Verification Result    ${file_ver_result}

TC_ITMWM_07414
    [Documentation]    Mass upload to update price for sku incase sku have campaign price active: update special price equal to campain price to sku via mass upload - fail
    [tags]    Regression
    Go To Mass Upload Price
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{CAMP_FAIL_skus}[0]    ${EMPTY}    903
    Sleep    5
    Wait Until Element Is Visible    //*[@id="uploadPrice"]/a    ${wait_time}
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

    # ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    Normal price                  C1    Special price
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]             C2    @{data_value1}[2]
    ${full_path_file}=    MCH Mass Upload Virtual Price - Set SKU and Price in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Price - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Price - Click Upload Button

    # ##.. Verify message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Price - Verify Alert For File Verification Result    ${message_fail}

    # # ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    ...   2    @{data_value1}    Cannot update, SKU in campaign
    MCH Mass Upload Virtual Price - Verify File Verification Result    ${file_ver_result}

TC_ITMWM_07415
    [Documentation]    Mass upload to update price for sku incase sku have campaign price active: update special price more than campain price to sku via mass upload - fail
    [tags]    Regression
    Go To Mass Upload Price
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{CAMP_FAIL_skus}[1]    1200    800
    Sleep    5
    Wait Until Element Is Visible    //*[@id="uploadPrice"]/a    ${wait_time}
    Click Element    //*[@id="uploadPrice"]/a
    Wait Until Page Contains Element    ${upload_button}    ${wait_time}

    # ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Price - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    Normal price                  C1    Special price
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]             C2    @{data_value1}[2]
    ${full_path_file}=    MCH Mass Upload Virtual Price - Set SKU and Price in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Price - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Price - Click Upload Button

    # ##.. Verify message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Price - Verify Alert For File Verification Result    ${message_fail}

    # # ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Price - Generate Expected Result for Verification
    ...   2    @{data_value1}    Cannot update, SKU in campaign
    MCH Mass Upload Virtual Price - Verify File Verification Result    ${file_ver_result}


