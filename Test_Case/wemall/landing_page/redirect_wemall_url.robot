*** Settings ***
Library             Selenium2Library
Resource            ${CURDIR}/../../../Keyword/Common/keywords_wemall_common.robot
Resource            ${CURDIR}/../../../Resource/init.robot
Suite Teardown      Close All Browsers

*** Testcase ***
TC_WMALL_01780 Wemall www url redirection [Web][TH]
    [Tags]    regression    redirection    wemall_web
    [Setup]    Verify Automatically Redirect Wemall WWW Url    ${FALSE}    ${TRUE}
    Log To Console    \n\tExpected - [Web][TH][WWW] - www.wemall.com/
    [Teardown]    Close All Browsers

TC_WMALL_01781 Wemall www url redirection [Web][EN]
    [Tags]    regression    redirection    wemall_web
    [Setup]    Verify Automatically Redirect Wemall WWW Url    ${FALSE}    ${FALSE}
    Log To Console    \n\tExpected - [Web][EN][WWW] - www.wemall.com/en
    [Teardown]    Close All Browsers

TC_WMALL_01782 Wemall www url redirection [Mobile][TH]
    [Tags]    regression    redirection
    [Setup]    Verify Automatically Redirect Wemall WWW Url    ${TRUE}    ${TRUE}
    Log To Console    \n\tExpected - [Mobile][TH][WWW] - www.wemall.com/portal/page1
    [Teardown]    Close All Browsers

TC_WMALL_01783 Wemall www url redirection [Mobile][EN]
    [Tags]    regression    redirection
    [Setup]    Verify Automatically Redirect Wemall WWW Url    ${TRUE}    ${FALSE}
    Log To Console    \n\tExpected - [Mobile][EN][WWW] - www.wemall.com/en/portal/page1
    [Teardown]    Close All Browsers

TC_WMALL_01784 Wemall m. url redirection [Web][TH]
    [Tags]    regression    redirection    wemall_web
    [Setup]    Verify Automatically Redirect Wemall m. Url    ${FALSE}    ${TRUE}
    Log To Console    \n\tExpected - [Web][TH][m.] - m.wemall.com/
    [Teardown]    Close All Browsers

TC_WMALL_01785 Wemall m. url redirection [Web][EN]
    [Tags]    regression    redirection    wemall_web
    [Setup]    Verify Automatically Redirect Wemall m. Url    ${FALSE}    ${FALSE}
    Log To Console    \n\tExpected - [Web][EN][m.] - m.wemall.com/en
    [Teardown]    Close All Browsers

TC_WMALL_01786 Wemall m. url redirection [Mobile][TH]
    [Tags]    regression    redirection
    [Setup]   Verify Automatically Redirect Wemall m. Url    ${TRUE}    ${TRUE}
    Log To Console    \n\tExpected - [Mobile][EN][m.] - m.wemall.com/portal/page1
    [Teardown]    Close All Browsers

TC_WMALL_01787 Wemall m. url redirection [Mobile][EN]
    [Tags]    regression    redirection
    [Setup]    Verify Automatically Redirect Wemall m. Url    ${TRUE}    ${FALSE}
    Log To Console    \n\tExpected - [Mobile][EN][m.] - m.wemall.com/en/portal/page1
    [Teardown]    Close All Browsers

*** Keywords ***
Verify Automatically Redirect Wemall WWW Url
    [Arguments]    ${is_mobile}    ${TH}
    Run Keyword If                ${is_mobile}
    ...                           Wemall Common - Open Mobile www. Wemall URL Homepage
    ...    ELSE                   Wemall Common - Open Web Wemall Homepage
    Run Keyword If                ${is_mobile} and '${TH}'=='True'
    ...                            Run Keywords    Go To    ${Wemall_URL}    AND     Verify Wemall WWW Url    1
    Run Keyword If                ${is_mobile} and '${TH}'=='False'
    ...                            Run Keywords    Go To    ${Wemall_URL}/en    AND     Verify Wemall WWW Url    2
    Run Keyword If                '${is_mobile}'=='False' and ${TH}
    ...                            Run Keywords    Go To    ${Wemall_URL}/portal/page1    AND     Verify Wemall WWW Url    3
    Run Keyword If                '${is_mobile}'=='False' and '${TH}'=='False'
    ...                            Run Keywords    Go To    ${Wemall_URL}/en/portal/page1    AND     Verify Wemall WWW Url    4

Verify Wemall WWW Url
    [Arguments]    ${type}
    ${url}=    Get Location
    Run Keyword If                ${type}==1    Should Be Equal    ${url}    ${Wemall_URL}/portal/page1
    Run Keyword If                ${type}==2    Should Be Equal    ${url}    ${Wemall_URL}/en/portal/page1
    Run Keyword If                ${type}==3    Should Be Equal    ${url}    ${Wemall_URL}/
    Run Keyword If                ${type}==4    Should Be Equal    ${url}    ${Wemall_URL}/en/

Verify Automatically Redirect Wemall m. Url
    [Arguments]    ${is_mobile}    ${TH}
    Run Keyword If                ${is_mobile}
    ...                           Wemall Common - Open Mobile m. Wemall URL Homepage
    ...    ELSE                   Wemall Common - Open Web Wemall Homepage
    Run Keyword If                ${is_mobile} and '${TH}'=='True'
    ...                            Run Keywords    Go To    ${WEMALL_MOBILE}    AND     Verify Wemall m. Url    1
    Run Keyword If                ${is_mobile} and '${TH}'=='False'
    ...                            Run Keywords    Go To    ${WEMALL_MOBILE}/en    AND     Verify Wemall m. Url    2
    Run Keyword If                '${is_mobile}'=='False' and ${TH}
    ...                            Run Keywords    Go To    ${WEMALL_MOBILE}/portal/page1    AND     Verify Wemall m. Url    3
    Run Keyword If                '${is_mobile}'=='False' and '${TH}'=='False'
    ...                            Run Keywords    Go To    ${WEMALL_MOBILE}/en/portal/page1    AND     Verify Wemall m. Url    4

Verify Wemall m. Url
    [Arguments]    ${type}
    Sleep    2s
    ${url}=    Get Location
    Run Keyword If                ${type}==1    Should Be Equal    ${url}    ${WEMALL_MOBILE}/portal/page1
    Run Keyword If                ${type}==2    Should Be Equal    ${url}    ${WEMALL_MOBILE}/en/portal/page1
    Run Keyword If                ${type}==3    Should Be Equal    ${url}    ${WEMALL_MOBILE}/
    Run Keyword If                ${type}==4    Should Be Equal    ${url}    ${WEMALL_MOBILE}/en/

