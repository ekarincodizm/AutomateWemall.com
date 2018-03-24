*** Settings ***
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/sticky_header/keywords_sticky_header.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Search_page/Keywords_SearchPage.robot
Library             ${CURDIR}/../../../Python_Library/common/web_element_library.py
Test Template       Sticky Header Search Box

*** Variables ***
${xss}       ""q=%22%3E%3Cimg%20src=x%20onerrror=document.body.innerHTML=location.hash%3E#""><img src=x onerror=prompt(1)>&per_page=60&page=""
${xss_encode}       %22%22q%3D%22%3E%3Cimg%20src%3Dx%20onerrror%3Ddocument.body.innerHTML%3Dlocation.hash%3E#%22%22%3E%3Cimg%20src=x%20onerror=prompt(1)%3E&per_page=60&page=%22%22

*** Test Cases ***
TC_WMALL_01726 Security - XSS search box [portal]    ${WEMALL_WEB}    .content-portal    wm

TC_WMALL_01726 Security - XSS search box [brand]    ${WEMALL_WEB}/brand/samsung-6931849325692.html    jquery=#link_map    itm
# link_map   .home__container.l-category
TC_WMALL_01726 Security - XSS search box [level-c]    ${WEMALL_WEB}/category/all-mobile-tablet-3193015175820.html    jquery=.home__container.l-category    itm

TC_WMALL_01726 Security - XSS search box [level-d]    ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    jquery=.breadcrumb__inner_wrapper    itm

*** Keywords ***
Sticky Header Search Box
    [Arguments]    ${full_url}    ${point_element}    ${server}    ${protocol}=http
    Open Browser and Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Sticky Header Should Not Show
    Scroll Page To Element    ${server}    ${point_element}
    Sticky Header Should Show
    Verify Search Box and Search Icon Exist
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_search_box}
    Input Text    ${sticky_search_box}     ${xss}
    Click Sticky Search Button
    ${alert_is_present}=    Run Keyword And Return Status    Alert Should Be Present
    Run Keyword If    ${alert_is_present}    Dismiss Alert
    Run Keyword If    ${alert_is_present}    Dismiss Alert
    Should Not Be True    ${alert_is_present}
    [Teardown]    Close Browser

