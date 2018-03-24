*** Settings ***
Resource          ${CURDIR}/../../../Common/keywords_wemall_common.robot
Library           Selenium2Library

*** Keywords ***
Wemall Level D - Open Browser Level D
    #*******************************************************************
    #
    #    @description: Open Browser with Wemall Level D
    #    @Used:    You must assign product_slug, product_pkey to TEST VARIABLE as name ${TEST_VAR}
    #
    #*******************************************************************
    Wemall Common - Init Test Variable
    ${product_slug}=    Wemall Common - Get Value From Test Variable    product_slug
    ${product_pkey}=    Wemall Common - Get Value From Test Variable    product_pkey
    Open Browser    ${WEMALL_URL}/products/${product_slug}-${product_pkey}.html    ${BROWSER}
    #*******************************************************************
    #
    #    @description: Assume browser is opened and redirect to Wemall level d
    #    @Used:    You must assign product_slug, product_pkey to TEST VARIABLE as name ${TEST_VAR}
    #
    #*******************************************************************

Wemall Level D - URL Redirect To Level D
    Wemall Common - Init Test Variable
    ${product_slug}=    Wemall Common - Get Value From Test Variable    product_slug
    ${product_pkey}=    Wemall Common - Get Value From Test Variable    product_pkey
    Wemall Common - Debug    ${product_slug}    product_slug
    Wemall Common - Debug    ${product_pkey}    product_pkey
    Wemall Common - Debug    ${WEMALL_URL}/products/${product_slug}-${product_pkey}.html    URL Level D
    Go To    ${WEMALL_URL}/products/${product_slug}-${product_pkey}.html
