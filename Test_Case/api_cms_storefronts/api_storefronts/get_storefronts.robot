*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup         Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Suite Teardown      Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Library             ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py
Resource            ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot

*** Variables ***
${merchant_id}              NIKE30000
${shop_name}                Nike Store
${slug}                     nike
${status}                   active
${draft}                    draft
${published}                published
${lang_thai}                th_TH
${lang_english}             en_US
${primary_lang}             name
${secondary_lang}           name_translation
${web_view}                 web
${mobile_view}              mobile
${invalid_shop_id}          TH9999999999999999999
${invalid_type}             invalid_type
${invalid_version}          invalid_version
${invalid_lang}             invalid_lang
${invalid_view}             invalid_view

*** Test Cases ***
############################# Web #############################
# Type
TC_WMALL_00213 Get Storefront Web Header Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}

TC_WMALL_00214 Get Storefront Web Active Menu Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}

TC_WMALL_01245 Get Storefront Web Active Menu with Mode Raw Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}

TC_WMALL_01246 Get Storefront Web Inactive Menu Success but Will Get Empty Data
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_menu}

TC_WMALL_01247 Get Storefront Web Inactive Menu with Mode Raw Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_inactive_menu}
    [Teardown]    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_menu}

TC_WMALL_00215 Get Storefront Web Banner Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}

TC_WMALL_00216 Get Storefront Web Banner with Mode Raw Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner_raw_mode}

TC_WMALL_00217 Get Storefront Web Content Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}

TC_WMALL_00218 Get Storefront Web Footer Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}

TC_WMALL_00219 Get Storefront Web UpdateTime Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront UpdateTime    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}
    Response UpdateTime Should Contain Data    ${Response}

# Version
TC_WMALL_00220 Get Storefront Web Draft Version Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Version Draft Should Contain Data    ${Response}    ${suite_shop_id}

TC_WMALL_00221 Get Storefront Web Published Version Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Version Publish Should Contain Data    ${Response}    ${suite_shop_id}

# Language
TC_WMALL_00222 Get Storefront Web Thai Language Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    lang=${lang_thai}    version=${draft}
    Response Should Contain Only Filter Language Data    ${Response}    ${primary_lang}

TC_WMALL_00223 Get Storefront Web English Language Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    lang=${lang_english}    version=${draft}
    Response Should Contain Only Filter Language Data    ${Response}    ${secondary_lang}

# Mix Qeury Variable
TC_WMALL_00226 Get Storefront Web Menu, TH Language and Published version
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_mix_menu_filter}

# Invalid Arguments
TC_WMALL_00227 Get Storefront Web With Invalid Shop ID
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${invalid_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_00228 Get Storefront With Invalid Type
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    type=${invalid_type}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_00229 Get Storefront Web With Invalid Version
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${invalid_version}
    Request Failed Because Version Missing or Invalid    ${Response}

TC_WMALL_00230 Get Storefront Web With Invalid Language
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    lang=${invalid_lang}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

############################# Mobile #############################
# Type
TC_WMALL_00224 Get Storefront Mobile Header Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}

TC_WMALL_00225 Get Storefront Mobile Active Menu Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}

TC_WMALL_01250 Get Storefront Mobile Active Menu with Mode Raw Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}

TC_WMALL_01251 Get Storefront Mobile Inactive Menu Success but Will Get Empty Data
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_menu}

TC_WMALL_01252 Get Storefront Mobile Inactive Menu with Mode Raw Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_inactive_menu}
    [Teardown]    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_menu}

TC_WMALL_00231 Get Storefront Mobile Banner Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}

TC_WMALL_00746 Get Storefront Mobile Banner with Mode Raw Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner_raw_mode}

TC_WMALL_00747 Get Storefront Mobile Content Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}

TC_WMALL_00748 Get Storefront Mobile Footer Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}

TC_WMALL_00749 Get Storefront Mobile UpdateTime Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront UpdateTime    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}
    Response UpdateTime Should Contain Data    ${Response}

# Version
TC_WMALL_00750 Get Storefront Mobile Draft Version Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Version Draft Should Contain Data    ${Response}    ${suite_shop_id}

TC_WMALL_00751 Get Storefront Mobile Published Version Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Version Publish Should Contain Data    ${Response}    ${suite_shop_id}

# Language
TC_WMALL_00752 Get Storefront Mobile Thai Language Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    lang=${lang_thai}    version=${draft}
    Response Should Contain Only Filter Language Data    ${Response}    ${primary_lang}

TC_WMALL_00753 Get Storefront Mobile English Language Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    lang=${lang_english}    version=${draft}
    Response Should Contain Only Filter Language Data    ${Response}    ${secondary_lang}

# Invalid Arguments
TC_WMALL_00754 Get Storefront Mobile With Invalid Shop ID
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${invalid_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_00755 Get Storefront Mobile With Invalid Type
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    type=${invalid_type}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_00756 Get Storefront Mobile With Invalid Version
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${invalid_version}
    Request Failed Because Version Missing or Invalid    ${Response}

TC_WMALL_00757 Get Storefront Mobile With Invalid Language
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    lang=${invalid_lang}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

# Mix Qeury Variable
TC_WMALL_00758 Get Storefront Mobile Menu, TH Language, Mobile View and Published version
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_mix_menu_filter_mobile}


