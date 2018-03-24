*** Settings ***
Library           Collections
Library           RequestsLibrary
Library           HttpLibrary.HTTP
Library           DateTime
Resource          ../../../../Resource/Env_config.robot
Library           DatabaseLibrary
Resource          ../../../../Resource/Env_config.robot
Resource          WebElement_AAD_Common.robot

*** Keywords ***
AAD POST /v1/merchants
    [Arguments]    ${username}    ${password}    ${password_confirm}    ${first_name}    ${last_name}    ${email}
    Comment    ${header}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded    Basic=Zmxhc2g6Rmxhc2gxMjM0
    Comment    ${auth}=    Create List    flash    Flash1234
    Comment    Create Session    auth    ${Merchant_API_URL}    headers=${header}    auth=${auth}
    Comment    ${resp}=    Post Request    auth    /authen/v1/tokens?grant_type=merchant
    Comment    ${json_obj}    To Json    ${resp.text}
    Comment    ${access_token}    Get From Dictionary    ${json_obj}    access_token
    Comment    ${header}=    Create Dictionary    x-wm-accessToken=${access_token}
    ${header}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    Comment    Set To Dictionary    ${header}    Content-Type=application/x-www-form-urlencoded
    Create Session    Http Post    ${AAD_API}
    ${body}=    Set Variable    username=${username}&first_name=${first_name}&last_name=${last_name}&password=${password}&password_confirm=${password_confirm}&email=${email}
    ${response}=    Post Request    Http Post    /authen/v1/merchants    ${body}    ${header}
    [Return]    ${response}

AAD Create merchant user
    [Arguments]    ${username}    ${password}    ${password_confirm}    ${first_name}    ${last_name}    ${email}
    ${response}=    AAD POST /v1/merchants    ${username}    ${password}    ${password_confirm}    ${first_name}    ${last_name}
    ...    ${email}
    AAD Verify return code and return message    ${response}    ${201}    Success
    [Return]    ${response}

AAD Verify return code and return message
    [Arguments]    ${response}    ${return_code}    ${expect_message}
    ${json_obj}    To Json    ${response.text}
    Should Be Equal    ${response.status_code}    ${return_code}
    ${message}=    Run Keyword If    ${response.status_code}==201    Get From Dictionary    ${json_obj}    user_id
    Return From Keyword If    ${response.status_code}==201    ${message}
    ${message}=    Run Keyword If    ${response.status_code}!=201    Get From Dictionary    ${json_obj}    errorMessage
    Run Keyword If    ${return_code}!=201    Should Be Equal    ${message.strip()}    ${expect_message.strip()}
    Return From Keyword If    ${response.status_code}!=201    ${message}
    [Return]    ${message}

Delete AAD user from DB by userid
    [Arguments]    ${user_id}
    Connect To Database    pymysql    wemall_aad    root    passwordaad    ${AAD_database}    3306
    Execute Sql String    delete t1,t2,t3,t4,t5,t6,t7 from user_identity as t1 \ inner join user as t2 on t1.User_id = t2.id \ inner join user_password as t3 on t1.User_id = t3.User_id \ left outer join merchant as t4 on t1.User_id = t4.User_id \ left outer join valid_refresh_token as t5 on t1.User_id = t5.User_id \ left outer join shopper as t6 on t1.User_id = t6.User_id \ left outer join USER_ADDRESS as t7 on t1.id = t7.id \ where t1.User_id = ${user_id}
    Connect To Database    pymysql    wms_s_rds_authz    root    passwordauthz    ${AAD_database_Authz}    3306
    Execute Sql String    delete from user_shop_role where user_id = ${user_id}

AAD Login And Get Token
    Create Http Context   ${AAD-HOST-API}   http
    Set Request Header    Content-Type   ${AAD-HEADER}
    Set Request Header    Authorization   Basic dGVzdDpwYXNzd29yZA==
    Next Request Should Succeed
    HttpLibrary.HTTP.POST   ${AAD-LOGIN-URI}
    ${body}=   Get Response Body


    #Create Http Context   ${AAD-HOST-API}   http
    Set Request Header   Content-Type   ${AAD-HEADER}
    Set Request Header    Authorization   Basic dGVzdDpwYXNzd29yZA==
    HttpLibrary.HTTP.POST   /authen/v1/tokens?grant_type=merchant
    ${body}=   Get Response Body
    ${refresh-token}=  Get Json Value   ${body}   /refresh_token
    ${access-token}=   Get Json Value   ${body}   /access_token
    ${refresh-token}=  Replace String   ${refresh-token}  "  ${EMPTY}
    ${access-token}=   Replace String   ${access-token}  "  ${EMPTY}

    ${dict}=  Create Dictionary   refresh_token=${refresh-token}  access_token=${access-token}

    [Return]  ${dict}
