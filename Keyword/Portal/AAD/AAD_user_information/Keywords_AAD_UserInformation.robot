*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          ../../../../Resource/WebElement/ADD/User_List.robot
Resource          ../../../../Resource/WebElement/ADD/Login_Page.robot
Resource          ../../../../Resource/WebElement/ADD/User_Information.robot
Resource          ../../../../Resource/WebElement/ADD/Role.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          ../../../../Resource/WebElement/ADD/User_Information.robot
Resource          WebElement_AAD_UserInformation.robot

*** Keywords ***
Assert_User_Information
    [Arguments]    ${username}    ${firstname}    ${lastname}    ${email}
    Wait Until Element Is Visible    ${UserInformation_Tab}    10
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
