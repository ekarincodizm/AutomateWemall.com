*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup         Prepare Brand Data For Suite Get    ${SHOWROOM-ID}
Suite Teardown      Clear Showroom Data For Suite Get    ${SHOWROOM-ID}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_portals/brand_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_portals/showrooms_keywords.robot

*** Variables ***
${SHOWROOM-ID}      showroom_id
${New-SHOWROOM-ID}  new_showroom_id
${REQUEST-BODY}     {"th_TH": {"sort_index": 1,"title": "ABC","src_web": "abc.jpg","src_mobile": "m.abc.jpg","link_url": "www.abc.com"}}
${DRAFT}            draft
${PUBLISHED}        published

*** Test Cases ***
TC_WMALL_00186 Test GET Brand Success
    [Tags]    get_brand    api_brand    api_showroom    api_portals    api_cms    Regression
    Get Brands Showroom Data    ${SHOWROOM-ID}    ${DRAFT}
    Check Response Body For Brands Showroom Data

TC_WMALL_00339 Get Text Link Version Published
    [Tags]    get_brand    api_brand    api_showroom    api_portals    api_cms    Regression
    Get Brands Showroom Data    ${SHOWROOM-ID}    ${PUBLISHED}
    Check Response Body For Brands Showroom Data

TC_WMALL_00340 Get Text Link with Invalid Showroom Id
    [Tags]    get_brand    api_brand    api_showroom    api_portals    api_cms    Regression
    Get Brands Showroom Data    invalid_showroom_id    ${DRAFT}
    Check Response Success But Data Null

TC_WMALL_00341 Get Text Link wtih Invalid Version
    [Tags]    get_brand    api_brand    api_showroom    api_portals    api_cms    Regression
    Get Brands Showroom Data    ${SHOWROOM-ID}    invalid_version
    Check Response Success But Data Null

TC_WMALL_00187 Test Put Brand Success
    [Tags]    post_brand    api_brand    api_showroom    api_portals    api_cms    Regression
    Put Brands Showroom Data    ${New-SHOWROOM-ID}    ${DRAFT}
    Check Response Body For Brands Showroom Data
    [Teardown]    Delete Showroom Data    ${New-SHOWROOM-ID}    ${DRAFT}

TC_WMALL_00188 Test Request Fail
    [Tags]    get_brand    api_brand    api_showroom    api_portals    api_cms    Regression
    Send Wrong GET Request
    Verify Reponse Failed Because API Gateway Not Nefine

TC_WMALL_00189 Test Put Invalid Json
    [Tags]    post_brand    api_brand    api_showroom    api_portals    api_cms    Regression
    Send Put with Empty Body Data    ${New-SHOWROOM-ID}    ${DRAFT}
    Check Update Failed Because Empty Body Data







