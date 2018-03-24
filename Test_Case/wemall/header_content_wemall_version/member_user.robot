*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/member_profile/keywords_member_profile.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Order_History/keywords_order_history.robot
#Test Template       Member User

*** Variables ***
${username}                     robot01@mail.com
${user_display_on_header}       Robot01@ma...
${user_display_name}            Robot01@mail.com
${password}                     123456

*** Test Cases ***
TC_WMALL_01431 Level C brand page header - Member User (WeMall_version)
    [tags]    regression    TC_WMALL_01431    WLS_Medium
    Member User    ${WEMALL_WEB}/brand/samsung-6931849325692.html    ${WEMALL_WEB}/brand/samsung-6931849325692.html

TC_WMALL_01441 Level C category page header - Member User (WeMall_version)
    [tags]    regression    TC_WMALL_01441    WLS_Medium
    Member User    ${WEMALL_WEB}/category/hulk-3302288514534.html    ${WEMALL_WEB}/category/hulk-3302288514534.html

TC_ITMWM_03996 Header on Lv.C for Merchant page - Member User (WeMall_version)
    [tags]    lyra
    Member User    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html

TC_WMALL_01451 Search page header - Member User (WeMall_version)
    [tags]    regression    TC_WMALL_01451    WLS_Medium
    Member User    ${WEMALL_WEB}/search2?q=Apple    ${WEMALL_WEB}/search2?q=Apple

TC_WMALL_01461 Everyday Wow page header - Member User (WeMall_version)
    [tags]    regression    TC_WMALL_01461    WLS_Medium
    Member User    ${WEMALL_WEB}/everyday-wow    ${WEMALL_WEB}/everyday-wow

TC_WMALL_01526 Login header - Member User (WeMall_version)
   [tags]    regression    TC_WMALL_01526    WLS_Medium
    Member User    ${WEMALL_WEB}/auth/login    ${WEMALL_WEB}    https

TC_WMALL_01527 Register header - Member User (WeMall_version)
   [tags]    regression    TC_WMALL_01527    WLS_Medium
    Member User    ${WEMALL_WEB}/users/register    ${WEMALL_WEB}    https

TC_WMALL_01528 Level D header - Member User (WeMall_version)
   [tags]    regression   TC_WMALL_01528    WLS_Medium
   Member User    ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    ${WEMALL_WEB}

TC_WMALL_01662 Wemall Portal page header - Member User (WeMall_version)
    [tags]    regression    TC_WMALL_01662    WLS_Medium
    Member User    ${WEMALL_WEB}    ${WEMALL_WEB}

TC_WMALL_01663 Wemall Stronfront page header - Member User (WeMall_version)
    [tags]    regression    TC_WMALL_01663    WLS_Medium
    Member User    ${WEMALL_WEB}/shop/canon    ${WEMALL_WEB}/shop/canon

TC_WMALL_01762 Forgot Password page header - Member User (WeMall_version)
    [tags]    regression    TC_WMALL_01762    WLS_Medium
    Member User HTTP    ${WEMALL_WEB}/forgot_password    ${WEMALL_WEB}/forgot_password    https

*** Keywords ***
Member User
    [Arguments]    ${full_url}    ${expected_url}    ${protocol}=http    ${expected_url2}=${expected_url}
    Go to Specific URL    ${full_url}
    keywords_wemall_header.Check Location Contain    ${expected_url}    ${protocol}
    Login User to WeMall    ${username}    ${password}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    keywords_wemall_header.Check Location Contain HTTPS    ${expected_url2}    ${protocol}
    Click User Profile Link
    Verify Member User Account    ${user_display_name}
    Go to Specific URL    ${full_url}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    Click Order History Link
    Verify Order History Page Exist
    Go to Specific URL    ${full_url}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    Click Order and Payment status Checking Link
    Verify Order History Page Exist
    Go to Specific URL    ${full_url}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    [Teardown]    Run Keywords    Click Log Out Link
        ...    AND    Verify Login Link Display As Not Login
        ...    AND    keywords_wemall_header.Check Location Contain    ${expected_url2}    ${protocol}

Member User HTTP
    [Arguments]    ${full_url}    ${expected_url}    ${protocol}=http    ${expected_url2}=${expected_url}
    Go to Specific URL    ${full_url}
    keywords_wemall_header.Check Location Contain    ${expected_url}    ${protocol}
    Login User to WeMall    ${username}    ${password}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    keywords_wemall_header.Check Location Contain    ${expected_url2}    ${protocol}
    Click User Profile Link
    Verify Member User Account    ${user_display_name}
    Go to Specific URL    ${full_url}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    Click Order History Link
    Verify Order History Page Exist
    Go to Specific URL    ${full_url}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    Click Order and Payment status Checking Link
    Verify Order History Page Exist
    Go to Specific URL    ${full_url}
    Verify Login Link Display As Member
    Verify User Display Name    ${user_display_on_header}
    [Teardown]    Run Keywords    Click Log Out Link
        ...    AND    Verify Login Link Display As Not Login
        ...    AND    keywords_wemall_header.Check Location Contain    ${expected_url2}    ${protocol}

