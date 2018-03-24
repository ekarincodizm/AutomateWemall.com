*** Settings ***
Resource        ${CURDIR}/../../Resource/init.robot
Resource        ${CURDIR}/../../Keyword/Portal/Point_redeem_api/Keywords_point_api.robot
Resource        ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Library         ${CURDIR}/../../Python_Library/DatabaseDataPoint.py
Library           Collections
Library           String
Library           OperatingSystem
Library           HttpLibrary.HTTP

*** Variable ***
${api_key_wemall}    1464942680
${api_key_weloveshoping}    1464942687
${trueyou}    1
${bay}    2
${header_error_code_400}    400 Bad Request
${userid}    99

*** Test Cases ***

API_Genarate Form_001 - To verify that API generate form return correct True You form-field and form-step 
    [Tags]    API_Genarate_Form_001

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${api_key_wemall}/${trueyou}/${userid}

    Point API - Verify Node API In API Generate Form For Trueyou Success    ${response}

API_Genarate Form_002 - To verify that API generate form return correct BAY form-field and form-step 
    [Tags]    API_Genarate_Form_002

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${api_key_wemall}/${bay}/${userid}

    Point API - Verify Node API In API Generate Form For BAY Success    ${response}

API_Genarate Form_003 - To verify that API generate form for verify next step return correct True You form-field and form-step when system send url with out User_ID
    [Tags]    API_Genarate_Form_003

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${api_key_wemall}/${trueyou}

    Point API - Verify Node API In API Generate Form For Trueyou Success    ${response}

API_Genarate Form_004 - To verify that API generate form for verify next step return correct BAY form-field and form-step when system send url with out User_ID
    [Tags]    API_Genarate_Form_004

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${api_key_wemall}/${bay}

    Point API - Verify Node API In API Generate Form For BAY Success    ${response}

API_Genarate Form_005 - To verify that API generate form for verify next step return error message when system donot send API_Key
    [Tags]    API_Genarate_Form_005

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${bay}    404 Not Found

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found

    Point API - Verify Response Error    ${response}    ${json_error}

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}//${bay}    400 Invalid API Key

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_api_key

    Point API - Verify Response Error    ${response}    ${json_error}

API_Genarate Form_006 - To verify that API generate form for verify next step return error message when system donot send Partner_ID
    [Tags]    API_Genarate_Form_006     not-ready    Token_test

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${api_key_wemall}    404 Not Found

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found

    Point API - Verify Response Error    ${response}    ${json_error}

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${api_key_wemall}//${userid}    400 Your partner is not support in this api

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    partner_id_wrong
    ${json_error}=    Replace String    ${json_error}    "[]"    {"api_key":"${api_key_wemall}","partner_id":"","user_id":"${userid}"}

    Point API - Verify Response Error    ${response}    ${json_error}

API_Genarate Form_007 - To verify that API generate form for verify next step return error message when system donot send API_Key and Partner_ID
    [Tags]    API_Genarate_Form_007

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}///    404 Not Found

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found

    Point API - Verify Response Error    ${response}    ${json_error}

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/    404 Not Found

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found

    Point API - Verify Response Error    ${response}    ${json_error}

API_Genarate Form_009 - To verify that API generate form for verify next step return error message when system send incorrect Request URL
    [Tags]    API_Genarate_Form_009

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}///${api_key_wemall}/${bay}/${userid}    404 Not Found

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found

    Point API - Verify Response Error    ${response}    ${json_error}

API_Genarate Form_010 - To verify that API generate form for verify next step return error message when system send invalid API_Key
    [Tags]    API_Genarate_Form_010

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/TEST/${bay}    400 Invalid API Key

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_api_key

    Point API - Verify Response Error    ${response}    ${json_error}

API_Genarate Form_011 - To verify that API generate form for verify next step return error message when system send incorrect Partner_ID
    [Tags]    API_Genarate_Form_011    not-ready

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${api_key_wemall}/99/${userid}    400 Your partner is not support in this api

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    partner_id_wrong
    ${json_error}=    Replace String    ${json_error}    "[]"    {"api_key":"${api_key_wemall}","partner_id":"99","user_id":"${userid}"}

    Point API - Verify Response Error    ${response}    ${json_error}

API_Genarate Form_012 - To verify that API generate form for verify next step return error message when system send User_ID only
    [Tags]    API_Genarate_Form_012

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}///${userid}    400 Invalid API Key

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_api_key

    Point API - Verify Response Error    ${response}    ${json_error}

    ${response}=    Point API - Send Http Get Request    ${POINT_API_URL_GET_FORM}/${userid}    404 Not Found

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found