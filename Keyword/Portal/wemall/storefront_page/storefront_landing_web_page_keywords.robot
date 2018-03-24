*** Settings ***
Library         Selenium2Library
Resource        ${CURDIR}/../common/web_common_keywords.robot
Resource        ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot
Resource        ${CURDIR}/webelement_storefront_page.robot

*** Variables ***
${shop_slug_active}         itruemart-slug01
${merchant_id_active}       ITM0111101
${shop_slug_inactive}       itruemart-slug02
${merchant_id_inactive}     ITM0111102
${shop_slug_waiting}        itruemart-slug03
${merchant_id_waiting}      ITM0111103
${shop_slug_not_found}      PageNotFound
${page_not_found}           pageNotFound
${body_post_template}       ${CURDIR}/../../../../Resource/TestData/storefronts/shops_data/post_shop_template.json

*** Keywords ***
########## Prepare ##########
Prepare Landing Page Data
    ${shop_id_active}=    Create Shop Success and Data Correct    ${body_post_template}    ${merchant_id_active}    ${shop_slug_active}    ${shop_slug_active}    active
    Set Suite Variable    ${shop_id_active}    ${shop_id_active}
    Prepare Storefront Content by Storefront API    ${shop_id_active}

    ${shop_id_inactive}=    Create Shop Success and Data Correct    ${body_post_template}    ${merchant_id_inactive}    ${shop_slug_inactive}    ${shop_slug_inactive}    inactive
    Set Suite Variable    ${shop_id_inactive}    ${shop_id_inactive}
    Prepare Storefront Content by Storefront API    ${shop_id_inactive}

    ${shop_id_waiting}=    Create Shop Success and Data Correct    ${body_post_template}    ${merchant_id_waiting}    ${shop_slug_waiting}    ${shop_slug_waiting}    inactive
    Set Suite Variable    ${shop_id_waiting}    ${shop_id_waiting}
    Prepare Storefront Content by Storefront API    ${shop_id_waiting}

Delete Landing Page Prepare Data
    Delete Storefront Web and Mobile All Type and All Version     ${shop_id_active}
    Delete Storefront Web and Mobile All Type and All Version     ${shop_id_inactive}
    Delete Storefront Web and Mobile All Type and All Version     ${shop_id_waiting}

Open Wemall Browser
    # Use ITM because we block wemall homepage
    Open Browser and Maximize Window    ${ITM_URL}    ${BROWSER}

Go To Wemall
    # Use ITM because we block wemall homepage
    Go To    ${ITM_URL}

Go To Active Merchant
    Go To    ${WEMALL_WEB}/shop/${shop_slug_active}

Go To Waiting Merchant
    Go To    ${WEMALL_WEB}/shop/${shop_slug_waiting}

Go To Waiting Merchant With Secondary Language
    Go To    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug_waiting}

Go To Inactive Merchant
    Go To    ${WEMALL_WEB}/shop/${shop_slug_inactive}

Go To Not Found MerChant
    Go To    ${WEMALL_WEB}/shop/${shop_slug_not_found}

Show Correct Merchant
    Location Should Contain    ${WEMALL_WEB}/shop/${shop_slug_active}

Show Page Not Found
    Location Should Contain    ${WEMALL_WEB}/${page_not_found}

Show Correct Merchant With Secondary Language
    Location Should Contain    ${WEMALL_WEB}/en/shop/${shop_slug_active}

Go To Active Merchant With Secondary Language
    Go To    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug_active}

Go To Inactive Merchant With Secondary Language
    Go To    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug_inactive}

Go To Not Found MerChant With Secondary Language
    Go To    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug_not_found}

Add Cookie Mobile
    Delete Cookie    is_mobile
    Add Cookie       is_mobile    true

Show Mobile Web
    ${coockie}=  Get Cookie Value    is_mobile
    Should Be Equal    ${coockie}    true

Go To Potal Page
    Go To    ${WEMALL_WEB}

Go To Potal Page With Dot In URL
    Go To    ${WEMALL_WEB}/xxx.jpg

Go To Potal Page With Controller And Action In URL Should Not Show
    Go To    ${WEMALL_WEB}/index/index

Go To Shop TH
    [Arguments]    ${shop_slug}
    Go To    ${WEMALL_WEB}/shop/${shop_slug}

Go To Shop EN
    [Arguments]    ${shop_slug}
    Go To    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug}
