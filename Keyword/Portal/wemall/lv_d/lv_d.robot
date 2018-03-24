*** Settings ***
Library     Collections
Library     HttpLibrary.HTTP
Library     Selenium2Library
Library     DatabaseLibrary
Library     ${CURDIR}/../../../../Python_Library/variant_library.py
Library     ${CURDIR}/../../../../Python_Library/variant_library.py
Library     ${CURDIR}/../../../../Python_Library/product.py
Library     ${CURDIR}/../../../../Python_Library/shop_library.py
Library     ${CURDIR}/../../../../Python_Library/mnp_util.py
Library     ${CURDIR}/../../../../Python_Library/DatabaseData.py

Resource    ${CURDIR}/webelement_lv_d.robot
Resource    ${CURDIR}/../../../API/api_storefronts/api_shops_keywords.robot
Resource    ${CURDIR}/../../../API/PCMS/Shop/keywords_shop.robot
Resource    ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot
Resource    ${CURDIR}/../../../Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource    ${CURDIR}/../../../../Resource/TestData/storefronts/storefront_data.robot

Library    ${CURDIR}/../../../../Python_Library/variant_library.py
Library    ${CURDIR}/../../../../Python_Library/product.py

Library    ${CURDIR}/../../../../Python_Library/shop_library.py

*** Keywords ***

########################
### Prepaer Keywords ###
########################

Create Robot Shop And Prepare Robot Storefront
    Create Robot Shop
    Prepare Variant
    Prepare Robot Storefront
    ${product_p_key}=    product.get_product_pkey    ${suite.inventory_id}
    Set Suite Variable    ${suite.product_p_key}    ${product_p_key}

Merchant Header - Footer
    [Arguments]    ${full_url}    ${expected_url}    ${protocol}=http    ${expected_url2}=${expected_url}
    Go to Specific URL    ${full_url}
    Check Location Contain    ${expected_url}    ${protocol}
    Page Should Contain Merchant Header And Footer Div
    Page Should Contain Merchant Menu Div

Create Robot Shop
    API Shop - Create Shop    ${shop_code}    ${shop_name}

    ${shop_id}=    Get Merchant ID By Merchant Code    ${shop_code}
    ${shop_id}=    Get From List    ${shop_id}    0

    Set Test Variable    ${var.shop_id}    ${shop_id}

Prepare Variant
    @{product_id}=    py_get_product_without_alias
    ${inventory_id}=    get_inventory_id_from_product_id    @{product_id}[0]
    ${backup_shop_id}=    get_original_shop_id_by_inventory_id    ${inventory_id}

    Set Test Variable    ${var.inventory_id}    ${inventory_id}
    Set Test Variable    ${var.backup_shop_id}    ${backup_shop_id}
    Set Test Variable    ${var.product_id}    @{product_id}[0]

    assign_shop_id_to_existing_inventory_id        ${var.shop_id}    ${var.inventory_id}

Prepare Two Variant With Same Shop
    ${products}=   py_get_product_normal_without_alias   2
    &{product_1}=   Set Variable   @{products}[0]
    &{product_2}=   Set Variable   @{products}[1]
    ${inventory_id_1}=    get_inventory_id_from_product_id    ${product_1.product_id}
    ${inventory_id_2}=    get_inventory_id_from_product_id    ${product_2.product_id}
    ${backup_shop_id_1}=    get_original_shop_id_by_inventory_id    ${inventory_id_1}
    ${backup_shop_id_2}=    get_original_shop_id_by_inventory_id    ${inventory_id_2}

    @{inventory_id}=     Create List   ${inventory_id_1}         ${inventory_id_2}
    @{backup_shop_id}=   Create List   ${backup_shop_id_1}       ${backup_shop_id_2}
    @{product_id}=       Create List   ${product_1.product_id}   ${product_2.product_id}

    Set Test Variable    ${var.inventory_id}      ${inventory_id}
    Set Test Variable    ${var.backup_shop_id}    ${backup_shop_id}
    Set Test Variable    ${var.product_id}        ${product_id}

    assign_shop_id_to_existing_inventory_id        ${var.shop_id}    ${inventory_id_1}
    assign_shop_id_to_existing_inventory_id        ${var.shop_id}    ${inventory_id_2}

Prepare Robot Storefront
    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${slug}    ${status}

##########
### UI ###
##########

Open Lv D
    ${product_p_key}=    product.get_product_pkey    ${var.inventory_id}
    Wemall Common - Debug   ${var.inventory_id}   var.inventory_id
    Open Browser ITM-levelD No Cache    ${product_p_key}

Open WM-level D Web Of Normal Product
    ${inv_id}=    get_inventory_normal
    ${product_pkey}=   product.get_product_pkey    ${inv_id}
    Open Browser    ${WEMALL_URL}/products/items-${product_pkey}.html    ${BROWSER}

#########################
### Teardown Keyowrds ###
#########################

Delete Robot Shop
    Delete Shop By Shop Code    ${shop_code}

Assign Backup Shop Id Back To Variant
    assign_shop_id_to_existing_inventory_id    ${var.backup_shop_id}    ${var.inventory_id}

Assign Backup Shop Id Back To Mutiple Variant
    # ${var.backup_shop_id}=list    ${var.inventory_id}=list
    ${count}=   Get Length   ${var.inventory_id}
    :For   ${x}   IN RANGE   ${count}
    \   assign_shop_id_to_existing_inventory_id    @{var.backup_shop_id}[${x}]    @{var.inventory_id}[${x}]

Delete Storefront
    # ${suite_shop_id}=    Set Variable    90d69843-6eae-46ed-b17f-d6425d237490
    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}

Delete Storefront Two Shop
    [Arguments]    ${suite_shop_id_1}    ${suite_shop_id_2}
    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id_1}
    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id_2}

####################
### Verification ###
####################

Check If Page Contain Wemall Header, Wemall Footer, Merchant Header, Merchant Footer
    Page Should Contain Wemall Header And Footer
    Page Should Contain Merchant Header And Footer
    Page Should Contain Merchant Menu

Page Should Contain Wemall Header And Footer
    Page Should Contain Element    ${LOGO-XPATH}
    Page Should Contain Element    ${SEARCH-BOX-XPATH}
    Page Should Contain Element    ${CART-XPATH}
    Page Should Contain Element    ${MEMBER-XPATH}
    Page Should Contain Element    ${FOOTER-XPATH}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-1}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-2}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-3}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-4}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-5}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-6}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-7}
    Page Should Contain    ${FOOTER-DUMMY-TEXT-8}

Page Should Contain Merchant Header And Footer
    Page Should Contain Element    ${DUMMY-MERCHANT-HEADER-XPATH}
    Page Should Contain Element    ${DUMMY-MERCHANT-FOOTER-XPATH}

Page Should Contain Merchant Menu
    Page Should Contain Element    ${MENU-CLASS-XPATH}
    Page Should Contain    ${MENU-DUMMY-TEXT-1}
    Page Should Contain    ${MENU-DUMMY-TEXT-2}
    Page Should Contain    ${MENU-DUMMY-TEXT-3}
    Page Should Contain    ${MENU-DUMMY-TEXT-4}
    Page Should Contain    ${MENU-DUMMY-TEXT-5}
    Page Should Contain    ${MENU-DUMMY-TEXT-6}


Page Should Contain Merchant Header And Footer With Merchant Code
    [Arguments]   ${merchant-code}
    Wait Until Page Contains Element   ${IWM_MERCHANT_HEADER_DIV}/*[@merchant-code="${merchant-code}"]    60s
    Wait Until Page Contains Element   ${IWM_MERCHANT_FOOTER_DIV}/*[@merchant-code="${merchant-code}"]    60s
    Page Should Contain Element        ${IWM_MERCHANT_HEADER_DIV}/*[@merchant-code="${merchant-code}"]
    Page Should Contain Element        ${IWM_MERCHANT_FOOTER_DIV}/*[@merchant-code="${merchant-code}"]

Page Should Contain Merchant Header And Footer Div
    Page Should Contain Element    ${IWM_MERCHANT_HEADER_DIV}

Page Should Contain Merchant Menu Div
    Page Should Contain Element    ${IWM_MERCHANT_FOOTER_DIV}

Lv D Must Be Show Alias Merchant Header




