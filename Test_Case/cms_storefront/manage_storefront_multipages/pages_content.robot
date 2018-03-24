*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
   ...             AND    Open Storefront - Shop List Page

Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}

Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_pages_list_table_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_page_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_page_content_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_content/css_manage_shop_content_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/ckeditor/web_ckeditor_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot

*** Variables ***
${suite_shop_id}       HULK-TEST-PAGE-0001
${shop_name}           HULK-TEST-PAGE-0001
${status}              active
${shop_slug}           hulk-test-page-0001

${ckidprimary}         contents_html_primary
${ckidsecondary}       contents_html_secondary
${imgsource}           <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg" style="width: 1920px; height: 116px;" />
${cssFilePath}         ${CURDIR}/../../../Resource/TestData/storefronts/menu_template.css

*** Test Cases ***
TC_ITMWM_05222 Content CMS show saved content data - web and mobile
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05222    05222      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05222
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05222
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05222

    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Storefront CMS Page Content - Verify Page Content       web    draft     ${page_id}      ${imgsource}

    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Check Shop Name and Storefront View    ${shop_slug}    mobile
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05222
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Storefront CMS Page Content - Verify Page Content       mobile    draft     ${page_id}      ${imgsource}

TC_ITMWM_05223 Error message when click save without required field data
    [Tags]    cms_storefront    storefront_management     Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05223    05223      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05223
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05223
    Click Save for Content Storefront page
    Wait For Error Content Storefront page

TC_ITMWM_05224 Error message when click preview without required field data
    [Tags]    cms_storefront    storefront_management     Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05224    05224      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05224
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05224
    Click Preview Thai for Content Storefront page
    Wait For Error Content Storefront page
    Click Preview English for Content Storefront page
    Wait For Error Content Storefront page

TC_ITMWM_05225 Add pages content TH/EN then save as draft and preview TH/EN on web
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05225    05225      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05225
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05225
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05225

    ## WEB ##
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       Text_TH
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     Text_EN
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Storefront CMS Page Content - Verify Page Content      web    draft     ${page_id}      Text_TH
    Storefront CMS Page Content - Verify Page Content EN      web    draft     ${page_id}      Text_EN

    ## TODO Check preview on web

TC_ITMWM_05226 Add pages content TH/EN then save as draft and preview TH/EN on mobile
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Check Shop Name and Storefront View    ${shop_slug}    mobile
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05226    05226      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05226
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05226
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05226

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       Text_Mobile_TH
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     Text_Mobile_EN
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Storefront CMS Page Content - Verify Page Content      mobile    draft     ${page_id}      Text_Mobile_TH
    Storefront CMS Page Content - Verify Page Content EN      mobile    draft     ${page_id}      Text_Mobile_EN

    ## TODO Check preview on mobile

TC_ITMWM_05227 Preview EN show TH content data when user put only TH data - web
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05227    05227      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05227
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05227

    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05227

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       Text_TH
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Storefront CMS Page Content - Verify Page Content      web    draft     ${page_id}      Text_TH
    ## TODO Check preview on web

TC_ITMWM_05228 Preview EN show TH content data when user put only TH data - mobile
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Check Shop Name and Storefront View    ${shop_slug}    mobile
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05228    05228      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05228
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05228

    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05228

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       Text_Mobile_TH
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Storefront CMS Page Content - Verify Page Content      mobile    draft     ${page_id}      Text_Mobile_TH
    ## TODO Check preview on mobile

TC_ITMWM_05229 Upload image and get link URL then paste in pages content
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05229    05229      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05229
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05229

    CKEditor Wait Util Ready    ${ckidprimary}
    Input Image to Ckditor for TH Language
    Input Image to Ckditor for EN Language
    Click Save for Content Storefront page
    Wait For Success Content Storefront page

TC_ITMWM_05230 Edit pages content
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05230    05230      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05230
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05230
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05230

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       Text_TH
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     Text_EN
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page

    Storefront CMS Page Content - Verify Page Content      web    draft     ${page_id}      Text_TH
    Storefront CMS Page Content - Verify Page Content EN      web    draft     ${page_id}      Text_EN

TC_ITMWM_05231 Published pages content both language on web (Check clear cache too)
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05231    05231      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05231
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05231
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05231

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       Text_TH
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     Text_EN
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Click Publish for Content Storefront page

    Storefront CMS Page Content - Verify Page Content      web    published     ${page_id}      Text_TH
    Storefront CMS Page Content - Verify Page Content EN      web    published     ${page_id}      Text_EN

TC_ITMWM_05232 Published pages content both language on mobile (Check clear cache too)
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Check Shop Name and Storefront View    ${shop_slug}    mobile
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05232    05232      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05232
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05232
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05232

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       Text_Mobile_TH
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     Text_Mobile_EN
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Click Publish for Content Storefront page

    Storefront CMS Page Content - Verify Page Content      mobile    published     ${page_id}      Text_Mobile_TH
    Storefront CMS Page Content - Verify Page Content EN      mobile    published     ${page_id}      Text_Mobile_EN

TC_ITMWM_05233 
    [Documentation]    Upload CSS for pages content
    [Tags]    cms_storefront    storefront_management     Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05233    05233      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05233
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05233
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05233

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}    ${imgsource}
    Upload CSS    ${cssFilePath}
    Verify CSS Is Uploaded    ${page_id}    web

TC_ITMWM_05234 Upload file less than limit file size (set limit = 10MB) - pages content
    [Tags]    cms_storefront    storefront_management     Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05234    05234      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05234
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05234
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05234

    Wait Until Angular Ready    60s
    Add Image    ${IMAGE_UPLOAD}    ${IMAGE_LT_10MB}
    Wait Until Element Is Visible    ${IMAGE_UPLOAD_ICON}
    Wait Until Element Is Not Visible    ${IMAGE_UPLOAD_ICON}    120s

TC_ITMWM_05235 Upload file large than limit file size (set limit = 10MB) - pages content
    [Tags]    cms_storefront    storefront_management     Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05235     05235       on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05235
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        05235
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    05235

    Wait Until Angular Ready    60s
    Add Image    ${IMAGE_UPLOAD}    ${IMAGE_GT_10MB}
    ${class}=    Get Element Attribute    ${IMAGE_ALERT}@class
    Should Not Contain    ${class}    ng-hide
    ${txt}=    Get Text    ${IMAGE_ALERT}
    Should Be Equal    ${txt}    Upload failed
    ${txt}=    Get Text    ${IMAGE_ALERT_LIST}
    Should Be Equal    ${txt}    file_type_10.gif - File size is more than 10MB


*** Keywords ***
Teardown Close Window
    [Arguments]    ${suite_shop_id}    ${view}
    Close Window
    Select Window    url=${STOREFRONT_CMS}/#/storefrontManagement/${suite_shop_id}/${view}



















