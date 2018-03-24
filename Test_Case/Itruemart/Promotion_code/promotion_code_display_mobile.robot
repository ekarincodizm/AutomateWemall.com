*** Settings ***
Force Tags    WLS_Promotion
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_c_page/lv_c.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/merchant_level_c/paginate_and_sorting_keyword.robot
Test Teardown     Close All Browsers

*** Variables ***
${lyras16_product_01_url}             ${slug_sp16_01}-${pkey_sp16_01}
${lyras16_product_02_url}             ${slug_sp16_02}-${pkey_sp16_02}
${lyras16_product_03_url}             ${slug_sp16_03}-${pkey_sp16_03}
${lyras16_product_04_url}             ${slug_sp16_04}-${pkey_sp16_04}
${lyras16_product_05_url}             ${slug_sp16_05}-${pkey_sp16_05}
${lyras16_product_06_url}             ${slug_sp16_06}-${pkey_sp16_06}
${lyras16_product_07_url}             ${slug_sp16_07}-${pkey_sp16_07}
${lyras16_product_08_url}             ${slug_sp16_08}-${pkey_sp16_08}
${lyras16_product_09_url}             ${slug_sp16_09}-${pkey_sp16_09}
${lyras16_product_10_url}             ${slug_sp16_10}-${pkey_sp16_10}
${lyras16_product_12_url}             ${slug_sp16_12}-${pkey_sp16_12}

*** Test Cases ***
TC_ITMWM_05477 don't show promotion code on Thumbnail(product) on Wemall Category Page(Mobile)
    [Tags]    TC_ITMWM_05477    regression    lyras16    WLS_High
    #${product_no_1}=          Set Variable              //*[@id='wrapper_content']/div/div[6]/div[3]/div[3]/div/a/span[2]/span[1]
    ${title_text_path}=            Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[1]/span
    ${code_test_path}=             Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]
    ${code_value_path}=            Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[2]
    ${discount_text_path}=         Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[1]
    ${discount_value_path}=        Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[2]
    ${promocode_text_path}=        Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]

    ${show_1_thumpmail_path}=      Set Variable              //*[@id='content']/div[3]/div[2]/a[2]/img
    ${show_list_path}=             Set Variable              //*[@id='content']/div[3]/div[2]/a[3]/img

    Open ITM Mobile level C Web With URI    /category/${category_url}.html?page=1&orderBy=discount&sort_by=discount&order=desc
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

    # Show 1 Thumpnail
    Click Element    ${show_1_thumpmail_path}
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

    Click Element    ${show_list_path}
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

TC_ITMWM_05478 don't show promotion code on Thumbnail(product) on Wemall Brand Page(Mobile)
    [Tags]    TC_ITMWM_05478    regression    lyras16    WLS_High
    ${title_text_path}=            Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[1]/span
    ${code_test_path}=             Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]
    ${code_value_path}=            Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[2]
    ${discount_text_path}=         Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[1]
    ${discount_value_path}=        Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[2]
    ${promocode_text_path}=        Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]

    ${sorting_discount_path}=      Set Variable             //*[@id='content']/div[4]/div/div/button[3]

    ${show_1_thumpmail_path}=      Set Variable              //*[@id='content']/div[3]/div[2]/a[2]/img
    ${show_list_path}=             Set Variable              //*[@id='content']/div[3]/div[2]/a[3]/img

    Open ITM Mobile level C Web With URI    /brand/${brand_url}.html?no-cache=1
    Sleep    20s

    Wait Until Element Is Visible    ${sorting_discount_path}
    # Sorting Discount
    Click Element    ${sorting_discount_path}
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

    # Show 1 Thumpnail
    Click Element    ${show_1_thumpmail_path}
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

    Click Element    ${show_list_path}
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

TC_ITMWM_05479 don't show promotion code on Thumbnail(product) on Wemall Search Page(Mobile)
    [Tags]    TC_ITMWM_05479    regression    lyras16    WLS_High
    ${title_text_path}=       Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[1]/span
    ${code_test_path}=        Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]
    ${code_value_path}=       Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[2]
    ${discount_text_path}=    Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[1]
    ${discount_value_path}=   Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[2]
    ${promocode_text_path}=   Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]

    ${show_display_path}=      Set Variable              //*[@id='content']/div/main/div[2]/div/div[2]/div[3]/div/div/div

    Open ITM Mobile level C Web With URI    ${search_url}?q=LyraFixS16PM
    Sleep    20s

    # Show 4 Thumpnail
    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

    # Show 1 Thumpnail
    Click Element    ${show_display_path}
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

    Click Element    ${show_display_path}
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

TC_ITMWM_05481 don't show promotion code on Thumbnail(product) on Wemall Every Day Wow Page(Mobile)
    [Tags]    TC_ITMWM_05481    regression    lyras16    WLS_High
    #${product_no_1}=          Set Variable              //*[@id='page-1']/div/div[2]/div/div/a/div/div[3]/h5
    ${title_text_path}=       Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[1]/span
    ${code_test_path}=        Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]
    ${code_value_path}=       Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[2]
    ${discount_text_path}=    Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[1]
    ${discount_value_path}=   Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[2]
    ${promocode_text_path}=   Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]

    Open ITM Mobile level C Web With URI    ${wow_url}?no-cache=1
    Sleep    20s

    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

TC_ITMWM_05482 show 1 promotion code on Thumbnail(product) on Wemall Category Page(Mobile)
    [Tags]    TC_ITMWM_05482    regression    lyras16    WLS_High

    ${title_text_path}=            Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[1]/span
    ${code_test_path}=             Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[1]
    ${code_value_path}=            Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[2]
    ${discount_text_path}=         Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[1]
    ${discount_value_path}=        Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[2]

    ${sorting_discount_path}=      Set Variable             //*[@id='content']/div[4]/div/div/button[3]

    ${show_1_thumpmail_path}=      Set Variable              //*[@id='content']/div[3]/div[2]/a[2]/img
    ${show_list_path}=             Set Variable              //*[@id='content']/div[3]/div[2]/a[3]/img

    Open ITM Mobile level C Web With URI    /category/${category_url}.html?page=1&orderBy=discount&sort_by=discount&order=desc
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

    # Show 1 Thumpnail
    Click Element    ${show_1_thumpmail_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

    Click Element    ${show_list_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

TC_ITMWM_05483 show 1 promotion code on Thumbnail(product) on Brand Page(Mobile)
    [Tags]    TC_ITMWM_05483    regression    lyras16    WLS_High
    ${title_text_path}=            Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[1]/span
    ${code_test_path}=             Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[1]
    ${code_value_path}=            Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[2]
    ${discount_text_path}=         Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[1]
    ${discount_value_path}=        Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[2]
    ${promocode_text_path}=        Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[1]

    ${sorting_discount_path}=      Set Variable             //*[@id='content']/div[4]/div/div/button[3]

    ${show_1_thumpmail_path}=      Set Variable              //*[@id='content']/div[3]/div[2]/a[2]/img
    ${show_list_path}=             Set Variable              //*[@id='content']/div[3]/div[2]/a[3]/img

    Open ITM Mobile level C Web With URI    /brand/${brand_url}.html?no-cache=1
    Sleep    20s


    Wait Until Element Is Visible    ${sorting_discount_path}
    # Sorting Discount
    Click Element    ${sorting_discount_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

    # Show 1 Thumpnail
    Click Element    ${show_1_thumpmail_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

    Click Element    ${show_list_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

TC_ITMWM_05484 show 1 promotion code on Thumbnail(product) on Search Page(Mobile)
    [Tags]    TC_ITMWM_05484    regression    lyras16    WLS_High
    ${title_text_path}=       Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[1]/span
    ${code_test_path}=        Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[1]
    ${code_value_path}=       Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[2]
    ${discount_text_path}=    Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[1]
    ${discount_value_path}=   Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[2]

    ${show_display_path}=      Set Variable              //*[@id='content']/div/main/div[2]/div/div[2]/div[3]/div/div/div

    Open ITM Mobile level C Web With URI    ${search_url}?q=LyraFixS16PM
    Sleep    20s
    # Show 4 Thumpnail
    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

    # Show 1 Thumpnail
    Click Element    ${show_display_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

    Click Element    ${show_display_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

TC_ITMWM_05486 show 1 promotion code on Thumbnail(product) on Every Day Wow Page(Mobile)
    [Tags]    TC_ITMWM_05486    regression    lyras16    WLS_High
    ${title_text_path}=       Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[1]/span
    ${code_test_path}=        Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[1]
    ${code_value_path}=       Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[2]
    ${discount_text_path}=    Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[1]
    ${discount_value_path}=   Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[2]

    Open ITM Mobile level C Web With URI    ${wow_url}?no-cache=1
    Sleep    20s

    #Wait Until Element Is Visible    ${product_no_2}
    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    #${product_no_2_name}=    Get Text    ${product_no_2}
    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    #Should Be Equal    ${product_no_2_name}               LyraFixS16PM10002
    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

TC_ITMWM_05487 show more 1 promotion code on Thumbnail(product) on Wemall Category Page(Mobile)
    [Tags]    TC_ITMWM_05487    regression    lyras16    WLS_High
    ${title_text_1_path}=        Set Variable              jquery=#discount-${pkey_sp16_10} .discount-label:eq(0)
    ${title_text_2_path}=        Set Variable              jquery=#discount-${pkey_sp16_10} .discount-increase

    ${show_1_thumpmail_path}=      Set Variable              //*[@id='content']/div[3]/div[2]/a[2]/img
    ${show_list_path}=             Set Variable              //*[@id='content']/div[3]/div[2]/a[3]/img

    Open ITM Mobile level C Web With URI    /category/${category_url}.html?page=1&orderBy=discount&sort_by=discount&order=desc
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

    # Show 1 Thumpnail
    Click Element    ${show_1_thumpmail_path}
    Sleep    20s
    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

    Click Element    ${show_list_path}
    Sleep    20s
    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

TC_ITMWM_05488 show more 1 promotion code on Thumbnail(product) on Brand Page(Mobile)
    [Tags]    TC_ITMWM_05488    regression    lyras16    WLS_High
    ${title_text_1_path}=        Set Variable              jquery=#discount-${pkey_sp16_10} .discount-label:eq(0)
    ${title_text_2_path}=        Set Variable              jquery=#discount-${pkey_sp16_10} .discount-increase

    ${sorting_discount_path}=      Set Variable             //*[@id='content']/div[4]/div/div/button[3]

    ${show_1_thumpmail_path}=      Set Variable              //*[@id='content']/div[3]/div[2]/a[2]/img
    ${show_list_path}=             Set Variable              //*[@id='content']/div[3]/div[2]/a[3]/img
    Open ITM Mobile level C Web With URI    /brand/${brand_url}.html?no-cache=1
    Sleep    20s


    Wait Until Element Is Visible    ${sorting_discount_path}
    # Sorting Discount
    Click Element    ${sorting_discount_path}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

    # Show 1 Thumpnail
    Click Element    ${show_1_thumpmail_path}
    Sleep    20s
    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

    Click Element    ${show_list_path}
    Sleep    20s
    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

TC_ITMWM_05489 show more 1 promotion code on Thumbnail(product) on Search Page(Mobile)
    [Tags]    TC_ITMWM_05489    regression    lyras16    WLS_High
    ${title_text_1_path}=        Set Variable              jquery=#discount-${pkey_sp16_03} .mi-discount-label:eq(0)
    ${title_text_2_path}=        Set Variable              jquery=#discount-${pkey_sp16_03} .mi-discount-increase:eq(0)

    ${show_display_path}=      Set Variable              //*[@id='content']/div/main/div[2]/div/div[2]/div[3]/div/div/div

    Open ITM Mobile level C Web With URI    ${search_url}?q=LyraFixS16PM
    Sleep    20s
    # Show 4 Thumpnail
    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

    # Show 1 Thumpnail
    Click Element    ${show_display_path}
    Sleep    20s
    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

    Click Element    ${show_display_path}
    Sleep    20s
    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม

TC_ITMWM_05491 show more 1 promotion code on Thumbnail(product) on Every Day Wow Page(Mobile)
    [Tags]    TC_ITMWM_05491    regression    lyras16    WLS_High
    ${title_text_1_path}=        Set Variable              jquery=#discount-${pkey_sp16_03} .discount-label:eq(0)
    ${title_text_2_path}=        Set Variable              jquery=#discount-${pkey_sp16_03} .discount-increase

    Open ITM Mobile level C Web With URI    ${wow_url}?no-cache=1
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_1_path}
    Wait Until Element Is Visible    ${title_text_2_path}

    #${product_no_2_name}=    Get Text    ${product_no_2}
    ${title_text_1}=            Get Text    ${title_text_1_path}
    ${title_text_2}=            Get Text    ${title_text_2_path}

    #Should Be Equal    ${product_no_2_name}               LyraFixS16PM10002
    Should Be Equal    ${title_text_1}                      ใส่โค้ด
    Should Be Equal    ${title_text_2}                      ลดเพิ่ม


TC_ITMWM_05492 don't show promotion code on Product Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05492    regression    lyras16    WLS_High
    ${title_text_path}=       Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[1]/span
    ${code_test_path}=        Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[1]
    ${code_value_path}=       Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[1]/div[2]/span[2]
    ${discount_text_path}=    Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[1]
    ${discount_value_path}=   Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[2]
    ${promocode_text_path}=   Set Variable              //*[@id='discount-${pkey_sp16_01}']/div[2]/span[3]
    ${text_record}=           Set Variable              //*[@id='itm-product-information']/div[1]/div[3]/div[5]/div
    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_01_url}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}
    Element Should Not Be Visible        ${text_record}
    Element Should Not Be Visible        ${title_text_path}
    Element Should Not Be Visible        ${code_test_path}
    Element Should Not Be Visible        ${code_value_path}
    Element Should Not Be Visible        ${discount_text_path}
    Element Should Not Be Visible        ${discount_value_path}
    Element Should Not Be Visible        ${promocode_text_path}

TC_ITMWM_05493 show 1 promotion code on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05493    regression    lyras16    WLS_High
    ${title_text_path}=       Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[1]
    ${code_test_path}=        Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[1]
    ${code_value_path}=       Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[1]/div[2]/span[2]
    ${discount_text_path}=    Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[1]
    ${discount_value_path}=   Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[2]
    ${promocode_text_path}=   Set Variable              //*[@id='discount-${pkey_sp16_02}']/div[2]/span[3]
    ${v1_path}=               Set Variable              //a/div[@data-style-option-pkey="${pkey_sp16_p02_v1}"]
    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_02_url}
    Sleep    20s

    Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}
    Wait Until Element Is Visible    ${text_option_type_promotion}
    Wait Until Element Is Visible    ${v1_path}

    ${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}
    ${text_option_type_text}=      Get Text    ${text_option_type_promotion}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-
    Should Be Equal    ${text_option_type_text}           *โค้ดส่วนลดขึ้นอยู่กับ พื้นผิว ของสินค้า

    Click Element    ${v1_path}
    Sleep    5s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${title_text}                      เทสไลร่า2
    Should Be Equal    ${code_test}                       ใส่
    Should Be Equal    ${code_value}                      LARA2F
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

TC_ITMWM_05601 show 1 promotion code on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05601    regression    lyras16    WLS_High
    #${title_text_path}=       Set Variable              //*[@id="discount-${pkey_sp16_12}"]/div[1]/div[1]/span
    ${code_test_path}=        Set Variable              //*[@id="discount-${pkey_sp16_12}"]/div[1]/div[2]/span[1]
    ${code_value_path}=       Set Variable              //*[@id="discount-${pkey_sp16_12}"]/div[1]/div[2]/span[2]
    ${discount_text_path}=    Set Variable              //*[@id='discount-${pkey_sp16_12}']/div[2]/span[1]
    ${discount_value_path}=   Set Variable              //*[@id='discount-${pkey_sp16_12}']/div[2]/span[2]
    ${promocode_text_path}=   Set Variable              //*[@id='discount-${pkey_sp16_12}']/div[2]/span[3]
    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_12_url}
    Sleep    5s

    #Wait Until Element Is Visible    ${title_text_path}
    Wait Until Element Is Visible    ${code_test_path}
    Wait Until Element Is Visible    ${code_value_path}
    Wait Until Element Is Visible    ${discount_text_path}
    Wait Until Element Is Visible    ${discount_value_path}

    #${title_text}=           Get Text    ${title_text_path}
    ${code_test}=            Get Text    ${code_test_path}
    ${code_value}=           Get Text    ${code_value_path}
    ${discount_text}=        Get Text    ${discount_text_path}
    ${discount_value}=       Get Text    ${discount_value_path}

    Element Should Not Be Visible        ${text_option_type_promotion}

    #Should Be Equal    ${title_text}                      เทสไลร่า03
    Should Be Equal    ${code_test}                       ใส่โค้ด
    Should Be Equal    ${code_value}                      LYR02RY4
    Should Be Equal    ${discount_text}                   20 บาท
    Should Be Equal    ${discount_value}                  20.-

TC_ITMWM_05494 show 3 promotion code(MNP Sort By sortable) on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05494    regression    lyras16    WLS_High
    ${v1_title_text_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_04}']/div[1]/div[1]/span[1]
    ${v1_code_test_path}=        Set Variable           //div[1][@id='discount-${pkey_sp16_04}']/div[1]/div[2]/span[1]
    ${v1_code_value_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_04}']/div[1]/div[2]/span[2]
    ${v1_discount_text_path}=    Set Variable           //div[1][@id='discount-${pkey_sp16_04}']/div[2]/span[1]
    ${v1_discount_value_path}=   Set Variable           //div[1][@id='discount-${pkey_sp16_04}']/div[2]/span[2]
    ${v1_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v1_op1}"]
    ${v1_op2_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v1_op2}"]

    ${v2_title_text_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_04}']/div[1]/div[1]/span[1]
    ${v2_code_test_path}=        Set Variable           //div[2][@id='discount-${pkey_sp16_04}']/div[1]/div[2]/span[1]
    ${v2_code_value_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_04}']/div[1]/div[2]/span[2]
    ${v2_discount_text_path}=    Set Variable           //div[2][@id='discount-${pkey_sp16_04}']/div[2]/span[1]
    ${v2_discount_value_path}=   Set Variable           //div[2][@id='discount-${pkey_sp16_04}']/div[2]/span[2]
    ${v2_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v2_op1}"]
    ${v2_op2_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v2_op2}"]

    ${v3_title_text_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_04}']/div[1]/div[1]/span[1]
    ${v3_code_test_path}=        Set Variable           //div[3][@id='discount-${pkey_sp16_04}']/div[1]/div[2]/span[1]
    ${v3_code_value_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_04}']/div[1]/div[2]/span[2]
    ${v3_discount_text_path}=    Set Variable           //div[3][@id='discount-${pkey_sp16_04}']/div[2]/span[1]
    ${v3_discount_value_path}=   Set Variable           //div[3][@id='discount-${pkey_sp16_04}']/div[2]/span[2]
    ${v3_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v3_op1}"]
    ${v3_op2_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v3_op2}"]


    ${v4_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v4_op1}"]
    ${v4_op2_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p04_v4_op2}"]
    ${v4_code_path}=             Set Variable           //*[@id='itm-product-information']/div[1]/div[3]/div[7]/div[2]

    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache   ${lyras16_product_04_url}
    Sleep    20s

    Wait Until Element Is Visible    ${v1_title_text_path}
    Wait Until Element Is Visible    ${v1_code_test_path}
    Wait Until Element Is Visible    ${v1_code_value_path}
    Wait Until Element Is Visible    ${v1_discount_text_path}
    Wait Until Element Is Visible    ${v1_discount_value_path}
    Wait Until Element Is Visible    ${v1_op1_path}
    Wait Until Element Is Visible    ${v1_op2_path}

    Wait Until Element Is Visible    ${v2_title_text_path}
    Wait Until Element Is Visible    ${v2_code_test_path}
    Wait Until Element Is Visible    ${v2_code_value_path}
    Wait Until Element Is Visible    ${v2_discount_text_path}
    Wait Until Element Is Visible    ${v2_discount_value_path}
    Wait Until Element Is Visible    ${v2_op1_path}
    Wait Until Element Is Visible    ${v2_op2_path}

    Wait Until Element Is Visible    ${v3_title_text_path}
    Wait Until Element Is Visible    ${v3_code_test_path}
    Wait Until Element Is Visible    ${v3_code_value_path}
    Wait Until Element Is Visible    ${v3_discount_text_path}
    Wait Until Element Is Visible    ${v3_discount_value_path}
    Wait Until Element Is Visible    ${v3_op1_path}
    Wait Until Element Is Visible    ${v3_op2_path}

    Wait Until Element Is Visible    ${v4_op1_path}
    Wait Until Element Is Visible    ${v4_op2_path}

    Wait Until Element Is Visible    ${text_option_type_promotion}

    ${v1_title_text}=             Get Text     ${v1_title_text_path}
    ${v1_code_test}=              Get Text     ${v1_code_test_path}
    ${v1_code_value}=             Get Text     ${v1_code_value_path}
    ${v1_discount_text}=          Get Text     ${v1_discount_text_path}
    ${v1_discount_value}=         Get Text     ${v1_discount_value_path}

    ${v2_title_text}=             Get Text     ${v2_title_text_path}
    ${v2_code_test}=              Get Text     ${v2_code_test_path}
    ${v2_code_value}=             Get Text     ${v2_code_value_path}
    ${v2_discount_text}=          Get Text     ${v2_discount_text_path}
    ${v2_discount_value}=         Get Text     ${v2_discount_value_path}

    ${v3_title_text}=             Get Text     ${v3_title_text_path}
    ${v3_code_test}=              Get Text     ${v3_code_test_path}
    ${v3_code_value}=             Get Text     ${v3_code_value_path}
    ${v3_discount_text}=          Get Text     ${v3_discount_text_path}
    ${v3_discount_value}=         Get Text     ${v3_discount_value_path}

    ${text_option_type}=          Get Text     ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า17
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYR172J3
    Should Be Equal    ${v1_discount_text}                   170 บาท
    Should Be Equal    ${v1_discount_value}                  170.-

    Should Be Equal    ${v2_title_text}                      เทสไลร่า16
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR165KB
    Should Be Equal    ${v2_discount_text}                   160 บาท
    Should Be Equal    ${v2_discount_value}                  160.-

    Should Be Equal    ${v3_title_text}                      เทสไลร่า15
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYR159
    Should Be Equal    ${v3_discount_text}                   150 บาท
    Should Be Equal    ${v3_discount_value}                  150.-

    Should Be Equal    ${text_option_type}                   *โค้ดส่วนลดขึ้นอยู่กับ สี และขนาด ของสินค้า

    Element Should Not Be Visible        ${v4_code_path}

    #click  v1

    Click Element    ${v1_op1_path}
    Sleep    10s
    Click Element    ${v1_op2_path}
    Sleep    10s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า17
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYR172J3
    Should Be Equal    ${v1_discount_text}                   170 บาท
    Should Be Equal    ${v1_discount_value}                  170.-

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Close All Browsers

    #click  v2
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_04_url}
    Sleep    20s
    Click Element    ${v2_op1_path}
    Sleep    10s
    Click Element    ${v2_op2_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v2_title_text}                      เทสไลร่า16
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR165KB
    Should Be Equal    ${v2_discount_text}                   160 บาท
    Should Be Equal    ${v2_discount_value}                  160.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Close All Browsers

    #click  v3
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_04_url}
    Sleep    20s
    Click Element    ${v3_op1_path}
    Sleep    10s
    Click Element    ${v3_op2_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v3_title_text}                      เทสไลร่า15
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYR159
    Should Be Equal    ${v3_discount_text}                   150 บาท
    Should Be Equal    ${v3_discount_value}                  150.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Close All Browsers

    #click  v4
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_04_url}
    Sleep    20s
    Click Element    ${v4_op1_path}
    Sleep    10s
    Click Element    ${v4_op2_path}
    Sleep    20s

    ${v4_code_path_text}=         Get Text     ${v4_code_path}

    Should Be Equal    ${v4_code_path_text}               ไม่มีโค้ดส่วนลดสำหรับสีและขนาดที่คุณเลือก

    Element Should Not Be Visible        ${text_option_type_promotion}

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

TC_ITMWM_05495 show 3 promotion code(General Sort By sortable) on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05495    regression    lyras16    WLS_High
    ${v1_title_text_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_05}']/div[1]/div[1]/span
    ${v1_code_test_path}=        Set Variable           //div[1][@id='discount-${pkey_sp16_05}']/div[1]/div[2]/span[1]
    ${v1_code_value_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_05}']/div[1]/div[2]/span[2]
    ${v1_discount_text_path}=    Set Variable           //div[1][@id='discount-${pkey_sp16_05}']/div[2]/span[1]
    ${v1_discount_value_path}=   Set Variable           //div[1][@id='discount-${pkey_sp16_05}']/div[2]/span[2]
    ${v1_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p05_v1_op1}"]

    ${v2_title_text_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_05}']/div[1]/div[1]/span
    ${v2_code_test_path}=        Set Variable           //div[2][@id='discount-${pkey_sp16_05}']/div[1]/div[2]/span[1]
    ${v2_code_value_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_05}']/div[1]/div[2]/span[2]
    ${v2_discount_text_path}=    Set Variable           //div[2][@id='discount-${pkey_sp16_05}']/div[2]/span[1]
    ${v2_discount_value_path}=   Set Variable           //div[2][@id='discount-${pkey_sp16_05}']/div[2]/span[2]
    ${v2_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p05_v2_op1}"]

    ${v3_title_text_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_05}']/div[1]/div[1]/span
    ${v3_code_test_path}=        Set Variable           //div[3][@id='discount-${pkey_sp16_05}']/div[1]/div[2]/span[1]
    ${v3_code_value_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_05}']/div[1]/div[2]/span[2]
    ${v3_discount_text_path}=    Set Variable           //div[3][@id='discount-${pkey_sp16_05}']/div[2]/span[1]
    ${v3_discount_value_path}=   Set Variable           //div[3][@id='discount-${pkey_sp16_05}']/div[2]/span[2]
    ${v3_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p05_v3_op1}"]

    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_05_url}
    Sleep    20s

    Wait Until Element Is Visible    ${v1_title_text_path}
    Wait Until Element Is Visible    ${v1_code_test_path}
    Wait Until Element Is Visible    ${v1_code_value_path}
    Wait Until Element Is Visible    ${v1_discount_text_path}
    Wait Until Element Is Visible    ${v1_discount_value_path}
    Wait Until Element Is Visible    ${v1_op1_path}

    Wait Until Element Is Visible    ${v2_title_text_path}
    Wait Until Element Is Visible    ${v2_code_test_path}
    Wait Until Element Is Visible    ${v2_code_value_path}
    Wait Until Element Is Visible    ${v2_discount_text_path}
    Wait Until Element Is Visible    ${v2_discount_value_path}
    Wait Until Element Is Visible    ${v2_op1_path}

    Wait Until Element Is Visible    ${v3_title_text_path}
    Wait Until Element Is Visible    ${v3_code_test_path}
    Wait Until Element Is Visible    ${v3_code_value_path}
    Wait Until Element Is Visible    ${v3_discount_text_path}
    Wait Until Element Is Visible    ${v3_discount_value_path}
    Wait Until Element Is Visible    ${v3_op1_path}

    Wait Until Element Is Visible    ${text_option_type_promotion}

    ${v1_title_text}=             Get Text     ${v1_title_text_path}
    ${v1_code_test}=              Get Text     ${v1_code_test_path}
    ${v1_code_value}=             Get Text     ${v1_code_value_path}
    ${v1_discount_text}=          Get Text     ${v1_discount_text_path}
    ${v1_discount_value}=         Get Text     ${v1_discount_value_path}

    ${v2_title_text}=             Get Text     ${v2_title_text_path}
    ${v2_code_test}=              Get Text     ${v2_code_test_path}
    ${v2_code_value}=             Get Text     ${v2_code_value_path}
    ${v2_discount_text}=          Get Text     ${v2_discount_text_path}
    ${v2_discount_value}=         Get Text     ${v2_discount_value_path}

    ${v3_title_text}=             Get Text     ${v3_title_text_path}
    ${v3_code_test}=              Get Text     ${v3_code_test_path}
    ${v3_code_value}=             Get Text     ${v3_code_value_path}
    ${v3_discount_text}=          Get Text     ${v3_discount_text_path}
    ${v3_discount_value}=         Get Text     ${v3_discount_value_path}

    ${text_option_type}=          Get Text     ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า8
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA87M7
    Should Be Equal    ${v1_discount_text}                   80 บาท
    Should Be Equal    ${v1_discount_value}                  80.-

    Should Be Equal    ${v2_title_text}                      เทสไลร่า7
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR93U
    Should Be Equal    ${v2_discount_text}                   70 บาท
    Should Be Equal    ${v2_discount_value}                  70.-

    Should Be Equal    ${v3_title_text}                      เทสไลร่า6
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA6TRB
    Should Be Equal    ${v3_discount_text}                   60 บาท
    Should Be Equal    ${v3_discount_value}                  60.-

    Should Be Equal    ${text_option_type}                   *โค้ดส่วนลดขึ้นอยู่กับ สี ของสินค้า

    #click  v1

    Click Element    ${v1_op1_path}
    Sleep    10s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า8
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA87M7
    Should Be Equal    ${v1_discount_text}                   80 บาท
    Should Be Equal    ${v1_discount_value}                  80.-

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Close All Browsers

    #click  v2
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_05_url}
    Sleep    20s
    Click Element    ${v2_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v2_title_text}                      เทสไลร่า7
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR93U
    Should Be Equal    ${v2_discount_text}                   70 บาท
    Should Be Equal    ${v2_discount_value}                  70.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Close All Browsers

    #click  v3
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_05_url}
    Sleep    20s
    Click Element    ${v3_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v3_title_text}                      เทสไลร่า6
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA6TRB
    Should Be Equal    ${v3_discount_text}                   60 บาท
    Should Be Equal    ${v3_discount_value}                  60.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

TC_ITMWM_05496 show 3 promotion code(Bundle Sort By sortable) on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05496    regression    lyras16    WLS_High
    ${v1_title_text_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_06}']/div[1]/div[1]/span
    ${v1_code_test_path}=        Set Variable           //div[1][@id='discount-${pkey_sp16_06}']/div[1]/div[2]/span[1]
    ${v1_code_value_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_06}']/div[1]/div[2]/span[2]
    ${v1_discount_text_path}=    Set Variable           //div[1][@id='discount-${pkey_sp16_06}']/div[2]/span[1]
    ${v1_discount_value_path}=   Set Variable           //div[1][@id='discount-${pkey_sp16_06}']/div[2]/span[2]
    ${v1_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p06_v1_op1}"]

    ${v2_title_text_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_06}']/div[1]/div[1]/span
    ${v2_code_test_path}=        Set Variable           //div[2][@id='discount-${pkey_sp16_06}']/div[1]/div[2]/span[1]
    ${v2_code_value_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_06}']/div[1]/div[2]/span[2]
    ${v2_discount_text_path}=    Set Variable           //div[2][@id='discount-${pkey_sp16_06}']/div[2]/span[1]
    ${v2_discount_value_path}=   Set Variable           //div[2][@id='discount-${pkey_sp16_06}']/div[2]/span[2]
    ${v2_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p06_v2_op1}"]

    ${v3_title_text_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_06}']/div[1]/div[1]/span
    ${v3_code_test_path}=        Set Variable           //div[3][@id='discount-${pkey_sp16_06}']/div[1]/div[2]/span[1]
    ${v3_code_value_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_06}']/div[1]/div[2]/span[2]
    ${v3_discount_text_path}=    Set Variable           //div[3][@id='discount-${pkey_sp16_06}']/div[2]/span[1]
    ${v3_discount_value_path}=   Set Variable           //div[3][@id='discount-${pkey_sp16_06}']/div[2]/span[2]
    ${v3_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p06_v3_op1}"]

    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_06_url}
    Sleep    20s

    Wait Until Element Is Visible    ${v1_title_text_path}
    Wait Until Element Is Visible    ${v1_code_test_path}
    Wait Until Element Is Visible    ${v1_code_value_path}
    Wait Until Element Is Visible    ${v1_discount_text_path}
    Wait Until Element Is Visible    ${v1_discount_value_path}
    Wait Until Element Is Visible    ${v1_op1_path}

    Wait Until Element Is Visible    ${v2_title_text_path}
    Wait Until Element Is Visible    ${v2_code_test_path}
    Wait Until Element Is Visible    ${v2_code_value_path}
    Wait Until Element Is Visible    ${v2_discount_text_path}
    Wait Until Element Is Visible    ${v2_discount_value_path}
    Wait Until Element Is Visible    ${v2_op1_path}

    Wait Until Element Is Visible    ${v3_title_text_path}
    Wait Until Element Is Visible    ${v3_code_test_path}
    Wait Until Element Is Visible    ${v3_code_value_path}
    Wait Until Element Is Visible    ${v3_discount_text_path}
    Wait Until Element Is Visible    ${v3_discount_value_path}
    Wait Until Element Is Visible    ${v3_op1_path}

    Wait Until Element Is Visible    ${text_option_type_promotion}

    ${v1_title_text}=             Get Text     ${v1_title_text_path}
    ${v1_code_test}=              Get Text     ${v1_code_test_path}
    ${v1_code_value}=             Get Text     ${v1_code_value_path}
    ${v1_discount_text}=          Get Text     ${v1_discount_text_path}
    ${v1_discount_value}=         Get Text     ${v1_discount_value_path}

    ${v2_title_text}=             Get Text     ${v2_title_text_path}
    ${v2_code_test}=              Get Text     ${v2_code_test_path}
    ${v2_code_value}=             Get Text     ${v2_code_value_path}
    ${v2_discount_text}=          Get Text     ${v2_discount_text_path}
    ${v2_discount_value}=         Get Text     ${v2_discount_value_path}

    ${v3_title_text}=             Get Text     ${v3_title_text_path}
    ${v3_code_test}=              Get Text     ${v3_code_test_path}
    ${v3_code_value}=             Get Text     ${v3_code_value_path}
    ${v3_discount_text}=          Get Text     ${v3_discount_text_path}
    ${v3_discount_value}=         Get Text     ${v3_discount_value_path}

    ${text_option_type}=          Get Text     ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า13
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYR13K29
    Should Be Equal    ${v1_discount_text}                   130 บาท
    Should Be Equal    ${v1_discount_value}                  130.-

    Should Be Equal    ${v2_title_text}                      เทสไลร่า12
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR12M9N
    Should Be Equal    ${v2_discount_text}                   120 บาท
    Should Be Equal    ${v2_discount_value}                  120.-

    Should Be Equal    ${v3_title_text}                      เทสไลร่า11
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYR11RDP
    Should Be Equal    ${v3_discount_text}                   110 บาท
    Should Be Equal    ${v3_discount_value}                  110.-

    Should Be Equal    ${text_option_type}                   *โค้ดส่วนลดขึ้นอยู่กับ สี ของสินค้า

    #click  v1

    Click Element    ${v1_op1_path}
    Sleep    10s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า13
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYR13K29
    Should Be Equal    ${v1_discount_text}                   130 บาท
    Should Be Equal    ${v1_discount_value}                  130.-

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Close All Browsers

    #click  v2
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_06_url}
    Sleep    20s
    Click Element    ${v2_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v2_title_text}                      เทสไลร่า12
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR12M9N
    Should Be Equal    ${v2_discount_text}                   120 บาท
    Should Be Equal    ${v2_discount_value}                  120.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Close All Browsers

    #click  v3
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_06_url}
    Sleep    20s
    Click Element    ${v3_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v3_title_text}                      เทสไลร่า11
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYR11RDP
    Should Be Equal    ${v3_discount_text}                   110 บาท
    Should Be Equal    ${v3_discount_value}                  110.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

TC_ITMWM_05497 show 4 promotion code(1General 2Bundle Sort By sortable) on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05497    regression    lyras16    WLS_High
    ${v1_title_text_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_07}']/div[1]/div[1]/span
    ${v1_code_test_path}=        Set Variable           //div[1][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[1]
    ${v1_code_value_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[2]
    ${v1_discount_text_path}=    Set Variable           //div[1][@id='discount-${pkey_sp16_07}']/div[2]/span[1]
    ${v1_discount_value_path}=   Set Variable           //div[1][@id='discount-${pkey_sp16_07}']/div[2]/span[2]
    ${v1_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p07_v1_op1}"]

    ${v2_title_text_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_07}']/div[1]/div[1]/span
    ${v2_code_test_path}=        Set Variable           //div[2][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[1]
    ${v2_code_value_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[2]
    ${v2_discount_text_path}=    Set Variable           //div[2][@id='discount-${pkey_sp16_07}']/div[2]/span[1]
    ${v2_discount_value_path}=   Set Variable           //div[2][@id='discount-${pkey_sp16_07}']/div[2]/span[2]
    ${v2_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p07_v2_op1}"]

    ${v3_title_text_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_07}']/div[1]/div[1]/span
    ${v3_code_test_path}=        Set Variable           //div[3][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[1]
    ${v3_code_value_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[2]
    ${v3_discount_text_path}=    Set Variable           //div[3][@id='discount-${pkey_sp16_07}']/div[2]/span[1]
    ${v3_discount_value_path}=   Set Variable           //div[3][@id='discount-${pkey_sp16_07}']/div[2]/span[2]
    ${v3_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p07_v3_op1}"]

    ${v4_title_text_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_07}']/div[1]/div[1]/span
    ${v4_code_test_path}=        Set Variable           //div[4][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[1]
    ${v4_code_value_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_07}']/div[1]/div[2]/span[2]
    ${v4_discount_text_path}=    Set Variable           //div[4][@id='discount-${pkey_sp16_07}']/div[2]/span[1]
    ${v4_discount_value_path}=   Set Variable           //div[4][@id='discount-${pkey_sp16_07}']/div[2]/span[2]
    ${v4_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p07_v4_op1}"]

    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_07_url}
    Sleep    20s

    Wait Until Element Is Visible    ${v1_title_text_path}
    Wait Until Element Is Visible    ${v1_code_test_path}
    Wait Until Element Is Visible    ${v1_code_value_path}
    Wait Until Element Is Visible    ${v1_discount_text_path}
    Wait Until Element Is Visible    ${v1_discount_value_path}
    Wait Until Element Is Visible    ${v1_op1_path}

    Wait Until Element Is Visible    ${v2_title_text_path}
    Wait Until Element Is Visible    ${v2_code_test_path}
    Wait Until Element Is Visible    ${v2_code_value_path}
    Wait Until Element Is Visible    ${v2_discount_text_path}
    Wait Until Element Is Visible    ${v2_discount_value_path}
    Wait Until Element Is Visible    ${v2_op1_path}

    Wait Until Element Is Visible    ${v3_title_text_path}
    Wait Until Element Is Visible    ${v3_code_test_path}
    Wait Until Element Is Visible    ${v3_code_value_path}
    Wait Until Element Is Visible    ${v3_discount_text_path}
    Wait Until Element Is Visible    ${v3_discount_value_path}
    Wait Until Element Is Visible    ${v3_op1_path}

    Wait Until Element Is Visible    ${v4_title_text_path}
    Wait Until Element Is Visible    ${v4_code_test_path}
    Wait Until Element Is Visible    ${v4_code_value_path}
    Wait Until Element Is Visible    ${v4_discount_text_path}
    Wait Until Element Is Visible    ${v4_discount_value_path}
    Wait Until Element Is Visible    ${v4_op1_path}

    Wait Until Element Is Visible    ${text_option_type_promotion}

    ${v1_title_text}=             Get Text     ${v1_title_text_path}
    ${v1_code_test}=              Get Text     ${v1_code_test_path}
    ${v1_code_value}=             Get Text     ${v1_code_value_path}
    ${v1_discount_text}=          Get Text     ${v1_discount_text_path}
    ${v1_discount_value}=         Get Text     ${v1_discount_value_path}

    ${v2_title_text}=             Get Text     ${v2_title_text_path}
    ${v2_code_test}=              Get Text     ${v2_code_test_path}
    ${v2_code_value}=             Get Text     ${v2_code_value_path}
    ${v2_discount_text}=          Get Text     ${v2_discount_text_path}
    ${v2_discount_value}=         Get Text     ${v2_discount_value_path}

    ${v3_title_text}=             Get Text     ${v3_title_text_path}
    ${v3_code_test}=              Get Text     ${v3_code_test_path}
    ${v3_code_value}=             Get Text     ${v3_code_value_path}
    ${v3_discount_text}=          Get Text     ${v3_discount_text_path}
    ${v3_discount_value}=         Get Text     ${v3_discount_value_path}

    ${v4_title_text}=             Get Text     ${v4_title_text_path}
    ${v4_code_test}=              Get Text     ${v4_code_test_path}
    ${v4_code_value}=             Get Text     ${v4_code_value_path}
    ${v4_discount_text}=          Get Text     ${v4_discount_text_path}
    ${v4_discount_value}=         Get Text     ${v4_discount_value_path}

    ${text_option_type}=          Get Text     ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า4
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA2UN
    Should Be Equal    ${v1_discount_text}                   40 บาท
    Should Be Equal    ${v1_discount_value}                  40.-

    Should Be Equal    ${v2_title_text}                      เทสไลร่า6
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYRA6TRB
    Should Be Equal    ${v2_discount_text}                   60 บาท
    Should Be Equal    ${v2_discount_value}                  60.-

    Should Be Equal    ${v3_title_text}                      เทสไลร่า5
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA5ZY3
    Should Be Equal    ${v3_discount_text}                   50 บาท
    Should Be Equal    ${v3_discount_value}                  50.-

    Should Be Equal    ${v4_title_text}                      เทสไลร่า9
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYRADG
    Should Be Equal    ${v4_discount_text}                   90 บาท
    Should Be Equal    ${v4_discount_value}                  90.-

    Should Be Equal    ${text_option_type}                   *โค้ดส่วนลดขึ้นอยู่กับ ขนาด ของสินค้า

    #click  v1

    Click Element    ${v1_op1_path}
    Sleep    10s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า4
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA2UN
    Should Be Equal    ${v1_discount_text}                   40 บาท
    Should Be Equal    ${v1_discount_value}                  40.-

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v2
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_07_url}
    Sleep    20s
    Click Element    ${v2_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v2_title_text}                      เทสไลร่า6
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYRA6TRB
    Should Be Equal    ${v2_discount_text}                   60 บาท
    Should Be Equal    ${v2_discount_value}                  60.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v3
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_07_url}
    Sleep    20s
    Click Element    ${v3_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v3_title_text}                      เทสไลร่า5
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA5ZY3
    Should Be Equal    ${v3_discount_text}                   50 บาท
    Should Be Equal    ${v3_discount_value}                  50.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v4
    Open Browser ITM Mobile -levelD No Cache   ${lyras16_product_07_url}
    Sleep    20s
    Click Element    ${v4_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v4_title_text}                      เทสไลร่า9
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYRADG
    Should Be Equal    ${v4_discount_text}                   90 บาท
    Should Be Equal    ${v4_discount_value}                  90.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

TC_ITMWM_05498 show 4 promotion code(1General 2MNP Sort By sortable) on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05498    regression    lyras16    WLS_High
    ${v1_title_text_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_08}']/div[1]/div[1]/span
    ${v1_code_test_path}=        Set Variable           //div[1][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[1]
    ${v1_code_value_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[2]
    ${v1_discount_text_path}=    Set Variable           //div[1][@id='discount-${pkey_sp16_08}']/div[2]/span[1]
    ${v1_discount_value_path}=   Set Variable           //div[1][@id='discount-${pkey_sp16_08}']/div[2]/span[2]
    ${v1_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p08_v1_op1}"]

    ${v2_title_text_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_08}']/div[1]/div[1]/span
    ${v2_code_test_path}=        Set Variable           //div[2][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[1]
    ${v2_code_value_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[2]
    ${v2_discount_text_path}=    Set Variable           //div[2][@id='discount-${pkey_sp16_08}']/div[2]/span[1]
    ${v2_discount_value_path}=   Set Variable           //div[2][@id='discount-${pkey_sp16_08}']/div[2]/span[2]
    ${v2_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p08_v2_op1}"]

    ${v3_title_text_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_08}']/div[1]/div[1]/span
    ${v3_code_test_path}=        Set Variable           //div[3][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[1]
    ${v3_code_value_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[2]
    ${v3_discount_text_path}=    Set Variable           //div[3][@id='discount-${pkey_sp16_08}']/div[2]/span[1]
    ${v3_discount_value_path}=   Set Variable           //div[3][@id='discount-${pkey_sp16_08}']/div[2]/span[2]
    ${v3_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p08_v3_op1}"]

    ${v4_title_text_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_08}']/div[1]/div[1]/span
    ${v4_code_test_path}=        Set Variable           //div[4][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[1]
    ${v4_code_value_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_08}']/div[1]/div[2]/span[2]
    ${v4_discount_text_path}=    Set Variable           //div[4][@id='discount-${pkey_sp16_08}']/div[2]/span[1]
    ${v4_discount_value_path}=   Set Variable           //div[4][@id='discount-${pkey_sp16_08}']/div[2]/span[2]
    ${v4_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p08_v4_op1}"]

    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_08_url}
    Sleep    20s

    Wait Until Element Is Visible    ${v1_title_text_path}
    Wait Until Element Is Visible    ${v1_code_test_path}
    Wait Until Element Is Visible    ${v1_code_value_path}
    Wait Until Element Is Visible    ${v1_discount_text_path}
    Wait Until Element Is Visible    ${v1_discount_value_path}
    Wait Until Element Is Visible    ${v1_op1_path}

    Wait Until Element Is Visible    ${v2_title_text_path}
    Wait Until Element Is Visible    ${v2_code_test_path}
    Wait Until Element Is Visible    ${v2_code_value_path}
    Wait Until Element Is Visible    ${v2_discount_text_path}
    Wait Until Element Is Visible    ${v2_discount_value_path}
    Wait Until Element Is Visible    ${v2_op1_path}

    Wait Until Element Is Visible    ${v3_title_text_path}
    Wait Until Element Is Visible    ${v3_code_test_path}
    Wait Until Element Is Visible    ${v3_code_value_path}
    Wait Until Element Is Visible    ${v3_discount_text_path}
    Wait Until Element Is Visible    ${v3_discount_value_path}
    Wait Until Element Is Visible    ${v3_op1_path}

    Wait Until Element Is Visible    ${v4_title_text_path}
    Wait Until Element Is Visible    ${v4_code_test_path}
    Wait Until Element Is Visible    ${v4_code_value_path}
    Wait Until Element Is Visible    ${v4_discount_text_path}
    Wait Until Element Is Visible    ${v4_discount_value_path}
    Wait Until Element Is Visible    ${v4_op1_path}

    Wait Until Element Is Visible    ${text_option_type_promotion}

    ${v1_title_text}=             Get Text     ${v1_title_text_path}
    ${v1_code_test}=              Get Text     ${v1_code_test_path}
    ${v1_code_value}=             Get Text     ${v1_code_value_path}
    ${v1_discount_text}=          Get Text     ${v1_discount_text_path}
    ${v1_discount_value}=         Get Text     ${v1_discount_value_path}

    ${v2_title_text}=             Get Text     ${v2_title_text_path}
    ${v2_code_test}=              Get Text     ${v2_code_test_path}
    ${v2_code_value}=             Get Text     ${v2_code_value_path}
    ${v2_discount_text}=          Get Text     ${v2_discount_text_path}
    ${v2_discount_value}=         Get Text     ${v2_discount_value_path}

    ${v3_title_text}=             Get Text     ${v3_title_text_path}
    ${v3_code_test}=              Get Text     ${v3_code_test_path}
    ${v3_code_value}=             Get Text     ${v3_code_value_path}
    ${v3_discount_text}=          Get Text     ${v3_discount_text_path}
    ${v3_discount_value}=         Get Text     ${v3_discount_value_path}

    ${v4_title_text}=             Get Text     ${v4_title_text_path}
    ${v4_code_test}=              Get Text     ${v4_code_test_path}
    ${v4_code_value}=             Get Text     ${v4_code_value_path}
    ${v4_discount_text}=          Get Text     ${v4_discount_text_path}
    ${v4_discount_value}=         Get Text     ${v4_discount_value_path}

    ${text_option_type}=          Get Text     ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า4
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA2UN
    Should Be Equal    ${v1_discount_text}                   40 บาท
    Should Be Equal    ${v1_discount_value}                  40.-

    Should Be Equal    ${v2_title_text}                      เทสไลร่า6
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYRA6TRB
    Should Be Equal    ${v2_discount_text}                   60 บาท
    Should Be Equal    ${v2_discount_value}                  60.-

    Should Be Equal    ${v3_title_text}                      เทสไลร่า5
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA5ZY3
    Should Be Equal    ${v3_discount_text}                   50 บาท
    Should Be Equal    ${v3_discount_value}                  50.-

    Should Be Equal    ${v4_title_text}                      เทสไลร่า14
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYR14VZT
    Should Be Equal    ${v4_discount_text}                   140 บาท
    Should Be Equal    ${v4_discount_value}                  140.-

    Should Be Equal    ${text_option_type}                   *โค้ดส่วนลดขึ้นอยู่กับ ขนาด ของสินค้า

    #click  v1

    Click Element    ${v1_op1_path}
    Sleep    10s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า4
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA2UN
    Should Be Equal    ${v1_discount_text}                   40 บาท
    Should Be Equal    ${v1_discount_value}                  40.-

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v2
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_08_url}
    Sleep    20s
    Click Element    ${v2_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v2_title_text}                      เทสไลร่า6
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYRA6TRB
    Should Be Equal    ${v2_discount_text}                   60 บาท
    Should Be Equal    ${v2_discount_value}                  60.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v3
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_08_url}
    Sleep    20s
    Click Element    ${v3_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v3_title_text}                      เทสไลร่า5
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA5ZY3
    Should Be Equal    ${v3_discount_text}                   50 บาท
    Should Be Equal    ${v3_discount_value}                  50.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v4
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_08_url}
    Sleep    20s
    Click Element    ${v4_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v4_title_text}                      เทสไลร่า14
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYR14VZT
    Should Be Equal    ${v4_discount_text}                   140 บาท
    Should Be Equal    ${v4_discount_value}                  140.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

TC_ITMWM_05499 show 4 promotion code(1Bundle 2MNP Sort By sortable) on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05499    regression    lyras16    WLS_High
    ${v1_title_text_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_09}']/div[1]/div[1]/span
    ${v1_code_test_path}=        Set Variable           //div[1][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[1]
    ${v1_code_value_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[2]
    ${v1_discount_text_path}=    Set Variable           //div[1][@id='discount-${pkey_sp16_09}']/div[2]/span[1]
    ${v1_discount_value_path}=   Set Variable           //div[1][@id='discount-${pkey_sp16_09}']/div[2]/span[2]
    ${v1_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p09_v1_op1}"]

    ${v2_title_text_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_09}']/div[1]/div[1]/span
    ${v2_code_test_path}=        Set Variable           //div[2][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[1]
    ${v2_code_value_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[2]
    ${v2_discount_text_path}=    Set Variable           //div[2][@id='discount-${pkey_sp16_09}']/div[2]/span[1]
    ${v2_discount_value_path}=   Set Variable           //div[2][@id='discount-${pkey_sp16_09}']/div[2]/span[2]
    ${v2_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p09_v2_op1}"]

    ${v3_title_text_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_09}']/div[1]/div[1]/span
    ${v3_code_test_path}=        Set Variable           //div[3][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[1]
    ${v3_code_value_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[2]
    ${v3_discount_text_path}=    Set Variable           //div[3][@id='discount-${pkey_sp16_09}']/div[2]/span[1]
    ${v3_discount_value_path}=   Set Variable           //div[3][@id='discount-${pkey_sp16_09}']/div[2]/span[2]
    ${v3_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p09_v3_op1}"]

    ${v4_title_text_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_09}']/div[1]/div[1]/span
    ${v4_code_test_path}=        Set Variable           //div[4][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[1]
    ${v4_code_value_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_09}']/div[1]/div[2]/span[2]
    ${v4_discount_text_path}=    Set Variable           //div[4][@id='discount-${pkey_sp16_09}']/div[2]/span[1]
    ${v4_discount_value_path}=   Set Variable           //div[4][@id='discount-${pkey_sp16_09}']/div[2]/span[2]
    ${v4_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p09_v4_op1}"]

    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_09_url}
    Sleep    20s

    Wait Until Element Is Visible    ${v1_title_text_path}
    Wait Until Element Is Visible    ${v1_code_test_path}
    Wait Until Element Is Visible    ${v1_code_value_path}
    Wait Until Element Is Visible    ${v1_discount_text_path}
    Wait Until Element Is Visible    ${v1_discount_value_path}
    Wait Until Element Is Visible    ${v1_op1_path}

    Wait Until Element Is Visible    ${v2_title_text_path}
    Wait Until Element Is Visible    ${v2_code_test_path}
    Wait Until Element Is Visible    ${v2_code_value_path}
    Wait Until Element Is Visible    ${v2_discount_text_path}
    Wait Until Element Is Visible    ${v2_discount_value_path}
    Wait Until Element Is Visible    ${v2_op1_path}

    Wait Until Element Is Visible    ${v3_title_text_path}
    Wait Until Element Is Visible    ${v3_code_test_path}
    Wait Until Element Is Visible    ${v3_code_value_path}
    Wait Until Element Is Visible    ${v3_discount_text_path}
    Wait Until Element Is Visible    ${v3_discount_value_path}
    Wait Until Element Is Visible    ${v3_op1_path}

    Wait Until Element Is Visible    ${v4_title_text_path}
    Wait Until Element Is Visible    ${v4_code_test_path}
    Wait Until Element Is Visible    ${v4_code_value_path}
    Wait Until Element Is Visible    ${v4_discount_text_path}
    Wait Until Element Is Visible    ${v4_discount_value_path}
    Wait Until Element Is Visible    ${v4_op1_path}

    Wait Until Element Is Visible    ${text_option_type_promotion}

    ${v1_title_text}=             Get Text     ${v1_title_text_path}
    ${v1_code_test}=              Get Text     ${v1_code_test_path}
    ${v1_code_value}=             Get Text     ${v1_code_value_path}
    ${v1_discount_text}=          Get Text     ${v1_discount_text_path}
    ${v1_discount_value}=         Get Text     ${v1_discount_value_path}

    ${v2_title_text}=             Get Text     ${v2_title_text_path}
    ${v2_code_test}=              Get Text     ${v2_code_test_path}
    ${v2_code_value}=             Get Text     ${v2_code_value_path}
    ${v2_discount_text}=          Get Text     ${v2_discount_text_path}
    ${v2_discount_value}=         Get Text     ${v2_discount_value_path}

    ${v3_title_text}=             Get Text     ${v3_title_text_path}
    ${v3_code_test}=              Get Text     ${v3_code_test_path}
    ${v3_code_value}=             Get Text     ${v3_code_value_path}
    ${v3_discount_text}=          Get Text     ${v3_discount_text_path}
    ${v3_discount_value}=         Get Text     ${v3_discount_value_path}

    ${v4_title_text}=             Get Text     ${v4_title_text_path}
    ${v4_code_test}=              Get Text     ${v4_code_test_path}
    ${v4_code_value}=             Get Text     ${v4_code_value_path}
    ${v4_discount_text}=          Get Text     ${v4_discount_text_path}
    ${v4_discount_value}=         Get Text     ${v4_discount_value_path}

    ${text_option_type}=          Get Text     ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า9
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRADG
    Should Be Equal    ${v1_discount_text}                   90 บาท
    Should Be Equal    ${v1_discount_value}                  90.-

    Should Be Equal    ${v2_title_text}                      เทสไลร่า11
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR11RDP
    Should Be Equal    ${v2_discount_text}                   110 บาท
    Should Be Equal    ${v2_discount_value}                  110.-

    Should Be Equal    ${v3_title_text}                      เทสไลร่า10
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYR10MNG
    Should Be Equal    ${v3_discount_text}                   100 บาท
    Should Be Equal    ${v3_discount_value}                  100.-

    Should Be Equal    ${v4_title_text}                      เทสไลร่า14
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYR14VZT
    Should Be Equal    ${v4_discount_text}                   140 บาท
    Should Be Equal    ${v4_discount_value}                  140.-

    Should Be Equal    ${text_option_type}                   *โค้ดส่วนลดขึ้นอยู่กับ ขนาด ของสินค้า

    #click  v1

    Click Element    ${v1_op1_path}
    Sleep    10s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า9
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRADG
    Should Be Equal    ${v1_discount_text}                   90 บาท
    Should Be Equal    ${v1_discount_value}                  90.-

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v2
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_09_url}
    Sleep    20s
    Click Element    ${v2_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v2_title_text}                      เทสไลร่า11
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYR11RDP
    Should Be Equal    ${v2_discount_text}                   110 บาท
    Should Be Equal    ${v2_discount_value}                  110.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v3
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_09_url}
    Sleep    20s
    Click Element    ${v3_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v3_title_text}                      เทสไลร่า10
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYR10MNG
    Should Be Equal    ${v3_discount_text}                   100 บาท
    Should Be Equal    ${v3_discount_value}                  100.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Close All Browsers

    #click  v4
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_09_url}
    Sleep    20s
    Click Element    ${v4_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v4_title_text}                      เทสไลร่า14
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYR14VZT
    Should Be Equal    ${v4_discount_text}                   140 บาท
    Should Be Equal    ${v4_discount_value}                  140.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

TC_ITMWM_05501 show 5 promotion code(1General 2Bundle 3MNP Sort By sortable) on Product(variant) Lv.D Page(Mobile)
    [Tags]    TC_ITMWM_05501    regression    lyras16    WLS_High
    ${v1_title_text_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_10}']/div[1]/div[1]/span
    ${v1_code_test_path}=        Set Variable           //div[1][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[1]
    ${v1_code_value_path}=       Set Variable           //div[1][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[2]
    ${v1_discount_text_path}=    Set Variable           //div[1][@id='discount-${pkey_sp16_10}']/div[2]/span[1]
    ${v1_discount_value_path}=   Set Variable           //div[1][@id='discount-${pkey_sp16_10}']/div[2]/span[2]
    ${v1_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p10_v1_op1}"]

    ${v2_title_text_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_10}']/div[1]/div[1]/span
    ${v2_code_test_path}=        Set Variable           //div[2][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[1]
    ${v2_code_value_path}=       Set Variable           //div[2][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[2]
    ${v2_discount_text_path}=    Set Variable           //div[2][@id='discount-${pkey_sp16_10}']/div[2]/span[1]
    ${v2_discount_value_path}=   Set Variable           //div[2][@id='discount-${pkey_sp16_10}']/div[2]/span[2]
    ${v2_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p10_v2_op1}"]

    ${v3_title_text_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_10}']/div[1]/div[1]/span
    ${v3_code_test_path}=        Set Variable           //div[3][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[1]
    ${v3_code_value_path}=       Set Variable           //div[3][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[2]
    ${v3_discount_text_path}=    Set Variable           //div[3][@id='discount-${pkey_sp16_10}']/div[2]/span[1]
    ${v3_discount_value_path}=   Set Variable           //div[3][@id='discount-${pkey_sp16_10}']/div[2]/span[2]
    ${v3_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p10_v3_op1}"]

    ${v4_title_text_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_10}']/div[1]/div[1]/span
    ${v4_code_test_path}=        Set Variable           //div[4][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[1]
    ${v4_code_value_path}=       Set Variable           //div[4][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[2]
    ${v4_discount_text_path}=    Set Variable           //div[4][@id='discount-${pkey_sp16_10}']/div[2]/span[1]
    ${v4_discount_value_path}=   Set Variable           //div[4][@id='discount-${pkey_sp16_10}']/div[2]/span[2]
    ${v4_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p10_v4_op1}"]

    ${v5_title_text_path}=       Set Variable           //div[5][@id='discount-${pkey_sp16_10}']/div[1]/div[1]/span
    ${v5_code_test_path}=        Set Variable           //div[5][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[1]
    ${v5_code_value_path}=       Set Variable           //div[5][@id='discount-${pkey_sp16_10}']/div[1]/div[2]/span[2]
    ${v5_discount_text_path}=    Set Variable           //div[5][@id='discount-${pkey_sp16_10}']/div[2]/span[1]
    ${v5_discount_value_path}=   Set Variable           //div[5][@id='discount-${pkey_sp16_10}']/div[2]/span[2]
    ${v5_op1_path}=              Set Variable           //a/div[@data-style-option-pkey="${pkey_sp16_p10_v5_op1}"]

    ${text_option_type_promotion}=      Set Variable    //*[@id='discount-remark-group']

    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_10_url}
    Sleep    20s

    Wait Until Element Is Visible    ${v1_title_text_path}
    Wait Until Element Is Visible    ${v1_code_test_path}
    Wait Until Element Is Visible    ${v1_code_value_path}
    Wait Until Element Is Visible    ${v1_discount_text_path}
    Wait Until Element Is Visible    ${v1_discount_value_path}
    Wait Until Element Is Visible    ${v1_op1_path}

    Wait Until Element Is Visible    ${v2_title_text_path}
    Wait Until Element Is Visible    ${v2_code_test_path}
    Wait Until Element Is Visible    ${v2_code_value_path}
    Wait Until Element Is Visible    ${v2_discount_text_path}
    Wait Until Element Is Visible    ${v2_discount_value_path}
    Wait Until Element Is Visible    ${v2_op1_path}

    Wait Until Element Is Visible    ${v3_title_text_path}
    Wait Until Element Is Visible    ${v3_code_test_path}
    Wait Until Element Is Visible    ${v3_code_value_path}
    Wait Until Element Is Visible    ${v3_discount_text_path}
    Wait Until Element Is Visible    ${v3_discount_value_path}
    Wait Until Element Is Visible    ${v3_op1_path}

    Wait Until Element Is Visible    ${v4_title_text_path}
    Wait Until Element Is Visible    ${v4_code_test_path}
    Wait Until Element Is Visible    ${v4_code_value_path}
    Wait Until Element Is Visible    ${v4_discount_text_path}
    Wait Until Element Is Visible    ${v4_discount_value_path}
    Wait Until Element Is Visible    ${v4_op1_path}

    Wait Until Element Is Visible    ${v5_title_text_path}
    Wait Until Element Is Visible    ${v5_code_test_path}
    Wait Until Element Is Visible    ${v5_code_value_path}
    Wait Until Element Is Visible    ${v5_discount_text_path}
    Wait Until Element Is Visible    ${v5_discount_value_path}
    Wait Until Element Is Visible    ${v5_op1_path}

    Wait Until Element Is Visible    ${text_option_type_promotion}

    ${v1_title_text}=             Get Text     ${v1_title_text_path}
    ${v1_code_test}=              Get Text     ${v1_code_test_path}
    ${v1_code_value}=             Get Text     ${v1_code_value_path}
    ${v1_discount_text}=          Get Text     ${v1_discount_text_path}
    ${v1_discount_value}=         Get Text     ${v1_discount_value_path}

    ${v2_title_text}=             Get Text     ${v2_title_text_path}
    ${v2_code_test}=              Get Text     ${v2_code_test_path}
    ${v2_code_value}=             Get Text     ${v2_code_value_path}
    ${v2_discount_text}=          Get Text     ${v2_discount_text_path}
    ${v2_discount_value}=         Get Text     ${v2_discount_value_path}

    ${v3_title_text}=             Get Text     ${v3_title_text_path}
    ${v3_code_test}=              Get Text     ${v3_code_test_path}
    ${v3_code_value}=             Get Text     ${v3_code_value_path}
    ${v3_discount_text}=          Get Text     ${v3_discount_text_path}
    ${v3_discount_value}=         Get Text     ${v3_discount_value_path}

    ${v4_title_text}=             Get Text     ${v4_title_text_path}
    ${v4_code_test}=              Get Text     ${v4_code_test_path}
    ${v4_code_value}=             Get Text     ${v4_code_value_path}
    ${v4_discount_text}=          Get Text     ${v4_discount_text_path}
    ${v4_discount_value}=         Get Text     ${v4_discount_value_path}

    ${v5_title_text}=             Get Text     ${v5_title_text_path}
    ${v5_code_test}=              Get Text     ${v5_code_test_path}
    ${v5_code_value}=             Get Text     ${v5_code_value_path}
    ${v5_discount_text}=          Get Text     ${v5_discount_text_path}
    ${v5_discount_value}=         Get Text     ${v5_discount_value_path}

    ${text_option_type}=          Get Text     ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า4
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA2UN
    Should Be Equal    ${v1_discount_text}                   40 บาท
    Should Be Equal    ${v1_discount_value}                  40.-

    Should Be Equal    ${v2_title_text}                      เทสไลร่า6
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYRA6TRB
    Should Be Equal    ${v2_discount_text}                   60 บาท
    Should Be Equal    ${v2_discount_value}                  60.-

    Should Be Equal    ${v3_title_text}                      เทสไลร่า5
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA5ZY3
    Should Be Equal    ${v3_discount_text}                   50 บาท
    Should Be Equal    ${v3_discount_value}                  50.-

    Should Be Equal    ${v4_title_text}                      เทสไลร่า9
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYRADG
    Should Be Equal    ${v4_discount_text}                   90 บาท
    Should Be Equal    ${v4_discount_value}                  90.-

    Should Be Equal    ${v5_title_text}                      เทสไลร่า14
    Should Be Equal    ${v5_code_test}                       ใส่
    Should Be Equal    ${v5_code_value}                      LYR14VZT
    Should Be Equal    ${v5_discount_text}                   140 บาท
    Should Be Equal    ${v5_discount_value}                  140.-

    Should Be Equal    ${text_option_type}                   *โค้ดส่วนลดขึ้นอยู่กับ ขนาด ของสินค้า

    #click  v1

    Click Element    ${v1_op1_path}
    Sleep    10s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v1_title_text}                      เทสไลร่า4
    Should Be Equal    ${v1_code_test}                       ใส่
    Should Be Equal    ${v1_code_value}                      LYRA2UN
    Should Be Equal    ${v1_discount_text}                   40 บาท
    Should Be Equal    ${v1_discount_value}                  40.-

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Element Should Not Be Visible        ${v5_title_text}
    Element Should Not Be Visible        ${v5_code_test}
    Element Should Not Be Visible        ${v5_code_value}
    Element Should Not Be Visible        ${v5_discount_text}
    Element Should Not Be Visible        ${v5_discount_value}

    Close All Browsers

    #click  v2
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_10_url}
    Sleep    20s
    Click Element    ${v2_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v2_title_text}                      เทสไลร่า6
    Should Be Equal    ${v2_code_test}                       ใส่
    Should Be Equal    ${v2_code_value}                      LYRA6TRB
    Should Be Equal    ${v2_discount_text}                   60 บาท
    Should Be Equal    ${v2_discount_value}                  60.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Element Should Not Be Visible        ${v5_title_text}
    Element Should Not Be Visible        ${v5_code_test}
    Element Should Not Be Visible        ${v5_code_value}
    Element Should Not Be Visible        ${v5_discount_text}
    Element Should Not Be Visible        ${v5_discount_value}

    Close All Browsers

    #click  v3
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_10_url}
    Sleep    20s
    Click Element    ${v3_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v3_title_text}                      เทสไลร่า5
    Should Be Equal    ${v3_code_test}                       ใส่
    Should Be Equal    ${v3_code_value}                      LYRA5ZY3
    Should Be Equal    ${v3_discount_text}                   50 บาท
    Should Be Equal    ${v3_discount_value}                  50.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}

    Element Should Not Be Visible        ${v5_title_text}
    Element Should Not Be Visible        ${v5_code_test}
    Element Should Not Be Visible        ${v5_code_value}
    Element Should Not Be Visible        ${v5_discount_text}
    Element Should Not Be Visible        ${v5_discount_value}

    Close All Browsers

    #click  v4
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_10_url}
    Sleep    20s
    Click Element    ${v4_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v4_title_text}                      เทสไลร่า9
    Should Be Equal    ${v4_code_test}                       ใส่
    Should Be Equal    ${v4_code_value}                      LYRADG
    Should Be Equal    ${v4_discount_text}                   90 บาท
    Should Be Equal    ${v4_discount_value}                  90.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v5_title_text}
    Element Should Not Be Visible        ${v5_code_test}
    Element Should Not Be Visible        ${v5_code_value}
    Element Should Not Be Visible        ${v5_discount_text}
    Element Should Not Be Visible        ${v5_discount_value}

    Close All Browsers

    #click  v5
    Open Browser ITM Mobile -levelD No Cache    ${lyras16_product_10_url}
    Sleep    20s
    Click Element    ${v5_op1_path}
    Sleep    20s

    Element Should Not Be Visible        ${text_option_type_promotion}

    Should Be Equal    ${v5_title_text}                      เทสไลร่า14
    Should Be Equal    ${v5_code_test}                       ใส่
    Should Be Equal    ${v5_code_value}                      LYR14VZT
    Should Be Equal    ${v5_discount_text}                   140 บาท
    Should Be Equal    ${v5_discount_value}                  140.-

    Element Should Not Be Visible        ${v1_title_text}
    Element Should Not Be Visible        ${v1_code_test}
    Element Should Not Be Visible        ${v1_code_value}
    Element Should Not Be Visible        ${v1_discount_text}
    Element Should Not Be Visible        ${v1_discount_value}

    Element Should Not Be Visible        ${v2_title_text}
    Element Should Not Be Visible        ${v2_code_test}
    Element Should Not Be Visible        ${v2_code_value}
    Element Should Not Be Visible        ${v2_discount_text}
    Element Should Not Be Visible        ${v2_discount_value}

    Element Should Not Be Visible        ${v3_title_text}
    Element Should Not Be Visible        ${v3_code_test}
    Element Should Not Be Visible        ${v3_code_value}
    Element Should Not Be Visible        ${v3_discount_text}
    Element Should Not Be Visible        ${v3_discount_value}

    Element Should Not Be Visible        ${v4_title_text}
    Element Should Not Be Visible        ${v4_code_test}
    Element Should Not Be Visible        ${v4_code_value}
    Element Should Not Be Visible        ${v4_discount_text}
    Element Should Not Be Visible        ${v4_discount_value}
