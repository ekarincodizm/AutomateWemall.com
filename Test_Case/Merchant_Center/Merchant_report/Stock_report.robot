*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           Selenium2Library    browser_breath_delay=2
#Test Teardown     Selenium2Library.Close Browser
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Log-in/Keywords_LoginPage.robot
Resource          ${CURDIR}/../../../Resource/Config/alpha/Env_config.robot
Resource          ${CURDIR}/../../../Resource/Config/alpha/database.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_Light_Box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_Pop_Up/Keywords_CartPopUp.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/User_Information_Page/Keywords_UserInformationPage.robot
Resource          ../../../Keyword/Features/User_login/User_login.robot
Resource          ../../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/Features/Sanity_test/Keywords_Sanity_Production.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Login/Keywords_loginMCHPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Merchant_Center/Merchant_Bar/Keywords_MCHBar.robot


*** Variables ***
${merchant_username}    Test
${merchant_password}    password

*** Test Cases ***
TEMPX
    [TAGS]    TEMPX
    Selenium2Library.Open browser    ${LOGIN-PAGE}    chrome
    Log-in via MCH    ${merchant_username}    ${merchant_password}
    Go To Merchant Report FirstPage