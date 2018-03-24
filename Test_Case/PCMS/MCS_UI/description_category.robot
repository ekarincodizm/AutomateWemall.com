*** Settings ***
Library             Selenium2Library
Library             Collections
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_description_tab.robot
Library             ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_category.py
Resource            ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Common/Keywords_CAMPS_Common.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_category.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_display_tab.robot
Suite Setup         Merchant Category Description - Prepare Data for Test
Suite Teardown      Merchant Category Description - Teardown data for Test

*** Variable ***
${root_id}              1
${level}                1
${50_chars}                       12345678901234567890123456789012345678901234567890
${100_chars}                      ${50_chars}${50_chars}
${255_chars}                      ${100_chars}${100_chars}${50_chars}12345
${256_chars}                      ${255_chars}1

${select_merchant_label}             Hulk_Robot ( HULK01 )
${select_merchant_label2}            Hulk_Robot2 ( HULK02 )
${cat_level_2_name_th}               cat_level_2_name_th
${cat_level_2_name_en}               cat_level_2_name_en
${liveBtn}                          jquery=#categoryActive
${activeBtn}                        jquery=#categoryLiveOnWeb

*** Testcase ***

TC_ITMWM_00251 Display default description tab field when created new category.
    [Tags]    TC_ITMWM_00251
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Click Element    jquery=select#selectMerchant
    Click Element    jquery=select#selectMerchant > option:contains('${select_merchant_label}')
    Merchant Category Management - Click Create New Category
    Sleep    5s
    Merchant Category Description - Verify Category Management Page Info    ${select_merchant_label}
    [Teardown]    Close All Browsers

TC_ITMWM_00252 Change merchant field other filed should be clear.
    [Tags]    TC_ITMWM_00252
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Click Element    jquery=select#selectMerchant
    Click Element    jquery=select#selectMerchant > option:contains('${select_merchant_label}')
    Merchant Category Management - Click Create New Category
    Merchant Category Description - Input Category Name    ${255_chars}
    Merchant Category Description - Input Category Name Translate    ${255_chars}
    Click Element    jquery=select#merchantName
    Click Element    jquery=select#merchantName > option:contains('Hulk_Robot2 ( HULK02 )')
    ${name_th}=    Get Value    jquery=div > input[id='categoryName']
    ${name_en}=    Get Value    jquery=div > input[id='categoryNameTranslate']
    Should Be Equal As Strings     ${EMPTY}    ${name_th}
    Should Be Equal As Strings     ${EMPTY}    ${name_en}
    [Teardown]    Close All Browsers

TC_ITMWM_00253 Validate category and category translation name.
    [Tags]    TC_ITMWM_00253
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Click Element    jquery=select#selectMerchant
    Click Element    jquery=select#selectMerchant > option:contains('${select_merchant_label}')
    Merchant Category Management - Click Create New Category
    Merchant Category Description - Input Category Name    ${256_chars}
    Merchant Category Description - Input Category Name Translate    ${256_chars}
    ${name_th}=    Get Value    jquery=div > input[id='categoryName']
    ${name_en}=    Get Value    jquery=div > input[id='categoryNameTranslate']
    Should Be Equal As Strings     ${255_chars}    ${name_th}
    Should Be Equal As Strings     ${255_chars}    ${name_en}
    Merchant Category Description - Input Category Name    ${SPACE}
    Merchant Category Description - Input Category Name Translate    ${SPACE}
    Merchant Category Description - Click Save Button
    Page Should Contain Element    jquery=a.nav-link.disabled > span:contains('Display')
    [Teardown]    Close All Browsers

TC_ITMWM_00254 Validate slug name field and auto fill slug name by category name.
    [Tags]    TC_ITMWM_00254
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Click Element    jquery=select#selectMerchant
    Click Element    jquery=select#selectMerchant > option:contains('${select_merchant_label}')
    Merchant Category Management - Click Create New Category
    Merchant Category Description - Input Category Name    ทดสอบ-slug
    Merchant Category Description - Input Category Name Translate    test-slug
    Merchant Category Description - Input Slug Name    @#$$$$$$$$$$
    # ${name_th}=    Get Value    jquery=div > input[id='categoryName']
    # ${name_en}=    Get Value    jquery=div > input[id='categoryNameTranslate']
    # Merchant Category Description - Input Category Name    ${SPACE}
    # Merchant Category Description - Input Category Name Translate    ${SPACE}
    Merchant Category Description - Click Save Button
    Sleep    3s
    Page Should Contain Element     jquery=#categorySlugValidationAlert
    [Teardown]    Close All Browsers

TC_ITMWM_00255 Create category level1 has successfully.
    [Tags]    TC_ITMWM_00255
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    Merchant Category Description - Clear Old Category Data    iLekCategoryTH
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    iLekCategoryTH    iLekCategoryEN
    sleep   2s
    Merchant Category - Verify New Category    HULK01    iLekCategoryTH     iLekCategoryEN     1    1   0     inactive
    ${res_idcategory}=    Merchant Category Management Display - Extract Id From Url
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    ${id_cat}=    Merchant Category - Get ID Category by Category name (Level1)    iLekCategoryTH
    Merchant Category Management - Edit Category    ${id_cat}
    Merchant Category Description - Verify Slug On Description Tab    ilekcategoryen
    Permanent Delete Category By Category ID    ${res_idcategory}
    [Teardown]    Close All Browsers

TC_ITMWM_00256 Create sub-category(level2) has successfully.
    [Tags]    TC_ITMWM_00256
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Merchant Category Management - Create Category    ${cat1_id}
    Sleep    2s
    Merchant Category Description - Verify Slug On Description Tab    wmhulk-en-1-1--
    Merchant Category Description - Input Category Name    ${cat_level_2_name_th}
    Merchant Category Description - Input Category Name Translate    ${cat_level_2_name_en}
    Merchant Category Description - Click Save Button
    sleep   2s
    Merchant Category - Verify New Category    HULK01     ${cat_level_2_name_th}    ${cat_level_2_name_en}    ${cat1_id}    2    0     inactive
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Sleep    2s
    ${id_cat}=    Merchant Category - Get ID Category by Category name (Level1)    cat_level_2_name_th
    Merchant Category Management - Edit Category    ${id_cat}
    Merchant Category Description - Verify Slug On Description Tab    wmhulk-en-1-1--cat-level-2-name-en
    Merchant Category- Delete Category level2 by Category name    ${select_merchant_label}    ${cat_level_2_name_th}    ${cat1_id}
    [Teardown]    Close All Browsers

TC_ITMWM_04029 Create sub-category(level6) has successfully.
    [Tags]    TC_ITMWM_04029
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Click Plus Button    ${cat2_id}
    Merchant Category Management - Click Plus Button    ${cat3_id}
    Merchant Category Management - Click Plus Button    ${cat4_id}
    Merchant Category Management - Click Plus Button    ${cat5_id}
    Merchant Category Management - Create Category    ${cat5_id}
    Merchant Category Description - Verify Slug On Description Tab    wmhulk-en-1-5--
    Merchant Category Description - Input Category Name    ปลา
    Merchant Category Description - Input Category Name Translate    fish
    Merchant Category Description - Click Save Button
    sleep    2s
    Page Should Contain Element    jquery=div > span:contains('ปลา')
    ${id_level5}=    Merchant Category Management Display - Extract Id From Url
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Click Plus Button    ${cat2_id}
    Merchant Category Management - Click Plus Button    ${cat3_id}
    Merchant Category Management - Click Plus Button    ${cat4_id}
    Merchant Category Management - Click Plus Button    ${cat5_id}
    Merchant Category Management - Edit Category    ${id_level5}
    Merchant Category Description - Verify Slug On Description Tab    wmhulk-en-1-5--fish
    ${response}=    Permanent Delete Category By Category ID    ${id_level5}
    [Teardown]    Close All Browsers

TC_ITMWM_00257 Edit cat_name_th and cat_naeme_en(lvl1)
    [Tags]    TC_ITMWM_00257
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Merchant Category Management - Edit Category            ${cat1_id}
    sleep   1s
    Merchant Category Management - Edit Name , Name (EN) , Slug    categoryname_edit11     categorynameEN_edit11    slug-edit11
    Select Checkbox         ${liveBtn}
    Select Checkbox         ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category Management - Click On Display Tab
    Merchant Category Description - Verify Slug On Description Tab    slug-edit11
    Merchant Category - Verify New Category    HULK01    categoryname_edit11    categorynameEN_edit11    1    1    1     active
    Close Browser
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Merchant Category Management - Select Category          ${select_merchant_label}
    Merchant Category Management - Edit Category            ${cat1_id}
    sleep   1s
    Merchant Category Management - Edit Name , Name (EN) , Slug    WMHULK-1-1     WMHULKEN-1-1    wmhulken-1-1
    Unselect Checkbox         ${liveBtn}
    Unselect Checkbox        ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category Management - Click On Display Tab
    Merchant Category Description - Verify Slug On Description Tab    wmhulken-1-1
    Merchant Category - Verify New Category    HULK01    WMHULK-1-1    WMHULKEN-1-1    1    1   0     inactive
    # [Teardown]    Close All Browsers

TC_ITMWM_00258 Edit cat_name_th and cat_name_en(lvl2)
    [Tags]    TC_ITMWM_00258
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Merchant Category Management - Select Category    ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Edit Category    ${cat2_id}
    sleep   1s
    Merchant Category Management - Edit Name , Name (EN) , Slug    categoryname_edit22    categorynameEN_edit22    slug-edit2
    Select Checkbox         ${liveBtn}
    Select Checkbox         ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category - Verify New Category    HULK01    categoryname_edit22    categorynameEN_edit22    ${cat1_id}    2      1    active
    Close Browser
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category    ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Edit Category    ${cat2_id}
    sleep   1s
    Merchant Category Management - Edit Name , Name (EN) , Slug    WMHULK-1-2    WMHULKEN-1-2    slug-edit2
    Unselect Checkbox         ${liveBtn}
    Unselect Checkbox        ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category - Verify New Category    HULK01    WMHULK-1-2    WMHULKEN-1-2    ${cat1_id}    2      0     inactive
    [Teardown]    Close All Browsers

TC_ITMWM_00259 Edit cat_name_th and cat_name_en(lvl3)
    [Tags]    TC_ITMWM_00259
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category    ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Click Plus Button    ${cat2_id}
    Merchant Category Management - Edit Category    ${cat3_id}
    sleep    2s
    Merchant Category Management - Edit Name , Name (EN) , Slug    categoryname_edit33    categorynameEN_edit33    categorynamewmhulken-1-3
    Select Checkbox         ${liveBtn}
    Select Checkbox         ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category Management - Click On Display Tab
    Merchant Category Description - Verify Slug On Description Tab    categorynamewmhulken-1-3
    Merchant Category - Verify New Category    HULK01    categoryname_edit33    categorynameEN_edit33    ${cat2_id}    3    1     active
    Close Browser
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category    ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Click Plus Button    ${cat2_id}
    Merchant Category Management - Edit Category    ${cat3_id}
    Sleep    2s
    Merchant Category Management - Edit Name , Name (EN) , Slug    WMHULK-1-3    WMHULKEN-1-3    wmhulken-1-3
    Unselect Checkbox         ${liveBtn}
    Unselect Checkbox         ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category Management - Click On Display Tab
    Merchant Category Description - Verify Slug On Description Tab    wmhulken-1-3
    Merchant Category - Verify New Category    HULK01    WMHULK-1-3    WMHULKEN-1-3    ${cat2_id}    3   0     inactive
    [Teardown]    Close All Browsers

TC_ITMWM_00260 Edit status category name.
    [Tags]    TC_ITMWM_00260
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    sleep    5s
    Merchant Category Management - Select Category    ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Click Plus Button    ${cat2_id}
    Merchant Category Management - Edit Category    ${cat3_id}
    Sleep    2s
    Merchant Category Management - Edit Name , Name (EN) , Slug    categoryname_edit33    categorynameEN_edit33    wmhulken-1-3
    Select Checkbox         ${liveBtn}
    Select Checkbox         ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category - Verify New Category    HULK01    categoryname_edit33    categorynameEN_edit33    ${cat2_id}    3     1     active
    Close Browser
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Merchant Category Management - Select Category    ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Click Plus Button    ${cat2_id}
    Merchant Category Management - Edit Category    ${cat3_id}
    Sleep    2s
    Merchant Category Management - Edit Name , Name (EN) , Slug    WMHULK-1-3    WMHULKEN-1-3    wmhulken-1-3
    Unselect Checkbox         ${liveBtn}
    Unselect Checkbox        ${activeBtn}
    Merchant Category Management - Click Save Category
    Sleep    2s
    Merchant Category - Verify New Category    HULK01    WMHULK-1-3    WMHULKEN-1-3    ${cat2_id}    3    0     inactive
    [Teardown]    Close All Browsers

TC_ITMWM_04031 Parent tail on description tab display data correctly.
    [Tags]      TC_ITMWM_04031
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Merchant Category Management - Select Category    ${select_merchant_label}
    Merchant Category Management - Click Plus Button    ${cat1_id}
    Merchant Category Management - Click Plus Button    ${cat2_id}
    Merchant Category Management - Edit Category        ${cat3_id}
    sleep   5s
    ${trail_text_ui}=              Merchant Category Management - Get Trail From UI
    ${trail}=                   Merchant Category - Get Category Trail By Merchant Code        HULK01
    ${id}=                      Convert To Integer        ${cat3_id}
    ${trail_list}               Join Trail     ${id}       ${trail}
    Should Be Equal As Strings          '${trail_text_ui}'           '${trail_list}'
    [Teardown]    Close All Browsers

TC_ITMWM_04030 Create category by parent tail table has correctly.
    [Tags]    TC_ITMWM_04030
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    3s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Merchant Category Management - Click Create New Category
    Merchant Category - Edit Category Parent
    Merchant Category - Select Parent    1    ${cat1_id}
    Merchant Category - Select Parent    2    ${cat2_id}
    Merchant Category - Select Parent    3    ${cat3_id}
    Merchant Category - Select Parent    4    ${cat4_id}
    Sleep    2s
    # Merchant Category Description - Verify Slug On Description Tab    wmhulken-1-5
    Merchant Category Description - Input Category Name    pen
    Merchant Category Description - Input Category Name Translate    pencil
    Merchant Category Description - Input Slug Name    pen-cil
    Merchant Category Description - Click Save Button
    Sleep    2s
    Merchant Category - Verify New Category    HULK01    pen     pencil     ${cat4_id}    5   0     inactive
      ${res_idcategory}=    Merchant Category Management Display - Extract Id From Url
    Merchant Category Management - Click On Display Tab
    Merchant Category Description - Verify Slug On Description Tab        pen-cil
    Permanent Delete Category By Category ID    ${res_idcategory}

# Clear Category
#     [Tags]      jentest23
#     Merchant Category Description - Delete All Categories          1644

# WMHULK - Category Merchant
#     [Tags]    1
#     Merchant Category - Prepare Data Create Merchant In DB    "Hulk_Robot2"    "HULK02"    "M"
    # ${tc_number}=    Get Test Case Number
    # Merchant Category - Create Category     HULK01    merchant    ${tc_number}

# Delete - Merchant
#     [Tags]    delete
#     ${res_deleted}=    Merchant Category - Delete Merchant From DB    12347647

# #Test Verify Category
#     #Open Browser    http://localhost:4200/category
#     #Merchant Category - Verify New Category         ${merchant_code}        ${category_name}        ${root_id}      ${level}
#     # Merchant Category - Verify New Category         ${merchant_code}        name 2        74      2

# Test Select Parent
#     Open Browser    http://localhost:4200/category/edit/102     chrome
#     sleep       5s
#     Merchant Category - Edit Category Parent
#     Merchant Category - Select Parent       1       104
#     Merchant Category - Select Parent       2       105
#     Merchant Category - Select Parent       3       134
#     Merchant Category - Select Parent       4       136
#     Merchant Category - Select Parent       5       346

# TEST TEST
#     [Tags]    test
#     Merchant Category - Delete Merchant From DB    12347727

*** Keywords ***

Merchant Category Description - Prepare Data for Test
    Merchant Category - Clear Category All Root
    Merchant Category - Create Category     HULK01    merchant    WMHULK
    Merchant Category Description - Set Catogory Id Suited Variable

Merchant Category Description - Teardown data for Test
    Merchant Category Description - Delete All Categories    ${cat1_id}
    Close All Browsers

Merchant Category Description - Set Catogory Id Suited Variable
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    10s
    Wait Until Element Is Visible    jquery=select#selectMerchant    30s
    Click Element    jquery=select#selectMerchant
    Sleep    2s
    Wait Until Element Is Visible    jquery=select#selectMerchant > option:contains('${select_merchant_label}')    30s
    Click Element    jquery=select#selectMerchant > option:contains('${select_merchant_label}')
    Sleep    2s
    ${id_cat_lvl1}=    Merchant Category - Get ID Category by Category name (Level1)    WMHULK-1-1
    Set Suite Variable    ${cat1_id}    ${id_cat_lvl1}
    ${id_cat_lvl1}=    Evaluate    ${id_cat_lvl1}+1
    Set Suite Variable    ${cat2_id}    ${id_cat_lvl1}
    ${id_cat_lvl1}=    Evaluate    ${id_cat_lvl1}+1
    Set Suite Variable    ${cat3_id}    ${id_cat_lvl1}
    ${id_cat_lvl1}=    Evaluate    ${id_cat_lvl1}+1
    Set Suite Variable    ${cat4_id}    ${id_cat_lvl1}
    ${id_cat_lvl1}=    Evaluate    ${id_cat_lvl1}+1
    Set Suite Variable    ${cat5_id}    ${id_cat_lvl1}
    ${id_cat_lvl1}=    Evaluate    ${id_cat_lvl1}+1
    Set Suite Variable    ${cat6_id}    ${id_cat_lvl1}
    Log To Console    Lvl1=${cat1_id}|Lvl2=${cat2_id}|Lvl3=${cat3_id}|Lvl4=${cat4_id}|Lvl5=${cat5_id}|Lvl6=${cat6_id}
    Close Browser

Merchant Category Description - Clear Old Category Data
    [Arguments]    ${check_cat_name}
    ${res}=    Run Keyword And Return Status    Page Should Contain Element    jquery=div > span:contains('${check_cat_name}')
    Log     ${res}
    ${id_res}=    Run Keyword If    ${res}    Merchant Category - Get ID Category by Category name (Level1)    ${check_cat_name}
    ${response}=    Run Keyword If    ${res}    Permanent Delete Category By Category ID   ${id_res}

Merchant Category - Clear Category All Root
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    10s
    Click Element    jquery=select#selectMerchant
    Click Element    jquery=select#selectMerchant > option:contains('${select_merchant_label}')
    Sleep    2s
    ${res}=    Run Keyword And Return Status    Page Should Contain Element    jquery=div > span:contains('WMHULK-1-1')
    Log To Console    ${res}
    ${id_res}=    Run Keyword If    ${res}    Merchant Category - Get ID Category by Category name (Level1)    WMHULK-1-1
    Run Keyword If    ${res}    Merchant Category Description - Delete All Categories    ${id_res}
