*** Settings ***
Library             HttpLibrary.HTTP
Library             String
Resource            ${CURDIR}/../../../Database/PDS/keyword_merchant.robot
Resource            ${CURDIR}/../../../API/PDS/pds_api_keywords.robot
Resource            ${CURDIR}/../../../../Resource/TestData/${env}/test_data.robot

*** Variable ***
${display_tab_locator}                jquery=li.nav-item a span:contains("Display")
${category_locator}                   jquery=app-category-info div.panel-body div div.row:eq(0) div > span
${alias_locator}                      jquery=app-category-info div.panel-body div div.row:eq(1) span
${publish_locator}                    jquery=app-category-info div.panel-body div div.row:eq(2) span
${banner_mgt_desktop_locator}         jquery=app-category-banner-upload:eq(0)
${banner_mgt_mobile_locator}          jquery=app-category-banner-upload:eq(1)
${banner_mgt_img_locator}             img
${banner_mgt_img_required_locator}    div[id="imageValidationAlert"]
${banner_mgt_img_close_locator}       span.close
${banner_mgt_img_browse_locator}      input:file
${banner_mgt_alt_locator}             input:text[id="banner-upload-alt"]
${banner_mgt_link_locator}            input:text[id="banner-upload-link"]
${banner_mgt_newtab_locator}          input[id="banner-upload-newtab"]
${thumb_mgt_sortby_locator}           id=thm-sort-by
${thumb_mgt_displayoption_locator}    thm-display-option
${display_save_btn_locator}           id=thm-save-btn
${successMsgLocator}                  jquery=div.alert-success
${failMsgLocator}                     jquery=div.alert-danger
${displayTabLocator}                  jquery=li.nav-item.active span:contains("Display")
${catDataLocator}                     jquery=app-category-info
${bannerMgtLocator}                   jquery=h3:contains("Banner Management")
${thumbnailMgtLocator}                jquery=h3:contains("Thumbnail Management")
${imageBadgeLocator}                  div.img-wrap.nv-badge
${imageBadgeTextLocator}              div.img-wrap.nv-badge span.badge-icon

*** Keywords ***
Merchant Category Management - Click On Display Tab
    Click Element    ${display_tab_locator}
    Merchant Category Management Display - Display Tab has been shown

######## Goto
Merchant Category Management Display - Goto Display Cat Lv1
    [Arguments]    ${merchant_label}    ${idLv1}
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${merchant_label}')    30
    Merchant Category Management - Select Category    ${merchant_label}
    sleep   1s
    Merchant Category Management - Edit Category    ${idLv1}
    sleep   1s
    Merchant Category Management - Click On Display Tab

Merchant Category Management Display - Goto Display Cat Lv2
    [Arguments]    ${merchant_label}    ${idLv1}    ${idLv2}
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${merchant_label}')    30
    Merchant Category Management - Select Category    ${merchant_label}
    sleep   1s
    Merchant Category Management - Click Plus Button    ${idLv1}
    sleep   1s
    Merchant Category Management - Edit Category    ${idLv2}
    sleep   1s
    Merchant Category Management - Click On Display Tab

######## Input
Merchant Category Management Display - Input Alt
    [Arguments]    ${type}    ${alt}
    ${bannerTypeLocator}=    Set Variable If    '${type}' == 'desktop'    ${banner_mgt_desktop_locator}
    ...                                         '${type}' == 'mobile'     ${banner_mgt_mobile_locator}
    Input Text    ${bannerTypeLocator} ${banner_mgt_alt_locator}    ${alt}

Merchant Category Management Display - Input Link
    [Arguments]    ${type}    ${link}
    ${bannerTypeLocator}=    Set Variable If    '${type}' == 'desktop'    ${banner_mgt_desktop_locator}
    ...                                         '${type}' == 'mobile'     ${banner_mgt_mobile_locator}
    Input Text    ${bannerTypeLocator} ${banner_mgt_link_locator}    ${link}

Merchant Category Management Display - Check NewTab
    [Arguments]    ${type}    ${newtab}
    ${bannerTypeLocator}=    Set Variable If    '${type}' == 'desktop'    ${banner_mgt_desktop_locator}
    ...                                         '${type}' == 'mobile'     ${banner_mgt_mobile_locator}
    Run Keyword If    ${newtab}    Select Checkbox    ${bannerTypeLocator} ${banner_mgt_newtab_locator}
    ...     ELSE      Unselect Checkbox    ${bannerTypeLocator} ${banner_mgt_newtab_locator}

Merchant Category Management Display - Select SortBy
    [Arguments]    ${sortBy}
    Select From List By Value    ${thumb_mgt_sortby_locator}    ${sortBy}

Merchant Category Management Display - Select DisplayOption
    [Arguments]    ${displayOption}
    Select Radio Button    ${thumb_mgt_displayoption_locator}    ${displayOption}

Merchant Category Management Display - Remove Image
    [Arguments]    ${type}
    ${bannerTypeLocator}=    Set Variable If    '${type}' == 'desktop'    ${banner_mgt_desktop_locator}
    ...                                         '${type}' == 'mobile'     ${banner_mgt_mobile_locator}
    Click Element    ${bannerTypeLocator} ${banner_mgt_img_close_locator}

Merchant Category Management Display - Choose Image
    [Arguments]    ${type}    ${file}
    ${bannerTypeLocator}=    Set Variable If    '${type}' == 'desktop'    ${banner_mgt_desktop_locator}
    ...                                         '${type}' == 'mobile'     ${banner_mgt_mobile_locator}
    Choose File    ${bannerTypeLocator} ${banner_mgt_img_browse_locator}    ${file}

Merchant Category Management Display - Update Display
    [Arguments]    ${dAlt}    ${dLink}    ${dNewtab}    ${dImage}    ${mAlt}    ${mLink}    ${mNewtab}    ${mImage}    ${sortBy}    ${dislayOption}
    Merchant Category Management Display - Input Alt    desktop    ${dAlt}
    Merchant Category Management Display - Input Link    desktop    ${dLink}
    Merchant Category Management Display - Check NewTab    desktop    ${dNewtab}
    Merchant Category Management Display - Remove Image    desktop
    ${dChooseImage}=    Run Keyword And Return Status    Should Not Be Empty    ${dImage}
    Run Keyword If    ${dChooseImage}     Merchant Category Management Display - Choose Image    desktop    ${dImage}
    Merchant Category Management Display - Input Alt    mobile    ${mAlt}
    Merchant Category Management Display - Input Link    mobile    ${mLink}
    Merchant Category Management Display - Check NewTab    mobile    ${mNewtab}
    Merchant Category Management Display - Remove Image    mobile
    ${mChooseImage}=    Run Keyword And Return Status    Should Not Be Empty    ${mImage}
    Run Keyword If    ${mChooseImage}     Merchant Category Management Display - Choose Image    mobile    ${mImage}
    Merchant Category Management Display - Select SortBy    ${sortBy}
    Merchant Category Management Display - Select DisplayOption    ${dislayOption}

Merchant Category Management Display - Click Save
    Click Element    ${display_save_btn_locator}

Merchant Category Management Display - Extract Id From Url
    ${location}=    Get Location
    @{words}=     Split String    ${location}    /
    Return From Keyword    @{words}[6]

#### Verify
Merchant Category Management Display - Display Tab has been shown
    Wait Until Element Is Visible    ${displayTabLocator}
    Wait Until Element Is Visible    ${catDataLocator}
    Wait Until Element Is Visible    ${bannerMgtLocator}
    Wait Until Element Is Visible    ${thumbnailMgtLocator}
    Wait Until Element Is Visible    ${banner_mgt_desktop_locator}
    Wait Until Element Is Visible    ${banner_mgt_mobile_locator}

Merchant Category Management Display - Verify Category Data
    [Arguments]    ${manageCategory}    ${aliasName}    ${publishFor}
    ${category_elements}=    Get Webelements    ${category_locator}

    ${acManageCategory}=     Set Variable    -
    ${manageCategory}=     Catenate    -    ${manageCategory}

    : FOR    ${element}    IN    @{category_elements}
    \    ${acManageCategory}=    Catenate    ${acManageCategory}    ${element.text}
    Should Be Equal    ${acManageCategory}    ${manageCategory}
    Selenium2Library.Element Text Should Be    ${alias_locator}    ${aliasName}
    Selenium2Library.Element Text Should Be    ${publish_locator}    ${publishFor}

Merchant Category Management Display - Verify Banner Management
    [Arguments]    ${type}    ${expImageSrc}    ${expAlt}    ${expLink}    ${expNewTab}
    ${bannerTypeLocator}=    Set Variable If    '${type}' == 'desktop'    ${banner_mgt_desktop_locator}
    ...                                         '${type}' == 'mobile'     ${banner_mgt_mobile_locator}
    ${imgSrc}=    Selenium2Library.Get Element Attribute    ${bannerTypeLocator} ${banner_mgt_img_locator}@src
    Should Contain    ${imgSrc}    ${expImageSrc}
    Textfield Value Should Be    ${bannerTypeLocator} ${banner_mgt_alt_locator}    ${expAlt}
    Textfield Value Should Be    ${bannerTypeLocator} ${banner_mgt_link_locator}    ${expLink}
    Run Keyword If    ${expNewTab}    Checkbox Should Be Selected    ${bannerTypeLocator} ${banner_mgt_newtab_locator}
    ...     ELSE      Checkbox Should Not Be Selected    ${bannerTypeLocator} ${banner_mgt_newtab_locator}

Merchant Category Management Display - Verify Image Required
    [Arguments]    ${type}
    ${bannerTypeLocator}=    Set Variable If    '${type}' == 'desktop'    ${banner_mgt_desktop_locator}
    ...                                         '${type}' == 'mobile'     ${banner_mgt_mobile_locator}
    Element Should Be Visible    ${bannerTypeLocator} ${banner_mgt_img_required_locator}

Merchant Category Management Display - Verify Thumbnail Management
    [Arguments]    ${expSortBy}    ${expDisplayOption}
    ${sortBy}    Get Value    ${thumb_mgt_sortby_locator}
    Should Be Equal    ${sortBy}    ${expSortBy}
    Radio Button Should Be Set To    ${thumb_mgt_displayoption_locator}    ${expDisplayOption}

Merchant Category Management Display - Verify Save Success
    Wait Until Element Is Visible    ${successMsgLocator}   30

Merchant Category Management Display - Verify Save fail
    Wait Until Element Is Visible    ${failMsgLocator}    30

Merchant Category Management Display - Verify image badge
    [Arguments]    ${checkDesktop}    ${checkMobile}
    Run Keyword If    ${checkDesktop}    Element Should Be Visible    ${banner_mgt_desktop_locator} ${imageBadgeLocator}
    Run Keyword If    ${checkDesktop}    Element Should Be Visible    ${banner_mgt_desktop_locator} ${imageBadgeTextLocator}
    Run Keyword If    ${checkMobile}     Element Should Be Visible    ${banner_mgt_mobile_locator} ${imageBadgeLocator}
    Run Keyword If    ${checkMobile}     Element Should Be Visible    ${banner_mgt_mobile_locator} ${imageBadgeTextLocator}

Merchant Category Management Display - Get Image Url Desktop
    [Arguments]    ${data}
    ${ac_image_url_desktop}=      Get From Dictionary     ${data}       image_url_desktop
    Set Suite Variable    ${ac_image_url_desktop}

Merchant Category Management Display - Get Image Url Mobile
    [Arguments]    ${data}
    ${ac_image_url_mobile}=      Get From Dictionary     ${data}       image_url_mobile
    Set Suite Variable    ${ac_image_url_mobile}

Merchant Category Management Display - Verify Category Display Data
    [Arguments]     ${id}    ${image_url_desktop}    ${alt_text_desktop}    ${image_url_desktop_link}    ${newtab_desktop}    ${image_url_mobile}    ${alt_text_mobile}    ${image_url_mobile_link}    ${newtab_mobile}    ${sort_by}    ${display_option}

    ${response}=     Get Category By Category ID    ${id}
    ${data}=    Merchant Category - Get Json Value and Convert to List    ${response}    /data

    ${imageUrlD}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${data}       image_url_desktop
    ${imageUrlM}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${data}       image_url_mobile

    ${ac_image_url_desktop}=    Set Variable    ${EMPTY}
    Run Keyword If    ${imageUrlD}    Merchant Category Management Display - Get Image Url Desktop    ${data}

    ${ac_image_url_mobile}=    Set Variable    ${EMPTY}
    Run Keyword If    ${imageUrlM}    Merchant Category Management Display - Get Image Url Mobile    ${data}

    # ${ac_image_url_desktop}=      Get From Dictionary     ${data}       image_url_desktop
    ${ac_alt_text_desktop}=      Get From Dictionary     ${data}       alt_text_desktop
    ${ac_image_url_desktop_link}=      Get From Dictionary     ${data}       image_url_desktop_link
    ${ac_image_new_tab_option_desktop}=      Get From Dictionary     ${data}       image_new_tab_option_desktop
    # ${ac_image_url_mobile}=      Get From Dictionary     ${data}       image_url_mobile
    ${ac_alt_text_mobile}=      Get From Dictionary     ${data}       alt_text_mobile
    ${ac_image_url_mobile_link}=      Get From Dictionary     ${data}       image_url_mobile_link
    ${ac_image_new_tab_option_mobile}=      Get From Dictionary     ${data}       image_new_tab_option_mobile
    ${ac_sort_by}=      Get From Dictionary     ${data}       sort_by
    ${ac_display_option}=      Get From Dictionary     ${data}       display_option

    ${image_new_tab_option_desktop}=    Set Variable If    ${newtab_desktop}    1    0
    ${image_new_tab_option_mobile}=    Set Variable If    ${newtab_mobile}    1    0
#
    Should contain     ${ac_image_url_desktop}    ${image_url_desktop}
    Should Be Equal    ${alt_text_desktop}    ${ac_alt_text_desktop}
    Should Be Equal    ${image_url_desktop_link}    ${ac_image_url_desktop_link}
    Should Be Equal    ${image_new_tab_option_desktop}    ${ac_image_new_tab_option_desktop}
    Should contain     ${ac_image_url_mobile}    ${image_url_mobile}
    Should Be Equal    ${alt_text_mobile}    ${ac_alt_text_mobile}
    Should Be Equal    ${image_url_mobile_link}    ${ac_image_url_mobile_link}
    Should Be Equal    ${image_new_tab_option_mobile}    ${ac_image_new_tab_option_mobile}
    Should Be Equal    ${sort_by}    ${ac_sort_by}
    Should Be Equal    ${display_option}    ${ac_display_option}
