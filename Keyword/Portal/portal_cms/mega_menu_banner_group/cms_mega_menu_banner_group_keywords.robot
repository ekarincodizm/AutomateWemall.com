*** Settings ***
Resource            ${CURDIR}/../mega_menu/webelement_mega_menu_page.robot
Resource            ${CURDIR}/../../../API/api_portals/megamenus_keywords.robot
Library             ${CURDIR}/../../../../Python_Library/cdnUrlGenerator.py
Library             Collections
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Keywords ***
Open Brower AND Go To Manage Mega Menu
    Open Browser    ${PORTAL-HOST}/#/mega-menu    ${BROWSER}
    Wait Until Angular Ready    30s
    Set Window Position    ${0}    ${0}
    Set Window Size    ${1440}    ${900}

Click Lv1 Mega Menu
    Wait Until Element Is Visible    ${mega_menulvl1}:last
    Click Element and Wait Angular Ready   ${mega_menulvl1}:last

Click Banner Group Management
    Wait Until Element Is Visible    ${banner_group_management}
    Click Element and Wait Angular Ready   ${banner_group_management}

Click Add Banner Group
    Wait Until Element Is Visible    ${button_add_banner_group}
    Click Element and Wait Angular Ready   ${button_add_banner_group}

Input Text Banner Group Th
    [Arguments]     ${textTh}
    Input Text    ${input_banner_group_th}    ${textTh}

Input Text Banner Group En
    [Arguments]     ${textEn}
    Input Text    ${input_banner_group_en}    ${textEn}

Click Submit Banner
    Wait Until Element Is Visible    ${button_submit_banner}
    Click Element and Wait Angular Ready     ${button_submit_banner}

Click Delete First Banner
    Wait Until Element Is Visible    ${button_delete_first_banner}
    Click Element and Wait Angular Ready     ${button_delete_first_banner}

Click Delete Last Banner
    Wait Until Element Is Visible    ${button_delete_last_banner}
    Click Element and Wait Angular Ready     ${button_delete_last_banner}

Click Submit Delete
    Wait Until Element Is Visible    ${button_submit_remove_banner}    5s
    Click Element and Wait Angular Ready    ${button_submit_remove_banner}

Click Save Banner Group
    Wait Until Element Is Visible    ${button_save_banner_group}
    Click Element and Wait Angular Ready    ${button_save_banner_group}

Click Preview Button
    Click Element and Wait Angular Ready     ${button_preview}

Click Edit Banner Content
    [Arguments]       ${position}=0
    Click Element and Wait Angular Ready     ${button_edit_detail}:eq(${position})

Click Change Language
    [Arguments]    ${lang}
    Click Element and Wait Angular Ready     ${btn_lang_menu}
    Run Keyword if    '${lang}'=='th'    Click Element and Wait Angular Ready     ${btn_lang_th}
    Run Keyword if    '${lang}'=='en'    Click Element and Wait Angular Ready     ${btn_lang_en}

Click Manage Mega Menu Page
    Click Element and Wait Angular Ready    ${btn_mega_menu}

Click Preview Mega Menu Page
    Click Element and Wait Angular Ready    ${btn_mega_menu_preview}

Click Publish Mega Menu
    Click Element and Wait Angular Ready    ${btn_mega_menu_publish}

Get Banner List From UI
    ${banner_list_from_ui}=    Create List
    ${elements}=        Get WebElements      ${banner_list}
    ${length}=          Get Length       ${elements}
    Log         ${length}
    :FOR    ${index}    IN RANGE    ${length}
    \       ${banner_text}=     Get Text                ${banner_list}:eq(${index})
    \       Append To List     ${banner_list_from_ui}      ${banner_text}
    [Return]        ${banner_list_from_ui}

Get Banner List From API
    [Arguments]         ${parent_id}
    GET Mega Menu Data Filter Version    portal    draft
    ${megamenu_data}=                Get Response Body
    ${data_dict}=    Convert json to Dict    ${megamenu_data}
    ${data}=        Get From Dictionary     ${data_dict}     data
    ${data}=        Get From Dictionary     ${data}          1
    ${data}=        Get From Dictionary     ${data}          child
    ${data}=        Get From Dictionary     ${data}          ${parent_id}
    ${data}=        Get From Dictionary     ${data}          showroom
    ${data}=        Get From Dictionary     ${data}          child
    Log Dictionary      ${data}
    [Return]       ${data}

Get Banner Version From API
    [Arguments]         ${parent_id}
    GET Mega Menu Data Filter Version    portal    draft
    ${megamenu_data}=                Get Response Body
    ${data_dict}=    Convert json to Dict    ${megamenu_data}
    ${data}=        Get From Dictionary     ${data_dict}     data
    ${data}=        Get From Dictionary     ${data}          1
    ${version}=        Get From Dictionary     ${data}          version
    Log Dictionary      ${data}
    [Return]       ${version}

Add Banner Content
    [Arguments]    ${imgPath1}     ${imgPath2}    ${imgPath3}     ${parent_banner}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(0)
    Input Text              ${input_text_banner_th}             banner1Th
    Input Text              ${input_text_banner_link_th}        banner1linkTh
    Input Text              ${input_text_banner_en}             banner1En
    Input Text              ${input_text_banner_link_en}        banner1linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath1}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath1}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath1}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath1}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(1)
    Input Text              ${input_text_banner_th}             banner2Th
    Input Text              ${input_text_banner_link_th}        banner2linkTh
    Input Text              ${input_text_banner_en}             banner2En
    Input Text              ${input_text_banner_link_en}        banner2linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath2}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath2}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath2}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath2}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(2)
    Input Text              ${input_text_banner_th}             banner3Th
    Input Text              ${input_text_banner_link_th}        banner3linkTh
    Input Text              ${input_text_banner_en}             banner3En
    Input Text              ${input_text_banner_link_en}        banner3linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath3}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath3}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath3}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath3}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}

Add Banner Content Mobile And Web EN/TH
    [Arguments]    ${imgPath1_WEBTH}     ${imgPath2_WEBTH}    ${imgPath3_WEBTH}    ${imgPath1_WEBEN}     ${imgPath2_WEBEN}    ${imgPath3_WEBEN}    ${imgPath1_MOBILETH}     ${imgPath2_MOBILETH}    ${imgPath3_MOBILETH}    ${imgPath1_MOBILEEN}     ${imgPath2_MOBILEEN}    ${imgPath3_MOBILEEN}     ${parent_banner}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(0)
    Input Text              ${input_text_banner_th}             banner1Th
    Input Text              ${input_text_banner_link_th}        banner1linkTh
    Input Text              ${input_text_banner_en}             banner1En
    Input Text              ${input_text_banner_link_en}        banner1linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath1_WEBTH}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath1_MOBILETH}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath1_WEBEN}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath1_MOBILEEN}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(1)
    Input Text              ${input_text_banner_th}             banner2Th
    Input Text              ${input_text_banner_link_th}        banner2linkTh
    Input Text              ${input_text_banner_en}             banner2En
    Input Text              ${input_text_banner_link_en}        banner2linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath2_WEBTH}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath2_MOBILETH}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath2_WEBEN}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath2_MOBILEEN}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(2)
    Input Text              ${input_text_banner_th}             banner3Th
    Input Text              ${input_text_banner_link_th}        banner3linkTh
    Input Text              ${input_text_banner_en}             banner3En
    Input Text              ${input_text_banner_link_en}        banner3linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath3_WEBTH}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath3_MOBILETH}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath3_WEBEN}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath3_MOBILEEN}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}

Add Banner Content Web and Mobile
    [Arguments]    ${imgPath1Web}     ${imgPath2Web}    ${imgPath3Web}     ${imgPath1Mobile}     ${imgPath2Mobile}    ${imgPath3Mobile}     ${parent_banner}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(0)
    Input Text              ${input_text_banner_th}             banner1Th
    Input Text              ${input_text_banner_link_th}        banner1linkTh
    Input Text              ${input_text_banner_en}             banner1En
    Input Text              ${input_text_banner_link_en}        banner1linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath1Web}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath1Mobile}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath1Web}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath1Mobile}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(1)
    Input Text              ${input_text_banner_th}             banner2Th
    Input Text              ${input_text_banner_link_th}        banner2linkTh
    Input Text              ${input_text_banner_en}             banner2En
    Input Text              ${input_text_banner_link_en}        banner2linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath2Web}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath2Mobile}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath2Web}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath2Mobile}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${parent_banner}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(2)
    Input Text              ${input_text_banner_th}             banner3Th
    Input Text              ${input_text_banner_link_th}        banner3linkTh
    Input Text              ${input_text_banner_en}             banner3En
    Input Text              ${input_text_banner_link_en}        banner3linkEn
    Upload Pic Banner    ${file_input}:eq(0)    ${imgPath3Web}
    Upload Pic Banner    ${file_input}:eq(1)    ${imgPath3Mobile}
    Upload Pic Banner    ${file_input}:eq(2)    ${imgPath3Web}
    Upload Pic Banner    ${file_input}:eq(3)    ${imgPath3Mobile}
    Sleep           4s
    Click Element and Wait Angular Ready           ${button_save_banner_detail}

Upload Pic Banner
    [Arguments]     ${file_input}          ${imgPath}
    ${canonicalPath}=    Get Canonical Path    ${imgPath}
    Log             ${canonicalPath}
    Log             ${imgPath}
    Choose File             ${file_input}          ${canonicalPath}
    Wait Until Angular Ready    30s

Verify CDN Path With Expected Path
    [Arguments]     ${imgElementId}     ${expectedPath}     ${fileFullPath}
    ${cdn_path}     Selenium2Library.Get Element Attribute       ${imgElementId}@src
    Log             ${cdn_path}
    Log             ${expectedPath}
    Log             ${fileFullPath}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expectedPath}    ${fileFullPath}
    Should Be Equal As Strings    ${cdn_path}    ${expected_cdn_url_with_md5}    CDN URL not matched

Verify CDN Path With Portal API
    [Arguments]     ${imgElementId}     ${menuPortal}     ${bannerPosition}     ${srcNodeName}      ${megaMenuId}       ${showroomPosition}
    GET Mega Menu Child Data        ${menuPortal}
    ${response_body}=      Get Response Body

    ${imagePath}=    Get Json Value    ${response_body}    /data/data/th_TH/child/${megaMenuId}/showroom/child/${showroomPosition}/banners/${bannerPosition}/${srcNodeName}
    ${imagePath}=    Replace String    ${imagePath}    "    ${EMPTY}
    ${cdn_path}     Selenium2Library.Get Element Attribute       ${imgElementId}@src
    Should Be Equal As Strings    ${cdn_path}       http:${imagePath}    CDN URL not matched

Verify Banner Data Required Field
    [Arguments]             ${textTest2}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${textTest2}")
    Click Element and Wait Angular Ready           ${button_create_banner_content}:eq(0)
    Click Element and Wait Angular Ready           ${button_save_banner_detail}
    Element Should Be Visible               ${alert_label_text}:eq(0)
    Element Should Be Visible              ${alert_label_text}:eq(1)
    Element Should Be Visible              ${alert_label_text}:eq(2)
    Element Should Be Visible              ${alert_label_text}:eq(3)
    Element Should Be Visible              ${alert_label_img}:eq(0)
    Element Should Be Visible              ${alert_label_img}:eq(1)
    Element Should Be Visible              ${alert_label_img}:eq(2)
    Element Should Be Visible              ${alert_label_img}:eq(3)

Verify Banner Data Detail
    [Arguments]         ${position}
    Click Element and Wait Angular Ready                ${banner_item}:contains("${bannerTest2}")
    Click Element and Wait Angular Ready                ${button_remove_banner_data}:eq(${position})
    Click Element and Wait Angular Ready                ${button_confirm_remove_banner_data}
    Element Should Be Visible           ${button_create_banner_content}:eq(${position})

Verify The Add Banner Group Button Disable
    Wait Until Element Is Visible      ${button_add_banner_group_disable}

Verify The Add Banner Group Button Enable
    Wait Until Element Is Visible      ${button_add_banner_group}

Select Status Banner Group
    [Arguments]    ${name}
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}) label

Click Delete Banner Group
    [Arguments]    ${name}
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}) [data-id='delete-menu']
    Click Element and Wait Angular Ready    jquery=button:contains(Remove)

Click Edit Banner Group
    [Arguments]    ${name}    ${text_th}    ${text_en}
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}) [data-id='edit-menu']
    Input Text Banner Group Th              ${text_th}
    Input Text Banner Group En              ${text_en}
    Click Submit Banner