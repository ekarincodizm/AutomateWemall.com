*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}

Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_banner/css_manage_shop_banner_keywords.robot
Library             Selenium2Library
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/

*** Variables ***
${suite_shop_id}       LG014014
${shop_name}           LG Shop
${status}              active
${shop_slug}           lg-shop

${img}                 <img alt="" src="http://alpha-cdn.wemall-dev.com/th/Header/MTH10000_images/banner-storefront.png" style="width: 1920px; height: 116px;">
${type}             banner
${draft}            draft
${module}           Banner
${published}        published
${web_link}         Web
${mobile_link}      Mobile
${web_view}         web
${mobile_view}      mobile
${data}             <p>data</p>
${active_status}    active
${inactive_status}    inactive
${overlap_1_and_2_position}     1,2
# Banner No. 1
${bannerName1}              Banner1
${bannerOrder1}             1
${bannerStatus1}            active
${bannerNewTab1}             ${TRUE}
${bannerLinkTh1}            http://www.itruemart.com
${bannerLinkEn1}            http://www.itruemart.com/en
${bannerAltTh1}             iTruemart
${bannerAltEn1}             iTruemart EN
${bannerImageThTxt1}
${bannerImageEnTxt1}
@{banner1}                  ${bannerName1}     ${bannerOrder1}     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner2}                  bannerName2     2     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner3}                  bannerName3     3     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner4}                  bannerName4     4     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner5}                  bannerName5     5     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner6}                  bannerName6     6     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner7}                  bannerName7     7     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner8}                  bannerName8     8     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner9}                  bannerName9     9     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner10}                 bannerName10     10     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner11}                 bannerName11     11     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner12}                 bannerName12     12     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner13}                 bannerName13     13     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner14}                 bannerName14     14     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}
@{banner15}                 bannerName15     15     ${bannerStatus1}    ${bannerNewTab1}    ${bannerLinkTh1}    ${bannerLinkEn1}   ${bannerAltTh1}     ${bannerAltEn1}    ${bannerAltEn1}    ${bannerImageThTxt1}    ${bannerImageEnTxt1}

${prepareBannerPictureTh}       Nike_Lebron.jpeg
${prepareBannerPictureEn}       Nike_Jordan_CP3.jpeg
#//alpha-cdn.wemall-dev.com/th/banner_web/MTH10183_images/FotorB3TH.jpg?v=90eebc73?2016-01-07 02:23:53

*** Test Cases ***
############################# Web #############################
TC_WMALL_00089 Banner list table - Show data of web view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    ${type}    ${prepare_expected_banner}
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web_link}
    Wait Until Angular Ready    30s
    Banner List Table Should Display
    Verify Data In Banner List Table    ${suite_shop_id}    ${web_view}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_01230 Banner list table - Show data of mobile view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    ${type}    ${prepare_expected_banner}
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Click Banner Link on Management Page    ${suite_shop_id}    ${mobile_link}
    Wait Until Angular Ready    30s
    Banner List Table Should Display
    Verify Data In Banner List Table    ${suite_shop_id}    ${mobile_view}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00090 Banner list table - Filter Active/Inactive
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_Medium
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    ${type}    ${prepare_expected_banner}

    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Banner List Table Should Display
    Click Filter By Active Banner
    ${banner_table}=    Get All Banner Name From Banner List Table
    ${banner_from_api}=    Get Banner Name From API Service By Banner Status    ${suite_shop_id}    ${web_view}    ${active_status}
    Check List Should Be Equal    ${banner_table}    ${banner_from_api}    Banner name list not equal
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_00095 Active/Inactive toggle
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    ${type}    ${prepare_expected_banner}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Banner List Table Should Display
    Click Filter By Active Banner
    ${banner_table}=    Get All Banner Name From Banner List Table
    ${banner_from_api}=    Get Banner Name From API Service By Banner Status    ${suite_shop_id}    ${web_view}    ${active_status}
    Check List Should Be Equal    ${banner_table}    ${banner_from_api}    Banner name list not equal
    Click Filter By Inactive Banner
    ${banner_table}=    Get All Banner Name From Banner List Table
    ${banner_from_api}=    Get Banner Name From API Service By Banner Status    ${suite_shop_id}    ${web_view}     ${inactive_status}
    Log to console     ${banner_from_api}
    Check List Should Be Equal    ${banner_table}    ${banner_from_api}    Banner name list not equal
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_00096 Add new banner for web view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Click Add for Banner Storefront page
    Input Banner Required Field    @{banner1}
    Click OK For Banner Form
    Banner List Table Should Display
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    Click Filter By Active Banner
    ${banner_table}=    Get All Banner Name From Banner List Table
    ${banner_from_api}=    Get Banner Name From API Service By Banner Status    ${suite_shop_id}    ${web_view}    ${active_status}
    Check List Should Be Equal    ${banner_table}    ${banner_from_api}    Banner name list not equal
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_01231 Add new banner for mobile view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${mobile_link}
    Wait Until Angular Ready    30s
    Click Add for Banner Storefront page
    Input Banner Required Field    @{banner1}
    Click OK For Banner Form
    Banner List Table Should Display
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    Click Filter By Active Banner
    ${banner_table}=    Get All Banner Name From Banner List Table
    ${banner_from_api}=    Get Banner Name From API Service By Banner Status    ${suite_shop_id}    ${mobile_view}    ${active_status}
    Check List Should Be Equal    ${banner_table}    ${banner_from_api}    Banner name list not equal
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00097 Banner required field
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Click Add for Banner Storefront page
    Validate Banner Require Field    @{banner1}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00098 Set invalid start or end date
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Click Add for Banner Storefront page
    Input Banner Required Field    @{banner1}
    Set Start Date    -30
    Set End Date      2
    Click OK For Banner Form
    Wait For Start Date Greater Than Current Date For Banner Form
    Set Start Date    30
    Set End Date      -5
    Click OK For Banner Form
    Wait For End Date Greater Than Start Date For Banner Form
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00099 Change banner name
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_Medium
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    ${type}    ${prepare_expected_banner}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    60S
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready     60S
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready     60S
    Banner List Table Should Display
    Click Edit for Banner       0
    Update Banner Name Field    ${bannerName1}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00100 Change alt and link
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    ${type}    ${prepare_expected_banner}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    60S
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready     60S
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready     60S
    Banner List Table Should Display
    Click Edit for Banner       0
    Update Banner ALT AND LINK Field        ${suite_shop_id}    ${web_view}    0      @{banner1}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00101 Change banner picture
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    ${banner_data}=     Get Banner Image From API Service    ${suite_shop_id}    ${web_view}    0
    Verify Banner Picture TH    ${banner_data}    ${prepareBannerPictureTh}
    Verify Banner Picture EN    ${banner_data}    ${prepareBannerPictureEn}
    Click Edit for Banner    0
    Input Banner Image TH
    Input Banner Image EN
    Click OK For Banner Form
    Wait Until Angular Ready    30s
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    ${banner_data}=     Get Banner Image From API Service    ${suite_shop_id}    ${web_view}    0
    Verify Banner Picture TH    ${banner_data}    FotorB3TH.jpg
    Verify Banner Picture EN    ${banner_data}    FotorB3US.jpg
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_00102 Change banner start and end date
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_Medium
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    ${type}    ${prepare_expected_banner}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    60S
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready     60S
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready     60S
    Banner List Table Should Display
    Click Edit for Banner       0
    Update Banner Start And End Date Field        ${suite_shop_id}    ${web_view}    0
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00104 Change banner status for web view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Click Filter By All Banner
    Check Banner Status     ${suite_shop_id}      ${web_view}         ${active_status}        0
    Change Status for Banner Storefront page      0
    Click Save for Banner Storefront page
    Check Banner Status     ${suite_shop_id}      ${web_view}         ${inactive_status}      0
    Change Status for Banner Storefront page      0
    Click Save for Banner Storefront page
    Check Banner Status     ${suite_shop_id}      ${web_view}         ${active_status}        0
    Change Status for Banner Storefront Edit Page    0
    Check Banner Status     ${suite_shop_id}      ${web_view}         ${inactive_status}      0
    Change Status for Banner Storefront Edit Page    0
    Check Banner Status     ${suite_shop_id}      ${web_view}         ${active_status}        0
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_01232 Change banner status for mobile view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${mobile_link}
    Wait Until Angular Ready    30s
    Click Filter By All Banner
    Check Banner Status     ${suite_shop_id}      ${mobile_view}         ${active_status}         0
    Change Status for Banner Storefront page    0
    Click Save for Banner Storefront page
    Check Banner Status     ${suite_shop_id}      ${mobile_view}         ${inactive_status}       0
    Change Status for Banner Storefront page    0
    Click Save for Banner Storefront page
    Check Banner Status     ${suite_shop_id}      ${mobile_view}         ${active_status}         0
    Change Status for Banner Storefront Edit Page    0
    Check Banner Status     ${suite_shop_id}      ${mobile_view}         ${inactive_status}       0
    Change Status for Banner Storefront Edit Page    0
    Check Banner Status     ${suite_shop_id}      ${mobile_view}         ${active_status}         0
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00107 Set cell order to 1-15
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Create Banner By Order Number       2       @{banner2}
    Create Banner By Order Number       3       @{banner3}
    Create Banner By Order Number       4       @{banner4}
    Create Banner By Order Number       5       @{banner5}
    Create Banner By Order Number       6       @{banner6}
    Create Banner By Order Number       7       @{banner7}
    Create Banner By Order Number       8       @{banner8}
    Create Banner By Order Number       9       @{banner9}
    Create Banner By Order Number       10       @{banner10}
    Create Banner By Order Number       11       @{banner11}
    Create Banner By Order Number       12       @{banner12}
    Create Banner By Order Number       13       @{banner13}
    Create Banner By Order Number       14       @{banner14}
    Create Banner By Order Number       15       @{banner15}
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    Verify Banner Name and Order Between List Table And API     ${suite_shop_id}    ${web_view}
    sleep       5
    Create Banner By Order Number       2       @{banner1}
    Click Save for Banner Storefront page
    Wait For Banner Overlapping Message     2
#   Test when add a banner order more than maximum order
    Create Banner By Order Number       16       @{banner15}
    Click Save for Banner Storefront page
    Wait For Banner Overlapping Message     ${overlap_1_and_2_position}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_00108 Delete Banner for web view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Click Filter By All Banner
    Click Delete Banner By Name And Order Number     New Nike Shoe     1
    Verify Delete Banner By Name And Order Number    ${suite_shop_id}     ${web_view}     New Nike Shoe     1
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_01233 Delete Banner for mobile view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${mobile_link}
    Wait Until Angular Ready    30s
    Click Filter By All Banner
    Click Delete Banner By Name And Order Number     Seasonal Sale     2
    Verify Delete Banner By Name And Order Number    ${suite_shop_id}     ${mobile_view}     Seasonal Sale     2
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00110 Preview button for web view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    sleep       60s
    ${windows_location}=     Get Location
    Click Preview Thai for Banner Storefront page
    Verify Preview Banner Storefront Web    ${shop_slug}    ${suite_shop_id}      ${web_view}     ${windows_location}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_01235 Preview button for mobile view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${mobile_link}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    sleep       60s
    ${windows_location}=     Get Location
    Click Preview Thai for Banner Storefront page
    Verify Preview Banner Storefront Mobile    ${shop_slug}    ${suite_shop_id}      ${mobile_view}    ${windows_location}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00111 Save button for web view - Overlap active time
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    sleep       60s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Banner Overlapping Message     1
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_00112 Save button for mobile view - Overlap active time
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${mobile_link}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    sleep       60s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Banner Overlapping Message     1
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00113 Publish button for web view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Create Storefront Data From Input File    ${suite_shop_id}     ${web_view}     ${prepare_content}
    Prepare Content For Banner Web     ${suite_shop_id}

    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready    30s
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${web_link}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    Click Publish for Banner Storefront page
    Wait For Publish Success Banner Storefront page
    Log to console      test case is sleeping 60s
    sleep       60s
    Verify Published Banner Storefront Web      ${shop_slug}    ${suite_shop_id}      ${web_view}
    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    content
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_01236 Publish button for mobile view
    [Tags]    Regression    cms_storefront    cms_storefront_banner    WLS_High
    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    content
    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}
    Create Storefront Data From Input File    ${suite_shop_id}     ${mobile_view}     ${prepare_content}
    ####Create Storefront Data From Input File    ${suite_shop_id}     ${web_view}     ${prepare_content}
    Prepare Content For Banner Mobile     ${suite_shop_id}

    Go to URL Shop List Page
    Shop List Table Should Display
    Wait Until Angular Ready        10s
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Wait Until Angular Ready    30s
    Click Banner Link on Management Page    ${suite_shop_id}    ${mobile_link}
    Wait Until Angular Ready    30s
    Create Banner By Order Number       1       @{banner1}
    Click Save for Banner Storefront page
    Wait For Success Banner Storefront page
    Click Publish for Banner Storefront page
    Wait For Publish Success Banner Storefront page
    Log to console      test case is sleeping 60s
    sleep       60s
    Verify Published Banner Storefront Mobile      ${shop_slug}    ${suite_shop_id}      ${mobile_view}
    #
    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    content
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}