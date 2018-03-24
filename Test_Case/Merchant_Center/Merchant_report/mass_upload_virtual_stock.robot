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
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/WebElement_MCH_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Keywords_MCH_Mass_Upload_Virtual_Stock.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/WebElement_MCH_Mass_Upload_Virtual_Stock.robot
Test Teardown     Run Keywords    MCH Mass Upload Virtual Stock - Roll Back Stock Sum For Each Sku    AND    Close All Browsers

## Should add keyword to re-stock for test sku in tear down step

*** Variables ***
${MD_username}     phoenix_MD
${MD_password}     12345
@{MD_skus}         ACAAA1114111    ACAAA1114211    ACAAA1114311

${MX_username}     phoenix_MX
${MX_password}     12345
@{MX_skus}         ACAAA1114411    ACAAA1114511    ACAAA1114611

${MIX_username}    phoenix_MIX
${MIX_password}    12345
@{MIX_skus}        ACAAA1114811    ACAAA1114911

${MF_username}    phoenix_MF
${MF_password}    12345
@{MF_skus}        ACAAA1114711

${RX_username}    phoenix_RX
${RX_password}    12345
@{RX_skus}        ACAAA1115111

${CT_username}    phoenix_CT
${CT_password}    12345
@{CT_skus}        ACAAA1115211

${not_existed_sku}    AAAAA1110111
${deleted_sku}        QQAAA1112411

${message_success_template}       Uploaded ??number?? SKU successfully
${message_fail_template}          ??number?? row(s) failed
${invalid_header}              Invalid Header
${choose_file}                 Please choose file to upload
${invalid_file_format}         Invalid file format

*** Test Cases ***
TC_ITMWM_06151 Mass upload to replace stock for sku: replace stock to multiple sku via mass upload - success
    [tags]    TC_ITMWM_06151    regression    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    100
    @{data_value2}=    Create List    @{MD_skus}[1]    200
    @{data_value3}=    Create List    @{MD_skus}[2]    300
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   3    @{data_value2}    Success
    ...   4    @{data_value3}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}

TC_ITMWM_06152 Mass upload to replace stock for sku: replace stock more than hold stock to sku via mass upload - success
    [tags]    TC_ITMWM_06152    regression    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Get Hold stock for each sku
    ##.. Prepare new stock value to be more than hold stock value
    ##.. Create test data for test case
    @{data_value_list}=    Create List
    ${loop_num}=    Set Variable    0
    :FOR    ${sku_item}    IN    @{MD_skus}
    \    ${loop_num}=    Evaluate    ${loop_num} + 1
    \    ${hold_sku}=    MCH Mass Upload Virtual Stock - Get Hold Stock From PCMS Remaining API    ${sku_item}
    \    ${new_stock_sku}=    Evaluate    ${hold_sku} + (${loop_num}*10)
    \    ${data_value}=    Create List    ${sku_item}    ${new_stock_sku}
    \    Append To List    ${data_value_list}    ${data_value}
    @{data_value1}=    Get From List    ${data_value_list}    0
    @{data_value2}=    Get From List    ${data_value_list}    1
    @{data_value3}=    Get From List    ${data_value_list}    2
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   3    @{data_value2}    Success
    ...   4    @{data_value3}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}

TC_ITMWM_06153 Mass upload to replace stock for sku: replace stock equal to hold stock to sku via mass upload - success
    [tags]    TC_ITMWM_06153    regression    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Get Hold stock for each sku
    ##.. Prepare new stock value to be equal to hold stock value
    ##.. Create test data for test case
    @{data_value_list}=    Create List
    :FOR    ${sku_item}    IN    @{MD_skus}
    \    ${hold}=    MCH Mass Upload Virtual Stock - Get Hold Stock From PCMS Remaining API    ${sku_item}
    \    ${new_stock_sku}=    Set Variable    ${hold}
    \    ${data_value}=    Create List    ${sku_item}    ${new_stock_sku}
    \    Append To List    ${data_value_list}    ${data_value}
    @{data_value1}=    Get From List    ${data_value_list}    0
    @{data_value2}=    Get From List    ${data_value_list}    1
    @{data_value3}=    Get From List    ${data_value_list}    2
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   3    @{data_value2}    Success
    ...   4    @{data_value3}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}

TC_ITMWM_06154 Mass upload to replace stock for sku: replace stock to multiple sku 200 records - success
    [tags]    TC_ITMWM_06154
    Log    None
    [Teardown]    Log    No Teardown

TC_ITMWM_06155 Mass upload to replace stock for sku: Space in the field - success
    [tags]    TC_ITMWM_06155    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    100
    @{data_value2}=    Create List    @{MD_skus}[1]    200
    @{data_value3}=    Create List    @{MD_skus}[2]    300
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                                  B1    QTY
    ...   A2    @{data_value1}[0]${SPACE}            B2    @{data_value1}[1]${SPACE}
    ...   A3    ${SPACE}@{data_value2}[0]            B3    ${SPACE}@{data_value2}[1]
    ...   A4    ${SPACE}@{data_value3}[0]${SPACE}    B4    ${SPACE}@{data_value3}[1]${SPACE}
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   3    @{data_value2}    Success
    ...   4    @{data_value3}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}

TC_ITMWM_06156 Mass upload to replace stock for sku: sku with multiple source types - success
    [tags]    TC_ITMWM_06156    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MIX_username}    ${MIX_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MIX_skus}[0]    100
    @{data_value2}=    Create List    @{MIX_skus}[1]    200
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   3    @{data_value2}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}

TC_ITMWM_06157 Mass upload to replace stock for sku: header is case in-sensitive - success
    [tags]    TC_ITMWM_06157    regression    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ###### excel file 1 ######
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    100
    @{data_value2}=    Create List    @{MD_skus}[1]    200
    @{data_value3}=    Create List    @{MD_skus}[2]    300
    ###### excel file 2 ######
    ##.. Create test data for test case
    @{data_value4}=    Create List    @{MX_skus}[0]    100
    @{data_value5}=    Create List    @{MX_skus}[1]    200
    @{data_value6}=    Create List    @{MX_skus}[2]    300
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]
    ...    @{data_value4}[0]    @{data_value5}[0]    @{data_value6}[0]

    ###### excel file 1 ######
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page
    
    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    sku                  B1    qty
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   3    @{data_value2}    Success
    ...   4    @{data_value3}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}

    ##.. Click Close File Verification
    # MCH Mass Upload Virtual Stock - Click Close Button

    MCH Common - Open Merchant Center Page And Login    ${MX_username}    ${MX_password}
    MCH Common - Go To Merchant Center Report Page

    ###### excel file 2 ######
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    Sku                  B1    qTy
    ...   A2    @{data_value4}[0]    B2    @{data_value4}[1]
    ...   A3    @{data_value5}[0]    B3    @{data_value5}[1]
    ...   A4    @{data_value6}[0]    B4    @{data_value6}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value4}    Success
    ...   3    @{data_value5}    Success
    ...   4    @{data_value6}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value4}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value5}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value6}

TC_ITMWM_06158 Mass upload to replace stock for sku: Number format for stock field - success
    [tags]    TC_ITMWM_06158
    Log    None
    [Teardown]    Log    No Teardown

TC_ITMWM_06159 Mass upload to replace stock for sku: multiple tab sheet in excel - success
    [tags]    TC_ITMWM_06159
    Log    None
    [Teardown]    Log    No Teardown

TC_ITMWM_06160 Mass upload to replace stock for sku: stock zero - success
    [tags]    TC_ITMWM_06160    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MX_username}    ${MX_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MX_skus}[0]    0
    @{data_value2}=    Create List    @{MX_skus}[1]    0
    @{data_value3}=    Create List    @{MX_skus}[2]    0
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   3    @{data_value2}    Success
    ...   4    @{data_value3}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}

TC_ITMWM_06161 Mass upload to replace stock for sku: empty row - success
    [tags]    TC_ITMWM_06161    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MX_username}    ${MX_password}
    MCH Common - Go To Merchant Center Report Page

    ###### excel file 1 ######
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MX_skus}[0]    100
    @{data_value2}=    Create List    @{MX_skus}[1]    1000
    ###### excel file 2 ######
    ##.. Create test data for test case
    @{data_value3}=    Create List    @{MX_skus}[0]    200
    @{data_value4}=    Create List    @{MX_skus}[1]    2000
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]    @{data_value4}[0]

    ###### excel file 1 ######
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A4    @{data_value2}[0]    B4    @{data_value2}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Success
    ...   4    @{data_value2}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}

    ##.. Click Close File Verification
    # MCH Mass Upload Virtual Stock - Click Close Button

    MCH Common - Open Merchant Center Page And Login    ${MX_username}    ${MX_password}
    MCH Common - Go To Merchant Center Report Page

    ###### excel file 2 ######
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A3    @{data_value3}[0]    B3    @{data_value3}[1]
    ...   A4    @{data_value4}[0]    B4    @{data_value4}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_success}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   3    @{data_value3}    Success
    ...   4    @{data_value4}    Success
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value4}

TC_ITMWM_06162 Mass upload to replace stock for sku: Replace stock less than hold stock to sku - fail
    [tags]    TC_ITMWM_06162    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Get Hold stock for each sku
    ##.. Prepare new stock value to be less than hold stock value
    ##.. Create test data for test case
    ${hold}=    MCH Mass Upload Virtual Stock - Get Hold Stock From PCMS Remaining API    @{MD_skus}[2]
    ${new_stock_sku}=    Evaluate    ${hold} - 1
    @{data_value1}=    Create List    @{MD_skus}[2]    ${new_stock_sku}

    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Stock should be greater or equal than stock hold
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value1}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}[0]    ${stock_value}

TC_ITMWM_06163 Mass upload to replace stock for sku: Replace stock to sku more than 200 records - fail
    [tags]    TC_ITMWM_06163
    Log    None
    [Teardown]    Log    No Teardown

TC_ITMWM_06164 Mass upload to replace stock for sku: sku without supported marketplace source types - fail
    [tags]    TC_ITMWM_06164    phoenix    ready
    ##### Source Type is MF #####
    MCH Common - Open Merchant Center Page And Login    ${MF_username}    ${MF_password}
    MCH Common - Go To Merchant Center Report Page
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MF_skus}[0]    100
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page
    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}
    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button
    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}
    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Support marketplace source type MX, MD only
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##### Source Type is CT #####
    MCH Common - Open Merchant Center Page And Login    ${CT_username}    ${CT_password}
    MCH Common - Go To Merchant Center Report Page
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{CT_skus}[0]    100
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page
    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}
    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button
    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}
    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Support marketplace source type MX, MD only
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##### Source Type is RX #####
    MCH Common - Open Merchant Center Page And Login    ${RX_username}    ${RX_password}
    MCH Common - Go To Merchant Center Report Page
    ##.. Create test data for test case
    @{data_value1}=    Create List    @{RX_skus}[0]    100
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page
    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}
    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button
    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}
    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Support marketplace source type MX, MD only
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    [Teardown]    Close All Browsers

TC_ITMWM_06165 Mass upload to replace stock for sku: sku does not exist in system or sku was deleted - fail
    [tags]    TC_ITMWM_06165    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    ${not_existed_sku}    100
    @{data_value2}=    Create List    ${deleted_sku}        100

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Sku does not exist in merchant owner
    ...   3    @{data_value2}    Sku does not exist in merchant owner

    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    [Teardown]    Close All Browsers

TC_ITMWM_06166 Mass upload to replace stock for sku: no header - fail
    [Tags]    TC_ITMWM_06166    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##..1 Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A2    @{MD_skus}[0]    B2    100

    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    Click Element    ${upload_button}

    ##.. Verify message fail
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${invalid_header}

    [Teardown]    Close All Browsers

TC_ITMWM_06167 Mass upload to replace stock for sku: header is invalid - fail
    [Tags]     TC_ITMWM_06167    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##..1 Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    key              B1    number
    ...   A2    @{MD_skus}[0]    B2    100

    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    Click Element    ${upload_button}

    ##.. Verify message fail
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${invalid_header}

    ##..2 Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    ${SPACE}         B1    ${SPACE}
    ...   A2    @{MD_skus}[0]    B2    100

    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    Click Element    ${upload_button}

    ##.. Verify message fail
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${invalid_header}

    [Teardown]    Close All Browsers

TC_ITMWM_06168 Mass upload to replace stock for sku: not input sku - fail
    [Tags]     TC_ITMWM_06168    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##..1 Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU          B1    QTY
    ...   B2    100

    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    Click Element    ${upload_button}

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    ${EMPTY}    100    Missing Sku
    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    [Teardown]    Close All Browsers

TC_ITMWM_06169 Mass upload to replace stock for sku: not input quantity - fail
    [tags]    TC_ITMWM_06169    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    ${EMPTY}
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Missing Stock

    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value1}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}[0]    ${stock_value}

    [Teardown]    Close All Browsers

TC_ITMWM_06170 Mass upload to replace stock for sku: sku does not exist in merchant owner - fail
    [tags]    TC_ITMWM_06170    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MX_skus}[0]    100
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Sku does not exist in merchant owner

    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value1}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}[0]    ${stock_value}

    [Teardown]    Close All Browsers

TC_ITMWM_06171 Mass upload to replace stock for sku: stock negative - fail
    [tags]    TC_ITMWM_06171    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    -10
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Stock cannot be negative

    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value1}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}[0]    ${stock_value}

    [Teardown]    Close All Browsers

TC_ITMWM_06172 Mass upload to replace stock for sku: stock not integer - fail
    [tags]    TC_ITMWM_06172    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MD_skus}[0]    \'1000
    @{data_value2}=    Create List    @{MD_skus}[1]    3k
    @{data_value3}=    Create List    @{MD_skus}[2]    10.5
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]    @{data_value3}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    3
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Stock should be number
    ...   3    @{data_value2}    Stock should be number
    ...   4    @{data_value3}    Stock should be integer

    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value1}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}[0]    ${stock_value}
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value2}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}[0]    ${stock_value}
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value3}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value3}[0]    ${stock_value}

    [Teardown]    Close All Browsers

TC_ITMWM_06173 Mass upload to replace stock for sku: duplicate sku in file - fail
    [tags]    TC_ITMWM_06173    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MX_username}    ${MX_password}
    MCH Common - Go To Merchant Center Report Page

    ##.. Create test data for test case
    @{data_value1}=    Create List    @{MX_skus}[0]    100
    @{data_value2}=    Create List    @{MX_skus}[1]    200
    @{data_value3}=    Create List    @{MX_skus}[0]    300
    @{data_value4}=    Create List    @{MX_skus}[1]    400
    ##.. Keep existing stock sum for each test sku for roll back at teardown step
    MCH Mass Upload Virtual Stock - Keep Stock Sum For Each Sku    @{data_value1}[0]    @{data_value2}[0]

    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    ##.. Create excel file to be uploaded
    ${content_list}=    MCH Mass Upload Virtual Stock - Generate Excel File to be Uploaded
    ...   A1    SKU                  B1    QTY
    ...   A2    @{data_value1}[0]    B2    @{data_value1}[1]
    ...   A3    @{data_value2}[0]    B3    @{data_value2}[1]
    ...   A4    @{data_value3}[0]    B4    @{data_value3}[1]
    ...   A5    @{data_value4}[0]    B5    @{data_value4}[1]
    ${full_path_file}=    MCH Mass Upload Virtual Stock - Set SKU and QTY in file excel    ${content_list}

    ##.. Upload file
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${full_path_file}
    MCH Mass Upload Virtual Stock - Click Upload Button

    ##.. Verify message fail with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    4

    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${message_fail}

    ##.. Verify file verification result
    ${file_ver_result}=    MCH Mass Upload Virtual Stock - Generate Expected Result for Verification
    ...   2    @{data_value1}    Skus are duplicate with other rows in excel file (duplicated row: 2, 4)
    ...   3    @{data_value2}    Skus are duplicate with other rows in excel file (duplicated row: 3, 5)
    ...   4    @{data_value3}    Skus are duplicate with other rows in excel file (duplicated row: 2, 4)
    ...   5    @{data_value4}    Skus are duplicate with other rows in excel file (duplicated row: 3, 5)

    MCH Mass Upload Virtual Stock - Verify File Verification Result    ${file_ver_result}

    ##.. Verify stock via PCMS API
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value1}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value1}[0]    ${stock_value}
    ${stock_value}=    Get From Dictionary    ${existing_stock_sum_sku_dict}    @{data_value2}[0]
    MCH Mass Upload Virtual Stock - Verify Stock Sum From PCMS Remaining API    @{data_value2}[0]    ${stock_value}

TC_ITMWM_06174 Mass upload to replace stock for sku: Mass upload but not choose any file - fail
    [Tags]     TC_ITMWM_06174    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page
    Click Element    ${upload_button}

    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${choose_file}

    [Teardown]    Close All Browsers

TC_ITMWM_06175 Mass upload to replace stock for sku: choose other file format that is not excel file - fail
    [Tags]     TC_ITMWM_06175    phoenix    ready
    MCH Common - Open Merchant Center Page And Login    ${MD_username}    ${MD_password}
    MCH Common - Go To Merchant Center Report Page
    MCH Mass Upload Virtual Stock - Go To Merchant Center Report Upload Stock Page

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List     SKU              QTY
    @{data_value1}=    Create List     @{MD_skus}[0]    100
    @{data}=           Create List     ${data_name}        ${data_value1}
    ${path_file}=      MCH Mass Upload Virtual Stock - Set SKU and QTY in file csv    ${data}
    MCH Mass Upload Virtual Stock - Choose File For Mass Upload Product    ${path_file}
    Click Element    ${upload_button}

    ##.. Verify message fail
    MCH Mass Upload Virtual Stock - Verify Alert For File Verification Result    ${invalid_file_format}

    [Teardown]    Close All Browsers