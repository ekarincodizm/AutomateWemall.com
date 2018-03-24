*** Settings ***
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Library             ${CURDIR}/../../../../Python_Library/common.py
Library             ${CURDIR}/../../../../Python_Library/util/string.py
Resource            ${CURDIR}/../../wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/webelement_manage_shop_menu.robot
Resource            ${CURDIR}/../../wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../../wemall-mobile/storefront_page/storefront_page_keywords.robot
Library             ${CURDIR}/../../wemall/storefront_page/storefront_page_keywords.py

*** Keywords ***
Click Save Button
    Click Element and Wait Angular Ready    ${SAVE_BUTTON}

Click Save Menu Button
    Click Element and Wait Angular Ready    ${SAVE_MENU_BUTTON}

Click Preview Button
    Click Element and Wait Angular Ready    ${PREVIEW_BUTTON}

Click Publish Button
    Click Element and Wait Angular Ready    ${PUBLISH_BUTTON}

Click Edit Menu Button
    [Arguments]    ${level}    ${menu_name}
    Click Element and Wait Angular Ready    jquery=#level-${level} span[data-id="menu-name"]:contains(${menu_name}) + div a[title="Edit"]

Click Delete Menu Button
    [Arguments]    ${level}    ${menu_name}
    Click Element and Wait Angular Ready    jquery=#level-${level} span[data-id="menu-name"]:contains(${menu_name}) + div a[title="Delete"]

Click Ok Button on Modal Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_OK_BUTTON}

Click Cancel Button on Modal Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_CANCEL_BUTTON}

Click Delete Image Menu Data Button
    Click Element and Wait Angular Ready    ${DELETE_IMAGE_DATA_LEVEL_2}

Fill In Menu Data
    [Arguments]    @{data}
    Input Text    ${MODAL_DIALOG_NAME_TH_TXT}    @{data}[0]
    Input Text    ${MODAL_DIALOG_NAME_EN_TXT}    @{data}[1]
    Input Text    ${MODAL_DIALOG_LINK_TH_TXT}    @{data}[2]
    Input Text    ${MODAL_DIALOG_LINK_EN_TXT}    @{data}[3]
    Run Keyword If    @{data}[4]            Select iCheckbox      ${MODAL_DIALOG_NEW_TAB_CHK}        ${MODAL_DIALOG_NEW_TAB_SPAN}
    ...    ELSE                             Unselect iCheckbox    ${MODAL_DIALOG_NEW_TAB_CHK}        ${MODAL_DIALOG_NEW_TAB_SPAN}
    Run Keyword If    len($data) > 5      Set Menu Image Th     @{data}[5]
    Run Keyword If    len($data) > 6      Input Text            ${MODAL_DIALOG_IMG_ALT_TH}         @{data}[6]
    Run Keyword If    len($data) > 7      Input Text            ${MODAL_DIALOG_IMG_LINK_TH}        @{data}[7]
    Run Keyword If    len($data) > 8      Set Menu Image En     @{data}[8]
    Run Keyword If    len($data) > 9      Input Text            ${MODAL_DIALOG_IMG_ALT_EN}         @{data}[9]
    Run Keyword If    len($data) > 10     Input Text            ${MODAL_DIALOG_IMG_LINK_EN}        @{data}[10]
    Run Keyword If    len($data) > 11 and $data[11]
    ...               Select iCheckbox      ${MODAL_DIALOG_IMG_NEW_TAB_CHK}    ${MODAL_DIALOG_IMG_NEW_TAB_SPAN}
    Run Keyword If    len($data) > 11 and (not $data[11])
    ...               Unselect iCheckbox    ${MODAL_DIALOG_IMG_NEW_TAB_CHK}    ${MODAL_DIALOG_IMG_NEW_TAB_SPAN}

Select Menu
    [Arguments]    ${level}    ${menu_name}
    # Click Element and Wait Angular Ready    jquery=#level-${level} span[data-id="menu-name"]:contains(${menu_name})
    Execute Javascript    $('#level-${level} span[data-id="menu-name"]:contains(${menu_name})').click()

Click Add Menu Button
    [Arguments]    ${level}
    Click Element and Wait Angular Ready    id=addLv${level}Btn

Click Cancel on the Delete Menu Confirmation Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_CANCEL_BUTTON}

Click Confirm on the Delete Menu Confirmation Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_CONFIRM_BUTTON}

Click Cancel on the Delete Logo Confirmation Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_CANCEL_BUTTON}

Click Confirm on the Delete Logo Confirmation Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_CONFIRM_BUTTON}

Click Cancel on the Delete Image Menu Data Confirmation Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_CANCEL_BUTTON}:eq(1)

Click Confirm on the Delete Image Menu Data Confirmation Dialog
    Click Element and Wait Angular Ready    ${MODAL_DIALOG_CONFIRM_BUTTON}:eq(1)

Drag Menu And Drop After Another Menu
    [Arguments]    ${level}    ${src}    ${dest}
    ${srcLocator}=    Set Variable    jquery=#level-${level} span[data-id="menu-name"]:contains(${src})
    ${srcY}=    Get Vertical Position    ${srcLocator}
    ${destLocator}=    Set Variable    jquery=#level-${level} span[data-id="menu-name"]:contains(${dest})
    ${destY}=    Get Vertical Position    ${destLocator}
    ${offsetY}=    Evaluate    ${destY}+2-${srcY}
    Drag And Drop By Offset    ${srcLocator}    0    ${offsetY}

Drag Menu And Drop Before Another Menu
    [Arguments]    ${level}    ${src}    ${dest}
    ${srcLocator}=    Set Variable    jquery=#level-${level} span[data-id="menu-name"]:contains(${src})
    ${srcY}=    Get Vertical Position    ${srcLocator}
    ${destLocator}=    Set Variable    jquery=#level-${level} span[data-id="menu-name"]:contains(${dest})
    ${destY}=    Get Vertical Position    ${destLocator}
    ${offsetY}=    Evaluate    ${destY}-${srcY}-2
    Drag And Drop By Offset    ${srcLocator}    0    ${offsetY}

Set Menu Image Th
    [Arguments]          ${imagePath}
    ${canonicalPath}=    Get Canonical Path       ${imagePath}
    Choose File          ${UPLOAD_MENU_IMG_TH}    ${canonicalPath}
    Wait Until Element Is Visible    ${UPLOAD_MENU_IMG_TH_PRE}

Set Menu Image En
    [Arguments]          ${imagePath}
    ${canonicalPath}=    Get Canonical Path       ${imagePath}
    Choose File          ${UPLOAD_MENU_IMG_EN}    ${canonicalPath}
    Wait Until Element Is Visible    ${UPLOAD_MENU_IMG_EN_PRE}

Menu Image Th Should Not Appear
    Wait Until Element Is Not Visible    ${UPLOAD_MENU_IMG_TH_PRE}

Menu Image Th Should Appear
    [Arguments]       ${fileName}
    ${fileName}=      Get File Name From Path    ${fileName}
    ${imgSrc}=        Selenium2Library.Get Element Attribute    ${UPLOAD_MENU_IMG_TH_PRE}@src
    Should Contain    ${imgSrc}    ${fileName}

Menu Image En Should Not Appear
    Wait Until Element Is Not Visible    ${UPLOAD_MENU_IMG_EN_PRE}

Menu Image En Should Appear
    [Arguments]       ${fileName}
    ${fileName}=      Get File Name From Path    ${fileName}
    ${imgSrc}=        Selenium2Library.Get Element Attribute    ${UPLOAD_MENU_IMG_EN_PRE}@src
    Should Contain    ${imgSrc}    ${fileName}

Click Edit Logo
    Click Element and Wait Angular Ready    ${EDIT_LOGO_BUTTON}

Click Delete Logo
    Click Element and Wait Angular Ready    ${DELETE_LOGO_BUTTON}

Verify Edit Logo Popup Appears
    Wait Until Element Is Visible    ${MODAL_DIALOG}
    Wait Until Element Contains    ${MODAL_DIALOG_HEADER}    ${EDIT_LOGO_HEADER_MSG}

Set Logo Image Th
    [Arguments]    ${imagePath}
    ${canonicalPath}=    Get Canonical Path    ${imagePath}
    Choose File    ${MODAL_LOGO_IMG_TH}    ${canonicalPath}
    Wait Until Element Is Visible    ${MODAL_LOGO_IMG_TH_PRE}

Set Logo Image En
    [Arguments]    ${imagePath}
    ${canonicalPath}=    Get Canonical Path    ${imagePath}
    Choose File    ${MODAL_LOGO_IMG_EN}    ${canonicalPath}
    Wait Until Element Is Visible    ${MODAL_LOGO_IMG_EN_PRE}

Set Logo Link Th
    [Arguments]    ${link}
    Input Text    ${MODAL_LOGO_LINK_TH_TXT}    ${link}

Set Logo Link En
    [Arguments]    ${link}
    Input Text    ${MODAL_LOGO_LINK_EN_TXT}    ${link}

Logo Image Should Not Appear
    Wait Until Element Is Not Visible    ${LOGO_IMAGE}

Logo Image Should Appear
    [Arguments]    ${fileName}
    ${imgSrc}=    Selenium2Library.Get Element Attribute    ${LOGO_IMAGE}@src
    Should Contain    ${imgSrc}    ${fileName}

Set Status To Active
    Extended Select Checkbox   ${SET_STATUS_SWITCH_CHK}

Set Status To Inactive
    Unselect Checkbox    ${SET_STATUS_SWITCH_CHK}

Status Should Be Inactive
    Checkbox Should Not Be Selected    ${SET_STATUS_SWITCH_CHK}

Status Should Be Active
    Checkbox Should Be Selected    ${SET_STATUS_SWITCH_CHK}

Go To Preview Storefront
    [Arguments]    ${shop_slug}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    Location Should Contain    /${shop_slug}?

Go To Preview Storefront Mobile
    [Arguments]    ${shop_slug}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&is_mobile=1
    Location Should Contain    /${shop_slug}?
    Wait Until Angular Ready    30s

Go To Preview Storefront Mobile Secondary Language
    [Arguments]    ${shop_slug}
    Go To    ${WEMALL_WEB}/en/shop/${shop_slug}?${PRIVIEW_TOKEN}&is_mobile=1
    Location Should Contain    /en/shop/${shop_slug}?

Go To CMS Storefront
    Switch Browser    1
    Select Window    title=${CMS_STOREFRONT_TITLE}

# Preview Web
Close Preview Storefront Window
    [Arguments]    ${shop_slug}
    Go To Preview Storefront    ${shop_slug}
    Close Window
    Go To CMS Storefront

Verify Preview Storefront Window Contains Menus
    [Arguments]    ${shop_slug}    ${allMenuData}    ${logo}
    Go To Preview Storefront    ${shop_slug}
    Verify Menus    ${shop_slug}    ${allMenuData}    ${logo}
    Go To CMS Storefront

Verify Preview Storefront with Storefront Menu from Response
    [Arguments]    ${shop_slug}    ${shop_id}
    Go To Preview Storefront    ${shop_slug}
    Wait Until Angular Ready    30s
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${shop_id}    ${web_view}    version=draft
    Verify Menus with Expected Respones Data    ${Response}
    Go To CMS Storefront

Verify Preview Storefront Mobile with Storefront Menu from Response
    [Arguments]    ${shop_slug}    ${shop_id}
    Go To Preview Storefront Mobile    ${shop_slug}
    Wait Until Angular Ready    30s
    Click Element    jquery=.icon-menu-hamburger-dots
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${shop_id}    mobile    version=draft
    Verify Shop Menu Mobile with Response Data    ${Response}

Verify Preview Storefront Window Does Not Contains Menus
    [Arguments]    ${shop_slug}
    Go To Preview Storefront    ${shop_slug}
    Verify Menus Not Contain Menu
    Go To CMS Storefront

# Publish Web
Close Storefront Window
    [Arguments]    ${shop_slug}
    Close Storefront Page
    Switch Browser    1
    Go To CMS Storefront

Verify Storefront Window Contains Menus
    [Arguments]    ${shop_slug}    ${allMenuData}    ${logo}
    Go To Storefront Page    ${shop_slug}
    Verify Menus    ${shop_slug}    ${allMenuData}    ${logo}
    Go To CMS Storefront

Verify Published Storefront with Storefront Menu from Response
    [Arguments]    ${shop_slug}    ${shop_id}
    Go To Storefront Page    ${shop_slug}
    Wait Until Angular Ready    30s
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${shop_id}    ${web_view}    version=published
    Verify Menus with Expected Respones Data    ${Response}

Verify Published Storefront Mobile with Storefront Menu from Response
    [Arguments]    ${shop_slug}    ${shop_id}
    Go To Mobile Shop Page    ${shop_slug}
    Go To Mobile Shop Page    ${shop_slug}
    Wait Until Angular Ready    30s
    Click Element    jquery=.icon-menu-hamburger-dots
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${shop_id}    mobile    version=published
    Verify Shop Menu Mobile with Response Data    ${Response}
    Delete Is Mobile Cookie

Verify Storefront Window Does Not Contain Menus
    [Arguments]    ${shop_slug}
    Go To Storefront Page    ${shop_slug}
    Verify Menus Not Contain Menu
    Go To CMS Storefront

# Preview Mobile
Close Preview Storefront Mobile Window
    [Arguments]    ${shop_slug}
    Go To Preview Storefront Mobile    ${shop_slug}
    Close Window
    Go To CMS Storefront

Verify Preview Storefront Mobile Window Contains Menus
    [Arguments]    ${shop_slug}    ${allMenuData}
    Go To Preview Storefront Mobile    ${shop_slug}
    Verify Storefront Mobile Menu Data Primary Language    ${allMenuData}
    Go to Preview Storefront Mobile Secondary Language    ${shop_slug}
    Verify Storefront Mobile Menu Data Secondary Language    ${allMenuData}
    Go To    ${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&is_mobile=1
    Wait Until Angular Ready    30s

Verify Preview Storefront Mobile Window Does Not Contains Menus
    [Arguments]    ${shop_slug}
    Go To Preview Storefront Mobile    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    Go To Preview Storefront Mobile Secondary Language    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    Go To    ${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&is_mobile=1
    Wait Until Angular Ready    30s

# Publish Mobile
Close Storefront Mobile Window
    [Arguments]    ${shop_slug}
    Close Storefront Mobile Page
    Switch Browser    1
    Go To CMS Storefront

Verify Storefront Mobile Window Contains Menus
    [Arguments]    ${shop_slug}    ${allMenuData}
    Go To Storefront Mobile Page    ${shop_slug}
    Verify Storefront Mobile Menu Data Primary Language    ${allMenuData}
    Close Storefront Mobile Page
    Go to Storefront Mobile Page - Secondary Language    ${shop_slug}
    Verify Storefront Mobile Menu Data Secondary Language    ${allMenuDAta}
    Close Storefront Mobile Page
    Go To CMS Storefront

Verify Storefront Mobile Window Does Not Contain Menus
    [Arguments]    ${shop_slug}
    Go To Storefront Mobile Page    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    Close Storefront Mobile Page
    Go to Storefront Mobile Page - Secondary Language    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    Close Storefront Mobile Page
    Go To CMS Storefront

Verify Add Menu Popup Appears
    [Arguments]    ${level}
    Wait Until Element Is Visible    ${MODAL_DIALOG}
    Wait Until Element Contains      ${MODAL_DIALOG_HEADER}    ${ADD_MENU_HEADER_MSG}${level}

Verify Edit Menu Popup Appears
    [Arguments]    ${level}
    Wait Until Element Is Visible    ${MODAL_DIALOG}
    Wait Until Element Contains      ${MODAL_DIALOG_HEADER}    ${EDIT_MENU_HEADER_MSG}${level}

Verify Delete Menu Confirmation Dialog Appears
    [Arguments]    ${menuName}
    Wait Until Element Is Visible    ${MODAL_DIALOG}
    Wait Until Element Contains    ${MODAL_DIALOG_BODY}    Do you want to delete menu '${menuName}'?

Verify Delete Logo Confirmation Dialog Appears
    Wait Until Element Is Visible    ${MODAL_DIALOG}
    Wait Until Element Contains    ${MODAL_DIALOG_BODY}    ${MODAL_LOGO_DEL_MSG}

Verify Modal Dialog Alert Appears
    [Arguments]    ${msg}
    Wait Until Element Contains    ${MODAL_DIALOG_ALERT}    ${msg}

Verify Status Message Appears
    [Arguments]    ${msg}
    Wait Until Element Contains    ${ALERT_SUCCESS}    ${msg}

Verify Menu Data
    [Arguments]    @{data}
    ${file_name_th}=             Set Variable    ${EMPTY}
    Textfield Value Should Be    ${MODAL_DIALOG_NAME_TH_TXT}    @{data}[0]
    Textfield Value Should Be    ${MODAL_DIALOG_NAME_EN_TXT}    @{data}[1]
    Textfield Value Should Be    ${MODAL_DIALOG_LINK_TH_TXT}    @{data}[2]
    Textfield Value Should Be    ${MODAL_DIALOG_LINK_EN_TXT}    @{data}[3]
    Run Keyword If    @{data}[4]          Checkbox Should Be Selected        ${MODAL_DIALOG_NEW_TAB_CHK}
    ...    ELSE                           Checkbox Should Not Be Selected    ${MODAL_DIALOG_NEW_TAB_CHK}
    Run Keyword If    len($data) > 5      Menu Image Th Should Appear    @{data}[5]
    ...    ELSE                           Menu Image Th Should Not Appear
    Run Keyword If    len($data) > 6      Textfield Value Should Be      ${MODAL_DIALOG_IMG_ALT_TH}         @{data}[6]
    ...    ELSE                           Textfield Value Should Be      ${MODAL_DIALOG_IMG_ALT_TH}         ${EMPTY}
    Run Keyword If    len($data) > 7      Textfield Value Should Be      ${MODAL_DIALOG_IMG_LINK_TH}        @{data}[7]
    ...    ELSE                           Textfield Value Should Be      ${MODAL_DIALOG_IMG_LINK_TH}        ${EMPTY}
    Run Keyword If    len($data) > 8      Menu Image En Should Appear    @{data}[8]
    ...    ELSE                           Menu Image En Should Not Appear
    Run Keyword If    len($data) > 9      Textfield Value Should Be      ${MODAL_DIALOG_IMG_ALT_EN}         @{data}[9]
    ...    ELSE                           Textfield Value Should Be      ${MODAL_DIALOG_IMG_ALT_EN}         ${EMPTY}
    Run Keyword If    len($data) > 10     Textfield Value Should Be      ${MODAL_DIALOG_IMG_LINK_EN}        @{data}[10]
    ...    ELSE                           Textfield Value Should Be      ${MODAL_DIALOG_IMG_LINK_EN}        ${EMPTY}
    Run Keyword If    len($data) > 11 and $data[11]                      Checkbox Should Be Selected        ${MODAL_DIALOG_IMG_NEW_TAB_CHK}
    Run Keyword If    len($data) > 11 and (not $data[11])                Checkbox Should Not Be Selected    ${MODAL_DIALOG_IMG_NEW_TAB_CHK}
    Run Keyword If    len($data) <= 11                                   Checkbox Should Be Selected        ${MODAL_DIALOG_IMG_NEW_TAB_CHK}

Menu Panel List Should Contain
    [Arguments]    ${level}           @{varargs}
    ${list}=       Get Webelements    jquery=#level-${level} span.item-name
    ${actual}=     Create List
    ${rows} =      Get Length         ${list}
    : FOR    ${index}    IN RANGE     0    ${rows}
    \    ${menuName}=        Get Text     jquery=#level-${level} span.item-name:eq(${index})
    \    Append To List      ${actual}    ${menuName}
    Lists Should Be Equal    ${actual}    ${varargs}

Menu Panel List Is Empty
    [Arguments]    ${level}
    Locator Should Match X Times    jquery=#level-${level} span.item-name    0

Go To Menu Editor Page For Web
    [Arguments]    ${shop_id}
    Go To URL Shop List Page
    Go To Manage Storefront Page    ${shop_id}    web
    Click Menu Link on Management Page    ${shop_id}    Web

Go To Menu Editor Page For Mobile
    [Arguments]    ${shop_id}
    Go To URL Shop List Page
    Go To Manage Storefront Page    ${shop_id}    mobile
    Click Menu Link on Management Page    ${shop_id}    Mobile

Create Menu
    [Arguments]    ${level}    @{data}
    Click Add Menu Button    level=${level}
    Fill In Menu Data    @{data}
    Click Ok Button on Modal Dialog

