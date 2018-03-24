*** Settings ***
Library             ${CURDIR}/../../../Python_Library/jsonLibrary.py
# Library             HttpLibrary.HTTP
Library             OperatingSystem
Library             String
Library             Collections
Resource            ${CURDIR}/../common/api_keywords.robot

*** Variables ***
${update_department_json}   ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/put_department_01.json
${update_group_json}        ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/put_group_01.json
${template_group_json}      ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/post_merchant_groups_01.json

*** Keywords ***
#################### Prepare Data ####################
Prepare Department Merchant Zones Data
    [Arguments]    ${module_type}
    Create Module Type in Merchant Zone    ${module_type}    ${update_department_json}
    Response Status Code Should Equal    200 OK
    Update Merchant Zone Group    ${module_type}    1234567890001    ${update_group_json}
    Response Status Code Should Equal    200 OK
    Update Merchant Zone Group    ${module_type}    1234567890002    ${update_group_json}
    Response Status Code Should Equal    200 OK
    Update Merchant Zone Group    ${module_type}    1234567890003    ${update_group_json}
    Response Status Code Should Equal    200 OK
    Published Merchant Zones Data    ${module_type}
    Verify Publish Merchant Zones Success

Prepare Merchant Zone Data for Groups
    [Arguments]    ${module_type}
    Create Module Type in Merchant Zone    ${module_type}    ${update_department_json}
    Response Status Code Should Equal    200 OK

Prepare Published Merchant Zone Data
    [Arguments]    ${module_type}
    Create Module Type in Merchant Zone    ${module_type}    ${update_department_json}
    Response Status Code Should Equal    200 OK
    Update Merchant Zone Group    ${module_type}    1234567890001    ${update_group_json}
    Response Status Code Should Equal    200 OK
    Update Merchant Zone Group    ${module_type}    1234567890002    ${update_group_json}
    Response Status Code Should Equal    200 OK
    Update Merchant Zone Group    ${module_type}    1234567890003    ${update_group_json}
    Response Status Code Should Equal    200 OK
    Published Merchant Zones Data    ${module_type}
    Verify Publish Merchant Zones Success

#################### GET ####################
Get Merchant Zones By Module Type
    [Arguments]    ${module_type}
    HTTP Get Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}

Get Published Merchant Zones By Module Type
    [Arguments]    ${module_type}
    HTTP Get Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/published

Get Merchant Zone Id
    [Arguments]    ${module_type}
    Get Merchant Zones By Module Type    ${module_type}
    ${response_body}=     Get Response Body
    ${str_merchant_zone_id}=    Get Json Value    ${response_body}    /data/th_TH/merchant_zone_id
    ${merchant_zone_id}=    Replace String    ${str_merchant_zone_id}    "    ${EMPTY}
    [Return]    ${merchant_zone_id}

Get Merchant Zone Group List from Publish
    [Arguments]    ${module_type}
    Get Published Merchant Zones By Module Type    ${module_type}
    ${response_body}=     Get Response Body
    ${data1}=    Get Json Value    ${response_body}    /data/en_US/groups
    ${group_list}=    Get List Data From json    ${data1}    merchant_zone_group_id
    [Return]    ${group_list}

Get Merchant Zone Group List from Draft
    [Arguments]    ${module_type}
    Get Merchant Zones By Module Type    ${module_type}
    ${response_body}=     Get Response Body
    ${data1}=    Get Json Value    ${response_body}    /data/en_US/groups
    ${group_list}=    Get List Data From json    ${data1}    merchant_zone_group_id
    [Return]    ${group_list}

#################### POST ####################
Create Module Type in Merchant Zone
    [Arguments]    ${module_type}    ${json_data_file}
    ${request_body}=        Get File    ${json_data_file}
    HTTP Post Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}    ${request_body}

Create Module Type in Merchant Zone Failed
    [Arguments]    ${module_type}    ${json_data_file}
    ${request_body}=        Get File    ${json_data_file}
    HTTP Post Request Failed    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}    ${request_body}

Create Empty Module Type in Merchant Zone
    [Arguments]    ${module_type}
    HTTP Post Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}    ${EMPTY}

Create Merchant Zone Groups
    [Arguments]    ${module_type}    ${json_data_file}
    ${request_body}=        Get File    ${json_data_file}
    HTTP Post Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups    ${request_body}

Create Merchant Zone Groups with Empty Data
    [Arguments]    ${module_type}
    HTTP Post Request Failed    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups    ${EMPTY}

Create Merchant Zone Groups with Invalid Module Type
    [Arguments]    ${module_type}    ${json_data_file}
    ${request_body}=        Get File    ${json_data_file}
    HTTP Post Request Failed    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups    ${request_body}

Create Merchant Zone Group and Get Group ID
    [Arguments]    ${module_type}    ${json_data_file}
    Create Merchant Zone Groups    ${module_type}    ${json_data_file}
    ${merchant_zone_id}=    Get Merchant Zone Group Id From Post Response
    [Return]    ${merchant_zone_id}

#################### PUT ####################
Update Module Type in Merchant Zone
    [Arguments]    ${module_type}    ${json_data_file}
    ${request_body}=        Get File    ${json_data_file}
    HTTP Put Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}    ${request_body}

Update Module Type in Merchant Zone With Empty Body Data
    [Arguments]    ${module_type}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}    ${EMPTY}

Update Merchant Zone Group
    [Arguments]    ${module_type}    ${group_id}    ${json_data_file}
    ${request_body}=        Get File    ${json_data_file}
    HTTP put Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups/${group_id}    ${request_body}

Update Merchant Zone Group with Empty Data
    [Arguments]    ${module_type}    ${group_id}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups/${group_id}    ${EMPTY}

Update Merchant Zone Group with Invalid Module Type
    [Arguments]    ${module_type}    ${group_id}    ${json_data_file}
    ${request_body}=        Get File    ${json_data_file}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups/${group_id}    ${request_body}

Update Merchant Zone Group with Invalid Merchant Zone Group Id
    [Arguments]    ${module_type}    ${group_id}    ${json_data_file}
    Update Merchant Zone Group with Invalid Module Type    ${module_type}    ${group_id}    ${json_data_file}

Published Merchant Zones Data
    [Arguments]    ${module_type}
    HTTP Put Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/published    ${EMPTY}

Published Merchant Zones Data with Invalid Module Type
    [Arguments]    ${module_type}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/published    ${EMPTY}

Update Data Before Publish Merchant Zone
    [Arguments]    ${module_type}    ${group_id_list}
    ${after_change_group_list}=    Set Variable    ${group_id_list}
    ${delete_group_id}=   Get From List    ${group_id_list}    1
    Delete Merchant Zone Group By Select Group ID Form List    ${module_type}    ${group_id_list}
    # ${update_group_id}=   Get From List    ${group_id_list}    2
    # Update Merchant Zone Group    ${module_type}    ${update_group_id}    ${template_group_json}
    ${new_group_id}=    Create Merchant Zone Group and Get Group ID    ${module_type}    ${update_group_json}
    Remove Values From List    ${after_change_group_list}    ${delete_group_id}
    Append To List    ${after_change_group_list}    ${new_group_id}
    [Return]    ${after_change_group_list}

#################### DELETE ####################
Delete Module Type in Merchant Zone
    [Arguments]    ${module_type}
    HTTP Delete Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}

Delete Merchant Zone with Invalid Module Type
    [Arguments]    ${module_type}
    HTTP Delete Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}

Delete Merchant Zone Group
    [Arguments]    ${module_type}    ${group_id}
    HTTP Delete Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups/${group_id}
    ${response}=    Get Response Body

Delete Merchant Zone Group By Select Group ID Form List
    [Arguments]    ${module_type}    ${group_id_list}
    ${group_id}=   Get From List    ${group_id_list}    1
    Delete Merchant Zone Group    ${module_type}    ${group_id}

Delete Merchant Zone Group with Invalid Module Type
    HTTP Delete Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}/invalid_module_type/groups/invalid_group_id

Delete Merchant Zone Group with Invalid Group Id
    [Arguments]    ${module_type}
    HTTP Delete Request    ${PORTAL_API}    http    ${MERCHANT_ZONES}${module_type}/groups/invalid_group_id

#################### Tear Down ####################
Delete Merchant Zone Group Data
    [Arguments]    ${module_type}    ${merchant_zone_id}    ${group_id}
    Delete Merchant Zone Group    ${module_type}    ${group_id}
    Verify Delete Merchant Zone Groups Success and Verify Merchant Zone ID    ${merchant_zone_id}    ${group_id}

Delete Merchant Zone Data
    [Arguments]    ${module_type}
    Delete Module Type in Merchant Zone    ${module_type}
    Verify Delete Merchant Zone Success

#################### Verify ####################
Verify Merchant Zone Id Node Not Empty From Response
    [Arguments]    ${response_body}
    ${merchant_zone_id}=    Get Json Value    ${response_body}    /data/merchant_zone_id
    Should Not Be Equal    null    ${merchant_zone_id}    Merchant Zone ID is empty

Is Module Type Match with Expected
    [Arguments]    ${response_body}    ${expected_module_type}
    ${module_type}=    Get Json Value    ${response_body}    /data/module_type
    Should Be Equal    "${expected_module_type}"    ${module_type}    Module Type in not matched

Verify Language Node Not Empty From Response
    [Arguments]    ${response_body}
    ${th_TH}=    Get Json Value    ${response_body}    /data/th_TH
    ${en_US}=    Get Json Value    ${response_body}    /data/en_US
    Should Not Be Equal    null    ${th_TH}    Language TH is null
    Should Not Be Equal    null    ${en_US}    Language EN is null

Verify Language Node Empty From Response
    [Arguments]    ${response_body}
    ${th_TH}=    Get Json Value    ${response_body}    /data/th_TH
    ${en_US}=    Get Json Value    ${response_body}    /data/en_US
    Should Be Equal    null    ${th_TH}    Language TH is not null
    Should Be Equal    null    ${en_US}    Language EN is not null

Verify Banners Node Not Empty From Response
    [Arguments]    ${response_body}
    ${banners_th}=    Get Json Value    ${response_body}    /data/th_TH/banners
    ${banners_en}=    Get Json Value    ${response_body}    /data/en_US/banners
    Should Not Be Equal    null    ${banners_th}    Banners TH is null
    Should Not Be Equal    null    ${banners_en}    Banners EN is null

Verify Banners Node Empty From Response
    [Arguments]    ${response_body}
    ${banners_th}=    Get Json Value    ${response_body}    /data/th_TH/banners
    ${banners_en}=    Get Json Value    ${response_body}    /data/en_US/banners
    Should Be Equal    null    ${banners_th}    Banners TH is not null
    Should Be Equal    null    ${banners_en}    Banners EN is not null

Verify Banner Left and Right Node Not Empty
    [Arguments]    ${response_body}
    ${banners_left_th}=    Get Json Value    ${response_body}    /data/th_TH/banners/banner-01
    ${banners_right_th}=    Get Json Value    ${response_body}    /data/th_TH/banners/banner-02
    ${banners_left_en}=    Get Json Value    ${response_body}    /data/en_US/banners/banner-01
    ${banners_right_en}=    Get Json Value    ${response_body}    /data/en_US/banners/banner-02
    Should Not Be Equal    null    ${banners_left_th}    Banners Left TH is null
    Should Not Be Equal    null    ${banners_right_th}    Banners Right TH is null
    Should Not Be Equal    null    ${banners_left_en}    Banners Left EN is null
    Should Not Be Equal    null    ${banners_right_en}    Banners Right EN is null

Verify Groups Node Not Empty From Response
    [Arguments]    ${response_body}
    ${groups_th}=    Get Json Value    ${response_body}    /data/th_TH/groups
    ${groups_en}=    Get Json Value    ${response_body}    /data/en_US/groups
    Should Not Be Equal    null    ${groups_th}    Groups TH is null
    Should Not Be Equal    null    ${groups_en}    Groups EN is null

Verify Groups Node Empty From Response
    [Arguments]    ${response_body}
    ${groups_th}=    Get Json Value    ${response_body}    /data/th_TH/groups
    ${groups_en}=    Get Json Value    ${response_body}    /data/en_US/groups
    Should Be Equal    null    ${groups_th}    Groups TH is not null
    Should Be Equal    null    ${groups_en}    Groups EN is not null

Verify Module Type Node From Response Matched with Expected
    [Arguments]    ${response_body}    ${expected_module_type}
    # for GET method
    ${module_type_th}=    Get Json Value    ${response_body}    /data/th_TH/module_type
    ${module_type_en}=    Get Json Value    ${response_body}    /data/en_US/module_type
    Should Be Equal    "${expected_module_type}"    ${module_type_th}    Module Type in th_TH not matched
    Should Be Equal    "${expected_module_type}"    ${module_type_en}    Module Type in en_US not matched

Verify Merchant Zone Id Node From Response Not Empty
    [Arguments]    ${response_body}
    # for GET method
    ${merchant_zone_id_th}=    Get Json Value    ${response_body}    /data/th_TH/merchant_zone_id
    ${merchant_zone_id_en}=    Get Json Value    ${response_body}    /data/en_US/merchant_zone_id
    Should Not Be Equal    null    ${merchant_zone_id_th}    Merchant Zone ID is empty
    Should Not Be Equal    null    ${merchant_zone_id_en}    Merchant Zone ID is empty

Verify Merchant Zone Id Match with Expected
    [Arguments]    ${response_body}    ${expected_merchant_zone_id}
    ${merchant_zone_id}=    Get Json Value    ${response_body}    /data/merchant_zone_id
    Should Be Equal    "${expected_merchant_zone_id}"    ${merchant_zone_id}    Merchant Zone Id is not matched

Verify Merchant Zone Group Id Match with Expected
    [Arguments]    ${response_body}    ${expected_group_id}
    ${group_id}=    Get Json Value    ${response_body}    /data/merchant_zone_group_id
    Should Be Equal    "${expected_group_id}"    ${group_id}    Merchant Zone Group Id is not matched

Verify GET Response and Response Get Module Type Correct
    [Arguments]    ${expected_module_type}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Verify Language Node Not Empty From Response    ${response_body}
    Verify Banners Node Not Empty From Response    ${response_body}
    Verify Groups Node Not Empty From Response    ${response_body}
    Verify Merchant Zone Id Node From Response Not Empty    ${response_body}
    Verify Module Type Node From Response Matched with Expected    ${response_body}    ${expected_module_type}

Verify GET Response Success but Data Is Empty
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    Should Be Equal    null    ${data}    data is not null

Verify Response Success and Have Only Module Type
    [Arguments]    ${expected_module_type}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Is Module Type Match with Expected    ${response_body}    ${expected_module_type}
    Verify Merchant Zone Id Node Not Empty From Response    ${response_body}

Should Merchant Zone Data Have Module Type and Banner
    [Arguments]    ${expected_module_type}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Verify Language Node Not Empty From Response    ${response_body}
    Verify Banners Node Not Empty From Response    ${response_body}
    Verify Banner Left and Right Node Not Empty    ${response_body}
    Verify Merchant Zone Id Node From Response Not Empty    ${response_body}
    Verify Module Type Node From Response Matched with Expected    ${response_body}    ${expected_module_type}

Should Merchant Zone Data Empty
    [Arguments]    ${expected_module_type}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Verify Language Node Not Empty From Response    ${response_body}
    Verify Banners Node Not Empty From Response    ${response_body}
    Verify Merchant Zone Id Node From Response Not Empty    ${response_body}
    Verify Module Type Node From Response Matched with Expected    ${response_body}    ${expected_module_type}

Should Merchant Zone Data Have Only Module Type
    [Arguments]    ${expected_module_type}
    Verify Response Success and Have Only Module Type    ${expected_module_type}

Verify Create Meechant Zone Success
    [Arguments]    ${expected_module_type}
    Verify Response Success and Have Only Module Type    ${expected_module_type}

Verify Create Merchant Zone Groups Success
    [Arguments]    ${expected_merchant_zone_id}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Verify Merchant Zone Id Match with Expected    ${response_body}    ${expected_merchant_zone_id}

Verify Create Merchant Zone Groups with Empty Fialed
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal    "Missing data"    ${message}    Error message not match

Verify Create Merchant Zone Groups with Invalid Module Type Fialed
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal    "Invalid module type"    ${message}    Error message not match

Verify Post Response Failed Duplicate Module Type
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal    "Duplicate module type"    ${message}    Error message not match

Verify Update Merchant Zone Data Success
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Verify Merchant Zone Id Node Not Empty From Response    ${response_body}

Verify Publish Merchant Zones Success
    Verify Update Merchant Zone Data Success

Verify PUT Response Failed Because Empty Body Data
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal    "require data"    ${message}    Error message not match

Verify Update Merchant Zone Group Success
    [Arguments]    ${expected_merchant_zone_id}    ${expected_group_id}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Verify Merchant Zone Id Match with Expected    ${response_body}    ${expected_merchant_zone_id}
    Verify Merchant Zone Group Id Match with Expected    ${response_body}    ${expected_group_id}

Verify Update Merchant Zone Group Failed Because Invalid Module Type
    Verify Create Merchant Zone Groups with Invalid Module Type Fialed

Verify Published Merchant Zone Group Failed Because Invalid Module Type
    Verify Create Merchant Zone Groups with Invalid Module Type Fialed

Verify Delete Merchant Zone Success
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${merchant_zone_id}=    Get Json Value    ${response_body}    /data/draft/0/merchant_zone_id
    Should Not Be Equal    null    ${merchant_zone_id}    Merchant Zone ID is empty

Verify Delete Merchant Zone Failed Because Invalid Module Type
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body

Get Merchant Zone Group Id From Post Response
    ${response_body}=     Get Response Body
    ${str_group_id}=    Get Json Value    ${response_body}    /data/merchant_zone_group_id
    ${merchant_zone_group_id}=    Replace String    ${str_group_id}    "    ${EMPTY}
    [Return]    ${merchant_zone_group_id}

Verify Delete Merchant Zone Groups Success and Verify Merchant Zone ID
    [Arguments]    ${expected_merchant_zone_id}    ${expected_group_id}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${merchant_zone_id}=    Get Json Value    ${response_body}    /data/0/merchant_zone_id
    ${group_id}=    Get Json Value    ${response_body}    /data/0/merchant_zone_group_id
    Should Be Equal    "${expected_group_id}"    ${group_id}    Merchant Zone Group ID is empty
    Should Be Equal    "${expected_merchant_zone_id}"    ${merchant_zone_id}    Merchant Zone ID in not matched

Verify Delete Merchant Zone Groups Success
    [Arguments]    ${expected_group_id}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${group_id}=    Get Json Value    ${response_body}    /data/0/merchant_zone_group_id
    Should Be Equal    "${expected_group_id}"    ${group_id}    Merchant Zone Group ID is empty

Verify Delete Groups Draft Version Success and Publish Group Not Change
    [Arguments]    ${before_delete_publish_groups_list}    ${module_type}
    ${group_first_index}=   Get From List    ${before_delete_publish_groups_list}    1
    Verify Delete Merchant Zone Groups Success    ${group_first_index}
    # Draft merchant should be delete
    ${draft_group}=    Get Merchant Zone Group List from Draft    ${module_type}
    List Should Not Contain Value    ${draft_group}    ${group_first_index}    Deleted Group ID Exist
    # Publish merchant group must not be deleted
    ${publish_groups_list}=    Get Merchant Zone Group List from Publish    ${module_type}
    Check List Should Be Equal    ${publish_groups_list}    ${before_delete_publish_groups_list}    Publish merchant group not be the same

Verify Delete Merchant Zone Group Failed Because Invalid Module Type
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=     Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal    "require merchant zone id"    ${message}    Error message not match

Verify Delete Merchant Zone Group Failed Because Invalid Merchant Zone Group Id
    # Response Status Code Should Equal    400 Bad Request
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    # ${message}=    Get Json Value    ${response_body}    /data/1
    # Should Be Equal    "Do not have merchant_zone_id on version published"    ${message}    Error message not match

Verify Merchant Zone Group Id Exist in Module Type
    [Arguments]    ${expected_module_type}    ${expected_merchant_zone_id}    ${expected_group_id}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${module_type}=    Get Json Value    ${response_body}    /data/th_TH/module_type
    ${merchant_zone_id}=    Get Json Value    ${response_body}    /data/th_TH/merchant_zone_id
    ${groups}=    Get Json Value    ${response_body}    /data/th_TH/groups
    Response Body Should Contain    ${expected_group_id}
    Should Be Equal    "${expected_module_type}"    ${module_type}    Module type not match
    Should Be Equal    "${expected_merchant_zone_id}"    ${merchant_zone_id}    Merchant zone id not match

Verify Merchant Zone Group Id and Brands Exist in Module Type
    [Arguments]    ${expected_module_type}    ${expected_merchant_zone_id}    ${expected_group_id}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    ${module_type}=    Get Json Value    ${response_body}    /data/th_TH/module_type
    ${merchant_zone_id}=    Get Json Value    ${response_body}    /data/th_TH/merchant_zone_id
    Should Be Equal    "${expected_module_type}"    ${module_type}    Module type not match
    Should Be Equal    "${expected_merchant_zone_id}"    ${merchant_zone_id}    Merchant zone id not match
    Response Body Should Contain    ${expected_group_id}

Verify Published Data Success and Data Updated Correct
    [Arguments]    ${after_change_group_list}    ${module_type}
    Verify Publish Merchant Zones Success
    # Draft merchant should be delete
    ${draft_group}=    Get Merchant Zone Group List from Draft    ${module_type}
    Check List Should Be Equal    ${draft_group}    ${after_change_group_list}    Draft merchant group not be the same
    # Publish merchant group must not be deleted
    ${publish_groups_list}=    Get Merchant Zone Group List from Publish    ${module_type}
    Check List Should Be Equal    ${publish_groups_list}    ${after_change_group_list}    Publish merchant group not be the same

