*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup                 Prepare Template Data For Suite Get Mega Menu    ${portal}    ${template_mega_menu}
Suite Teardown              Clear Template Data For Suite Get Mega Menu    ${portal}
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot

*** Variables ***
${department_01}            department_001
${portal}                   portal_menu_id
${unknown_menu_id}          unknown_menu_id
${DRAFT}                    draft
${PUBLISHED}                published
${template_mega_menu}       ${CURDIR}/../../../Resource/TestData/portals/mega_menus/template_mega_menu.json

*** Test Cases ***
TC_WMALL_00164 Get Mega Menus Child with Default Filter
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    GET Mega Menu Child Data    ${portal}
    Verify Get Mega Menu Child Success and Data Correct    ${portal}    ${DRAFT}

TC_WMALL_00301 Get Mega Menus Child with Version Publish
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Get Mega Menu Child Data Filter Version    ${portal}    ${PUBLISHED}
    Verify Get Mega Menu Child Success and Data Correct    ${portal}    ${PUBLISHED}

TC_WMALL_00302 Get Mega Menus Child with Version Draft
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Get Mega Menu Child Data Filter Version    ${portal}    ${DRAFT}
    Verify Get Mega Menu Child Success and Data Correct    ${portal}    ${DRAFT}

TC_WMALL_00303 Get Mega Menu Child with Unknown Menu Id
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    GET Mega Menu Child Data    ${unknown_menu_id}
    Verify Get Mega Menu Child Success but Data Empty

TC_WMALL_00165 Update Mega Menus Child Data
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Update Mega Menu Child Data    ${department_01}    ${template_mega_menu}    ${DRAFT}
    Verify Update Mega Menu Child Data Success
    GET Mega Menu Data Filter Version    ${department_01}    ${DRAFT}
    Verify Get Mega Menu Success and Data Correct    ${department_01}    ${DRAFT}
    [Teardown]    Delete Mega Menu Success    ${department_01}

TC_WMALL_00166 Update Mega Menus Child with Empty Data
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Update Mega Menu Child with Empty Data    ${department_01}
    Verify Update Mega Menu Child with Empty Data Failed
    GET Mega Menu Child Data    ${department_01}
    Verify Get Mega Menu Child Success but Data Empty

TC_WMALL_00304 Update Mega Menus Child with No Node Data
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Update Mega Menu Child with No Node Data    ${department_01}
    Verify Update Mega Menu Child with No Node Data
    GET Mega Menu Child Data    ${department_01}
    Verify Get Mega Menu Child Success but Data Empty

TC_WMALL_00305 Update Mega Menus Child with No Node Version
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Update Mega Menu Child with No Node Version    ${department_01}
    Verify Update Mega Menu Child with No Node Version
    GET Mega Menu Child Data    ${department_01}
    Verify Get Mega Menu Child Success but Data Empty

TC_WMALL_00306 Published Mega Menu Data
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Update Mega Menu Child Data    ${department_01}    ${template_mega_menu}    ${DRAFT}
    Verify Update Mega Menu Child Data Success
    GET Mega Menu Data Filter Version    ${department_01}    ${PUBLISHED}
    Verify Get Mega Menu Success but Data Empty
    Publish Mega Menu Data    ${department_01}
    Verify Update Mega Menu Child Data Success
    GET Mega Menu Data Filter Version    ${department_01}    ${PUBLISHED}
    Verify Get Mega Menu Success and Data Correct    ${department_01}    ${PUBLISHED}
    [Teardown]    Delete Mega Menu Success    ${department_01}

TC_WMALL_00307 Not Allowed to Delete Mega Menu Child
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Delete Mega Menu Child Failed    ${department_01}
    Verify Reponse Failed Because Not Define Handle

TC_WMALL_00308 Not Allowed to Create Mega Menu Child
    [Tags]    mega_menus_child    api_mega_menus    api_portals    api_cms    Regression
    Create Mega Menu Child Failed    ${department_01}
    Verify Reponse Failed Because Not Define Handle
