*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/staticcontents_keywords.robot

*** Variables ***
${content}    aloha
${version}    draft
${en}    <p>en na ja</p>
${th}    <p>th na noo</p>

*** Test Cases ***
TC_WMALL_00205 Create Static Content Success
    [Tags]    post_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Create Static Content    ${content}    ${version}    ${en}    ${th}
    Verify PUT/POST Success

TC_WMALL_00206 Create Static Content WO TH
    [Tags]    post_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Create Static Content WO TH    ${content}    ${version}    ${en}
    Verify PUT/POST Invalid Inputs


TC_WMALL_00207 Create Static Content WO Version
    [Tags]    post_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Create Static Content WO Version    ${content}    ${en}    ${th}
    Verify PUT/POST Invalid Inputs
