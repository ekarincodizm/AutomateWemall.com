*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/staticcontents_keywords.robot

*** Variables ***
${content}    aloha
${versionDraft}    draft
${versionPublished}    published
${en}    <p>en na ja</p>
${th}    <p>th na noo</p>
${invalidContent}    MaiMeeNaeNon

*** Test Cases ***
TC_WMALL_00208 Update Static Content Success
    [Tags]    put_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Update Static Content    ${content}    ${versionDraft}    ${en}    ${th}
    Verify PUT/POST Success

TC_WMALL_00209 Update Static Content WO TH
    [Tags]    put_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Update Static Content WO TH    ${content}    ${versionDraft}    ${en}
    Verify PUT/POST Invalid Inputs

TC_WMALL_00210 Update Static Content WO Version
    [Tags]    put_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Update Static Content WO Version    ${content}    ${en}    ${th}
    Verify PUT/POST Invalid Inputs

TC_WMALL_00211 Publish Static Content Success
    [Tags]    put_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Publish Static Content Success    ${content}    ${versionPublished}    ${en}    ${th}
    Verify PUT/POST Success

TC_WMALL_00212 Publish Static Content Fail
    [Tags]    put_staticcontents    api_staticcontents    api_portals    api_cms    Regression
    Publish Static Content Fail    ${invalidContent}    ${versionPublished}    ${en}    ${th}
    Verify Publish Fail    ${invalidContent}