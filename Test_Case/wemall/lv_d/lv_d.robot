*** Settings ***
Force Tags    WLS_Level_D
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String

Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Portal/wemall/lv_d/lv_d.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource    ${CURDIR}/../../../Keyword/Database/PCMS/Merchant/keywords_db_merchant.robot

Library     ${CURDIR}/../../../Python_Library/storefronts_library.py
Library     ${CURDIR}/../../../Python_Library/product.py

*** Variables ***
${merchant_id}              ROBOTSHOPCODE
${shop_code}                ROBOTSHOPCODE
${shop_name}                ROBOTSHOPNAME
${slug}                     robotshop
${status}                   active
${draft}                    draft
${published}                published
${lang_thai}                th_TH
${lang_english}             en_US
${primary_lang}             name
${secondary_lang}           name_translation
${web_view}                 web
${mobile_view}              mobile
${invalid_shop_id}          TH9999999999999999999
${invalid_type}             invalid_type
${invalid_version}          invalid_version
${invalid_lang}             invalid_lang
${invalid_view}             invalid_view
${alias_merchant_id}        DEFCODE
${alias_merchant_code}      DEFCODE
${alias_merchant_name}      DEF Alias Merchant
${alias_merchant_slug}      def-am

*** Keywords ***
Update Alias Storefront Header
    [Arguments]   ${shop_id}
    ${prepare_header}=   Set Variable   ${CURDIR}/../../../Resource/TestData/storefronts/prepare_data/put_data/prepare_header.json
    ${put_published}=    Set Variable   ${CURDIR}/../../../Resource/TestData/storefronts/prepare_data/put_data/put_published.json
    Update Storefront Data From Input File With Data-ID   ${shop_id}   web      ${prepare_header}   ${alias_merchant_code}
    Update Storefront Data From Input File With Data-ID   ${shop_id}   mobile   ${prepare_header}   ${alias_merchant_code}
    Update Storefront Data From Input File    ${shop_id}    web       ${put_published}
    Update Storefront Data From Input File    ${shop_id}    mobile    ${put_published}

Prepare Data for Merchant Storefront
    Prepare Data for Storefront API    ${shop_code}    ${shop_name}    ${slug}    active
    Set Test Variable    ${cms_merchant_id}         ${suite_shop_id}

Prepare Data for Alias Merchant Storefront
    Prepare Data for Storefront API    ${alias_merchant_code}    ${alias_merchant_name}    ${alias_merchant_slug}    active
    Set Test Variable    ${alias_cms_merchant_id}   ${suite_shop_id}

Open Lv D of Fist Product
    Open Browser ITM-levelD No Cache    @{TEST_VAR.product_pkey}[0]

Open Lv D of Second Product
    Open Browser ITM-levelD No Cache    @{TEST_VAR.product_pkey}[1]

Merchant Header Should Contain Element With Data-ID
    [Arguments]   ${data-id}
    Page Should Contain Element   //div[@data-id="${data-id}"]

Init Storefront
    Run Keyword And Ignore Error    py_delete_storefront_shop_by_slug    ${slug}

*** Test Cases ***
TC_iTM_02362 TC_iTM_02364 Verify That New Wemall Header, Wemall Footer, Merchant Header, Merchant Footer are displayed on level D
    [Tags]    TC_iTM_02362     TC_iTM_02364    Ready    QCT     regression    WLS_High
    Given Init Storefront

    Given Create Robot Shop
    And Prepare Variant
    And Prepare Robot Storefront
    When Open Lv D
    Then Check If Page Contain Wemall Header, Wemall Footer, Merchant Header, Merchant Footer

    [Teardown]    Run Keywords    Assign Backup Shop Id Back To Variant    Delete Robot Shop    Delete Storefront    Close Browser

TC_iTM_02968 Merchant header is displayed on 2 products when both product is assign to same alias
    [Tags]    TC_iTM_02968    ITMA-3083   ready     regression    WLS_Medium
    Given Init Storefront

    Given Create Robot Shop
    And Prepare Two Variant With Same Shop
    And Prepare Data for Merchant Storefront
    And Prepare Product Merchant Alias To Mutiple Product ID    ${alias_merchant_name}   ${alias_merchant_code}
    And Prepare Data for Alias Merchant Storefront
    And Update Alias Storefront Header   ${alias_cms_merchant_id}

    When Open Lv D of Fist Product
    Then Page Should Contain Merchant Header And Footer With Merchant Code   ${alias_merchant_code}
    And Merchant Header Should Contain Element With Data-ID   ${alias_merchant_code}
    When Open Lv D of Second Product
    Then Page Should Contain Merchant Header And Footer With Merchant Code   ${alias_merchant_code}
    And Merchant Header Should Contain Element With Data-ID   ${alias_merchant_code}

    [Teardown]    Run Keywords    Assign Backup Shop Id Back To Mutiple Variant
    ...    AND    Delete Robot Shop
    ...    AND    Delete Merchant Alias And Product
    ...    AND    Delete Shop and All Storefront Data    ${cms_merchant_id}
    ...    AND    Delete Shop and All Storefront Data    ${alias_cms_merchant_id}
    ...    AND    Close All Browsers

TC_iTM_02967 Not display alias merchant on level D if no merchant is created in cms-storefront

    [Tags]   TC_iTM_02967    ready      regression    WLS_Medium
    Given Init Storefront


    Given DB Merchant - Create Merchant And Assign To Test Variable
    When Level D - Open Browser Level D With Inventory Id From Test Variable
    Then Level D - Level D Is Opened
    and Level D - Merchant Header Is Not Displayed


    [Teardown]   Run Keywords   DB Merchant - Rollback Shop Id For Inventory
    ...   AND    DB Merchant - Delete Shop By Shop Id
    ...   AND    Close All Browsers


