*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           ${CURDIR}/../../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../../Python_Library/common/csvlibrary.py
Resource          web_element_product_collection.robot

*** Variables ***
${filename}       ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/exported_products_download.csv
${template_}      ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/

*** Keywords ***
Set product key in file csv product collection
    [Arguments]    ${data}
    ${path_file}=    Set Variable    ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/export_product_collection_up.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]    ${path_file}

Go to export product collection menu
    Wait Until Element Is Visible    ${product_menu}    20s
    Click Element    ${product_menu}
    Wait Until Element Is Visible    ${export_product_collection_menu}    20s
    Click Element    ${export_product_collection_menu}
    Wait Until Element Is Visible    ${text_menu}    20s
    Location Should Contain    ${PCMS_URL}/export-products-collections
    ${get_text}=    Get Text    ${text_menu}
    Should Be Equal    ${get_text}    Export Product Collection
    ### Browse file ###

User browse file for upload export product collection
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${browse_file}    ${canonicalPath}
    Location Should Contain    ${PCMS_URL}/export-products-collections/verify

Upload result is displayed
    [Arguments]    ${result_upload}
    Wait Until Element Is Visible    ${text_result_upload}    15s
    ${get_text_result_upload}=    Get Text    ${text_result_upload}
    Log To Console    get text result=${get_text_result_upload}
    Should Be Equal    ${get_text_result_upload}    ${result_upload}

downloaded result is displayed
    [Arguments]    ${result_upload}
    wait Until Element Is Not Visible    ${spinner_name}
    Wait Until Element Is Visible    ${text_result_upload}    15s
    ${get_text_result_upload}=    Get Text    ${text_result_upload}
    Should Be Equal    ${get_text_result_upload}    ${result_upload}

check file download
    [Arguments]    ${cookies}
    ${product_Id}=    Selenium2Library.Get Element Attribute    ${get_product_ids}@value
    ${canonicalPath}=    common.Get Canonical Path    ${filename}
    write_download File Post Products Id    ${cookies}    http://${PCMS_URL_HTTP}/export-products-collections/download    ${canonicalPath}    ${product_Id}
    ${verify}=    Verify Exported Product Collection Csv    ${canonicalPath}
    Log To Console    verify=${verify}
    Should Be Equal    True    ${verify}

No content result is displayed
    [Arguments]    ${result_no_content}
    Wait Until Element Is Visible    ${link_back}    15s
    Wait Until Element Is Visible    ${text_result}    15s
    ${get_text_result}=    Get Text    ${text_result}
    Log To Console    ${result_no_content}
    Should Be Equal    ${get_text_result}    ${result_no_content}

Error message is displayed when upload fail
    [Arguments]    ${result_header_fail}
    Wait Until Element Is Visible    ${text_result}    15s
    ${get_text_result}=    Get Text    ${text_result}
    Log To Console    ${get_text_result}
    Should Be Equal    ${get_text_result}    ${result_header_fail}

Download template
    Wait Until Element Is Visible    ${link_example_file}    15s
    Click Element    ${link_example_file}
    ${ipHost}=    Get Ip From Url    ${PCMS_URL_HTTP}
    ${cookies}    Get Cookies
    write download file    ${cookies}    http://${PCMS_URL_HTTP}/export-products-collections/example-csv-file    ${filename}
    Return From Keyword    ${filename}

Verify export product collection template
    [Arguments]    ${filename}
    ${verify}=    verify_exported_product_collection_csv    ${filename}
    Log To Console    verify=${verify}
    Should Be Equal    True    ${verify}

Cannot see export product collection menu
    Wait Until Element Is Visible    ${product_menu}    15s
    Click Element    ${product_menu}
    Wait Until Element Is Not Visible    ${export_product_collection_menu}    15s

Get result in file verification table
    ${count_row}    Get Matching Xpath Count    ${xpath_count_row_td}
    ${count_hd_td}    Get Matching Xpath Count    ${xpath_hd_td}
    ${message}=    Create List
    : FOR    ${i}    IN RANGE    1    ${count_hd_td} * ${count_row} + 1
    \    ${name}=    Get Text    xpath=(${xptah_td})[${i}]
    \    Append To List    ${message}    ${name}
    # Log To Console    ${message}
    [Return]    ${message}
