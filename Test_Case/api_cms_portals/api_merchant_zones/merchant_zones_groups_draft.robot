*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup       Prepare Merchant Zone Data for Groups    ${department_03}
Suite Teardown    Delete Merchant Zone Data    ${department_03}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/merchantzones_keywords.robot

*** Variables ***
${department_03}        department_003
${department_05}        department_005
${create_group_json}    ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/post_merchant_groups_01.json
${update_group_json}    ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/put_group_01.json

*** Test Cases ***
TC_WMALL_00178 Merchant Zone Groups - Module Type Department
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    ${merchant_zone_id_03}=    Get Merchant Zone Id    ${department_03}
    Create Merchant Zone Groups    ${department_03}    ${create_group_json}
    Verify Create Merchant Zone Groups Success    ${merchant_zone_id_03}
    ${group_id_03}=    Get Merchant Zone Group Id From Post Response
    # Get
    Get Merchant Zones By Module Type    ${department_03}
    Verify Merchant Zone Group Id Exist in Module Type        ${department_03}    ${merchant_zone_id_03}    ${group_id_03}
    # Put
    Update Merchant Zone Group    ${department_03}    ${group_id_03}    ${update_group_json}
    Verify Update Merchant Zone Group Success    ${merchant_zone_id_03}    ${group_id_03}
    # Get
    Get Merchant Zones By Module Type    ${department_03}
    Verify Merchant Zone Group Id and Brands Exist in Module Type        ${department_03}    ${merchant_zone_id_03}    ${group_id_03}
    # Delete
    [Teardown]    Delete Merchant Zone Group Data    ${department_03}    ${merchant_zone_id_03}    ${group_id_03}

TC_WMALL_00179 Merchant Zone Groups - Module Type Department With Empty Data
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    Create Merchant Zone Groups with Empty Data    ${department_03}
    Verify Create Merchant Zone Groups with Empty Fialed

TC_WMALL_00180 Create Groups with Invalid Module Type
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    Create Merchant Zone Groups with Invalid Module Type    invalid_module_type    ${create_group_json}
    Verify Create Merchant Zone Groups with Invalid Module Type Fialed

TC_WMALL_00181 Update Merchant Zone Group with Empty Data
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    ${merchant_zone_id_03}=    Get Merchant Zone Id    ${department_03}
    Create Merchant Zone Groups    ${department_03}    ${create_group_json}
    Verify Create Merchant Zone Groups Success    ${merchant_zone_id_03}
    ${group_id_03}=    Get Merchant Zone Group Id From Post Response
    # Put
    Update Merchant Zone Group with Empty Data    ${department_03}    ${group_id_03}
    Verify PUT Response Failed Because Empty Body Data
    #Delete
    [Teardown]    Delete Merchant Zone Group Data    ${department_03}    ${merchant_zone_id_03}    ${group_id_03}

TC_WMALL_00182 Update Merchant Zone Group with Invalid Module Type
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    # Put
    Update Merchant Zone Group with Invalid Module Type    invalid_module_type    invalid_group_id    ${create_group_json}
    Verify Update Merchant Zone Group Failed Because Invalid Module Type

TC_WMALL_00183 Delete Merchant Zone Group - Delete Only Draft Data
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    [Setup]    Prepare Published Merchant Zone Data    ${department_05}
    ${before_delete_groups_list}=    Get Merchant Zone Group List from Publish    ${department_05}
    Delete Merchant Zone Group By Select Group ID Form List    ${department_05}    ${before_delete_groups_list}
    Verify Delete Groups Draft Version Success and Publish Group Not Change    ${before_delete_groups_list}    ${department_05}
    [Teardown]    Delete Merchant Zone Data    ${department_05}

TC_WMALL_00184 Delete Invalid Module Type
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    # Delete
    Delete Merchant Zone Group with Invalid Module Type
    Response Status Code Should Equal    301 Moved Permanently

TC_WMALL_00185 Delete Invalid Merchant Zone Group Id
    [Tags]    merchant_zone_groups    api_merchant_zones    api_portals    api_cms    Regression
    # Delete
    Delete Merchant Zone Group with Invalid Group Id    ${department_03}
    Verify Delete Merchant Zone Group Failed Because Invalid Merchant Zone Group Id


