*** Settings ***
Suite Setup       Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown    Run Keywords    Close All Browsers
Test Template     Search Product
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource          ${CURDIR}/../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Search_page/Keywords_SearchPage.robot

*** Test Cases ***
Level C brand page header - Search Product (WeMall_version)
    [Tags]    QCT
    ${WEMALL_WEB}/brand/samsung-6931849325692.html

TC_iTM_01742 - Level D page header - Search Product (iTM_version)
    [Tags]    regression    iTM_header
    ${WEMALL_WEB}/products/bonzart-ampel-black-2854712898105.htm

*** Keywords ***
Search Product
    [Arguments]    ${full_url}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Verify Search Box Exist
    Verify Autosuggestion    iphone
    Search Product in WeMall    iphone
    Verify Search Result Label    iphone
    Verify Search Text Box and Page Will Redirect to Search Page    iphone
