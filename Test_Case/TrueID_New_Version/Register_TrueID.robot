*** Settings ***
Test Teardown     Close Browser
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Log-in/Keywords_LoginPage.robot
Resource          ${CURDIR}/../../Resource/Config/Staging/Env_config.robot
Resource          ${CURDIR}/../../Resource/Config/Staging/database.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Light_Box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Pop_Up/Keywords_CartPopUp.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Pop_Up/Keywords_CartPopUp.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/User_Information_Page/Keywords_UserInformationPage.robot
Resource          ${CURDIR}/../../Keyword/Features/Register_TrueID_User/Register_TrueID_User.robot
Resource          ../../Keyword/Features/User_login/User_login.robot
Resource          ../../Keyword/Features/Freebie_Promotion/Create_Freebie.robot

*** Variables ***
${Product_Pkey}    2613442373522
${Text_ProductName}    เลนส์ เทเลซูม 12X iPhone 4/4S

*** Test Cases ***
Register TrueID user via WeMall site with all valid data
    [TAGS]    ready    tempx
    ${epoch_short}=    Get current epoch time short
    ${Text_Username}    Set Variable    STORM_${epoch_short}@gmail.com
    ${Text_Displayname}    Set Variable    TEST
    ${Text_Password}    Set Variable    P@ssw0rd
    ${Text_ConfirmPassword}    Set Variable    P@ssw0rd
    Open browser    ${ITM_URL}    chrome
    Register TrueID        ${Text_Username}    ${Text_Displayname}    ${Text_Password}    ${Text_ConfirmPassword}
    Sleep    10s
    Verify displayname on header    ${Text_Displayname}

Verify all error message on RegisterPage
    [TAGS]    ready
    ${Text_Username}    Set Variable    JUSTTEST2
    ${Text_Displayname}    Set Variable    TEST
    ${Text_Password}    Set Variable    P@ssw0rd
    ${Text_ConfirmPassword}    Set Variable    P@ssw0rd
    ${Expected_ErrorMessage}    Set Variable    Username must be email.
    Open browser    ${ITM_URL}    chrome
    Register TrueID        ${Text_Username}    ${Text_Displayname}    ${Text_Password}    ${Text_ConfirmPassword}
    ${errorMessage}=     Get Error message from PopupMessage
    Should Be Equal As Strings    ${errorMessage}    Username must be email.
    Sleep   10s
