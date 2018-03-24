*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Teardown              Clear Menu Bars Data For Suite Get    ${portal}
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/menubars_keywords.robot

*** Variables ***
${portal}                   portal_delete_module
${web}                      web
${mobile}                   mobile
${draft}                    draft
${published}                published
${template_json_data}       ${CURDIR}/../../../Resource/TestData/portals/menu_bars/template_menubars.json

*** Test Cases ***
TC_WMALL_00606 Delete Menu Bars Site Web Both Version
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_data}
    Delete Menu Bars    ${portal}    ${web}    ${draft}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${draft}
    Verify Get Menu Bars Success But Data is Null
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${published}
    Verify Get Menu Bars Success and Data is Not Null
    Delete Menu Bars    ${portal}    ${web}    ${published}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${draft}
    Verify Get Menu Bars Success But Data is Null
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${published}
    Verify Get Menu Bars Success But Data is Null

TC_WMALL_00607 Delete Menu Bars Site Web that Data Have Only Draft
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_data}
    Delete Menu Bars    ${portal}    ${web}    ${draft}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${draft}
    Verify Get Menu Bars Success But Data is Null
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${published}
    Verify Get Menu Bars Success and Data is Not Null

TC_WMALL_00608 Delete Menu Bars Site Web that Data Have Only Published
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_data}
    Delete Menu Bars    ${portal}    ${web}    ${published}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${draft}
    Verify Get Menu Bars Success and Data is Not Null
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${published}
    Verify Get Menu Bars Success But Data is Null

TC_WMALL_00609 Delete Menu Bars Site Mobile Both Version
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_data}
    Delete Menu Bars    ${portal}    ${mobile}    ${draft}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${draft}
    Verify Get Menu Bars Success But Data is Null
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${published}
    Verify Get Menu Bars Success and Data is Not Null
    Delete Menu Bars    ${portal}    ${mobile}    ${published}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${draft}
    Verify Get Menu Bars Success But Data is Null
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${published}
    Verify Get Menu Bars Success But Data is Null

TC_WMALL_00610 Delete Menu Bars Site Mobile that Data Have Only Draft
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_data}
    Delete Menu Bars    ${portal}    ${mobile}    ${draft}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${draft}
    Verify Get Menu Bars Success But Data is Null
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${published}
    Verify Get Menu Bars Success and Data is Not Null

TC_WMALL_00611 Delete Menu Bars Site Mobile that Data Have Only Published
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_data}
    Delete Menu Bars    ${portal}    ${mobile}    ${published}
    Verify Delete Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${draft}
    Verify Get Menu Bars Success and Data is Not Null
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${published}
    Verify Get Menu Bars Success But Data is Null

TC_WMALL_00612 Delete Menu Bars with Wrong Module Key
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    Delete Menu Bars    wrong_module_key    ${mobile}    ${published}
    Verify Delete Success and Response Data Correct

TC_WMALL_00613 Delete Menu Bars with Wrong Site
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    Delete Menu Bars    ${portal}    wrong_site    ${draft}
    Verify Delete Success and Response Data Correct

TC_WMALL_00614 Delete Menu Bars with Wrong Version
    [Tags]    delete_menubars   api_menubars    api_portals    api_cms    Regression
    Delete Menu Bars Failed    ${portal}    ${mobile}    wrong_version
    Verify Delete Menu Bars Failed and Message and Code Match    400 Bad Request    400    wrong version
