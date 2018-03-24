*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup         Prepare Showroom Data For Suite Get    ${portal_module}    ${showroom_id}
Suite Teardown      Clear Showroom Data For Suite Get    ${showroom_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/showrooms_keywords.robot

*** Variables ***
${portal_module}        portal_module
${showroom_id}          showroom_id
${DRAFT}                draft
${PUBLISHED}            published

*** Test Cases ***
TC_WMALL_00195 GET Showrooms API
    [Tags]    get_showroom    api_showroom    api_portals    api_cms    Regression
    GET Showroom Data    ${portal_module}    ${DRAFT}
    Check Response Success and Data not Empty    ${showroom_id}

TC_WMALL_00196 Get Showeooms Version Published
    [Tags]    get_showroom    api_showroom    api_portals    api_cms    Regression
    GET Showroom Data    ${portal_module}    ${PUBLISHED}
    Check Response Success and Data not Empty    ${showroom_id}

TC_WMALL_00347 Get Showroom with Invalid Module Key
    [Tags]    get_showroom    api_showroom    api_portals    api_cms    Regression
    GET Showroom Data    invalid_module_key    ${DRAFT}
    Check Response Success But Data Empty

TC_WMALL_00348 Get Showroom wtih Invalid Version
    [Tags]    get_showroom    api_showroom    api_portals    api_cms    Regression
    GET Showroom Data    ${portal_module}    invalid_version
    Check Response Success But Data Empty