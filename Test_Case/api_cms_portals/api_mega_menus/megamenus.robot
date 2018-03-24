*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup                 Prepare Template Data For Suite Get Mega Menu    ${portal}    ${template_mega_menu}
Suite Teardown              Clear Template Data For Suite Get Mega Menu    ${portal}
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot

*** Variables ***
${portal}                   portal_menu_id
${department_04}            department_004
${unknown_menu_id}          unknown_menu_id
${DRAFT}                    draft
${PUBLISHED}                published
${en_US}                    en_US
${template_mega_menu}       ${CURDIR}/../../../Resource/TestData/portals/mega_menus/template_mega_menu.json

*** Test Cases ***
TC_WMALL_00163 Get Mega Menu From Portal with Default Filter
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    GET Mega Menu Data    ${portal}
    Verify Get Mega Menu Success and Data Correct    ${portal}    ${PUBLISHED}

TC_WMALL_00290 Get Mega Menus with Version Publish
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    GET Mega Menu Data Filter Version    ${portal}    ${PUBLISHED}
    Verify Get Mega Menu Success and Data Correct    ${portal}    ${PUBLISHED}

TC_WMALL_00291 Get Mega Menus with Version Draft
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    GET Mega Menu Data Filter Version    ${portal}    ${DRAFT}
    Verify Get Mega Menu Success and Data Correct    ${portal}    ${DRAFT}

TC_WMALL_00292 Get Mega Menus with Language en_US
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    GET Mega Menu Data Filter Language    ${portal}    ${en_US}
    Verify Get Mega Menu Success and Data Correct    ${portal}    ${PUBLISHED}

TC_WMALL_00293 Get Mega Menu with Unknown Menu Id
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    GET Mega Menu Data    ${unknown_menu_id}
    Verify Get Mega Menu Success but Data Empty

TC_WMALL_00294 Create Mega Menu Data
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    Create Mega Menu Data    ${department_04}
    Verify Create Mega Menu Success and Data Correct    ${department_04}    ${DRAFT}
    GET Mega Menu Data Filter Version    ${department_04}    ${DRAFT}
    Verify Get Mega Menu Success and Data Correct    ${department_04}    ${DRAFT}
    GET Mega Menu Data Filter Version    ${department_04}    ${PUBLISHED}
    Verify Get Mega Menu Success but Data Empty
    [Teardown]    Delete Mega Menu Success    ${department_04}

TC_WMALL_00295 Create Duplicate Mega Menu
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    Create Mega Menu Data    ${department_04}
    Verify Create Mega Menu Success and Data Correct    ${department_04}    ${DRAFT}
    Create Mega Menu Data    ${department_04}
    Verify Create Mega Menu Not Success Because Duplicate Mega Menu Id    ${department_04}
    [Teardown]    Delete Mega Menu Success    ${department_04}

TC_WMALL_00296 Creat Mega Menu with No Menu Id
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    Create Mega Menu Failed
    Verify Reponse Failed Because API Gateway Not Nefine

TC_WMALL_00297 Not Allowed to Update Mega Menu
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    PUT Mega Menu Failed    ${department_04}
    Verify Reponse Failed Because Not Define Handle

TC_WMALL_00298 Delete Mega Menu Data that Have Only Draft Version
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    Update Mega Menu Child Data    ${department_04}    ${template_mega_menu}    ${DRAFT}
    Verify Update Mega Menu Child Data Success
    GET Mega Menu Data Filter Version    ${portal}    ${DRAFT}
    Verify Get Mega Menu Success and Data Correct    ${portal}    ${DRAFT}
    Delete Mega Menu Data    ${department_04}
    Verify Delete Draft Mega Menu Success    ${department_04}
    GET Mega Menu Data    ${department_04}
    Verify Get Mega Menu Success but Data Empty

TC_WMALL_00299 Delete Mega Menu Data that Have Draft and Published Version
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    Update Mega Menu Child Data    ${department_04}    ${template_mega_menu}    ${DRAFT}
    Verify Update Mega Menu Child Data Success
    Publish Mega Menu Data    ${department_04}
    Verify Update Mega Menu Child Data Success
    Delete Mega Menu Data    ${department_04}
    Verify Delete Draft and Published Mega Menu Success
    GET Mega Menu Data Filter Version    ${department_04}    ${DRAFT}
    Verify Get Mega Menu Success but Data Empty
    GET Mega Menu Data Filter Version    ${department_04}    ${PUBLISHED}
    Verify Get Mega Menu Success but Data Empty

TC_WMALL_00300 Delete Mega Menu with Unknown Menu Id
    [Tags]    mega_menus    api_mega_menus    api_portals    api_cms    Regression
    Delete Mega Menu Data    ${unknown_menu_id}
    Verify Delete Mega Menu Not Success Because Menu Id Version Not Exist    ${unknown_menu_id}    ${DRAFT}
    GET Mega Menu Data    ${unknown_menu_id}
    Verify Get Mega Menu Success but Data Empty




