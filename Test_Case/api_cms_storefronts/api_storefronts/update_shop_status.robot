*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Test Setup       Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${slug}    ${status}
Test Teardown    Delete Shop and All Storefront Data    ${suite_shop_id}
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource          ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Library           ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
${merchant_id}      ONITSUKA000123
${shop_name}        Onitsuka Store
${slug}             onitsuka
${status}           active
${draft}            draft
${published}        published
${web_view}         web
${mobile_view}      mobile
${data}             <p>data</p>

*** Test Cases ***
############################# Web #############################
TC_WMALL_01414 Check Storefront API Update Shop Status - Storefront Web Header
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_header}
    Verify Create Header Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_header}
    Verify Update Header Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    header    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_header}
    Verify Update Header Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    header    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}

TC_WMALL_01415 Check Storefront API Update Shop Status - Storefront Web Menu
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Menu}
    Verify Create Menu Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Menu}
    Verify Update Menu Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Menu}
    Verify Update Menu Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}

TC_WMALL_01416 Check Storefront API Update Shop Status - Storefront Web Banner
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Banner}
    Verify Create Banner Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Banner}
    Verify Update Banner Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    banner    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Banner}
    Verify Update Banner Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    banner    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}

TC_WMALL_01417 Check Storefront API Update Shop Status - Storefront Web Content
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Content}
    Verify Create Content Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Content}
    Verify Update Content Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    content    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Content}
    Verify Update Content Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    content    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}

TC_WMALL_01418 Check Storefront API Update Shop Status - Storefront Web Footer
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Footer}
    Verify Create Footer Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Footer}
    Verify Update Footer Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    footer    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_Footer}
    Verify Update Footer Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Web Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    footer    ${published}    ${web_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Web Data    ${suite_shop_id}

TC_WMALL_01419 Published Storefronts Web Data Failed Must Not Stamp Published Time in Shop Data
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_header}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_menu}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_banner}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_content}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${prepare_footer}
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Header   ${web_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Menu   ${web_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Banner   ${web_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Content   ${web_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Footer   ${web_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Web Data    ${suite_shop_id}


############################# Mobile #############################
TC_WMALL_01420 Check Storefront API Update Shop Status - Storefront Mobile Header
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_header}
    Verify Create Header Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_header}
    Verify Update Header Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    header    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_header}
    Verify Update Header Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    header    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}

TC_WMALL_01421 Check Storefront API Update Shop Status - Storefront Mobile Menu
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Menu}
    Verify Create Menu Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Menu}
    Verify Update Menu Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Menu}
    Verify Update Menu Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    menu    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}

TC_WMALL_01422 Check Storefront API Update Shop Status - Storefront Mobile Banner
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Banner}
    Verify Create Banner Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Banner}
    Verify Update Banner Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    banner    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Banner}
    Verify Update Banner Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    banner    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}

TC_WMALL_01423 Check Storefront API Update Shop Status - Storefront Mobile Content
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Content}
    Verify Create Content Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Content}
    Verify Update Content Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    content    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Content}
    Verify Update Content Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    content    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}

TC_WMALL_01424 Check Storefront API Update Shop Status - Storefront Mobile Footer
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Create Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Footer}
    Verify Create Footer Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Footer}
    Verify Update Footer Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    footer    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_Footer}
    Verify Update Footer Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Modified Status for Storefront Mobile Data    ${suite_shop_id}
    Sleep    1s
    Publish Storefront Success    ${suite_shop_id}    footer    ${published}    ${mobile_view}    ${data}
    Verify Publish Success    ${suite_shop_id}
    Get Shop Data and Verify Shop Published Status for Storefront Mobile Data    ${suite_shop_id}

TC_WMALL_01425 Published Storefronts Mobile Data Failed Must Not Stamp Published Time in Shop Data
    [Tags]    shop_status    api_storefronts    api_cms    Regression
    Get Shop Data and Verify Shop Waiting Status for Storefront Data    ${suite_shop_id}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_header}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_menu}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_banner}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_content}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${prepare_footer}
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Header   ${mobile_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Menu   ${mobile_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Banner   ${mobile_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Content   ${mobile_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}
    Publish Storefront Fail    ${suite_shop_id}    Footer   ${mobile_view}    ${published}    ${data}
    Verify PUT/POST Invalid Type
    Get Shop Data and Verify Shop Draft Status for Storefront Mobile Data    ${suite_shop_id}

