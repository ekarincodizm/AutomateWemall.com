*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup         Prepare Text Link Data For Suite Get    ${SHOWROOM-ID}
Suite Teardown      Clear Showroom Data For Suite Get    ${SHOWROOM-ID}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_portals/textlink_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_portals/showrooms_keywords.robot

*** Variables ***
${SHOWROOM-ID}      showroom_id
${New-SHOWROOM-ID}  new_showroom_id
${REQUEST-BODY}     {"th_TH": {"sort_index": 5,"text": "hello world","link_url": "www.google.com"}}
${DRAFT}            draft
${PUBLISHED}        published

*** Test Cases ***
TC_WMALL_00190 Test GET Text Link Success
    [Tags]    get_text_link    api_text_link    api_showroom    api_portals    api_cms    Regression
    Get Text Links Showroom Data    ${SHOWROOM-ID}    ${DRAFT}
    Check Response Body For Text Links Showroom Data

TC_WMALL_00342 Get Text Link Version Published
    [Tags]    get_text_link    api_text_link    api_showroom    api_portals    api_cms    Regression
    Get Text Links Showroom Data    ${SHOWROOM-ID}    ${PUBLISHED}
    Check Response Body For Text Links Showroom Data

TC_WMALL_00343 Get Text Link with Invalid Showroom Id
    [Tags]    get_text_link    api_text_link    api_showroom    api_portals    api_cms    Regression
    Get Text Links Showroom Data    invalid_showroom_id    ${DRAFT}
    Check Response Success But Data Null

TC_WMALL_00344 Get Text Link wtih Invalid Version
    [Tags]    get_text_link    api_text_link    api_showroom    api_portals    api_cms    Regression
    Get Text Links Showroom Data    ${SHOWROOM-ID}    invalid_version
    Check Response Success But Data Null

TC_WMALL_00191 Test Put Text Link Success
    [Tags]    post_text_link    api_text_link    api_showroom    api_portals    api_cms    Regression
    Put Text Links Showroom Data    ${New-SHOWROOM-ID}    ${DRAFT}
    Check Response Body For Text Links Showroom Data
    [Teardown]    Delete Showroom Data    ${New-SHOWROOM-ID}    ${DRAFT}

TC_WMALL_00192 Test Request Fail
    [Tags]    get_text_link    api_text_link    api_showroom    api_portals    api_cms    Regression
    Send Wrong GET Request
    Verify Reponse Failed Because API Gateway Not Nefine

TC_WMALL_00193 Test Put with Empty Body Data
    [Tags]    post_text_link    api_text_link    api_showroom    api_portals    api_cms    Regression
    Send PUT with Empty Body Data    ${New-SHOWROOM-ID}    ${DRAFT}
    Check Update Failed Because Empty Body Data








