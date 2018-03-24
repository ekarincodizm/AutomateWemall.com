*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../Resource/Env_config.robot
Resource          ../../Common/Keywords_Common.robot
Resource          ../../../Resource/WebElement/PDS/Merchant/Navigation_Bar.robot

*** Keywords ***
Navigate to Create merchant
    sleep    5s
    Wait Until Element is ready and click    ${NavigationBar_Merchant}    60
    Click Navigation bar - Create Merchant

Click Navigation bar - Create Merchant
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${is_NavigationBar_CreateMerchant_display}    Run Keyword And Return Status    Wait Until Element Is Visible    ${NavigationBar_CreateMerchant}
    \    Run Keyword If    ${is_NavigationBar_CreateMerchant_display}==${True}    Exit For Loop
    \    Wait Until Element is ready and click    ${NavigationBar_Merchant}    30
    Wait Until Element is ready and click    ${NavigationBar_CreateMerchant}    10

Click Navigation bar - Merchant list
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${is_NavigationBar_MerchantList_display}    Run Keyword And Return Status    Wait Until Element Is Visible    ${NavigationBar_MerchantList}
    \    Run Keyword If    ${is_NavigationBar_MerchantList_display}==${True}    Exit For Loop
    \    Wait Until Element is ready and click    ${NavigationBar_Merchant}    30
    Wait Until Element is ready and click    ${NavigationBar_MerchantList}    10
