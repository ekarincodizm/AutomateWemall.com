*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/templates_keywords.robot

*** Variables ***
${mega_menu}                mega-menu_template
${template_01}              template_0011233
${not_exist_tmplate}        not_exist_tmplate
${template_json_data}       ${CURDIR}/../../../Resource/TestData/portals/templates/put_templates_01.json

*** Test Cases ***
TC_WMALL_00287 Delete Exist Template
    [Tags]    delete_templates   api_templates    api_portals    api_cms    Regression
    Create Template Data    ${mega_menu}    ${template_01}    ${template_json_data}
    Verify Put Response Success and Data Correct    ${mega_menu}    ${template_01}
    Delete Template Data    ${mega_menu}    ${template_01}
    Verify Delete Response Success
    Get Specific Template    ${mega_menu}    ${template_01}
    Verify Get Specific Template Success but Data Empty

TC_WMALL_00288 Delete Not Exist Template
    [Tags]    delete_templates   api_templates    api_portals    api_cms    Regression
    Delete Template Data    ${mega_menu}    ${not_exist_tmplate}
    Verify Delete Response Success
    Get Specific Template    ${mega_menu}    ${not_exist_tmplate}
    Verify Get Specific Template Success but Data Empty

TC_WMALL_00289 Not Allowed Delete All Templates
    [Tags]    delete_templates   api_templates    api_portals    api_cms    Regression
    Delete All Templates Failed    ${mega_menu}
    Verify Reponse Failed Because API Gateway Not Nefine





