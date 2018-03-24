*** Settings ***
Force Tags        WLS_Manage_Shop
Resource          ${CURDIR}/../../../Resource/init.robot    
Suite Teardown    Run Keywords    Close All Browsers
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/member_profile/keywords_member_profile.robot
Library           ../../../Python_Library/util/browser.py

*** Variables ***
### WEB
${username}       robot01@mail.com
${user_display_on_header}    Robot01@ma...
${user_display_name}    Robot01@mail.com
${password}       123456
${username2}      robot02@mail.com
${user_display_on_header2}    robot02
${user_display_name2}    robot02
${username3}      robot03@mail.com
${user_display_on_header3}    robot03
${user_display_name3}    robot03

*** Test Cases ***
TC_WMALL_01727 API portal will clear cache after published portal display name web.
    [Tags]    Regression    WLS_Medium
    Member User    ${WEMALL_WEB}    ${username}    ${password}    ${user_display_on_header}
    Go To    ${WEMALL_WEB}/en
    Verify User Display Name    ${user_display_on_header}
    Member User    ${WEMALL_WEB}    ${username2}    ${password}    ${user_display_on_header2}
    Go To    ${WEMALL_WEB}/en
    Verify User Display Name    ${user_display_on_header2}
    Member User    ${WEMALL_WEB}    ${username3}    ${password}    ${user_display_on_header3}
    Go To    ${WEMALL_WEB}/en
    Verify User Display Name    ${user_display_on_header3}

TC_WMALL_01728
    [Documentation]    API portal will clear cache after published portal display name mobile.
    [Tags]    Regression    TC_WMALL_01728    WLS_Medium
    Member On Mobile    ${WEMALL_MOBILE_URL}    ${username}    ${password}    ${user_display_name}
    Go To    ${WEMALL_MOBILE_URL}/en
    Verify Display Name On Mobile    ${user_display_name}
    Member On Mobile    ${WEMALL_MOBILE_URL}    ${username2}    ${password}    ${user_display_name2}
    Go To    ${WEMALL_MOBILE_URL}/en
    Verify Display Name On Mobile    ${user_display_name2}
    Member On Mobile    ${WEMALL_MOBILE_URL}    ${username3}    ${password}    ${user_display_name3}
    Go To    ${WEMALL_MOBILE_URL}/en
    Verify Display Name On Mobile    ${user_display_name3}

*** Keywords ***
Member User
    [Arguments]    ${url}    ${user}    ${pass}    ${user_display}
    Open Browser    ${url}    Chrome
    Login User to WeMall    ${user}    ${password}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display}

Member On Mobile
    [Arguments]    ${url}    ${user}    ${pass}    ${user_display}
    ${options}=    Get Chrome Mobile Options    Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4
    #    Open Browser    ${url}    Chrome
    Create Webdriver    Chrome    chrome_options=${options}
    Set Window Size    375    667
    Set Selenium Speed    0.5s
    Set Browser Implicit Wait    0.5s
    Go to    ${url}
    Login User to WeMall Mobile    ${user}    ${password}
    #    Add Cookie    is_mobile    true
    #    Reload Page
    #    Reload Page
    Verify Display Name On Mobile    ${user_display}

Verify Display Name On Mobile
    [Arguments]    ${user_dis}
    Sleep    3s
    Page Should Contain Element    jquery=p.username.ng-binding:contains('${user_dis}')

Login User to WeMall Mobile
    [Arguments]    ${user}    ${password}
    Click Element    //span[@class='icon-menu-hamburger-light ng-scope']
    Execute Javascript    $('.btn-login.ng-binding').click()
    Input Text    //input[@name='username']    ${user}
    Input Text    //input[@name='password']    ${password}
    Click Element    //button[@id='login-submit']