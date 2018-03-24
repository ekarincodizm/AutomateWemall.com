*** Settings ***
Library          Selenium2Library
Library          ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Keywords ***
Open Browser and Maximize Window
    [Arguments]    ${HOST}    ${BROWSER}    ${alias}=None
    Open Browser    ${HOST}   ${BROWSER}    ${alias}
    Set Window Position    ${0}    ${0}
    # Maximize Browser Window
    Set Window Size    ${1440}    ${900}
    Set Selenium Speed    0.3s
    Set Browser Implicit Wait    0.3s

Reload Page and Wait Page Ready
    Reload Page
    Wait Until Angular Ready    30s

# Go To Wemall Mobile URL is in mobile_common_keyword.robot
Go To Wemall Desktop URL
    [Arguments]    ${full_url}
    Go To          ${full_url}
    ${is_currently_mobile}=       Get Cookie Value    is_mobile
    Run Keyword If                'true' == '${is_currently_mobile}'
    ...                           Set Cookie to Desktop and Reload Page
    Wait Until Angular Ready    30s

# Private keyword used by 'Go To Wemall Desktop URL'
Set Cookie to Desktop and Reload Page
    Add Cookie    is_mobile    false
    Reload Page

Dashboard will display
    Location Should Contain    /

Select iCheckbox
    [Arguments]    ${chkboxLocator}    ${spanLocator}
    ${checked}=    Selenium2Library.Get Element Attribute    ${chkboxLocator}@checked
    Run Keyword If    '${checked}'=='None'    Click Element and Wait Angular Ready    ${spanLocator}

Unselect iCheckbox
    [Arguments]    ${chkboxLocator}    ${spanLocator}
    ${checked}=    Selenium2Library.Get Element Attribute    ${chkboxLocator}@checked
    Run Keyword If    '${checked}'!='None'    Click Element and Wait Angular Ready    ${spanLocator}

User Wait 3 Seconds
    Sleep    3s

User Wait 5 Seconds
    Sleep    5s

User Wait 7 Seconds
    Sleep    7s

User Wait 10 Seconds
    Sleep    10s

User Wait 12 Seconds
    Sleep    12s

User Wait 15 Seconds
    Sleep    15s

User Wait 20 Seconds
    Sleep    20s

User Wait 30 Seconds
    Sleep    30s

Get All Texts
    [Arguments]    ${selector}
    ${webElemens}    Get Webelements    jquery=${selector}
    ${count}=    Get Length    ${webElemens}
    ${texts}=    Create List
    :FOR    ${i}    IN RANGE    0    ${count}
    \    ${name}=    Get Text    jquery=${selector}:eq(${i})
    \    Append To List    ${texts}    ${name}
    [Return]    ${texts}

Get All Element Attributes
    [Arguments]    ${selector}    ${attribute}
    ${webElemens}    Get Webelements    jquery=${selector}
    ${count}=    Get Length    ${webElemens}
    ${texts}=    Create List
    :FOR    ${i}    IN RANGE    0    ${count}
    \    ${name}=    Selenium2Library.Get Element Attribute    jquery=${selector}:eq(${i})@${attribute}
    \    Append To List    ${texts}    ${name}
    [Return]    ${texts}
