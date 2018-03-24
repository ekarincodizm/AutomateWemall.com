*** Settings ***
Force Tags    WLS_Merchant_Level_C
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_c_page/keyword_level_c.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/merchant_level_c/paginate_and_sorting_keyword.robot
Test Teardown     Close All Browsers

*** Variables ***
${total_product}       //*[@id='wrapper_content']/div/div[4]/div[1]/div/div[3]/span
${sorting}             //*[@id='wrapper_content']/div/div[4]/div[1]/div/div[2]/div/div/select
${cate_lv_2}           .//*[@id='filter-list-category']/div/a[3]
*** Test Cases ***

TC_ITMWM_03997 Verify Latest Sorting on Lv.C for Merchant
    [Tags]    TC_ITMWM_03997    regression    lyrasprint15
    ${cat_query_string}=    Set Variable    ?page=1&sort_by=price&order=desc
    ${product_no_1}=    Set Variable    ${xpath_product_no_1}

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${sorting}
    Click Element    ${sorting}
    Click Element    ${sorting}/option[1]
    Wait Until Element Is Visible    ${product_no_1}
    ${product_no_1_name}=    Get Text    ${product_no_1}
    Should Be Equal    ${product_no_1_name}    TestLyra0001


TC_ITMWM_03998 Verify Price High to Low on Lv.C for Merchant
    [Tags]    TC_ITMWM_03998    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&sort_by=discount&order=desc
    ${product_no_1}=    Set Variable    ${xpath_product_no_1}
    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}

    Wait Until Element Is Visible    ${sorting}
    Click Element    ${sorting}
    Wait Until Element Is Visible    ${sorting}/option[2]
    Click Element    ${sorting}/option[2]
    Wait Until Element Is Visible    ${product_no_1}
    ${product_no_1_name}=    Get Text    ${product_no_1}

    Should Be Equal    ${product_no_1_name}    TestLyra0001

TC_ITMWM_03999 Verify Price Low to High on Lv.C for Merchant
    [Tags]    TC_ITMWM_03999    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&sort_by=discount&order=desc
    ${product_no_1}=    Set Variable    //*[@id='wrapper_content']/div/div[4]/div[3]/div[1]/div/a/span[2]/span[1]
    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${sorting}
    Click Element    ${sorting}
    Click Element    ${sorting}/option[3]
    Wait Until Element Is Visible    ${product_no_1}
    ${product_no_1_name}=    Get Text    ${product_no_1}
    Should Be Equal    ${product_no_1_name}    TestLyra0005

TC_ITMWM_04000 Verify %Discount High to Low on Lv.C for Merchant
    [Tags]    TC_ITMWM_04000    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&sort_by=price&order=desc
    ${product_no_1}=    Set Variable    //*[@id='wrapper_content']/div/div[4]/div[3]/div[1]/div/a/span[2]/span[1]
    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${sorting}
    #Sleep    5s
    Click Element    ${sorting}
    Click Element    ${sorting}/option[4]
    Wait Until Element Is Visible    ${product_no_1}
    ${product_no_1_name}=    Get Text    ${product_no_1}
    Should Be Equal    ${product_no_1_name}    TestLyra0002

TC_ITMWM_04001 Verify %Discount Low to High on Lv.C for Merchant
    [Tags]    TC_ITMWM_04001    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&sort_by=price&order=asc
    ${product_no_1}=    Set Variable    //*[@id='wrapper_content']/div/div[4]/div[3]/div[1]/div/a/span[2]/span[1]
    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${sorting}
    #Sleep    5s
    Click Element    ${sorting}
    Click Element    ${sorting}/option[5]
    Wait Until Element Is Visible    ${product_no_1}
    ${product_no_1_name}=    Get Text    ${product_no_1}
    Should Be Equal    ${product_no_1_name}    TestLyra0006

TC_ITMWM_04003 Verify Total Items on Lv.C for Merchant
    [Tags]    TC_ITMWM_04003    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Sleep    5s
    Wait Until Element Is Visible    ${total_product}
    ${total_product_text}=    Get Text    ${total_product}
    Should Be Equal    ${total_product_text}    จำนวนทั้งหมด 100 ชิ้น

TC_ITMWM_04004 Verify Breadcrum on Lv.C for Merchant
    [Tags]    TC_ITMWM_04004    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${breadcrum_shop}=    Set Variable      //*[@id="link_map"]/span
    ${breadcrum_cate_lv_1}=    Set Variable      //*[@id="link_map"]/li[1]
    ${breadcrum_cate_lv_2_current}=    Set Variable      //*[@id="link_map"]/li[2]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${breadcrum_shop}
    Wait Until Element Is Visible    ${breadcrum_cate_lv_1}
    Wait Until Element Is Visible    ${breadcrum_cate_lv_2_current}

    ${breadcrum_shop_text}=    Get Text    ${breadcrum_shop}
    ${breadcrum_cate_lv_1_text}=    Get Text    ${breadcrum_cate_lv_1}
    ${breadcrum_cate_lv_2_current_text}=    Get Text    ${breadcrum_cate_lv_2_current}
    Should Be Equal    ${breadcrum_shop_text}    Lyra-Test
    Should Be Equal    ${breadcrum_cate_lv_1_text}    โทรศัพท์ & แท็บเล็ต
    Should Be Equal    ${breadcrum_cate_lv_2_current_text}    โทรศัพท์

TC_ITMWM_04005 Verify Product Price on Lv.C for Merchant
    [Tags]    TC_ITMWM_04005    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${product_no_1}=    Set Variable    //*[@id='wrapper_content']/div/div[4]/div[3]/div[1]/div/a/span[2]/span[1]
    ${product_no_1_price}=    Set Variable    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[2]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${sorting}
    Click Element    ${sorting}
    Click Element    ${sorting}/option[5]
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_price}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_price_text}=    Get Text    ${product_no_1_price}
    Should Be Equal    ${product_no_1_text}    TestLyra0006
    Should Be Equal    ${product_no_1_price_text}    ฿ 1,000.-

TC_ITMWM_04006 Verify Product Special Price on Lv.C for Merchant
    [Tags]    TC_ITMWM_04006    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1
    ${product_no_1}=    Set Variable    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[2]
    ${product_no_1_special_price}=    Set Variable    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[3]/span[1]
    ${product_no_1_normal_price}=    Set Variable    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[3]/span[2]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_special_price}
    Wait Until Element Is Visible    ${product_no_1_normal_price}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_special_price_text}=    Get Text    ${product_no_1_special_price}
    ${product_no_1_normal_price_text}=    Get Text    ${product_no_1_normal_price}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_special_price_text}    ฿ 6,000.-
    Should Be Equal    ${product_no_1_normal_price_text}    ฿ 10,000.-

TC_ITMWM_04007 Verify % Discount on Lv.C for Merchant
    [Tags]    TC_ITMWM_04007    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1
    ${product_no_1}=    Set Variable    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[2]
    ${product_no_1_discount}=    Set Variable    //*[@id="${product_pkey_p_01}"]/div[1]/span/span[1]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_discount}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_discount_text}=    Get Text    ${product_no_1_discount}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_discount_text}    40

TC_ITMWM_04008 Verify Out of Stock on Lv.C for Merchant
    [Tags]    TC_ITMWM_04008    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1
    ${product_no_4}=    Set Variable    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[5]/div/a/span[2]/span[1]
    ${product_no_4_out_of_stock}=    Set Variable    //*[@id="${product_pkey_outofstock}"]/div[2]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${product_no_4}
    Wait Until Element Is Visible    ${product_no_4_out_of_stock}

    ${product_no_4_text}=    Get Text    ${product_no_4}
    ${product_no_4_out_of_stock_count}=   Get Matching Xpath Count    ${product_no_4_out_of_stock}
    Should Be Equal    ${product_no_4_text}    TestLyra0004
    Should Be Equal    ${product_no_4_out_of_stock_count}    1

TC_ITMWM_04009 Verify Freebie Image on Lv.C for Merchant
    [Tags]    TC_ITMWM_04009    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1
    ${product_no_1}=    Set Variable    ${xpath_product_no_1}
    ${product_no_1_freebies}=    Set Variable    //*[@id="${product_pkey_p_01}"]/img[2]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_freebies}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_freebies_count}=   Get Matching Xpath Count    ${product_no_1_freebies}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_freebies_count}    1

TC_ITMWM_05164 Verify Installment on Lv.C for Merchant
    [Tags]    TC_ITMWM_05164    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1
    ${product_no_1}=    Set Variable    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[2]
    ${product_no_1_installment}=    Set Variable    //*[@id="${product_pkey_p_01}"]/div[1]/span/span[2]
    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_installment}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_installment_count}=   Get Matching Xpath Count    ${product_no_1_installment}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_installment_count}    1

TC_ITMWM_04011 Verify has disclosure indicator on Cat Section Menu
    [Tags]    TC_ITMWM_04011    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${all_category}=   Set Variable    //*[@id="filter-list-category"]/div/a[1]
    ${mobile_tablet_cate}=   Set Variable    //*[@id="filter-list-category"]/div/a[2]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${all_category}
    Wait Until Element Is Visible    ${mobile_tablet_cate}

    ${all_category_text}=    Get Text    ${all_category}
    ${mobile_tablet_cate_text}=   Get Text    ${mobile_tablet_cate}
    Should Be Equal    ${all_category_text}    กลับไปหมวดหมู่ทั้งหมด
    Should Be Equal    ${mobile_tablet_cate_text}   โทรศัพท์ & แท็บเล็ต

TC_ITMWM_04012 Verify no disclosure indicator on Cat Menu Lv 1
    [Tags]    TC_ITMWM_04012    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${product_for_mom_cate}=    Set Variable    //*[@id="filter-list-category"]/div/a[4]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Back to all category
    ${product_for_mom_text}=    Get Text    ${product_for_mom_cate}
    Should Be Equal    ${product_for_mom_text}    ผลิตภัณฑ์สำหรับคุณแม่


TC_ITMWM_04013 Verify has disclosure indicator on Cat Menu Lv 1
    [Tags]    TC_ITMWM_04013    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${mobile_tablet_cate}=    Set Variable    //*[@id="filter-list-category"]/div/a[2]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Back to all category
    ${icon_class}    Get Element Attribute    ${mobile_tablet_cate}/i@class
    Should Be Equal    ${icon_class}    icon-arrow-right-edge


TC_ITMWM_04014 Verify no disclosure indicator on Cat Menu Lv 2
    [Tags]    TC_ITMWM_04014    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Back to all category
    ${mom_and_kid}    Set Variable    //*[@id="filter-list-category"]/div/a[3]
    ${kid_element}    Set Variable    //*[@id="filter-list-category"]/div/a[3]

    Click Element    ${mom_and_kid}
    Wait Until Element Is Visible    ${kid_element}
    ${kid_text}    Get Text    ${kid_element}
    Should Be Equal    ${kid_text}    เด็ก

TC_ITMWM_04015 Verify has disclosure indicator on Cat Menu Lv 2
    [Tags]    TC_ITMWM_04015    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${mobile_tablet}    Set Variable    //*[@id="filter-list-category"]/div/a[1]
    ${mobile_element}    Set Variable    //*[@id="filter-list-category"]/div/a[3]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Back to all category
    Click Element    ${mobile_tablet}
    Wait Until Element Is Visible    ${mobile_element}
    ${icon_class}    Get Element Attribute    ${mobile_element}/i@class
    Should Be Equal    ${icon_class}    icon-arrow-right-edge

TC_ITMWM_04016 Verify no disclosure indicator on Cat Menu Lv 3
    [Tags]    TC_ITMWM_04016    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${camera_cate}    Set Variable    //*[@id="filter-list-category"]/div/a[2]
    ${compac_cate}    Set Variable    //*[@id="filter-list-category"]/div/a[3]
    ${canon_element}    Set Variable    //*[@id="filter-list-category"]/div/a[4]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Back to all category
    Click Element    ${camera_cate}
    Wait Until Element Is Visible    ${compac_cate}
    Click Element    ${compac_cate}
    Wait Until Element Is Visible    ${canon_element}
    ${canon_text}    Get Text    ${canon_element}
    Should Be Equal    ${canon_text}    แคนนอน


TC_ITMWM_04017 Verify has disclosure indicator on Cat Menu Lv 3
    [Tags]    TC_ITMWM_04017    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${mobile_tablet}    Set Variable    //*[@id="filter-list-category"]/div/a[1]
    ${mobile_element}    Set Variable    //*[@id="filter-list-category"]/div/a[3]
    ${iphone_element}    Set Variable    //*[@id="filter-list-category"]/div/a[4]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Back to all category
    Click Element    ${mobile_tablet}
    Wait Until Element Is Visible    ${mobile_element}
    Click Element    ${mobile_element}
    Wait Until Element Is Visible    ${iphone_element}
    ${icon_class}    Get Element Attribute    ${iphone_element}/i@class
    Should Be Equal    ${icon_class}    icon-arrow-right-edge


TC_ITMWM_04018 Verify no disclosure indicator on Cat Menu Lv 4
    [Tags]    TC_ITMWM_04018    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${mobile_tablet}    Set Variable    //*[@id="filter-list-category"]/div/a[1]
    ${mobile_element}    Set Variable    //*[@id="filter-list-category"]/div/a[3]
    ${iphone_element}    Set Variable    //*[@id="filter-list-category"]/div/a[4]
    ${iphone5_element}    Set Variable    //*[@id="filter-list-category"]/div/a[5]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Back to all category
    Click Element    ${mobile_tablet}
    Wait Until Element Is Visible    ${mobile_element}
    Click Element    ${mobile_element}
    Wait Until Element Is Visible    ${iphone_element}
    Click Element    ${iphone_element}
    Wait Until Element Is Visible    ${iphone5_element}
    ${iphone5_text}    Get Text    ${iphone5_element}
    Should Be Equal    ${iphone5_text}    ไอโฟน 5เอส

TC_ITMWM_04019 Verify Max 15 Categories on Lv.C for Merchant
    [Tags]    TC_ITMWM_04019    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${all_merchant_list}=  Set Variable   //*[@id="filter-list-category"]/div/a[1]
    ${list_filter}=        Set Variable   //*[@id="filter-list-category"]/div/a

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Click Element      ${all_merchant_list}
    And Wait Until Element Is Visible   ${all_merchant_list}
    Locator Should Match X Times    ${list_filter}  15

TC_ITMWM_04020 Verify More Button on Lv.C for Merchant
    [Tags]    TC_ITMWM_04020    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${all_merchant_list}=  Set Variable   //*[@id="filter-list-category"]/div/a[1]
    ${more_button}=        Set Variable   //*[@class="filter-show-all"]/a

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Click Element      ${all_merchant_list}
    And Wait Until Element Is Visible   ${all_merchant_list}
    Element Should Be Visible   ${more_button}

TC_ITMWM_04021 Verify Show All Categories on Lv.C for Merchant
    [Tags]    TC_ITMWM_04021    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${all_merchant_list}=  Set Variable   //*[@id="filter-list-category"]/div/a[1]
    ${see_more_cat}=       Set Variable   //*[@id="see-more-category"]
    ${more_button}=        Set Variable   //*[@class="filter-show-all"]/a

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Click Element      ${all_merchant_list}
    And Wait Until Element Is Visible   ${all_merchant_list}
    And Click Element       ${more_button}
    Sleep   0.5s
    ${collapse}     Get Element Attribute   ${see_more_cat}@class
    Should Be Equal     ${collapse}     collapse in

TC_ITMWM_04022 Verify Show 15 Categories on Lv.C for Merchant
    [Tags]    TC_ITMWM_04022    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${all_merchant_list}=  Set Variable   //*[@id="filter-list-category"]/div/a[1]
    ${see_more_cat}=       Set Variable   //*[@id="see-more-category"]
    ${more_button}=        Set Variable   //*[@class="filter-show-all"]/a

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Click Element      ${all_merchant_list}
    And Wait Until Element Is Visible   ${all_merchant_list}
    And Click Element       ${more_button}
    And Sleep   0.5s
    And Click Element       ${more_button}
    And Sleep   0.5s
    ${collapse}     Get Element Attribute   ${see_more_cat}@class
    Should Be Equal     ${collapse}     collapse

TC_ITMWM_04023 Verify Show Categoies Tree when select Cat Lv.1
    [Tags]    TC_ITMWM_04023    regression    lyrasprint15
    ${cat_query_string}=   Set Variable    ?page=1&sort_by=price&order=desc
    ${back_all_cate}=    Set Variable      //*[@id='filter-list-category']/div/a[1]
    ${cate_lv_1_current}=    Set Variable      //*[@id='filter-list-category']/div/a[2]
    ${cate_lv_2}=    Set Variable      //*[@id='filter-list-category']/div/a[3]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}

    Wait Until Element Is Visible    ${cate_lv_1_current}
    Click Element    ${cate_lv_1_current}

    Wait Until Element Is Visible    ${back_all_cate}
    Wait Until Element Is Visible    ${cate_lv_1_current}
    Wait Until Element Is Visible    ${cate_lv_2}

    ${back_all_cate_text}=    Get Text    ${back_all_cate}
    ${cate_lv_1_current_text}=    Get Text    ${cate_lv_1_current}
    ${cate_lv_2_text}=    Get Text    ${cate_lv_2}

    Should Be Equal    ${back_all_cate_text}    กลับไปหมวดหมู่ทั้งหมด
    Should Be Equal    ${cate_lv_1_current_text}    โทรศัพท์ & แท็บเล็ต
    Should Be Equal    ${cate_lv_2_text}    โทรศัพท์


TC_ITMWM_04024 Verify Show Categoies Tree when select Cat Lv.2
    [Tags]    TC_ITMWM_04024    regression    lyrasprint15
    ${cat_query_string}=   Set Variable    ?page=1&sort_by=price&order=desc
    ${back_all_cate}=    Set Variable      //*[@id='filter-list-category']/div/a[1]
    ${back_cate_lv_1}=    Set Variable      //*[@id='filter-list-category']/div/a[2]
    ${cate_lv_2}=    Set Variable      //*[@id='filter-list-category']/div/a[3]
    ${cate_lv_3}=    Set Variable      //*[@id='filter-list-category']/div/a[4]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${back_all_cate}
    Wait Until Element Is Visible    ${back_cate_lv_1}
    Wait Until Element Is Visible    ${cate_lv_2}
    Wait Until Element Is Visible    ${cate_lv_3}

    ${back_all_cate_text}=    Get Text    ${back_all_cate}
    ${back_cate_lv_1_text}=    Get Text    ${back_cate_lv_1}
    ${cate_lv_2_text}=    Get Text    ${cate_lv_2}
    ${cate_lv_3_text}=    Get Text    ${cate_lv_3}
    Should Be Equal    ${back_all_cate_text}    กลับไปหมวดหมู่ทั้งหมด
    Should Be Equal    ${back_cate_lv_1_text}    โทรศัพท์ & แท็บเล็ต
    Should Be Equal    ${cate_lv_2_text}    โทรศัพท์
    Should Be Equal    ${cate_lv_3_text}    ไอโฟน

TC_ITMWM_04025 Verify Show Categoies Tree when select Cat Lv.3
    [Tags]    TC_ITMWM_04025    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&sort_by=price&order=desc
    ${next_to_cate_lv_3}=    Set Variable    //*[@id='filter-list-category']/div/a[4]

    ${back_all_cate}=    Set Variable      //*[@id='filter-list-category']/div/a[1]
    ${back_cate_lv_1}=    Set Variable      //*[@id='filter-list-category']/div/a[2]
    ${backcate_lv_2}=    Set Variable      //*[@id='filter-list-category']/div/a[3]
    ${cate_lv_3_current}=    Set Variable      //*[@id='filter-list-category']/div/a[4]
    ${cate_lv_4_1}=    Set Variable      //*[@id='filter-list-category']/div/a[5]
    ${cate_lv_4_2}=    Set Variable      //*[@id='filter-list-category']/div/a[6]
    ${cate_lv_4_3}=    Set Variable      //*[@id='filter-list-category']/div/a[7]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}

    Wait Until Element Is Visible    ${next_to_cate_lv_3}
    Click Element    ${next_to_cate_lv_3}

    Wait Until Element Is Visible    ${back_all_cate}
    Wait Until Element Is Visible    ${back_cate_lv_1}
    Wait Until Element Is Visible    ${backcate_lv_2}
    Wait Until Element Is Visible    ${cate_lv_3_current}
    Wait Until Element Is Visible    ${cate_lv_4_1}
    Wait Until Element Is Visible    ${cate_lv_4_2}
    Wait Until Element Is Visible    ${cate_lv_4_3}

    ${back_all_cate_text}=    Get Text    ${back_all_cate}
    ${back_cate_lv_1_text}=    Get Text    ${back_cate_lv_1}
    ${backcate_lv_2_text}=    Get Text    ${backcate_lv_2}
    ${cate_lv_3_current_text}=    Get Text    ${cate_lv_3_current}
    ${cate_lv_4_1_text}=    Get Text    ${cate_lv_4_1}
    ${cate_lv_4_2_text}=    Get Text    ${cate_lv_4_2}
    ${cate_lv_4_3_text}=    Get Text    ${cate_lv_4_3}

    Should Be Equal    ${back_all_cate_text}    กลับไปหมวดหมู่ทั้งหมด
    Should Be Equal    ${back_cate_lv_1_text}    โทรศัพท์ & แท็บเล็ต
    Should Be Equal    ${backcate_lv_2_text}    โทรศัพท์
    Should Be Equal    ${cate_lv_3_current_text}    ไอโฟน
    Should Be Equal    ${cate_lv_4_1_text}    ไอโฟน 5เอส
    Should Be Equal    ${cate_lv_4_2_text}    ไอโฟน 6เอส
    Should Be Equal    ${cate_lv_4_3_text}    ไอโฟน 6เอส พลัส

TC_ITMWM_04026 Verify Show Categoies Tree when select Cat Lv.4
    [Tags]    TC_ITMWM_04026    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&sort_by=price&order=desc
    ${next_to_cate_lv_3}=    Set Variable    //*[@id='filter-list-category']/div/a[4]
     ${next_to_cate_lv_4}=    Set Variable    //*[@id='filter-list-category']/div/a[5]

    ${back_all_cate}=    Set Variable      //*[@id='filter-list-category']/div/a[1]
    ${back_cate_lv_1}=    Set Variable      //*[@id='filter-list-category']/div/a[2]
    ${backcate_lv_2}=    Set Variable      //*[@id='filter-list-category']/div/a[3]
    ${cate_lv_3}=    Set Variable      //*[@id='filter-list-category']/div/a[4]
    ${cate_lv_4_1_current}=    Set Variable      //*[@id='filter-list-category']/div/a[5]
    ${cate_lv_4_2}=    Set Variable      //*[@id='filter-list-category']/div/a[6]
    ${cate_lv_4_3}=    Set Variable      //*[@id='filter-list-category']/div/a[7]

    When Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}

    Wait Until Element Is Visible    ${next_to_cate_lv_3}
    Click Element    ${next_to_cate_lv_3}

    Wait Until Element Is Visible    ${next_to_cate_lv_4}
    Click Element    ${next_to_cate_lv_4}

    Wait Until Element Is Visible    ${back_all_cate}
    Wait Until Element Is Visible    ${back_cate_lv_1}
    Wait Until Element Is Visible    ${backcate_lv_2}
    Wait Until Element Is Visible    ${cate_lv_3}
    Wait Until Element Is Visible    ${cate_lv_4_1_current}
    Wait Until Element Is Visible    ${cate_lv_4_2}
    Wait Until Element Is Visible    ${cate_lv_4_3}

    ${back_all_cate_text}=    Get Text    ${back_all_cate}
    ${back_cate_lv_1_text}=    Get Text    ${back_cate_lv_1}
    ${backcate_lv_2_text}=    Get Text    ${backcate_lv_2}
    ${cate_lv_3_text}=    Get Text    ${cate_lv_3}
    ${cate_lv_4_1_current_text}=    Get Text    ${cate_lv_4_1_current}
    ${cate_lv_4_2_text}=    Get Text    ${cate_lv_4_2}
    ${cate_lv_4_3_text}=    Get Text    ${cate_lv_4_3}

    Should Be Equal    ${back_all_cate_text}    กลับไปหมวดหมู่ทั้งหมด
    Should Be Equal    ${back_cate_lv_1_text}    โทรศัพท์ & แท็บเล็ต
    Should Be Equal    ${backcate_lv_2_text}    โทรศัพท์
    Should Be Equal    ${cate_lv_3_text}    ไอโฟน
    Should Be Equal    ${cate_lv_4_1_current_text}    ไอโฟน 5เอส
    Should Be Equal    ${cate_lv_4_2_text}    ไอโฟน 6เอส
    Should Be Equal    ${cate_lv_4_3_text}    ไอโฟน 6เอส พลัส

TC_ITMWM_04609 Paginate category merchant working correctly.
    [Tags]     TC_ITMWM_04609    regression    lyrasprint15
    Merchant LevelC - Go To Category levelc merchant    ${merchant_slug}    ${CAT_SLUG_PKEY}
    Merchant LevelC - Verify Paginate    ${cat_pkey_lyra}    24
