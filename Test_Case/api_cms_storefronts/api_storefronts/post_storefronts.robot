*** Settings ***
Force Tags    WLS_API_CMS_Storefront
# Test Setup       Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
# Test Teardown    Delete Shop and All Storefront Data    ${suite_shop_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource          ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Library           ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}          ADIDAS20000
${shop_name}            Adidas Store
${slug}                 adidas
${status}               active
${type}                 header
${draft}                draft
${published}            published
${web_view}             web
${mobile_view}          mobile
${data}                 <p>data</p>
${invalid_shop_id}      invalid_shop_id

*** Test Cases ***
############################# Web #############################
# Update Data
TC_WMALL_00232 Create Storefront Web Header Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_header}
    Verify Create Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    header

TC_WMALL_00233 Create Storefront Web Active Menu Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

TC_WMALL_01248 Create Storefront Web Inactive Menu Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${inactive_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

TC_WMALL_00234 Create Storefront Web Banner Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00235 Create Storefront Web Content Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_content}
    Verify Create Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    content

TC_WMALL_00236 Create Storefront Web Footer Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_footer}
    Verify Create Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    footer

# Create with Invalid Data
TC_WMALL_00237 Create Storefront Web WO type
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront WO type    ${suite_shop_id}    ${draft}    ${web_view}    ${data}
    Verify PUT/POST Invalid Type
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_00238 Create Storefront Web WO Version
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront WO Version    ${suite_shop_id}    ${type}    ${web_view}    ${data}
    Verify PUT/POST Invalid Version
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_00239 Create Storefront Web WO data
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront WO data    ${suite_shop_id}    ${type}    ${draft}    ${web_view}
    Verify PUT/POST Invalid Data
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    ${type}

TC_WMALL_01410 Create Storefront Web Data with Not Exist Shop
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    Create Storefront Data Failed From Input File    ${invalid_shop_id}    ${web_view}    ${prepare_header}
    Verify PUT/POST Failed because Shop Not Exists
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${invalid_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${invalid_shop_id}    ${web_view}

############################# Mobile #############################
# Update Data
TC_WMALL_00759 Create Storefront Mobile Header Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_header}
    Verify Create Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    header

TC_WMALL_00760 Create Storefront Mobile Active Menu Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

TC_WMALL_01253 Create Storefront Mobile Inactive Menu Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${inactive_menu}
    Verify Create Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

TC_WMALL_00761 Create Storefront Mobile Banner Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_banner}
    Verify Create Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00762 Create Storefront Mobile Content Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_content}
    Verify Create Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    content

TC_WMALL_00763 Create Storefront Mobile Footer Success
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_footer}
    Verify Create Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    footer

# Create with Invalid Data
TC_WMALL_00764 Create Storefront Mobile WO type
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront WO type    ${suite_shop_id}    ${draft}    ${mobile_view}    ${data}
    Verify PUT/POST Invalid Type
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_00765 Create Storefront Mobile WO Version
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront WO Version    ${suite_shop_id}    ${type}    ${mobile_view}    ${data}
    Verify PUT/POST Invalid Version
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_00766 Create Storefront Mobile WO data
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
    Create Storefront WO data    ${suite_shop_id}    ${type}    ${draft}    ${mobile_view}
    Verify PUT/POST Invalid Data
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}
    # [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    ${type}

TC_WMALL_01411 Create Storefront Mobile Data with Not Exist Shop
    [Tags]    post_storefronts    api_storefronts    api_cms    Regression
    Create Storefront Data Failed From Input File    ${invalid_shop_id}    ${mobile_view}    ${prepare_header}
    Verify PUT/POST Failed because Shop Not Exists
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${invalid_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${invalid_shop_id}    ${mobile_view}

