*** Settings ***
Force Tags        WLS_Wemall_Portal_Page
Suite Setup       Open Wemall Browser
Suite Teardown    Close All Browsers
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/sticky_header/keywords_sticky_header.robot

*** Variables ***
${expectedBannerURL}      http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/06/mainbanner/WeMall-BG-Final.jpg

*** Test Cases ***
TC_WMALL_01761 Check Backgroud Portal Image
    [Tags]    Regression    Portal    TC_WMALL_01761    WLS_High
    Go to Specific URL     ${WEMALL_WEB}?debug-js=true
    Verify Backgroud Portal Image    ${expectedBannerURL}

TC_ITMWM_06806 Portal page - Showroom menu navigation
    [Tags]    Portal    navigation    TC_ITMWM_06806
    # TH Language
    # Set Selenium Speed    0.2
    # Maximize Browser Window
    # Set Window Size       ${1280}    ${800}
    Go to Specific URL    ${WEMALL_WEB}
    Check Location Contain    ${WEMALL_WEB}    http
    Scroll Page To Element    wm    .page-portal
    Showroom menu navigation Should Not Show
    Scroll Page To Element    wm    .wm-floor-box .wm-title-floor-box
    Sleep    5
    Showroom menu navigation Should Show
    # EN Language
    Go to Specific URL    ${WEMALL_WEB}/en/
    Check Location Contain    ${WEMALL_WEB}/en/    http
    Scroll Page To Element    wm    .page-portal
    Showroom menu navigation Should Not Show
    Scroll Page To Element    wm    .wm-floor-box .wm-title-floor-box
    Sleep    5
    Showroom menu navigation Should Show

TC_ITMWM_06807 Portal page - Back to Top button
    [Tags]    Regression    Portal    navigation    TC_ITMWM_06807    WLS_Medium
    # TH Language
    Go to Specific URL    ${WEMALL_WEB}
    Check Location Contain    ${WEMALL_WEB}    http
    Scroll Page To Element    wm    .page-portal
    Back To Top Button Not Show    wm
    Scroll Page To Element    wm    .wm-floor-box .wm-title-floor-box
    Back To Top Button Show    wm
    Click Back To Top Button
    Back To Top Button Not Show    wm
    Sticky Header Should Not Show
    Showroom menu navigation Should Not Show
    # EN Language
    Go to Specific URL    ${WEMALL_WEB}/en/
    Check Location Contain    ${WEMALL_WEB}/en/    http
    Scroll Page To Element    wm    .page-portal
    Back To Top Button Not Show    wm
    Scroll Page To Element    wm    .wm-floor-box .wm-title-floor-box
    Back To Top Button Show    wm
    Click Back To Top Button
    Back To Top Button Not Show    wm
    Sticky Header Should Not Show
    Showroom menu navigation Should Not Show

