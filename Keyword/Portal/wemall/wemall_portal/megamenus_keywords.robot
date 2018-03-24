*** Settings ***
Library             ${CURDIR}/../../../../Python_Library/jsonLibrary.py
Resource            ${CURDIR}/../../../../Keyword/API/common/api_keywords.robot
Resource            ${CURDIR}/../../../../Keyword/Portal/wemall/wemall_portal/webelement_portal_page.robot
Library             ${CURDIR}/../../../../Python_Library/common.py
Library             OperatingSystem
Library             Collections
Library             HttpLibrary.HTTP
Resource            ${CURDIR}/../../../../Keyword/API/api_portals/megamenus_keywords.robot
Library             ${CURDIR}/../../../../Keyword/API/api_portals/megamenus_keywords.py
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Variables ***
${DRAFT}                draft
${PUBLISHED}            published
${megamenu_moblie}      jquery=h3.lb-section-title.ng-binding.ng-scope
#$("h3.lb-section-title.ng-binding.ng-scope:eq(0):contains('อิเล็กทรอนิกส์')")
*** Keywords ***
Verify Mega Menu
    #       ${menu_id}=portal    ${lang}=en_US , th_TH    ${check_lv2}=check 1      ${check_showroom}= 1,check & 0 uncheck   ${version}= draft , pubolshed
    [Arguments]     ${menu_id}      ${lang}     ${check_lv2}     ${check_showroom}=0    ${version}=published
    Get Mega Menu Child Data Filter Version    ${menu_id}    ${version}
    ${body}=            Get Response Body
    ${data_dict}=    Convert json to Dict    ${body}
    GET Mega Menu Data Filter Version        ${menu_id}    ${version}
    ${raw_menu_body}=    Get Response Body
    ${raw_menu_dict}=    Convert json to Dict    ${raw_menu_body}
    ${raw_menu_dict}=    Get From Dictionary     ${raw_menu_dict}    data
    ${data}=        Get From Dictionary     ${data_dict}    data
    ${data}=        Get From Dictionary     ${data}     data
    ${data}=        Get From Dictionary     ${data}      ${lang}
    ${child_lv1}=       Get From Dictionary     ${data}     child
    ${menu_list}=       Convert child to list       ${child_lv1}
    ${total_items}=     Get Length    ${menu_list}
    :FOR    ${index}    IN RANGE    ${total_items}
    \       ${menu}=     Get From List       ${menu_list}      ${index}
    \       ${link_url}=     Get From Dictionary     ${menu}     link_url
    \       ${label}=        Get From Dictionary     ${menu}     label
    \       Element Should Be Visible       ${mega-menu-list-lv1}:eq(${index})[href=\"${link_url}\"]
    \       Element Should Be Visible       ${mega-menu-list-lv1}:eq(${index}) > span:contains('${label}')
    \       Run Keyword If      ${check_showroom}==1     Verify Showroom Banner        ${index}    ${menu}      ${raw_menu_dict}

Verify Mega Menu Mobile
    #       ${menu_id}=portal    ${lang}=en_US , th_TH    ${check_lv2}=check 1      ${check_showroom}= 1,check & 0 uncheck   ${version}= draft , pubolshed
    [Arguments]     ${menu_id}      ${lang}    ${mode}=0    ${check_showroom}=0    ${version}=published
    Get Mega Menu Child Data Filter Version    ${menu_id}    ${version}
    ${body}=            Get Response Body
    ${data_dict}=    Convert json to Dict    ${body}
    GET Mega Menu Data Filter Version        ${menu_id}    ${version}
    ${raw_menu_body}=    Get Response Body
    ${raw_menu_dict}=    Convert json to Dict    ${raw_menu_body}
    ${raw_menu_dict}=    Get From Dictionary     ${raw_menu_dict}    data
    ${data}=        Get From Dictionary     ${data_dict}    data
    ${data}=        Get From Dictionary     ${data}     data
    ${data}=        Get From Dictionary     ${data}      ${lang}
    ${child_lv1}=       Get From Dictionary     ${data}     child
    ${menu_list}=       Convert child to list       ${child_lv1}
    ${total_items}=     Get Length    ${menu_list}
    :FOR    ${index}    IN RANGE    ${total_items}
    \       ${menu}=     Get From List       ${menu_list}      ${index}
    \       ${label}=        Get From Dictionary     ${menu}     label
    \       Run Keyword If     ${index}==1    Go To Promotion Page Mobile Version    ${mode}    ${lang}
    \       ${res}=    Evaluate    ${index}-1
    \       Run Keyword If     ${index}!=0    Element Should Be Visible       ${megamenu_moblie}:eq(${res}):contains('${label}')
    # \       Run Keyword If      ${check_lv2}==1     Verify Mega Menu Level 2 Data      ${index}    ${menu}
    \       Run Keyword If      ${check_showroom}==1     Verify Showroom Banner Mobile        ${index}    ${menu}      ${raw_menu_dict}

Go To Promotion Page Mobile Version
    [Arguments]    ${mode}    ${lang}
    Run Keyword If     '${mode}'=='0' and '${lang}'=='th_TH'    Go To    ${WEMALL_WEB}/portal/page0
    Run Keyword If     '${mode}'=='0' and '${lang}'=='en_US'    Go To    ${WEMALL_WEB}/en/portal/page0
    Run Keyword If     '${mode}'=='1' and '${lang}'=='th_TH'        Go To    ${WEMALL_WEB}/portal/page0?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Run Keyword If     '${mode}'=='1' and '${lang}'=='en_US'        Go To    ${WEMALL_WEB}/en/portal/page0?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}

# Verify Mega Menu

Verify Mega Menu Level 2 Data
    [Arguments]     ${menu_index_lv1}      ${menu}
    ${menu_index_lv1}=      Convert To Integer      ${menu_index_lv1}
    ${menu_index}=      Evaluate    ${menu_index_lv1}+1
    Mouse Over Menu     ${menu_index}
    ${child}=       Get From Dictionary     ${menu}     child
    ${menu_list}=       Convert child to list       ${child}
    ${total_items}=     Get Length    ${menu_list}
    :FOR    ${index}    IN RANGE    ${total_items}
    \       ${menu_lv2}=        Get From List           ${menu_list}      ${index}
    \       ${menu_type}=       Get From Dictionary     ${menu_lv2}     type
    \       ${label}=           Get From Dictionary     ${menu_lv2}     label
    \       Run Keyword If      '${menu_type}'=='link'       Verify Menu Lv2 Link        ${menu_index_lv1}      ${index}    ${menu_lv2}
    \       Run Keyword If      '${menu_type}'=='header'     Verify Menu Lv2 Header      ${menu_index_lv1}      ${index}    ${menu_lv2}

Verify Menu Lv2 Link
    [Arguments]     ${menu_index_lv1}       ${index}    ${menu_lv2}
    ${link_url}=    Get From Dictionary     ${menu_lv2}     link_url
    ${label}=       Get From Dictionary     ${menu_lv2}     label
    #${lv2_index}=      Evaluate    ${index}+1
    Element Should Be Visible       ${mega-menu-list-lv2}:eq(${index}) a[href=\"${link_url}\"]
    Element Should Be Visible       ${mega-menu-list-lv2}:eq(${index}) a:contains(\"${label}\")

Verify Menu Lv2 Header
    [Arguments]     ${menu_index_lv1}       ${index}    ${menu_lv2}
    ${label}=       Get From Dictionary     ${menu_lv2}     label
    #${lv2_index}=      Evaluate    ${index}+1
    Element Should Be Visible       ${mega-menu-list-lv2}:eq(${index}) p:contains(\"${label}\")

Verify Mega Menu Level 1
    [Arguments]     ${menu_id}      ${lang}
    Verify Mega Menu       ${menu_id}      ${lang}     0

Verify Mega Menu Level 2
    [Arguments]     ${menu_id}      ${lang}
    Verify Mega Menu       ${menu_id}      ${lang}     1

Verify Showroom Banner On Mega Menu
    [Arguments]     ${menu_id}      ${lang}
    Verify Mega Menu       ${menu_id}      ${lang}     0        1

Verify Showroom Banner Mobile
    [Arguments]     ${index}    ${menu}     ${raw_menu_dict}
    ${menu_index}=      Convert To Integer      ${index}
    ${menu_index}=      Evaluate    ${menu_index}+1
    ${menu_id}=         Get From Dictionary    ${menu}     id
    ${raw_menu_dict}    Get From Dictionary     ${raw_menu_dict}    1
    ${raw_menu_child}   Get From Dictionary     ${raw_menu_dict}    child
    ${raw_menu_data}    Get From Dictionary     ${raw_menu_child}    ${menu_id}
    ${showroom}         Get From Dictionary     ${raw_menu_data}     showroom
    ${template}         Get From Dictionary     ${showroom}     template
    ${display_mode}     Get From Dictionary     ${template}     display_mode
    ${showroom_data}    Get From Dictionary     ${menu}     showroom
    Run Key Word If     '${display_mode}' == 'carousel'     Verify Carousel Template Showroom Banner With API Data Mobile      ${menu_index}    ${showroom_data}
    Run Key Word If     '${display_mode}' == 'fix'          Verify Fix Template Showroom Banner With API Data Mobile           ${menu_index}    ${showroom_data}

Verify Showroom Banner
    [Arguments]     ${index}    ${menu}     ${raw_menu_dict}
    ${menu_index}=      Convert To Integer      ${index}
    ${menu_index}=      Evaluate    ${menu_index}+1
    Mouse Over Menu     ${menu_index}
    ${menu_id}=         Get From Dictionary    ${menu}     id
    ${raw_menu_dict}    Get From Dictionary     ${raw_menu_dict}    1
    ${raw_menu_child}   Get From Dictionary     ${raw_menu_dict}    child
    ${raw_menu_data}    Get From Dictionary     ${raw_menu_child}    ${menu_id}
    ${showroom}         Get From Dictionary     ${raw_menu_data}     showroom
    ${template}         Get From Dictionary     ${showroom}     template
    ${display_mode}     Get From Dictionary     ${template}     display_mode
    ${showroom_data}    Get From Dictionary     ${menu}     showroom
    Run Key Word If     '${display_mode}' == 'carousel'     Verify Carousel Template Showroom Banner With API Data      ${menu_index}    ${showroom_data}
    Run Key Word If     '${display_mode}' == 'fix'          Verify Fix Template Showroom Banner With API Data           ${menu_index}    ${showroom_data}

Verify Carousel Template Showroom Banner With API Data
    [Arguments]     ${menu_index}    ${showroom_data}
    ${showroom_child}     Get From Dictionary     ${showroom_data}    child
    ${showroom_list}=       Convert child to list       ${showroom_child}
    ${total_items}=         Get Length    ${showroom_list}
    :FOR    ${show_room_index}    IN RANGE    ${total_items}
    \       ${data}=      Get From List             ${showroom_list}      ${show_room_index}
    \       ${banner_status}=   Get From Dictionary     ${data}       status
    \       ${banners}=     Get From Dictionary            ${data}      banners
    \       Run Keyword if    '${banner_status}' == 'active'
    \       ...    Verify Banner with Range    ${banners}       ${menu_index}

Verify Banner with Range
    [Arguments]    ${banners}        ${menu_index}
    ${banner_length}=    Get Length    ${banners}
    ${banners_list}=    Get Dictionary Keys    ${banners}
    ${total_items}=         Get Length    ${banners_list}
    :FOR    ${banners_index}    IN RANGE    ${total_items}
    \       ${index}=      Get From List             ${banners_list}      ${banners_index}
    \       ${banner}=      Get From Dictionary    ${banners}    ${index}
    \       ${banner_count}=    Get Length    ${banner}
    \       Continue For Loop If    ${banner_count} == 0
    \       ${banner_image}=    Get From Dictionary     ${banner}       src_web
    \       ${banner_link}=     Get From Dictionary     ${banner}       link_url
    \       Run Keyword if    '${index}'=='1'    Verify Carousel Banner     ${menu_index}       ${index}       ${banner_image}        ${banner_link}        0
    \       Run Keyword if    '${index}'!='1'    Verify Fix Banner          ${menu_index}       ${index}       ${banner_image}        ${banner_link}        0

### Mobile ###

Verify Carousel Template Showroom Banner With API Data Mobile
    [Arguments]     ${menu_index}    ${showroom_data}
    ${showroom_child}     Get From Dictionary     ${showroom_data}    child
    ${showroom_list}=       Convert child to list       ${showroom_child}
    ${total_items}=         Get Length    ${showroom_list}
    :FOR    ${show_room_index}    IN RANGE    ${total_items}
    \       ${data}=      Get From List             ${showroom_list}      ${show_room_index}
    \       ${banner_status}=   Get From Dictionary     ${data}       status
    \       ${banners}=     Get From Dictionary            ${data}      banners
    \       Run Keyword if    '${banner_status}' == 'active'
    \       ...    Verify Banner with Range Mobile   ${banners}       ${menu_index}

Verify Banner with Range Mobile
    [Arguments]    ${banners}        ${menu_index}
    ${banner_length}=    Get Length    ${banners}
    ${banners_list}=    Get Dictionary Keys    ${banners}
    ${total_items}=         Get Length    ${banners_list}
    :FOR    ${banners_index}    IN RANGE    ${total_items}
    \       ${index}=      Get From List             ${banners_list}      ${banners_index}
    \       ${banner}=      Get From Dictionary    ${banners}    ${index}
    \       ${banner_count}=    Get Length    ${banner}
    \       Continue For Loop If    ${banner_count} == 0
    \       ${banner_image}=    Get From Dictionary     ${banner}       src_mobile
    \       ${banner_link}=     Get From Dictionary     ${banner}       link_url
    \       Run Keyword if    '${index}'=='1'    Verify Carousel Banner Mobile     ${menu_index}       ${index}       ${banner_image}        ${banner_link}        0
    \       Run Keyword if    '${index}'!='1'    Verify Fix Banner Mobile          ${menu_index}       ${index}       ${banner_image}        ${banner_link}        0

Verify Fix Banner Mobile
    [Arguments]     ${menu_index}       ${position}       ${banner_image}        ${banner_link}     ${visible_check}
    ${menu_index}=      Convert To Integer      ${menu_index}
    ${menu_index}=      Evaluate    ${menu_index}-1
    ${elm}=     Set Variable If
    ...         ${OWL_CAROSEL_VERSION}==1     .owl-item
    ...         ${OWL_CAROSEL_VERSION}==2     .owl-item.active
    Wait Until Angular Ready    30s
    Page Should Contain Image       ${mega-menu-mobile} ${elm} a img       ${banner_image}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} a > img[src="${banner_image}"]
    Page Should Contain Link        ${mega-menu-mobile} ${elm} a     ${banner_link}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} a[href="${banner_link}"]

Verify Carousel Banner Mobile
    [Arguments]     ${menu_index}       ${position}       ${banner_image}        ${banner_link}     ${visible_check}
    ${menu_index}=      Convert To Integer      ${menu_index}
    ${menu_index}=      Evaluate    ${menu_index}-1
    Wait Until Angular Ready    30s
    ${elm}=     Set Variable If
    ...         ${OWL_CAROSEL_VERSION}==1     .owl-item
    ...         ${OWL_CAROSEL_VERSION}==2     .owl-item.active
    Page Should Contain Image       ${mega-menu-mobile} ${elm} a img       ${banner_image}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} ${elm} a img[src="${banner_image}"]
    Page Should Contain Link        ${mega-menu-mobile} ${elm} a    ${banner_link}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} ${elm} a[href="${banner_link}"]

Verify Fix Template Showroom Banner With API Data Mobile
    [Arguments]     ${menu_index}    ${showroom_data}
    ${showroom_count}    Get Length      ${showroom_data}
    ${showroom_child}     Get From Dictionary Ignore Data     ${showroom_data}    child
    @{keys}=    Get Dictionary Keys    ${showroom_child}
    :FOR    ${position}    IN    @{keys}
    \       ${banner}=          Get From Dictionary     ${showroom_child}      ${position}
    \       ${banner_image}=    Get From Dictionary     ${banner}       src_web
    \       ${banner_link}=     Get From Dictionary     ${banner}       link_url
    \       Verify Fix Banner Mobile       ${menu_index}       ${position}       ${banner_image}        ${banner_link}        1

################

Verify Fix Template Showroom Banner With API Data
    [Arguments]     ${menu_index}    ${showroom_data}
    ${showroom_count}    Get Length      ${showroom_data}
    ${showroom_child}     Get From Dictionary Ignore Data     ${showroom_data}    child
    @{keys}=    Get Dictionary Keys    ${showroom_child}
    :FOR    ${position}    IN    @{keys}
    \       ${banner}=          Get From Dictionary     ${showroom_child}      ${position}
    \       ${banner_image}=    Get From Dictionary     ${banner}       src_web
    \       ${banner_link}=     Get From Dictionary     ${banner}       link_url
    \       Verify Fix Banner       ${menu_index}       ${position}       ${banner_image}        ${banner_link}        1

Click Link Menu Lv1
     [Arguments]         ${menu_index}
     ${menu_index}=      Convert To Integer      ${menu_index}
     ${menu_index}=      Evaluate    ${menu_index}-1
     ${megamunu_elm}=    Convert To String       ${mega-menu-list}:eq(${menu_index})
     Click Element and Wait Angular Ready       ${megamunu_elm}

Click Link Menu Lv2
    [Arguments]         ${menu_index}       ${lv2_index}
    Mouse Over Menu     ${menu_index}
    ${menu_index}=      Convert To Integer      ${menu_index}
    ${menu_index}=      Evaluate    ${menu_index}-1
    ${lv2_index}=      Convert To Integer      ${lv2_index}
    ${lv2_index}=      Evaluate    ${lv2_index}-1
    Click Element and Wait Angular Ready      ${mega-menu-list-lv2}:eq(${lv2_index}) a

Click Showroom Banner
    [Arguments]         ${menu_index}       ${position}
    Mouse Over Menu     ${menu_index}
    ${menu_index}=      Convert To Integer      ${menu_index}
    ${menu_index}=      Evaluate    ${menu_index}-1
    ${elm}=     Set Variable If
    ...         ${OWL_CAROSEL_VERSION}==1     .owl-item
    ...         ${OWL_CAROSEL_VERSION}==2     .owl-item.active
    Click Element and Wait Angular Ready       ${mega-menu-banner-index}-${menu_index}-${position} ${elm} a

Verify Click Link
    [Arguments]         ${link}
    ${current_location}=     Get Location
    Select Window           url=${link}
    Location Should Be      ${link}
    Close Window
    Select Window           url=${current_location}

Mouse Over Menu
    [Arguments]     ${menu_index}
    ${menu_index}=      Convert To Integer      ${menu_index}
    ${menu_index}=      Evaluate    ${menu_index}-1
    ${megamunu_elm}=    Convert To String       ${mega-menu-list}:eq(${menu_index})
    Mouse Over          ${megamunu_elm}
    Wait Until Angular Ready    30s
    sleep       1s

Verify Fix Banner
    [Arguments]     ${menu_index}       ${position}       ${banner_image}        ${banner_link}     ${visible_check}
    ${menu_index}=      Convert To Integer      ${menu_index}
    ${menu_index}=      Evaluate    ${menu_index}-1
    Wait Until Angular Ready    30s
    Page Should Contain Image       ${mega-menu-banner-index}-${menu_index}-${position} a > img       ${banner_image}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} a > img[src="${banner_image}"]
    Page Should Contain Link        ${mega-menu-banner-index}-${menu_index}-${position} a             ${banner_link}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} a[href="${banner_link}"]

Verify Carousel Banner
    [Arguments]     ${menu_index}       ${position}       ${banner_image}        ${banner_link}     ${visible_check}
    ${menu_index}=      Convert To Integer      ${menu_index}
    ${menu_index}=      Evaluate    ${menu_index}-1
    Wait Until Angular Ready    30s
    ${elm}=     Set Variable If
    ...         ${OWL_CAROSEL_VERSION}==1     .owl-item
    ...         ${OWL_CAROSEL_VERSION}==2     .owl-item.active
    Page Should Contain Image       ${mega-menu-banner-index}-${menu_index}-${position} ${elm} a img       ${banner_image}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} ${elm} a img[src="${banner_image}"]
    Page Should Contain Link        ${mega-menu-banner-index}-${menu_index}-${position} ${elm} a             ${banner_link}
    Run Keyword If      ${visible_check}==1     Element Should Be Visible       ${mega-menu-banner-index}-${menu_index}-${position} ${elm} a[href="${banner_link}"]

Verify Carousel Banner By File
    [Arguments]     ${total_set}    ${total_position}       ${menu_index}      ${showroom_image_data_path}      ${visible_check}
    ${body}=    Get File    ${showroom_image_data_path}
    ${data_dict}=    Convert json to Dict    ${body}
    ${total_set}=       Convert To Integer      ${total_set}
    ${total_set}=       Evaluate    ${total_set}+1
    :FOR    ${SET_INDEX}    IN RANGE    1      ${total_set}
    \       Banner While Position Loop Check    ${menu_index}    ${SET_INDEX}    ${total_position}    ${data_dict}        ${visible_check}

Banner While Position Loop Check
    [Arguments]     ${menu_index}    ${SET_INDEX}    ${total_position}    ${data_dict}        ${visible_check}
    :FOR    ${index}    IN RANGE    1       20
    \       ${status}=      Run keyword and return status     Banner Position Loop Check    ${menu_index}    ${SET_INDEX}    ${total_position}    ${data_dict}        ${visible_check}
    \       Run Keyword If      ${status}       Exit For Loop
    \       Run Keyword If      ${index}>15     Report failure      Verify Banner Fail ${menu_index} ${SET_INDEX}
    \       sleep    1

Banner Position Loop Check
     [Arguments]    ${menu_index}    ${set_index}    ${total_position}       ${data_dict}       ${visible_check}
     ${total_position}=      Convert To Integer      ${total_position}
     ${total_position}=      Evaluate    ${total_position}+1
     :FOR       ${position}       IN RANGE    1       ${total_position}
     \          ${key}=        Make Test Data Key      ${set_index}        ${position}
     \          ${banner_image_src}=        Get From Dictionary     ${data_dict}       ${key}
     \          Run Keyword If      ${position} == 1        Verify Carousel Banner      ${menu_index}       ${position}       ${banner_image_src}        link_url_${set_index}_${position}      ${visible_check}
     \          Run Keyword If      ${position} != 1        Verify Fix Banner           ${menu_index}       ${position}       ${banner_image_src}        link_url_${set_index}_${position}      ${visible_check}

Switch to EN Language
    Click Element       ${button_select_lang}
    Click Element and Wait Angular Ready       ${button_change_lang}