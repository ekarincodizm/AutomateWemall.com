*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup         Run Keywords    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${slug}    ${status}    ${prepare_shoppages}
                    ...    AND    Prepare Pages and Content Storefront    ${suite_shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
Suite Teardown      Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Library             ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_pages_keywords.robot
Resource            ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot

*** Variables ***
${merchant_id}              YOO687452
${shop_name}                Yoobao Store
${slug}                     yoobao-store
${status}                   active
${draft}                    draft
${published}                published
${lang_thai}                th_TH
${lang_english}             en_US

${pages_name}               Store Policy
${pages_slug}               store-policy
${banner_display}           off
${pages_status}             active
${prepare_shoppages}      ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/prepare_shop_pages.json
${second_pages_name}        Super Sale
${second_pages_slug}        super-sale

${primary_lang}             name
${secondary_lang}           name_translation
${web_view}                 web
${mobile_view}              mobile

*** Test Cases ***
############################# Web #############################
# Type
TC_ITMWM_05575 Get Pages Header Content Success but Data Should Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    #### Mobile
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_ITMWM_05576 Get Pages Menu Content Success but Data Should Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    #### Mobile
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_ITMWM_05577 Get Pages Menu Content with Mode Raw Success but Data Should Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    mode=raw    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    #### Mobile
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    mode=raw    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_ITMWM_05578 Get Pages Banner Content Success but Data Should Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    #### Mobile
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_ITMWM_05579 Get Pages Banner Content with Mode Raw Success but Data Should Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    mode=raw    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    #### Mobile
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    mode=raw    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_ITMWM_05580 Get Pages Content Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    #### Mobile
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}

TC_ITMWM_05581 Get Pages Footer Content Success but Data Should Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    #### Mobile
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}

TC_ITMWM_05582 Get Pages UpdateTime Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront UpdateTime    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}
    Response UpdateTime Should Contain Data    ${Response}
    #### Mobile
    ${Response}=    Get Storefront UpdateTime    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}
    Response UpdateTime Should Contain Data    ${Response}

# Version
TC_ITMWM_05583 Get Pages Content Draft Version Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}
    Response Pages Content Should Contain Data    ${Response}    ${suite_pages_id}
    #### Mobile
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}
    Response Pages Content Should Contain Data    ${Response}    ${suite_pages_id}

TC_ITMWM_05584 Get Pages Content Published Version Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${published}
    Response Pages Content Should Contain Data    ${Response}    ${suite_pages_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    #### Mobile
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${published}
    Response Pages Content Should Contain Data    ${Response}    ${suite_pages_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}

# Language
TC_ITMWM_05585 Get Pages Content Thai Language Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    lang=${lang_thai}    version=${draft}
    Response Pages Content Should Contain Only Filter Language Data    ${Response}    ${primary_lang}
    #### Mobile
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    lang=${lang_thai}    version=${draft}
    Response Pages Content Should Contain Only Filter Language Data    ${Response}    ${primary_lang}

TC_ITMWM_05586 Get Pages Content English Language Success and Data Not Empty
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    #### Web
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    lang=${lang_english}    version=${draft}
    Response Pages Content Should Contain Only Filter Language Data    ${Response}    ${secondary_lang}
    #### Mobile
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    lang=${lang_english}    version=${draft}
    Response Pages Content Should Contain Only Filter Language Data    ${Response}    ${secondary_lang}

######## Incomplete Content ########
TC_ITMWM_05587 Incomplete Pages Content Data for Type Content - Get Raw Data
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Incomplete Pages Content Storefront   ${suite_shop_id}    ${suite_pages_id}
    #### Web
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    #### Mobile
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}

TC_ITMWM_05588 Incomplete Pages Content Data for Type Content - Get Language Thai
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Incomplete Pages Content Storefront    ${suite_shop_id}    ${suite_pages_id}
    #### Web
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}
    #### Mobile
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${published}    lang=${lang_thai}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name}

TC_ITMWM_05589 Incomplete Pages Content Data for Type Content - Get Language English
    [tags]    incomplete_data    get_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Incomplete Pages Content Storefront    ${suite_shop_id}    ${suite_pages_id}
    #### Web
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${web_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}
    #### Mobile
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${draft}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_pages_id}    ${mobile_view}    version=${published}    lang=${lang_english}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_name_translation}

TC_ITMWM_05570 Get Content-Pages success, updated_at_web on pages should be equal content [Web]
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${second_pages_name} 01    ${second_pages_slug}-01    ${banner_display}    inactive
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    API Pages - Verify Pages Status Waiting Response Node Time    ${web_view}
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    web    ${prepare_content}
    # Get Pages content detail
    ${page_content_response}=    Get Storefront    ${STOREFRONT-API}    ${pages_id}    ${web_view}    version=${draft}
    # Get Pages data detail
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    ${pages_data_response}=    Get Response Body
    API Pages - Verify Pages Status Draft Response Node Time    ${web_view}
    API Pages - Compare Pages Update Content Time with Pages Content Data    ${page_content_response}    ${pages_data_response}    ${web_view}
    [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}

TC_ITMWM_05571 Get Content-Pages success, updated_at_mobile on pages should be equal content [Mobile]
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${second_pages_name} 02    ${second_pages_slug}-02    ${banner_display}    inactive
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    API Pages - Verify Pages Status Waiting Response Node Time    ${mobile_view}
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    mobile    ${prepare_content}
    # Get Pages content detail
    ${page_content_response}=    Get Storefront    ${STOREFRONT-API}    ${pages_id}    ${mobile_view}    version=${draft}
    # Get Pages data detail
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    ${pages_data_response}=    Get Response Body
    API Pages - Verify Pages Status Draft Response Node Time    ${mobile_view}
    API Pages - Compare Pages Update Content Time with Pages Content Data    ${page_content_response}    ${pages_data_response}    ${mobile_view}
    [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}

TC_ITMWM_05572 Get Content-Pages success, published_at_web on pages should be equal content [Web]
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${second_pages_name} 04    ${second_pages_slug}-04    ${banner_display}    inactive
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    API Pages - Verify Pages Status Waiting Response Node Time    ${web_view}
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    web    ${prepare_content}
    Sleep    2s
    Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    web
    # Get Pages content detail
    ${draft_page_content_response}=    Get Storefront    ${STOREFRONT-API}    ${pages_id}    ${web_view}    version=${draft}
    ${published_page_content_response}=    Get Storefront    ${STOREFRONT-API}    ${pages_id}    ${web_view}    version=${published}
    # Get Pages data detail
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    ${pages_data_response}=    Get Response Body
    API Pages - Verify Pages Status Published Response Node Time    ${web_view}
    API Pages - Compare Pages Update Content Time with Pages Content Data    ${draft_page_content_response}    ${pages_data_response}    ${web_view}
    API Pages - Compare Pages Published Content Time with Pages Content Data    ${published_page_content_response}    ${pages_data_response}    ${web_view}
    [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}

TC_ITMWM_05573 Get Content-Pages success, published_at_mobile on pages should be equal content [Mobile]
    [Tags]    get_storefronts    api_storefronts    api_cms    Regression
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${second_pages_name} 04    ${second_pages_slug}-04    ${banner_display}    inactive
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    API Pages - Verify Pages Status Waiting Response Node Time    ${mobile_view}
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    mobile    ${prepare_content}
    Sleep    2s
    Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    mobile
    # Get Pages content detail
    ${draft_page_content_response}=    Get Storefront    ${STOREFRONT-API}    ${pages_id}    ${mobile_view}    version=${draft}
    ${published_page_content_response}=    Get Storefront    ${STOREFRONT-API}    ${pages_id}    ${mobile_view}    version=${published}
    # Get Pages data detail
    Get Pages Detail by Page ID    ${suite_shop_id}    ${pages_id}
    ${pages_data_response}=    Get Response Body
    API Pages - Verify Pages Status Published Response Node Time    ${mobile_view}
    API Pages - Compare Pages Update Content Time with Pages Content Data    ${draft_page_content_response}    ${pages_data_response}    ${mobile_view}
    API Pages - Compare Pages Published Content Time with Pages Content Data    ${published_page_content_response}    ${pages_data_response}    ${mobile_view}
    [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}


















