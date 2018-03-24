*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          ../../../../Resource/WebElement/ADD/User_List.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          ../../../../Resource/WebElement/ADD/Navigation_Bar.txt
Resource          WebElement_AAD_NavigationBar.robot

*** Keywords ***
Click Navigation bar - User list
    Wait Until Element is ready and click    ${Navigation_bar_User_List}    10
