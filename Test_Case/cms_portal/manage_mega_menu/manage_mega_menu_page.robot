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
Suite Teardown              Close All Browsers

*** Variable ***
${lvl1_preview_th}         ทดสอบพรีวิว
${lvl1_preview_en}         TestPreview
${link1_th}                http://www.wemall-dev.com
${link1_en}                http://www.wemall-dev.com/en

${lvl2_preview_th}         ทดสอบพรีวิวเลเวลสอง
${lvl2_preview_en}         TestPreviewlevel2
${link2_th}                http://www.wemall-dev.com
${link2_en}                http://www.wemall-dev.com/en

*** Test Cases ***
TC_WMALL_00038 List Categories level 1-2
    [Tags]    Regression    Mega Menu    WLS_High
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

TC_WMALL_00059
    [Documentation]    Preview button
    [Tags]    Regression    Mega Menu    WLS_High
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${lvl1_preview_th}    ${lvl1_preview_en}    ${link1_th}    ${link1_en}
    Create Mega Menu Level2    ${lvl2_preview_th}    ${lvl2_preview_en}    ${link2_th}    ${link2_en}    ${header}
    Click Element and Wait Angular Ready    ${save_button}
    Click Preview All Mega Menu Page
    ${res_lvl1}=    Get All Mega Menu Level1 From API CMS Portal    ${PORTAL}
    Log    ${res_lvl1}
    ${length_lvl1}=    Get Length    ${res_lvl1}
    ## Verify Mega Menu Level 1 On Portal Page - LEVLE 1 ##
    Select Window On Preview Portal Page
    :FOR    ${index}    IN RANGE    0     ${length_lvl1}
    \    Verify Mega Menu On Portal Page Show Level1 Data Correctly    ${index}    ${res_lvl1[${index}]}
    Verify Mega Menu    ${PORTAL}    ${lang_th}    ${visible_check}    ${visible_uncheck}    ${draft_version}

TC_WMALL_00060 Publish button
    [Tags]    Regression    Mega Menu    WLS_High
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Create Mega Menu Level2    ${namelvl2_th}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}    ${header}
    Create Mega Menu Level2    ${namelvl2_th}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}
    Create New Banner Group    ${textTest}    ${img_with_path1}    ${img_with_path2}    ${img_with_path3}
    Go To    ${PORTAL-HOST}
    Wait Until Angular Ready    30s
    Sleep    2s
    Select Mega Menu Page
    Sleep    2s
    Click All Publish Mega Menu
    Go To    ${WEMALL_WEB}
    Verify Mega Menu    ${PORTAL}    ${lang_th}    ${visible_check}    ${visible_uncheck}    ${published_version}
    [Teardown]    Delete Mega Menu Level1    ${namelvl1_th}

TC_WMALL_00262 Show Type of Menu Level 2, TC_WMALL_00263, TC_WMALL_00265
    [Tags]    Regression    Mega Menu    WLS_Medium
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Create Mega Menu Level2    ${namelvl2_th}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}    ${header}
    Create Mega Menu Level2    ${namelvl2_th}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}
    Create Mega Menu Level2    ${namelvl3_th}    ${namelvl3_en}    ${linklvl3_th}    ${linklvl3_en}
    Create Mega Menu Level2    ${namelvl3_th}    ${namelvl3_en}    ${linklvl3_th}    ${linklvl3_en}    ${header}
    Click Preview All Mega Menu Page
    Select Window On Preview Portal Page
    Verify Mega Menu    ${PORTAL}    ${lang_th}    ${visible_check}    ${visible_uncheck}    ${draft_version}
    [Teardown]    Delete Mega Menu Level1    ${namelvl1_th}

# TC_WMALL_00263 - Show Selected Menu Level 2 Name
#     [Tags]    Regression

# TC_WMALL_00265 - Save button
#     [Tags]    Regression

*** Keywords ***
Delete Mega Menu Level1
    [Arguments]    ${namelvl1_th}
    Go To    ${PORTAL-HOST}
    Wait Until Angular Ready    30s
    Select Mega Menu Page
    Click Delete Mega Menu Level1    ${namelvl1_th}
    Click All Draft Mega Menu
    Click All Publish Mega Menu

