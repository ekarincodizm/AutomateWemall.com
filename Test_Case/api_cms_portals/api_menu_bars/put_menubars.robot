*** Settings ***
Force Tags    WLS_API_CMS_Portal
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/menubars_keywords.robot

*** Variables ***
${portal}                   portal_put_module
${portal_published}         portal_put_published
${web}                      web
${mobile}                   mobile
${draft}                    draft
${published}                published
${template_json_data}       ${CURDIR}/../../../Resource/TestData/portals/menu_bars/template_menubars.json

*** Test Cases ***
TC_WMALL_00597 Put Menu Bars with Site Web
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    Put Menu Bars    ${portal}    ${web}    ${draft}    ${template_json_data}
    Verify Put Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${draft}
    Verify Get Menu Bars Success and Data is Not Null
    Get Menu Bars with Specific Version    ${portal}    ${web}    ${published}
    Verify Get Menu Bars Success But Data is Null
    [Teardown]    Delete Menu Bars Success    ${portal}    ${web}

TC_WMALL_00598 Put Menu Bars with Site Mobile
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    Put Menu Bars    ${portal}    ${mobile}    ${draft}    ${template_json_data}
    Verify Put Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${draft}
    Verify Get Menu Bars Success and Data is Not Null
    Get Menu Bars with Specific Version    ${portal}    ${mobile}    ${published}
    Verify Get Menu Bars Success But Data is Null
    [Teardown]    Delete Menu Bars Success    ${portal}    ${mobile}

TC_WMALL_00599 Put Menu Bars Site Web with version Published
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Create Menu Bars Success   ${portal_published}    ${web}    ${template_json_data}
    Published Menu Bars    ${portal_published}    ${web}
    Verify Put Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal_published}    ${web}    ${draft}
    Verify Get Menu Bars Success and Data is Not Null
    Get Menu Bars with Specific Version    ${portal_published}    ${web}    ${published}
    Verify Get Menu Bars Success and Data is Not Null
    [Teardown]    Delete Menu Bars Success    ${portal_published}    ${web}

TC_WMALL_00600 Put Menu Bars Site Mobile with version Published
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    [Setup]    Create Menu Bars Success   ${portal_published}    ${mobile}    ${template_json_data}
    Published Menu Bars    ${portal_published}    ${mobile}
    Verify Put Success and Response Data Correct
    Get Menu Bars with Specific Version    ${portal_published}    ${mobile}    ${draft}
    Verify Get Menu Bars Success and Data is Not Null
    Get Menu Bars with Specific Version    ${portal_published}    ${mobile}    ${published}
    Verify Get Menu Bars Success and Data is Not Null
    [Teardown]    Delete Menu Bars Success    ${portal_published}    ${mobile}

TC_WMALL_00601 Put Menu Bars with Empty Body
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    Put Menu Bars with Empty Data    ${portal}    ${web}
    Verify Put Menu Bars Failed and Message and Code Match    400 Bad Request    400    require json-input

TC_WMALL_00602 Put Menu Bars with Empty Site
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    Put Menu Bars with Empty Data    ${portal}    ${EMPTY}
    Verify Put Menu Bars Failed and Message and Code Match    500 Internal Server Error    500    Not-Found handler is not callable or is not defined

TC_WMALL_00603 Put Menu Bars with Wrong Site
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    Put Menu Bars Failed    ${portal}    wrong_site    ${draft}    ${template_json_data}
    Verify Put Menu Bars Failed and Message and Code Match    400 Bad Request    400    wrong site

TC_WMALL_00604 Put Menu Bars with Wrong Version
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    Put Menu Bars Failed    ${portal}    ${web}    wrong_version    ${template_json_data}
    Verify Put Menu Bars Failed and Message and Code Match    400 Bad Request    400    wrong version

TC_WMALL_00605 Put Menu Bars without Version
    [Tags]    put_menubars   api_menubars    api_portals    api_cms    Regression
    Put Menu Bars Failed Because No Version Node    ${portal}    ${web}    ${template_json_data}
    Verify Put Menu Bars Failed and Message and Code Match    400 Bad Request    400    wrong version

