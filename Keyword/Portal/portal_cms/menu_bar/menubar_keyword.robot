*** Settings ***
Resource            ${CURDIR}/../../../Portal/portal_cms/menu_bar/web_element_menu_bar.robot
Resource            ${CURDIR}/../../../Portal/wemall/wemall_portal/portal_page_keywords.robot
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Keywords ***
Open Brower AND Go To Manage Menu Bar
    Open Browser     ${PORTAL-HOST}    chrome
    Wait Until Angular Ready    30s
    Go To Manage Menu Bar

Go To Manage Menu Bar
    # Wait Until Element Is Visible      ${manage_portal_dropdown}
    # Click Element and Wait Angular Ready    ${manage_portal_dropdown}
    # Click Element and Wait Angular Ready    ${submenu_menu_bar}
    Go To                       ${PORTAL-HOST}/#/menubar
    Wait Until Angular Ready    30s

Submit Menu Bar Web
    Click Element and Wait Angular Ready     ${ok_button}

Click Save Menu Bar Web
    Click Element and Wait Angular Ready      ${save_btn}

Publish Menu Bar Web
    Click Element and Wait Angular Ready      ${publish_btn}

Confirm Delete Web
    Click Element and Wait Angular Ready      ${confirm_delete}

Click Delete Menu Bar Web
    [Arguments]         ${remove_target_btn}
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains("${remove_target_btn}") div.item-tools a.item-tools--remove:eq(0)

Add Menu Bar Web
    [Arguments]  ${name_th_1}     ${link_th_1}     ${name_en_1}      ${link_en_1}
    Wait Until Element Is Visible    ${add_menu_bar_web}    5s
    Click Element and Wait Angular Ready     ${add_menu_bar_web}
    Input Text        ${name_th}        ${name_th_1}
    Input Text        ${link_th}        ${link_th_1}
    Input Text        ${name_en}        ${name_en_1}
    Input Text        ${link_en}        ${link_en_1}
    Extended Select Checkbox      ${checkbox_open_new_tab}

Verify Menu Bar Preview Mode Web
    [Arguments]    ${target_draft_th}    ${target_draft_en}
    Go To     ${WEMALL_WEB}/?preview=678e45fa792c0a865d0eaee1b19e834d
    Page Should Contain Element     jquery=li a:contains("${target_draft_th}"):eq(0)
    Click Element and Wait Angular Ready              ${dropdown_lang}
    Click Element and Wait Angular Ready              ${en_btn}
    Wait Until Angular Ready    30s
    Page Should Contain Element     jquery=li a:contains("${target_draft_en}"):eq(0)

Update Data Menu Bar Web
    [Arguments]  ${edit_target_btn}     ${name_th_2}     ${link_th_2}     ${name_en_2}      ${link_en_2}
    sleep    3s
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains("${edit_target_btn}") div.item-tools a.item-tools--edit:eq(0)
    Input Text        ${name_th}        ${name_th_2}
    Input Text        ${link_th}        ${link_th_2}
    Input Text        ${name_en}        ${name_en_2}
    Input Text        ${link_en}        ${link_en_2}
    Extended Select Checkbox      ${checkbox_open_new_tab}

Verify Menu Bar Publish Web
    [Arguments]     ${target_publish_th}    ${target_publish_en}
    Go To     ${WEMALL_WEB}
    Page Should Contain Element     jquery=li a:contains("${target_publish_th}"):eq(0)
    Click Element and Wait Angular Ready              ${dropdown_lang}
    Click Element and Wait Angular Ready              ${en_btn}
    Wait Until Angular Ready    30s
    Page Should Contain Element     jquery=li a:contains("${target_publish_en}"):eq(0)


#   Mobile

Submit Menu Bar Mobile
    Click Element and Wait Angular Ready     ${ok_button}

Click Save Menu Bar Mobile
    Click Element and Wait Angular Ready      ${save_btn_mobile}

Publish Menu Bar Mobile
    Click Element and Wait Angular Ready      ${publish_btn_mobile}

Confirm Delete Mobile
    Click Element and Wait Angular Ready      ${confirm_delete}

Click Delete Menu Bar Mobile
    [Arguments]         ${remove_target_btn}
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains("${remove_target_btn}") div.item-tools a.item-tools--remove:eq(0)

Add Menu Bar Mobile
    [Arguments]  ${name_th_1}     ${link_th_1}     ${name_en_1}      ${link_en_1}
    Click Element and Wait Angular Ready     ${add_menu_bar_mobile}
    Input Text        ${name_th}        ${name_th_1}
    Input Text        ${link_th}        ${link_th_1}
    Input Text        ${name_en}        ${name_en_1}
    Input Text        ${link_en}        ${link_en_1}
    Extended Select Checkbox      ${checkbox_open_new_tab}

Verify Menu Bar Preview Mode Mobile
    [Arguments]    ${target_draft_th}    ${target_draft_en}
    Go To     ${WEMALL_WEB}/portal/page1?preview=678e45fa792c0a865d0eaee1b19e834d&is_mobile=1
    Add Cookie                          is_mobile       true
    Reload Page
    Wait Until Angular Ready    30s
    Page Should Contain Element     jquery=li a:contains("${target_draft_th}"):eq(0)
    Go To     ${WEMALL_WEB}/en/portal/page1?preview=678e45fa792c0a865d0eaee1b19e834d&is_mobile=1
    Add Cookie                          is_mobile       true
    Reload Page
    Wait Until Angular Ready    30s
    Page Should Contain Element     jquery=li a:contains("${target_draft_en}"):eq(0)

Update Data Menu Bar Mobile
    [Arguments]  ${edit_target_btn}     ${name_th_2}     ${link_th_2}     ${name_en_2}      ${link_en_2}
    sleep    3s
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains("${edit_target_btn}") div.item-tools a.item-tools--edit:eq(0)
    Input Text        ${name_th}        ${name_th_2}
    Input Text        ${link_th}        ${link_th_2}
    Input Text        ${name_en}        ${name_en_2}
    Input Text        ${link_en}        ${link_en_2}
    Extended Select Checkbox      ${checkbox_open_new_tab}

Verify Menu Bar Publish Mobile
    [Arguments]     ${target_publish_th}    ${target_publish_en}
    Go To     ${WEMALL_WEB}/portal/page1
    Add Cookie                          is_mobile       true
    Reload Page
    Wait Until Angular Ready    30s
    Page Should Contain Element     jquery=li a:contains("${target_publish_th}"):eq(0)
    Go To     ${WEMALL_WEB}/en/portal/page1
    Add Cookie                          is_mobile       true
    Reload Page
    Wait Until Angular Ready    30s
    Page Should Contain Element     jquery=li a:contains("${target_publish_en}"):eq(0)