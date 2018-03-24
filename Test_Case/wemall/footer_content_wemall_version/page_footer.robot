*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_footer
Suite Setup       Prepare Footer And Open Browser
Suite Teardown    Run Keywords    Prepare New Footer And Close All Browser
Test Template     Page Footer
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/footer/keywords_wemall_footer.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot

*** Variables ***
${footer_category}    ${ITM_URL}/category/tablet-3363917653771.html
${footer_every_wow}    ${ITM_URL}/everyday-wow
${footer_search}    ${ITM_URL}/search2?q=Apple
${footer_brand}    ${ITM_URL}/brand/samsung-6931849325692.html
${footer_login}    ${ITM_URL}/auth/login
${footer_forget_password}    ${ITM_URL}/forgot_password
${footer_register}    ${ITM_URL}/users/register
${footer_category_en}    ${ITM_URL}/en/category/tablet-3363917653771.html
${footer_every_wow_en}    ${ITM_URL}/en/everyday-wow
${footer_search_en}    ${ITM_URL}/en/search2?q=Apple
${footer_brand_en}    ${ITM_URL}/en/brand/samsung-6931849325692.html
${footer_login_en}    ${ITM_URL}/en/auth/login
${footer_forget_password_en}    ${ITM_URL}/en/forgot_password
${footer_register_en}    ${ITM_URL}/en/users/register
${shop_slug}      shop-test-portal-footer2
${merchant_id}    PORTALFOOTERSHOP124598
${shop_name}      Portal Footer Shop2
${footer_shop}    ${WEMALL_WEB}/shop/${shop_slug}
${footer_shop_en}    ${WEMALL_WEB}/en/shop/${shop_slug}

*** Test Cases ***
TC_WMALL_01488 Portal page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01488    WLS_Medium
    ${ITM_URL}    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01489 Category page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01489    WLS_Medium
    ${footer_category}?no-cache=1    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01490 Every wow page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01490    WLS_Medium
    ${footer_every_wow}?no-cache=1    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01491 Search page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01491    WLS_Medium
    ${footer_search}&no-cache=1    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01492 Brand page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01492    WLS_Medium
    ${footer_brand}?no-cache=1    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01493 Login page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01493    WLS_Medium
    ${footer_login}?no-cache=1    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01494 Forget Password page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01494    WLS_Medium
    ${footer_forget_password}?no-cache=1    ${platform_web}    ${language_th}    ${version_published}

TC_ITMWM_03996 Footer on Lv.C for Merchant page footer (WeMall_version)
    [Tags]    lyra
    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01495 Register page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01495    WLS_Medium
    ${footer_register}?no-cache=1    ${platform_web}    ${language_th}    ${version_published}

TC_WMALL_01496 Shop In Shop page footer (WeMall_version)
    [Tags]    regression    TC_WMALL_01496    WLS_Medium
    [Setup]    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    active
    ${footer_shop}    ${platform_web}    ${language_th}    ${version_published}
    ### English Version ####
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01497 Portal page footer (WeMall English_version)
    [Tags]    regression    TC_WMALL_01497    WLS_Medium
    ${ITM_URL}/en/?no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01498 Category page footer (WeMall_English version)
    [Tags]    regression    TC_WMALL_01498    WLS_Medium
    ${footer_category_en}?no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01499 Every wow page footer (WeMall_English version)
    [Tags]    regression    TC_WMALL_01499    WLS_Medium
    ${footer_every_wow_en}?no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01500 Search page footer (WeMall_English version)
    [Tags]    regression    TC_WMALL_01500    WLS_Medium
    ${footer_search_en}&no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01501 Brand page footer (WeMall_English version)
    [Tags]    regression    TC_WMALL_01501    WLS_Medium
    ${footer_brand_en}?no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01502 Login page footer (WeMall_English version)
    [Tags]    regression    TC_WMALL_01502    WLS_Medium
    ${footer_login_en}?no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01503 Forget Password page footer (WeMall_English version)
    [Tags]    regression    TC_WMALL_01503    WLS_Medium
    ${footer_forget_password_en}?no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01504 Register page footer (WeMall_English version)
    [Tags]    regression    TC_WMALL_01504    WLS_Medium
    ${footer_register_en}?no-cache=1    ${platform_web}    ${language_en}    ${version_published}

TC_WMALL_01505 Shop In Shop page footer (WeMall_English_version)
    [Tags]    regression    TC_WMALL_01505    WLS_Medium
    [Setup]    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    active
    ${footer_shop_en}    ${platform_web}    ${language_en}    ${version_published}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

*** Keywords ***
Page Footer
    [Arguments]    ${full_url}    ${platform}    ${language}    ${version}    ${protocol}=http
    Verify Footer Page    ${full_url}
    Verify Link On Footer Page With Api data    ${platform}    ${language}    ${version}

Prepare Footer And Open Browser
    Comment    We need to prepare a draft version before publish version because the API will copy from a draft to a publish version
    Prepare Footer Data By Called API    ${json_footer_draft}
    Prepare Footer Data By Called API    ${json_footer_publish}
    Open Browser and Go to Specific URL    ${ITM_URL}

Prepare New Footer And Close All Browser
    Prepare Footer Data By Called API    ${json_footer_draft2}
    Prepare Footer Data By Called API    ${json_footer_publish2}
    Close All Browsers
