*** Settings ***
Force Tags    WLS_API_CMS_Portal
Suite Setup                 Prepare Menu Bars Data For Suite Get    ${portal}    ${template_json_data}
Suite Teardown              Clear Menu Bars Data For Suite Get    ${portal}
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/menubars_keywords.robot

*** Variables ***
${portal}                   portal_get_module
${web}                      web
${mobile}                   mobile
${draft}                    draft
${published}                published
${template_json_data}       ${CURDIR}/../../../Resource/TestData/portals/menu_bars/template_menubars.json

*** Test Cases ***
TC_WMALL_00590 Get Menu Bars with Site Web
    [Tags]    get_menubars   api_menubars    api_portals    api_cms    Regression
    Get Menu Bars    ${portal}    ${web}
    Verify Get Menu Bars Success and Data is Not Null

TC_WMALL_00591 Get Menu Bars with Site Mobile
    [Tags]    get_menubars   api_menubars    api_portals    api_cms    Regression
    Get Menu Bars    ${portal}    ${mobile}
    Verify Get Menu Bars Success and Data is Not Null

TC_WMALL_00592 Get Menu Bars with Wrong Module Key
    [Tags]    get_menubars   api_menubars    api_portals    api_cms    Regression
    Get Menu Bars    wrong_module_key    ${web}
    Verify Get Menu Bars Success But Data is Null

TC_WMALL_00593 Get Menu Bars with Wrong Site
    [Tags]    get_menubars   api_menubars    api_portals    api_cms    Regression
    Get Menu Bars    ${portal}    wrong_site
    Verify Get Menu Bars Success But Data is Null

TC_WMALL_00594 Get Menu Bars with Version Draft
    [Tags]    get_menubars   api_menubars    api_portals    api_cms    Regression
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${draft}
    Verify Get Menu Bars Success and Data is Not Null

TC_WMALL_00595 Get Menu Bars with Version Published
    [Tags]    get_menubars   api_menubars    api_portals    api_cms    Regression
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${published}
    Verify Get Menu Bars Success and Data is Not Null

TC_WMALL_00596 Get Menu Bars with Worng Version
    [Tags]    get_menubars   api_menubars    api_portals    api_cms    Regression
    Get Menu Bars Failed with Specific Version    ${portal}    ${mobile}    wrong_version
    Verify Get Menu Bars Failed and Message and Code Match    400 Bad Request    400    wrong version


