*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../Resource/Env_config.robot
Resource          ../../Common/Keywords_Common.robot
Resource          ../../../Resource/WebElement/MerchantCenter/Top_Bar.robot
Resource          MC_SignIn_Page.robot

*** Keywords ***
Assert Merchant center Top bar
    [Arguments]    ${first_name}    ${last_name}    ${ShopName}    ${menus}
    Comment    sleep    5
    Wait Until Element Is Visible    ${topbarMerchantUserName}    30
    Wait Until Element Is Visible    ${topbarMerchantShopName}    30
    Wait Until Element Is Visible    ${topbarMerchantLogo}    30
    Comment    ${temp}    Get Element Attribute    ${topbarMerchantUserName}@innerText
    ${actual username}    Get Text    ${topbarMerchantUserName}
    ${expect username}    Set Variable    ${first_name} ${last_name}
    Should Be Equal    ${actual username.strip()}    ${expect username.strip()}    Merchant user name not as expected - expect \"${expect username.strip()} \" actual \"${actual username}\"
    ${actual shopname}    Get Text    ${topbarMerchantShopName}
    Should Be Equal    ${actual shopname.strip()}    ${ShopName.strip()}    Merchant user name not as expected - expect \"${ShopName}\" actual \"${actual shopname.strip()}\"
    Asset top bar menu(s) visible and enable    ${menus}

Asset top bar menu(s) visible and enable
    [Arguments]    ${menus}
    ${length}=    Evaluate    len(${menus})
    : FOR    ${INDEX}    IN RANGE    0    ${length}
    \    ${expect}    Get From List    ${menus}    ${INDEX}
    \    ${element_menu}    Replace String    ${lvl1_menu}    REPLACE_ME    ${expect}
    \    ${actual}    Get Text    ${element_menu}
    \    Should Be Equal    ${actual.strip()}    ${expect.strip()}    Menu name not as expected - Expect \"${expect.strip()}\" actual return \"${actual.strip()}\"

Click topbar menu
    [Arguments]    ${menu}
    ${element_menu}    Replace String    ${lvl1_menu}    REPLACE_ME    ${menu}
    Wait Until Element is ready and click    ${element_menu}    30

Assert Multiple Shopname
    [Arguments]    ${shopnames}
    ${length}=    Evaluate    len(${shopnames})
    : FOR    ${INDEX}    IN RANGE    0    ${length}
    \    ${expect_shopname}    Get From List    ${shopnames}    ${INDEX}
    \    ${element_menu}    Replace String    ${Shopname_Dropdown}    REPLACE_ME    ${expect_shopname}
    \    ${actual}    Get Text    ${element_menu}
    \    Should Be Equal    ${expect_shopname}    ${actual}

Click shopname
    Wait Until Element is ready and click    ${topbarMerchantShopName}    10

Topbar Logout
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${is_logout_button_display}    Run Keyword And Return Status    Wait Until Element Is Visible    ${logout_button}
    \    Run Keyword If    ${is_logout_button_display}==${True}    Exit For Loop
    \    Wait Until Element is ready and click    ${topbarMerchantUserName}    30
    Wait Until Element is ready and click    ${logout_button}    10
    Wait Until Element Is Visible    ${username_inputbox}    10
