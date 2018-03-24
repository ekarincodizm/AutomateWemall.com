*** Settings ***
Library         Selenium2Library
Library         ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource        ${CURDIR}/../common/web_common_keywords.robot

*** Keywords ***
Element should be display on-screen
    [Arguments]     ${locator}
    ${element}=    GetWebElement    ${locator}
    ${w}	${h}=	Get Window Size
    ${elementLocationX}=    Get From Dictionary   ${element.location}    x
    ${elementLocationY}=    Get From Dictionary   ${element.location}    y

    #Should Be True	  0 <= ${elementLocationX}
    #Should Be True	  ${w} >= ${elementLocationX}
    Should Be True	  0 <= ${elementLocationY}
    Should Be True	  ${h} >= ${elementLocationY}

Scroll to Element When Enter Url With Hash
    [Arguments]     ${url}    ${locator}    ${expectedQueryString}
    GO TO    ${url}
    Wait Until Angular Ready    30s
    Sleep    2s
    Element should be display on-screen      ${locator}
    Location URL is Contains     ${expectedQueryString}

Scroll to Element When Click Element
    [Arguments]     ${clickedElem}    ${destElem}    ${expectedQueryString}
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible                  ${clickedElem}
    Click Element and Wait Angular Ready           ${clickedElem}
    Sleep    2s
    Element should be display on-screen            ${destElem}
    Location URL is Contains    ${expectedQueryString}

Location URL is Contains
    [Arguments]    ${expectedText}
    ${locationURL}=    Get Location
    Should Contain	${locationURL}	${expectedText}

Log Element Position
    [Arguments]     ${locator}
    ${element}=    GetWebElement    ${locator}
    ${w}	${h}=	Get Window Size
    ${elementLocationX}=    Get From Dictionary   ${element.location}    x
    ${elementLocationY}=    Get From Dictionary   ${element.location}    y

    LOG TO CONSOLE    WINDOW SIZE :${w},${h}
    Log To Console    element x-y${elementLocationX},${elementLocationY}