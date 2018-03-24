*** Settings ***
Force Tags    WLS_Manage_Shop
Library                     Selenium2Library
Library                     ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot
Library                     ${CURDIR}/../../../Keyword/Portal/portal_cms/manage_banner.py
Library                     ${CURDIR}/../../../Python_Library/common.py
Resource                    ${CURDIR}/../../../Keyword/Portal/portal_cms/mega_menu/cms_mega_menu_keywords.robot
Resource                    ${CURDIR}/../../../Keyword/Portal/portal_cms/mega_menu_banner_group/cms_mega_menu_banner_group_keywords.robot
Resource                    ${CURDIR}/../../../Resource/TestData/portals/mega_menus/mega_menu_variable.robot
Resource                    ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource                    ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/megamenus_keywords.robot
Suite Teardown              Close All Browsers
Test Setup                  Prepare Data Megamenu And Open Browser
Test Teardown               Delete Mega Menu Level1 AND Close Browser    ${namelvl1_th}

*** Variable ***
${nametest}      เทสโรบอทสาม
${name_editth}    โรบอทแก้ไข
${name_editen}    Robotedit
${name_th3}       โรบอทสาม
${name_en3}       Robotthree
${maximum_banner_groups}     15
${OWL_CAROSEL_VERSION}       2

*** Test Case ***
TC_WMALL_01466 Manage Mega Menu - Show room carousel - Manage Mega Menu - Show room carousel
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Location Should Be      ${PORTAL-HOST}/#/mega-menu/showroom/${data_id}/2

TC_WMALL_01467 Manage Mega Menu - Show room carousel - Add New Banner Group
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible      ${menu_level1_list}
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Add Banner Group
    Input Text Banner Group Th              ${textTest}
    Input Text Banner Group En              ${textTest}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${textTest}")            ${textTest}

TC_WMALL_01470 Manage Mega Menu - Show room carousel - Edit Banner Group
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible      ${menu_level1_list}
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Add Banner Group
    Input Text Banner Group Th              ${textTest}
    Input Text Banner Group En              ${textTest}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${textTest}")            ${textTest}
    Click Element and Wait Angular Ready                      ${last_banner_group_edit}
    Input Text Banner Group Th              ${textTest}edited
    Input Text Banner Group En              ${textTest}edited
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${textTest}edited")            ${textTest}edited

TC_WMALL_01468 Manage Mega Menu - Show room carousel - Delete Banner Group
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible      ${menu_level1_list}
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Add Banner Group
    Input Text Banner Group Th              ${textTest}
    Input Text Banner Group En              ${textTest}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${textTest}")            ${textTest}
    Click Delete Last Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${textTest}")

TC_WMALL_01469 Manage Mega Menu - Show room carousel - Sort banner group
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible      ${menu_level1_list}
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    ${link}=   Get Element Attribute              ${banner_group_management}@href
    ${parent_id}=      get_parent_id          ${link}
    Click Banner Group Management
    Click Add Banner Group
    Input Text Banner Group Th              ${bannerTest2}
    Input Text Banner Group En              ${bannerTest2}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${bannerTest2}")            ${bannerTest2}
    Click Save Banner Group
    Drag And Drop             ${last_banner}    ${first_banner}
    Click Save Banner Group
    ${banner_api}=       Get Banner List From API           ${parent_id}
    ${banner_list_ui}=      Get Banner List From UI
    Log List     ${banner_list_ui}
    Log Dictionary      ${banner_api}
    check_banner        ${banner_list_ui}           ${banner_api}
    Click Delete First Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${bannerTest2}")
    Click Save Banner Group

TC_WMALL_01471 Manage Mega Menu - Show room carousel - Save button on banner group page.
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible      ${menu_level1_list}
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Add Banner Group
    Input Text Banner Group Th              ${textTest}
    Input Text Banner Group En              ${textTest}
    Click Submit Banner
    Click Save Banner Group
    ${version}=                Get Banner Version From API    ${data_id}
    Should Contain            ${version}      draft

TC_WMALL_01472
    [Documentation]    Preview button on banner group page.
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible      ${menu_level1_list}
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Wait Until Angular Ready    30s
    Click Add Banner Group
    Input Text Banner Group Th              ${bannerTest2}
    Input Text Banner Group En              ${bannerTest2}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${bannerTest2}")            ${bannerTest2}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${bannerTest2}")
    Add Banner Content         ${img_with_path4}    ${img_with_path5}    ${img_with_path6}     ${bannerTest2}
    Click Save Banner Group
    Click Element and Wait Angular Ready           ${banner_item}:contains("${bannerTest2}")
    Click Edit Banner Content              0
    ${window_title}=            Get Title
    Upload Pic banner               ${file_input}:eq(0)             ${img_with_path7}
    Upload Pic banner               ${file_input}:eq(1)             ${img_with_path7}
    Upload Pic banner               ${file_input}:eq(2)             ${img_with_path7}
    Upload Pic banner               ${file_input}:eq(3)             ${img_with_path7}
    Click Save Banner Group
    Click Preview Button
    Select Window On Preview Portal Page
    Verify Mega Menu        portal       th_TH     1    0    draft
    Close All Browsers
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Delete Last Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${bannerTest2}")
    Click Save Banner Group

TC_WMALL_00061
    [Documentation]    Verify a preview image
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    ${data_id}    Get Element Attribute    jquery=li.dd2-item:last@data-id
    Log    ${data_id}
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Add Banner Group
    Input Text Banner Group Th              ${textTest2}
    Input Text Banner Group En              ${textTest2}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${textTest2}")            ${textTest2}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${textTest2}")
    Add Banner Content Web and Mobile         ${web_img_path1}    ${web_img_path2}    ${web_img_path3}     ${mobile_img_path1}    ${mobile_img_path2}    ${mobile_img_path3}      ${textTest2}
    Click Save Banner Group
    Verify CDN Path With Expected Path      ${web_image_position_1}     ${expected_cdn_url1}     ${web_img_path1}
    Verify CDN Path With Expected Path      ${web_image_position_2}     ${expected_cdn_url2}     ${web_img_path2}
    Verify CDN Path With Expected Path      ${web_image_position_3}     ${expected_cdn_url3}     ${web_img_path3}
    Verify CDN Path With Expected Path      ${mobile_image_position_1}      ${expected_cdn_url4}        ${mobile_img_path1}
    Verify CDN Path With Expected Path      ${mobile_image_position_2}      ${expected_cdn_url5}        ${mobile_img_path2}
    Verify CDN Path With Expected Path      ${mobile_image_position_3}      ${expected_cdn_url6}        ${mobile_img_path3}
    Verify CDN Path With Portal API         ${web_image_position_1}         ${menuPortal}      ${bannerPosition1}        ${srcWebNode}         ${data_id}      1
    Verify CDN Path With Portal API         ${web_image_position_2}         ${menuPortal}      ${bannerPosition2}        ${srcWebNode}         ${data_id}      1
    Verify CDN Path With Portal API         ${web_image_position_3}         ${menuPortal}      ${bannerPosition3}        ${srcWebNode}         ${data_id}      1
    Verify CDN Path With Portal API         ${mobile_image_position_1}      ${menuPortal}      ${bannerPosition1}        ${srcMobileNode}      ${data_id}     1
    Verify CDN Path With Portal API         ${mobile_image_position_2}      ${menuPortal}      ${bannerPosition2}        ${srcMobileNode}      ${data_id}     1
    Verify CDN Path With Portal API         ${mobile_image_position_3}      ${menuPortal}      ${bannerPosition3}        ${srcMobileNode}      ${data_id}     1
    Click Delete Last Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${bannerTest2}")
    Click Save Banner Group

TC_WMALL_00062
    [Documentation]    Verify Banner data required filed
    [Tags]    Regression    Mega Menu    Carousel    WLS_Medium
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Wait Until Angular Ready    30s
    Click Add Banner Group
    Input Text Banner Group Th              ${textTest2}
    Input Text Banner Group En              ${textTest2}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${textTest2}")            ${textTest2}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${textTest2}")
    Click Save Banner Group
    Verify Banner Data Required Field       ${textTest2}
    Click Delete Last Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${textTest2}")
    Click Save Banner Group

TC_WMALL_00064 Delete banner data
    [Tags]    Regression    Mega Menu    Carousel    WLS_High
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Wait Until Angular Ready    30s
    Click Add Banner Group
    Input Text Banner Group Th              ${bannerTest2}
    Input Text Banner Group En              ${bannerTest2}
    Click Submit Banner
    Selenium2Library.Element Text Should Be       ${banner_item}:contains("${bannerTest2}")            ${bannerTest2}
    Click Element and Wait Angular Ready                ${banner_item}:contains("${bannerTest2}")
    Add Banner Content           ${img_with_path4}    ${img_with_path5}    ${img_with_path6}     ${bannerTest2}
    Click Save Banner Group
    Verify Banner Data Detail               ${position}
    Click Delete Last Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${bannerTest2}")
    Click Save Banner Group

TC_WMALL_01475
    [Documentation]    Portal web show carousel mega menu on portal page draft
    [Tags]    Regression    Mega Menu    Carousel    TC_WMALL_01475    WLS_Medium
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Wait Until Angular Ready    30s
    Click Add Banner Group
    Input Text Banner Group Th              ${bannerTest2}
    Input Text Banner Group En              ${bannerTest2}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${bannerTest2}")            ${bannerTest2}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${bannerTest2}")
    Add Banner Content Mobile And Web EN/TH    ${img_p1_th_web}   ${img_p2_th_web}   ${img_p3_th_web}    ${img_p1_en_web}    ${img_p2_en_web}    ${img_p3_en_web}    ${img_p1_th_mob}    ${img_p2_th_mob}    ${img_p3_th_mob}    ${img_p1_en_mob}    ${img_p2_en_mob}    ${img_p3_en_mob}    ${bannerTest2}
    Click Save Banner Group
    Click Preview Button
    Select Window On Preview Portal Page
    # Select Window           Title=${url}
    Verify Mega Menu    portal    th_TH    1    1    draft
    Click Change Language    en
    Wait Until Angular Ready    30s
    Verify Mega Menu    portal    en_US    1    1    draft
    Close All Browsers
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Delete Last Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${bannerTest2}")
    Click Save Banner Group
    Delete Mega Menu Level1 AND Close Browser    ${namelvl1_th}
    #### Publish ####
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Wait Until Angular Ready    30s
    Click Add Banner Group
    Input Text Banner Group Th              ${bannerTest2}
    Input Text Banner Group En              ${bannerTest2}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${bannerTest2}")            ${bannerTest2}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${bannerTest2}")
    Add Banner Content Mobile And Web EN/TH    ${img_p1_th_web}   ${img_p2_th_web}   ${img_p3_th_web}    ${img_p1_en_web}    ${img_p2_en_web}    ${img_p3_en_web}    ${img_p1_th_mob}    ${img_p2_th_mob}    ${img_p3_th_mob}    ${img_p1_en_mob}    ${img_p2_en_mob}    ${img_p3_en_mob}    ${bannerTest2}
    Click Save Banner Group
    Click Manage Mega Menu Page
    Click Publish Mega Menu
    Click Preview Mega Menu Page
    Select Window           url=${WEMALL_WEB}/?${PRIVIEW_TOKEN}
    Go To    ${WEMALL_WEB}
    Wait Until Angular Ready    30s
    Verify Mega Menu    portal    th_TH    1    1    publish
    Click Change Language    en
    Wait Until Angular Ready    30s
    Verify Mega Menu    portal    en_US    1    1    publish
    Close All Browsers
    Open Brower AND Go To Manage Mega Menu
    Wait Until Angular Ready    30s
    ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Delete Last Banner
    Click Submit Delete
    Page Should Not Contain Element      ${banner_item}:contains("${bannerTest2}")
    Click Save Banner Group

# TC_WMALL_01475 Portal web show carousel mega menu on portal page publish
#     [Tags]    Regression    Mega Menu    Carousel    TC_WMALL_01475
#     Click Mega Menu Level1    ${namelvl1_th}
#     Click Banner Group Management
#     Wait Until Angular Ready    30s
#     Click Add Banner Group
#     Input Text Banner Group Th              ${bannerTest2}
#     Input Text Banner Group En              ${bannerTest2}
#     Click Submit Banner
#     Selenium2Library.Element Text Should Be    ${banner_item}:contains("${bannerTest2}")            ${bannerTest2}
#     Click Element and Wait Angular Ready           ${banner_item}:contains("${bannerTest2}")
#     Add Banner Content Mobile And Web EN/TH    ${img_p1_th_web}   ${img_p2_th_web}   ${img_p3_th_web}    ${img_p1_en_web}    ${img_p2_en_web}    ${img_p3_en_web}    ${img_p1_th_mob}    ${img_p2_th_mob}    ${img_p3_th_mob}    ${img_p1_en_mob}    ${img_p2_en_mob}    ${img_p3_en_mob}    ${bannerTest2}
#     Click Save Banner Group
#     Click Manage Mega Menu Page
#     Click Publish Mega Menu
#     Click Preview Mega Menu Page
#     Select Window           url=${WEMALL_WEB}/?${PRIVIEW_TOKEN}
#     Go To    ${WEMALL_WEB}
#     Wait Until Angular Ready    30s
#     Verify Mega Menu    portal    th_TH    1    1    publish
#     Click Change Language    en
#     Wait Until Angular Ready    30s
#     Verify Mega Menu    portal    en_US    1    1    publish
#     Close All Browsers
#     Open Brower AND Go To Manage Mega Menu
#     Wait Until Angular Ready    30s
#     ${data_id}              Get Element Attribute       jquery=li.dd2-item:last@data-id
#     Click Mega Menu Level1    ${namelvl1_th}
#     Click Banner Group Management
#     Click Delete Last Banner
#     Click Submit Delete
#     Page Should Not Contain Element      ${banner_item}:contains("${bannerTest2}")
#     Click Save Banner Group

TC_WMALL_01477
    [Documentation]    Admin create and edit megamenu
    [Tags]    Regression    Mega Menu    Carousel
    Create New Banner Group    ${textTest}    ${img_with_path1}    ${img_with_path2}    ${img_with_path3}
    Select Status Banner Group    ${textTest}
    Click Add Banner Group
    Input Text Banner Group Th              ${bannerTest2}
    Input Text Banner Group En              ${bannerTest2}
    Click Submit Banner
    Add Banner Content Mobile And Web EN/TH    ${img_p1_th_web}   ${img_p2_th_web}   ${img_p3_th_web}    ${img_p1_en_web}    ${img_p2_en_web}    ${img_p3_en_web}    ${img_p1_th_mob}    ${img_p2_th_mob}    ${img_p3_th_mob}    ${img_p1_en_mob}    ${img_p2_en_mob}    ${img_p3_en_mob}    ${bannerTest2}
    Create New Banner Group    ${nametest}    ${img_with_path1}    ${img_with_path2}    ${img_with_path3}    Not
    Click Save Banner Group
    Click Manage Mega Menu Page
    Click Publish Mega Menu
    Go To    ${WEMALL_WEB}
    Wait Until Angular Ready    30s
    Verify Mega Menu    portal    th_TH    1    1    publish
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    Click Delete Banner Group    ${bannerTest2}
    Click Edit Banner Group    ${nametest}    ${name_editth}   ${name_editen}
    Click Add Banner Group
    Input Text Banner Group Th              ${name_th3}
    Input Text Banner Group En              ${name_en3}
    Click Submit Banner
    Add Banner Content Mobile And Web EN/TH    ${img_p1_th_web}   ${img_p2_th_web}   ${img_p3_th_web}    ${img_p1_en_web}    ${img_p2_en_web}    ${img_p3_en_web}    ${img_p1_th_mob}    ${img_p2_th_mob}    ${img_p3_th_mob}    ${img_p1_en_mob}    ${img_p2_en_mob}    ${img_p3_en_mob}    ${name_th3}
    Create New Banner Group    ${nametest}    ${img_with_path1}    ${img_with_path2}    ${img_with_path3}    Not
    Click Save Banner Group
    Click Manage Mega Menu Page
    Click Publish Mega Menu
    Go To    ${WEMALL_WEB}
    Wait Until Angular Ready    30s
    Verify Mega Menu    portal    th_TH    1    1    publish
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Click Delete Mega Menu Level1    ${namelvl1_th}

TC_WMALL_01478 Banner group support allow maxium 15
    [Tags]    Regression    Mega Menu    Carousel    WLS_Medium
    Click Mega Menu Level1    ${namelvl1_th}
    Click Banner Group Management
    :FOR    ${index}    IN RANGE    0    ${maximum_banner_groups}
    \       Run Keyword If    ${index}==13    Verify The Add Banner Group Button Enable
    \       Click Add Banner Group
    \       Input Text Banner Group Th              ${textTest2}
    \       Input Text Banner Group En              ${textTest2}
    \       Click Submit Banner
    Verify The Add Banner Group Button Disable

*** Keyword ***
Prepare Data Megamenu And Open Browser
    Open Brower AND Go To Manage Mega Menu
    Go To    ${PORTAL-HOST}
    Select Mega Menu Page
    Create Mega Menu Level1    ${namelvl1_th}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Click All Draft Mega Menu

Delete Mega Menu Level1 AND Close Browser
    [Arguments]    ${namelvl1_th}
    Go To    ${PORTAL-HOST}
    Wait Until Angular Ready    30s
    Select Mega Menu Page
    Click Delete Mega Menu Level1    ${namelvl1_th}
    Click All Draft Mega Menu
    Click All Publish Mega Menu
    Close All Browsers
