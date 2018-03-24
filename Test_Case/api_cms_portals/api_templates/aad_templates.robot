*** Settings ***
Force Tags    WLS_API_CMS_Portal
# Suite Setup     Prepare Get Tokens
Suite Setup       Prepare Template Data For Suite Get
Suite Teardown    Clear Template Data For Suite Get
Resource          ${CURDIR}/../../../Keyword/API/api_portals/templates_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Resource/init.robot

*** Variables ***
${mega_menu}                mega-menu_template
${showroom}                 showroom_template
${template_01}              template_001
${name_template_01}         Template 01 for Mega-Menu
${unknown_template_type}    unknown_template_type
${unknown_template_id}      unknown_template_id
${anonymousId}              anonymousId

*** Test Cases ***
TC_WMALL_00584 Authentication Get All Templates
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get Tokens from AAD    ${EMAIL}    ${PASSWORD}    ${GRANT_TYPE}
    Get All Templates    ${mega_menu}    ${anonymousId}    ${ACCESS_TOKENS}
    Verify Get All Templates Success and Data Correct    ${mega_menu}    4
    Get All Templates    ${mega_menu}    ${EMPTY}    ${ACCESS_TOKENS}
    Verify Get All Templates Success and Data Correct    ${mega_menu}    4
    Get All Templates    ${mega_menu}    ${anonymousId}    ${EMPTY}
    Verify Get All Templates Success and Data Correct    ${mega_menu}    4
    Get All Templates    ${mega_menu}    ${EMPTY}    ${EMPTY}
    Verify Get All Templates Success and Data Correct    ${mega_menu}    4

TC_WMALL_00585 Expired Token for Get All Templates
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get All Templates Failed    ${mega_menu}    ${anonymousId}    ${EXPIRED_TOKENS}
    Verify Request Failed Because Access Token Expired
    Get All Templates Failed    ${mega_menu}    ${EMPTY}    ${EXPIRED_TOKENS}
    Verify Request Failed Because Access Token Expired

TC_WMALL_00586 Authentication Get Specific Template
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get Tokens from AAD    ${EMAIL}    ${PASSWORD}    ${GRANT_TYPE}
    Get Specific Template    ${mega_menu}    ${template_01}    ${anonymousId}    ${ACCESS_TOKENS}
    Verify Get Specific Template Success and Data Correct    ${mega_menu}    ${template_01}    ${name_template_01}
    Get Specific Template    ${mega_menu}    ${template_01}    ${EMPTY}    ${ACCESS_TOKENS}
    Verify Get Specific Template Success and Data Correct    ${mega_menu}    ${template_01}    ${name_template_01}
    Get Specific Template    ${mega_menu}    ${template_01}    ${anonymousId}    ${EMPTY}
    Verify Get Specific Template Success and Data Correct    ${mega_menu}    ${template_01}    ${name_template_01}
    Get Specific Template    ${mega_menu}    ${template_01}    ${EMPTY}    ${EMPTY}
    Verify Get Specific Template Success and Data Correct    ${mega_menu}    ${template_01}    ${name_template_01}

TC_WMALL_00587 Expired Token for Get Specific Templates
    [Tags]    get_templates   api_templates    api_portals    api_cms    Regression
    Get Specific Template Failed    ${mega_menu}    ${template_01}    ${anonymousId}    ${EXPIRED_TOKENS}
    Verify Request Failed Because Access Token Expired
    Get Specific Template Failed    ${mega_menu}    ${template_01}    ${EMPTY}    ${EXPIRED_TOKENS}
    Verify Request Failed Because Access Token Expired




