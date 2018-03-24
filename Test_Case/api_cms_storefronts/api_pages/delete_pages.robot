*** Settings ***
Force Tags    WLS_API_CMS_Storefront
Library             OperatingSystem
Library             Collections
Library             ${CURDIR}/../../../Python_Library/DynamoDb.py
Library             ${CURDIR}/../../../Python_Library/jsonLibrary.py
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_pages_keywords.robot
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Suite Setup         Prepare Shop And Check is Shop Exist
Suite Teardown      Delete Shop by Shop ID Success    ${SUTIE_JULY_SHOP_ID}

*** Variable ***
${pages_json}                ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/pages/pages_template.json
${body_post_template}        ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${july_merchant_id}         July0001
${july_shop_name}           July 2016
${july_shop_slug}           july-2016
${july_shop_slug_TH}        เดือน-กรกฎาคม
${deafult_merchant_id}       ${EMPTY}


*** Keywords ***
Prepare Shop And Check is Shop Exist
    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${july_shop_slug}
    ${july_shop_id}=    Create Shop Success    ${body_post_template}    ${july_merchant_id}    ${july_shop_name}    ${july_shop_slug}    active
    Get Shop by Shop ID    ${july_shop_id}
    Set Suite Variable    ${SUTIE_JULY_SHOP_ID}    ${july_shop_id}

*** Test Cases ***

TC_ITMWM_05536 Delete Pages Success
    [Tags]    delete_pages    api_pages    Regression    api_cms
    ${json_pages}=    Prepare Json Body for Post Pages    ${pages_json}    July Pages 1   july-pages-1    on    inactive
    ${page_1_id}=    Create Pages    ${SUTIE_JULY_SHOP_ID}    ${json_pages}
    ${json_pages}=    Prepare Json Body for Post Pages    ${pages_json}    July Pages 2   july-pages-2    on    active
    ${page_2_id}=    Create Pages    ${SUTIE_JULY_SHOP_ID}    ${json_pages}
    ${json_pages}=    Prepare Json Body for Post Pages    ${pages_json}    July Pages 3   july-pages-3    off    active
    ${page_3_id}=    Create Pages    ${SUTIE_JULY_SHOP_ID}    ${json_pages}
    Delete Pages by Shop ID    ${SUTIE_JULY_SHOP_ID}   ${page_2_id}
    Get Pages Detail by Page Slug Failed    ${SUTIE_JULY_SHOP_ID}    july-pages-2
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_JULY_SHOP_ID}    ${page_1_id}
    Verify Create Pages Success and Response Data Correct    ${page_1_id}    July Pages 1   july-pages-1    on    inactive
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_JULY_SHOP_ID}    ${page_3_id}
    Verify Create Pages Success and Response Data Correct    ${page_3_id}    July Pages 3   july-pages-3    off    active
    Run Keywords    Delete Pages by Shop ID    ${SUTIE_JULY_SHOP_ID}   ${page_1_id}    AND    Delete Pages by Shop ID    ${SUTIE_JULY_SHOP_ID}   ${page_3_id}
    Get Shop by Shop ID    ${SUTIE_JULY_SHOP_ID}
    Verify Node Pages from Shops is Empty

TC_ITMWM_05537 Delete Pages by Invalid Pages ID
    [Tags]    delete_pages    api_pages    Regression    api_cms
    Delete Pages by Shop ID Failed    ${SUTIE_JULY_SHOP_ID}   XXXXX
    Verify Error Code Message    400 Bad Request    CSS4009    Item does not exist    Page ID 'XXXXX' does not exist in Shop Id '${SUTIE_JULY_SHOP_ID}'
