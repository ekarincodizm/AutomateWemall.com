*** Settings ***
Suite Setup         Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Suite Teardown      Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}

Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_www_wemall/storefront_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot

*** Variables ***
${merchant_id}              ROBOT
${shop_name}                robot
${slug}                     robot
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
TC_1 - Get StoreInfo Info Success
    [Tags]    get_storefront_info
    ${response}=    Get Storefront Info
    Check Storefront Validity    ${response}

TC_2 - Get StoreInfo Info With With Non Existing Merchant Code
    [Tags]    get_storefront_info
    ${response}=    Get Non Existing Storefront Info
    Check Storefront Validity For Non Existing Storefront    ${response}