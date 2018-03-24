*** Settings ***
Suite Setup       Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown    Run Keywords    Close All Browsers
Test Template     Switch Language
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource          ${CURDIR}/../../Keyword/Portal/wemall/header/keywords_wemall_header.robot

*** Variables ***
${username}       robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}       123456

*** Test Cases ***
Everyday Wow page header - Switch Language (WeMall_version)
    [Tags]    QCT
    ${WEMALL_WEB}/everyday-wow    /everyday-wow    /everyday-wow

Level D header - Switch Language (WeMall_version)
    [Tags]    QCT
    ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    /products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    /products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html

*** Keywords ***
Switch Language
    [Arguments]    ${full_url}    ${EN_url}    ${TH_url}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify Language Button    ${protocol}
    Switch to EN Language
    Verify Switch to EN    ${EN_url}    ${protocol}
    Switch to TH Language
    Verify Switch to TH    ${TH_url}    ${protocol}
