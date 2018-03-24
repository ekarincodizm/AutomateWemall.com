
*** Settings ***
# Resource   ${CURDIR}/../../../../../Resource/Config/pcms_uri_endpoint.robot
Resource   ${CURDIR}/web_elements_mass_delete_product_alias_merchant.robot
Library    ${CURDIR}/../../../../../Python_Library/alias_merchant.py
Library    ${CURDIR}/../../../../../Python_Library/common.py
Library    ${CURDIR}/../../../../../Python_Library/common/csvlibrary.py
Library    ${CURDIR}/../../../../../Python_Library/dbclass/database_class.py

*** Variables ***
${file_name}         mass_alias_delete.csv
${file_template}     ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/template_mass_alias_delete.csv
${path_file}         ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/${file_name}

*** Keywords ***

Merchant Alias - User click mass delete product
    Click Element     ${btn_mass_delete}
    Location Should Contain    ${PCMS_URL}/products/alias-merchant/mass-delete/

Merchant Alias - User click link edit alias merchant
    Click Element     ${link_edit}
    Location Should Contain    ${PCMS_URL}/products/alias-merchant/edit/

Merchant Alias - User browse file for mass delete product
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File          ${browse_file}    ${canonicalPath}
    Location Should Contain     ${PCMS_URL}/products/alias-merchant/mass-delete/verify

Merchant Alias - Mass delete product result is displayed
    [Arguments]    ${result_upload}
    Wait Until Element Is Visible    ${text_result_upload}    15s
    ${get_text_result_upload}=       Get Text    ${text_result_upload}
    Log To Console    get text result=${get_text_result_upload}
    Should Be Equal    ${get_text_result_upload}    ${result_upload}

Merchant Alias - User click back to history page delete
    Click Element    ${link_back}
    Location Should Contain    ${PCMS_URL}/products/alias-merchant/mass-delete

Merchant Alias - User click link back to history page delete
    Click Element    ${link_back_upload}
    Location Should Contain    ${PCMS_URL}/products/alias-merchant/mass-delete

Merchant Alias - Prepare data alias merchant
    [Arguments]    ${alias_merchant_name}    ${merchant_code}
    ${alias_id}=     create_alias_merchant    ${alias_merchant_name}    ${merchant_code}
    Log To Console    alias id=${alias_id}
    [Return]     ${alias_id}

Verify mass delete alias merchant template
    [Arguments]    ${filename}
    ${file}=     common.Get Canonical Path    ${filename}
    ${verify}=     verify_exported_templete_product_collection     ${file}
    Log To Console     verify=${verify}
    Should Be Equal    True    ${verify}

Download template mass delete alias merchant
    Wait Until Element Is Visible    ${link_example_file}    15s
    Click Element    ${link_example_file}
    ${cookies}       Get Cookies
    write download file    ${cookies}    http://${PCMS_URL_HTTP}/products/alias-merchant/mass-delete/example-csv-file      ${file_template}
    Return From Keyword    ${file_template}

Merchant Alias - Error message is displayed when delete fail
    [Arguments]    ${result_header_fail}
    Wait Until Element Is Visible     ${text_result}    15s
    ${get_text_result}=     Get Text    ${text_result}
    Log To Console    ${get_text_result}
    Should Be Equal    ${get_text_result}    ${result_header_fail}

Merchant Alias - check header merchant be itruemart
    [Arguments]    ${header_merchant_ITM}
    Wait Until Element Is Visible     ${header_merchant}    15s
    ${img_header_merchant}=     Selenium2Library.Get Element Attribute      ${header_merchant}@src
    ${re_img_header_merchant}=     Replace String     ${img_header_merchant}     http://     ${EMPTY}
    Should Contain     ${header_merchant_ITM}      ${re_img_header_merchant}

Get link banner header shop merchant from JSON
    [Arguments]     ${response_body}
    ${data}=    Get Json Value    ${response_body}    /data/header/data/name/content
    Log To Console      data=${data}
    [Return]     ${data}
