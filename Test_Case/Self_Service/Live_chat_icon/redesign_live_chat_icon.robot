*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/web_element_common.robot
#Suite Teardown    Close All Browsers

*** Keywords ***
SS Live Chat - Verify Live Chat Button
    Wait Until Element Is Visible                   ${SS_Img_Live_Chat}                                      15s
    SS Common - Click Live Chat Button
    Wait Until Element Is Visible                   //div[@id='SScontainer']                                 15s

*** Test Cases ***
TC_ITMWM_01007 Change live chat icon on home page following the new design in JIRA
    [Tags]  TC_ITMWM_01007      regression      ITMMZ-1293      X-Support-2016S14
    Open Browser                                    ${WEMALL_URL}                 ${BROWSER}
    SS Live Chat - Verify Live Chat Button
    Go To                                           ${WEMALL_URL}/en
    SS Live Chat - Verify Live Chat Button
    [Teardown]              Close All Browsers

TC_ITMWM_01008 Change live chat icon on Level C Collection/Category page following the new design in JIRA
    [Tags]  TC_ITMWM_01008      regression      ITMMZ-1293      X-Support-2016S14
    SS Live Chat - Verify Live Chat Button          ${WEMALL_URL}/category/all-mobile-tablet-3193015175820.html
    SS Live Chat - Verify Live Chat Button          ${WEMALL_URL}/en/category/all-mobile-tablet-3193015175820.html
    [Teardown]              Close Browser

TC_ITMWM_01009 Change live chat icon on Level C Brand page following the new design in JIRA
    [Tags]  TC_ITMWM_01009      regression      ITMMZ-1293      X-Support-2016S14
    SS Live Chat - Verify Live Chat Button          ${WEMALL_URL}/brand/apple-6602864363193.html
    [Teardown]              Close Browser
