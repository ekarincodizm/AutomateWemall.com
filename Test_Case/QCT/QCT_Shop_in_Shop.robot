*** Settings ***
Suite Setup       Prepare Footer And Open Browser
Suite Teardown    Run Keywords    Prepare New Footer And Close All Browser
Test Template     Page Footer
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource          ${CURDIR}/../../Keyword/Portal/wemall/footer/keywords_wemall_footer.robot
Resource          ${CURDIR}/../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource          ../../Keyword/Common/keywords_wemall_common.robot

*** Variables ***
${footer_shop}    ${WEMALL_WEB}/shop/${shop_slug}
${footer_register_en}    ${ITM_URL}/en/users/register
${shop_slug}      shop-test-portal-footer2
${merchant_id}    PORTALFOOTERSHOP124598
${shop_name}      Portal Footer Shop2
${footer_shop}    ${WEMALL_WEB}/shop/${shop_slug}
${footer_shop_en}    ${WEMALL_WEB}/en/shop/${shop_slug}

*** Test Cases ***
Create Shop In Shop page
    [Tags]    QCT
    [Setup]    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    active
    ${footer_shop}    ${platform_web}    ${language_th}    ${version_published}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

Create Shop In Shop page (WeMall_English_version)
    [Tags]    QCT
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
