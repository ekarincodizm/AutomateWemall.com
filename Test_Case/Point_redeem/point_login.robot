*** Settings ***
Library        Selenium2Library
Resource        ${CURDIR}/../../Keyword/Portal/CMS_Point_Redeemtion/Login/Keywords_login.robot
Resource        ${CURDIR}/../../Keyword/Portal/CMS_Point_Redeemtion/Login/web_element_login.robot
Resource        ${CURDIR}/../../Resource/Config/${ENV}/Env_config.robot
Force Tags      Point_Redeem

*** Test Cases ***
TC_ITMWM_05668 To verify that system allow to login by user input username must be in the format as follow (name@domain.com)
    [Tags]    regression    ITM-Point-2016S1    TC_TEST15    TC_ITMWM_05668
    ${username}=    Set Variable    point@point.com
    ${password}=    Set Variable    point
    Login To Point CMS    ${username}    ${password}
    Expect Log In Success    point@point.com
    [Teardown]    Close Browser

TC_ITMWM_05669 To verify that user cannot login if user are not input username and password
    [Tags]    regression    ITM-Point-2016S1    TC_TEST16    TC_ITMWM_05669
    ${username}=    Set Variable
    ${password}=    Set Variable
    Login To Point CMS    ${username}    ${password}
    Expect Log In Not Input Username Or Password    You have some form errors. Please check below.
    [Teardown]    Close Browser

TC_ITMWM_05670 To verify that user cannot login if user input username only
    [Tags]    regression    ITM-Point-2016S1    TC_TEST17    TC_ITMWM_05670
    ${username}=    Set Variable    point@point.com
    ${password}=    Set Variable
    Login To Point CMS    ${username}     ${password}
    Expect Log In Not Input Username Or Password    You have some form errors. Please check below.
    [Teardown]    Close Browser

TC_ITMWM_05671 To verify that user cannot login if user input password only
    [Tags]    regression    ITM-Point-2016S1    TC_TEST18    TC_ITMWM_05671
    ${username}=    Set Variable
    ${password}=    Set Variable    point
    Login To Point CMS    ${username}    ${password}
    Expect Log In Not Input Username Or Password    You have some form errors. Please check below.
    [Teardown]    Close Browser

TC_ITMWM_05672 To verify that user cannot login if user input incorrect password
    [Tags]    regression    ITM-Point-2016S1    TC_TEST19    TC_ITMWM_05672
    ${username}=    Set Variable    point@point.com
    ${password}=    Set Variable    wrongPassword
    Login To Point CMS    ${username}    ${password}
    Expect Log In Incorrect Password    invalid username or password
    [Teardown]    Close Browser

TC_ITMWM_05673 To verify that user cannot login if use username that not exist in system
    [Tags]    regression    ITM-Point-2016S1    TC_TEST20    TC_ITMWM_05673
    ${username}=    Set Variable    wrong@username.com
    ${password}=    Set Variable    wrongPassword
    Login To Point CMS    ${username}    ${password}
    Expect Log In Incorrect Password    invalid username or password.
    [Teardown]    Close Browser