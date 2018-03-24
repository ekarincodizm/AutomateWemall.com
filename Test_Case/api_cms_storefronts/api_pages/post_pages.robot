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
Suite Teardown      Run Keywords    Delete Shop by Shop ID Success    ${SUTIE_CITRA_SHOP_ID}    AND    Delete Shop by Shop ID Success    ${SUTIE_CHICKEN_SHOP_ID}

*** Variable ***
${pages_json}                ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/pages/pages_template.json
${body_post_template}        ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${citra_merchant_id}         Citra0001
${citra_shop_name}           Citra Pearly White UV
${citra_shop_slug}           citra-pearly-white-uv
${citra_shop_slug_TH}        ซิตร้า-เพิร์ลลี่-ไวท์-ยูว์
${deafult_merchant_id}       ${EMPTY}
${chicken_merchant_id}         Chicken0001
${chicken_shop_name}           Chicken Sticks
${chicken_shop_slug}           chicken-sticks
${chicken_shop_slug_TH}        ขนมขาไก่-ปรุงรส

*** Keywords ***
Prepare Shop And Check is Shop Exist
    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${citra_shop_slug}
    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${chicken_shop_slug}
    ${citra_shop_id}=    Create Shop Success    ${body_post_template}    ${citra_merchant_id}    ${citra_shop_name}    ${citra_shop_slug}    active
    Get Shop by Shop ID    ${citra_shop_id}
    Set Suite Variable    ${SUTIE_CITRA_SHOP_ID}    ${citra_shop_id}
    ${chicken_shop_id}=    Create Shop Success    ${body_post_template}    ${chicken_merchant_id}    ${chicken_shop_name}    ${chicken_shop_slug}    active
    Get Shop by Shop ID    ${chicken_shop_id}
    Set Suite Variable    ${SUTIE_CHICKEN_SHOP_ID}    ${chicken_shop_id}

*** Test Cases ***

TC_ITMWM_05502 Create Pages Success.
    [Tags]    post_pages    api_pages    Regression    api_cms
    ${json_pages}=    Prepare Json Body for Post Pages    ${pages_json}    TONG GARDEN100   tong-garden100    on    active
    ${page_id}=    Create Pages    ${SUTIE_CITRA_SHOP_ID}    ${json_pages}
    Log To console    ${page_id}
    ${data_dynamo}=    Get Page from Dynamo   ${SUTIE_CITRA_SHOP_ID}    ${page_id}
    Log Dictionary     ${data_dynamo}
    ${json_pages}=    Convert Json To Dict    ${json_pages}
    Log Dictionary    ${json_pages}
    Dictionary Should Contain Sub Dictionary    ${data_dynamo}    ${json_pages}
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_CITRA_SHOP_ID}   ${page_id}

TC_ITMWM_05503 Create Pages by Name and Slug Thai Language.
    [Tags]     post_pages    api_pages    Regression    api_cms
    ${json_pages}=    Prepare Json Body for Post Pages    ${pages_json}    ทองการ์เด้น ช็อป   ทอง-การ์เด้น    on    active
    ${page_id}=    Create Pages    ${SUTIE_CITRA_SHOP_ID}    ${json_pages}
    Log To console    ${page_id}
    ${data_dynamo}=    Get Page from Dynamo   ${SUTIE_CITRA_SHOP_ID}    ${page_id}
    Log Dictionary     ${data_dynamo}
    ${json_pages}=    Convert Json To Dict    ${json_pages}
    Log Dictionary    ${json_pages}
    Dictionary Should Contain Sub Dictionary    ${data_dynamo}    ${json_pages}
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_CITRA_SHOP_ID}   ${page_id}

TC_ITMWM_05504 Create Pages by Empty Page Name.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages Not Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    ${EMPTY}   tong-garden    on    active
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid page name
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05505 Create Pages By Empty Slug Name.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages Not Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   ${EMPTY}    on    active
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid page url
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05506 Create Pages By Empty Banner Display.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages Not Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   tong-garden    ${EMPTY}    active
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid banner display format
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05507 Create Pages By Empty Page Status.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages Not Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   tong-garden    on    ${EMPTY}
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid page status format
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05508 Create Pages by Wrong Shop Slug Format.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages Not Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   tong-garden!@#$%^    on    active
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid page url format
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05509 Create Pages Without Page Name.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages WO Pages Name Node    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   tong-garden    on    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Page name is missing
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05510 Create Pages Without Page Slug Name.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages WO Pages Slug Node    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   tong-garden    on    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Page url is missing
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05511 Create Pages Without Banner Display.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages WO Pages Banner Display Node    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   tong-garden    on    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field     Page banner display is missing
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05512 Create Pages Without Page Status.
    [Tags]     post_pages    api_pages    Regression    api_cms
    Create Pages WO Pages Status Node    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN   tong-garden    on    active
    Verify Error Code Message    400 Bad Request    CSS4001    Missing Required Field    Page status is missing
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden

TC_ITMWM_05513 Create Pages Duplicate Page Name in same Shop.
    [Tags]     post_pages    api_pages    Regression    api_cms
    ${page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN10   tong-garden11    on    active
    Create Pages Not Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN10   tong-garden12    on    active
    Verify Error Code Message    400 Bad Request    CSS4004    Duplicate Data    Page name already exists
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden12

TC_ITMWM_05514 Create Pages Duplicate Slug Name in same Shop.
    [Tags]     post_pages    api_pages    Regression    api_cms
    ${page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN13   tong-garden14    on    active
    Create Pages Not Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN14   tong-garden14    on    active
    Verify Error Code Message    400 Bad Request    CSS4004    Duplicate Data    Page slug already exists
    Get Pages Detail by Page Slug Failed    ${SUTIE_CITRA_SHOP_ID}    tong-garden14

TC_ITMWM_05515 Create Pages Duplicate Page Name in other Shop.
    [Tags]     post_pages    api_pages    Regression    api_cms
    ${page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN5   tong-garden5    on    active
    ${chicken_page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_CHICKEN_SHOP_ID}    TONG GARDEN5   tong-garden6    on    active
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_CITRA_SHOP_ID}    ${page_id}
    Verify Create Pages Success and Response Data Correct    ${page_id}    TONG GARDEN5   tong-garden5    on    active
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_CHICKEN_SHOP_ID}    ${chicken_page_id}
    Verify Create Pages Success and Response Data Correct    ${chicken_page_id}    TONG GARDEN5   tong-garden6    on    active
    [Teardown]    Run Keywords    Delete Pages by Shop ID    ${SUTIE_CITRA_SHOP_ID}   ${page_id}    AND     Delete Pages by Shop ID    ${SUTIE_CHICKEN_SHOP_ID}    ${chicken_page_id}

TC_ITMWM_05516 Create Pages Duplicate Slug Name in other Shop.
    [Tags]     post_pages    api_pages    Regression    api_cms
    ${page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_CITRA_SHOP_ID}    TONG GARDEN7   tong-garden7    on    active
    ${chicken_page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_CHICKEN_SHOP_ID}    TONG GARDEN8   tong-garden7    on    active
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_CITRA_SHOP_ID}    ${page_id}
    Verify Create Pages Success and Response Data Correct    ${page_id}    TONG GARDEN7   tong-garden7    on    active
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_CHICKEN_SHOP_ID}    ${chicken_page_id}
    Verify Create Pages Success and Response Data Correct    ${chicken_page_id}    TONG GARDEN8   tong-garden7    on    active
    [Teardown]    Run Keywords    Delete Pages by Shop ID    ${SUTIE_CITRA_SHOP_ID}   ${page_id}    AND     Delete Pages by Shop ID    ${SUTIE_CHICKEN_SHOP_ID}    ${chicken_page_id}
