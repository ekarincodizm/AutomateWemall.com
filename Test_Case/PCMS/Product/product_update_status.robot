*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Library           String
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Manage_Variant/keywords_manage_variant.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTruemart/Level_d_page/keywords_leveld.robot
Test Setup        Login Pcms

*** Variables ***
${pkey_product_flash}    2488448225275


*** Test Cases ***
TC_iTM_03123 Update product status to Active when all variants are active
    [Documentation]    To Verify that Update Product Status = Active When Variant Status = Active
    [Tags]    TC_iTM_03123    ready    flash    Product_Update_Status    regression

    ${product}=          Get product by pkey    ${pkey_product_flash}
    ${product_id}=       Set Variable    ${product[0]}
    ${product_title}=    Set Variable    ${product[1]}

    ${before_variants}=        Get variants by product id    ${product_id}
    ${before_variants_id}=     Create List    ${before_variants[0][0]}    ${before_variants[1][0]}    ${before_variants[2][0]}    ${before_variants[3][0]}    ${before_variants[4][0]}

    ${expected_status_list}=    Create List    active    active    active    active    active
    User set variant status    ${product_title}    ${before_variants_id}    ${expected_status_list}

    ${value_color}=     Create list    น้ำตาลมะกอก    น้ำเงินมิดไนท์บลู    (Product)Red    ชมพูอ่อน    ดำ

    ##step test##
    GO TO PRODUCT List PAGE
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    1
    Save product status

    ${after_variants}=    Get variants by product id    ${product_id}
    Check variant status when expect same status      ${expected_status_list}    ${after_variants}
    Verify variant status - on DB    ${before_variants_id}     ${expected_status_list}

    # Go To      ${ITM_URL}/products/${pkey_product_flash}.html?no-cache=1
    # ${count_style_color}=     Level D - count variant status
    # ${color_list}=    Level D - Get style color    ${count_style_color}
    # Level D - verify style type    ${color_list}    ${value_color}

    [Teardown]    Close All Browsers


TC_iTM_03125 Update product status to Active when variants are active and disable
    [Documentation]    To Verify that Update Product Status = Active When Variant Status = Active and Inactive
    [Tags]    TC_iTM_03125    ready    flash    Product_Update_Status    regression

    ${product}=    Get product by pkey    ${pkey_product_flash}
    ${product_id}=    Set Variable    ${product[0]}
    ${product_title}=    Set Variable    ${product[1]}

    ${before_variants}=    Get variants by product id    ${product_id}
    ${before_variants_id}=     Create List    ${before_variants[0][0]}    ${before_variants[1][0]}    ${before_variants[2][0]}    ${before_variants[3][0]}    ${before_variants[4][0]}

    ${expected_status_list}=    Create List    active    disable    active    active    active
    User set variant status    ${product_title}    ${before_variants_id}    ${expected_status_list}

    ## Test step ##
    GO TO PRODUCT List PAGE
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    1
    Save product status

    ${after_variants}=    Get variants by product id    ${product_id}
    Check variant status when expect same status     ${expected_status_list}    ${after_variants}

    # Go To      ${ITM_URL}/products/product-flash-apple-iphone-6-${pkey_product_flash}.html?no-cache=1
    # ${count_style_color}=     Level D - count variant status
    # ${color_list}=    Level D - Get style color    ${count_style_color}
    # ${value_color}=     Create list    น้ำตาลมะกอก    (Product)Red    ชมพูอ่อน    ดำ
    # Level D - verify style type    ${color_list}    ${value_color}

    [Teardown]    Close All Browsers

TC_iTM_03126 Update product status to Inactive when all variants are active
    [Documentation]    To Verify that Update Product Status = Inactive When Variant Status = Active
    [Tags]    TC_iTM_03126    ready    flash    Product_Update_Status    regression
    ${product}=    Get product by pkey    ${pkey_product_flash}
    ${product_id}=    Set Variable    ${product[0]}
    ${product_title}=    Set Variable    ${product[1]}

    ${before_variants}=    Get variants by product id    ${product_id}
    ${before_variants_id}=     Create List    ${before_variants[0][0]}    ${before_variants[1][0]}    ${before_variants[2][0]}    ${before_variants[3][0]}    ${before_variants[4][0]}

    ${expected_status_list}=    Create List    active    active    active    active    active
    User set variant status    ${product_title}    ${before_variants_id}    ${expected_status_list}

    ##step test##
    GO TO PRODUCT List PAGE
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    0
    Save product status

    ${after_variants}=    Get variants by product id    ${product_id}
    Check variant status when expect same status     ${expected_status_list}    ${after_variants}

    # Level D Go to level D with Product No Cache    ${pkey_product_flash}
    # ${get_location}=    Get Location
    # Should Be Equal     ${get_location}    ${WEMALL_URL}/

    [Teardown]    Close All Browsers

TC_iTM_03128 Update product status to Inactive when all variants are active and disable
    [Documentation]    To Verify that Update Product Status = Inactive When Variant Status = Active and Inactive
    [Tags]    TC_iTM_03128    ready    flash    Product_Update_Status    regression

    ${product}=    Get product by pkey    ${pkey_product_flash}
    ${product_id}=    Set Variable    ${product[0]}
    ${product_title}=    Set Variable    ${product[1]}

    ${before_variants}=    Get variants by product id    ${product_id}
    ${before_variants_id}=     Create List    ${before_variants[0][0]}    ${before_variants[1][0]}    ${before_variants[2][0]}    ${before_variants[3][0]}    ${before_variants[4][0]}

    ${expected_status_list}=    Create List    active    disable    active    active    active
    User set variant status    ${product_title}    ${before_variants_id}    ${expected_status_list}

    GO TO PRODUCT List PAGE
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    0
    Save product status

    ${after_variants}=    Get variants by product id    ${product_id}
    Check variant status when expect same status       ${expected_status_list}    ${after_variants}

    # Go To      ${ITM_URL}/products/${pkey_product_flash}.html?no-cache=1
    # ${get_location}=    Get Location
    # Should Be Equal     ${get_location}    ${WEMALL_URL}/

    [Teardown]    Close All Browsers