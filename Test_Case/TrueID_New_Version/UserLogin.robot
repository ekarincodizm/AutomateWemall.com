*** Settings ***
Test Teardown     Close Browser
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Log-in/Keywords_LoginPage.robot
Resource          ${CURDIR}/../../Resource/Config/staging/Env_config.robot
Resource          ${CURDIR}/../../Resource/Config/staging/database.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Light_Box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Pop_Up/Keywords_CartPopUp.robot
Resource          ../../Keyword/Features/User_login/User_login.robot


*** Variables ***
${TrueID_username}    thanos_trueid@gmail.com
${TrueID_password}    password
${TrueID_Invalid_Username}    InvalidUsername
${TrueID_Invalid_Password}    InvalidPassword
${TrueIDMobile_Username}    0909048396
${TrueIDMobile_Password}    bombycorleone
${TrueIDMobile_Invalid_Username}    0900000000
${TrueID_User_Displayname}    thanos_test
${TrueID_MobileUser_Displayname}    thanapop.jin
${Product_Pkey}    2613442373522



*** Test Cases ***
TC_iTM_02970-TC_iTM_02976 Verify TrueID user login page Invalid Cases
    [TAGS]    ready    regression    userlogin    TC_iTM_02970    TC_iTM_02971    TC_iTM_02972    TC_iTM_02973    TC_iTM_02974    TC_iTM_02975    TC_iTM_02976
    Open browser    ${ITM_URL}    chrome
    #TC_iTM_02970 Leave user name and password as blank
    Login_with_TrueID    ${EMPTY}    ${EMPTY}
    Verify TrueID User Login Error Message    กรุณาใส่ทรูไอดี (อีเมล์ / เบอร์มือถือ / เบอร์ทรูการ์ด)
    #TC_iTM_02971 Leave username as blank
    Login_with_TrueID    ${EMPTY}    ${TrueID_password}
    Verify TrueID User Login Error Message    กรุณาใส่ทรูไอดี (อีเมล์ / เบอร์มือถือ / เบอร์ทรูการ์ด)
    #TC_iTM_02972 Leave password as blank
    Login_with_TrueID    ${TrueID_username}    ${EMPTY}
    Verify TrueID User Login Error Message    กรุณาใส่รหัสผ่าน
    #TC_iTM_02973 Enter invalid username in case login with email
    Login_with_TrueID    ${TrueID_Invalid_Username}    ${TrueID_password}
    Verify TrueID User Login Error Message    Invalid Account.
    #TC_iTM_02974 Enter invalid password in case login with email
    Login_with_TrueID    ${TrueID_username}    ${TrueID_Invalid_Password}
    Verify TrueID User Login Error Message    กรุณาตรวจสอบรหัสผ่าน
    #TC_iTM_02975 Enter invalid username in case login with mobile
    Login_with_TrueID    ${TrueIDMobile_Invalid_Username}    ${EMPTY}
    Verify TrueID User Login Error Message    ไม่พบข้อมูลผู้ใช้.
    #TC_iTM_02976 Enter invalid password in case login with mobile
    Login_with_TrueID    ${TrueIDMobile_Username}    ${TrueID_Invalid_Password}
    Verify TrueID User Login Error Message    กรุณาตรวจสอบรหัสผ่าน

TC_iTM_02977 Login with valid existing TrueID Email user
    [TAGS]    ready    regression    userlogin    TC_iTM_02977
    Open browser    ${ITM_URL}    chrome
    Login_with_TrueID    ${TrueID_username}    ${TrueID_password}
    Sleep    5s
    #Location Should Be    ${ITM_URL}/
    Verify displayname on header    ${TrueID_User_Displayname}

TC_iTM_02978 Login with valid existing TrueID mobile user
    [TAGS]    ready    regression    userlogin    TC_iTM_02978
    Open browser    ${ITM_URL}    chrome
    Login_with_TrueID    ${TrueIDMobile_Username}    ${TrueIDMobile_Password}
    Sleep    5s
    #Location Should Be    ${ITM_URL}/
    Verify displayname on header    ${TrueID_MobileUser_Displayname}

TC_iTM_03005 Login with valid existing TrueID Email user
    [TAGS]    ready    regression    userlogin    TC_iTM_03005
    Open browser    ${ITM_URL}    chrome
    Go to    ${ITM_URL}/products/item-${product_pkey}.html
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    sleep    2
    Checkout1 Login With trueID User    ${TrueID_username}    ${TrueID_password}
    Verify displayname on header    ${TrueID_User_Displayname}

TC_iTM_03006 Login with valid existing TrueID mobile user
    [TAGS]    ready    regression    userlogin    TC_iTM_03006
    Open browser    ${ITM_URL}    chrome
    Go to    ${ITM_URL}/products/item-${product_pkey}.html
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    sleep    2
    Checkout1 Login With trueID User    ${TrueIDMobile_Username}    ${TrueIDMobile_Password}
    Verify displayname on header    ${TrueID_MobileUser_Displayname}
