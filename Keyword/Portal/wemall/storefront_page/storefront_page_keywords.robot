*** Settings ***
Library         Selenium2Library
Library         ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource        ${CURDIR}/../common/web_common_keywords.robot
Resource        ${CURDIR}/webelement_storefront_page.robot
Resource        ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot
# Resource        ${CURDIR}/../keywords_common_for_wemall.robot

*** Variables ***
${SECONDARY_PATH}   /en
${PRIVIEW_TOKEN}    preview=678e45fa792c0a865d0eaee1b19e834d

*** Keywords ***
Prepare Data and Open Storefront Page
    [Arguments]     ${merchant_id}    ${shop_name}    ${shop_slug}
    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    active
    Open Storefront Page    ${shop_slug}

Create Shop But Do Not Initial Data
    [Arguments]     ${merchant_id}    ${shop_name}    ${shop_slug}
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    active

### DEPLICATED ###
Open Storefront Page
    [Arguments]     ${shop_slug}
    Open Browser and Maximize Window    ${WEMALL_WEB}/shop/${shop_slug}       ${BROWSER}
    Wait Until Angular Ready     60s
    # Wait Until Page Contains Element    css=div.btn-cart

### DEPLICATED ###
Open Storefront Page - Secondary Language
    [Arguments]     ${shop_slug}
    Open Browser and Maximize Window    ${WEMALL_WEB}/en/shop/${shop_slug}    ${BROWSER}
    Wait Until Angular Ready     60s
    # Wait Until Page Contains Element    css=div.btn-cart

### DEPLICATED ###
Change URL To Storefront Page
    [Arguments]     ${shop_slug}
    Go To   ${WEMALL_WEB}/shop/${shop_slug}?no-cache=1
    Wait Until Location Contains        ${WEMALL_WEB}/shop/${shop_slug}
    Wait Until Angular Ready    30s
    Wait Until Page Contains Element    css=html
    # Wait Until Page Contains Element    css=div.btn-cart

### DEPLICATED ###
Change URL To Storefront Page - Secondary Language
    [Arguments]     ${shop_slug}
    Go To    ${WEMALL_WEB}/en/shop/${shop_slug}?no-cache=1
    Wait Until Location Contains        ${WEMALL_WEB}/en/shop/${shop_slug}
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    css=html
    # Wait Until Page Contains Element    css=div.btn-cart

Go To Preview Web Shop Page
    [Arguments]     ${shop_slug}    ${lang}=th
    Run Keyword If    '${lang}' == 'th'    Go To   ${WEMALL_WEB}/shop/${shop_slug}/?preview=678e45fa792c0a865d0eaee1b19e834d
    ...    ELSE IF    '${lang}' == 'en'    Go To   ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}/?preview=678e45fa792c0a865d0eaee1b19e834d
    Wait Until Location Contains        /shop/${shop_slug}/?preview=678e45fa792c0a865d0eaee1b19e834d    15s
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    css=html    10s
    # Wait Until Page Contains Element    css=div.btn-cart    10s

Go To Preview Mobile Shop Page
    [Arguments]     ${shop_slug}    ${lang}=th
    Run Keyword If    '${lang}' == 'th'    Go To   ${WEMALL_WEB}/shop/${shop_slug}/?preview=678e45fa792c0a865d0eaee1b19e834d&is_mobile=1
    ...    ELSE IF    '${lang}' == 'en'    Go To   ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}/?preview=678e45fa792c0a865d0eaee1b19e834d&is_mobile=1
    Wait Until Location Contains        /shop/${shop_slug}/?preview=678e45fa792c0a865d0eaee1b19e834d&is_mobile=1    15s
    Wait Until Angular Ready    60s

Go To Web Shop Page
    [Arguments]     ${shop_slug}    ${lang}=th
    Run Keyword If    '${lang}' == 'th'    Go To   ${WEMALL_WEB}/shop/${shop_slug}
    ...    ELSE IF    '${lang}' == 'en'    Go To   ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Wait Until Location Contains        /shop/${shop_slug}   15s
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    css=html    10s
    # Wait Until Page Contains Element    css=div.btn-cart    10s

Go To Mobile Shop Page
    [Arguments]     ${shop_slug}    ${lang}=th
    Add Is Mobile Cookie
    Run Keyword If    '${lang}' == 'th'    Go To   ${WEMALL_WEB}/shop/${shop_slug}
    ...    ELSE IF    '${lang}' == 'en'    Go To   ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Wait Until Location Contains        /shop/${shop_slug}   15s
    Wait Until Angular Ready    60s

Click On ITM Logo
    Wait Until Element Is Visible    ${LOGO_ITRUEMART}    5s
    Click Element and Wait Angular Ready       ${LOGO_ITRUEMART}

Redirect To ITM Portal Page
    Wait Until Location Contains        ${ITM_URL}

Header Will Not Show Megamenu Hamburgur
    Page Should Not Contain Element     ${MEGAMENU_HAMBURGER}

Header Will Not Show Micro Cart
    Mouse Over                          ${BUTTON_CART}
    ELEMENT SHOULD NOT BE VISIBLE       ${MICROCART_BOX_ACCTIVE}

Check Microcart Not Show
    Page Should Not Contain Element     ${MICROCART_BOX_ACCTIVE}

Mouse Over On Sign In Box
    Mouse Over                          ${BUTTON_MY_PROFILE}

Log In Box Don't Expand
    Page Should Not Contain Element     ${LOGIN_BOX_ACCTIVE}

Click On Sign In Box
    Wait Until Element Is Visible    ${BUTTON_MY_PROFILE}    5s
    Click Element and Wait Angular Ready                       ${BUTTON_MY_PROFILE}

Click On Cart Icon
    Wait Until Element Is Visible    ${BUTTON_CART}    5s
    Click Element and Wait Angular Ready                       ${BUTTON_CART}

Change To Primary Language
    Not Visible Then If Failed Wait and Check Is Visible Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${TH_language_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("แชทออนไลน์")

Change To Secondary Language
    Not Visible Then If Failed Wait and Check Is Visible Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${EN_language_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("Online chat")

Login As Member
    [Arguments]     ${username}     ${password}
    Wait Until Element Is Visible       ${ITM_USERNAME_INPUT}    10s
    Input Text          ${ITM_USERNAME_INPUT}       ${username}
    Input Password      ${ITM_PASSWORD_INPUT}       ${password}
    Click Element and Wait Angular Ready       ${ITM_BUTTON_LOGIN}

Web Will Redirect To Storefront Page
    [Arguments]     ${shop_slug}
    Wait Until Location Contains        ${WEMALL_WEB}/shop/${shop_slug}    10s

Web Will Redirect To Storefront Page - Secondary Language
    [Arguments]     ${shop_slug}
    Wait Until Location Contains        ${WEMALL_WEB}/en/shop/${shop_slug}    10s

Sign in Box Will Have Profile
    Mouse Over                          ${BUTTON_MY_PROFILE}
    Page Should Contain Element         ${LOGIN_BOX_ACCTIVE}

Checking My Order
    ELEMENT SHOULD BE VISIBLE           ${MY_ORDER_LINK}

Checking Log Out
    ELEMENT SHOULD BE VISIBLE           ${LOGOUT_LINK}

Checking User Coupon
    ELEMENT SHOULD BE VISIBLE           ${COUPON_LINK}

Mouse Over On Sign In Page
    Mouse Over                          ${BUTTON_MY_PROFILE}

Click On Profile Link
    Wait Until Element Is Visible    ${PROFILE_LINK}    5s
    Click Element and Wait Angular Ready                       ${PROFILE_LINK}

Click Checking My Order Link
    Wait Until Element Is Visible    ${MY_ORDER_LINK}    5s
    Click Element and Wait Angular Ready                       ${MY_ORDER_LINK}

Click Checking User Coupon Link
    Wait Until Element Is Visible    ${COUPON_LINK}    5s
    Click Element and Wait Angular Ready                       ${COUPON_LINK}

Profile Page Display
    Wait Until Location Contains        ${WEMALL_WEB}/member/profile

Order Tracking Page Display
    Wait Until Location Contains        ${WEMALL_WEB}/member/orders

User Coupon Page Display
    Wait Until Location Contains        ${WEMALL_WEB}/member/profile?coupon=new-user

Click On Log Out Link
    Wait Until Element Is Visible    ${LOGOUT_LINK}    30s
    Click Element and Wait Angular Ready                       ${LOGOUT_LINK}

Member Log Out Correctly
    Mouse Over                          ${BUTTON_MY_PROFILE}
    Page Should Not Contain Element     ${LOGIN_BOX_ACCTIVE}

Member Display Name Show Correctly
    [Arguments]     ${displayName}
    Wait Until Element Is Visible       ${DISPLAY_NAME_TEXT}
    Element Should Contain              ${DISPLAY_NAME_TEXT}     ${displayName}

Put Text Search Box
    [Arguments]     ${searchKeyword}
    Input Text      ${SEARCH_INPUT}     ${searchKeyword}

Search Product On Search Box
    [Arguments]     ${searchKeyword}
    Put Text Search Box     ${searchKeyword}
    Click Element and Wait Angular Ready           ${SEARCH_BUTTON}

Search Product With Word On ITM
    [Arguments]     ${searchKeyword}
    wait until element is visible       ${ITM_SEARCH_TEXT}
    wait until element contains         ${ITM_SEARCH_TEXT}      ${searchKeyword}

Selected Suggestion Word
    [Arguments]     ${searchKeyword}
    Wait Until Element Is Visible       ${SEARCH_DROPDOWN}
    Wait Until Element Is Visible       ${SEARCH_DROPDOWN} div:eq(0)
    Mouse Over                          ${SEARCH_DROPDOWN} div:eq(0)
    Click Element and Wait Angular Ready                       ${SEARCH_DROPDOWN} div:eq(0)

Suggestion Words Do Not Display
    Wait Until Element Is Not Visible       ${SEARCH_DROPDOWN}

Banner Not Should Be Show
    Page Should Not Contain Element     jquery=div.wm-store-highlight-banner owl-item

Banner Amount Dot Should Be
    [Arguments]     ${amount}
    ${list}=    Get WebElements    ${banner_storefront_index}
    Length Should Be   ${list}    ${amount}

Banner Should Not Show Carousel Dot
    ${list}=    Get WebElements    ${banner_carousel_dot}.disabled
    Length Should Be   ${list}    1

Banner Should Show Carousel Dot
    ${list}=    Get WebElements    ${banner_carousel_dot}:not(.disabled)
    Length Should Be   ${list}    1

Banner Image Carousel By Index Should Contain
    [Arguments]     ${Index}    ${value}
    Banner Element Attribute By Index Should Contain    ${Index}    img    src     ${value}

Banner Alt Carousel By Index Should be Equal
    [Arguments]     ${Index}    ${value}
    Banner Element Attribute By Index Should be Equal    ${Index}    img    alt     ${value}

Banner Link Carousel By Index Should be Equal
    [Arguments]     ${Index}    ${value}
    Locator Should Match X Times    ${banner_storefront_index}:eq(${Index}) a[href='${value}']     1

Banner Target Carousel By Index Should be Equal
    [Arguments]     ${Index}    ${value}
    Banner Element Attribute By Index Should be Equal    ${Index}    a    target     ${value}

Banner Element Attribute By Index Should be Equal
    # [Arguments]     ${Index}    ${tag}    ${attrName}    ${expected_value}
    # ${element}=    Get WebElement    jquery=div.owl-item:not(.cloned):eq(${Index}) ${tag}
    # ${actual_value}=    Set Variable    ${element.get_attribute('${attrName}')}
    # Should Be Equal As Strings   ${actual_value}    ${expected_value}
    [Arguments]     ${Index}    ${tag}    ${attrName}    ${expected_value}
    # ${element}=    Get WebElement    jquery=div.owl-item:not(.cloned):eq(${Index}) ${tag}
    # ${actual_value}=    Set Variable    ${element.get_attribute('${attrName}')}
    ${actual_value}=    Selenium2Library.Get Element Attribute    ${banner_storefront_index}:eq(${Index}) ${tag}@${attrName}
    Should Be Equal As Strings   ${actual_value}    ${expected_value}

Banner Element Attribute By Index Should Contain
    # [Arguments]     ${Index}    ${tag}    ${attrName}    ${expected_value}
    # ${element}=    Get WebElement    jquery=div.owl-item:not(.cloned):eq(${Index}) ${tag}
    # ${actual_value}=     Set Variable    ${element.get_attribute('${attrName}')}
    # Should Contain  ${actual_value}    ${expected_value}
    [Arguments]     ${Index}    ${tag}    ${attrName}    ${expected_value}
    # ${element}=    Get WebElement    jquery=div.owl-item:not(.cloned):eq(${Index}) ${tag}
    # ${actual_value}=     Set Variable    ${element.get_attribute('${attrName}')}
    ${actual_value}=    Selenium2Library.Get Element Attribute    ${banner_storefront_index}:eq(${Index}) ${tag}@${attrName}
    Should Contain  ${actual_value}    ${expected_value}

### DEPLICATED ###
Go To Storefront Page
    [Arguments]     ${shop_slug}
    Open Browser and Maximize Window    ${WEMALL_WEB}/shop/${shop_slug}       ${BROWSER}    ${PAGE_ALIAS}

### DEPLICATED ###
Go To Storefront Page - Secondary Language
    [Arguments]     ${shop_slug}
    Open Browser and Maximize Window    ${WEMALL_WEB}/en/shop/${shop_slug}    ${BROWSER}    ${PAGE_ALIAS}

Switch To Storefront Page
    Switch Browser    ${PAGE_ALIAS}

Close Storefront Page
    Switch To Storefront Page
    Close Window

Updated Prepare Storefront Content Draft
    [Arguments]    ${shop_id}    ${view}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${updated_prepare_header}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${updated_prepare_menu}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${updated_prepare_banner}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${updated_prepare_content}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${updated_prepare_footer}

Modified Prepare Storefront Content Draft
    [Arguments]    ${shop_id}    ${view}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${modified_prepare_header}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${modified_prepare_menu}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${modified_prepare_banner}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${modified_prepare_content}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${modified_prepare_footer}

Published Storefront Data
    [Arguments]    ${shop_id}    ${view}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${put_published}

Verify Menus Not Contain Menu
    Locator Should Match X Times    ${MENU_NAV}     0

Verify Menus
    [Arguments]    ${shop_slug}    ${allMenuData}    ${logo}
    ${dataFromDatadict}=    Extract Menus Lv1 Data From Datadict    ${allMenuData}
    Verify Menus Primary Lang    ${shop_slug}    ${dataFromDatadict}    ${logo}    ${allMenuData}
    Change To Secondary Language
    Verify Menus Secondary Lang    ${shop_slug}    ${dataFromDatadict}    ${logo}    ${allMenuData}
    Change To Primary Language

Verify Menus Primary Lang
    [Arguments]    ${shop_slug}    ${dataFromDatadict}    ${logo}    ${allMenuData}
    ${expNameTHLv1}=    Set Variable    @{dataFromDatadict}[0]
    ${expNameENLv1}=    Set Variable    @{dataFromDatadict}[1]
    ${expLinkTHLv1}=    Set Variable    @{dataFromDatadict}[2]
    ${expLinkENLv1}=    Set Variable    @{dataFromDatadict}[3]
    ${expTarget}=    Set Variable    @{dataFromDatadict}[4]

    #Extract Data From StorefrontPage
    ${dataFromPage}=    Extract Menus Lv1 Data From Storefront Page
    ${menu1Name}=    Set Variable    @{dataFromPage}[0]
    #${menu1Link}=    Set Variable    @{dataFromPage}[1]
    ${menu1Target}=    Set Variable    @{dataFromPage}[2]

    #TH
    Should Be Equal    ${expNameTHLv1}    ${menu1Name}
    Should Be Equal    ${expTarget}    ${menu1Target}
    Menu Lv1 Link Should Be    ${expLinkTHLv1}    ${expTarget}
    Verify Menus Lv2    ${allMenuData}    ${menu1Target}    Th
    Verify Logo    ${logo}    Th

Verify Menus Secondary Lang
    [Arguments]    ${shop_slug}    ${dataFromDatadict}    ${logo}    ${allMenuData}
    ${expNameTHLv1}=    Set Variable    @{dataFromDatadict}[0]
    ${expNameENLv1}=    Set Variable    @{dataFromDatadict}[1]
    ${expLinkTHLv1}=    Set Variable    @{dataFromDatadict}[2]
    ${expLinkENLv1}=    Set Variable    @{dataFromDatadict}[3]
    ${expTarget}=    Set Variable    @{dataFromDatadict}[4]

    #Extract Data From StorefrontPage
    ${dataFromPage}=    Extract Menus Lv1 Data From Storefront Page
    ${menu1Name}=    Set Variable    @{dataFromPage}[0]
    #${menu1Link}=    Set Variable    @{dataFromPage}[1]
    ${menu1Target}=    Set Variable    @{dataFromPage}[2]

    #EN
    Should Be Equal    ${expNameENLv1}    ${menu1Name}
    Should Be Equal    ${expTarget}    ${menu1Target}
    Menu Lv1 Link Should Be    ${expLinkENLv1}    ${expTarget}
    Verify Menus Lv2    ${allMenuData}    ${menu1Target}    En
    Verify Logo    ${logo}    En

Menu Lv1 Link Should Be
    [Arguments]    ${expectedLinks}    ${expTarget}
    ${NoneList}=    Create List
    ${count}=    Get Length    ${expectedLinks}

    :FOR    ${i}    IN RANGE    0    ${count}
    \   ${itemLink}=    Set Variable    @{expectedLinks}[${i}]
    \   ${itemTarget}=    Set Variable    @{expTarget}[${i}]
    \   Run Keyword If    '${itemTarget}' != 'None'    Locator Should Match X Times    jquery=${MENU_LV1}[href='${itemLink}']     1
    \   ...    ELSE    Append To List    ${NoneList}    ${itemLink}

    ${NoneCount}=    Get Length    ${NoneList}
    Locator Should Match X Times    jquery=${MENU_LV1}:not([target])     ${NoneCount}

Extract Menus Lv1 Data From Datadict
    [Arguments]    ${allMenuData}
    ${nameTHLv1}=    Create List
    ${nameENLv1}=    Create List
    ${linkTHLv1}=    Create List
    ${linkENLv1}=    Create List
    ${newTab}=    Create List

    :FOR  ${item}  IN  @{allMenuData}
    \   Append To List    ${nameTHLv1}    ${item.nameTh}
    \   Append To List    ${nameENLv1}    ${item.nameEn}
    \   Append To List    ${linkTHLv1}    ${item.linkTh}
    \   Append To List    ${linkENLv1}    ${item.linkEn}
    # Check is empty
    \   ${isNone}=    Run Keyword And Return Status    Should Be Equal    ${item.children}    ${None}
    \   ${isChildrenEmpty}=    Run Keyword And Return Status    Should Be Empty    ${item.children}
    \   ${isChildrenEmpty}=    Evaluate    ${isNone} or ${isChildrenEmpty}
    #
    \   Run Keyword If    not ${isChildrenEmpty}      Append To List    ${newTab}    ${None}
    \   ...    ELSE IF    ${item.newTab}      Append To List    ${newTab}    _blank
    \   ...    ELSE    Append To List    ${newTab}    _self

    ${out}=    Create List    ${nameTHLv1}    ${nameENLv1}    ${linkTHLv1}    ${linkENLv1}    ${newTab}
    [Return]    ${out}

Extract Menus Lv1 Data From Storefront Page
    ${menu1Name}=    Get All Texts    ${MENU_LV1}
    ${menu1Link}=    Get All Element Attributes    ${MENU_LV1}    href
    ${menu1Target}=    Get All Element Attributes    ${MENU_LV1}    target
    ${out}=    Create List    ${menu1Name}    ${menu1Link}    ${menu1Target}
    [Return]    ${out}

Verify Menus Lv2
    [Arguments]    ${allMenuData}    ${menu1Target}    ${lang}
    ${length}=    Get Length    ${allMenuData}
    ${field}=    Set Variable    name${lang}
    :FOR    ${i}    IN RANGE    0    ${length}
    \   ${item}=    Set Variable    @{allMenuData}[${i}]
    \   ${target}=     Set Variable    @{menu1Target}[${i}]
    #Check whether locator is valid slow here
    \   ${isInvalid}=    Run Keyword And Return Status    Should Not Be Equal   ${target}    ${None}
    \   Continue For Loop If    ${isInvalid}
    #Extract data
    \   Mouse Over    xpath=//span[contains(text(),'${item.${field}}')]
    \   ${elements}=    Get Webelements    xpath=//span[contains(text(),'${item.${field}}')]/../../ul/li
    \   ${length}=    Get Length    ${elements}
    \   Verify Inner Menus Lv2    ${item}    ${item.${field}}    ${length}    ${lang}

Verify Inner Menus Lv2
    [Arguments]    ${item}    ${itemField}    ${length}    ${lang}
    :FOR    ${i}    IN RANGE    1    ${length+1}
    \   ${name}=    Get Text    xpath=//span[contains(text(),'${itemField}')]/../../ul/li[${i}]/a
    \   ${link}=    Selenium2Library.Get Element Attribute    xpath=//span[contains(text(),'${itemField}')]/../../ul/li[${i}]/a@href
    \   ${target}=    Selenium2Library.Get Element Attribute    xpath=//span[contains(text(),'${itemField}')]/../../ul/li[${i}]/a@target
    \   ${child}=    Set Variable    @{item.children}[${i-1}]
    \   ${expName}=    Set Variable    ${child.name${lang}}
    \   ${expLink}=    Set Variable    ${child.link${lang}}
    \   ${expTarget}=    Set Variable If    ${child.newTab}    _blank    _self
    \   Should Be Equal    ${expName}    ${name}
    \   Should Be Equal    ${expTarget}    ${target}
    \   Locator Should Match X Times    xpath=//span[contains(text(),'${itemField}')]/../../ul/li[${i}]/a[@href='${expLink}']     1

Verify Logo
    [Arguments]    ${logo}    ${lang}
    ${isLogoNone}=    Run Keyword And Return Status    Should Be Equal    ${logo}    ${None}
    Return From Keyword If    ${isLogoNone}
    #
    ${expFileName}=    Set Variable    ${logo.fileName${lang}}
    ${expLink}=    Set Variable    ${logo.link${lang}}
    #
    ${fileName}=    Selenium2Library.Get Element Attribute    jquery=${MENU_LOGO_LINK} img @src
    #
    Should Contain    ${fileName}    ${expFileName}
    Locator Should Match X Times    jquery=${MENU_LOGO_LINK}[href='${expLink}']     1

### DEPLICATED ###
Open Storefront Page and Verify All Content
    [Arguments]     ${shop_slug}
    Open Browser and Maximize Window    ${WEMALL_WEB}/shop/${shop_slug}    ${BROWSER}    storefront

Close Window and Switch to Browser 1
    Switch Browser    storefront
    Close Window
    Switch Browser    1

Open Storefront Web Page
    [Arguments]     ${shop_slug}
    Open Browser and Maximize Window    ${WEMALL_WEB}/shop/${shop_slug}    ${BROWSER}    storefront
    Wait Until Angular Ready    30s

Open WeMall Page
    Open Browser and Maximize Window    ${WEMALL_WEB}/    ${BROWSER}    wm_portal
    Wait Until Angular Ready    30s

Verify All Content in Storefront Web Page
    [Arguments]     ${shop_slug}
    Switch Browser    storefront
    Go To    ${WEMALL_WEB}/shop/${shop_slug}
    Verify All Content in Storefront Web Page - Primary Language
    Go To    ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Verify All Content in Storefront Web Page - Secondary Language

Verify Content Type in Storefront Web Page are Updated
    [Arguments]     ${shop_slug}
    Switch Browser    storefront
    Go To    ${WEMALL_WEB}/shop/${shop_slug}
    Verify Conent Type in Storefront Web Page are Updated - Primary Language
    Go To    ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Verify Conent Type in Storefront Web Page are Updated - Secondary Language

Verify All Content in Storefront Mobile Page
    [Arguments]     ${shop_slug}
    Switch Browser    storefront
    Add Is Mobile Cookie
    Go To    ${WEMALL_WEB}/shop/${shop_slug}
    Verify All Content in Storefront Mobile Page - Primary Language
    Go To    ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Verify All Content in Storefront Mobile Page - Secondary Language

Verify Content Type in Storefront Mobile Page are Updated
    [Arguments]     ${shop_slug}
    Switch Browser    storefront
    Add Is Mobile Cookie
    Go To    ${WEMALL_WEB}/shop/${shop_slug}
    Verify Conent Type in Storefront Mobile Page are Updated - Primary Language
    Go To    ${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Verify Conent Type in Storefront Mobile Page are Updated - Secondary Language

Verify Shop Content with Prepare Data - Web Preview Mode
    [Arguments]    ${slug}
    Go To Preview Web Shop Page    ${slug}
    Verify All Content in Storefront Web Page - Primary Language
    Go To Preview Web Shop Page    ${slug}    en
    Verify All Content in Storefront Web Page - Secondary Language

Verify Shop Content with Prepare Data - Mobile Preview Mode
    [Arguments]    ${slug}
    Go To Preview Mobile Shop Page    ${slug}
    Verify All Content in Storefront Mobile Page - Primary Language
    Go To Preview Mobile Shop Page    ${slug}    en
    Verify All Content in Storefront Mobile Page - Secondary Language

Verify Shop Content with Updated Prepare Data - Web Preview Mode
    [Arguments]    ${slug}
    Go To Preview Web Shop Page    ${slug}
    Verify Updated Prepare Content in Storefront Web Page - Primary Language
    Go To Preview Web Shop Page    ${slug}    en
    Verify Updated Prepare Content in Storefront Web Page - Secondary Language

Verify Shop Content with Updated Prepare Data - Mobile Preview Mode
    [Arguments]    ${slug}
    Go To Preview Mobile Shop Page    ${slug}
    Verify Updated Prepare Content in Storefront Mobile Page - Primary Language
    Go To Preview Mobile Shop Page    ${slug}    en
    Verify Updated Prepare Content in Storefront Mobile Page - Secondary Language

Verify Shop Content with Updated Prepare Data - Web Published Mode
    [Arguments]    ${slug}
    Go To Web Shop Page    ${slug}
    Verify Updated Prepare Content in Storefront Web Page - Primary Language
    Go To Web Shop Page    ${slug}    en
    Verify Updated Prepare Content in Storefront Web Page - Secondary Language

Verify Shop Content with Updated Prepare Data - Mobile Published Mode
    [Arguments]    ${slug}
    Go To Mobile Shop Page    ${slug}
    Verify Updated Prepare Content in Storefront Mobile Page - Primary Language
    Go To Mobile Shop Page    ${slug}    en
    Verify Updated Prepare Content in Storefront Mobile Page - Secondary Language

Verify Shop Content with Modified Data - Web Preview Mode
    [Arguments]    ${slug}
    Go To Preview Web Shop Page    ${slug}
    Verify Modified Content in Storefront Web Page - Primary Language
    Go To Preview Web Shop Page    ${slug}    en
    Verify Modified Content in Storefront Web Page - Secondary Language

Verify Shop Content with Modified Data - Mobile Preview Mode
    [Arguments]    ${slug}
    Go To Preview Mobile Shop Page    ${slug}
    Verify Modified Content in Storefront Mobile Page - Primary Language
    Go To Preview Mobile Shop Page    ${slug}    en
    Verify Modified Content in Storefront Mobile Page - Secondary Language

Verify Shop Content with Modified Data - Web Published Mode
    [Arguments]    ${slug}
    Go To Web Shop Page    ${slug}
    Verify Modified Content in Storefront Web Page - Primary Language
    Go To Web Shop Page    ${slug}    en
    Verify Modified Content in Storefront Web Page - Secondary Language

Verify Shop Content with Modified Data - Mobile Published Mode
    [Arguments]    ${slug}
    Go To Mobile Shop Page    ${slug}
    Verify Modified Content in Storefront Mobile Page - Primary Language
    Go To Mobile Shop Page    ${slug}    en
    Verify Modified Content in Storefront Mobile Page - Secondary Language

Verify All Content in Storefront Web Page - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="header-storefront-test"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("แม็ค")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="ไนกี้ แอร์"]
    # Check Content
    Page Should Contain Element    jquery=h3[id="content-storefront-test"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="footer-storefront-test"]

Verify All Content in Storefront Web Page - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="header-storefront-test-en"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("Mac")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="Nike Air"]
    # Check Content
    Page Should Contain Element    jquery=h3[id="content-storefront-test-en"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="footer-storefront-test-en"]

Verify Conent Type in Storefront Web Page are Updated - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="header-storefront-test"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("แม็ค")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="ไนกี้ แอร์"]
    # Check Content
    Page Should Contain Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="footer-storefront-test"]

Verify Conent Type in Storefront Web Page are Updated - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="header-storefront-test-en"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("Mac")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="Nike Air"]
    # Check Content
    Page Should Contain Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test-en"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="footer-storefront-test-en"]

Verify All Content in Storefront Mobile Page - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="header-storefront-test"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("แม็ค")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="ไนกี้ แอร์"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=h3[id="content-storefront-test"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="footer-storefront-test"]    10s

Verify All Content in Storefront Mobile Page - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="header-storefront-test-en"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("Mac")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="Nike Air"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=h3[id="content-storefront-test-en"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="footer-storefront-test-en"]    10s

Verify Conent Type in Storefront Mobile Page are Updated - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="header-storefront-test"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("แม็ค")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="ไนกี้ แอร์"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="footer-storefront-test"]    10s

Verify Conent Type in Storefront Mobile Page are Updated - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="header-storefront-test-en"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("Mac")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="Nike Air"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test-en"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="footer-storefront-test-en"]    10s

Verify Updated Prepare Content in Storefront Web Page - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="updated-header-storefront-test"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("อุปกรณ์เสริม")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="Yoobao"]
    # Check Content
    Page Should Contain Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="updated-footer-storefront-test"]

Verify Updated Prepare Content in Storefront Web Page - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="updated-header-storefront-test-en"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("Accessory")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="Piper Standard"]
    # Check Content
    Page Should Contain Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test-en"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="updated-footer-storefront-test-en"]

Verify Modified Content in Storefront Web Page - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="modified-header-storefront-test"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("กล้อง Mirror less")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="Zyxel"]
    # Check Content
    Page Should Contain Element    jquery=div[id="testModifiedPublishedData"] h3[id="content-storefront-test"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="modified-footer-storefront-test"]

Verify Modified Content in Storefront Web Page - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Page Should Contain Element    jquery=img[id="modified-header-storefront-test-en"]
    # Check Menu
    Page Should Contain Element    jquery=div[id="store-vendor-nav"] ul.menu:contains("Mirror less camera")
    # Check Banner
    Page Should Contain Element    jquery=div.owl-stage img[alt="Plantronics"]
    # Check Content
    Page Should Contain Element    jquery=div[id="testModifiedPublishedData"] h3[id="content-storefront-test-en"]
    # Check Footer
    Page Should Contain Element    jquery=div[id="modified-footer-storefront-test-en"]

Verify Updated Prepare Content in Storefront Mobile Page - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="updated-header-storefront-test"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("อุปกรณ์เสริม")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="Yoobao"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="updated-footer-storefront-test"]    10s

Verify Updated Prepare Content in Storefront Mobile Page - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="updated-header-storefront-test-en"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("Accessory")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="Piper Standard"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=div[id="testUpdatedPublishedData"] h3[id="content-storefront-test-en"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="updated-footer-storefront-test-en"]    10s

Verify Modified Content in Storefront Mobile Page - Primary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="modified-header-storefront-test"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("กล้อง Mirror less")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="Zyxel"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=div[id="testModifiedPublishedData"] h3[id="content-storefront-test"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="modified-footer-storefront-test"]    10s

Verify Modified Content in Storefront Mobile Page - Secondary Language
    Wait Until Angular Ready    30s
    # Check Header
    Wait Until Page Contains Element    jquery=img[id="modified-header-storefront-test-en"]    10s
    # Check Menu
    Wait Until Page Contains Element    jquery=div.wm-store-front-slide-content li.ng-scope:contains("Mirror less camera")    10s
    # Check Banner
    Wait Until Page Contains Element    jquery=div.owl-stage img[alt="Plantronics"]    10s
    # Check Content
    Wait Until Page Contains Element    jquery=div[id="testModifiedPublishedData"] h3[id="content-storefront-test-en"]    10s
    # Check Footer
    Wait Until Page Contains Element    jquery=div[id="modified-footer-storefront-test-en"]    10s

Add Is Mobile Cookie
    Delete Is Mobile Cookie
    Add Cookie       is_clear    true
    Add Cookie       is_mobile    true

Delete Is Mobile Cookie
    Delete Cookie    is_mobile
    Delete Cookie    is_clear

Not Visible Then If Failed Wait and Check Is Visible Again
    [Arguments]    ${locator}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    5s
    Run Keyword If    ${result} == False    Sleep    1s
    Wait Until Element Is Visible    ${locator}    30s

Click Then If Failed Wait and Click Again
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    5s
    ${result}=    Run Keyword And Return Status    Click Element and Wait Angular Ready    ${locator}
    Run Keyword If    ${result} == False    Sleep    3s
    Run Keyword If    ${result} == False    Click Element and Wait Angular Ready    ${locator}

