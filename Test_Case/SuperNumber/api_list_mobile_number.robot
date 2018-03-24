*** Settings ***
Force Tags     WLS_Supernumber     WLS_High
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     requests
Library     String

Resource    ${CURDIR}/../../Resource/init.robot
Resource    ${CURDIR}/../../Keyword/API/api_super_number/keyword_super_number_common.robot
Resource    ${CURDIR}/../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource    ${CURDIR}/../../Keyword/API/api_super_number/web_element_super_number_common.robot

*** Variables ***


*** Test Cases ***

TC_ITMWM_07484 To verify that API get list numbers and return code = success
    [Tags]    TC_ITMWM_07484    regression    ready

    ${data}=    SuperNumber - Prepare Data Insert Mobile Number    total_number=10    total_use=1    total_permanent=1    total_inactive=1    total_hold=1    total_expired=1
    ${import_lot}=    Get From Dictionary    ${data}    import_lot

    ${check}=    SuperNumber - Verify Api List Mobile Response Success    ${data}

     Should Be Equal    ${check}    success

    [Teardown]    SuperNumber - Delete Data With Import Lot And Company Code    ${import_lot}

TC_ITMWM_07485 To verify that API return code = error when system send key = invalid.
    [Tags]    TC_ITMWM_07485    regression    ready

    ${url_path}=    Set Variable    /mobile-number/list/${API_KEY_INVALID}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}

    SuperNumber - Verify Response Check Available list Fail    ${result}    ${DATA_NULL}    ${ERROR_CODE_WMM4001}    ${ERROR_MESSAGE_WMM4001}

TC_ITMWM_07486 To verify that API return code = error when system send key = null.
    [Tags]    TC_ITMWM_07486    regression    ready

    ${value} =  Get Variable Value  ${SP_ENV_PCMS}
    Log To Console    value = ${value}
    ${RESULT_HEADER}=    Run Keyword If    '${value}' == 'None'    Set Variable    403
    ...    ELSE    Set Variable    ${RESULT_HEADER_404}
    ${message}=    Run Keyword If    '${value}' == 'None'    Set Variable    Missing Authentication Token
    ...    ELSE    Set Variable    404 NOT FOUND

    ${url_path}=    Set Variable    /mobile-number/list/
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER}

    Run Keyword If    '${value}' == 'None'    Should Contain    ${result}    ${message}
    ...    ELSE    SuperNumber - Verify Response Check Available list Fail    ${result}    ${DATA_NULL}    ${ERROR_CODE_WMM4001}    ${ERROR_MESSAGE_WMM4001}


TC_ITMWM_07487 To verify that API return data = null when system send page more than current page.
    [Tags]    TC_ITMWM_07487    regression    ready

    ${url_path}=    Set Variable    /mobile-number/list/${API_KEY}?page=9999999999
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}
    #Log To Console    ${result}
    SuperNumber - Verify Response Check Available list page invalid    ${result}    9999999999    ${DATA_NULL}
    Should Contain    ${result}    total
    Should Contain    ${result}    per_page
    Should Contain    ${result}    current_page
    Should Contain    ${result}    last_page
    Should Contain    ${result}    from
    Should Contain    ${result}    to

TC_ITMWM_07516 To verify that API return code = error when system send page = invalid.
    [Tags]    TC_ITMWM_07516    regression    ready
    ${url_path}=    Set Variable    /mobile-number/list/${API_KEY}?page=onetwo
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}
    #Log To Console    ${result}
    SuperNumber - Verify Response Check Available list Fail    ${result}    ${DATA_NULL}    ${ERROR_CODE_WMM4005}    ${ERROR_MESSAGE_WMM4005}

TC_ITMWM_07488 To verify that API return default page = 1 when system send page = null.
    [Tags]    TC_ITMWM_07488    regression    ready

    ${url_path}=    Set Variable    /mobile-number/list/${API_KEY}?page=
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}
    #Log To Console    ${result}
    SuperNumber - Verify Response Check Default page    ${result}    ${DEFAULT_PAGE}
    Should Contain    ${result}    total
    Should Contain    ${result}    per_page
    Should Contain    ${result}    current_page
    Should Contain    ${result}    last_page
    Should Contain    ${result}    from
    Should Contain    ${result}    to


