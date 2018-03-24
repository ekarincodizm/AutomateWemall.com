*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/showrooms_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/textlink_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/brand_keywords.robot

*** Variables ***
${DRAFT}                    draft
${PUBLISHED}                published
${portal_module}            portal_module
${deleted_showroom_id}      deleted_showroom_id
${invalid_showroom_id}      invalid_showroom_id
${showroom_json_data}       ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_showroom.json
${REQUEST-BODY}             {"th_TH": {"sort_index": 5,"text": "hello world","link_url": "www.google.com"}}

*** Test Cases ***
TC_WMALL_00194 Delete Showroom Draft Success
    [Tags]    delete_showroom    api_showroom    api_portals    api_cms    Regression
    # Prepare Data
    PUT Data Create New Showroom    ${portal_module}    ${deleted_showroom_id}    ${DRAFT}    ${showroom_json_data}
    Verify Create New Showroom Success    ${deleted_showroom_id}
    Put Text Links Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Check Response Body For Brands Showroom Data
    Put Brands Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Check Response Body For Text Links Showroom Data
    # Delete Showroom
    Delete Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Verify Delete Showroom Data Success    ${deleted_showroom_id}
    # Verify empty
    Get Brands Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    brand_keywords.Check Response Success But Data Null
    Get Text Links Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    textlink_keywords.Check Response Success But Data Null
    GET Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Check Response Success But Data Empty
    GET Showroom Data    ${deleted_showroom_id}    ${PUBLISHED}
    Check Response Success But Data Empty

TC_WMALL_00345 Delete Showroom All Version
    [Tags]    delete_showroom    api_showroom    api_portals    api_cms    Regression
    # Prepare Data
    PUT Data Create New Showroom    ${portal_module}    ${deleted_showroom_id}    ${DRAFT}    ${showroom_json_data}
    Verify Create New Showroom Success    ${deleted_showroom_id}
    Put Text Links Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Check Response Body For Brands Showroom Data
    Put Brands Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Check Response Body For Text Links Showroom Data
    Published Showroom Data    ${portal_module}    ${deleted_showroom_id}
    Verify Published Showroom Data Success    ${deleted_showroom_id}
    # Delete Showroom
    Delete Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Verify Delete Showroom Data Success    ${deleted_showroom_id}
    Delete Showroom Data    ${deleted_showroom_id}    ${PUBLISHED}
    Verify Delete Showroom Data Success    ${deleted_showroom_id}
    # Verify empty
    Get Brands Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    brand_keywords.Check Response Success But Data Null
    Get Brands Showroom Data    ${deleted_showroom_id}    ${PUBLISHED}
    brand_keywords.Check Response Success But Data Null
    Get Text Links Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    textlink_keywords.Check Response Success But Data Null
    Get Text Links Showroom Data    ${deleted_showroom_id}    ${PUBLISHED}
    textlink_keywords.Check Response Success But Data Null
    GET Showroom Data    ${deleted_showroom_id}    ${DRAFT}
    Check Response Success But Data Empty
    GET Showroom Data    ${deleted_showroom_id}    ${PUBLISHED}
    Check Response Success But Data Empty

TC_WMALL_00346 Delete Showroom with Unknown Showroom Id
    [Tags]    delete_showroom    api_showroom    api_portals    api_cms    Regression
    Delete Showroom Data    ${invalid_showroom_id}    ${DRAFT}
    Verify Delete Showroom Data Success    ${invalid_showroom_id}
    Delete Showroom Data    ${invalid_showroom_id}    ${PUBLISHED}
    Verify Delete Showroom Data Success    ${invalid_showroom_id}



