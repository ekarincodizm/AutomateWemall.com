*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem

Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_c_page/lv_c.robot
Resource    ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot

Test Teardown   Close All Browsers

*** Variables ***
${cat_query_string}=            ?page=1&orderBy=price&order=desc

${hamburger_menu}               //*[@id="wm-storefront-sticky-header"]/div/div[3]
${total_product}                //*[@id="content"]/div[4]/div[1]/span
${live_chat}                    //*[@id='chatbar']
${default_view}                 //*[@id="content"]/div[4]/div[2]/a[1]/img
${thumbnail_view}               //*[@id='content']/div[4]/div[2]/a[2]/img
${list_view}                    //*[@id='content']/div[4]/div[2]/a[3]/img
${go_to_top}                    //*[@id="backtotop-arrow"]
${sort_by_publish}              //*[@id="content"]/div[5]/div/div/button[1]
${product_no_1}=                //*[@id="pkey-content"]/div/div[1]/div/div[3]/h2
${product_no_1_thumb}           //*[@id="pkey-content"]/div/div[1]/div/div[3]
${product_no_1_list}            //*[@id="pkey-content"]/div/div[1]/div/div/div[2]/div/div[1]
${product_no_1_special_price}=  //*[@id="pkey-content"]/div/div[1]/div/div[4]/div/div/span[1]
${product_no_1_thumb_special}       //*[@id="pkey-content"]/div/div[1]/div/div[4]/div/div/h2

${product_no_1_list_special}    //*[@id="pkey-content"]/div/div[1]/div/div/div[2]/div/div[2]/div/div/h2
${product_no_1_normal_price}=   //*[@id="pkey-content"]/div/div[1]/div/div[4]/div/div/span[2]
${product_no_1_thumb_normal}        //*[@id="pkey-content"]/div/div[1]/div/div[4]/div/div/span
${product_no_1_list_normal}     //*[@id="pkey-content"]/div/div[1]/div/div/div[2]/div/div[2]/div/div/span
${product_no_1_discount}=       //*[@id="pkey-content"]/div/div[1]/div/div[1]/div/span
${product_no_1_freebies}=       //*[@id="${product_pkey_p_01}"]/img




*** Test Cases ***

TC_ITMWM_03978 Verify Breadcrum on Lv.C for Merchant
    [Tags]      TC_ITMWM_03978      regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}

TC_ITMWM_03979 Verify Total product on Lv.C for Merchant
    [Tags]      TC_ITMWM_03979      regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Wait Until Element Is Visible    ${total_product}
    ${total_product_text}=    Get Text    ${total_product}
    Should Be Equal    ${total_product_text}    100

TC_ITMWM_03980 Verify Default view on Lv.C for Merchant
    [Tags]      TC_ITMWM_03980      regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Mobile Level C - Scroll Over Live Chat
    And Sleep    30s
    And Wait Until Element Is Visible  ${default_view}
    And Click Element   ${default_view}
    And Sleep    30s
    And Wait Until Element Is Visible   ${sort_by_publish}
    And Click Element    ${sort_by_publish}
    And Sleep    30s
    And Wait Until Element Is Visible   ${sort_by_publish}
    And Click Element    ${sort_by_publish}
    And Sleep    30s
    And Wait Until Element Is Visible    ${product_no_1}
    And Wait Until Element Is Visible    ${product_no_1_special_price}
    And Wait Until Element Is Visible    ${product_no_1_normal_price}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_special_price_text}=    Get Text    ${product_no_1_special_price}
    ${product_no_1_normal_price_text}=    Get Text    ${product_no_1_normal_price}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_special_price_text}    ฿ 6,000 .-
    Should Be Equal    ${product_no_1_normal_price_text}    ฿ 10,000 .-

TC_ITMWM_03981 Verify Thumbnail view on Lv.C for Merchant
    [Tags]      TC_ITMWM_03981      regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Mobile Level C - Scroll Over Live Chat
    And Sleep    30s
    And Wait Until Element Is Visible  ${thumbnail_view}
    And Click Element   ${thumbnail_view}
    And Sleep    30s
    And Wait Until Element Is Visible   ${sort_by_publish}
    And Click Element    ${sort_by_publish}
    And Sleep    30s
    And Wait Until Element Is Visible   ${sort_by_publish}
    And Click Element    ${sort_by_publish}
    And Sleep    30s
    And Wait Until Element Is Visible    ${product_no_1_thumb}
    And Wait Until Element Is Visible    ${product_no_1_thumb_special}
    And Wait Until Element Is Visible    ${product_no_1_thumb_normal}

    ${product_no_1_text}=    Get Text    ${product_no_1_thumb}
    ${product_no_1_special_price_text}=    Get Text    ${product_no_1_thumb_special}
    ${product_no_1_normal_price_text}=    Get Text    ${product_no_1_thumb_normal}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_special_price_text}    ฿ 6,000 .-
    Should Be Equal    ${product_no_1_normal_price_text}    ฿ 10,000 .-


TC_ITMWM_03982 Verify List view on Lv.C for Merchant
    [Tags]      TC_ITMWM_03982      regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Mobile Level C - Scroll Over Live Chat
    And Sleep    30s
    And Wait Until Element Is Visible   ${list_view}
    And Click Element    ${list_view}
    And Sleep    30s
    And Wait Until Element Is Visible   ${sort_by_publish}
    And Click Element    ${sort_by_publish}
    And Sleep   30s
    And Wait Until Element Is Visible   ${sort_by_publish}
    And Click Element    ${sort_by_publish}
    And Sleep   30s
    And Wait Until Element Is Visible    ${product_no_1_list}
    And Wait Until Element Is Visible    ${product_no_1_list_special}
    And Wait Until Element Is Visible    ${product_no_1_list_normal}

    ${product_no_1_text}=    Get Text    ${product_no_1_list}
    ${product_no_1_special_price_text}=    Get Text    ${product_no_1_list_special}
    ${product_no_1_normal_price_text}=    Get Text    ${product_no_1_list_normal}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_special_price_text}    ฿ 6,000 .-
    Should Be Equal    ${product_no_1_normal_price_text}    ฿ 10,000 .-

TC_ITMWM_03983 Verify Go To Top on Lv.C for Merchant
    [Tags]      TC_ITMWM_03983      regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Mobile Level C - Scroll Down
    And Sleep    30s
    And Element Should Be Visible   ${go_to_top}
    And Click Element   ${go_to_top}

TC_ITMWM_03984 Verify Live Chat on Lv.C for Merchant
    [Tags]      TC_ITMWM_03984      regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Then Sleep    30s
    And Wait Until Element Is Visible    ${live_chat}    60s
    Element Should Be Visible        ${live_chat}

TC_ITMWM_03985 Verify Descending Sort By Latest on Lv.C for Merchant
    [Tags]      TC_ITMWM_03985      Sorting    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=published_at&order=desc
    ${sort_published}=   Set Variable   //*[@id="content"]/div[5]/div/div/button[1]

    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${sort_published}
    ${sort_class}    Get Element Attribute    ${sort_published}@class
    ${sort_order_type}    Get Element Attribute    ${sort_published}@data-order-type
    ${sort_order_by}    Get Element Attribute    ${sort_published}@data-order-by

    Should Contain    ${sort_class}    active
    Should Be Equal    ${sort_order_type}    desc
    Should Be Equal    ${sort_order_by}    published_at

TC_ITMWM_03986 Verify Ascending Sort By Latest on Lv.C for Merchant
    [Tags]      TC_ITMWM_03986      Sorting    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=published_at&order=asc
    ${sort_published}=   Set Variable   //*[@id="content"]/div[5]/div/div/button[1]

    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Wait Until Element Is Visible    ${sort_published}
    ${sort_class}    Get Element Attribute    ${sort_published}@class
    ${sort_order_type}    Get Element Attribute    ${sort_published}@data-order-type
    ${sort_order_by}    Get Element Attribute    ${sort_published}@data-order-by

    Should Contain    ${sort_class}    active
    Should Be Equal    ${sort_order_type}    asc
    Should Be Equal    ${sort_order_by}    published_at

TC_ITMWM_03987 Verify Descending Sort By Price on Lv.C for Merchant
    [Tags]      TC_ITMWM_03987     Sorting    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=desc
    ${sort_price}=   Set Variable   //*[@id="content"]/div[5]/div/div/button[2]

    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    ${sort_class}    Get Element Attribute    ${sort_price}@class
    ${sort_order_type}    Get Element Attribute    ${sort_price}@data-order-type
    ${sort_order_by}    Get Element Attribute    ${sort_price}@data-order-by

    Should Contain    ${sort_class}    active
    Should Be Equal    ${sort_order_type}    desc
    Should Be Equal    ${sort_order_by}    price

TC_ITMWM_03988 Verify Ascending Sort By Price on Lv.C for Merchant
    [Tags]      TC_ITMWM_03988      Sorting    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=price&order=asc
    ${sort_price}=   Set Variable   //*[@id="content"]/div[5]/div/div/button[2]
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    ${sort_class}    Get Element Attribute    ${sort_price}@class
    ${sort_order_type}    Get Element Attribute    ${sort_price}@data-order-type
    ${sort_order_by}    Get Element Attribute    ${sort_price}@data-order-by

    Should Contain    ${sort_class}    active
    Should Be Equal    ${sort_order_type}    asc
    Should Be Equal    ${sort_order_by}    price

TC_ITMWM_03989 Verify Descending Sort By Discount on Lv.C for Merchant
    [Tags]      TC_ITMWM_03989      Sorting    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=discount&order=desc
    ${sort_discount}=   Set Variable   //*[@id="content"]/div[5]/div/div/button[3]
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    ${sort_class}    Get Element Attribute    ${sort_discount}@class
    ${sort_order_type}    Get Element Attribute    ${sort_discount}@data-order-type
    ${sort_order_by}    Get Element Attribute    ${sort_discount}@data-order-by

    Should Contain    ${sort_class}    active
    Should Be Equal    ${sort_order_type}    desc
    Should Be Equal    ${sort_order_by}    discount

TC_ITMWM_03990 Verify Ascending Sort By Discount on Lv.C for Merchant
    [Tags]      TC_ITMWM_03990      Sorting    regression    lyrasprint15
    ${cat_query_string}=   Set Variable   ?page=1&orderBy=discount&order=asc
    ${sort_discount}=   Set Variable   //*[@id="content"]/div[5]/div/div/button[3]
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    ${sort_class}    Get Element Attribute    ${sort_discount}@class
    ${sort_order_type}    Get Element Attribute    ${sort_discount}@data-order-type
    ${sort_order_by}    Get Element Attribute    ${sort_discount}@data-order-by

    Should Contain    ${sort_class}    active
    Should Be Equal    ${sort_order_type}    asc
    Should Be Equal    ${sort_order_by}    discount


TC_ITMWM_03991 Verify Product Price on Lv.C for Merchant
    [Tags]   TC_ITMWM_03991    regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Sleep    30s
    Wait Until Element Is Visible    ${sort_by_publish}
    ${product_no_6}=    Set Variable    //*[@id="pkey-content"]/div/div[6]/div/div[2]/h2
    ${product_no_6_price}=    Set Variable    //*[@id="pkey-content"]/div/div[6]/div/div[3]/div/div/span

    Click Element    ${sort_by_publish}
    Sleep    30s
    Click Element    ${sort_by_publish}
    Sleep    30s
    Wait Until Element Is Visible    ${product_no_6}
    Wait Until Element Is Visible    ${product_no_6_price}

    ${product_no_6_text}=    Get Text    ${product_no_6}
    ${product_no_6_price_text}=    Get Text    ${product_no_6_price}
    Should Be Equal    ${product_no_6_text}    TestLyra0006
    Should Be Equal    ${product_no_6_price_text}    ฿ 1,000 .-

TC_ITMWM_03992 Verify Product Special Price on Lv.C for Merchant
    [Tags]   TC_ITMWM_03992    regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Sleep    30s
    Wait Until Element Is Visible    ${sort_by_publish}

    Click Element    ${sort_by_publish}
    Sleep    30s
    Click Element    ${sort_by_publish}
    Sleep    30s
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_special_price}
    Wait Until Element Is Visible    ${product_no_1_normal_price}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_special_price_text}=    Get Text    ${product_no_1_special_price}
    ${product_no_1_normal_price_text}=    Get Text    ${product_no_1_normal_price}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_special_price_text}    ฿ 6,000 .-
    Should Be Equal    ${product_no_1_normal_price_text}    ฿ 10,000 .-

TC_ITMWM_03993 Verify Product % Discount on Lv.C for Merchant
    [Tags]   TC_ITMWM_03993    regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Sleep    30s
    Wait Until Element Is Visible    ${sort_by_publish}

    Click Element    ${sort_by_publish}
    Sleep    30s
    Click Element    ${sort_by_publish}
    Sleep    30s
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_discount}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_discount_text}=    Get Text    ${product_no_1_discount}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_discount_text}    40

TC_ITMWM_03994 Verify Out of Stock on Lv.C for Merchant
    [Tags]   TC_ITMWM_03994    regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Sleep    30s
    Wait Until Element Is Visible    ${sort_by_publish}
    ${product_no_4}=    Set Variable    //*[@id="pkey-content"]/div/div[5]/div/div[3]/h2
    ${product_no_4_out_of_stock}=    Set Variable    //*[@id="${product_pkey_outofstock}"]/div[1]

    Click Element    ${sort_by_publish}
    Sleep    30s
    Click Element    ${sort_by_publish}
    Sleep    30s
    Wait Until Element Is Visible    ${product_no_4}
    Wait Until Element Is Visible    ${product_no_4_out_of_stock}

    ${product_no_4_text}=    Get Text    ${product_no_4}
    ${product_no_4_out_of_stock_count}=    Get Matching Xpath Count    ${product_no_4_out_of_stock}
    Should Be Equal    ${product_no_4_text}    TestLyra0004
    Should Be Equal    ${product_no_4_out_of_stock_count}    1

TC_ITMWM_03995 Verify Freebie Image on Lv.C for Merchant
    [Tags]   TC_ITMWM_03995    regression    lyrasprint15
    When Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey      ${merchant_slug}    ${cat_slug_pkey}    th      ${cat_query_string}
    Sleep    30s
    Wait Until Element Is Visible    ${sort_by_publish}

    Click Element    ${sort_by_publish}
    Sleep    30s
    Click Element    ${sort_by_publish}
    Sleep    30s
    Wait Until Element Is Visible    ${product_no_1}
    Wait Until Element Is Visible    ${product_no_1_freebies}

    ${product_no_1_text}=    Get Text    ${product_no_1}
    ${product_no_1_freebies_count}=    Get Matching Xpath Count    ${product_no_1_freebies}
    Should Be Equal    ${product_no_1_text}    TestLyra0001
    Should Be Equal    ${product_no_1_freebies_count}    1
