*** Settings ***
Library           Selenium2Library
Resource          web_element_manage_variant.robot    # Library    ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Go To Management variants menu
    Go To    ${PCMS_URL}/products/variants
    Wait Until Element Is Visible    ${breadcrumb}    15s

User input product name
    [Arguments]    ${text_product_name}
    Input Text    ${textbox_product_name}    ${text_product_name}

User click search
    Click Element    ${btn_search}

User click manage button
    Click Element    ${btn_manage}

Set variants status
    [Arguments]    ${variant_ids}    ${variants_status}
    ${variant_id_length}=    Get Length    ${variant_ids}
    ${variant_status_length}=    Get Length    ${variants_status}
    : FOR    ${INDEX}    IN RANGE    0    ${variant_id_length}
    \    ${variant_id}=    Get From List    ${variant_ids}    ${INDEX}
    \    ${variant_status}=    Get From List    ${variants_status}    ${INDEX}
    \    Select From List By Value    //*[@name="status[${variant_id}]"]    ${variant_status}
    \    Log To Console    //*[@name="status[${variant_id}]"]    ${variant_status}

Set specific variants status
    [Arguments]    ${variant_id}    ${variant_status}
    Select From List By Value    //*[@name="status[${variant_id}]"]    ${variant_status}

User click save
    Click Element    ${btn_save}

Verify variant status - on DB
    [Arguments]    ${variant_ids}    ${variants_status}
    ${variant_id_length}=    Get Length    ${variant_ids}
    ${variant_status_length}=    Get Length    ${variants_status}
    Connect DB ITM
    : FOR    ${INDEX}    IN RANGE    0    ${variant_id_length}
    \    ${variant_id}=    Get From List    ${variant_ids}    ${INDEX}
    \    ${variant_status}=    Get From List    ${variants_status}    ${INDEX}
    \    ${variant_status_db}=    Query    SELECT status FROM `variants` where `id` = '${variant_id}'
    \    Should Be Equal    ${variant_status}    ${variant_status_db[0][0]}

User set variant status
    [Arguments]    ${text_product_name}    ${variant_ids}    ${variants_status}
    Go To Management variants menu
    User input product name    ${text_product_name}
    User click search
    User click manage button
    Set variants status    ${variant_ids}    ${variants_status}
    User click save
    Verify variant status - on DB    ${variant_ids}    ${variants_status}

User set specific variant status
    # ${variants_status}=active/disable
    [Arguments]    ${text_product_name}    ${variant_id}    ${variants_status}
    Go To Management variants menu
    User input product name    ${text_product_name}
    User click search
    User click manage button
    Set specific variants status   ${variant_id}    ${variants_status}
    User click save
    Check specific variant status as expect   ${variant_id}    ${variants_status}

Check specific variant status as expect
    [Arguments]    ${variant_id}    ${expect_status}
    ${variants_status}=   Get Selected List Value   //*[@name="status[${variant_id}]"]
    Should be equal    ${variants_status}    ${expect_status}

Check variant status when expect same status
    [Arguments]       ${expected_status_list}    ${variants}
    # ${product_id}=    Convert To String    ${product_id}
    ${variants_length}=    Get Length    ${variants}
    ${expected_status_list_length}=    Get Length    ${expected_status_list}
    : FOR    ${INDEX}    IN RANGE    0    ${expected_status_list_length}
    \  ${variant}=    Get From List    ${variants}    ${INDEX}
    \  ${expected_status}=    Get From List    ${expected_status_list}    ${INDEX}
    \  ${status}=    Set Variable    ${variant[2]}
    # \  Log to console    status::${status}
    # \  Log to console    expected_status::${expected_status}
    \  Should be equal    ${status}    ${expected_status}

Get variants by product id
    [Arguments]    ${product_id}
    ${variants}=    get_variant_by_product_id    ${product_id}
    [Return]    ${variants}

Display Manage Variants Success
    Wait Until Page Contains    Your data has been successfully saved.

