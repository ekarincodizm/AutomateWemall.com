*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/csv_library.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Resource          web_element_discount_campaign.robot

*** Variables ***
${filename}       ${CURDIR}/../../../../Resource/TestData/Promotion/Discount_Campaign/csv_file/exported_products_download.csv
${template_}      ${CURDIR}/../../../../Resource/TestData/Promotion/Discount_Campaign/csv_file/


*** Keywords ***
Download template
    Wait Until Element Is Visible    ${link_example_file}    15s
    Click Element    ${link_example_file}
    ${ipHost}=       Get Ip From Url     ${PCMS_URL_HTTP}
    ${cookies}       Get Cookies
    write download file    ${cookies}    http://${PCMS_URL_HTTP}/campaigns/mass-upload/example-csv-file      ${filename}
    Return From Keyword    ${filename}

Check template is correctly
    [Arguments]    ${filename}
    ${verify}=     verify_example_template_of_mass_upload_campaign_price_and_product     ${filename}
    Log To Console     verify=${verify}
    Should Be Equal    True    ${verify}
