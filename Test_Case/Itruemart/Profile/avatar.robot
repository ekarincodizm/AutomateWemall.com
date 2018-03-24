*** Settings ***
Library           Selenium2Library
Library           Collections
Library           OperatingSystem
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
# Resource          ${CURDIR}/../../../Keyword/Features/User_login/User_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Profile/keywords_profile.robot
Resource          ${CURDIR}/../../../Keyword/Features/User_login/User_login.robot

*** Variables ***

${FB_USERNAME}    benzascend@gmail.com
${FB_PASSWORD}    P@ssw0rd

*** Test Case ***

TC_iTM_03543 Has value for avatar and type for true id account
    [tags]    TC_iTM_03543    ITMA-3101    ready   regression
    Open browser    ${ITM_URL}    chrome
    Maximize Browser Window
    # Login_with_TrueID    ${${ITM_USERNAME}}    ${ITM_PASSWORD}
    Login User to iTrueMart
    Sleep    3s
    ${type}=  Get Avatar     11
    Should Be Equal As Strings    ${type}    "true_sso"
    ${src}=  Get Avatar     10
    Go To   ${ITM_URL}/member/profile
    Should Display Avatar   ${src}

    [teardown]     Run Keywords    Go To Logout
    ...     AND     Sleep       1s
    ...     AND     Close Browser

TC_iTM_03544 Has value at avatar and type for fb account
    [tags]    TC_iTM_03544    ITMA-3101    ready   regression
    Open browser    ${ITM_URL}    chrome
    Maximize Browser Window
    # Login_with_TrueID    ${${ITM_USERNAME}}    ${ITM_PASSWORD}
    Login_with_Facebook(Existing user)      ${FB_USERNAME}      ${FB_PASSWORD}
    Sleep    5s
    ${type}=  Get Avatar     10
    Should Be Equal As Strings    ${type}    "facebook"
    ${src}=  Get Avatar     9       # customer_type = facebook
    Go To   ${ITM_URL}/member/profile
    Should Display Avatar   ${src}
    [teardown]      Run Keywords    Close Browser