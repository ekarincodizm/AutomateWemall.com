*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup                 Prepare Template Data For Suite Get
Suite Teardown              Clear Template Data For Suite Get
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/templates_keywords.robot

*** Variables ***
${mega_menu}                mega-menu_template
${showroom}                 showroom_template
${template_01}              template_001
${name_template_01}         Template 01 for Mega-Menu
${unknown_template_type}    unknown_template_type
${unknown_template_id}      unknown_template_id

*** Test Cases ***
TC_WMALL_00275 Get All Templates in Template Type
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get All Templates    ${mega_menu}
    Verify Get All Templates Success and Data Correct    ${mega_menu}    4
    Get All Templates    ${showroom}
    Verify Get All Templates Success and Data Correct    ${showroom}    1

TC_WMALL_00276 Get Specific Template
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get Specific Template    ${mega_menu}    ${template_01}
    Verify Get Specific Template Success and Data Correct    ${mega_menu}    ${template_01}    ${name_template_01}

TC_WMALL_00277 Get All Templates with Unknown Template Type
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get All Templates    ${unknown_template_type}
    Verify Get All Templates Success but Data Empty

TC_WMALL_00278 Get Specific Template with Unknown Template Type
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get Specific Template    ${unknown_template_type}    ${template_01}
    Verify Get Specific Template Success but Data Empty

TC_WMALL_00279 Get Specific Template with Unknown Template Id
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get Specific Template    ${mega_menu}    ${unknown_template_id}
    Verify Get Specific Template Success but Data Empty




