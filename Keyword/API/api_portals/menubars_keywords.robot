*** Settings ***
Resource            ${CURDIR}/../common/api_keywords.robot
Library             HttpLibrary.HTTP
Library             OperatingSystem

*** Variables ***
${web}              web
${mobile}           mobile
${draft}            draft
${published}        published

*** Keywords ***
############# Prepare Data #############
Prepare Menu Bars Data For Suite Get
    [Arguments]    ${module_key}    ${json_data_file}
    Create Menu Bars Success    ${module_key}    ${web}    ${json_data_file}
    Publish Menu Bars Success    ${module_key}    ${web}
    Create Menu Bars Success    ${module_key}    ${mobile}    ${json_data_file}
    Publish Menu Bars Success    ${module_key}    ${mobile}

Clear Menu Bars Data For Suite Get
    [Arguments]    ${module_key}
    Delete Menu Bars Success    ${module_key}    ${web}
    Delete Menu Bars Success    ${module_key}    ${mobile}

############# Get #############
Get Menu Bars
    [Arguments]    ${module_key}    ${site}
    HTTP Get Request    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}

Get Menu Bars Failed
    [Arguments]    ${module_key}    ${site}
    HTTP Get Request Failed    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}

Get Menu Bars with Specific Version
    [Arguments]    ${module_key}    ${site}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}?version=${version}

Get Menu Bars Failed with Specific Version
    [Arguments]    ${module_key}    ${site}    ${version}
    HTTP Get Request Failed    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}?version=${version}

############# Put #############
Put Menu Bars
    [Arguments]    ${module_key}    ${site}    ${version}    ${json_data_file}
    ${json_data}=    Get File    ${json_data_file}
    ${request_body}=    Add Version to Json Body    ${json_data}    ${version}
    HTTP Put Request    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}    ${request_body}

Put Menu Bars Failed
    [Arguments]    ${module_key}    ${site}    ${version}    ${json_data_file}
    ${json_data}=    Get File    ${json_data_file}
    ${request_body}=    Add Version to Json Body    ${json_data}    ${version}
    HTTP Put Request Failed   ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}    ${request_body}

Create Menu Bars Success
    [Arguments]    ${module_key}    ${site}    ${json_data_file}
    Put Menu Bars    ${module_key}    ${site}    ${draft}    ${json_data_file}
    Verify Put Success and Response Data Correct

Published Menu Bars
    [Arguments]    ${module_key}    ${site}
    ${request_body}=    Generate JSON Version    ${published}
    HTTP Put Request    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}    ${request_body}

Publish Menu Bars Success
    [Arguments]    ${module_key}    ${site}
    Published Menu Bars    ${module_key}    ${site}
    Verify Put Success and Response Data Correct

Put Menu Bars with Empty Data
    [Arguments]    ${module_key}    ${site}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}    ${EMPTY}

Put Menu Bars Failed Because No Version Node
    [Arguments]    ${module_key}    ${site}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    HTTP Put Request Failed   ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}    ${request_body}

############# Delete #############
Delete Menu Bars
    [Arguments]    ${module_key}    ${site}    ${version}
    HTTP Delete Request    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}?version=${version}

Delete Menu Bars Failed
    [Arguments]    ${module_key}    ${site}    ${version}
    HTTP Delete Request Failed    ${PORTAL_API}    http    ${MENUBARS}${module_key}/${site}?version=${version}

Delete Menu Bars Success
    [Arguments]    ${module_key}    ${site}
    Delete Menu Bars    ${module_key}    ${site}    ${draft}
    Verify Delete Success and Response Data Correct
    Delete Menu Bars    ${module_key}    ${site}    ${published}
    Verify Delete Success and Response Data Correct

############# Verify #############
Verify Get Menu Bars Success and Data is Not Null
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Verify Data is Not Empty    ${response_body}
    Verify Node Data is Not Empty    ${response_body}    /data/en_US
    Verify Node Data is Not Empty    ${response_body}    /data/th_TH

Verify Get Menu Bars Success But Data is Null
    Verify Response Success but Data Empty    null

Verify Get Menu Bars Failed and Message and Code Match
    [Arguments]    ${status_code}    ${code}    ${message}
    Verify Error Code and Message    ${status_code}    ${code}    ${message}

Verify Put Menu Bars Failed and Message and Code Match
    [Arguments]    ${status_code}    ${code}    ${message}
    Verify Error Code and Message    ${status_code}    ${code}    ${message}

Verify Delete Menu Bars Failed and Message and Code Match
    [Arguments]    ${status_code}    ${code}    ${message}
    Verify Error Code and Message    ${status_code}    ${code}    ${message}

Verify Put Success and Response Data Correct
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${actual_data}=    Get Json Value    ${response_body}    /data
    Should Be Equal    true    ${actual_data}    Response data isn't true

Verify Delete Success and Response Data Correct
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${actual_data}=    Get Json Value    ${response_body}    /data
    Should Be Equal    true    ${actual_data}    Response data isn't true

############# Utility #############
Add Version to Json Body
    [Arguments]    ${json_body}    ${version}
    ${json_body}=    Add Node to Json Body    ${json_body}    version    ${version}
    [Return]    ${json_body}

Generate JSON Version
    [Arguments]    ${version}
    ${json}=    Create Dictionary    version=${version}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

