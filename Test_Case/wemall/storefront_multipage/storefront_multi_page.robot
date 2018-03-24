*** Settings ***
Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
   ...             AND    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}

Library             Selenium2Library
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_pages_list_table_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_page_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_page_content_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_content/css_manage_shop_content_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_content/webelement_manage_shop_content.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/ckeditor/web_ckeditor_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_banner/css_manage_shop_banner_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_menu/css_manage_shop_menu_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_multi_page/storefront_multi_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot

*** Variables ***
${suite_shop_id}       HULK-TEST-PAGE-0002
${shop_name}           HULK-TEST-PAGE-0002
${status}              active
${shop_slug}           hulk-test-page-0002

${temp_suite_shop_id}       HULK-TEST-PAGE-temp
${temp_shop_name}           HULK-TEST-PAGE-temp
${temp_status}              active
${temp_shop_slug}           hulk-test-page-temp

${imgsource}           <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg" style="width: 1920px; height: 116px;" />
${imgsource_en}        <img alt="" src="http://alpha-cdn.wemall-dev.com/en/content/MTH10000_web_images/content-storefront.jpg?lang=en" style="width: 1920px; height: 116px;" />
${pageContentPic}                http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg
${pageContentPicEn}              http://alpha-cdn.wemall-dev.com/en/content/MTH10000_web_images/content-storefront.jpg?lang=en
${cssFilePath}         ${CURDIR}/../../../Resource/TestData/storefronts/menu_template.css

#Shop Content
${ckidprimary}         contents_html_primary
${ckidsecondary}       contents_html_secondary
${storefrontContent}                .store-front-main-content

#Shop Header
${storefrontHeader}         div.inner-store-header
${storefrontHeaderMobile}    div.storefront-header div.storefront-cover
${shopHeaderPic}            //sandbox-cdn.wemall-dev.com/th/Header/MTH10000_images/cover.png
${shopHeaderPicEn}          //sandbox-cdn.wemall-dev.com/th/Header/MTH10000_images/cover.png?lang=en

#Shop footer
${storefrontFooter}         div.body-wrapper
${shopFooterPic}            //sandbox-cdn.wemall-dev.com/th/Footer/MTH10000_images/hqdefault.jpg
${shopFooterPicEn}          //sandbox-cdn.wemall-dev.com/th/Footer/MTH10000_images/hqdefault.jpg?lang=en

#Shop Banner
${storefrontBanner}         .store-front-highlight-section
${shopBannerPic}            Image 01 TH
${shopBannerPicEn}          Image 01 EN

${test_content_en}     ${CURDIR}/../../../Resource/TestData/storefronts/merchant_template_en.txt
${test_content_th}     ${CURDIR}/../../../Resource/TestData/storefronts/merchant_template_th.txt

*** Test Cases ***
### Desktop ###
TC_ITMWM_05236 Active shop, Active pages and have published data on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05236
    ${page_slug}=               Set Variable       tc-itmwm-05236
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPic}
    Verify Window Preview Storefront Web TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPicEn}
    Verify Window Preview Storefront Web EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Click Publish for Content Storefront page

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPic}
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPic}
    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPicEn}
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPicEn}

TC_ITMWM_05237 Active shop, Active pages but not have published data on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05237
    ${page_slug}=               Set Variable       tc-itmwm-05237
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPic}
    Verify Window Preview Storefront Web TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPicEn}
    Verify Window Preview Storefront Web EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/shop/${shop_slug}

    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/en/shop/${shop_slug}

TC_ITMWM_05238 Active shop, Inactive pages and have published data on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05238
    ${page_slug}=               Set Variable       tc-itmwm-05238
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       inactive

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPic}
    Verify Window Preview Storefront Web TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPicEn}
    Verify Window Preview Storefront Web EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Click Publish for Content Storefront page

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/shop/${shop_slug}

    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/en/shop/${shop_slug}


TC_ITMWM_05239 Inactive shop, Active pages and have published data on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Run Keywords    Storefront Multi Page - Prepare Shop        ${suite_shop_id}     ${shop_name}    ${shop_slug}    inactive
    ...             AND         Storefront Multi Page - Prepare Shop ALL Content    ${temp_suite_shop_id}

    ${page_name}=               Set Variable       TC_ITMWM_05239
    ${page_slug}=               Set Variable       tc-itmwm-05239
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    Storefront Multi Page - Prepare Page    ${temp_suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${temp_suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${temp_suite_shop_id}    ${page_name}

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPic}
    Verify Window Preview Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPic}
    Verify Window Preview Storefront Web TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPicEn}
    Verify Window Preview Storefront Web EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    web    content    1
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Click Publish for Content Storefront page

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/pageNotFound

    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/pageNotFound

    [Teardown]      Prepare Storefront With Content for Storefront API    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}

TC_ITMWM_05240 Shop exist but pages not exist on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    ${page_slug}=               Set Variable       tc-itmwm-05240
    Go to Storefront Window Path    ${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be              ${WEMALL_WEB}/shop/${shop_slug}
    Go To Storefront Window Path En     ${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be                  ${WEMALL_WEB}/en/shop/${shop_slug}

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    Location Should Be              ${WEMALL_WEB}/shop/${shop_slug}
    Go To Storefront Window Path En     ${shop_slug}/${page_slug}
    Location Should Be                  ${WEMALL_WEB}/en/shop/${shop_slug}

TC_ITMWM_05241 Shop and pages not exist on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    ${shop_slug}=               Set Variable       tc-itmwm-05241
    ${page_slug}=               Set Variable       tc-itmwm-05241

    Go to Storefront Window Path    ${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be              ${WEMALL_WEB}/pageNotFound
    Go To Storefront Window Path En     ${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be                  ${WEMALL_WEB}/pageNotFound

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    Location Should Be              ${WEMALL_WEB}/pageNotFound
    Go To Storefront Window Path En     ${shop_slug}/${page_slug}
    Location Should Be                  ${WEMALL_WEB}/pageNotFound

TC_ITMWM_05242 Pages show shop header, shop menu and shop footer but content form pages on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05242
    ${page_slug}=               Set Variable       tc-itmwm-05242
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}

    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPic}
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPic}
    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeader}       ${shopHeaderPicEn}
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontFooter}       ${shopFooterPicEn}

TC_ITMWM_05243 Pages content turn on/off shop banner on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05243
    ${page_slug}=               Set Variable       tc-itmwm-05243
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}

    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPic}

    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web En Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPicEn}

    ## off shop banner ##
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Edit Page By Page Name       ${suite_shop_id}        ${page_name}
    Storefront CMS Page Management - Fill Page Banner Display           off
    Storefront CMS Page Management - Click Save On Page From

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    sleep       1s
    ${status}=      Run Keyword and return status        Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPic}
    Should Be Equal	    '${status}'         'False'

    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    sleep       1s
    ${status}=      Run Keyword and return status        Verify Window Storefront Web En Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPicEn}
    Should Be Equal	    '${status}'         'False'

TC_ITMWM_05244 Pages have only TH content on web
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05244
    ${page_slug}=               Set Variable       tc-itmwm-05244
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

    Go to Storefront Window Path    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}

    Go To Storefront Window Path En    ${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}

TC_ITMWM_05245 Shop have multi pages (check 5-7 pages) on web (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}

    ${page_name}=               Set Variable       TC_ITMWM_05245
    ${page_slug}=               Set Variable       tc-itmwm-05245
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    #Prepare page
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}-1    ${page_slug}-1    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}-2    ${page_slug}-2    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}-3    ${page_slug}-3    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}-4    ${page_slug}-4    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}-5    ${page_slug}-5    ${page_display_banner}    ${page_status}

    ##Verify page content
    Storefront Multi Page - Verify page content     ${suite_shop_id}        web        ${shop_slug}        ${page_name}     ${page_slug}       1
    Storefront Multi Page - Verify page content     ${suite_shop_id}        web        ${shop_slug}        ${page_name}     ${page_slug}       2
    Storefront Multi Page - Verify page content     ${suite_shop_id}        web        ${shop_slug}        ${page_name}     ${page_slug}       3
    Storefront Multi Page - Verify page content     ${suite_shop_id}        web        ${shop_slug}        ${page_name}     ${page_slug}       4
    Storefront Multi Page - Verify page content     ${suite_shop_id}        web        ${shop_slug}        ${page_name}     ${page_slug}       5

TC_ITMWM_05246 Alignment Pages Content TH for Web
    [Tags]      Regression      Storefront      Multi page
    ${page_name}=               Set Variable       TC_ITMWM_05246
    ${page_slug}=               Set Variable       tc-itmwm-05246
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    #Prepare page
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}

    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    ${content}=    Get File    ${test_content_th}
    CKEditor Input Text    ${ckidprimary}    ${content}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview Thai for Content Storefront page
    Verify Window Preview Storefront Web TH Alignment Center    ${shop_slug}/${page_slug}
    Close Window
    Select Window    title=WeMall: CMS Storefront

TC_ITMWM_05247 Alignment Pages Content EN for Web
    [Tags]      Regression      Storefront      Multi page
    ${page_name}=               Set Variable       TC_ITMWM_05247
    ${page_slug}=               Set Variable       tc-itmwm-05247
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active

    #Prepare page
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    web    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}

    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    ${content}=    Get File    ${test_content_th}
    CKEditor Input Text    ${ckidprimary}    ${content}
    ${content}=    Get File    ${test_content_en}
    CKEditor Input Text    ${ckidsecondary}    ${content}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Preview Thai for Content Storefront page
    Verify Window Preview Storefront Web TH Alignment Center    ${shop_slug}/${page_slug}
    Close Window
    Select Window    title=WeMall: CMS Storefront

### Mobile ###
TC_ITMWM_05248 Active shop, Active pages and have published data on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05248
    ${page_slug}=               Set Variable       tc-itmwm-05248
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active
    ${site}=                    Set Variable       mobile

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPic}
    Verify Window Preview Storefront Mobile TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Mobile EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Click Publish for Content Storefront page

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPic}
    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPicEn}

TC_ITMWM_05249 Active shop, Active pages but not have published data on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05249
    ${page_slug}=               Set Variable       tc-itmwm-05249
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active
    ${site}=                    Set Variable       mobile

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPic}
    Verify Window Preview Storefront Mobile TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Mobile EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/shop/${shop_slug}

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/en/shop/${shop_slug}

TC_ITMWM_05250 Active shop, Inactive pages and have published data on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05250
    ${page_slug}=               Set Variable       tc-itmwm-05250
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       inactive
    ${site}=                    Set Variable       mobile

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPic}
    Verify Window Preview Storefront Mobile TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Mobile EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Click Publish for Content Storefront page

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/shop/${shop_slug}

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/en/shop/${shop_slug}

TC_ITMWM_05251 Inactive shop, Active pages and have published data on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Run Keywords    Storefront Multi Page - Prepare Shop        ${suite_shop_id}     ${shop_name}    ${shop_slug}    inactive
    ...             AND         Storefront Multi Page - Prepare Shop ALL Content    ${temp_suite_shop_id}

    ${page_name}=               Set Variable       TC_ITMWM_05251
    ${page_slug}=               Set Variable       tc-itmwm-05251
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active
    ${site}=                    Set Variable       mobile

    Storefront Multi Page - Prepare Page    ${temp_suite_shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${temp_suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${temp_suite_shop_id}    ${page_name}

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}
    Click Preview Thai for Content Storefront page

    sleep       1s
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Preview Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPic}
    Verify Window Preview Storefront Mobile TH Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront
    Click Preview English for Content Storefront page
    sleep       1s
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Preview Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPicEn}
    Verify Window Preview Storefront Mobile EN Contains CSS        ${shop_slug}/${page_slug}     ${page_id}    ${site}    content
    Close Window
    Select Window    title=WeMall: CMS Storefront

    Click Publish for Content Storefront page

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/pageNotFound

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    Location Should Be    ${WEMALL_WEB}/pageNotFound

    [Teardown]    Prepare Storefront With Content for Storefront API    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}

TC_ITMWM_05252 Shop exist but pages not exist on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    ${page_slug}=               Set Variable       tc-itmwm-05252
    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be                         ${WEMALL_WEB}/shop/${shop_slug}
    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be                         ${WEMALL_WEB}/en/shop/${shop_slug}

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    Location Should Be                         ${WEMALL_WEB}/shop/${shop_slug}
    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    Location Should Be                         ${WEMALL_WEB}/en/shop/${shop_slug}

TC_ITMWM_05253 Shop and pages not exist on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    ${shop_slug}=               Set Variable       tc-itmwm-05253
    ${page_slug}=               Set Variable       tc-itmwm-05253

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be                         ${WEMALL_WEB}/pageNotFound
    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}?${PRIVIEW_TOKEN}
    Location Should Be                         ${WEMALL_WEB}/pageNotFound

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    Location Should Be                         ${WEMALL_WEB}/pageNotFound
    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    Location Should Be                         ${WEMALL_WEB}/pageNotFound

TC_ITMWM_05254 Pages show shop header, shop menu and shop footer but content form pages on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05254
    ${page_slug}=               Set Variable       tc-itmwm-05254
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active
    ${site}=                    Set Variable       mobile

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}

    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}

    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}
    Verify Window Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPic}
    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPicEn}
    Verify Window Storefront Mobile EN Contains            ${shop_slug}/${page_slug}     ${storefrontHeaderMobile}       ${shopHeaderPicEn}

TC_ITMWM_05255 Pages content turn on/off shop banner on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05255
    ${page_slug}=               Set Variable       tc-itmwm-05255
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active
    ${site}=                    Set Variable       mobile

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}     ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Upload CSS    ${cssFilePath}

    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPic}

    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Mobile En Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPicEn}

    ## off shop banner ##
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Edit Page By Page Name       ${suite_shop_id}        ${page_name}
    Storefront CMS Page Management - Fill Page Banner Display           off
    Storefront CMS Page Management - Click Save On Page From

    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    sleep       1s
    ${status}=      Run Keyword and return status        Verify Window Storefront Mobile TH Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPic}
    Should Be Equal     '${status}'         'False'

    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    sleep       1s
    ${status}=      Run Keyword and return status        Verify Window Storefront Mobile En Contains            ${shop_slug}/${page_slug}     ${storefrontBanner}      ${shopBannerPicEn}
    Should Be Equal     '${status}'         'False'

TC_ITMWM_05256 Pages have only TH content on mobile
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}
    ${page_name}=               Set Variable       TC_ITMWM_05244
    ${page_slug}=               Set Variable       tc-itmwm-05244
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active
    ${site}=                    Set Variable       mobile

    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${page_display_banner}    ${page_status}
    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${suite_shop_id}        ${page_name}
    ${page_id}=         Storefront CMS Page Management - Get Page Id From Page Name         ${suite_shop_id}    ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Input Text    ${ckidprimary}       ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}

    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}

    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug}
    sleep       1s
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug}     ${storefrontContent}      ${pageContentPic}

TC_ITMWM_05257 Shop have multi pages (check 5-7 pages) on mobile (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]     Storefront Multi Page - Prepare Shop ALL Content    ${suite_shop_id}

    ${page_name}=               Set Variable       TC_ITMWM_05245
    ${page_slug}=               Set Variable       tc-itmwm-05245
    ${page_display_banner}=     Set Variable       on
    ${page_status}=             Set Variable       active
    ${site}=                    Set Variable       mobile

    #Prepare page
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}-1    ${page_slug}-1    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}-2    ${page_slug}-2    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}-3    ${page_slug}-3    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}-4    ${page_slug}-4    ${page_display_banner}    ${page_status}
    Storefront Multi Page - Prepare Page    ${suite_shop_id}    ${shop_slug}    ${site}    ${page_name}-5    ${page_slug}-5    ${page_display_banner}    ${page_status}

    ##Verify page content
    Storefront Multi Page - Verify page content Mobile     ${suite_shop_id}        ${site}        ${shop_slug}        ${page_name}     ${page_slug}       1
    Storefront Multi Page - Verify page content Mobile     ${suite_shop_id}        ${site}        ${shop_slug}        ${page_name}     ${page_slug}       2
    Storefront Multi Page - Verify page content Mobile     ${suite_shop_id}        ${site}        ${shop_slug}        ${page_name}     ${page_slug}       3
    Storefront Multi Page - Verify page content Mobile     ${suite_shop_id}        ${site}        ${shop_slug}        ${page_name}     ${page_slug}       4
    Storefront Multi Page - Verify page content Mobile     ${suite_shop_id}        ${site}        ${shop_slug}        ${page_name}     ${page_slug}       5

TC_ITMWM_05258 Only Mobile page have content (Storefront web/mobile and Page web no content data)
    [Tags]      Regression      Storefront      Multi page
    [Setup]    Run Keywords    Storefront Multi Page - Prepare Shop    ${temp_suite_shop_id}    ${temp_shop_name}    ${temp_shop_slug}    ${temp_status}
   ...             AND    Storefront Multi Page - Prepare Page    ${temp_suite_shop_id}    ${temp_shop_slug}    mobile    TC_ITMWM_05258    tc-itmwm-05258    on    active
   ...             AND    Storefront Multi Page - Prepare Page Content    ${temp_suite_shop_id}    ${temp_shop_slug}    mobile    TC_ITMWM_05258

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05258
    Location Should Be    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05258
    Storefront Multi Page - Verify Mobile View

    [Teardown]    Delete Shop and All Storefront Data    ${temp_suite_shop_id}


TC_ITMWM_05663 Storefront web/mobile and Page web have content but mobile page do not have content (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]    Run Keywords    Storefront Multi Page - Prepare Shop                         ${temp_suite_shop_id}    ${temp_shop_name}    ${temp_shop_slug}    ${temp_status}
   ...             AND         Storefront - Prepare Storefront Content Data Both Version    ${temp_suite_shop_id}    web
   ...             AND         Storefront - Prepare Storefront Content Data Both Version    ${temp_suite_shop_id}    mobile
   ...             AND         Storefront Multi Page - Prepare Page                         ${temp_suite_shop_id}    ${temp_shop_slug}    mobile    TC_ITMWM_05663    tc-itmwm-05663    on    active
   ...             AND         Storefront Multi Page - Prepare Page Content                 ${temp_suite_shop_id}    ${temp_shop_slug}    web    TC_ITMWM_05663

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05663
    Location Should Be    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05663
    Storefront Multi Page - Verify Web View

    [Teardown]    Delete Shop and All Storefront Data    ${temp_suite_shop_id}

TC_ITMWM_05664 Storefront and page web have content data but Storefront and page mobile do not have content (TH/EN
    [Tags]      Regression      Storefront      Multi page
    [Setup]    Run Keywords    Storefront Multi Page - Prepare Shop                         ${temp_suite_shop_id}    ${temp_shop_name}    ${temp_shop_slug}    ${temp_status}
   ...             AND         Storefront - Prepare Storefront Content Data Both Version    ${temp_suite_shop_id}    web
   ...             AND         Storefront Multi Page - Prepare Page                         ${temp_suite_shop_id}    ${temp_shop_slug}    mobile    TC_ITMWM_05663    tc-itmwm-05663    on    active
   ...             AND         Storefront Multi Page - Prepare Page Content                 ${temp_suite_shop_id}    ${temp_shop_slug}    web    TC_ITMWM_05663

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05663
    Location Should Be    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05663
    Storefront Multi Page - Verify Web View

    [Teardown]    Delete Shop and All Storefront Data    ${temp_suite_shop_id}

TC_ITMWM_05665 Storefront web/mobile have content but page web/mobile do not have content (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]    Run Keywords    Storefront Multi Page - Prepare Shop                         ${temp_suite_shop_id}    ${temp_shop_name}    ${temp_shop_slug}    ${temp_status}
   ...             AND         Storefront - Prepare Storefront Content Data Both Version    ${temp_suite_shop_id}    web
   ...             AND         Storefront - Prepare Storefront Content Data Both Version    ${temp_suite_shop_id}    mobile
   ...             AND         Storefront Multi Page - Prepare Page                         ${temp_suite_shop_id}    ${temp_shop_slug}    mobile    TC_ITMWM_05665    tc-itmwm-05665    on    active

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05665
    Location Should Be    ${WEMALL_WEB}/shop/hulk-test-page-temp
    Storefront Multi Page - Verify Mobile View

    [Teardown]    Delete Shop and All Storefront Data    ${temp_suite_shop_id}

TC_ITMWM_05666 Only storefront web have content data. (Storefront mobile and page web/mobile do not have content data)
    [Tags]      Regression      Storefront      Multi page
    [Setup]    Run Keywords    Storefront Multi Page - Prepare Shop    ${temp_suite_shop_id}    ${temp_shop_name}    ${temp_shop_slug}    ${temp_status}
   ...             AND    Storefront - Prepare Storefront Content Data Both Version    ${temp_suite_shop_id}    web
   ...             AND    Storefront Multi Page - Prepare Page    ${temp_suite_shop_id}    ${temp_shop_slug}    mobile    TC_ITMWM_05666    tc-itmwm-05666    on    active

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05666
    Location Should Be    ${WEMALL_WEB}/shop/hulk-test-page-temp
    Storefront Multi Page - Verify Web View

    [Teardown]    Delete Shop and All Storefront Data    ${temp_suite_shop_id}


TC_ITMWM_05667 Storefront web/mobile and Page web/mobile do not have content (TH/EN)
    [Tags]      Regression      Storefront      Multi page
    [Setup]    Run Keywords    Storefront Multi Page - Prepare Shop    ${temp_suite_shop_id}    ${temp_shop_name}    ${temp_shop_slug}    ${temp_status}
   ...             AND    Storefront Multi Page - Prepare Page    ${temp_suite_shop_id}    ${temp_shop_slug}    mobile    TC_ITMWM_05667    tc-itmwm-05667    on    active

    Go To Wemall Mobile URL With Reload Url    ${WEMALL_WEB}/shop/hulk-test-page-temp/tc-itmwm-05667
    Location Should Contain    ${WEMALL_WEB}/pageNotFound
    Storefront Multi Page - Verify Web View

    [Teardown]    Delete Shop and All Storefront Data    ${temp_suite_shop_id}


*** Keywords ***
Storefront Multi Page - Prepare Page
    [Arguments]    ${shop_id}    ${shop_slug}    ${site}    ${page_name}    ${page_slug}    ${main_banner}    ${staus}
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${shop_id}    ${site}
    Check Shop Name and Storefront View    ${shop_slug}    ${site}
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    ${page_name}    ${page_slug}      ${main_banner}          ${staus}
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${shop_id}        ${page_name}

Storefront Multi Page - Prepare Shop
    [Arguments]    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
    Set Suite Variable    ${swap_suite_shop_id}    ${suite_shop_id}
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
    Set Suite Variable    ${temp_suite_shop_id}    ${suite_shop_id}
    Set Suite Variable    ${suite_shop_id}    ${swap_suite_shop_id}

Storefront Multi Page - Prepare Page Content
    [Arguments]    ${shop_id}    ${shop_slug}    ${site}    ${page_name}        ${imgsource}=${imgsource}       ${imgsource_en}=${imgsource_en}
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${shop_id}    ${site}
    Check Shop Name and Storefront View    ${shop_slug}    ${site}

    Storefront CMS Page Management - Click Edit Page Content By Page Name       ${shop_id}        ${page_name}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    CKEditor Input Text    ${ckidprimary}      ${imgsource}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    CKEditor Input Text    ${ckidsecondary}    ${imgsource_en}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page
    Wait For Publish Content Storefront page

Storefront Multi Page - Verify page content
    [Arguments]         ${suite_shop_id}        ${view}     ${shop_slug}        ${page_name}        ${page_slug}                ${page_number}
    ${page_content}=        Set Variable       <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?page=${page_number}" style="width: 1920px; height: 116px;" />
    ${page_content_en}=     Set Variable       <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?lang=en&page=${page_number}" style="width: 1920px; height: 116px;" />

    ${page_slug_check}=         Set Variable    ${page_slug}-${page_number}
    ${page_content_check}=      Set Variable        http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?page=${page_number}
    ${page_content_check_en}=      Set Variable     http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?lang=en&page=${page_number}

    Storefront Multi Page - Prepare Page Content        ${suite_shop_id}        ${shop_slug}        ${view}     ${page_name}-${page_number}    ${page_content}    ${page_content_en}
    Go to Storefront Window Path    ${shop_slug}/${page_slug_check}
    sleep       1s
    Verify Window Storefront Web TH Contains            ${shop_slug}/${page_slug_check}     ${storefrontContent}      ${page_content_check}
    Go To Storefront Window Path En    ${shop_slug}/${page_slug_check}
    sleep       1s
    Verify Window Storefront Web EN Contains            ${shop_slug}/${page_slug_check}     ${storefrontContent}      ${page_content_check_en}

Storefront Multi Page - Verify page content Mobile
    [Arguments]         ${suite_shop_id}        ${view}     ${shop_slug}        ${page_name}        ${page_slug}                ${page_number}
    ${page_content}=        Set Variable       <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?page=${page_number}" style="width: 1920px; height: 116px;" />
    ${page_content_en}=     Set Variable       <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?lang=en&page=${page_number}" style="width: 1920px; height: 116px;" />

    ${page_slug_check}=         Set Variable    ${page_slug}-${page_number}
    ${page_content_check}=      Set Variable        http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?page=${page_number}
    ${page_content_check_en}=      Set Variable     http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg?lang=en&page=${page_number}

    Storefront Multi Page - Prepare Page Content        ${suite_shop_id}        ${shop_slug}        ${view}     ${page_name}-${page_number}    ${page_content}    ${page_content_en}
    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/shop/${shop_slug}/${page_slug_check}
    sleep       1s
    Verify Window Storefront Mobile TH Contains            ${shop_slug}/${page_slug_check}     ${storefrontContent}      ${page_content_check}
    Go To Wemall Mobile URL With Reload Url                ${WEMALL_WEB}/en/shop/${shop_slug}/${page_slug_check}
    sleep       1s
    Verify Window Storefront Mobile EN Contains            ${shop_slug}/${page_slug_check}     ${storefrontContent}      ${page_content_check_en}

Storefront Multi Page - Prepare Shop ALL Content
    [Arguments]         ${shop_id}
    ### Shop Content ###
    ${content_data}=         Set Variable       ${CURDIR}/../../../Resource/TestData/storefronts/prepare_data/put_data/prepare_content.json
    Update Storefront Data From Input File      ${shop_id}    web       ${content_data}
    Update Storefront Data From Input File      ${shop_id}    mobile    ${content_data}

    ### Shop menu   ###
    ${menu_data}=         Set Variable          ${CURDIR}/../../../Resource/TestData/storefronts/prepare_data/put_data/prepare_menu.json
    Update Storefront Data From Input File      ${shop_id}    web       ${menu_data}
    Update Storefront Data From Input File      ${shop_id}    mobile    ${menu_data}

    ### Shop banner ###
    ${banner_data}=         Set Variable        ${CURDIR}/../../../Resource/TestData/storefronts/banner_data/update_banner_success_01.json
    Update Storefront Data From Input File      ${shop_id}    web       ${banner_data}
    Update Storefront Data From Input File      ${shop_id}    mobile    ${banner_data}

    ### Shop header ###
    ${header_data}=         Set Variable        ${CURDIR}/../../../Resource/TestData/storefronts/prepare_data/put_data/prepare_header.json
    Update Storefront Data From Input File      ${shop_id}    web       ${header_data}
    Update Storefront Data From Input File      ${shop_id}    mobile    ${header_data}

    ### Footer ###
    ${footer_data}=         Set Variable        ${CURDIR}/../../../Resource/TestData/storefronts/prepare_data/put_data/prepare_footer.json
    Update Storefront Data From Input File      ${shop_id}    web       ${footer_data}
    Update Storefront Data From Input File      ${shop_id}    mobile    ${footer_data}

    ### Publish All ###
    Publish Storefront Data     ${shop_id}    content    web
    Publish Storefront Data     ${shop_id}    content    mobile
    Publish Storefront Data     ${shop_id}    menu    web
    Publish Storefront Data     ${shop_id}    menu    mobile
    Publish Storefront Data     ${shop_id}    banner    web
    Publish Storefront Data     ${shop_id}    banner    mobile
    Publish Storefront Data     ${shop_id}    header    web
    Publish Storefront Data     ${shop_id}    header    mobile
    Publish Storefront Data     ${shop_id}    footer    web
    Publish Storefront Data     ${shop_id}    footer    mobile
