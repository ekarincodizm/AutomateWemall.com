*** Settings ***
Resource            ${CURDIR}/../common/api_keywords.robot
Library             HttpLibrary.HTTP

*** Keywords ***
####### GET #######
Get Static Content By content
    [Arguments]    ${content}
    HTTP Get Request    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}

Get Static Content By content and lang
    [Arguments]    ${content}    ${lang}
    HTTP Get Request    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}?lang=${lang}

Get Static Content By content and version
    [Arguments]    ${content}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}/${version}

Get Static Content By content and version and lang
    [Arguments]    ${content}    ${version}    ${lang}
    HTTP Get Request    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}/${version}?lang=${lang}

####### POST #######
Create Static Content
    [Arguments]    ${content}    ${version}    ${en_US}    ${th_TH}
    ${request_body}=    Generate JSON    ${version}    ${en_US}    ${th_TH}
    Send Post Staticcontents Success    ${content}    ${request_body}

Create Static Content WO TH
    [Arguments]    ${content}    ${version}    ${en_US}
    ${request_body}=    Generate JSON WO TH    ${version}    ${en_US}
    Send Post Staticcontents Fail    ${content}    ${request_body}

Create Static Content WO Version
    [Arguments]    ${content}    ${en_US}    ${th_TH}
    ${request_body}=    Generate JSON WO Version    ${en_US}    ${th_TH}
    Send Post Staticcontents Fail     ${content}    ${request_body}

Send Post Staticcontents Success
    [Arguments]    ${content}    ${request_body}
    HTTP Post Request    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}    ${request_body}

Send Post Staticcontents Fail
    [Arguments]    ${content}    ${request_body}
    HTTP Post Request Failed    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}    ${request_body}

####### PUT #######
Update Static Content
    [Arguments]    ${content}    ${version}    ${en_US}    ${th_TH}
    ${request_body}=    Generate JSON    ${version}    ${en_US}    ${th_TH}
    Send Put Staticcontents Success    ${content}    ${request_body}

Update Static Content By Json Data
    [Arguments]    ${content}       ${request_body}
    Send Put Staticcontents Success    ${content}    ${request_body}

Update Static Content WO TH
    [Arguments]    ${content}    ${version}    ${en_US}
    ${request_body}=    Generate JSON WO TH    ${version}    ${en_US}
    Send Put Staticcontents Fail    ${content}    ${request_body}

Update Static Content WO Version
    [Arguments]    ${content}    ${en_US}    ${th_TH}
    ${request_body}=    Generate JSON WO Version    ${en_US}    ${th_TH}
    Send Put Staticcontents Fail    ${content}    ${request_body}

Publish Static Content Success
    [Arguments]    ${content}    ${version}    ${en_US}    ${th_TH}
    Update Static Content    ${content}    ${version}    ${en_US}    ${th_TH}

Publish Static Content Fail
    [Arguments]    ${content}    ${version}    ${en_US}    ${th_TH}
    ${request_body}=    Generate JSON    ${version}    ${en_US}    ${th_TH}
    Send Put Staticcontents Fail    ${content}    ${request_body}

Send Put Staticcontents Success
    [Arguments]    ${content}    ${request_body}
    HTTP Put Request    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}    ${request_body}

Send Put Staticcontents Fail
    [Arguments]    ${content}    ${request_body}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${STATIC_CONTENTS}${content}    ${request_body}

####### Verify #######
Verify PUT/POST Success
    ${response_body}=     Get Response Body
    ${th_TH}=    Get Json Value    ${response_body}    /data/th_TH
    ${en_US}=    Get Json Value    ${response_body}    /data/en_US
    ${version}=    Get Json Value    ${response_body}    /data/version
    ${content}=    Get Json Value    ${response_body}    /data/content
    Response Status Code Should Equal    200 OK
    Should Not Be Empty     ${th_TH}
    Should Not Be Empty     ${en_US}
    Should Not Be Empty     ${version}
    Should Not Be Empty     ${content}

Verify PUT/POST Invalid Inputs
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Response Status Code Should Equal    400
    Should Be Equal    ${message}    "Invalid inputs"

Verify Get Response With Specify Lang
    [Arguments]    ${lang}
    ${response_body}=     Get Response Body
    ${lang_data}=    Get Json Value    ${response_body}    /data/${lang}
    Response Status Code Should Equal    200 OK
    Should Not Be Empty     ${lang_data}

Verify Get Response Data Not Found
    ${response_body}=     Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    Response Status Code Should Equal    200 OK
    Should Not Be Empty     ${data}

Verify Get Response
    ${response_body}=     Get Response Body
    ${th_TH}=    Get Json Value    ${response_body}    /data/th_TH
    ${en_US}=    Get Json Value    ${response_body}    /data/en_US
    Response Status Code Should Equal    200 OK
    Should Not Be Empty     ${th_TH}
    Should Not Be Empty     ${en_US}

Verify Publish Fail
    [Arguments]    ${expContent}
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Response Status Code Should Equal    400
    Should Be Equal     "The draft version storefront of the content '${expContent}' does not exist"    ${message}

####### GEN JSON #######
Generate JSON
    [Arguments]    ${version}    ${en_US}    ${th_TH}
    ${json}=    Create Dictionary    version=${version}    en_US=${en_US}    th_TH=${th_TH}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Generate JSON WO TH
    [Arguments]    ${version}    ${en_US}
    ${json}=    Create Dictionary    version=${version}    en_US=${en_US}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Generate JSON WO Version
    [Arguments]    ${en_US}    ${th_TH}
    ${json}=    Create Dictionary    th_TH=${th_TH}    en_US=${en_US}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}



