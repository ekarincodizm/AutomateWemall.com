*** Settings ***
Library         ${CURDIR}/../../../Python_Library/jsonLibrary.py
Library         templatesLibrary.py
# Library         HttpLibrary.HTTP
Library         OperatingSystem
Library         String
Library         Collections
Resource        ${CURDIR}/../common/api_keywords.robot

*** Variables ***
${prepare_json_data}        ${CURDIR}/../../../Resource/TestData/portals/templates/put_templates_01.json
${mega_menu}                mega-menu_template
${showroom}                 showroom_template


*** Keywords ***
############# Prepare #############
Prepare Template Data For Suite Get
    Create Template Data    ${mega_menu}    template_001    ${prepare_json_data}
    Verify Create Success and Response Data Correct    ${mega_menu}    template_001
    Create Template Data    ${mega_menu}    template_002    ${prepare_json_data}
    Verify Create Success and Response Data Correct    ${mega_menu}    template_002
    Create Template Data    ${mega_menu}    template_003    ${prepare_json_data}
    Verify Create Success and Response Data Correct    ${mega_menu}    template_003
    Create Template Data    ${mega_menu}    template_004    ${prepare_json_data}
    Verify Create Success and Response Data Correct    ${mega_menu}    template_004
    Create Template Data    ${showroom}    template_001    ${prepare_json_data}
    Verify Create Success and Response Data Correct    ${showroom}    template_001

Clear Template Data For Suite Get
    Delete Template Success    ${mega_menu}    template_001
    Delete Template Success    ${mega_menu}    template_002
    Delete Template Success    ${mega_menu}    template_003
    Delete Template Success    ${mega_menu}    template_004
    Delete Template Success    ${showroom}    template_001

############# Get #############
Get All Templates
    [Arguments]    ${template_type}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    HTTP Get Request    ${PORTAL_API}    http    ${TEMPLATES}${template_type}    ${Anonymousid}    ${AccessTokens}

Get All Templates Failed
    [Arguments]    ${template_type}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    HTTP Get Request Failed    ${PORTAL_API}    http    ${TEMPLATES}${template_type}    ${Anonymousid}    ${AccessTokens}

Get Specific Template
    [Arguments]    ${template_type}    ${template_id}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    HTTP Get Request    ${PORTAL_API}    http    ${TEMPLATES}${template_type}/${template_id}    ${Anonymousid}    ${AccessTokens}

Get Specific Template Failed
    [Arguments]    ${template_type}    ${template_id}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    HTTP Get Request Failed    ${PORTAL_API}    http    ${TEMPLATES}${template_type}/${template_id}    ${Anonymousid}    ${AccessTokens}

############# Put #############
Put Template Should Success
    [Arguments]    ${template_type}    ${template_id}    ${json_data_file}
    ${json_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Temlpate Type and Template Id to Json Body    ${json_body}    ${template_type}    ${template_id}
    HTTP Put Request    ${PORTAL_API}    http    ${TEMPLATES}    ${request_body}

Put Template with Empty Data
    HTTP Put Request Failed    ${PORTAL_API}    http    ${TEMPLATES}    ${EMPTY}

Put Data with out Template Type in Body
    [Arguments]    ${template_id}    ${json_data_file}
    ${json_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Template Id to Json Body    ${json_body}    ${template_id}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${TEMPLATES}    ${request_body}

Put Data with out Template Id in Body
    [Arguments]    ${template_type}    ${json_data_file}
    ${json_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Temlpate Type to Json Body    ${json_body}    ${template_type}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${TEMPLATES}    ${request_body}

Create Template Data
    [Arguments]    ${template_type}    ${template_id}    ${json_data_file}
    Put Template Should Success    ${template_type}    ${template_id}    ${json_data_file}

Create Template with Empty Data
    Put Template with Empty Data

Update Template Data
    [Arguments]    ${template_type}    ${template_id}    ${json_data_file}
    Put Template Should Success    ${template_type}    ${template_id}    ${json_data_file}

Update Template with Empty Data
    Put Template with Empty Data

############# Delete #############
Delete Template Data
    [Arguments]    ${template_type}    ${template_id}
    HTTP Delete Request    ${PORTAL_API}    http    ${TEMPLATES}${template_type}/${template_id}

Delete Template Success
    [Arguments]    ${template_type}    ${template_id}
    Delete Template Data    ${template_type}    ${template_id}
    Response Status Code Should Equal    200 OK

Delete All Templates Failed
    [Arguments]    ${template_type}
    HTTP Delete Request Failed    ${PORTAL_API}    http    ${TEMPLATES}${template_type}

############# Verify #############
Assert Tamplate Type From Get All Templates with Expected
    [Arguments]    ${expected_template_type}
    ${response_body}=     Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    ${template_type_list}=    Get List Data From json    ${data}    template_type
    ${result}=    Should List Contain Only One Value    ${template_type_list}    ${expected_template_type}
    Should Be True    ${result}    Template Type didn't match

Assert Tamplate Type From Get Specific Template Match with Expected
    [Arguments]    ${expected_template_type}
    ${response_body}=     Get Response Body
    ${template_type}=    Get Json Value    ${response_body}    /data/template_type
    Should Be Equal    "${expected_template_type}"    ${template_type}    Template Type didn't match

Assert Tamplate Id From Get Specific Template Match with Expected
    [Arguments]    ${expected_template_id}
    ${response_body}=     Get Response Body
    ${template_id}=    Get Json Value    ${response_body}    /data/template_id
    Should Be Equal    "${expected_template_id}"    ${template_id}    Template Id didn't match

Assert Tamplate Name From Get Specific Template Match with Expected
    [Arguments]    ${expected_template_name}
    ${response_body}=     Get Response Body
    ${template_name}=    Get Json Value    ${response_body}    /data/name
    Should Be Equal    "${expected_template_name}"    ${template_name}    Template Name didn't match

Verify Get All Templates Success and Data Correct
    [Arguments]    ${expected_template_type}    ${expected_template_id_count}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    ${template_type_list}=    Get List Data From json    ${data}    template_type
    Assert Tamplate Type From Get All Templates with Expected    ${expected_template_type}
    ${expected_template_id_list}=    Get Expected Mega Menu Template List    ${expected_template_id_count}
    ${template_id_list}=    Get List Data From json    ${data}    template_id
    Check List Should Be Equal    ${expected_template_id_list}    ${template_id_list}    List of template id didn't match

Verify Get Specific Template Success and Data Correct
    [Arguments]    ${expected_template_type}    ${expected_template_id}    ${expected_template_name}
    Response Status Code Should Equal    200 OK
    Assert Tamplate Type From Get Specific Template Match with Expected    ${expected_template_type}
    Assert Tamplate Id From Get Specific Template Match with Expected    ${expected_template_id}
    Assert Tamplate Name From Get Specific Template Match with Expected    ${expected_template_name}

Verify Get All Templates Success but Data Empty
    Verify Response Success but Data Empty    []

Verify Get Specific Template Success but Data Empty
    Verify Response Success but Data Empty    null

Verify Delete Response Success
    Verify Response Success but Data Empty    {"scalar": true}

Verify Reponse Failed Because Not Define Handle
    Verify Response Status Code and Message    500 Internal Server Error    Not-Found handler is not callable or is not defined

Verify Put Response Success and Data Correct
    [Arguments]    ${expected_template_type}    ${expected_template_id}
    Verify Response Status Code and Message    200 OK    OK
    Assert Tamplate Type From Get Specific Template Match with Expected    ${expected_template_type}
    Assert Tamplate Id From Get Specific Template Match with Expected    ${expected_template_id}

Verify Create Success and Response Data Correct
    [Arguments]    ${expected_template_type}    ${expected_template_id}
    Verify Put Response Success and Data Correct    ${expected_template_type}    ${expected_template_id}

Verify Put Template Failed Because No Template Type in json Body
    Verify Error Code Message    400 Bad Request    CPS4001    Missing Required Field    Template Type is missing

Verify Put Template Failed Because No Template Id in json Body
    Verify Error Code Message    400 Bad Request    CPS4001    Missing Required Field    Template Id is missing

Verify Update Success and Response Data Correct
    [Arguments]    ${expected_template_type}    ${expected_template_id}
    Verify Put Response Success and Data Correct    ${expected_template_type}    ${expected_template_id}

Verify Update Failed and Response Data Correct
    [Arguments]    ${expected_template_type}    ${expected_template_id}
    ${expected_message}=    Set Variable    Error Message
    Verify Response Status Code and Message    400 Bad Request    ${expected_message}

############# Utility #############
Add Temlpate Type and Template Id to Json Body
    [Arguments]    ${json_00}    ${template_type}    ${template_id}
    ${json_01}=    Add Temlpate Type to Json Body    ${json_00}    ${template_type}
    ${return_json}=    Add Template Id to Json Body    ${json_01}    ${template_id}
    [Return]    ${return_json}

Add Temlpate Type to Json Body
    [Arguments]    ${json_body}    ${template_type}
    ${dict}=    Convert json to Dict    ${json_body}
    Set To Dictionary    ${dict}    template_type    ${template_type}
    ${return_json}=     Convert Dict to json    ${dict}
    [Return]    ${return_json}

Add Template Id to Json Body
    [Arguments]    ${json_body}    ${template_id}
    ${dict}=    Convert json to Dict    ${json_body}
    Set To Dictionary    ${dict}    template_id    ${template_id}
    ${return_json}=     Convert Dict to json    ${dict}
    [Return]    ${return_json}



