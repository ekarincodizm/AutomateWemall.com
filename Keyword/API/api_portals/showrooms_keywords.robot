*** Settings ***
Library         ${CURDIR}/../../../Python_Library/jsonLibrary.py
Library         ${CURDIR}/showrooms.py
# Library         HttpLibrary.HTTP
Library         String
Library         OperatingSystem
Resource        ${CURDIR}/../common/api_keywords.robot

*** Variables ***
${DRAFT}                draft
${PUBLISHED}            published
${showroom_json_data}    ${CURDIR}/../../../Resource/TestData/portals/showrooms/prepare_showroom.json
${text_link}            text-link
${brand}                brand

*** Keywords ***
############ Prepare Data ############
Prepare Showroom Data For Suite Get
    [Arguments]    ${module_key}    ${showroom_id}
    PUT Data Create New Showroom    ${module_key}    ${showroom_id}    ${DRAFT}    ${showroom_json_data}
    Response Status Code Should Equal    200 OK
    Published Showroom Data    ${module_key}    ${showroom_id}
    Response Status Code Should Equal    200 OK

Clear Showroom Data For Suite Get
    [Arguments]    ${showroomId}
    Delete Showroom Data    ${showroomId}    ${DRAFT}
    Response Status Code Should Equal    200 OK
    Delete Showroom Data    ${showroomId}    ${PUBLISHED}
    Response Status Code Should Equal    200 OK

Prepare Showroom Draft All Data
    [Arguments]    ${module_key}    ${showroom_id}    ${showroom_data}    ${textlink_data}    ${brand_data}
    PUT Data Create New Showroom    ${module_key}    ${showroom_id}    ${DRAFT}    ${showroom_data}
    Response Status Code Should Equal    200 OK
    PUT Showroom Textlink    ${showroom_id}    ${textlink_data}
    Response Status Code Should Equal    200 OK
    PUT Showroom Brand    ${showroom_id}    ${brand_data}
    Response Status Code Should Equal    200 OK

Prepare Showroom Publish All Data
    [Arguments]    ${module_key}    ${showroom_id}    ${showroom_data}    ${textlink_data}    ${brand_data}
    Prepare Showroom Draft All Data    ${module_key}    ${showroom_id}    ${showroom_data}    ${textlink_data}    ${brand_data}
    Published Showroom Data    ${module_key}    ${showroom_id}
    Response Status Code Should Equal    200 OK

############ Get ############
GET Showroom Data
    [Arguments]    ${module_key}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${version}

GET Showroom Textlink Data
    [Arguments]    ${showroom_id}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroom_id}/${text_link}/${version}

GET Showroom Brand Data
    [Arguments]    ${showroom_id}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroom_id}/${brand}/${version}

############ Put ############
PUT Data Create New Showroom
    [Arguments]    ${module_key}    ${showroom_id}    ${version}    ${json_data_file}
    ${json_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Showroom Id to Json Body    ${json_body}    ${showroom_id}
    HTTP Put Request    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${version}    ${request_body}

PUT Data Create New Showroom without Showroom Id
    [Arguments]    ${module_key}    ${version}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    HTTP Put Request    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${version}    ${request_body}

PUT Update Empty Data
    [Arguments]    ${module_key}    ${version}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${version}    ${EMPTY}

PUT Update with No Sort Index
    [Arguments]    ${module_key}    ${version}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${version}    {"data": "data"}

PUT Update with No Status
    [Arguments]    ${module_key}    ${version}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${version}    {"sort_index": 99}

Published Showroom Data
    [Arguments]    ${module_key}    ${showroom_id}
    ${request_body}=    Add Showroom Id to Json Body    {}    ${showroom_id}
    HTTP Put Request    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${PUBLISHED}    ${request_body}

Published Showroom Data with Empty Data
    [Arguments]    ${module_key}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${PUBLISHED}    ${EMPTY}

Published Showroom Data without Showroom Id
    [Arguments]    ${module_key}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${PUBLISHED}    {"data": "data"}

Published Showroom Data with Showroom Id That Not Exist
    [Arguments]    ${module_key}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${module_key}/${PUBLISHED}    {"showroom_id": "not_exist"}

############ Put ############
PUT Showroom Textlink
    [Arguments]    ${showroom_id}    ${json_data_file}
    ${json_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Showroom Id to Json Body    ${json_body}    ${showroom_id}
    HTTP Put Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroom_id}/${text_link}/${DRAFT}    ${request_body}

PUT Showroom Brand
    [Arguments]    ${showroom_id}    ${json_data_file}
    ${json_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Showroom Id to Json Body    ${json_body}    ${showroom_id}
    HTTP Put Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroom_id}/${brand}/${DRAFT}    ${request_body}

############ Delete ############
Delete Showroom Data
    [Arguments]    ${showroom_id}    ${version}
    HTTP Delete Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroom_id}/${version}

Delete All Version of Showroom Data
    [Arguments]    ${showroomId}
    Delete Showroom Data    ${showroomId}    ${DRAFT}
    Response Status Code Should Equal    200 OK
    Delete Showroom Data    ${showroomId}    ${PUBLISHED}
    Response Status Code Should Equal    200 OK

############ Verify ############
Check Response Success and Data not Empty
    [Arguments]    ${showroom_id}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Data is Not Empty    ${response_body}
    Verify Node Data is Not Empty    ${response_body}    /data/en_US
    Verify Node Data is Not Empty    ${response_body}    /data/th_TH
    Check Required Node of Showroom Exist    ${response_body}    ${showroom_id}

Check Required Node of Showroom Exist
    [Arguments]    ${response_body}    ${showroom_id}
    ${node_TH}=    Get Json Value    ${response_body}    /data/th_TH/${showroom_id}
    ${node_EN}=    Get Json Value    ${response_body}    /data/en_US/${showroom_id}
    Assert Data Have Required Showroom Node    ${node_TH}
    Assert Data Have Required Showroom Node    ${node_EN}

Assert Data Have Required Showroom Node
    [Arguments]    ${json_data}
    ${data_dict}=    Convert json to Dict    ${json_data}
    ${list_dict_keys}=    Get Dictionary Keys    ${data_dict}
    ${expected_node}=    Create List    title    color_rgb    awesome_font    status
    Append To List    ${expected_node}    optionalBanners    link_url    banners    id
    Append To List    ${expected_node}    sort_index    template    text_links    brands
    Check List Should Be Equal    ${expected_node}    ${list_dict_keys}   Node in each showroom not matched with expected

Check Response Success But Data Empty
    Verify Response Success but Data Empty    []

Assert Showroom Id From PUT Showrooms with Expected
    [Arguments]    ${expected_showroom_id}
    ${response_body}=     Get Response Body
    ${showroom_id}=    Get Json Value    ${response_body}    /data/showroom_id
    Should Be Equal    "${expected_showroom_id}"    ${showroom_id}    Showroom Id didn't match

Assert Data From Response Expected Node Not Null or Empty
    [Arguments]    ${expected_node_data}
    ${response_body}=     Get Response Body
    ${showroom_id}=    Get Json Value    ${response_body}    ${expected_node_data}
    Should Not Be Equal    null    ${showroom_id}    Showroom Id are null
    Should Not Be Equal    []    ${showroom_id}    Showroom Id are empty
    ${return_showroom_id}=    Replace String    ${showroom_id}    "    ${EMPTY}
    [Return]    ${return_showroom_id}

Verify Create New Showroom Success
    [Arguments]    ${expected_showroom_id}
    Response Status Code Should Equal    200 OK
    Assert Showroom Id From PUT Showrooms with Expected    ${expected_showroom_id}

Verify PUT Update with Empty Data Failed
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=    Get Response Body
    Verify Message in Response    ${response_body}    require json-input

Verify PUT Update with No Sort Index Data Failed
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=    Get Response Body
    Verify Message in Response    ${response_body}    require sort_index

Verify PUT Update with No Status Data Failed
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=    Get Response Body
    Verify Message in Response    ${response_body}    require status

Verify Create New Showroom without Showroom Id Success
    Response Status Code Should Equal    200 OK
    ${showroom_id}=    Assert Data From Response Expected Node Not Null or Empty    /data/showroom_id
    [Return]    ${showroom_id}

Verify Published Showroom Data Success
    [Arguments]    ${expected_showroom_id}
    Response Status Code Should Equal    200 OK
    Assert Showroom Id From PUT Showrooms with Expected    ${expected_showroom_id}

Verify PUT Update without Showroom Id Failed
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=    Get Response Body
    Verify Message in Response    ${response_body}    require showroom_id

Verify PUT Update with Showroom Id That Not Exist Failed
    Response Status Code Should Equal    500 Internal Server Error
    ${response_body}=    Get Response Body
    Verify Message in Response    ${response_body}    Cannot Published

Verify Delete Showroom Data Success
    [Arguments]    ${expected_showroom_id}
    ${response_body}=    Get Response Body
    Response Status Code Should Equal    200 OK
    ${showroom}=    Get Json Value    ${response_body}    /data/showroom
    ${textlink}=    Get Json Value    ${response_body}    /data/textlink
    ${brand}=    Get Json Value    ${response_body}    /data/brand
    Should Be Equal As Strings    "${expected_showroom_id}"    ${showroom}    Showroom not match
    Should Be Equal As Strings    "${expected_showroom_id}"    ${textlink}    Text link not match
    Should Be Equal As Strings    "${expected_showroom_id}"    ${brand}    Brand not match

############ Utility ############
Add Showroom Id to Json Body
    [Arguments]    ${json_body}    ${showroom_id}
    ${return_json}=     Add Node to Json Body    ${json_body}    showroom_id    ${showroom_id}
    [Return]    ${return_json}

Add Sort Index to Json Body
    [Arguments]    ${json_body}    ${sort_index}
    ${return_json}=     Add Node to Json Body    ${json_body}    sort_index    ${sort_index}
    [Return]    ${return_json}

