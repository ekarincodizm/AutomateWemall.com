*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup         Prepare Incomplete Storefront Data    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Suite Teardown      Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Library             ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}          IN789MCH
${shop_name}            Nike Store
${slug}                 nike-store
${status}               active
${draft}                draft
${published}            published
${lang_thai}            th_TH
${lang_english}         en_US
${primary_lang}         name
${secondary_lang}       name_translation
${web_view}             web
${mobile_view}          mobile
${invalid_lang}         invalid_lang

*** Test Cases ***
############################# Web #############################
######## Header ########
TC_WMALL_01050 Incomplete Storefront Web Data for Type Header - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}

TC_WMALL_01051 Incomplete Storefront Web Data for Type Header - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name}

TC_WMALL_01052 Incomplete Storefront Web Data for Type Header - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name_translation}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name_translation}

TC_WMALL_01053 Incomplete Storefront Web Data for Type Header - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

######## Menu ########
TC_WMALL_01054 Incomplete Storefront Web Data for Type Active Menu - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}

TC_WMALL_01055 Incomplete Storefront Web Data for Type Active Menu - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}

TC_WMALL_01056 Incomplete Storefront Web Data for Type Active Menu - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}

TC_WMALL_01057 Incomplete Storefront Web Data for Type Active Menu - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_01255 Incomplete Storefront Web Data for Type Active Menu with Mode Raw - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}

TC_WMALL_01256 Incomplete Storefront Web Data for Type Active Menu with Mode Raw - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}

TC_WMALL_01257 Incomplete Storefront Web Data for Type Active Menu with Mode Raw - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}

TC_WMALL_01258 Incomplete Storefront Web Data for Type Active Menu with Mode Raw - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_01259 Incomplete Storefront Web Data for Type Inactive Menu - Get Raw Data but Will Get Empty Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

TC_WMALL_01260 Incomplete Storefront Web Data for Type Inactive Menu - Get Language Thai but Will Get Empty Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_thai}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

TC_WMALL_01261 Incomplete Storefront Web Data for Type Inactive Menu - Get Language English but Will Get Empty Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_english}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_english}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

TC_WMALL_01262 Incomplete Storefront Web Data for Type Inactive Menu - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

TC_WMALL_01263 Incomplete Storefront Web Data for Type Inactive Menu with Mode Raw - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

TC_WMALL_01264 Incomplete Storefront Web Data for Type Inactive Menu with Mode Raw - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

TC_WMALL_01265 Incomplete Storefront Web Data for Type Inactive Menu with Mode Raw - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name_translation}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name_translation}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

TC_WMALL_01266 Incomplete Storefront Web Data for Type Inactive Menu with Mode Raw - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    menu    ${incomplete_menu}

######## Banner ########
TC_WMALL_01058 Incomplete Storefront Web Data for Type Banner - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}

TC_WMALL_01059 Incomplete Storefront Web Data for Type Banner - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name}

TC_WMALL_01060 Incomplete Storefront Web Data for Type Banner - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name_translation}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name_translation}

TC_WMALL_01061 Incomplete Storefront Web Data for Type Banner - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

######## Content ########
TC_WMALL_01062 Incomplete Storefront Web Data for Type Content - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}

TC_WMALL_01063 Incomplete Storefront Web Data for Type Content - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}

TC_WMALL_01064 Incomplete Storefront Web Data for Type Content - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}

TC_WMALL_01065 Incomplete Storefront Web Data for Type Content - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

######## Footer ########
TC_WMALL_01066 Incomplete Storefront Web Data for Type Footer - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}

TC_WMALL_01067 Incomplete Storefront Web Data for Type Footer - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name}

TC_WMALL_01068 Incomplete Storefront Web Data for Type Footer - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name_translation}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name_translation}

TC_WMALL_01069 Incomplete Storefront Web Data for Type Footer - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

############################# Mobile #############################
######## Header ########
TC_WMALL_01070 Incomplete Storefront Mobile Data for Type Header - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}

TC_WMALL_01071 Incomplete Storefront Mobile Data for Type Header - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name}

TC_WMALL_01072 Incomplete Storefront Mobile Data for Type Header - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name_translation}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_name_translation}

TC_WMALL_01073 Incomplete Storefront Mobile Data for Type Header - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

######## Menu ########
TC_WMALL_01074 Incomplete Storefront Mobile Data for Type Active Menu - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}

TC_WMALL_01075 Incomplete Storefront Mobile Data for Type Active Menu - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}

TC_WMALL_01076 Incomplete Storefront Mobile Data for Type Active Menu - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}

TC_WMALL_01077 Incomplete Storefront Mobile Data for Type Active Menu - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_01267 Incomplete Storefront Mobile Data for Type Active Menu with Mode Raw - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}

TC_WMALL_01268 Incomplete Storefront Mobile Data for Type Active Menu with Mode Raw - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name}

TC_WMALL_01269 Incomplete Storefront Mobile Data for Type Active Menu with Mode Raw - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_name_translation}

TC_WMALL_01270 Incomplete Storefront Mobile Data for Type Active Menu with Mode Raw - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

TC_WMALL_01271 Incomplete Storefront Mobile Data for Type Inactive Menu - Get Raw Data but Will Get Empty Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

TC_WMALL_01272 Incomplete Storefront Mobile Data for Type Inactive Menu - Get Language Thai but Will Get Empty Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_thai}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_thai}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

TC_WMALL_01273 Incomplete Storefront Mobile Data for Type Inactive Menu - Get Language English but Will Get Empty Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_english}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Request Storefront Specific Type Success but Response Data Should Empty    ${Response}    menu
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

TC_WMALL_01274 Incomplete Storefront Mobile Data for Type Inactive Menu - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

TC_WMALL_01275 Incomplete Storefront Mobile Data for Type Inactive Menu with Mode Raw - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

TC_WMALL_01276 Incomplete Storefront Mobile Data for Type Inactive Menu with Mode Raw - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

TC_WMALL_01277 Incomplete Storefront Mobile Data for Type Inactive Menu with Mode Raw - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name_translation}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_name_translation}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

TC_WMALL_01278 Incomplete Storefront Mobile Data for Type Inactive Menu with Mode Raw - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    [Teardown]    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    menu    ${incomplete_menu}

######## Banner ########
TC_WMALL_01078 Incomplete Storefront Mobile Data for Type Banner - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}

TC_WMALL_01079 Incomplete Storefront Mobile Data for Type Banner - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name}

TC_WMALL_01080 Incomplete Storefront Mobile Data for Type Banner - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name_translation}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_name_translation}

TC_WMALL_01081 Incomplete Storefront Mobile Data for Type Banner - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

######## Content ########
TC_WMALL_01082 Incomplete Storefront Mobile Data for Type Content - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}

TC_WMALL_01083 Incomplete Storefront Mobile Data for Type Content - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}

TC_WMALL_01084 Incomplete Storefront Mobile Data for Type Content - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}

TC_WMALL_01085 Incomplete Storefront Mobile Data for Type Content - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}

######## Footer ########
TC_WMALL_01086 Incomplete Storefront Mobile Data for Type Footer - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}

TC_WMALL_01087 Incomplete Storefront Mobile Data for Type Footer - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name}

TC_WMALL_01088 Incomplete Storefront Mobile Data for Type Footer - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name_translation}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_name_translation}

TC_WMALL_01089 Incomplete Storefront Mobile Data for Type Footer - Get with Invalid Lang
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}    lang=${invalid_lang}
    Request Success But Response Data Should Empty    ${Response}
