*** Settings ***
Library           HttpLibrary.HTTP
# Library           Selenium2Library
Library           Collections
Library           String
Library           BuiltIn
Resource          ${CURDIR}/../../../../Resource/init.robot
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/brand.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/Collection/keywords_collection.robot
Resource          ${CURDIR}/../../../../Keyword/Common/Keywords_Common.robot

*** Keyword ***
Create Brand

    [Arguments]    ${name}  ${description}
    Go To   ${PCMS_URL}/brands/create
    Input Text    name=name    ${name}
    Input Text    name=description    ${description}
    Click Element       //*[@class="btn btn-primary"]
    Sleep    2s

Get Brand
    [Arguments]    ${name}
    Connect DB ITM
    ${total_row_colelction}=    Query    SELECT * FROM `brands` WHERE `brands`.`name` = '${name}'
    # Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row_colelction}


Verify Description in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /data/description

    Should Be Equal As Strings    ${message}    "${expected_mssage}"    Description Not Matched


Count Brands
    Connect DB ITM
    ${total_row_colelction}=    Query    SELECT COUNT(*) FROM `brands` WHERE `brands`.`id` IN (SELECT DISTINCT `brand_id` FROM `products` WHERE `products`.`deleted_at` IS NULL AND `status` = "publish") AND `brands`.`deleted_at` IS NULL
    # Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row_colelction[0][0]}


