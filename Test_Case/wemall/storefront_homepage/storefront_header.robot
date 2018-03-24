*** Settings ***
Force Tags    WLS_Wemall_storefront_homepage
Suite Setup        Prepare Data and Open Storefront Page    ${merchant_id}    ${shop_name}    ${shop_slug}
Suite Teardown     Run Keywords    Close All Browsers
    ...            AND    Delete Shop and All Storefront Data    ${suite_shop_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot

*** Variables ***
${shop_slug}            tong-garden
${merchant_id}          TONG04352
${shop_name}            Tong Garden
${username}             robot01@mail.com
${password}             123456
${displayName}          Robot01
${searchKeyword}        iphone
${suggestionWords}      iph
${suggestionWordsNotDisplay}      asdfgghj

*** Test Cases ***
# TC_WMALL_01204 - Click on Logo
#     [Tags]    wemall_header      Regression
#     Change URL To Storefront Page       ${shop_slug}
#     Click On ITM Logo
#     Redirect To ITM Portal Page

# TC_WMALL_01205 - No Megamenu Hamburgur
#     [Tags]    wemall_header      Regression
#     Change URL To Storefront Page       ${shop_slug}
#     Header Will Not Show Megamenu Hamburgur

TC_WMALL_01206 No Micro Cart
    [Tags]    wemall_header      Regression
    Change URL To Storefront Page       ${shop_slug}
    Header Will Not Show Micro Cart

TC_WMALL_01207 Guest Signin Box
    [Tags]    wemall_header      Regression
    Change URL To Storefront Page       ${shop_slug}
    Mouse Over On Sign In Box
    Log In Box Don't Expand

# TC_WMALL_01208 - Member Signin Box
#     [Tags]    wemall_header      Regression
#     Change URL To Storefront Page       ${shop_slug}
#     Click On Sign In Box
#     Login As Member     ${username}     ${password}
#     Web Will Redirect To Storefront Page        ${shop_slug}
#     Sign in Box Will Have Profile
#     Checking My Order
#     Checking Log Out
#     Checking User Coupon
#     [Teardown]    Log Out

# TC_WMALL_01209 - Member Signin Box - Secondary Language
#     [Tags]    wemall_header      Regression
#     Change URL To Storefront Page - Secondary Language      ${shop_slug}
#     Click On Sign In Box
#     Login As Member     ${username}     ${password}
#     Web Will Redirect To Storefront Page - Secondary Language        ${shop_slug}
#     Sign in Box Will Have Profile
#     Checking My Order
#     Checking Log Out
#     Checking User Coupon
#     [Teardown]    Log Out

TC_WMALL_01210 Member Go To Profile Page
    [Tags]    wemall_header      Regression
    Change URL To Storefront Page       ${shop_slug}
    Click On Sign In Box
    Login As Member     ${username}     ${password}
    Web Will Redirect To Storefront Page        ${shop_slug}
    Sign in Box Will Have Profile
    Mouse Over On Sign In Page
    Click On Profile Link
    Profile Page Display
    [Teardown]    Log Out

TC_WMALL_01211 Member Go To Order Tracking
    [Tags]    wemall_header      Regression
    Change URL To Storefront Page       ${shop_slug}
    Click On Sign In Box
    Login As Member     ${username}     ${password}
    Web Will Redirect To Storefront Page        ${shop_slug}
    Sign in Box Will Have Profile
    Mouse Over On Sign In Page
    Click Checking My Order Link
    Order Tracking Page Display
    [Teardown]    Log Out

# TC_WMALL_01287 - Member Go To User Coupon
#     [Tags]    wemall_header      Regression
#     Change URL To Storefront Page       ${shop_slug}
#     Click On Sign In Box
#     Login As Member     ${username}     ${password}
#     Web Will Redirect To Storefront Page        ${shop_slug}
#     Sign in Box Will Have Profile
#     Mouse Over On Sign In Page
#     Click Checking User Coupon Link
#     User Coupon Page Display
#     [Teardown]    Log Out

TC_WMALL_01212 Log Out
    [Tags]    wemall_header      Regression
    Change URL To Storefront Page       ${shop_slug}
    Click On Sign In Box
    Login As Member     ${username}     ${password}
    Web Will Redirect To Storefront Page        ${shop_slug}
    Sign in Box Will Have Profile
    Mouse Over On Sign In Page
    Click On Log Out Link
    Member Log Out Correctly

TC_WMALL_01213 Member Display Name
    [Tags]    wemall_header      Regression
    Change URL To Storefront Page       ${shop_slug}
    Click On Sign In Box
    Login As Member     ${username}     ${password}
    Web Will Redirect To Storefront Page        ${shop_slug}
    Sign in Box Will Have Profile
    Member Display Name Show Correctly          ${displayName}
    [Teardown]    Log Out

TC_WMALL_01214 Seacrh On Portal Header
    [Tags]    SanityTest      Regression
    Change URL To Storefront Page       ${shop_slug}
    Search Product On Search Box        ${searchKeyword}
    Search Product With Word On ITM     ${searchKeyword}

TC_WMALL_01215 Search Product On Search Portal Header
    [Tags]    SanityTest      Regression
    Change URL To Storefront Page       ${shop_slug}
    Put Text Search Box                 ${suggestionWords}
    Selected Suggestion Word            ${searchKeyword}
    Search Product With Word On ITM     ${searchKeyword}

TC_WMALL_01216 No Suggestion From Search Portal Header
    [Tags]    SanityTest      Regression
    Change URL To Storefront Page       ${shop_slug}
    Put Text Search Box                 ${suggestionWordsNotDisplay}
    Suggestion Words Do Not Display

TC_WMALL_01217 Secondary Language - Search Portal Header
    [Tags]    SanityTest      Regression
    Change URL To Storefront Page - Secondary Language      ${shop_slug}
    Put Text Search Box                 ${suggestionWords}
    Selected Suggestion Word            ${searchKeyword}
    Search Product With Word On ITM     ${searchKeyword}

*** Keywords ***
Log Out
    Change URL To Storefront Page     ${shop_slug}
    Mouse Over On Sign In Page
    Click On Log Out Link
    Member Log Out Correctly