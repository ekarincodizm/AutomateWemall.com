*** Settings ***
Library             HttpLibrary.HTTP
Library             Collections
Library             OperatingSystem
Library             Selenium2Library
Library             Collections
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Library             ${CURDIR}/../../../../Python_Library/requestapi.py
Library             ${CURDIR}/../../../../Python_Library/jsonLibrary.py
Library             ${CURDIR}/../../../../Python_Library/sortedlibrary.py
Library             ${CURDIR}/../../../../Python_Library/dateTimeUtil.py
Library             ${CURDIR}/../../../../Python_Library/common.py
Library             ${CURDIR}/../../../API/api_storefronts/storefront.py
Resource            ${CURDIR}/../../wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../API/common/api_keywords.robot
Resource            ${CURDIR}/../../../../Resource/TestData/storefronts/storefront_data.robot
Resource            ${CURDIR}/../manage_shop_header/webelement_manage_shop_header.robot
Resource            ${CURDIR}/webelement_manage_shop_banner.robot
Resource            ${CURDIR}/../../wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../manage_shop_content/css_manage_shop_content_keywords.robot
Resource            ${CURDIR}/../common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../ckeditor/web_ckeditor_keywords.robot

*** Variables ***
${web_view}                     web
${mobile_view}                  mobile
${banner_url}                   /web?type=banner
${raw_mode}                     raw
${ckidprimary}                  html_primary
${ckidsecondary}                html_secondary
${img}                          <img alt="" src="http://alpha-cdn.wemall-dev.com/th/Header/MTH10000_images/banner-storefront.png" style="width: 1920px; height: 116px;">
${content_module}               Content

*** Keywords ***
Banner List Table Should Display
    Wait Until Element Is Visible    ${table_banner_list}    20S

Get All Banner Name From Banner List Table
    Banner List Table Should Display
    ${banner_name}=    Create List
    ${list} =   Get Webelements    ${table_banner_list} tr.ng-scope
    ${rows} =   Get Length    ${list}
    : FOR    ${index}    IN RANGE    0    ${rows}
    \    ${banner}=    Get Text    ${table_banner_list} tr.ng-scope:eq(${index}) td:eq(1)
    \    Append To List    ${banner_name}    ${banner}
    # ${mechat_name}=    Remove Duplicates    ${mechat_name}
    # Log List    ${mechat_name}
    Log to console    ${banner_name}
    [Return]    ${banner_name}

Get All Banner Name From API Service
    [Arguments]    ${shop_id}    ${site_view}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}    version=${draft}    mode=raw
    ${banner_name}=    Get Title Banner List    ${banner_response}
    [Return]    ${banner_name}

Get Banner Name From API Service By Banner Status
    [Arguments]    ${shop_id}    ${site_view}    ${status}
    Log to console    ${status}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}    version=${draft}    mode=${raw_mode}
    Log to console    ${banner_response}
    ${banner_name}=    Get Banner List By Banner Status    ${banner_response}    ${status}
    [Return]    ${banner_name}

Get Banner Status From API Service
    [Arguments]    ${shop_id}    ${site_view}    ${index}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${draft}    mode=${raw_mode}
    ${banner_data}=    Get Banner List By Index    ${banner_response}    ${index}
    ${banner_status}=    Get From Dictionary    ${banner_data}    status
    [Return]    ${banner_status}

Check Banner Status
    [Arguments]    ${shop_id}    ${site_view}    ${status}      ${index}
    ${banner_status}=    Get Banner Status From API Service    ${shop_id}    ${site_view}    ${index}
    Should Be Equal     ${banner_status}    ${status}

Get Banner Image From API Service
    [Arguments]    ${shop_id}    ${site_view}    ${index}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${draft}    mode=${raw_mode}
    ${banner_data}=    Get Banner List By Index    ${banner_response}    ${index}
    [Return]    ${banner_data}

Verify Banner Picture TH
    [Arguments]    ${banner_data}    ${pictureName}
    ${banner_data}=     Get From Dictionary     ${banner_data}      name
    ${image}=     Get From Dictionary     ${banner_data}      image
    Should Contain      ${image}    ${pictureName}

Verify Banner Picture EN
    [Arguments]    ${banner_data}    ${pictureName}
    ${banner_data}=     Get From Dictionary     ${banner_data}      name_translation
    ${image}=     Get From Dictionary     ${banner_data}      image
    Should Contain      ${image}    ${pictureName}

Change Status for Banner Storefront page
    [Arguments]    ${index}
    Click Element and Wait Angular Ready       ${STATUS_BANNER_BUTTON}:eq(${index})
    Wait Until Angular Ready    30s

Change Status for Banner Storefront Edit Page
    [Arguments]    ${index}
    Click Edit for Banner    ${index}
    Click Change Status For Banner Form
    Click OK For Banner Form
    Banner List Table Should Display
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page

Click Change Status For Banner Form
    Click Element and Wait Angular Ready    ${STATUS_BANNER_BUTTON_FOR_BANNER_FORM}:eq(0)
    Wait Until Angular Ready    30s

Verify Data In Banner List Table
    [Arguments]    ${shop_id}    ${site_view}
    ${banner_name_list_from_table}=    Get All Banner Name From Banner List Table
    ${banner_name_list_from_api}=    Get All Banner Name From API Service    ${shop_id}    ${site_view}
    Check List Should Be Equal    ${banner_name_list_from_table}    ${banner_name_list_from_api}    Banner name list not equal

View Banner List for Banner Storefront page
    #Click Element and Wait Angular Ready    ${ADD_BANNER_BUTTON}

Click Add for Banner Storefront page
    Wait Until Angular Ready    30s
    Click Element and Wait Angular Ready    ${ADD_BANNER_BUTTON}
    Wait Until Element Is Visible    ${MODAL_BANNER_NAME_TH_TXT}        90s

Click Save for Banner Storefront page
    Click Element and Wait Angular Ready    ${SAVE_BANNER_BUTTON}

Click Preview Thai for Banner Storefront page
    Click Element and Wait Angular Ready    ${PREVIEW_BANNER_BUTTON}

Click Publish for Banner Storefront page
    Click Element and Wait Angular Ready    ${PUBLISH_BANNER_BUTTON}

Wait For Success Banner Storefront page
    Wait Until Element Contains     ${ALERT_BANNER_SUCCESS}    ${SAVE_BANNER_SUCCESS}       30s

Wait For Publish Success Banner Storefront page
    Wait Until Element Contains     ${ALERT_BANNER_SUCCESS}    ${PUBLISH_BANNER_SUCCEED}        30s

Wait For Error Banner Storefront page
    Wait Until Element Contains     ${ALERT_BANNER_ERROR}      ${ERROR_MESSAGE}     30s

Wait For Error Banner Form Storefront page
    Wait Until Element Contains     ${MODAL_BANNER_ALERT}    ${ERROR_BANNER_REQUIRED_MESSAGE}       30s

Wait For Start Date Greater Than Current Date For Banner Form
    Wait Until Element Contains     ${MODAL_BANNER_ALERT}       ${ERROR_BANNER_START_DATE_GREATER_CURRENT_DATE}     30s

Wait For End Date Greater Than Start Date For Banner Form
    Wait Until Element Contains     ${MODAL_BANNER_ALERT}       ${ERROR_BANNER_END_DATE_GREATER_START_DATE}     30s

Wait For Start Date Missing For Banner Form
    Wait Until Element Contains     ${MODAL_BANNER_ALERT}       ${ERROR_BANNER_START_DATE_MISSING}      30s

Wait For End Date Missing For Banner Form
    Wait Until Element Contains     ${MODAL_BANNER_ALERT}       ${ERROR_BANNER_END_DATE_MISSING}        30s

Wait For Banner Overlapping Message
    [Arguments]     ${overlap_position}
    Wait Until Element Contains     ${ALERT_MAIN_BANNER_ERROR}       ${ERROR_BANNER_OVERLAPPING} [${overlap_position}]      30S

Click Filter By Active Banner
    Click Element and Wait Angular Ready   ${BANNER_FILTER}
    Click Element and Wait Angular Ready   ${ACTIVE_BANNER_STATUS}

Click Filter By Inactive Banner
    Click Element and Wait Angular Ready   ${BANNER_FILTER}
    Click Element and Wait Angular Ready   ${INACTIVE_BANNER_STATUS}

Click Filter By All Banner
    Click Element and Wait Angular Ready   ${BANNER_FILTER}
    Click Element and Wait Angular Ready   ${ALL_BANNER_STATUS}

Click Edit for Banner
    [Arguments]     ${index}
    Wait Until Angular Ready    30s
    Click Element and Wait Angular Ready   ${EDIT_BANNER_BUTTON}:eq(${index})
    Wait Until Element Is Visible    ${MODAL_BANNER_NAME_TH_TXT}        30s

Click Delete for Banner
    [Arguments]     ${index}
    Click Element and Wait Angular Ready   ${DELETE_BANNER_BUTTON}:eq(${index})
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible    ${MODAL_BANNER_CONFIRM_DELETE}     30s
    Click Element and Wait Angular Ready   ${BANNER_CONFIRM_DELETE_BUTTON}
    Wait Until Angular Ready    30s
    Click Save for Banner Storefront page
    Wait Until Angular Ready    30s

Click Delete Banner By Name And Order Number
    [Arguments]     ${bannerName}       ${orderNumber}
    ${index}=       Get Banner Index By Name And Order ID    ${bannerName}      ${orderNumber}
    Click Delete for Banner    ${index}

Get Banner Index By Name And Order ID
    [Arguments]     ${bannerName}       ${orderNumber}
    ${banner_table} =   Get Webelements    ${table_banner_list} tr.ng-scope
    ${banner_rows} =   Get Length    ${banner_table}
    ${banner_order_list} =    Create List
    ${banner_title_list} =    Create List
    : FOR    ${index}    IN RANGE    0    ${banner_rows}
    \    ${banner_order}=    Get Text    ${table_banner_list} tr.ng-scope:eq(${index}) td:eq(0)
    \    ${banner_title}=    Get Text    ${table_banner_list} tr.ng-scope:eq(${index}) td:eq(1)
    \    Append To List     ${banner_order_list}    ${banner_order}
    \    Append To List     ${banner_title_list}    ${banner_title}
    ${index}=    Get Banner Index By Name List And Order List    ${bannerName}    ${orderNumber}    ${banner_title_list}    ${banner_order_list}
    [Return]    ${index}

Verify Delete Banner By Name And Order Number
    [Arguments]     ${shop_id}    ${site_view}    ${bannerName}    ${orderNumber}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${draft}    mode=${raw_mode}
    ${banner_title_list}=    Get Title Banner List    ${banner_response}
    ${banner_order_list}=    Get Order Banner List    ${banner_response}
    ${index}=    Get Banner Index By Name List And Order List    ${bannerName}    ${orderNumber}    ${banner_title_list}    ${banner_order_list}
    ${index}=    Convert To String    ${index}
    Should Be Equal    ${index}    -1

Click OK For Banner Form
    Click Element and Wait Angular Ready    ${OK_BANNER_FORM_BUTTON}

Input Banner Required Field
    [Arguments]    @{data}
    Input Text    ${MODAL_BANNER_NAME_TH_TXT}           @{data}[0]
    Input Text    ${MODAL_BANNER_ORDER_TXT}             @{data}[1]
    #Input Text    ${MODAL_BANNER_STATUS_TXT}            @{data}[2]
    #Input Text    ${MODAL_BANNER_NEW_TAB_TXT}           @{data}[3]
    Input Text    ${MODAL_BANNER_LINK_TH_TXT}           @{data}[4]
    Input Text    ${MODAL_BANNER_LINK_EN_TXT}           @{data}[5]
    Input Text    ${MODAL_BANNER_ALT_TH_TXT}            @{data}[6]
    Input Text    ${MODAL_BANNER_ALT_EN_TXT}            @{data}[7]
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_TH_TXT}    ${MODAL_BANNER_WEB_IMAGE_TH_PATH}    ${MODAL_BANNER_WEB_IMAGE_TH_ID}
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_EN_TXT}    ${MODAL_BANNER_WEB_IMAGE_EN_PATH}    ${MODAL_BANNER_WEB_IMAGE_EN_ID}

Input Banner Image TH
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_TH_TXT}    ${MODAL_BANNER_WEB_IMAGE_TH_PATH}    ${MODAL_BANNER_WEB_IMAGE_TH_ID}
    Wait Until Angular Ready    30s

Input Banner Image EN
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_EN_TXT}    ${MODAL_BANNER_WEB_IMAGE_EN_PATH}    ${MODAL_BANNER_WEB_IMAGE_EN_ID}
    Wait Until Angular Ready    30s

Set Banner Image
    [Arguments]    ${imageFileNameTag}    ${imagePath}    ${imageFileNameTagId}
    ${canonicalPath}=    Get Canonical Path    ${imagePath}
    Choose File    ${imageFileNameTag}    ${canonicalPath}
    Wait Until Element Is Visible    ${imageFileNameTagId}    45s
    Wait Until Angular Ready    30s

Validate Banner Require Field
    [Arguments]    @{data}
    Click OK For Banner Form
    Wait For Error Banner Form Storefront page
    Input Text    ${MODAL_BANNER_NAME_TH_TXT}           @{data}[0]

    Input Text    ${MODAL_BANNER_ORDER_TXT}             @{data}[1]
    Click OK For Banner Form
    Wait For Error Banner Form Storefront page

    Input Text    ${MODAL_BANNER_LINK_TH_TXT}           @{data}[4]
    Click OK For Banner Form
    Wait For Error Banner Form Storefront page

    Input Text    ${MODAL_BANNER_LINK_EN_TXT}           @{data}[5]
    Click OK For Banner Form
    Wait For Error Banner Form Storefront page

    Input Text    ${MODAL_BANNER_ALT_TH_TXT}            @{data}[6]
    Click OK For Banner Form
    Wait For Error Banner Form Storefront page

    Input Text    ${MODAL_BANNER_ALT_EN_TXT}            @{data}[7]
    Click OK For Banner Form
    Wait For Error Banner Form Storefront page

    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_TH_TXT}    ${MODAL_BANNER_WEB_IMAGE_TH_PATH}    ${MODAL_BANNER_WEB_IMAGE_TH_ID}
    Click OK For Banner Form
    Wait For Error Banner Form Storefront page

    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_EN_TXT}    ${MODAL_BANNER_WEB_IMAGE_EN_PATH}    ${MODAL_BANNER_WEB_IMAGE_EN_ID}
    Click OK For Banner Form

Update Banner Name Field
    [Arguments]    ${name}
    Input Text    ${MODAL_BANNER_NAME_TH_TXT}           ${name}
    Click OK For Banner Form
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page

Set Start Date
    [Arguments]    ${minutes}
    ${dateTimeText} =    Get Date Time    minutes    ${minutes}
    Wait Until Element Is Visible       ${START_DATE_INPUT}     30s
    Click Element and Wait Angular Ready                       ${START_DATE_INPUT}
    Clear Element Text                  ${START_DATE_INPUT}
    sleep       1
    Input Text                          ${START_DATE_INPUT}        ${dateTimeText}
    Click Element and Wait Angular Ready                       ${ADD_BANNER_TITLE}
    [Return]    ${dateTimeText}

Set End Date
    [Arguments]    ${minutes}
    ${dateTimeText} =    Get Date Time    minutes    ${minutes}
    Wait Until Element Is Visible       ${END_DATE_INPUT}       30s
    Click Element and Wait Angular Ready                       ${END_DATE_INPUT}
    Clear Element Text                  ${END_DATE_INPUT}
    sleep       1
    Input Text                          ${END_DATE_INPUT}        ${dateTimeText}
    Click Element and Wait Angular Ready                       ${ADD_BANNER_TITLE}
    [Return]    ${dateTimeText}

Update Banner ALT AND LINK Field
    [Arguments]     ${shop_id}    ${site_view}    ${index}      @{data}
    Input Text    ${MODAL_BANNER_LINK_TH_TXT}           @{data}[4]
    Input Text    ${MODAL_BANNER_LINK_EN_TXT}           @{data}[5]
    Input Text    ${MODAL_BANNER_ALT_TH_TXT}            @{data}[6]
    Input Text    ${MODAL_BANNER_ALT_EN_TXT}            @{data}[7]
    Click OK For Banner Form
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page

    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}    version=${draft}     mode=${raw_mode}
    ${banner}=    Get Banner List By Index    ${banner_response}    ${index}

    # Get Node of primary and secondary lang.
    ${dataNodeTH}=    Get From Dictionary    ${banner}    name
    ${dataNodeEN}=    Get From Dictionary    ${banner}    name_translation

    #Assert the link th field value.
    ${linkTh}=    Get From Dictionary    ${dataNodeTH}    link
    ${inputLinkTh}=    Set Variable     @{data}[4]
    Should Be Equal As Strings      ${linkTh}     ${inputLinkTh}

    #Assert the link en field value.
    ${linkEn}=    Get From Dictionary    ${dataNodeEN}    link
    ${inputLinkEn}=    Set Variable     @{data}[5]
    Should Be Equal As Strings      ${linkEn}     ${inputLinkEn}

    #Assert the alt th field value.
    ${altTh}=    Get From Dictionary    ${dataNodeTH}    alt
    ${inputAltTh}=    Set Variable     @{data}[6]
    Should Be Equal As Strings      ${altTh}     ${inputAltTh}

    #Assert the alt en field value.
    ${altEn}=    Get From Dictionary    ${dataNodeEN}    alt
    ${inputAltEn}=    Set Variable     @{data}[7]
    Should Be Equal As Strings      ${altEn}     ${inputAltEn}

Update Banner Start And End Date Field
    [Arguments]     ${shop_id}    ${site_view}    ${index}
    ${startDateInDatePicker}=        Set Start Date     5
    Log to console     ${startDateInDatePicker}
    ${endDateInDatePicker}=          Set End Date       60
    Log to console     ${endDateInDatePicker}

    Click OK For Banner Form
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page

    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}    version=${draft}     mode=${raw_mode}
    ${banner}=    Get Banner List By Index    ${banner_response}    ${index}

    ${startDateFromDB}=    Get From Dictionary    ${banner}    start_date
    ${startDateTime}=     Convert String To Time      ${startDateFromDB}      ${BANNER_DATE_FORMAT_FROM_DB}
    ${startDateTimeString}=     Convert Date Time To String      ${startDateTime}      ${BANNER_DATE_FORMAT_FOR_DISPLAY}
    Should Be Equal As Strings      ${startDateTimeString}     ${startDateInDatePicker}

    ${endDateFromDB}=    Get From Dictionary    ${banner}    end_date
    ${endDateTime}=     Convert String To Time      ${endDateFromDB}      ${BANNER_DATE_FORMAT_FROM_DB}
    ${endDateTimeString}=     Convert Date Time To String      ${endDateTime}      ${BANNER_DATE_FORMAT_FOR_DISPLAY}
    Should Be Equal As Strings      ${endDateTimeString}     ${endDateInDatePicker}


Create Banner By Order Number
    [Arguments]    ${order}     @{data}
    Click Add for Banner Storefront page
    Input Text    ${MODAL_BANNER_NAME_TH_TXT}           @{data}[0]
    Input Text    ${MODAL_BANNER_ORDER_TXT}             ${order}
    Set Start Date     1
    Set End Date       60
    Input Text    ${MODAL_BANNER_LINK_TH_TXT}           @{data}[4]
    Input Text    ${MODAL_BANNER_LINK_EN_TXT}           @{data}[5]
    Input Text    ${MODAL_BANNER_ALT_TH_TXT}            @{data}[6]
    Input Text    ${MODAL_BANNER_ALT_EN_TXT}            @{data}[7]
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_TH_TXT}    ${MODAL_BANNER_WEB_IMAGE_TH_PATH}    ${MODAL_BANNER_WEB_IMAGE_TH_ID}
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_EN_TXT}    ${MODAL_BANNER_WEB_IMAGE_EN_PATH}    ${MODAL_BANNER_WEB_IMAGE_EN_ID}
    Click OK For Banner Form

Create Banner By Order Number With Start And End Time
    [Arguments]    ${order}     ${plusMinuteStart}    ${plusMinuteEnd}    @{data}
    Click Add for Banner Storefront page
    Input Text    ${MODAL_BANNER_NAME_TH_TXT}           @{data}[0]
    Input Text    ${MODAL_BANNER_ORDER_TXT}             ${order}
    Set Start Date     ${plusMinuteStart}
    Set End Date       ${plusMinuteEnd}
    Input Text    ${MODAL_BANNER_LINK_TH_TXT}           @{data}[4]
    Input Text    ${MODAL_BANNER_LINK_EN_TXT}           @{data}[5]
    Input Text    ${MODAL_BANNER_ALT_TH_TXT}            @{data}[6]
    Input Text    ${MODAL_BANNER_ALT_EN_TXT}            @{data}[7]
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_TH_TXT}    ${MODAL_BANNER_WEB_IMAGE_TH_PATH}    ${MODAL_BANNER_WEB_IMAGE_TH_ID}
    Set Banner Image    ${MODAL_BANNER_WEB_IMAGE_FILE_EN_TXT}    ${MODAL_BANNER_WEB_IMAGE_EN_PATH}    ${MODAL_BANNER_WEB_IMAGE_EN_ID}
    Click OK For Banner Form

Verify Banner Name and Order Between List Table And API
    [Arguments]    ${shop_id}    ${site_view}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${draft}     mode=${raw_mode}

    Banner List Table Should Display
    ${banner_list}=    Create List
    ${banner_table} =   Get Webelements    ${table_banner_list} tr.ng-scope
    ${banner_rows} =   Get Length    ${banner_table}
    : FOR    ${index}    IN RANGE    0    ${banner_rows}
    \    ${banner_order}=    Get Text    ${table_banner_list} tr.ng-scope:eq(${index}) td:eq(0)
    \    ${banner_title}=    Get Text    ${table_banner_list} tr.ng-scope:eq(${index}) td:eq(1)
    \    ${banner_data}=    Get Banner List By Index    ${banner_response}    ${index}
    \    ${banner_order_api}=    Get From Dictionary    ${banner_data}    order
    \    ${banner_title_api}=    Get From Dictionary    ${banner_data}    title
    \    Should Be Equal As Strings      ${banner_order}     ${banner_order_api}
    \    Should Be Equal As Strings      ${banner_title}     ${banner_title_api}

Prepare Content For Banner
    [Arguments]    ${shop_id}      ${site_view}
    Go to URL Shop List Page
    Click Create Merchant for Web    ${shop_id}
    Click Link on Management Page    ${shop_id}    ${content_module}    ${site_view}
    Wait Until Angular Ready    30s
    Sleep     2s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Sleep     2s
    CKEditor Input Text    ${ckidprimary}    ${img}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

Prepare Content For Banner Mobile
    [Arguments]    ${shop_id}
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click the Publish Button on the storefront Management Page

Prepare Content For Banner Web
    [Arguments]    ${shop_id}
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Sleep    1s
    Click the Publish Button on the storefront Management Page

    #Click Link on Management Page    ${shop_id}    ${content_module}    ${site_view}
    #Wait Until Angular Ready    30s
    #CKEditor Wait Util Ready    ${ckidprimary}
    #Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    #CKEditor Input Text    ${ckidprimary}    ${img}
    #Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    #Click Save for Content Storefront page
    #Wait For Success Content Storefront page
    #Click Publish for Content Storefront page

Verify Banner Image Storefront
    [Arguments]     ${banner_response}
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible    ${DIV_BANNER_ON_FRONTEND}      60s
    ${banner_datas}=        Get Data Item From Json Response     ${banner_response}
    ${banner_datas}=        Get From Dictionary     ${banner_datas}     banner
    ${banner_datas}=        Get From Dictionary     ${banner_datas}     data
    ${banner_rows} =        Get Length    ${banner_datas}
    : FOR    ${index}    IN RANGE    0    ${banner_rows}
    \    ${banner_data}=    Get Banner List By Index    ${banner_response}    ${index}
    \    ${banner_data}=    Get From Dictionary     ${banner_data}      name
    \    ${banner_link}=    Get From Dictionary     ${banner_data}      link
    \    ${banner_image}=    Get From Dictionary    ${banner_data}      image
    \    Element Should Be Visible     ${banner_storefront_index}:eq(${index}) a[href="${banner_link}"]       30s
    \    Element Should Be Visible     ${banner_storefront_index}:eq(${index}) img[src="${banner_image}"]     30s

Verify Preview Banner Storefront Web
    [Arguments]     ${shop_slug}    ${shop_id}      ${site_view}    ${windows_location}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${draft}     mode=
    Verify Banner Image Storefront     ${banner_response}
    Close Window
    Select Window    url=${windows_location}

Verify Published Banner Storefront Web
    [Arguments]     ${shop_slug}    ${shop_id}      ${site_view}
    Go to    ${WEMALL_WEB}/shop/${shop_slug}
    ${banner_response}=     Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${published}     mode=
    Verify Banner Image Storefront     ${banner_response}

Verify Preview Banner Storefront Mobile
    [Arguments]     ${shop_slug}    ${shop_id}      ${site_view}    ${windows_location}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    ${banner_response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${draft}     mode=
    Verify Banner Image Storefront     ${banner_response}
    Close Window
    Select Window    url=${windows_location}

Verify Published Banner Storefront Mobile
    [Arguments]     ${shop_slug}    ${shop_id}      ${site_view}
    Go to    ${WEMALL_WEB}/shop/${shop_slug}
    Add Cookie      is_mobile    true
    Reload Page
    ${banner_response}=     Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${site_view}     version=${published}     mode=
    Verify Banner Image Storefront     ${banner_response}
