*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/staticcontents_keywords.robot

*** Variables ***
${content}    using-coupon
${invalidContent}    roboto
${version}    draft
${invalidVersion}    NAJA
${en}    en_US
${th}    th_TH

*** Test Cases ***
TC_WMALL_00199 Get Item UsingCoupon Success
    [Tags]    get_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Get Static Content By content    ${content}
    Verify Get Response

TC_WMALL_00200 Get Item UsingCoupon Success With Lang TH
    [Tags]    get_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Get Static Content By content and lang    ${content}    ${th}
    Verify Get Response With Specify Lang    ${th}

TC_WMALL_00201 Get Item Roboto Not Found
    [Tags]    get_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Get Static Content By content    ${invalidContent}
    Verify Get Response Data Not Found

TC_WMALL_00202 Get Item UsingCoupon Draft Success
    [Tags]    get_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Get Static Content By content and version   ${content}    ${version}
    Verify Get Response

TC_WMALL_00203 Get Item UsingCoupon Draft Success With Lang en_US
    [Tags]    get_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Get Static Content By content and version and lang    ${content}    ${version}    ${en}
    Verify Get Response With Specify Lang    ${en}

TC_WMALL_00204 Get Item UsingCoupon Version NAJA Not Found
    [Tags]    get_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Get Static Content By content and version    ${content}    ${invalidVersion}
    Verify Get Response Data Not Found

