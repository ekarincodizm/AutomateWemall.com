*** Settings ***
Suite Teardown    Run Keywords    Close All Browsers
Test Template     Search with XSS
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Search_page/Keywords_SearchPage.robot
# Library           ${CURDIR}/../../../Python_Library/alert.py

*** Variables ***
${xss}       ""q=%22%3E%3Cimg%20src=x%20onerrror=document.body.innerHTML=location.hash%3E#""><img src=x onerror=prompt(1)>&per_page=60&page=""
${xss_encode}       %22%22q%3D%22%3E%3Cimg%20src%3Dx%20onerrror%3Ddocument.body.innerHTML%3Dlocation.hash%3E#%22%22%3E%3Cimg%20src=x%20onerror=prompt(1)%3E&per_page=60&page=%22%22

*** Test Cases ***
TC_WMALL_01725 Security - XSS search box [portal]    ${WEMALL_WEB}

TC_WMALL_01725 Security - XSS search box [brand]    ${WEMALL_WEB}/brand/samsung-6931849325692.html

TC_WMALL_01725 Security - XSS search box [shop in shop]    ${WEMALL_WEB}/shop/canon

TC_WMALL_01725 Security - XSS search box [level-c]    ${WEMALL_WEB}/category/all-mobile-tablet-3193015175820.html

TC_WMALL_01725 Security - XSS search box [level-d]    ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html

# TC_WMALL_01725 - Security - XSS on url address [search]    ${WEMALL_WEB}/search2?q=${xss_encode}

*** Keywords ***
Search with XSS
    [Arguments]    ${full_url}    ${protocol}=http
    Open Browser and Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify Search Box Exist
    Search Product in WeMall    ${xss}
    ${alert_is_present}=    Run Keyword And Return Status    Alert Should Be Present
    Run Keyword If    ${alert_is_present}    Dismiss Alert
    Run Keyword If    ${alert_is_present}    Dismiss Alert
    Should Not Be True    ${alert_is_present}
    [Teardown]    Close Browser