*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/showrooms_keywords.robot

*** Variables ***
${DRAFT}                    draft
${PUBLISHED}                published
${portal_module}            portal_module
${new_showroom_id}          new_showroom_id
${published_showroom_id}    published_showroom_id
${showroom_json_data}       ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_showroom.json

*** Test Cases ***
TC_WMALL_00197 PUT Update Empty Data Showroom
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    PUT Update Empty Data    ${portal_module}    ${DRAFT}
    Verify PUT Update with Empty Data Failed

TC_WMALL_00198 PUT Data To Create Showroom
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    PUT Data Create New Showroom    ${portal_module}    ${new_showroom_id}    ${DRAFT}    ${showroom_json_data}
    Verify Create New Showroom Success    ${new_showroom_id}
    GET Showroom Data    ${portal_module}    ${DRAFT}
    Check Response Success and Data not Empty    ${new_showroom_id}
    GET Showroom Data    ${portal_module}    ${PUBLISHED}
    Check Response Success But Data Empty
    [Teardown]    Delete Showroom Data    ${new_showroom_id}    ${DRAFT}

TC_WMALL_00349 PUT Data To Create Showroom without Showroom Id Data
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    PUT Data Create New Showroom without Showroom Id    ${portal_module}    ${DRAFT}    ${showroom_json_data}
    ${unique_showroom_id}=    Verify Create New Showroom without Showroom Id Success
    GET Showroom Data    ${portal_module}    ${DRAFT}
    Check Response Success and Data not Empty    ${unique_showroom_id}
    GET Showroom Data    ${portal_module}    ${PUBLISHED}
    Check Response Success But Data Empty
    [Teardown]    Delete Showroom Data    ${unique_showroom_id}    ${DRAFT}

TC_WMALL_00350 PUT Update with No Sort Index
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    PUT Update with No Sort Index    ${portal_module}    ${DRAFT}
    Verify PUT Update with No Sort Index Data Failed

TC_WMALL_00351 PUT Update with No Status
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    PUT Update with No Status    ${portal_module}    ${DRAFT}
    Verify PUT Update with No Status Data Failed

TC_WMALL_00352 Published Showroom Data
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    PUT Data Create New Showroom    ${portal_module}    ${published_showroom_id}    ${DRAFT}    ${showroom_json_data}
    Verify Create New Showroom Success    ${published_showroom_id}
    Published Showroom Data    ${portal_module}    ${published_showroom_id}
    Verify Published Showroom Data Success    ${published_showroom_id}
    GET Showroom Data    ${portal_module}    ${DRAFT}
    Check Response Success and Data not Empty    ${published_showroom_id}
    GET Showroom Data    ${portal_module}    ${PUBLISHED}
    Check Response Success and Data not Empty    ${published_showroom_id}
    [Teardown]    Delete All Version of Showroom Data    ${published_showroom_id}

TC_WMALL_00353 Published Showroom Data with Empty Data
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    Published Showroom Data with Empty Data    ${portal_module}
    Verify PUT Update with Empty Data Failed

TC_WMALL_00354 Published Showroom Data without Showroom Id
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    Published Showroom Data without Showroom Id    ${portal_module}
    Verify PUT Update without Showroom Id Failed

TC_WMALL_00355 Published Showroom Data with Showroom Id That Not Exist
    [Tags]    put_showroom    api_showroom    api_portals    api_cms    Regression
    Published Showroom Data with Showroom Id That Not Exist    ${portal_module}
    Verify PUT Update with Showroom Id That Not Exist Failed

