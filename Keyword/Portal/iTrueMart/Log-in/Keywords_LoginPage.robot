*** Settings ***
Library           Selenium2Library
Library           String
Resource          WebElement_LoginPage.robot

*** Variables ***

*** Keywords ***
Go to log-in page
    Wait Until Element Is Visible    //*[@class="text ng-binding ng-scope"]    20s
    #Click Element    //*[@class="text ng-binding ng-scope"]
    Go to    ${ITM_URL}/auth/login?continue=${ITM_URL}

Enter log-in with trueID formation
    [Arguments]    ${Text_Username}    ${Text_Password}
    Wait Until Element Is Visible    ${Input_username_locator}    20s
    Input Text    ${Input_username_locator}    ${Text_Username}
    Input Text    ${Input_password_locator}    ${Text_Password}

Click submit login with trueID button
    Wait Until Element Is Visible    ${Submit_login_locator}    20s
    Click Element    ${Submit_login_locator}

Click login with facebook on login page
    Wait Until Element Is Visible    ${FBloginBtn_LoginPage_locator}    20s
    Click Element    ${FBloginBtn_LoginPage_locator}

Enter log-in with facebook formation
    [Arguments]    ${Text_FBUsername}    ${Text_FBPassword}
    Wait Until Element Is Visible    ${Input_FBemail_locator}    20s
    Input Text    ${Input_FBemail_locator}    ${Text_FBUsername}
    Input Text    ${Input_FBpassword_locator}    ${Text_FBPassword}

Click submit login with facebook button
    Wait Until Element Is Visible    ${FaceBook_Submitlogin_locator}    20s
    Click Element    ${FaceBook_Submitlogin_locator}

Click cancel login with facebook button
    Wait Until Element Is Visible    ${FaceBook_Canclelogin_locator}    20s
    Click Element    ${FaceBook_Canclelogin_locator}

Click allow permission on facebook
    Wait Until Element Is Visible    ${Facebook_allowPermission_locator}    20s
    Click Element    ${Facebook_allowPermission_locator}

Click not allow permission on facebook
    Wait Until Element Is Visible    ${Facebook_NotallowPermission_locator}    20s
    Click Element    ${Facebook_NotallowPermission_locator}

Click Editpermission
    Wait Until Element Is Visible    ${Facebook_EditPermission_locator}    20s
    Click Element    ${Facebook_EditPermission_locator}

Verify displayname on header
    [Arguments]    ${Displayname}
    ${Displayname_10FirstChar}=    Get Substring    ${Displayname}    1    10
    Wait Until Element Is Visible    ${Header_displayname_locator}    20s
    Element Should Contain    ${Header_displayname_locator}    ${Displayname_10FirstChar}...

Wait Until HomePage is Ready
    Wait Until Element Is Visible    ${Top_banner_locator}    20s

Verify TrueID User Login Error Message
    [Arguments]    ${Expect_message}
    Wait Until Element Is Visible    ${login_errorMessage_locator}    20s
    ${errorMessage}=    Get Text    ${login_errorMessage_locator}
    Should be equal as Strings    ${errorMessage}    ${Expect_message}