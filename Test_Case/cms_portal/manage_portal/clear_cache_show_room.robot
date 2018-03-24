*** Settings ***
Force Tags    WLS_Manage_Shop
Resource              ${CURDIR}/../../../Resource/init.robot
Resource              ${CURDIR}/../../../Keyword/API/api_portals/showrooms_keywords.robot
Resource              ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/showrooms_keywords.robot
Resource              ${CURDIR}/../../../Keyword/Portal/portal_cms/common/common.resource.robot

*** Variables ***
${merchant_id}             Doraemon0001
${shop_name}               Doraemon
${status}                  active
${shop_slug}               doraemon

${portal}                  portal
${showroom_id}             showroom_id_clear_cache
${showroom_published}      ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_showroom_clear_cache_publish.json
${showroom_new_draft}      ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_showroom_clear_cache_new_draft.json
${textlink_published}      ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_textlinks_clear_cache_publish.json
${textlink_new_draft}      ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_textlinks_clear_cache_new_draft.json
${brand_published}         ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_brands_clear_cache_publish.json
${brand_new_draft}         ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_brands_clear_cache_new_draft.json

${Draft}                   draft
${Published}               published
${TH}                      th_TH
${EN}                      en_US

*** Test Cases ***

TC_WMALL_01717 API portal will clear cache after published portal showroom web.
    [Tags]    Regression    WLS_Medium
    [Setup]    Run Keywords    Prepare Showroom Publish All Data    ${portal}    ${showroom_id}    ${showroom_published}    ${textlink_published}    ${brand_published}
        ...    AND    Prepare Showroom Draft All Data    ${portal}    ${showroom_id}    ${showroom_new_draft}    ${textlink_new_draft}    ${brand_new_draft}
    Open Browser     ${WEMALL_WEB}/?${PRIVIEW_TOKEN}    Chrome
    Set Window Size     ${1440}    ${900}
    Select Window On Preview Portal Page
    Verify Showroom    ${portal}    ${showroom_id}    ${Draft}    ${TH}
    Go To    ${WEMALL_WEB}/en/?${PRIVIEW_TOKEN}
    Verify Showroom    ${portal}    ${showroom_id}    ${Draft}    ${EN}
    Go To    ${WEMALL_WEB}
    Verify Showroom    ${portal}    ${showroom_id}    ${Published}    ${TH}
    Go To    ${WEMALL_WEB}/en/
    Verify Showroom    ${portal}    ${showroom_id}    ${Published}    ${EN}
    Published Showroom Data    ${portal}    ${showroom_id}
    Go To    ${WEMALL_WEB}
    Verify Showroom    ${portal}    ${showroom_id}    ${Draft}    ${TH}
    Go To    ${WEMALL_WEB}/en/
    Verify Showroom    ${portal}    ${showroom_id}    ${Draft}    ${EN}

    [Teardown]    Run Keywords    Clear Showroom Data For Suite Get    ${showroom_id}
        ...       AND    Close All Browsers

TC_WMALL_01718 API portal will clear cache after published portal showroom mobile.
    [Tags]    Regression    WLS_Medium
    [Setup]    Run Keywords    Prepare Showroom Publish All Data    ${portal}    ${showroom_id}    ${showroom_published}    ${textlink_published}    ${brand_published}
        ...    AND    Prepare Showroom Draft All Data    ${portal}    ${showroom_id}    ${showroom_new_draft}    ${textlink_new_draft}    ${brand_new_draft}
    Open Browser And Set Screen
    Add Cookie      is_mobile    true
    Reload Page
    Go To    ${WEMALL_WEB}/portal/page1?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Verify Showroom mobile    ${portal}    ${showroom_id}    ${Draft}    ${TH}
    Go To    ${WEMALL_WEB}/en/portal/page1?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Verify Showroom mobile    ${portal}    ${showroom_id}    ${Draft}    ${EN}
    Go To    ${WEMALL_WEB}/portal/page1
    Verify Showroom mobile    ${portal}    ${showroom_id}    ${Published}    ${TH}
    Go To    ${WEMALL_WEB}/en/portal/page1
    Verify Showroom mobile    ${portal}    ${showroom_id}    ${Published}    ${EN}
    Published Showroom Data    ${portal}    ${showroom_id}
    Go To    ${WEMALL_WEB}/portal/page1
    Verify Showroom mobile    ${portal}    ${showroom_id}    ${Draft}    ${TH}
    Go To    ${WEMALL_WEB}/en/portal/page1
    Verify Showroom mobile    ${portal}    ${showroom_id}    ${Draft}    ${EN}

    [Teardown]    Run Keywords    Clear Showroom Data For Suite Get    ${showroom_id}
        ...       AND    Close All Browsers

*** Keyword ***
Open Browser And Set Screen
    Open Browser     ${WEMALL_WEB}    Chrome
    Set Window Position    ${0}    ${0}
    Set Window Size     ${720}    ${900}

Select Window On Preview Portal Page
      Select Window    url=${WEMALL_WEB}/?${PRIVIEW_TOKEN}

