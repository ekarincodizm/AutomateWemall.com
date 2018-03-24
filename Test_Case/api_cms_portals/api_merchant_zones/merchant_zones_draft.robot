*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_portals/merchantzones_keywords.robot

*** Variables ***
${department_01}    department_001
${department_02}    department_002
${create_department_json}    ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/post_department_01.json
${update_department_json}    ${CURDIR}/../../../Resource/TestData/portals/merchant_zones/put_department_01.json

*** Test Cases ***
TC_WMALL_00173 Merchant Zones - Module Type Department
    [Tags]    merchant_zones_id    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    Create Module Type in Merchant Zone    ${department_01}    ${create_department_json}
    Verify Create Meechant Zone Success    ${department_01}
    # Get
    Get Merchant Zones By Module Type    ${department_01}
    Should Merchant Zone Data Empty    ${department_01}
    # Put
    Update Module Type in Merchant Zone    ${department_01}    ${update_department_json}
    Verify Update Merchant Zone Data Success
    # Get
    Get Merchant Zones By Module Type    ${department_01}
    Should Merchant Zone Data Have Module Type and Banner    ${department_01}
    # Delete
    [Teardown]    Delete Merchant Zone Data    ${department_01}

TC_WMALL_00174 Merchant Zones - Module Type Department With Empty Data
    [Tags]    merchant_zones_id    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    Create Empty Module Type in Merchant Zone    ${department_02}
    Verify Create Meechant Zone Success    ${department_02}
    # Get
    Get Merchant Zones By Module Type    ${department_02}
    Should Merchant Zone Data Have Only Module Type    ${department_02}
    # Put
    Update Module Type in Merchant Zone    ${department_02}    ${update_department_json}
    Verify Update Merchant Zone Data Success
    # Get
    Get Merchant Zones By Module Type    ${department_02}
    Should Merchant Zone Data Have Module Type and Banner    ${department_02}
    # Delete
    [Teardown]    Delete Merchant Zone Data    ${department_02}

TC_WMALL_00175 Create Duplicate Merchant Zone
    [Tags]    merchant_zones_id    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    Create Module Type in Merchant Zone    ${department_01}    ${update_department_json}
    Verify Create Meechant Zone Success    ${department_01}
    # Get
    Get Merchant Zones By Module Type    ${department_01}
    Should Merchant Zone Data Have Module Type and Banner    ${department_01}
    # Post Duplicate
    Create Module Type in Merchant Zone Failed    ${department_01}    ${create_department_json}
    Verify Post Response Failed Duplicate Module Type
    # Get
    Get Merchant Zones By Module Type    ${department_01}
    Should Merchant Zone Data Have Module Type and Banner    ${department_01}
    # Delete
    [Teardown]    Delete Merchant Zone Data    ${department_01}

TC_WMALL_00176 Update Merchant Zone with Empty Data
    [Tags]    merchant_zones_id    api_merchant_zones    api_portals    api_cms    Regression
    # Post
    Create Module Type in Merchant Zone    ${department_01}    ${update_department_json}
    Verify Create Meechant Zone Success    ${department_01}
    # Get
    Get Merchant Zones By Module Type    ${department_01}
    Should Merchant Zone Data Have Module Type and Banner    ${department_01}
    # Put
    Update Module Type in Merchant Zone With Empty Body Data    ${department_01}
    Verify PUT Response Failed Because Empty Body Data
    # Get
    Get Merchant Zones By Module Type    ${department_01}
    Should Merchant Zone Data Have Module Type and Banner    ${department_01}
    # Delete
    [Teardown]    Delete Merchant Zone Data    ${department_01}

TC_WMALL_00177 Delete Invalid Module Type
    [Tags]    merchant_zones_id    api_merchant_zones    api_portals    api_cms    Regression
    # Delete
    Delete Merchant Zone with Invalid Module Type    invalid_module_type
    Verify Delete Merchant Zone Failed Because Invalid Module Type









