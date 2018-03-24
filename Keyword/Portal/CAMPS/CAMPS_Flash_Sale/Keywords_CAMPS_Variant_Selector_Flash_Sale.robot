*** Settings ***
Resource          ../../../../Resource/Config/stark/camps_libs_resources.robot
Resource          WebElement_CAMPS_Variant_Selector_Flash_Sale.robot

*** Variables ***

*** Keywords ***
Open Variant Selector Modal for Flash Sale
    [Arguments]     ${flash_sale_type}=Wow Banner
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    Run Keyword If    '${flash_sale_type}' == 'Wow Banner'    Go To Create Wow Banner Page
    ...    ELSE IF    '${flash_sale_type}' == 'Wow Extra'    Go To Create Wow Extra Page
    ...    ELSE    Log    Invalid Flash Sale Type
    Click Element    ${VARIANT-SELECTOR-OPEN-BUTTON}
    Wait Until Page Contains Variant Selector Table

Search Products by Product Name
    [Arguments]    ${product_name}
    Input Text    ${VARIANT-SELECTOR-PRODUCT-NAME}    ${product_name}
    Click Element    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Variant Selector Table

Verify Search Result by Product Name
    [Arguments]    ${expected_name}
    ${actual_product_name}=    Get Text    //*[@id='productName1']
    ${result}=    Get Lines Matching Pattern    ${actual_product_name}    *${expected_name}*    True
    Should Not Be Empty    ${result}

Search Products by Vendor
    [Arguments]    ${vendor_name}
    Sleep    1s
    Select From List    ${VARIANT-SELECTOR-VENDOR-SELECT}    ${vendor_name}
    Wait Until Page Contains Variant Selector Table

Verify Search Result by Vendor
    [Arguments]    ${expected_name}
    : For    ${i}    IN RANGE    1    30
    \    ${xpath}=    Set Variable    vendorName1-${i}
    \    ${actual_vendor_name}=    Get Text    //*[@id='${xpath}']
    \    Run Keyword If    '${actual_vendor_name}' == '${expected_name}'    Exit For Loop
    Should Be Equal    ${actual_vendor_name}    ${expected_name}

Search Products by Brand
    [Arguments]    ${brand_name}
    Sleep    1s
    Select From List    ${VARIANT-SELECTOR-BRAND-SELECT}    ${brand_name}
    Wait Until Page Contains Variant Selector Table

Verify Search Result by Brand
    [Arguments]    ${expected_name}
    Element Should Contain    //*[@id='brandName1']    ${expected_name}

Select Variant for Flash Sale
    [Arguments]    ${product_index}=1    ${variant_index}=1
    # Click Element    ${PROMO-SELECT-CODE-GROUP-BUTTON}
    Click Element    //*[@id="variantCheckboxSpan${product_index}-${variant_index}"]

Wait Until Page Contains Variant Selector Table
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Page Contains Element    ${VARIANT-SELECTOR-TABLE}    ${wait_time}

Submit Selected Variant
    Click Element    ${VARIANT-SELECTOR-OK-BUTTON}

Cancel Selected Variant
    Click Element    ${VARIANT-SELECTOR-CANCEL-BUTTON}
