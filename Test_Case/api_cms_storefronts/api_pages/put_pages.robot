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
Suite Teardown      Run Keywords    Delete Shop by Shop ID Success    ${SUTIE_DOWNY_SHOP_ID}    AND    Delete Shop by Shop ID Success    ${SUITE_LCD_SHOP_ID}

*** Variable ***
${pages_json}                ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/pages/pages_template.json

${body_post_template}        ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${downy_merchant_id}         Downy0001
${downy_shop_name}           Downy Shop
${downy_shop_slug}           downy-shop
${downy_shop_slug_TH}        ดาวน์นี่-กลิ่นหอมสดชื่นยามเช้า
${deafult_merchant_id}       ${EMPTY}
${lcd_merchant_id}           Lcd0001
${lcd_shop_name}             LCD SCREEN
${lcd_shop_slug}             lcd-screen
${lcd_shop_slug_TH}          น้ำยาเช็ด-หน้าจอ

*** Keywords ***

Prepare Shop And Check is Shop Exist
    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${downy_shop_slug}
    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${lcd_shop_slug}
    ${downy_shop_id}=    Create Shop Success    ${body_post_template}    ${downy_merchant_id}    ${downy_shop_name}    ${downy_shop_slug}    active
    Set Suite Variable    ${SUTIE_DOWNY_SHOP_ID}    ${downy_shop_id}
    ${lcd_shop_id}=    Create Shop Success    ${body_post_template}    ${lcd_merchant_id}    ${lcd_shop_name}    ${lcd_shop_slug}    active
    Set Suite Variable    ${SUITE_LCD_SHOP_ID}    ${lcd_shop_id}

Prepare Pages Data
    ${page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_DOWNY_SHOP_ID}    Mont Fleur   mont-fleur    on    active
    Set Suite Variable    ${SUITE_DOWNY_PAGES_ID}    ${page_id}

Prepare Pages In LCD Shop Data
    ${page_id}=    Create Pages Success    ${pages_json}    ${SUITE_LCD_SHOP_ID}    Digda Ball    digda-ball    on    active
    Set Suite Variable    ${SUITE_LCD_PAGES_ID}    ${page_id}

*** Test Cases ***

TC_ITMWM_05517 Update Pages Success.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages Success    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    Update Downy    update-downy-shop    off    inactive
    ${res}=    Get Response Body
    Log    ${res}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Update Downy    mont-fleur    off    inactive
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05518 Update Pages by Name and Slug Thai Language.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages Success    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    อัพเดทดาว์นี่น้ำยาปรับผ้านุ่ม    downy-shop    off    inactive
    ${res}=    Get Response Body
    Log    ${res}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    อัพเดทดาว์นี่น้ำยาปรับผ้านุ่ม    mont-fleur    off    inactive
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05519 Update Pages by Empty Page Name.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages Not Success    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    ${EMPTY}    downy-shop    off    inactive
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid page name
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Mont Fleur   mont-fleur    on    active
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05520 Update Pages by Empty Slug Name.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages Success    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    Update Downy    ${EMPTY}    off    inactive
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Update Downy    mont-fleur    off    inactive
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05521 Update Pages by Empty Banner Display.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages Not Success    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    Update Downy    downy-shop    ${EMPTY}    inactive
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid banner display format
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Mont Fleur   mont-fleur    on    active
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05522 Update Pages by Empty Banner Page Status.
    [Setup]    Prepare Pages Data
    Update Pages Not Success    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    Update Downy    downy-shop    on    ${EMPTY}
    Verify Error Code Message    400 Bad Request    CSS4006    Invalid Input Data Format    Invalid page status format
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Mont Fleur   mont-fleur    on    active
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05523 Update Pages Page Name Only.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages By Pages Name Node Only    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    Update Downy Only
    ${res}=    Get Response Body
    Log    ${res}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Update Downy Only    mont-fleur    on    active
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05524 Update Pages Banner Display Only.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages By Banner Display Node Only    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    off
    ${res}=    Get Response Body
    Log    ${res}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Mont Fleur    mont-fleur    off    active
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05525 Update Pages Page Status Only.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    Update Pages By Page Status Node Only    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    ${pages_json}    inactive
    ${res}=    Get Response Body
    Log    ${res}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_DOWNY_PAGES_ID}    Mont Fleur    mont-fleur    on    inactive
    [Teardown]    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}

TC_ITMWM_05526 Update Pages Duplicate Page Name in same Shop.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Prepare Pages Data
    ${page_id}=    Create Pages Success    ${pages_json}    ${SUTIE_DOWNY_SHOP_ID}    Mont Fleur2   mont-fleur2    on    active
    Update Pages By Pages Name Node Only Failed    ${SUTIE_DOWNY_SHOP_ID}   ${page_id}    ${pages_json}    Mont Fleur
    ${res}=    Get Pages Detail by Page ID And Return Response    ${SUTIE_DOWNY_SHOP_ID}    ${page_id}
    Verify Response Create and Update Pages Data Correct    ${res}    ${page_id}    Mont Fleur2   mont-fleur2    on    active
    [Teardown]    Run Keywords    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    AND        Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}    ${page_id}

TC_ITMWM_05527 Update Pages Duplicate Page Name in other Shop.
    [Tags]     put_pages    api_pages    Regression    api_cms
    [Setup]    Run Keywords    Prepare Pages Data    AND    Prepare Pages In LCD Shop Data
    Update Pages By Pages Name Node Only    ${SUITE_LCD_SHOP_ID}   ${SUITE_LCD_PAGES_ID}    ${pages_json}    Mont Fleur
    ${res}=    Get Response Body
    Log    ${res}
    Verify Response Create and Update Pages Data Correct    ${res}    ${SUITE_LCD_PAGES_ID}    Mont Fleur    digda-ball    on    active
    [Teardown]    Run Keywords    Delete Pages by Shop ID    ${SUTIE_DOWNY_SHOP_ID}   ${SUITE_DOWNY_PAGES_ID}    AND    Delete Pages by Shop ID    ${SUITE_LCD_SHOP_ID}   ${SUITE_LCD_PAGES_ID}
