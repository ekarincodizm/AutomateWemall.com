*** Settings ***
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Keywords ***
Open Mobile Browser
    [Arguments]     ${HOST}    ${BROWSER}    ${ALIAS}=None
    Open Browser    ${HOST}    ${BROWSER}    ${ALIAS}
    Add Cookie      is_mobile  true
    Reload Page
    Set Window Position   ${0}      ${0}
    Set Window Size       ${320}    ${568}

Go To Wemall Mobile URL
    [Arguments]    ${full_url}
    Go To          ${full_url}
    #if cookie 'is_mobile' does not exists then set it first
    ${hasCookie}=    Run Keyword And Return Status    Get Cookie Value    is_mobile
    Run Keyword If    ${hasCookie}==${FALSE}    Set Cookie to Mobile and Reload Page
    #Set cookie if is_mobile is false to prevent 'reload'
    ${is_currently_mobile}=       Get Cookie Value    is_mobile
    Run Keyword If                'false' == '${is_currently_mobile}'
    ...                           Set Cookie to Mobile and Reload Page
    Wait Until Angular Ready    30s

# Private keyword used by 'Go To Wemall Mobile URL'
Set Cookie to Mobile and Reload Page
    Add Cookie    is_mobile    true
    Reload Page


Go To Wemall Mobile URL With Reload Url
    [Arguments]    ${full_url}
    Go To          ${full_url}
    #if cookie 'is_mobile' does not exists then set it first
    ${hasCookie}=    Run Keyword And Return Status    Get Cookie Value    is_mobile
    Run Keyword If    ${hasCookie}==${FALSE}    Set Cookie to Mobile and Reload Page With Url    ${full_url}
    #Set cookie if is_mobile is false to prevent 'reload'
    ${is_currently_mobile}=       Get Cookie Value    is_mobile
    Run Keyword If                'false' == '${is_currently_mobile}'
    ...                           Set Cookie to Mobile and Reload Page With Url    ${full_url}
    Wait Until Angular Ready    30s

Set Cookie to Mobile and Reload Page With Url
    [Arguments]    ${full_url}
    Add Cookie    is_mobile    true
    Go To          ${full_url}