*** Settings ***
Library                 ${CURDIR}/../../../Python_Library/jsonLibrary.py
Resource                ${CURDIR}/../common/api_keywords.robot
Resource                ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/webelement_portal_page.robot
Library                 ${CURDIR}/../../../Python_Library/common.py
Library                 OperatingSystem
Library                 Collections
Library                 HttpLibrary.HTTP
Library                 ${CURDIR}/megamenus_keywords.py

*** Variables ***
${DRAFT}                draft
${PUBLISHED}            published

*** Keywords ***
############# Prepare #############
Prepare Template Data For Suite Get Mega Menu
    [Arguments]    ${menu_id}    ${json_data_file}
    Create Mega Menu Child Data    ${menu_id}    ${json_data_file}
    Verify Update Mega Menu Child Data Success
    Publish Mega Menu Data    ${menu_id}

Prepare Template Mega Menu Data Draft
    [Arguments]    ${menu_id}    ${json_data_file}
    Create Mega Menu Child Data    ${menu_id}    ${json_data_file}
    Verify Update Mega Menu Child Data Success

Prepare Mega Menu Showroom Banner From File
    [Arguments]     ${menu_id}    ${menu_index}    ${template_id}     ${banner_data_file_path}
    GET Mega Menu Child Data        ${menu_id}
    ${body} =           Get Response Body
    ${banner_data}=     Get File       ${banner_data_file_path}
    ${request_body}=    Build Mega Menu Showroom Banner Data    ${body}     ${menu_index}       ${template_id}      ${banner_data}
    Update Mega Menu Child Data By Eequest Body     ${menu_id}      ${request_body}
    Publish Mega Menu Data      ${menu_id}

Prepare Mega Menu Link Lv 1
    [Arguments]     ${menu_id}      ${menu_index}       ${link}
    GET Mega Menu Child Data        ${menu_id}
    ${body} =          Get Response Body
    ${request_body}=        Prepare Mega Menu Link       ${body}      ${menu_index}       1       ${link}
    Update Mega Menu Child Data By Eequest Body     ${menu_id}      ${request_body}
    Publish Mega Menu Data      ${menu_id}

Prepare Mega Menu Link Lv 2
    [Arguments]     ${menu_id}      ${menu_index}     ${menu_lv2_index}       ${link}
    GET Mega Menu Child Data       ${menu_id}
    ${body} =          Get Response Body
    ${request_body}=        Prepare Mega Menu Link       ${body}      ${menu_index}       2       ${link}       ${menu_lv2_index}
    Update Mega Menu Child Data By Eequest Body     ${menu_id}      ${request_body}
    Publish Mega Menu Data      ${menu_id}

Clear Template Data For Suite Get Mega Menu
    [Arguments]    ${menu_id}
    Delete Mega Menu Success    ${menu_id}

############# Get #############
Get Mega Menu Data Version Draft
    [Arguments]    ${menu_id}
    HTTP Get Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}?version=draft

GET Mega Menu Data
    [Arguments]    ${menu_id}
    HTTP Get Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}

GET Mega Menu Data Filter Version
    [Arguments]    ${menu_id}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}?version=${version}

GET Mega Menu Data Filter Language
    [Arguments]    ${menu_id}    ${language}
    HTTP Get Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}?language=${language}

GET Mega Menu Child Data
    [Arguments]    ${menu_id}
    HTTP Get Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child

Get Mega Menu Child Data Filter Version
    [Arguments]    ${menu_id}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child?version=${version}

############# Post #############
Create Mega Menu Data
    [Arguments]    ${menu_id}
    HTTP Post Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}    ${EMPTY}

Create Mega Menu Failed
    HTTP Post Request Failed    ${PORTAL_API}    http    ${MEGAMENUS}    ${EMPTY}

Create Mega Menu Child Failed
    [Arguments]    ${menu_id}
    HTTP Post Request Failed    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child    ${EMPTY}

Create Mega Menu Child Data
    [Arguments]    ${menu_id}    ${json_data_file}
    Update Mega Menu Child Data    ${menu_id}    ${json_data_file}    ${DRAFT}

############# Put #############
Update Mega Menu Child Data
    [Arguments]    ${menu_id}    ${json_data_file}    ${version}
    ${json_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Version to Json Body    ${json_body}        ${version}
    HTTP Put Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child    ${request_body}

Update Mega Menu Child Data By Eequest Body
    [Arguments]    ${menu_id}    ${request_body}
    HTTP Put Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child    ${request_body}

Update Mega Menu Child with Empty Data
    [Arguments]    ${menu_id}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child    ${EMPTY}

Update Mega Menu Child with No Node Data
    [Arguments]    ${menu_id}
    ${request_body}=    Create json Body Version
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child    ${request_body}

Update Mega Menu Child with No Node Version
    [Arguments]    ${menu_id}
    ${request_body}=    Create json Body Data
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child    ${request_body}

PUT Mega Menu Failed
    [Arguments]    ${menu_id}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}    ${EMPTY}

Publish Mega Menu Data
    [Arguments]    ${menu_id}
    ${request_body}=    Create json Body Version Published
    HTTP Put Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child    ${request_body}

############# Delete #############
Delete Mega Menu Data
    [Arguments]    ${menu_id}
    HTTP Delete Request    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}

Delete Mega Menu Success
    [Arguments]    ${menu_id}
    Delete Mega Menu Data    ${menu_id}
    Response Status Code Should Equal    200 OK

Delete Mega Menu Child Failed
    [Arguments]    ${menu_id}
    HTTP Delete Request Failed    ${PORTAL_API}    http    ${MEGAMENUS}${menu_id}/child

############# Verify #############
Assert Menu Id From Get Mega Menu with Expected
    [Arguments]    ${expected_menu_id}
    ${response_body}=     Get Response Body
    ${menu_id}=    Get Json Value    ${response_body}    /data/1/menu_id
    Should Be Equal    "${expected_menu_id}"    ${menu_id}    Menu Id didn't match

Assert Version From Get Mega Menu with Expected
    [Arguments]    ${expected_version}
    ${response_body}=     Get Response Body
    ${version}=    Get Json Value    ${response_body}    /data/1/version
    Should Be Equal    "${expected_version}"    ${version}    Version didn't match

Assert Menu Id From Get Mega Menu Child with Expected
    [Arguments]    ${expected_menu_id}
    ${response_body}=     Get Response Body
    ${menu_id}=    Get Json Value    ${response_body}    /data/menu_id
    Should Be Equal    "${expected_menu_id}"    ${menu_id}    Menu Id didn't match

Assert Version From Get Mega Menu Child with Expected
    [Arguments]    ${expected_version}
    ${response_body}=     Get Response Body
    ${version}=    Get Json Value    ${response_body}    /data/version
    Should Be Equal    "${expected_version}"    ${version}    Version didn't match

Assert Menu Id From Create Mega Menu with Expected
    [Arguments]    ${expected_menu_id}
    Assert Menu Id From Get Mega Menu Child with Expected    ${expected_menu_id}

Assert Version From Create Mega Menu with Expected
    [Arguments]    ${expected_version}
    Assert Version From Get Mega Menu Child with Expected    ${expected_version}

Assert Result From Create Mega Menu with Expected
    [Arguments]    ${expected_result}
    ${response_body}=     Get Response Body
    ${result}=    Get Json Value    ${response_body}    /data/result
    Should Be Equal    ${expected_result}    ${result}    result didn't match

Verify Get Mega Menu Success and Data Correct
    [Arguments]    ${expected_menu_id}    ${expected_version}
    Response Status Code Should Equal    200 OK
    Assert Menu Id From Get Mega Menu with Expected    ${expected_menu_id}
    Assert Version From Get Mega Menu with Expected    ${expected_version}

Verify Get Mega Menu Child Success and Data Correct
    [Arguments]    ${expected_menu_id}    ${expected_version}
    Response Status Code Should Equal    200 OK
    Assert Menu Id From Get Mega Menu Child with Expected    ${expected_menu_id}
    Assert Version From Get Mega Menu Child with Expected    ${expected_version}

Verify Get Mega Menu Success but Data Empty
    Verify Response Success but Data Empty    []

Verify Get Mega Menu Child Success but Data Empty
    Verify Response Success but Data Empty    []

Verify Create Mega Menu Success and Data Correct
    [Arguments]    ${expected_menu_id}    ${expected_version}
    Response Status Code Should Equal    200 OK
    Assert Menu Id From Create Mega Menu with Expected    ${expected_menu_id}
    Assert Version From Create Mega Menu with Expected    ${expected_version}
    Assert Result From Create Mega Menu with Expected    true

Verify Create Mega Menu with Empty Data Failed
    Verify Response Status Code and Message    400 Bad Request    Empty Data

Verify Create Mega Menu Not Success Because Duplicate Mega Menu Id
    [Arguments]    ${expected_menu_id}
    Verify Response Status Code and Message    200 OK    Mega Menu '${expected_menu_id}' has already exist.

Verify Delete Mega Menu Not Success Because Menu Id Version Not Exist
    [Arguments]    ${expected_menu_id}    ${expected_version}
    Verify Response Status Code and Message    200 OK    Mega Menu '${expected_menu_id} version ${expected_version}' didn't exist.

Verify Create Mega Menu with No Node Data
    Verify Response Status Code and Message    400 Bad Request    Required field: data

Verify Update Mega Menu Child with Empty Data Failed
    Verify Create Mega Menu with Empty Data Failed

Verify Update Mega Menu Child with No Node Data
    Verify Create Mega Menu with No Node Data

Verify Update Mega Menu Child with No Node Version
    Verify Response Status Code and Message    400 Bad Request    Required field: version

Verify Update Mega Menu Child Data Success
    Response Status Code Should Equal    200 OK

Verify Delete Draft Mega Menu Success
    [Arguments]    ${expected_menu_id}
    Verify Response Status Code and Message    200 OK    Mega Menu '${expected_menu_id} version published' didn't exist.

Verify Delete Draft and Published Mega Menu Success
    Response Status Code Should Equal    200 OK
    Verify Response Success but Data Empty    null

Verify Update Mega Menu Child Data with Empty Data Failed
    Verify Response Status Code and Message    400 Bad Request    Empty Data

Verify Reponse Failed Because Not Define Handle
    Verify Response Status Code and Message    500 Internal Server Error    Not-Found handler is not callable or is not defined

Create json Body Version
    ${json}=    Create Dictionary    version=draft
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Create json Body Version Published
    ${json}=    Create Dictionary    version=published
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Create json Body Data
    ${json}=    Create Dictionary    data=data
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Add Version to Json Body
    [Arguments]    ${json_body}    ${version}
    ${dict}=    Convert json to Dict    ${json_body}
    Set To Dictionary    ${dict}    version    ${version}
    ${return_json}=     Convert Dict to json    ${dict}
    [Return]    ${return_json}