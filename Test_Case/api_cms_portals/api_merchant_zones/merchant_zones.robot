*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup       Prepare Department Merchant Zones Data    ${department_04}
Suite Teardown    Delete Merchant Zone Data    ${department_04}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/merchantzones_keywords.robot

*** Variables ***
${department_04}        department_004
${department_05}        department_005
${invalid_module_type}  invalid_module_type

*** Test Cases ***
# Get Portal
TC_WMALL_00167 Get Merchant Zone - Module Type Portal
    [Tags]    merchant_zones    api_merchant_zones    api_portals    api_cms    Regression
    Get Merchant Zones By Module Type    ${department_04}
    Verify GET Response and Response Get Module Type Correct    ${department_04}

TC_WMALL_00168 Get Published Merchant Zone - Module Type Portal
    [Tags]    merchant_zones    api_merchant_zones    api_portals    api_cms    Regression
    Get Published Merchant Zones By Module Type    ${department_04}
    Verify GET Response and Response Get Module Type Correct    ${department_04}

# Invalid Module
TC_WMALL_00169 Get Merchant Zone with Invalid Module Type
    [Tags]    merchant_zones    api_merchant_zones    api_portals    api_cms    Regression
    Get Merchant Zones By Module Type    ${invalid_module_type}
    Verify GET Response Success but Data Is Empty

TC_WMALL_00170 Get Published Merchant Zone with Invalid Module Type
    [Tags]    merchant_zones    api_merchant_zones    api_portals    api_cms    Regression
    Get Published Merchant Zones By Module Type    ${invalid_module_type}
    Verify GET Response Success but Data Is Empty

# Published Module Type
TC_WMALL_00171 Publish Merchant Zone Data
    [Tags]    merchant_zones    api_merchant_zones    api_portals    api_cms    Regression
    [Setup]    Prepare Published Merchant Zone Data    ${department_05}
    ${before_change_groups_list}=    Get Merchant Zone Group List from Publish    ${department_05}
    ${after_change_group_list}=    Update Data Before Publish Merchant Zone    ${department_05}    ${before_change_groups_list}
    Published Merchant Zones Data    ${department_05}
    Verify Published Data Success and Data Updated Correct    ${after_change_group_list}    ${department_05}
    [Teardown]    Delete Merchant Zone Data    ${department_05}

# Published with invalid data
TC_WMALL_00172 Publish Merchant Zone with Invalid Module Type
    [Tags]    merchant_zones    api_merchant_zones    api_portals    api_cms    Regression
    Published Merchant Zones Data with Invalid Module Type    ${invalid_module_type}
    Verify Published Merchant Zone Group Failed Because Invalid Module Type






