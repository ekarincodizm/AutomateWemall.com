*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String

Resource    ${CURDIR}/../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Portal/wemall/lv_d/lv_d.robot

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
${mobile_viewcvd}              mobile
${invalid_shop_id}          TH9999999999999999999
${invalid_type}             invalid_type
${invalid_version}          invalid_version
${invalid_lang}             invalid_lang
${invalid_view}             invalid_view

*** Test Cases ***
TC_iTM_02362 TC_iTM_02364 Verify That New Wemall Header, Wemall Footer, Merchant Header, Merchant Footer are displayed on level D
    [Tags]    TC_iTM_02362     TC_iTM_02364    Ready
    Given Create Robot Shop
    And Prepare Variant
    And Prepare Robot Storefront
    When Open Lv D
    Then Check If Page Contain Wemall Header, Wemall Footer, Merchant Header, Merchant Footer

    [Teardown]    Run Keywords    Assign Backup Shop Id Back To Variant    Delete Robot Shop    Delete Storefront    Close Browser