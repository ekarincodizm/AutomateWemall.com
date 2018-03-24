*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup       Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Suite Teardown    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Library           ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}          IN789123MCH
${shop_name}            Adidas Shop
${slug}                 adidas-shop
${status}               active
${draft}                draft
${published}            published
${web_view}             web
${mobile_view}          mobile

*** Test Cases ***
############################# Web #############################
######## Header ########
TC_WMALL_01090 Create Storefront Web Data Type Header with Incomplete Header Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_header}
    Verify Create Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    header

######## Menu ########
TC_WMALL_01091 Create Storefront Web Data Type Active Menu with Incomplete Menu Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

TC_WMALL_01279 Create Storefront Web Data Type Inactive Menu with Incomplete Menu Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_inactive_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

######## Banner ########
TC_WMALL_01092 Create Storefront Web Data Type Banner with Incomplete Banner Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

######## Content ########
TC_WMALL_01093 Create Storefront Web Data Type Content with Incomplete Content Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_content}
    Verify Create Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    content

######## Footer ########
TC_WMALL_01094 Create Storefront Web Data Type Footer with Incomplete Footer Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_footer}
    Verify Create Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    footer

############################# Mobile #############################
######## Header ########
TC_WMALL_01095 Create Storefront Mobile Data Type Header with Incomplete Header Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_header}
    Verify Create Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    header

######## Menu ########
TC_WMALL_01096 Create Storefront Mobile Data Type Active Menu with Incomplete Menu Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

TC_WMALL_01280 Create Storefront Mobile Data Type Inactive Menu with Incomplete Menu Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_inactive_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

######## Banner ########
TC_WMALL_01097 Create Storefront Mobile Data Type Banner with Incomplete Banner Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

######## Content ########
TC_WMALL_01098 Create Storefront Mobile Data Type Content with Incomplete Content Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_content}
    Verify Create Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    content

######## Footer ########
TC_WMALL_01099 Create Storefront Mobile Data Type Footer with Incomplete Footer Data
    [tags]    incomplete_data    post_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_footer}
    Verify Create Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    footer
