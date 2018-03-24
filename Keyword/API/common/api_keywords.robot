*** Settings ***
Library           ${CURDIR}/../../../Python_Library/common/jsonLibrary.py
Library           HttpLibrary.HTTP
Library           Collections
Library           String

*** Keywords ***
############ Request ############
HTTP Get Request
    [Arguments]    ${Host}    ${Context}    ${URL}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Log    ${Host}${URL}
    HttpLibrary.HTTP.GET    ${URL}
    Sleep    50 milliseconds

HTTP Get Request Failed
    [Arguments]    ${Host}    ${Context}    ${URL}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Next Request Should Not Succeed
    Log    ${URL}
    HttpLibrary.HTTP.GET    ${URL}
    Sleep    50 milliseconds

HTTP Post Request
    [Arguments]    ${Host}    ${Context}    ${URL}    ${request_body}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}    ${ContentType}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Set Request Header    Content-Type    ${ContentType}
    Set Request Body    ${request_body}
    Log    ${URL}
    HttpLibrary.HTTP.POST    ${URL}
    Sleep    50 milliseconds

HTTP Post Request Failed
    [Arguments]    ${Host}    ${Context}    ${URL}    ${request_body}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Set Request Body    ${request_body}
    Next Request Should Not Succeed
    Log    ${URL}
    HttpLibrary.HTTP.POST    ${URL}
    Sleep    50 milliseconds

HTTP Put Request
    [Arguments]    ${Host}    ${Context}    ${URL}    ${request_body}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Set Request Body    ${request_body}
    Log    ${URL}
    HttpLibrary.HTTP.PUT    ${URL}
    Sleep    50 milliseconds

HTTP Put Request Failed
    [Arguments]    ${Host}    ${Context}    ${URL}    ${request_body}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Set Request Body    ${request_body}
    Next Request Should Not Succeed
    Log    ${URL}
    HttpLibrary.HTTP.PUT    ${URL}
    Sleep    50 milliseconds

HTTP Delete Request
    [Arguments]    ${Host}    ${Context}    ${URL}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Log    ${Context}${Host}${URL}
    Log    ${URL}
    HttpLibrary.HTTP.DELETE    ${URL}
    Sleep    50 milliseconds

HTTP Delete Request Failed
    [Arguments]    ${Host}    ${Context}    ${URL}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    Restore Http Context
    Create Http Context    ${Host}    ${Context}
    Run Keyword If    "${Anonymousid}"!="${EMPTY}"    Set Request Header    X-Wm-Anonymousid    ${Anonymousid}
    Run Keyword If    "${AccessTokens}"!="${EMPTY}"    Set Request Header    X-Wm-Accesstoken    ${AccessTokens}
    Next Request Should Not Succeed
    Log    ${URL}
    HttpLibrary.HTTP.DELETE    ${URL}
    Sleep    50 milliseconds

############ Get Tokens ############
Get Tokens from AAD
    [Arguments]    ${account_name}    ${password}    ${grant_type}
    Post to Get Tokens    ${account_name}    ${password}    ${grant_type}
    ${response_body}=    Get Response Body
    ${access_token}=    Get Value From Response Body without Quotation Marks    ${response_body}    /access_token
    ${refresh_token}=    Get Value From Response Body without Quotation Marks    ${response_body}    /refresh_token
    ${TOKENS}=    Create Dictionary    access_token=${access_token}    refresh_token=${refresh_token}
    Set Suite Variable    ${TOKENS}    ${TOKENS}
    Set Suite Variable    ${ACCESS_TOKENS}    ${access_token}
    Set Suite Variable    ${REFRESH_TOKENS}    ${refresh_token}

Post to Get Tokens
    [Arguments]    ${account_name}    ${password}    ${grant_type}
    Restore Http Context
    Create Http Context    ${AAD_API_HOST}    http
    Set Basic Auth    ${account_name}    ${password}
    Set Request Header    Content-Type    application/x-www-form-urlencoded
    Set Request Body    grant_type=${grant_type}
    HttpLibrary.HTTP.POST    ${Tokens_API}

############ Verify ############
Verify Message in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal As Strings    "${expected_mssage}"    ${message}    Message Not Matched

Verify Data is Not Empty
    [Arguments]    ${response_body}
    ${data}=    Get Json Value    ${response_body}    /data
    Should Not Be Equal As Strings    null    ${data}    Data is empty
    Should Not Be Equal As Strings    []    ${data}    Data is empty

Verify Response Success but Data Empty
    [Arguments]    ${expected_empty_format}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    Should Be Equal    ${expected_empty_format}    ${data}    Data not empty

Verify Node Data is Not Empty
    [Arguments]    ${response_body}    ${node_data}
    ${data}=    Get Json Value    ${response_body}    ${node_data}
    Should Not Be Equal As Strings    null    ${data}    Node ${node_data} is empty
    Should Not Be Equal As Strings    []    ${data}    Node ${node_data} is empty

Verify Node Data is Empty
    [Arguments]    ${response_body}    ${node_data}    ${expected_empty_format}
    ${data}=    Get Json Value    ${response_body}    ${node_data}
    Should Be Equal    ${expected_empty_format}    ${data}    Node '${node_data}' not empty

Assert Node Data Value with Expected
    [Arguments]    ${response_body}    ${node_data}    ${expected_data}    ${message}
    ${actual_data}=    Get Json Value    ${response_body}    ${node_data}
    Should Be Equal    "${expected_data}"    ${actual_data}    ${message}

Check List Should Be Equal
    [Arguments]    ${expected_list}    ${actual_list}    ${message}=none
    Sort List    ${expected_list}
    Sort List    ${actual_list}
    Lists Should Be Equal    ${expected_list}    ${actual_list}    ${message}

Verify Reponse Failed Because API Gateway Not Nefine
    Verify Response Status Code and Message    500 Internal Server Error    Not-Found handler is not callable or is not defined

Verify Response Success and Data Not Empty
    ${response_body}=     Get Response Body
    Response Status Code Should Equal    200 OK
    Verify Data is Not Empty    ${response_body}

Verify Response Status Code and Message
    [Arguments]    ${expected_status_code}    ${expected_message}
    Response Status Code Should Equal    ${expected_status_code}
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal As Strings    "${expected_message}"    ${message}    Error message didn't match

Assert Error Code
    [Arguments]    ${response_body}    ${expected_errorCode}
    ${errorCode}=    Get Json Value    ${response_body}    /errorCode
    Should Be Equal As Strings    "${expected_errorCode}"    ${errorCode}    Error code didn't match

Assert Error Message
    [Arguments]    ${response_body}    ${expected_errorMessage}
    ${errorMessage}=    Get Json Value    ${response_body}    /errorMessage
    Should Be Equal As Strings    "${expected_errorMessage}"    ${errorMessage}    Error message didn't match

Assert Error Description
    [Arguments]    ${response_body}    ${expected_errorDescription}
    ${errorDescription}=    Get Json Value    ${response_body}    /errorDescription
    Should Be Equal As Strings    "${expected_errorDescription}"    ${errorDescription}    Error description didn't match

Verify Error Code Message
    [Arguments]    ${status_code}    ${expected_errorCode}    ${expected_errorMessage}    ${expected_errorDescription}
    Response Status Code Should Equal    ${status_code}
    ${response_body}=     Get Response Body
    Assert Error Code    ${response_body}    ${expected_errorCode}
    Assert Error Message    ${response_body}    ${expected_errorMessage}
    Assert Error Description    ${response_body}    ${expected_errorDescription}

Verify Error Code and Message
    [Arguments]    ${status_code}    ${expected_errorCode}    ${expected_errorMessage}
    Response Status Code Should Equal    ${status_code}
    ${response_body}=     Get Response Body
    ${errorCode}=    Get Json Value    ${response_body}    /code
    ${errorMessage}=    Get Json Value    ${response_body}    /message
    Should Be Equal As Strings    "${expected_errorMessage}"    ${errorMessage}    Error message didn't match
    Should Be Equal As Strings    ${expected_errorCode}    ${errorCode}    Error code didn't match

Verify Request Failed Because Access Token Expired
    Verify Error Code Message    401 Unauthorized    CPS4002    Expired token    Expired token

Verify Request Failed Because Access Token Expired for CSS
    Verify Error Code and Message    401 Unauthorized    401    Expired token

############ Utility ############
Add Node to Json Body
    [Arguments]    ${json_body}    ${key}    ${value}
    ${dict}=    Convert json to Dict    ${json_body}
    Set To Dictionary    ${dict}    ${key}    ${value}
    ${return_json}=    Convert Dict to json    ${dict}
    [Return]    ${return_json}

Send Http Get Request
    [Arguments]    ${host}    ${port}    ${path}    ${content}
    Restore Http Context
    Create Http Context    ${host}    http
    Next Request Should Succeed
    HttpLibrary.HTTP.GET    ${path}
    Response Status Code Should Equal    200
    ${response}=    Get Response Body
    ${response_code}=    Get Json Value    ${response}    /code
    Should Be Equal As Strings    ${response_code}    200
    Return From Keyword    ${response}

Send Http Post Request
    [Arguments]    ${host}    ${port}    ${path}    ${content}    ${content-type}
    Restore Http Context
    Create Http Context    ${host}    http
    Next Request Should Succeed
    Set Request Body    ${content}
    Set Request Header    Content-Type    application/json
    HttpLibrary.HTTP.POST    ${path}
    Response Status Code Should Equal    200
    ${response}=    Get Response Body
    ${response_code}=    Get Json Value    ${response}    /code
    Should Be Equal As Strings    ${response_code}    200
    Return From Keyword    ${response}

Remove Node from Json Body
    [Arguments]    ${json_body}    ${key}
    ${dict}=    Convert json to Dict    ${json_body}
    Remove From Dictionary    ${dict}    ${key}
    ${return_json}=     Convert Dict to json    ${dict}
    [Return]    ${return_json}

Get Value From Response Body without Quotation Marks
    [Arguments]    ${response_body}    ${node_data}
    ${return_value}=    Get Json Value    ${response_body}    ${node_data}
    ${return_value}=    Cut Quotation Marks and Get Only Value    ${return_value}
    [Return]    ${return_value}

Cut Quotation Marks and Get Only Value
    [Arguments]    ${string}
    ${string_length}=    Get Length    ${string}
    ${last_string}=    Evaluate    ${string_length}-1
    ${return_string}=    Get Substring    ${string}    1    ${last_string}
    [Return]    ${return_string}

