*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup                 Create Template Data    ${mega_menu}    ${template_02}    ${prepare_json_data}
Suite Teardown              Delete Template Success    ${mega_menu}    ${template_02}
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/templates_keywords.robot

*** Variables ***
${mega_menu}                mega-menu_template
${new_template_type}        new_template_type
${name_new_template}        Template 01 for Mega-Menu
${new_template_01}          new_template_001
${new_template_02}          new_template_002
${template_02}              template_002_for_put
${template_json_data}       ${CURDIR}/../../../Resource/TestData/portals/templates/put_templates_01.json
${prepare_json_data}        ${CURDIR}/../../../Resource/TestData/portals/templates/put_templates_02.json

*** Test Cases ***
TC_WMALL_00280 Create New Template with Exist Template Type
    [Tags]    put_templates   api_templates    api_portals    api_cms    Regression
    Create Template Data    ${mega_menu}    ${new_template_01}    ${template_json_data}
    Verify Create Success and Response Data Correct    ${mega_menu}    ${new_template_01}
    Get Specific Template    ${mega_menu}    ${new_template_01}
    Verify Get Specific Template Success and Data Correct    ${mega_menu}    ${new_template_01}    ${name_new_template}
    [Teardown]    Delete Template Success    ${mega_menu}    ${new_template_01}

TC_WMALL_00281 Create New Template with New Template Type
    [Tags]    put_templates   api_templates    api_portals    api_cms    Regression
    Create Template Data    ${new_template_type}    ${new_template_01}    ${template_json_data}
    Verify Create Success and Response Data Correct    ${new_template_type}    ${new_template_01}
    Get Specific Template    ${new_template_type}    ${new_template_01}
    Verify Get Specific Template Success and Data Correct    ${new_template_type}    ${new_template_01}    ${name_new_template}
    [Teardown]    Delete Template Success    ${new_template_type}    ${new_template_01}

TC_WMALL_00282 Create New Template with Empty Data
    [Tags]    put_templates   api_templates    api_portals    api_cms    Regression
    Create Template with Empty Data
    Verify Put Template Failed Because No Template Type in json Body

TC_WMALL_00283 Update Template Data
    [Tags]    put_templates   api_templates    api_portals    api_cms    Regression
    Update Template Data    ${mega_menu}    ${template_02}    ${template_json_data}
    Verify Update Success and Response Data Correct    ${mega_menu}    ${template_02}
    Get Specific Template    ${mega_menu}    ${template_02}
    Verify Get Specific Template Success and Data Correct    ${mega_menu}    ${template_02}    ${name_new_template}

TC_WMALL_00284 Update Template with Empty Data
    [Tags]    put_templates   api_templates    api_portals    api_cms    Regression
    Update Template with Empty Data
    Verify Put Template Failed Because No Template Type in json Body

TC_WMALL_00285 Put Tempate with No Template Type in Body
    [Tags]    put_templates   api_templates    api_portals    api_cms    Regression
    Put Data with out Template Type in Body    ${template_02}    ${template_json_data}
    Verify Put Template Failed Because No Template Type in json Body

TC_WMALL_00286 Put Tempate with No Template ID in Body
    [Tags]    put_templates   api_templates    api_portals    api_cms    Regression
    Put Data with out Template Id in Body    ${mega_menu}    ${template_json_data}
    Verify Put Template Failed Because No Template Id in json Body





