*** Settings ***
Library             String
Library             Collections
Library             Selenium2Library

*** Keywords ***
Open WM Page Web With URI
    # ex. uri=/category/clearance-3776607921569.html
    [Arguments]  ${uri}  ${lang}=th
    Run Keyword If   '${lang}'=='th'   Open Browser   ${WEMALL_URL}${uri}   ${BROWSER}
     ...  ELSE   Open Browser   ${WEMALL_URL}/${lang}${uri}   ${BROWSER}

Display Wemall Location
    [Arguments]   ${lang}=th
    Run Keyword If   '${lang}'=='th'   Location Should Contain   ${WEMALL_URL}
     ...      ELSE    Location Should Contain   ${WEMALL_URL}/${lang}

Display Wemall Location With URI
    [Arguments]   ${uri}   ${lang}=th
    # ${uri} = /sometihing
    Run Keyword If   '${lang}'=='th'   Location Should Contain   ${WEMALL_URL}${uri}
     ...      ELSE   Location Should Contain   ${WEMALL_URL}/${lang}${uri}

Display Wemall SSL Location With URI
    [Arguments]   ${uri}   ${lang}=th
    # ${uri} = /sometihing
    Run Keyword If   '${lang}'=='th'   Location Should Contain   ${WEMALL_URL_SSL}${uri}
     ...      ELSE    Location Should Contain   ${WEMALL_URL_SSL}/${lang}${uri}

Selenium2Library.Get Element Attribute And Should Be Equal
    [Arguments]    ${attribute_locator}    ${expected_data}
    ${actual_data}    Selenium2Library.Get Element Attribute    ${attribute_locator}
    Should Be Equal As Strings    ${actual_data}    ${expected_data}

Get Text And Should Be Equal
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}    Get Text    ${locator}
    Should Be Equal As Strings    ${expected_text}    ${actual_text}

Get Value And Should Be Equal
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}    Get Value    ${locator}
    Should Be Equal As Strings    ${expected_text}    ${actual_text}

Not Visible Then If Failed Wait and Check Is Visible Again
    [Arguments]    ${locator}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    5s
    Run Keyword If    ${result} == False    Sleep    1s
    Wait Until Element Is Visible    ${locator}    30s

Click Then If Failed Wait and Click Again
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    5s
    ${result}=    Run Keyword And Return Status    Click Element and Wait Angular Ready  ${locator}
    Run Keyword If    ${result} == False    Sleep    3s
    Run Keyword If    ${result} == False    Click Element and Wait Angular Ready  ${locator}

Get Value from Json Node
    [Arguments]    ${json_data}    ${json_node}
    ${data}=    Get Json Value    ${json_data}    ${json_node}
    ${data}=   Replace String   ${data}    "    ${EMPTY}
    [Return]    ${data}

WebElement Should Be Display On-Screen
    [Arguments]     ${locator}
    ${element}=    GetWebElement    ${locator}
    ${w}    ${h}=    Get Window Size
    ${elementLocationX}=    Get From Dictionary   ${element.location}    x
    ${elementLocationY}=    Get From Dictionary   ${element.location}    y

    #Should Be True   0 <= ${elementLocationX}
    #Should Be True   ${w} >= ${elementLocationX}
    Should Be True    0 <= ${elementLocationY}
    Should Be True    ${h} >= ${elementLocationY}

WebElement Should Not Be Display On-Screen
    [Arguments]     ${locator}
    ${element}=    GetWebElement    ${locator}
    ${w}    ${h}=    Get Window Size
    ${elementLocationX}=    Get From Dictionary   ${element.location}    x
    ${elementLocationY}=    Get From Dictionary   ${element.location}    y

    #Should Be True   0 <= ${elementLocationX}
    #Should Be True   ${w} >= ${elementLocationX}
    Should Be True    0 <= ${elementLocationY}
    Should Be True    ${h} < ${elementLocationY}
