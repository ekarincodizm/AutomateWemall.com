*** Settings ***
Library             RequestsLibrary
Test Setup          Open Browser and Go to Specific URL    ${ITM_URL}

Library     Selenium2Library
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource    ${CURDIR}/../../../Keyword/Portal/wemall/lv_d/lv_d.robot
Resource    ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot

Suite Setup         Create Robot Shop And Prepare Robot Storefront
Suite Teardown      Run Keywords    Assign Backup Shop Id Back To Variant
                    ...             Delete Robot Shop
                    ...             Delete Storefront

Test Template       Merchant Header - Footer
Test Teardown       Close Browser

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

*** Test Cases ***
TC_WMALL_XXXXX - Home Merchant Header - Footer (WeMall_version) Desktop
    ${ITM_URL}/itruemart    ${ITM_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - Home Merchant Header - Footer (WeMall_version) Mobile
    ${ITM_MOBILE_URL}/itruemart    ${ITM_MOBILE_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - Truemove H Merchant Header - Footer (WeMall_version) Desktop
    ${ITM_URL}/truemove-h    ${ITM_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - Truemove H Merchant Header - Footer (WeMall_version) Mobile
    ${ITM_MOBILE_URL}/truemove-h    ${ITM_MOBILE_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - Truemove H Registration Merchant Header - Footer (WeMall_version) Desktop
    ${ITM_URL}/truemove-h/registration    ${ITM_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - Truemove H Registration Merchant Header - Footer (WeMall_version) Mobile
    ${ITM_MOBILE_URL}/truemove-h/registration    ${ITM_MOBILE_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - MNP Merchant Header - Footer (WeMall_version) Desktop
    ${ITM_URL}/truemove-h/mnp    ${ITM_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - MNP Merchant Header - Footer (WeMall_version) Mobile
    ${ITM_MOBILE_URL}/truemove-h/mnp    ${ITM_MOBILE_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - MNP Registration Merchant Header - Footer (WeMall_version) Desktop
    ${ITM_URL}/truemove-h/mnp/registration    ${ITM_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - MNP Registration Merchant Header - Footer (WeMall_version) Mobile
    ${ITM_MOBILE_URL}/truemove-h/mnp/registration    ${ITM_MOBILE_URL}    http
    [tags]    regression    wemall_merchant_header

TC_WMALL_XXXXX - Level D Merchant Header - Footer (WeMall_version) Desktop
    ${ITM_URL}/products/${suite.product_p_key}.html    ${ITM_URL}    http
    [tags]    regression    wemall_merchant_header    lv_d
