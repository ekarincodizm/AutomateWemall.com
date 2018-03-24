*** Settings ***
Library           Collections
Library           DateTime
Resource          ${CURDIR}/../../../Resource/Config/${ENV}/env_config.robot
Library           RequestsLibrary
#Library           HttpLibrary
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
#Resource          WebElement_Common.robot
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/Config/${ENV}/database.robot
Library         ${CURDIR}/../../../Python_Library/DatabaseDataPoint.py

*** Keywords ***
Authen API - Verify Response Success
    [Arguments]    ${response_body}    ${request_api_key}
    ${response_api_key}=    Point API - Get Data From Json    ${response_body}    /api_key
    ${response_api_token}=    Point API - Get Data From Json    ${response_body}    /api_token
    ${response_api_key}=    Convert To Integer    ${request_api_key}

    Should Be Equal    ${response_api_key}    ${request_api_key}
    Should Not Be Empty    ${response_api_token}

Authen API - Verify Response False
    [Arguments]    ${response_body}    ${expect_error_msg}
    ${response_errorMessage}=    Get Json Value    ${response_body}    /errorMessage
    ${expect_error_msg}=    Convert To String    ${expect_error_msg}

    Should Be Equal    ${response_errorMessage}    ${expect_error_msg}

Point API - Request Token Success
    ${api_token}=    Point API - Get API Token From Authen
    ${user_id}    Set Variable    RobotPoint
    ${username}    Set Variable    j_atthapon@hotmail.com
    ${password}    Set Variable    99999999
    ${partner_id}    Set Variable    1

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}

    Point API - Verify Node API In API Request Token Success    ${request_body}    ${response}

    ${response_data}    Get Json Value    ${response}    /data
    ${response_data_token}=    Point API - Get Data From Json    ${response_data}   /token

    Point API - Check User Token Exists In DB    ${user_id}    ${response_data_token}    ${partner_id}

    ${json_data}=    Set Variable    {}
    ${json_data}=    Add Node to Json Body    ${json_data}    api_token    ${api_token}
    ${json_data}=    Add Node to Json Body    ${json_data}    user_id    ${user_id}
    ${json_data}=    Add Node to Json Body    ${json_data}    partner_id    ${partner_id}
    ${json_data}=    Add Node to Json Body    ${json_data}    user_token    ${response_data_token}

    Return From Keyword    ${json_data}

Point API - Get API Token From Authen
    [Arguments]    ${api_key}=    ${api_secret}=

    ${api_key_and_secret}=    Point API - Get api_key and api_secret
    ${api_key}    Set Variable    ${api_key_and_secret[0]}
    ${api_secret}    Set Variable    ${api_key_and_secret[1]}

    ${request_body_authen}=    Point API - Create Request Api Authen    "${api_key}"    "${api_secret}"

    ${response_authen}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body_authen}

    ${api_token}    Point API - Get Data From Json    ${response_authen}    /api_token

    Point API - Verify Token In DB    ${api_key}    ${api_secret}    ${api_token}

    Log To console    ${api_token}
    Return From Keyword    ${api_token}

Point API - Create Request Api Authen
    [Arguments]     ${api_key}=1464942680    ${api_secret}=95991a646701

    ${body_shipped}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/authen.json

    ${body_shipped}=    Set Json Value       ${body_shipped}    /api_key    ${api_key}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /api_secret    ${api_secret}

    Return From Keyword     ${body_shipped}

Point API - Create Request Api Request Token
    [Arguments]     ${api_token}=    ${user_id}=    ${username}=    ${password}=    ${partner_id}=

    ${body_shipped}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/request_token.json

    ${body_shipped}=    Set Json Value       ${body_shipped}    /api_token    ${api_token}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /user_id    ${user_id}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /username    ${username}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /password    ${password}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /partner_id    ${partner_id}

    Return From Keyword     ${body_shipped}

Point API - Create Request Api Redeem Node Key
    [Arguments]     ${sequence}=    ${key}=    ${price}=    ${point}=

    ${body_shipped}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/redeem_key.json

    ${body_shipped}=    Set Json Value       ${body_shipped}    /sequence    ${sequence}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /key    ${key}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /price    ${price}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /point    ${point}

    Return From Keyword     ${body_shipped}

Point API - Create Request Api Redeem
    [Arguments]     ${api_token}=    ${partner_id}=    ${request_id}=    ${user_id}=    ${total_point}=    ${keys}=

    ${body_shipped}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/redeem.json

    ${body_shipped}=    Set Json Value       ${body_shipped}    /api_token    ${api_token}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /partner_id    ${partner_id}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /request_id    ${request_id}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /user_id    ${user_id}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /total_point    ${total_point}
    ${body_shipped}=    Set Json Value       ${body_shipped}    /keys    ${keys}

    Return From Keyword     ${body_shipped}

Point API - Send Http Get Request
    [Arguments]    ${path}    ${status_code}=200
    Create Http Context    ${POINT_API_URL}    http
    Next Request Should Have Status Code    ${status_code}
    HttpLibrary.HTTP.GET    ${path}

    ${response}=    Get Response Body

    Return From Keyword    ${response}

Point API - Send Http Delete Request
    [Arguments]    ${path}    ${body}    ${status_code}=<Response [200]>
    Create Session    Http Delete    http://${POINT_API_URL}
    ${header}=    Create Dictionary    content-Type=application/json
    ${response}=    Delete Request    Http Delete    ${path}    ${body}    ${header}

    ${response_string}=    Convert To String    ${response}
    Should Be Equal     ${status_code}    ${response_string}

    Return From Keyword    ${response.json()}

Point API - Send Http Post Request
    [Arguments]    ${path}    ${body}    ${status_code}=200

    Create Http Context             ${POINT_API_URL}    http
    Set Request Header              Content-type     application/json
    Set Request Body                ${body}
    Next Request Should Have Status Code    ${status_code}

    HttpLibrary.HTTP.POST           ${path}

    ${response}=    Get Response Body

    Response Status Code Should Equal    ${status_code}

    Return From Keyword    ${response}

Point API - Get Multiple Error Invalid Input
    [Arguments]    ${json_error_all}

    ${json_error}=    Point API - Get Error For Expect Data    {}    invalid_input
    ${json_error}=    Replace String    ${json_error}    "[]"    [${json_error_all}]

    Return From Keyword    ${json_error}

Point API - Get Error For Expect Data
    [Arguments]    ${json_error}    ${error_type}    ${error_node}=null    ${error_message}=null

    ${error_data}=    Run Keyword If    '${error_node}'!='null'    Set Variable    ${error_node}    ELSE    Set Variable    []
    ${error_message}=    Run Keyword If    '${error_message}'!='null'    Set Variable    ${error_message}    ELSE    Point API - Get Error Message From Type And Node    ${error_type}    ${error_node}

    ${error_code}=    Point API - Get Error Code From Type    ${error_type}
#    ${error_message}=    Point API - Get Error Message From Type And Node    ${error_type}    ${error_node}

    ${json_data}=    Set Variable    {}

    ${json_data}=    Add Node to Json Body    ${json_data}    data    ${error_data}
    ${json_data}=    Add Node to Json Body    ${json_data}    errorCode    ${error_code}
    ${json_data}=    Add Node to Json Body    ${json_data}    errorMessage    ${error_message}

    ${error_json_data}=    Run Keyword If    ${json_error}!={}    Set Variable    ${json_error},${json_data}    ELSE    Set Variable    ${json_data}
    Return From Keyword    ${error_json_data}

Point API - Get Error Code From Type
    [Arguments]    ${error_type}

    ${error_all}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/error_code.json
    ${error_code_by_type}=    Point API - Get Data From Json       ${error_all}    /${error_type}

    Return From Keyword    ${error_code_by_type}

Point API - Get Error Message From Type And Node
    [Arguments]    ${error_type}    ${error_node}=null

    ${error_all}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/error_message.json
    ${convert_node_to_string}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/convert_node_to_string.json

    ${error_message_by_type}=    Point API - Get Data From Json       ${error_all}    /${error_type}

    ${error_node_string}=    Run Keyword If   '${error_node}' != 'null'    Point API - Get Data From Json    ${convert_node_to_string}    /${error_node}    ELSE    Set Variable   0
    ${error_message}=        Run Keyword If   '${error_node}' != 'null'    Replace String 	${error_message_by_type} 	{node_error}    ${error_node_string}    ELSE   Set Variable    ${error_message_by_type}

    Return From Keyword    ${error_message}

Point API - Verify Response Error
    [Arguments]    ${response}    ${response_expect}

    ${response_data}=    Point API - Get Data From Json       ${response}    /data
    ${response_code}=    Point API - Get Data From Json       ${response}    /errorCode
    ${response_message}=    Point API - Get Data From Json       ${response}    /errorMessage

    ${response_expect_data}=    Point API - Get Data From Json       ${response_expect}    /data
    ${response_expect_code}=    Point API - Get Data From Json       ${response_expect}    /errorCode
    ${response_expect_message}=    Point API - Get Data From Json       ${response_expect}    /errorMessage

    Should Be Equal   ${response_expect_code}    ${response_code}
    Should Be Equal   ${response_expect_message}    ${response_message}
    Should Be Equal   ${response_expect_data}    ${response_data}

Point API - Verify Response Error Without Data Node
    [Arguments]    ${response}    ${response_expect}

    ${response_code}=    Point API - Get Data From Json       ${response}    /errorCode
    ${response_message}=    Point API - Get Data From Json       ${response}    /errorMessage

    ${response_expect_code}=    Point API - Get Data From Json       ${response_expect}    /errorCode
    ${response_expect_message}=    Point API - Get Data From Json       ${response_expect}    /errorMessage

    Should Be Equal   ${response_expect_code}    ${response_code}
    Should Be Equal   ${response_expect_message}    ${response_message}

Point API - Verify Response Error For Redeem
    [Arguments]    ${response}    ${response_expect}

    ${response_data}=    Get Json Value       ${response}    /data
    ${response_code}=    Point API - Get Data From Json       ${response}    /errorCode
    ${response_message}=    Point API - Get Data From Json       ${response}    /errorMessage

    ${response_expect_data}=    Get Json Value       ${response_expect}    /data
    ${response_expect_code}=    Point API - Get Data From Json       ${response_expect}    /errorCode
    ${response_expect_message}=    Point API - Get Data From Json       ${response_expect}    /errorMessage

    ${response_data_keys}=    Point API - Get Data From Json       ${response_data}    /keys
    ${response_expect_data_keys}=    Point API - Get Data From Json       ${response_expect_data}    /keys

#    Log to console    ${response_data_keys}
#    Log to console    ${response_expect_data_keys}

    Should Be Equal   ${response_expect_code}    ${response_code}
    Should Be Equal   ${response_expect_message}    ${response_message}
#    Should Be Equal   ${response_expect_data_keys}    ${response_data_keys}

Point API - Verify Node API In API Request Token Success
    [Arguments]    ${request_body}    ${response}

    ${user_id}=    Point API - Get Data From Json       ${request_body}    /user_id
    ${username}=    Point API - Get Data From Json       ${request_body}    /username
    ${partner_id}=    Point API - Get Data From Json       ${request_body}    /partner_id

    ${response_data}    Get Json Value    ${response}    /data
    ${response_user_id}=    Point API - Get Data From Json       ${response_data}    /user_id
    ${response_username}=    Point API - Get Data From Json       ${response_data}    /username
    ${response_partner_id}=    Point API - Get Data From Json       ${response_data}    /partner_id
    ${response_partner_token}=    Point API - Get Data From Json       ${response_data}    /token

    Should Be Equal    ${user_id}    ${response_user_id}
    Should Be Equal    ${username}    ${response_username}
    Should Be Equal    ${partner_id}    ${response_partner_id}
    Should Not Be Empty    ${response_partner_token}

Point API - Verify Node API In API Generate Form For Trueyou Success
    [Arguments]    ${response}

    ${response_data}    Get Json Value    ${response}    /data
    ${response_form}=    Point API - Get Data From Json       ${response_data}    /form-field
    ${response_step}=    Point API - Get Data From Json       ${response_data}    /form-step

    Should Be Equal    ${response_form}    [{type: text, name: username, value: }, {type: password, name: password, value: }]
    Should Be Equal    ${response_step}    request-token

Point API - Verify Node API In API Generate Form For BAY Success
    [Arguments]    ${response}

    ${response_data}    Get Json Value    ${response}    /data
    ${response_form}=    Point API - Get Data From Json       ${response_data}    /form-field
    ${response_step}=    Point API - Get Data From Json       ${response_data}    /form-step

    Should Be Equal    ${response_form}    [{type: text, name: mobile, value: }, {type: text, name: card_no, value: }]
    Should Be Equal    ${response_step}    request-otp

Point API - Verify Response Cancel Token Success
    [Arguments]    ${response}    ${request_body}

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_user_token}=    Point API - Get Data From Json    ${request_body}   /user_token
    ${token_partner_id}=    Point API - Get Data From Json    ${request_body}   /partner_id

    Should Be Equal    ${token_user_id}    ${response['data']['user_id']}

    ${num_user}=    check_user_token_exists    ${token_user_id}    ${token_user_token}     ${token_partner_id}
    ${num_user}=    Convert To String    ${num_user}

    Should Be Equal    0    ${num_user}

Point API - Verify Response Cancel Token Error
    [Arguments]    ${response}    ${json_error_expect}    ${request_body}

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_user_token}=    Point API - Get Data From Json    ${request_body}   /user_token
    ${token_partner_id}=    Point API - Get Data From Json    ${request_body}   /partner_id

    ${json_error_expect}    To Json    ${json_error_expect}

    Compare Json    ${json_error_expect}    ${response}

    Point API - Check User Token Exists In DB    ${token_user_id}    ${token_user_token}     ${token_partner_id}

Point API - Verify Token In DB
    [Arguments]    ${api_key}    ${api_secret}    ${token}

    ${token_db}=    get_token_by_api_key_and_api_secret    ${api_key}    ${api_secret}
    Should Be Equal    ${token_db}    ${token}

Point API - Get Data From Json
    [Arguments]    ${body}    ${node}    ${remove_string}="
    ${data}=    Get Json Value       ${body}    ${node}

    ${data}=    Remove String    ${data}    ${remove_string}
    Return From Keyword    ${data}

Point API - Remove Node From Json Data
    [Arguments]    ${json_data}    ${node_for_remove}

    ${index}=    Set Variable    1
    :FOR    ${node_for_remove}    IN    @{node_for_remove}
    \    ${json_data}=    Remove Node from Json Body    ${json_data}    ${node_for_remove}

    Return From Keyword    ${json_data}

Point Request OTP - Create Request
    [Arguments]     ${api_token}=   ${user_id}=   ${partner_id}=    ${card_no}=    ${mobile}=

    ${request_body}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/request_otp.json
    ${request_body}=    Set Json Value      ${request_body}     /api_token      "${api_token}"
    ${request_body}=    Set Json Value      ${request_body}     /user_id      "${user_id}"
    ${request_body}=    Set Json Value      ${request_body}     /partner_id      "${partner_id}"
    ${request_body}=    Set Json Value      ${request_body}     /card_no      "${card_no}"
    ${request_body}=    Set Json Value      ${request_body}     /mobile      "${mobile}"

    Return From Keyword    ${request_body}

Point Request OTP - Verify Response
    [Arguments]    ${response}    ${expected}

    ${expected_user_id}=    Point API - Get Data From Json    ${expected}   /user_id
    ${expected_partner_id}=    Point API - Get Data From Json    ${expected}   /partner_id
    ${expected_card_no}=    Point API - Get Data From Json    ${expected}   /card_no

    ${response_data}=    Get Json Value    ${response}   /data

    ${response_user_id}=    Point API - Get Data From Json    ${response_data}   /user_id
    ${response_partner_id}=    Point API - Get Data From Json    ${response_data}   /partner_id
    ${response_card_no}=    Point API - Get Data From Json    ${response_data}   /card_no
    ${response_reference_otp}=    Point API - Get Data From Json    ${response_data}   /reference_otp

    Should Be Equal    ${expected_user_id}    ${response_user_id}
    Should Be Equal    ${expected_partner_id}    ${response_partner_id}
    Should Be Equal    ${expected_card_no}    ${response_card_no}

Point API - Get api_key and api_secret By merchant name
    [Arguments]    ${merchant_name}

    ${response}=    get_api_key_and_api_secret_by_name    ${merchant_name}
    Return From Keyword    ${response}

Point API - Get api_key and api_secret
    ${response}=    get_api_key_and_api_secret
    Return From Keyword    ${response}

Point API - Check User Token Exists In DB
     [Arguments]     ${user_id}    ${token}    ${partner_id}
     ${response}=    check_user_token_exists    ${user_id}    ${token}    ${partner_id}
     ${response}=    Convert To String    ${response}

     Should Be Equal    1    ${response}

Point API - Get Parnter In DB
    ${response}=    get_partner
    Return From Keyword    ${response}

Point API - Create Request Api Check Currency Money
    [Arguments]     ${api_token}=    ${partner_id}=    ${total_point}=
    ${body}=    Get Binary File      ${CURDIR}/../../../Resource/TestData/point/request_check_currency_money.json
    ${body}=    Set Json Value       ${body}    /api_token    ${api_token}
    ${body}=    Set Json Value       ${body}    /partner_id    ${partner_id}
    ${body}=    Set Json Value       ${body}    /total_point    ${total_point}

    Return From Keyword     ${body}

Point API - Compare Json Value
    [Arguments]     ${json1}=      ${json1_node}=       ${json2}=       ${json2_node}=
    ${json1_value}=     Point API - Get Data From json      ${json1}            ${json1_node}
    ${json2_value}=     Point API - Get Data From json      ${json2}            ${json2_node}
    Should Be Equal    ${json1_value}    ${json2_value}

