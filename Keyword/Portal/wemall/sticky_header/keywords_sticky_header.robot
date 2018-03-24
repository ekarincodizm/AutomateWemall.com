*** Settings ***
Resource            ${CURDIR}/webelement_sticky_header.robot
Resource            ${CURDIR}/../header/webelement_wemall_header.robot
Resource            ${CURDIR}/../footer/webelement_wemall_footer.robot
Library             ${CURDIR}/../../../../Python_Library/common/web_element_library.py
Resource            ${CURDIR}/../keywords_common_for_wemall.robot

*** Variables ***
${sticky_wm_logo_image_path}    http://cdn.wemall-dev.com/th/wemall/wemall/logo-wemall-portal-sticky@x.png?v=c507d2d5
${sticky_wow_logo_img_path}    http://cdn.wemall-dev.com/th/wemall/wemall/everyday-wow-sticky.png?v=dea312b5

*** Keywords ***
Open Browser and Go to Specific URL
    [Arguments]    ${full_url}
    Open Browser    ${full_url}   ${BROWSER}    None
    Set Window Position    ${0}    ${0}
    Set Window Size    ${1440}    ${900}
    # Maximize Browser Window

Click Sticky WeMall Logo
    Click Then If Failed Wait and Click Again    ${sticky_wm_logo}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${wm_logo_img}

Click Sticky WoW Logo
    Click Then If Failed Wait and Click Again    ${sticky_wow_logo}
    Not Visible Then If Failed Wait and Check Is Visible Again    jquery=#superdeal

Click Sticky Search Button
    Click Then If Failed Wait and Click Again    ${sticky_search_button}

Search Product on Sticky Header
    [Arguments]    ${search_text}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_suggestion_box}
    Input Text    ${sticky_suggestion_box}    ${search_text}
    Click Sticky Search Button

Click Sticky Cart Box Button
    Click Then If Failed Wait and Click Again    ${sticky_cart_icon}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${cart_light_box}
    Wait Until Page Does Not Contain Element    ${cart_light_box}:contains("กำลังโหลดรายการ...")    30s

Verify Sticky WeMall Logo
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_wm_logo}
    ${src_wm_logo_img}    Selenium2Library.Get Element Attribute    ${sticky_wm_logo}@src
    ${sticky_wm_logo_image_path}=    Replace String    ${sticky_wm_logo_image_path}    http    ${protocol}
    Should Be Equal As Strings    ${src_wm_logo_img}    ${sticky_wm_logo_image_path}

Verify Sticky WoW Logo
    [Arguments]    ${protocol}
    Capture Page Screenshot
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_wow_logo}
    ${src_wow_logo_img}    Selenium2Library.Get Element Attribute    ${sticky_wow_logo} img@src
    ${sticky_wow_logo_img_path}=    Replace String    ${sticky_wow_logo_img_path}    http    ${protocol}
    Should Be Equal As Strings    ${src_wow_logo_img}    ${sticky_wow_logo_img_path}

Verify Search Box and Search Icon Exist
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_search_box}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_search_button}

Verify Autosuggestion on Sticky
    [Arguments]    ${search_text}
    Input Text    ${sticky_search_box}    ${search_text}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_suggestion_box}

Check Sticky Cart Badge Quantity
    [Arguments]    ${cart_quantity}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${sticky_cart_icon}
    Wait Until Page Contains Element    ${sticky_cart_quantity_badge}[data-noti-number="${cart_quantity}"]    20s

Scroll Page To Element
    [Arguments]    ${server}    ${element}
    Run Keyword If    '${server}' == 'wm'    Scroll Page To Element For WeMall    ${element}
    Run Keyword If    '${server}' == 'itm'    Scroll Page To Element For iTM    ${element}

Scroll Page To Element For iTM
    [Arguments]    ${point_element}
    ${element}=    Get Webelement    ${point_element}
    Scroll To Element    ${element}    0    0

Sticky Header Should Not Show
    Page Should Not Contain Element    ${wm_sticky_header}.sticky-header.portal.active

Sticky Header Should Show
    Page Should Contain Element    ${wm_sticky_header}.sticky-header.portal.active

Back To Top Button Not Show
    [Arguments]    ${server}
    Run Keyword If    '${server}' == 'wm'    Page Should Not Contain Element    ${back_to_top_button}.btn-back-to-top.icon-arrow-up.active
    Run Keyword If    '${server}' == 'itm'    Wait Until Element Is Not Visible    ${itm_back_to_top_button}    15s

Back To Top Button Show
    [Arguments]    ${server}
    Run Keyword If    '${server}' == 'wm'    Page Should Contain Element    ${back_to_top_button}.btn-back-to-top.icon-arrow-up.active
    Run Keyword If    '${server}' == 'itm'    Wait Until Element Is Visible    ${itm_back_to_top_button}    15s

Scroll Page To Footer
    [Arguments]    ${server}
    Run Keyword If    '${server}' == 'wm'    Scroll Page To Element For WeMall    ${element_footer}
    Run Keyword If    '${server}' == 'itm'    Scroll Page To Element For iTM    ${iwm_footer_id}

Scroll Page To Header
    [Arguments]    ${server}
    Run Keyword If    '${server}' == 'wm'    Scroll Page To Element For WeMall    ${element_header}
    Run Keyword If    '${server}' == 'itm'    Scroll Page To Element For iTM    ${wm_header}



