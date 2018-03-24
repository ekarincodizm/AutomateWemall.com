*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Suite Setup       Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Suite Teardown    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource          ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Library           ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}              PUMA00989
${shop_name}                Puma Shop
${slug}                     puma
${status}                   active
${header}                   header
${draft}                    draft
${published}                published
${data}                     <p>data</p>
${web_view}                 web
${mobile_view}              mobile
${invalid_shop_id}          invalid_shop_id

*** Test Cases ***
############################# Web #############################
# Update Data
TC_WMALL_00240 Update Storefront Web Header Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_header}
    Verify Update Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    header

TC_WMALL_00241 Update Storefront Web Active Menu Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

TC_WMALL_01249 Update Storefront Web Inactive Menu Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${inactive_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    menu

TC_WMALL_00242 Update Storefront Web Banner Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00243 Update Storefront Web Content Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_content}
    Verify Update Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    content

TC_WMALL_00244 Update Storefront Web Footer Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_footer}
    Verify Update Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    footer

# Update with Invalid Data
TC_WMALL_00245 Update Storefront Web WO Type
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront WO type    ${suite_shop_id}    ${draft}    ${web_view}    ${data}
    Verify PUT/POST Invalid Type
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${suite_shop_id}    ${web_view}

TC_WMALL_00246 Update Storefront Web WO Version
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront WO Version    ${suite_shop_id}    ${header}    ${web_view}    ${data}
    Verify PUT/POST Invalid Version
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${suite_shop_id}    ${web_view}

TC_WMALL_00247 Update Storefront Web WO Data
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront WO data    ${suite_shop_id}    ${header}    ${web_view}    ${draft}
    Verify PUT/POST Invalid Data Site
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${suite_shop_id}    ${web_view}

TC_WMALL_01412 Update Storefront Web Data with Not Exist Shop
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${invalid_shop_id}    ${web_view}    ${prepare_header}
    Verify PUT/POST Failed because Shop Not Exists
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${invalid_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${invalid_shop_id}    ${web_view}

# Publish Data
TC_WMALL_00248 Publish Storefront Web Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_header}
    Publish Storefront Success    ${suite_shop_id}    ${header}    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    header

TC_WMALL_00249 Publish Storefront Web Data with Not Exist Shop
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Publish Storefront Fail    ${invalid_shop_id}    ${header}   ${web_view}    ${published}    ${data}
    Verify PUT/POST Failed because Shop Not Exists
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${invalid_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${invalid_shop_id}    ${web_view}

# Update Banner Data
TC_WMALL_00250 Update Banner Web with Valid Period Time
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${update_banner_success_01}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_success_01}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${update_banner_success_02}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_success_02}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00251 Update Banner Web with Overlap between active forever and active range date
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${web_view}    ${update_banner_failed_01}
    Verify Update Banner Failed Because Time Collapsing    11
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00255 Update Banner Web with Overlap between active forever and active forever
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${web_view}    ${update_banner_failed_02}
    Verify Update Banner Failed Because Time Collapsing    12
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00256 Update Banner Web with Overlap between active range date and active range date (second or time)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${web_view}    ${update_banner_failed_03}
    Verify Update Banner Failed Because Time Collapsing    13
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00257 Update Banner Web with Overlap between active range date and active range date (date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${web_view}    ${update_banner_failed_04}
    Verify Update Banner Failed Because Time Collapsing    14
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00258 Update Banner Web with Overlap between active range date and active range date (Start date is the same date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${web_view}    ${update_banner_failed_05}
    Verify Update Banner Failed Because Time Collapsing    15
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00259 Update Banner Web with Overlap between active range date and active range date (End date is the same date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${web_view}    ${update_banner_failed_06}
    Verify Update Banner Failed Because Time Collapsing    15
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

TC_WMALL_00260 Update Banner Web with Overlap between active range date and active range date (Start date and End date are the same date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${web_view}    ${update_banner_failed_07}
    Verify Update Banner Failed Because Time Collapsing    15
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${web_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${web_view}    banner

############################# Mobile #############################
# Update Data
TC_WMALL_00767 Update Storefront Mobile Header Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_header}
    Verify Update Header Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    header

TC_WMALL_00768 Update Storefront Mobile Active Menu Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

TC_WMALL_01254 Update Storefront Mobile Inactive Menu Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${inactive_menu}
    Verify Update Menu Success    ${suite_shop_id}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    menu    ${expected_inactive_menu}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    menu

TC_WMALL_00769 Update Storefront Mobile Banner Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_banner}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00770 Update Storefront Mobile Content Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_content}
    Verify Update Content Success    ${suite_shop_id}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    content

TC_WMALL_00771 Update Storefront Mobile Footer Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_footer}
    Verify Update Footer Success    ${suite_shop_id}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    footer

# Update with Invalid Data
TC_WMALL_00772 Update Storefront Mobile WO Type
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront WO type    ${suite_shop_id}    ${draft}    ${mobile_view}    ${data}
    Verify PUT/POST Invalid Type
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${suite_shop_id}    ${mobile_view}

TC_WMALL_00773 Update Storefront Mobile WO Version
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront WO Version    ${suite_shop_id}    ${header}    ${mobile_view}    ${data}
    Verify PUT/POST Invalid Version
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${suite_shop_id}    ${mobile_view}

TC_WMALL_00774 Update Storefront Mobile WO Data
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront WO data    ${suite_shop_id}    ${header}    ${mobile_view}    ${draft}
    Verify PUT/POST Invalid Data Site
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${suite_shop_id}    ${mobile_view}

TC_WMALL_01413 Update Storefront Mobile Data with Not Exist Shop
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${invalid_shop_id}    ${mobile_view}    ${prepare_header}
    Verify PUT/POST Failed because Shop Not Exists
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${invalid_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${invalid_shop_id}    ${mobile_view}

# Publish Data
TC_WMALL_00775 Publish Storefront Mobile Success
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    [Setup]    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_header}
    Publish Storefront Success    ${suite_shop_id}    ${header}    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    header

TC_WMALL_00776 Publish Storefront Mobile Data with Not Exist Shop
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Publish Storefront Fail    ${invalid_shop_id}    ${header}   ${mobile_view}    ${published}    ${data}
    Verify PUT/POST Failed because Shop Not Exists
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${invalid_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success All Type    ${invalid_shop_id}    ${mobile_view}

# Update Banner Data
TC_WMALL_00777 Update Banner Mobile with Valid Period Time
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${update_banner_success_01}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_success_01}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${update_banner_success_02}
    Verify Update Banner Success    ${suite_shop_id}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    mode=raw    version=${draft}
    Response Should Contain Data Like Expected    ${Response}    banner    ${expected_banner_success_02}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00778 Update Banner Mobile with Overlap between active forever and active range date
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${mobile_view}    ${update_banner_failed_01}
    Verify Update Banner Failed Because Time Collapsing    11
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00779 Update Banner Mobile with Overlap between active forever and active forever
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${mobile_view}    ${update_banner_failed_02}
    Verify Update Banner Failed Because Time Collapsing    12
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00780 Update Banner Mobile with Overlap between active range date and active range date (second or time)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${mobile_view}    ${update_banner_failed_03}
    Verify Update Banner Failed Because Time Collapsing    13
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00781 Update Banner Mobile with Overlap between active range date and active range date (date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${mobile_view}    ${update_banner_failed_04}
    Verify Update Banner Failed Because Time Collapsing    14
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00782 Update Banner Mobile with Overlap between active range date and active range date (Start date is the same date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${mobile_view}    ${update_banner_failed_05}
    Verify Update Banner Failed Because Time Collapsing    15
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00783 Update Banner Mobile with Overlap between active range date and active range date (End date is the same date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${mobile_view}    ${update_banner_failed_06}
    Verify Update Banner Failed Because Time Collapsing    15
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner

TC_WMALL_00784 Update Banner Mobile with Overlap between active range date and active range date (Start date and End date are the same date)
    [Tags]    put_storefronts    api_storefronts    api_cms    Regression
    Update Storefront Data From Input File But Failed    ${suite_shop_id}    ${mobile_view}    ${update_banner_failed_07}
    Verify Update Banner Failed Because Time Collapsing    15
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${draft}
    Request Success But Response Data Should Empty    ${Response}
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${suite_shop_id}    ${mobile_view}    version=${published}
    Request Success But Response Data Should Empty    ${Response}
    [teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    ${mobile_view}    banner




