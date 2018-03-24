*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          ../../../../Resource/WebElement/ADD/User_List.robot
Resource          ../../../../Resource/WebElement/ADD/Login_Page.robot
Resource          ../../../../Resource/WebElement/ADD/User_Information.robot
Resource          ../../../../Resource/WebElement/ADD/Role.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_AAD_Role.robot

*** Keywords ***
# AAD User Information - Associate to Shop
#     [Arguments]    ${shop_name}    ${role_name}
#     Wait Until Element is ready and click    ${Role_Tab}    5
#     Wait Until Element is ready and type    ${Role_ShopName}    ${shop_name}    5
#     Wait Until Element is ready and click    ${Role_Search}    5
#     AAD Select roles    ${role_name}
#     Wait Until Element is ready and click    ${Role_Save_bttn}    5
#     Wait Until Element Is Visible    ${Save_Success}
#     Comment    sleep    5

AAD User Information - Associate to Shop
    [Arguments]    ${shop_name}    ${role_name}
    Wait Until Element is ready and click    ${Role_Tab}    5
    Wait Until Element is ready and type    ${Role_ShopName}    ${shop_name}    5
    CLick Element    //body
    Wait Until Element is ready and click    ${Role_Search}    5
    AAD Select roles    ${role_name}
    Wait Until Element is ready and click    ${Role_Save_bttn}    5
    Wait Until Element Is Visible    ${Save_Success}
    Comment    sleep    5

AAD Select roles
    [Arguments]    ${roles}
    ${length}=    Evaluate    len(${roles})
    : FOR    ${INDEX}    IN RANGE    0    ${length}
    \    ${role_name}=    Get From List    ${roles}    ${INDEX}
    \    ${element_role_checkbox_by_rolename}=    Replace String    ${Role_Checkbox_By_RoleName}    REPLACE_ME    ${role_name}
    \    Wait until checkbox is ready and select    ${element_role_checkbox_by_rolename}    15

Assert AAD checked roles
    [Arguments]    ${roles}
    Wait Until Element Is Visible    ${Role_Tab}    10
    Comment    sleep    5
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${actual_username}    Selenium2Library.Get Element Attribute    ${UserInformation_username}@value
    \    Exit For Loop If    '${actual_username}'!=''
    \    sleep    1
    ${actual_firstname}    Get Value    ${UserInformation_firstName}
    ${actual_lastname}    Get Value    ${UserInformation_lastName}
    ${actual_email}    Get Value    ${UserInformation_email}
    Should Be Equal    ${actual_username.strip()}    ${username.strip()}
    Should Be Equal    ${actual_firstname.strip()}    ${firstname.strip()}
    Should Be Equal    ${actual_lastname.strip()}    ${lastname.strip()}
    Should Be Equal    ${actual_email.strip()}    ${email.strip()}
