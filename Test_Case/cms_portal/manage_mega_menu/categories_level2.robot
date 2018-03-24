*** Settings ***
Force Tags    WLS_Manage_Shop
Library             Selenium2Library
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/portal_cms/mega_menu/cms_mega_menu_keywords.robot
Resource            ${CURDIR}/../../../Resource/TestData/portals/mega_menus/mega_menu_variable.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/megamenus_keywords.robot
Suite Setup         Open Brower AND Go To Manage Mega Menu
Suite Teardown      Delete Mega Menu Level1 AND Close Browser    ${namelvl1_th}

*** Test Cases ***
TC_WMALL_00048 Categories Level 2 - Add new header type, TC_WMALL_00049 - Categories Level 2 - Add new link type
    [Tags]    Regression    Mega Menu    WLS_Medium
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Create Mega Menu Level2    ${namelvl2_th}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}    ${header}
    Create Mega Menu Level2    ${namelvl3_th}    ${namelvl3_en}    ${linklvl3_th}    ${linklvl3_en}
    Create Mega Menu Level2    ${namelvl4_th}    ${namelvl4_en}    ${linklvl4_th}    ${linklvl4_en}
    Click All Draft Mega Menu
    # [Teardown]    Delete Mega Menu Level1

TC_WMALL_00050 Categories Level 2 - create required field
    [Tags]    Regression    Mega Menu    WLS_Medium
    # [Setup]    Run Keywrods    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    # ...    Click All Draft Mega Menu
    Create Mega Menu Level2    ${EMPTY}    ${EMPTY}   ${EMPTY}   ${EMPTY}
    Verify Required Message On Mega Menu Level2 Type Link
    # [Teardown]    Delete Mega Menu Level1

TC_WMALL_00051 Add new Categories Level 2 - all field cannot be space
    [Tags]    Regression    Mega Menu    WLS_Low
    # [Setup]    Run Keywrods    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    # ...    Click All Draft Mega Menu
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Create Mega Menu Level2    ${SPACE}    ${SPACE}    ${SPACE}    ${SPACE}    ${header}
    Verify Required Message On Mega Menu Level2 Type Header
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Create Mega Menu Level2    ${SPACE}    ${SPACE}    ${SPACE}    ${SPACE}
    Verify Required Message On Mega Menu Level2 Type Link
    # [Teardown]    Delete Mega Menu Level1

TC_WMALL_00052 
    [Documentation]    Categories Level 2 - Update Name
    [Tags]    Regression    Mega Menu    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Update Mega Menu Level2    ${namelvl2_th}    ${edit_th}    ${edit_en}    ${linklvl2_th}    ${linklvl2_en}    ${header}
    Click All Draft Mega Menu
    ## Verify Mega Menu 1 AND 2 ##
    ${res_lvl1}=    Get All Mega Menu Level1 From API CMS Portal    ${PORTAL}
    Log    ${res_lvl1}
    ${length_lvl1}=    Get Length    ${res_lvl1}
    ## Verify Mega Menu On PCMS with API - LEVLE 1 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Verify Mega Menu Level1 Show Data Correctly    ${index}    ${res_lvl1[${index}]}
    ## Verify Mega Menu On PCMS with API - LEVEL 2 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Select Mega Menu Level 1    ${index}
    \    ${res_lvl2}=    Get Mega Menu Level2 From API CMS Portal    ${PORTAL}    ${index}
    \    ${length_lvl2}=    Get Length    ${reslvl2}
    \    Log    ${length_lvl2}
    \    Verify that check Mega Menu Lvl2 with API    ${length_lvl2}    ${res_lvl2}

TC_WMALL_00053
    [Documentation]    Categories Level 2 - Change header type to link, TC_WMALL_00054 - Categories Level 2 - Update Link
    [Tags]    Regression    Mega Menu    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Update Mega Menu Level2    ${edit_th}    ${edit_th}    ${edit_en}    ${edit_link_th}    ${edit_link_en}
    Update Mega Menu Level2    ${namelvl3_th}    ${edit2_th}    ${edit2_en}    ${edit_link_th}    ${edit_link_en}    ${header}
    Click All Draft Mega Menu
    ## Verify Mega Menu 1 AND 2 ##
    ${res_lvl1}=    Get All Mega Menu Level1 From API CMS Portal    ${PORTAL}
    Log    ${res_lvl1}
    ${length_lvl1}=    Get Length    ${res_lvl1}
    ## Verify Mega Menu On PCMS with API - LEVLE 1 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Verify Mega Menu Level1 Show Data Correctly    ${index}    ${res_lvl1[${index}]}

    ## Verify Mega Menu On PCMS with API - LEVEL 2 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Select Mega Menu Level 1    ${index}
    \    ${res_lvl2}=    Get Mega Menu Level2 From API CMS Portal    ${PORTAL}    ${index}
    \    ${length_lvl2}=    Get Length    ${reslvl2}
    \    Log    ${length_lvl2}
    \    Verify that check Mega Menu Lvl2 with API    ${length_lvl2}    ${res_lvl2}

TC_WMALL_00055
    [Documentation]    Categories Level 2 - update required field
    [Tags]    Regression    Mega Menu    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Update Mega Menu Level2    ${edit_th}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Verify Required Message On Mega Menu Level2 Type Link

TC_WMALL_00056
    [Documentation]    Categories Level 2 - all field cannot be space
    [Tags]    Regression    Mega Menu    WLS_Low
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Update Mega Menu Level2    ${edit_th}    ${SPACE}    ${SPACE}    ${SPACE}    ${SPACE}
    Verify Required Message On Mega Menu Level2 Type Link

TC_WMALL_00057
    [Documentation]    Categories Level 2 - Delete
    [Tags]    Regression    Mega Menu    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    ${delete_status}    Run Keyword And Return Status    Click Delete Mega Menu Level2    ${namelvl4_th}
    Run Keyword If    '${delete_status}' == 'False'    Create Mega Menu Level2    ${namelvl4_th}    ${namelvl4_en}    ${linklvl4_th}    ${linklvl4_en}    ${header}
    Run Keyword If    '${delete_status}' == 'False'    Click Delete Mega Menu Level2    ${namelvl4_th}
    Click All Draft Mega Menu
    Element Should Not Be Visible    div.dd2-content:contains(${namelvl4_th})

TC_WMALL_00058
    [Documentation]    Categories Level 2 - drag and drop
    [Tags]    Regression    Mega Menu    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    ${menu1_visible}    Run Keyword And Return Status    Element Should Be Visible    jquery=div.dd2-content:contains(${edit2_th})
    ${menu2_visible}    Run Keyword And Return Status    Element Should Be Visible    jquery=div.dd2-content:contains(${edit_th})
    Run Keyword If    '${menu1_visible}' == 'False'    Create Mega Menu Level2    ${edit2_th}    ${namelvl4_en}    ${linklvl4_th}    ${linklvl4_en}    ${header}
    Run Keyword If    '${menu1_visible}' == 'False'    Create Mega Menu Level2    ${edit_th}    ${namelvl4_en}    ${linklvl4_th}    ${linklvl4_en}    ${header}
    Drag And Drop    jquery=div.dd2-content:contains(${edit2_th})    jquery=div.dd2-content:contains(${edit_th})
    Click All Draft Mega Menu
    ## Verify Mega Menu 1 AND 2 ##
    ${res_lvl1}=    Get All Mega Menu Level1 From API CMS Portal    ${PORTAL}
    Log    ${res_lvl1}
    ${length_lvl1}=    Get Length    ${res_lvl1}
    ## Verify Mega Menu On PCMS with API - LEVLE 1 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Verify Mega Menu Level1 Show Data Correctly    ${index}    ${res_lvl1[${index}]}

    ## Verify Mega Menu On PCMS with API - LEVEL 2 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Select Mega Menu Level 1    ${index}
    \    ${res_lvl2}=    Get Mega Menu Level2 From API CMS Portal    ${PORTAL}    ${index}
    \    ${length_lvl2}=    Get Length    ${reslvl2}
    \    Log    ${length_lvl2}
    \    Verify that check Mega Menu Lvl2 with API    ${length_lvl2}    ${res_lvl2}

TC_WMALL_00264
    [Documentation]    Categories Level 2 - Update Type
    [Tags]    Regression    Mega Menu    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Update Mega Menu Level2    ${edit_th}    ${edit_th}    ${edit_en}    ${linklvl2_th}    ${linklvl2_en}    ${header}

*** Keywords ***
Delete Mega Menu Level1 AND Close Browser
    [Arguments]    ${namelvl1_th}
    Delete Mega Menu Level1    ${namelvl1_th}
    Close All Browsers

Delete Mega Menu Level1
    [Arguments]    ${namelvl1_th}
    Go To    ${PORTAL-HOST}
    Wait Until Angular Ready    30s
    Select Mega Menu Page
    Click Delete Mega Menu Level1    ${namelvl1_th}
    Click All Draft Mega Menu
    Click All Publish Mega Menu

