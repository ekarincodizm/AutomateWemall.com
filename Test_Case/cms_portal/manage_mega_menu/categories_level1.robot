*** Settings ***
Force Tags    WLS_Manage_Shop
Library                     Selenium2Library
Library                     ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot
Resource                    ${CURDIR}/../../../Keyword/Portal/portal_cms/mega_menu/cms_mega_menu_keywords.robot
Resource                    ${CURDIR}/../../../Resource/TestData/portals/mega_menus/mega_menu_variable.robot
Resource                    ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource                    ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/megamenus_keywords.robot
Suite Setup                 Open Brower AND Go To Manage Mega Menu
Suite Teardown              Close All Browsers

*** Test Cases ***
TC_WMALL_00039 Add new Categories Level 1
    [Tags]    Regression    Mega Menu    TC_WMALL_00039    WLS_Medium
    Click Add Mega Menu Level1 And Verify Field Mega Menu Level1

TC_WMALL_00040 Add new Categories Level 1 - required field
    [Tags]    Regression    Mega Menu    TC_WMALL_00040    WLS_Medium
    Click Element    ${ok_btn}
    Verify Required Message On Mega Menu Level1

TC_WMALL_00041 Add new Categories Level 1 - all field cannot be space
    [Tags]    Regression    Mega Menu    TC_WMALL_00041    WLS_Low
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${SPACE}    ${SPACE}    ${SPACE}    ${SPACE}
    Click Element    ${ok_btn}
    Verify Required Message On Mega Menu Level1

TC_WMALL_00042 Update Categories Level 1 - Name, TC_WMALL_00043 - Update Categories Level 1 - Link
    [Tags]    Regression    Mega Menu    TC_WMALL_00042    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Click All Draft Mega Menu
    Update Mega Menu Level1    ${namelvl1_th}    ${namelvl2_th}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}
    Wait Until Element Is Visible    jquery=div.dd2-content:contains(${namelvl2_th})
    Click All Draft Mega Menu
    ## Verify Mega Menu Levl1 ##
    ${res_lvl1}=    Get All Mega Menu Level1 From API CMS Portal    ${PORTAL}
    Log    ${res_lvl1}
    ${length_lvl1}=    Get Length    ${res_lvl1}
    ## Verify Mega Menu On PCMS with API - LEVLE 1 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Verify Mega Menu Level1 Show Data Correctly    ${index}    ${res_lvl1[${index}]}

TC_WMALL_00044 Update Categories Level 1 - required field, TC_WMALL_00045 - Update Categories Level 1 - all field cannot be space
    [Tags]    Regression    Mega Menu    TC_WMALL_00044    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    #Update Mega Menu Level1    ${namelvl2_th}    ${SPACE}    ${SPACE}    ${SPACE}    ${SPACE}
    Update Mega Menu Level1    ${namelvl1_th}    ${SPACE}    ${SPACE}    ${SPACE}    ${SPACE}
    Click Element    ${ok_btn}
    Verify Required Message On Mega Menu Level1

TC_WMALL_00046 Categories Level 1 - Delete
    [Tags]    Regression    Mega Menu    TC_WMALL_00046    WLS_Medium
     Go To    ${PORTAL-HOST}
     Select Mega Menu Page
     Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
     #Click Delete Mega Menu Level1    ${namelvl2_th}
     Click Delete Mega Menu Level1    ${namelvl1_th}
     Click All Draft Mega Menu
     Go To    ${PORTAL-HOST}
     Select Mega Menu Page
     Element Should Not Be Visible    jquery=div.dd2-content:contains(${namelvl2_th})

TC_WMALL_00047 Categories Level 1 - drag and drop
    [Tags]    Regression    Mega Menu    TC_WMALL_00047    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Create Mega Menu Level1    ${namelvl2_th}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}
    Drag And Drop    jquery=div.dd2-content:contains(${namelvl2_th})    jquery=div.dd2-content:contains(${namelvl1_th})
    Click All Draft Mega Menu
    ## Verify Mega Menu Sort Correctly ##
    ${res_lvl1}=    Get All Mega Menu Level1 From API CMS Portal    ${PORTAL}
    Log    ${res_lvl1}
    ${length_lvl1}=    Get Length    ${res_lvl1}
    ## Verify Mega Menu On PCMS with API - LEVLE 1 ##
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Verify Mega Menu Level1 Show Data Correctly    ${index}    ${res_lvl1[${index}]}
    Click Delete Mega Menu Level1    ${namelvl1_th}
    Click Delete Mega Menu Level1    ${namelvl2_th}
    Click All Draft Mega Menu

*** Keywords ***
Delete Mega Menu Level1
    [Arguments]    ${namelvl1_th}
    Go To    ${PORTAL-HOST}
    Wait Until Angular Ready    30s
    Select Mega Menu Page
    Click Delete Mega Menu Level1    ${namelvl1_th}
    Click All Draft Mega Menu
    Click All Publish Mega Menu