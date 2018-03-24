*** Settings ***
Force Tags    WLS_CAMP_Template
Test Setup        Open Camps Browser
Test Teardown     Close All Browsers
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_00997 Able to filter products by product name
    [TAGS]    TC_CAMPS_00997    ready    Regression
    Open Variant Selector Modal for Flash Sale
    Search Products by Product Name    iphone
    Verify Search Result by Product Name    iphone

TC_CAMPS_01000 Able to filter product by brand
    [TAGS]    TC_CAMPS_01000    ready    Regression
    Open Variant Selector Modal for Flash Sale
    Search Products by Brand    Apple
    Verify Search Result by Brand    Apple

TC_CAMPS_01003 Able to filter product by vendor
    [TAGS]    TC_CAMPS_01003    ready    Regression
    Open Variant Selector Modal for Flash Sale
    Search Products by Vendor    1O1 CORPORATION CO., LTD.
    Verify Search Result by Vendor    1O1 CORPORATION CO., LTD.

TC_CAMPS_01017 Verify product and variant selector modal page
    [TAGS]    TC_CAMPS_01017    ready    Regression
    Open Variant Selector Modal for Flash Sale
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-TABLE}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-PRODUCT-NAME}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-PRODUCT-LINE}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-SHOP-SELECT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-BRAND-SELECT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-VENDOR-SELECT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-TAG}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-COLLECTION-SELECT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${SEARCH-CLEAR-BUTTON}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${SEARCH-FILTER-BUTTON}    ${g_loading_delay_short}
    # Scroll Page To Location
    # Wait Until Element Is Visible    ${VARIANT-SELECTOR-OK-BUTTON}    ${g_loading_delay_short}
    # Wait Until Element Is Visible    ${VARIANT-SELECTOR-CANCEL-BUTTON}    ${g_loading_delay_short}
