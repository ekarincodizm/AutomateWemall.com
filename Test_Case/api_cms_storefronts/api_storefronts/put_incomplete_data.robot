*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup       Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Suite Teardown    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Library           ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}          IN789MCH
${shop_name}            Puma Store
${slug}                 puma-store
${status}               active
${draft}                draft
${published}            published
${web_view}             web
${mobile_view}          mobile

*** Test Cases ***
############################# Web #############################
######## Header ########
TC_WMALL_01100 Update Storefront Web Data Type Header with Incomplete Header Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_header}
    Verify Update Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    header    ${published}    ${web_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    header

######## Menu ########
TC_WMALL_01101 Update Storefront Web Data Type Active Menu with Incomplete Menu Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${web_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

TC_WMALL_01281 Update Storefront Web Data Type Inactive Menu with Incomplete Menu Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_inactive_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${web_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

######## Banner ########
TC_WMALL_01102 Update Storefront Web Data Type Banner with Incomplete Banner Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_banner}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    banner    ${published}    ${web_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

######## Content ########
TC_WMALL_01103 Update Storefront Web Data Type Content with Incomplete Content Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_content}
    Verify Update Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    content    ${published}    ${web_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    content

######## Footer ########
TC_WMALL_01104 Update Storefront Web Data Type Footer with Incomplete Footer Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_footer}
    Verify Update Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    footer    ${published}    ${web_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    footer

############################# Mobile #############################
######## Header ########
TC_WMALL_01105 Update Storefront Mobile Data Type Header with Incomplete Header Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_header}
    Verify Update Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    header    ${published}    ${mobile_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    header    ${expected_header_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    header

######## Menu ########
TC_WMALL_01106 Update Storefront Mobile Data Type Active Menu with Incomplete Menu Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${mobile_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

TC_WMALL_01282 Update Storefront Mobile Data Type Inactive Menu with Incomplete Menu Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_inactive_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${mobile_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_menu_inactive_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

######## Banner ########
TC_WMALL_01107 Update Storefront Mobile Data Type Banner with Incomplete Banner Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_banner}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    banner    ${published}    ${mobile_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

######## Content ########
TC_WMALL_01108 Update Storefront Mobile Data Type Content with Incomplete Content Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_content}
    Verify Update Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    content    ${published}    ${mobile_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    content    ${expected_content_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    content

######## Footer ########
TC_WMALL_01109 Update Storefront Mobile Data Type Footer with Incomplete Footer Data
    [tags]    incomplete_data    put_storefronts    api_storefronts    api_cms    Regression
    # Just Draft
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_footer}
    Verify Update Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    # Published
    Publish Storefront Success    ${suite_shop_id}    footer    ${published}    ${mobile_view}    data
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    footer    ${expected_footer_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    footer

