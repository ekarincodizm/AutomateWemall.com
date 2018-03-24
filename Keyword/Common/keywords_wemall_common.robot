#************************************************
#
#    @author    : Preme W.
#    @since     : May 6, 2016
#
#***************************************************


*** Settings ***
Library           Collections
Resource          ${CURDIR}/web_element_itruemart.robot

*** Keywords ***
#************************************************
#
#    @description    : check existing and create TEST VARIABLE
#
#***************************************************
Wemall Common - Init Test Variable

    ${test_var_exist}=    Run Keyword And Return Status    Variable Should Exist    ${TEST_VAR}
    ${dict}=    Run Keyword If    '${test_var_exist}' == '${False}'    Create Dictionary    page=init
    ...    ELSE    Set Variable    ${TEST_VAR}
    Set Test Variable    ${TEST_VAR}    ${dict}

#************************************************
#
#    @description    : Assign key, value to TEST VARIABLE
#
#***************************************************

Wemall Common - Assign Value To Test Variable
    [Arguments]    ${key}=None    ${value}=None
    #Run Keyword If    '${key}' == 'None'    Return From Keyword    Please enter key
    #Run Keyword If    '${value}' == 'None'    Return From Keyword    Please enter value
    Wemall Common - Init Test Variable
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    ${key}=${value}
    Set Test Variable    ${TEST_VAR}    ${dict}


#************************************************
#
#    @description:    Exception when get value from TEST VARIABLE
#
#***************************************************

Wemall Common - Get Value From Test Variable
    [Arguments]    ${key}=None
    Run Keyword If    '${key}' == 'None'    Return From Keyword    Please enter key
    ${alias_name}=    RUn Keyword And Return Status    Get From Dictionary    ${TEST_VAR}    alias_name
    ${can_get_value}=    Run Keyword And Return Status    Get From Dictionary    ${TEST_VAR}    ${key}
    Run Keyword If    '${can_get_value}' == '${False}'    Return From Keyword    DO_NOT_FOUND_KEY_IN_TEST_VARIABLE
    ${value}=    Get From Dictionary    ${TEST_VAR}    ${key}
    [Return]    ${value}


#************************************************
#
#    @description    :
#    Debugging value of variable and message when pass DEBUG:True in command line
#
#***************************************************
Wemall Common - Debug
    [Arguments]    ${data}=None    ${message}=${EMPTY}
    Run Keyword If    '${data}' == 'None'    Return From Keyword    Please enter data for DEBUG
    Run Keyword If    '${DEBUG}' == 'True'    Log To Console    ${\n}x=x=x=x=x=x=x ${message}=${data} x=x=x=x=x=x=x${\n}

#*****************************************************
#
#    @description:
#    Set display=none live chat
#
#*****************************************************
Wemall Common - Close Live Chat
    ${chatbar}=   Get Matching Xpath Count   ${XPATH_COMMON.live_chat}
	Run Keyword If  '${chatbar}' > '0'   Execute Javascript   document.getElementById('chatbar').style.display = 'none';


#*****************************************************
#
#	@description
#		Open new tab
#
#*****************************************************
Wemall Common - Open New Tab
    [Arguments]    ${url}=None
    Execute JavaScript    window.open('${url}', 'New Tab');

Wemall Common - Open Web Wemall Homepage
    [Arguments]   ${b}=${BROWSER}
    Open Browser   ${WEMALL_URL}  ${b}

Wemall Common - Open Mobile www. Wemall URL Homepage
    [Arguments]   ${b}=${BROWSER}
    Open Browser   ${WEMALL_URL}  ${b}
    Add Cookie      is_mobile   true
    Reload Page

Wemall Common - Open Mobile m. Wemall URL Homepage
    [Arguments]   ${b}=${BROWSER}
    Open Browser   ${WEMALL_MOBILE}  ${b}
    Add Cookie      is_mobile   true
    Reload Page

Wemall Common - Go To Wemall Home Page
    Go To   ${WEMALL_URL}

Wemall Common - Go To iTruemart Home Page
    Go To    ${WEMALL_URL}/itruemart

Wemall Common - Wait Until Element Is Visible And Ready
    [Arguments]  ${element}=None
    Run Keyword If  '${element}' == 'None'  Return From Keyword   Required Xpath Element
    Wait Until Element Is Visible   ${element}   60s
    Wait Until Page Contains Element  ${element}  60s

Wemall Common - Do Again If First Action Is Failed
    [Arguments]   ${element}   ${action}=click

    Run Keyword If   '${action}' == 'click'  Wemall Common - Click Again If First Click Is Failed  ${element}
     ...  ELSE IF   '${action}' == 'input'   Wemall Common - Input Again If First Input Is Failed  ${element}

Wemall Common - Click Again If First Click Is Failed
    [Arguments]   ${element}
    ${click_element}=  Run Keyword And Return Status   Click Element   ${element}
    Run Keyword If   '${click_element}' == '${False}'   Click Element  ${element}


Wemall Common - Input Again If First Input Is Failed
    [Arguments]  ${element}
    Log to console  xxxx


Wemall Common - Logout
    Go To    ${WEMALL_URL}/auth/logout

Wemall Common - Success Message Is Display
    Wait Until Element Is Visible   //div[@class="alert alert-success"]   60s

