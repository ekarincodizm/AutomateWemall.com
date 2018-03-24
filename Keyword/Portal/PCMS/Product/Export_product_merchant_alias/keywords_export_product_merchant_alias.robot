*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           ${CURDIR}/../../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../../Python_Library/common/csvlibrary.py
Resource          web_element_export_product_merchant_alias.robot

*** Variables ***
${file_name_export}       ${CURDIR}/../../../../../Resource/TestData/Product/csv_file/export_product_merchant_alias.csv

*** Keywords ***
Merchant Alias - Verify export product merchant alias
    [Arguments]    ${input_file_name_export}
    ${verify}=     verify_export_product_merchant_alias_csv     ${input_file_name_export}
    Log To Console     verify=${verify}
    Should Be Equal    True    ${verify}

Merchant Alias - User click export product merchant alias
    Wait Until Element Is Visible    ${btn_export_products}    15s
    ${link_download}=      Selenium2Library.Get Element Attribute      ${btn_export_products}@href
    Log To Console       filename=${file_name_export}
    Log To Console       link_download=${link_download}
    Click Element    ${btn_export_products}
    ${cookies}       Get Cookies
    write download file    ${cookies}     ${link_download}      ${file_name_export}
    Return From Keyword    ${file_name_export}

Merchant Alias - Check button export disable
   Wait Until Element Is Visible    ${btn_export_products}    15s
   ${status_disable}=      Selenium2Library.Get Element Attribute      ${btn_export_products}@disabled
   Should Be Equal    true    ${status_disable}

Merchant Alias - Get merchant alias id from url
    ${get_url}=    Get Location
    ${alias_merchant_id}=      Remove String    ${get_url}       ${PCMS_URL}/products/alias-merchant/edit/
    Return From Keyword    ${alias_merchant_id}
