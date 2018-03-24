*** Settings ***
Force Tags    WLS_Shop
Library             RequestsLibrary
Library             Collections
Library             Selenium2Library
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/../../../Resource/init.robot
Library             ${CURDIR}/../../../Python_Library/common.py
Library             ${CURDIR}/../../../Python_Library/jsonLibrary.py
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/create_shop_page/css_create_shop_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Suite Setup         Run Keywords    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${repeat_url_shop}
                    ...    AND    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
                    ...    AND    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${repeat_url_shop}

*** Variable ***
#### Test Data ####
${text_256_char}     Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pharetra sit amet ligula vel egestas. Mauris non nulla a velit blandit eleifend. Quisque eget feugiat massa, at lobortis dui. Etiam posuere vitae leo nec feugiat. Pellentesque habitant morbi t
${text_255_char}     Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pharetra sit amet ligula vel egestas. Mauris non nulla a velit blandit eleifend. Quisque eget feugiat massa, at lobortis dui. Etiam posuere vitae leo nec feugiat. Pellentesque habitant morbi
${repeat_shop_name}    Sloth Shop
${repeat_url_shop}     sloth-shop
${symbol_text}         @_!!!!#$%
${img_desktop}         ${CURDIR}/../../../Resource/TestData/pic/sloth.png
${img_mobile}          ${CURDIR}/../../../Resource/TestData/pic/sloth2.png
${updated_shoppages}      ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/prepare_shop_pages.json

*** Test Cases ***
TC_WMALL_01323 Shop list page must be shown "+Add New Shop" button.
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop
    Click Element and Wait Angular Ready    ${addShop_btn}
    Selenium2Library.Element Text Should Be    ${newShop_title}    Add new shop

TC_WMALL_01324 Create new shop page show field data are correctly.
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop
    Click Element and Wait Angular Ready    ${addShop_btn}
    Verify info on Create New Shop

TC_WMALL_01325 Validate message of shop name field on create new shop page.
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop
    Click Element and Wait Angular Ready    ${addShop_btn}

TC_WMALL_01326 Validate message of shop id on create new shop page.
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    MTH2000    ${repeat_shop_name}    ${repeat_url_shop}    inactive
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop
    Click Element and Wait Angular Ready    ${addShop_btn}
    Write Name to console    Robot : String longer than 255 character.
    Input Shop name    ${text_256_char}
    ${res}=    Get Text    ${shopName_field}
    Click Element and Wait Angular Ready    ${merchantId_text}
    Write Name to console    Robot : Repeat Shop Name
    Input Shop name    ${repeat_shop_name}
    Click Element and Wait Angular Ready    ${merchantId_text}
    Selenium2Library.Element Text Should Be    ${errmsg_shopname}    ${exist_shopname}
    [Teardown]    Delete Shop by Shop ID    ${suite_shop_id}

TC_WMALL_01327 Validate message of slug url field on create new shop page.
    [Tags]    shops_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    MTH2000    ${repeat_shop_name}    ${repeat_url_shop}    active
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop
    Click Element and Wait Angular Ready    ${addShop_btn}
    Input Shop name    ${text_256_char}
    ${res}=    Get Text    ${shopName_field}
    Click Element and Wait Angular Ready    ${merchantId_text}
    Input Shop Url    ${repeat_url_shop}
    Click Element and Wait Angular Ready    ${merchantId_text}
    Selenium2Library.Element Text Should Be    ${errmsg_urlshop}    ${exist_shopurl}
    Input Shop Url    ${symbol_text}
    Selenium2Library.Element Text Should Be    ${shopUrl_field}     ${EMPTY}
    [Teardown]    Delete Shop by Shop ID    ${suite_shop_id}

TC_WMALL_01328 Verify that message required field on create new shop page.
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop
    Click Element and Wait Angular Ready    ${addShop_btn}
    Verify info on Create New Shop
    Input Text    ${shopName_field}    ${text_256_char}
    ${res}=    Get Text    ${shopName_field}
    Log To Console    ${res}
    Set Logo(157x85) Image    ${img_desktop}
    Page Should Contain Element    ${disable_save_button}

TC_WMALL_01329 Verfity that alert message of status shop on create shop page.
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop
    Click Element and Wait Angular Ready    ${addShop_btn}
    Click Element and Wait Angular Ready    ${statusShop_switch}
    Selenium2Library.Element Text Should Be    ${status_confirm_title}    Changing status confirm
    Click Element and Wait Angular Ready    ${ok_status_button}
    Click Element and Wait Angular Ready    ${statusShop_switch}
    Selenium2Library.Element Text Should Be    ${status_confirm_title}    Changing status confirm
    Click Element and Wait Angular Ready    ${cancel_status_button}:eq(1)

TC_WMALL_01330 Shop list page must be shown the data shop correctly.
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Click Element and Wait Angular Ready    ${addShop_btn}
    Input Text    ${shopName_field}    Sloth Shop
    Set Logo(157x85) Image    ${img_desktop}
    Set Logo(130x130) Image    ${img_mobile}
    Sleep    2s
    Click Element and Wait Angular Ready    ${statusShop_switch}
    Sleep    2s
    Click Element and Wait Angular Ready    ${ok_status_button}
    Sleep    2s
    Click Element and Wait Angular Ready    ${create_button}
    ${shopId}=     Get Id Shop from Shop Name    Sloth Shop
    ${shopId}=    Replace String    ${shopId}    "    ${EMPTY}    count=-1
    Check Shop Data on Table    ${shopId}    Sloth name    Active     web       Waiting
    Check Shop Data on Table    ${shopId}    Sloth name    Active     mobile    Waiting
    [Teardown]    Delete Shop by Shop ID    ${shopId}

TC_WMALL_01332 Click cancle button on create new shop will close pop-up(modal) and the page show shop list page.
    [Tags]    shops_cms    Regression
    Go to URL Shop List Page
    Selenium2Library.Element Text Should Be    ${addShop_btn}    Add New Shop    message=Add New Shop Button Not Found.
    Click Element and Wait Angular Ready    ${addShop_btn}
    Verify info on Create New Shop
    Click Element and Wait Angular Ready    ${cancel_status_button}

TC_WMALL_01333 Edit the data of shop on edit shop page.
    [Tags]    shops_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    MTH2000    ${repeat_shop_name}    ${repeat_url_shop}    active
    Go to URL Shop List Page
    ${shopId}=    Get Id Shop from Shop Name    Sloth Shop
    ${shopId}=    Replace String    ${shopId}    "    ${EMPTY}    count=-1
    # Log To console    ${table_shop_list} tr[id='${shopId}'] td:eq(3)
    Click Element and Wait Angular Ready    jquery=table.table-striped.table-hover tr[id='${shopId}-web'] td:eq(1)
    Selenium2Library.Element Text Should Be    ${edit_title}    Edit shop : Sloth Shop
    Wait Until Page Contains Element     ${disable_shopUrl}    3s
    [Teardown]    Delete Shop by Shop ID    ${shopId}

TC_WMALL_01334 Edit shop to succes then the shop list page displayed correctly.
    [Tags]    shops_cms    Regression
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    MTHAAAA    ${repeat_shop_name}    ${repeat_url_shop}    active
    Go to URL Shop List Page
    ${shopId}=    Get Id Shop from Shop Name    Sloth Shop
    ${shopId}=    Replace String    ${shopId}    "    ${EMPTY}    count=-1
    Click Edit Shop Web By Shop ID    ${shopId}
    Selenium2Library.Element Text Should Be    ${edit_title}    Edit shop : Sloth Shop
    Input Shop name    Sloth Shop2
    Input Mechant Code    MTHBBBB
    Click Element and Wait Angular Ready    ${statusShop_switch}
    Click Element and Wait Angular Ready    ${ok_status_button}
    Sleep    2s
    Click Element and Wait Angular Ready   ${create_button}
    Check Shop Data on Table    ${shopId}    Sloth Shop2    Inactive     web       Waiting
    Check Shop Data on Table    ${shopId}    Sloth Shop2    Inactive     mobile    Waiting
    Get Shop by Shop ID    ${shopId}
    Verify Get Shop Success and Data Correct    ${shopId}    MTHBBBB    Sloth Shop2    ${repeat_url_shop}    inactive
    Verify Node Pages from Shops is Empty
    # Edit Again
    Update Shop Success    ${shopId}    ${updated_shoppages}    MTHBBBB    Sloth Shop2    ${repeat_url_shop}    inactive
    Click Edit Shop Mobile By Shop ID    ${shopId}
    Selenium2Library.Element Text Should Be    ${edit_title}    Edit shop : Sloth Shop2
    Input Shop name    Sloth Shop3
    Click Element and Wait Angular Ready    ${statusShop_switch}
    Click Element and Wait Angular Ready    ${ok_status_button}
    Sleep    2s
    Click Element and Wait Angular Ready   ${create_button}
    Check Shop Data on Table    ${shopId}    Sloth Shop3    Active     web       Waiting
    Check Shop Data on Table    ${shopId}    Sloth Shop3    Active     mobile    Waiting
    Get Shop by Shop ID    ${shopId}
    Verify Get Shop Success and Data Correct    ${shopId}    MTHBBBB    Sloth Shop3    ${repeat_url_shop}    active
    Verify Node Pages from Shops is Not Empty
    Verify Node Pages Matched with Expected    ${updated_shoppages}
    [Teardown]    Delete Shop by Shop ID    ${shopId}

TC_ITMWM_05668 Edit shop data - duplicate shop name
    [Tags]    shops_cms    Regression
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    MTHAAAA    Exist Shop    duplicate    inactive
    ${duplicate_shopId}=    Get Id Shop from Shop Name    Exist Shop
    ${duplicate_shopId}=    Replace String    ${duplicate_shopId}    "    ${EMPTY}    count=-1
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    MTHAAAA    ${repeat_shop_name}    ${repeat_url_shop}    active
    Go to URL Shop List Page
    Click Edit Shop Web By Shop ID    ${suite_shop_id}
    Selenium2Library.Element Text Should Be    ${edit_title}    Edit shop : Sloth Shop
    Input Shop name    Exist Shop
    Click Element    ${merchantId_field}
    Error Message Shop Name Already Exists Appears
    [Teardown]    Run Keywords    Delete Shop by Shop ID    ${duplicate_shopId}
                  ...    AND    Delete Shop by Shop ID    ${suite_shop_id}



















