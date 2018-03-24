*** Settings ***
Library             Selenium2Library
Library             Collections
Library             ${CURDIR}/../../../Python_Library/common.py
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_category.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_description_tab.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_display_tab.robot
Resource            ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_category.robot
Suite Setup         Prepare TestData
Suite Teardown      Delete Prepare TestData

*** Variable ***
${select_merchant_label}             Hulk_Robot ( HULK01 )
${select_merchant_code}              HULK01
${created_cat_name_th}               iRobotCategoryTH
${created_cat_name_en}               iRobotCategoryEN
${cat_name_lv11_th}                  AlohaLv11TH
${cat_name_lv11_en}                  AlohaLv11EN
${cat_name_lv211_th}                 AlohaLv211TH
${cat_name_lv211_en}                 AlohaLv211EN
${cat_name_lv212_th}                 AlohaLv212TH
${cat_name_lv212_en}                 AlohaLv212EN
${cat_name_lv12_th}                  AlohaLv12TH
${cat_name_lv12_en}                  AlohaLv12EN
${cat_name_lv221_th}                 AlohaLv221TH
${cat_name_lv221_en}                 AlohaLv221EN
${cat_level1_id}                     81
${default_image_url}                 http://cdn.wemall.com/th/wemall/wemall/logo-wemall-portal@x.png?v=6a19c920
${imgName}                           kapao.jpg
${imgPath}                           ${CURDIR}/../../../Resource/TestData/pic/kapao.jpg
${prepareImgPath}                    ${CURDIR}/../../../Resource/TestData/pic/sloth2.png
${CategoryMgtLocator}               jquery=h3:contains("Category Management")

*** Testcase ***
TC_ITMWM_04146 Display tab shown info correctly
    [Tags]    TC_ITMWM_04146
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${created_cat_name_th}    ${created_cat_name_en}
    Sleep    1s
    Merchant Category Management Display - Verify Category Data    ${created_cat_name_th}    ${select_merchant_label}    WEMALL
    Merchant Category Management Display - Verify Banner Management    desktop    ${default_image_url}    ${EMPTY}    ${EMPTY}    ${TRUE}
    Merchant Category Management Display - Verify Banner Management    mobile    ${default_image_url}    ${EMPTY}    ${EMPTY}    ${TRUE}
    Merchant Category Management Display - Verify Thumbnail Management    publish    product

    ${id}=    Merchant Category Management Display - Extract Id From Url
    [Teardown]    Delete Category By Category ID    ${id}

TC_ITMWM_04147 Banner cateogry level1 is required field
    [Tags]    TC_ITMWM_04147
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${created_cat_name_th}    ${created_cat_name_en}
    Sleep    1s
    Merchant Category Management Display - Remove Image    desktop
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Image Required    desktop
    #
    Merchant Category Management Display - Remove Image    mobile
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Image Required    mobile
    #
    ${id}=    Merchant Category Management Display - Extract Id From Url
    [Teardown]    Delete Category By Category ID    ${id}

TC_ITMWM_04148 Change banner on category level1 has success.
    [Tags]    TC_ITMWM_04148
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${created_cat_name_th}    ${created_cat_name_en}
    Sleep    1s
    ${canonicalPath}=    Get Canonical Path    ${imgPath}
    Merchant Category Management Display - Remove Image    desktop
    Merchant Category Management Display - Choose Image    desktop    ${canonicalPath}
    Merchant Category Management Display - Remove Image    mobile
    Merchant Category Management Display - Choose Image    mobile    ${canonicalPath}
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Save Success

    ${id}=    Merchant Category Management Display - Extract Id From Url
    Merchant Category Management Display - Verify Category Display Data    ${id}    ${imgName}    ${EMPTY}    ${EMPTY}    ${TRUE}    ${imgName}    ${EMPTY}    ${EMPTY}    ${TRUE}    publish    product
    #
    [Teardown]    Delete Category By Category ID    ${id}

TC_ITMWM_04149 Can swich to description tab and edit data, it work correctly
    [Tags]    TC_ITMWM_04149
    Login Pcms
    Merchant Category Management Display - Goto Display Cat Lv2    ${select_merchant_label}    ${idLv11}    ${idLv212}
    Merchant Category Management Display - Verify Category Data    ${cat_name_lv11_th} > ${cat_name_lv212_th}    ${select_merchant_label}    WEMALL
    Merchant Category Management - Click On Description Tab
    Merchant Category Description - Input Category Name    ${cat_name_lv212_th}XXX
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category Management - Click On Display Tab
    Sleep    2s
    Merchant Category Management Display - Verify Category Data    ${cat_name_lv11_th} > ${cat_name_lv212_th}XXX    ${select_merchant_label}    WEMALL

TC_ITMWM_04150 Edit category level1 work correctly
    [Tags]    TC_ITMWM_04150
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Management - Select Category          ${select_merchant_label}
    sleep   1s
    Merchant Category Management - Edit Category By Name            ${cat_name_lv11_th}
    sleep   1s
    Merchant Category Management - Click On Display Tab

    ${canonicalPath}=    Get Canonical Path    ${imgPath}
    Merchant Category Management Display - Update Display    alt desktop    link desktop    ${FALSE}    ${canonicalPath}    alt mobile    link mobile    ${FALSE}    ${canonicalPath}    ranking    variant
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Save Success

    ${id}=    Merchant Category Management Display - Extract Id From Url
    Merchant Category Management Display - Verify Category Display Data    ${id}    ${imgName}    alt desktop    link desktop    ${FALSE}    ${imgName}    alt mobile    link mobile    ${FALSE}    ranking    variant

TC_ITMWM_04151 Subcategory can edit display tab data correctly
    [Tags]    TC_ITMWM_04151
    Login Pcms
    Merchant Category Management Display - Goto Display Cat Lv2    ${select_merchant_label}    ${idLv11}    ${idLv211}

    #edit
    ${canonicalPath}=    Get Canonical Path    ${imgPath}
    Merchant Category Management Display - Update Display    alt desktop    link desktop    ${FALSE}    ${canonicalPath}    alt mobile    link mobile    ${FALSE}    ${canonicalPath}    ranking    variant
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Save Success

    ${id}=    Merchant Category Management Display - Extract Id From Url
    Merchant Category Management Display - Verify Category Display Data    ${id}    ${imgName}    alt desktop    link desktop    ${FALSE}    ${imgName}    alt mobile    link mobile    ${FALSE}    ranking    variant

TC_ITMWM_04152 Delete banner subcategory correctly.
    [Tags]    TC_ITMWM_04152    regression
    Login Pcms
    Merchant Category Management Display - Goto Display Cat Lv2    ${select_merchant_label}    ${idLv11}    ${idLv211}

    #edit
    Merchant Category Management Display - Update Display    alt desktop    link desktop    ${FALSE}    ${EMPTY}    alt mobile    link mobile    ${FALSE}    ${EMPTY}    ranking    variant
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Save Success

    ${id}=    Merchant Category Management Display - Extract Id From Url
    Merchant Category Management Display - Verify Category Display Data    ${id}    ${EMPTY}    alt desktop    link desktop    ${FALSE}    ${EMPTY}    alt mobile    link mobile    ${FALSE}    ranking    variant

TC_ITMWM_04153 Update banner subcategory correctly.
    [Tags]    TC_ITMWM_04153    regression
    Login Pcms
    Merchant Category Management Display - Goto Display Cat Lv2    ${select_merchant_label}    ${idLv11}    ${idLv211}

    #edit
    ${canonicalPath}=    Get Canonical Path    ${imgPath}
    Merchant Category Management Display - Update Display    alt desktop    link desktop    ${FALSE}    ${canonicalPath}    alt mobile    link mobile    ${FALSE}    ${canonicalPath}    ranking    variant
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Save Success

    ${id}=    Merchant Category Management Display - Extract Id From Url
    Merchant Category Management Display - Verify Category Display Data    ${id}    ${imgName}    alt desktop    link desktop    ${FALSE}    ${imgName}    alt mobile    link mobile    ${FALSE}    ranking    variant

TC_ITMWM_04154 Default Image has been changed after changing image of category lv1
    [Tags]    TC_ITMWM_04154   regression
    Login Pcms
    Merchant Category Management Display - Goto Display Cat Lv2    ${select_merchant_label}    ${idLv12}    ${idLv221}
    #verify lv
    Merchant Category Management Display - Verify Category Data    ${cat_name_lv12_th} > ${cat_name_lv221_th}    ${select_merchant_label}    WEMALL
    Merchant Category Management Display - Verify Banner Management    desktop    ${default_image_url}    ${EMPTY}    ${EMPTY}    ${TRUE}
    Merchant Category Management Display - Verify Banner Management    mobile    ${default_image_url}    ${EMPTY}    ${EMPTY}    ${TRUE}
    Merchant Category Management Display - Verify image badge    ${TRUE}   ${TRUE}

    Merchant Category Management Display - Goto Display Cat Lv1    ${select_merchant_label}    ${idLv12}
    ${canonicalPath}=    Get Canonical Path    ${imgPath}
    Merchant Category Management Display - Remove Image    desktop
    Merchant Category Management Display - Choose Image    desktop    ${canonicalPath}
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Save Success

    Merchant Category Management Display - Goto Display Cat Lv2    ${select_merchant_label}    ${idLv12}    ${idLv221}
    Merchant Category Management Display - Verify Category Data    ${cat_name_lv12_th} > ${cat_name_lv221_th}    ${select_merchant_label}    WEMALL
    Merchant Category Management Display - Verify Banner Management    desktop    ${imgName}    ${EMPTY}    ${EMPTY}    ${TRUE}
    Merchant Category Management Display - Verify Banner Management    mobile    ${default_image_url}    ${EMPTY}    ${EMPTY}    ${TRUE}
    Merchant Category Management Display - Verify image badge    ${TRUE}   ${FALSE}


*** Keywords ***
Prepare TestData
    Login Pcms
    #add cat lv 11
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${cat_name_lv11_th}    ${cat_name_lv11_en}
    Sleep    1s
    ${tId}=    Merchant Category Management Display - Extract Id From Url
    Set Suite Variable    ${idLv11}    ${tId}
    Log To Console    idLv11:${idLv11}

    #add cat lv 211
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Management - Select Category          ${select_merchant_label}
    sleep   2s
    Merchant Category Management - Create Category    ${idLv11}
    sleep   2s
    Merchant Category Description - Input Category Name    ${cat_name_lv211_th}
    Merchant Category Description - Input Category Name Translate    ${cat_name_lv211_en}
    Merchant Category Description - Click Save Button
    Merchant Category Management Display - Display Tab has been shown

    ${canonicalPath}=    Get Canonical Path    ${prepareImgPath}
    Merchant Category Management Display - Remove Image    desktop
    Merchant Category Management Display - Choose Image    desktop    ${canonicalPath}
    Merchant Category Management Display - Remove Image    mobile
    Merchant Category Management Display - Choose Image    mobile    ${canonicalPath}
    Merchant Category Management Display - Click Save
    Merchant Category Management Display - Verify Save Success

    ${tId}=    Merchant Category Management Display - Extract Id From Url
    Set Suite Variable    ${idLv211}    ${tId}
    Log To Console    idLv211:${idLv211}

    #add cat lv 212
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Management - Select Category          ${select_merchant_label}
    sleep   2s
    Merchant Category Management - Create Category    ${idLv11}
    sleep   2s
    Merchant Category Description - Input Category Name    ${cat_name_lv212_th}
    Merchant Category Description - Input Category Name Translate    ${cat_name_lv212_en}
    Merchant Category Description - Click Save Button
    Merchant Category Management Display - Display Tab has been shown

    ${tId}=    Merchant Category Management Display - Extract Id From Url
    Set Suite Variable    ${idLv212}    ${tId}
    Log To Console    idLv212:${idLv212}

    #add cat lv 12
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${cat_name_lv12_th}    ${cat_name_lv12_en}
    Sleep    1s
    ${tId}=    Merchant Category Management Display - Extract Id From Url
    Set Suite Variable    ${idLv12}    ${tId}
    Log To Console    idLv12:${idLv12}

    #add cat lv 213
    Go To    ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Visible    jquery=option:contains('${select_merchant_label}')    30
    Merchant Category Management - Select Category          ${select_merchant_label}
    sleep   2s
    Merchant Category Management - Create Category    ${idLv12}
    sleep   2s
    Merchant Category Description - Input Category Name    ${cat_name_lv221_th}
    Merchant Category Description - Input Category Name Translate    ${cat_name_lv221_en}
    Merchant Category Description - Click Save Button
    Merchant Category Management Display - Display Tab has been shown

    ${tId}=    Merchant Category Management Display - Extract Id From Url
    Set Suite Variable    ${idLv221}    ${tId}
    Log To Console    idLv221:${idLv221}

Delete Prepare TestData
    Delete Category By Category ID    ${idLv211}
    Delete Category By Category ID    ${idLv212}
    Delete Category By Category ID    ${idLv11}
    Delete Category By Category ID    ${idLv221}
    Delete Category By Category ID    ${idLv12}
    Close All Browsers