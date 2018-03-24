*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           ${CURDIR}/../../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../../Python_Library/common/csvlibrary.py
Resource          web_element_mass_active_product.robot

*** Variables ***
${file_template}    ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/template_active_product.csv
${template_}      ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/

*** Keywords ***
Create collection
    ${CollectionPkey}    Set Variable    9123456789123
    ${total_row_colelction}=    Get collection row    ${CollectionPkey}
    Log To Console    insert coll log=${total_row_colelction}
    Run Keyword If    ${total_row_colelction} == 0    Run Keywords    Log To Console    insert collection
    ...    AND    Create category and collection for mass active product

Create category and collection for mass active product
    ${collection_id}=    Create category and collection with param    0    9123456789123    mass active product    mass-active-product    0
    ...    C9123456789123    2
    [Return]    ${collection_id}

Set product key in file csv product collection
    [Arguments]    ${data}
    ${path_file}=    Set Variable    ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/mass_active_product_up.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]    ${path_file}

Go to mass active product menu
    Wait Until Element Is Visible    ${product_menu}    20s
    Click Element    ${product_menu}
    Wait Until Element Is Visible    ${mass_active_product_menu}    20s
    Click Element    ${mass_active_product_menu}
    Wait Until Element Is Visible    ${text_menu}    20s
    Location Should Contain    ${PCMS_URL}/products/mass-active-products
    ${get_text}=    Get Text    ${text_menu}
    Should Be Equal    ${get_text}    Mass Active Products
    ### Browse file ###

User browse file for mass active product collection
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${browse_file}    ${canonicalPath}
    Location Should Contain    ${PCMS_URL}/products/mass-active-products/verify

Mass active product result is displayed
    [Arguments]    ${result_upload}
    Wait Until Element Is Visible    ${text_result_upload}    15s
    ${get_text_result_upload}=    Get Text    ${text_result_upload}
    Log To Console    get text result=${get_text_result_upload}
    Should Be Equal    ${get_text_result_upload}    ${result_upload}

result in displayed on web
    [Arguments]    ${product_key}    ${product_name}
    Go To    ${ITM_URL}/products/${product_key}.html
    ${product_name_level_d}=    Get Text    ${xpath_product_name_level_D}
    Log To Console    ${product_name_level_d}
    Should Be Equal    ${product_name_level_d}    ${product_name}

Search product by name
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    ${xpath_search_product_name}    15s
    Input Text    ${xpath_search_product_name}    ${product_name}
    Wait Until Element Is Visible    ${xpath_search_button}    15s
    Click Element    ${xpath_search_button}

Edit product
    [Arguments]    ${product_id}
    Wait Until Element Is Visible    //a[@href="${PCMS_URL}/products/edit/${product_id}"]${xpath_edit_button}    15s
    Click Element    /${xpath_edit_button}

Check status product
    Wait Until Element Is Visible    ${xpath_select_status_product}    15s
    ${status}=    Get Selected List Value    ${xpath_select_status_product}
    Log To Console    status=${status}
    Should Be Equal    1    ${status}

Download template mass active product
    Wait Until Element Is Visible    ${link_example_file}    15s
    Click Element    ${link_example_file}
    ${cookies}    Get Cookies
    write download file    ${cookies}    http://${PCMS_URL_HTTP}/products/mass-active-products/example-csv-file    ${file_template}
    Return From Keyword    ${file_template}

Verify mass active product template
    [Arguments]    ${filename}
    ${file}=    common.Get Canonical Path    ${filename}
    ${verify}=    verify_exported_templete_product_collection    ${file}
    Log To Console    verify=${verify}
    Should Be Equal    True    ${verify}

Error message is displayed when upload fail
    [Arguments]    ${result_header_fail}
    Wait Until Element Is Visible    ${text_result}    15s
    ${get_text_result}=    Get Text    ${text_result}
    Log To Console    ${get_text_result}
    Should Be Equal    ${get_text_result}    ${result_header_fail}

Get result in file verification table
    ${count_row}    Get Matching Xpath Count    ${xpath_count_row_td}
    ${count_hd_td}    Get Matching Xpath Count    ${xpath_hd_td}
    ${message}=    Create List
    : FOR    ${i}    IN RANGE    1    ${count_hd_td} * ${count_row} + 1
    \    ${name}=    Get Text    xpath=(${xpath_td})[${i}]
    \    Append To List    ${message}    ${name}
    [Return]    ${message}

No content result is displayed
    [Arguments]    ${result_no_content}
    Wait Until Element Is Visible    ${link_back_mass_active}    15s
    Wait Until Element Is Visible    ${text_result}    15s
    ${get_text_result}=    Get Text    ${text_result}
    Log To Console    ${result_no_content}
    Should Be Equal    ${get_text_result}    ${result_no_content}

Cannot see mass active product menu
    Wait Until Element Is Visible    ${product_menu}    15s
    Click Element    ${product_menu}
    Wait Until Element Is Not Visible    ${mass_active_product_menu}    15s
