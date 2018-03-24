*** Settings ***
Library           String
Library           Selenium2Library
Resource          ${CURDIR}/web_element_header.robot
Resource          ${CURDIR}/../Login/web_element_login.robot
Resource          ${CURDIR}/../Cart_light_box/WebElement_CartLightBox.robot
Resource          ${CURDIR}/../../../Common/Keywords_Common.robot
Resource          ${CURDIR}/../checkout_3/WebElement_Checkout3.robot

*** Variables ***
# ${itm_logo_image_path}    ${ITM_URL}/themes/itruemart/assets/images/logo/itruemart.png?q=102014?ckey=2016-14
${itm_logo_image_path}    ${ITM_URL}/themes/itruemart/assets/images/logo/itruemart.png?q=102014?ckey=
${everday_wow_logo_img_path}    http://cdn-banner.itruemart-dev.com/pcms/uploads/banners/101/wowicon.png?q=7e61fc5441d96f2b71e714703438c110
${TH_lang_img_path}    ${ITM_URL}/themes/itruemart/assets/images/icn/flag/th.jpg?ckey=
${EN_lang_img_path}    ${ITM_URL}/themes/itruemart/assets/images/icn/flag/en.jpg?ckey=

*** Keywords ***
Header - User Click Login Link On Web
    Run Keyword If    '${IS_WEMALL}' == 'on'    Run Keywords    Not Visible Then If Failed Wait and Check Is Visible Again    ${XPATH_HEADER.lnk_login_wm}
    ...    AND    Click Then If Failed Wait and Click Again    ${XPATH_HEADER.lnk_login_wm}
    ...    ELSE    Run Keywords    Not Visible Then If Failed Wait and Check Is Visible Again    ${XPATH_HEADER.lnk_login}
    ...    AND    Click Then If Failed Wait and Click Again    ${XPATH_HEADER.lnk_login}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${XPATH_LOGIN.txt_username}

Header - User Click Login Link On Mobile
    Wait Until Element Is Visible    ${XPATH_HEADER_MOBILE.lnk_login}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_HEADER_MOBILE.lnk_login}
    #    ชื่อเหมือนกัน แค่อยากปรับชื่อ Keyword เฉยๆ แต่ไม่อยากให้ Effect กับ TestCases เก่าที่ย้ายมา

User Click Login Link On Top Bar
    Wait Until Element Is Visible    ${XPATH_HEADER.lnk_login}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_HEADER.lnk_login}

User Click Login Link On Top Bar Mobile
    Wait Until Element Is Visible    ${XPATH_HEADER_MOBILE.lnk_login}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_HEADER_MOBILE.lnk_login}

Go to Specific URL
    [Arguments]    ${full_url}
    Go to    ${full_url}
    Wait Until Element Is Visible    ${chat_online_button}:contains("แชทออนไลน์")    30s
    # Click Then If Failed Wait and Click Again
    #    [Arguments]    ${locator}
    #    Wait Until Element Is Visible    ${locator}    5s
    #    ${result}=    Run Keyword And Return Status    Click Element    ${locator}
    #    Run Keyword If    ${result} == False    Sleep    3s
    #    Run Keyword If    ${result} == False    Click Element    ${locator}

Click Open Chat Online
    Wait Until Element Is Visible    ${chat_online_button}    30s
    Click Element    ${chat_online_button}
    Wait Until Element Is Visible    ${chat_online_iframe}    30s

Click iTM Logo
    Click Then If Failed Wait and Click Again    ${itm_logo_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${itm_logo_img}

Click Search Button
    Click Then If Failed Wait and Click Again    ${search_button}

Click Everyday Wow Logo
    Click Then If Failed Wait and Click Again    ${everyday_wow_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    jquery=#superdeal

Click User Profile Dropdown
    Click Then If Failed Wait and Click Again    ${user_name_label}

Click User Profile Link
    Click User Profile Dropdown
    Click Then If Failed Wait and Click Again    ${user_profile_link}

Click Order History Link
    Click User Profile Dropdown
    Click Then If Failed Wait and Click Again    ${order_history_link}

Click New Member Coupon Link
    Click User Profile Dropdown
    Click Then If Failed Wait and Click Again    ${new_memeber_coupon_link}

Click Log Out Link
    Click User Profile Dropdown
    Click Then If Failed Wait and Click Again    ${logout_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${login_link}

Click Mega Menu Button
    Click Then If Failed Wait and Click Again    ${mega_menu_button}

Click Expand Mega Menu Section
    ${megamenu_exist}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${mega_menu_section}    5s
    Run Keyword If    ${megamenu_exist}    Click Mega Menu Button

Click Collapse Mega Menu Section
    ${megamenu_exist}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${mega_menu_section}    5s
    Run Keyword If    ${megamenu_exist}    Click Mega Menu Button

Click Cart Box Button
    Click Then If Failed Wait and Click Again    ${cart_box_button}
    Wait Until Element Is Visible    ${cart_light_box_popup}    10s
    Wait Until Page Does Not Contain Element    ${cart_light_box_popup}:contains("กำลังโหลดรายการ...")    30s

Search Product in iTM
    [Arguments]    ${search_text}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${itm_search_box}
    Input Text    ${itm_search_box}    ${search_text}
    Click Search Button

Switch to TH Language
    Not Visible Then If Failed Wait and Check Is Visible Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${TH_language_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("แชทออนไลน์")

Switch to EN Language
    ${xpath_btn_language}=    Run Keyword If    '${IS_WEMALL}' == 'on'    Set Variable    ${language_button_wm}
    ...    ELSE    Set Variable    ${language_button_itm}
    ${xpath_lnk_language_en}=    Run Keyword If    '${IS_WEMALL}' == 'on'    Set Variable    ${EN_language_link_wm}
    ...    ELSE    Set Variable    ${EN_language_link_itm}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${xpath_btn_language}
    #Click Then If Failed Wait and Click Again    ${language_button}
    Click Then If Failed Wait and Click Again    xpath=//html/body/div[5]/div[2]/div[2]/div/div[9]/ul/li[1]/a
    Click Element    //div[contains(@class, "btn-select-lang float-right")]//a[@class="ng-binding"]
    Click Then If Failed Wait and Click Again    ${xpath_lnk_language_en}
    # Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("Customer Service")
    Sleep    3
Switch to TH Language on Mobile
    Click Element    ${XPATH_HEADER_MOBILE.lnk_switch_language}

Switch to EN Language on Mobile
    Click Element    //div[contains(@class, "btn-select-lang float-right")]//a[@class="ng-binding"]
    Run Keyword If    '${IS_WEMALL}' == 'on'    Run Keywords    Click Element    ${XPATH_HEADER_MOBILE.lnk_header_menu_wm}
    ...    AND    Wait Until Element Is Visible    ${XPATH_HEADER_MOBILE.lnk_switch_eng_wm}
    ...    AND    Click Element    ${XPATH_HEADER_MOBILE.lnk_switch_eng_wm}
    ...    ELSE    Run Keywords    Wait Until Element Is Visible    ${XPATH_HEADER_MOBILE.lnk_switch_language}
    ...    AND    Click Element    ${XPATH_HEADER_MOBILE.lnk_switch_language}

Header - Click Switch Language
    Wait Until Element Is Visible    ${XPATH_HEADER_MOBILE}

Verify Chat Online Link Display
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button} img
    Selenium2Library.Get Element Attribute And Should Be Equal    ${chat_online_button} img@src    ${protocol}://support.itruemart.com/application/images/icn/chat-on.png
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("แชทออนไลน์")

Verify Chat Online iFrame Display
    ${src_iframe_chat_online}    Selenium2Library.Get Element Attribute    ${chat_online_iframe}@src
    Should Contain    ${src_iframe_chat_online}    http://support.itruemart.com/scripts/generateWidget.php?v=4.28.0.7
    Should Contain    ${src_iframe_chat_online}    &cwid=713acad1&cwt=onlineform&ie=-1&pt=iTrueMart.com%20-%20%E0%B8%9C%E0%B9%88%E0%B8%AD%E0%B8%990%20%E0%B8%A1%E0%B8%B7%E0%B8%AD%E0%B8%96%E0%B8%B7%E0%B8%AD%20iphone%20samsung%20%E0%B9%81%E0%B8%97%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%A5%E0%B9%87%E0%B8%95%20%E0%B8%AA%E0%B8%A1%E0%B8%B2%E0%B8%A3%E0%B9%8C%E0%B8%97%E0%B9%82%E0%B8%9F%E0%B8%99%20gadget#http%3A%2F%2Fwww.itruemart-dev.com%2F
    # Select Frame    ${chat_online_iframe}
    # Unselect Frame

Verify iTM Logo
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${itm_logo_img}
    ${href_itm_logo_link}    Selenium2Library.Get Element Attribute    ${itm_logo_link}@href
    ${src_itm_logo_img}    Selenium2Library.Get Element Attribute    ${itm_logo_img}@src
    ${itm_logo_image_path}=    Replace String    ${itm_logo_image_path}    http    ${protocol}
    Should Be Equal As Strings    ${href_itm_logo_link}    ${ITM_URL}/
    # Should Be Equal As Strings    ${src_itm_logo_img}    ${itm_logo_image_path}
    Should Contain    ${src_itm_logo_img}    ${itm_logo_image_path}

Verify Search Box Exist
    Not Visible Then If Failed Wait and Check Is Visible Again    ${itm_search_box}

Verify Autosuggestion
    [Arguments]    ${search_text}
    Input Text    ${itm_search_box}    ${search_text}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${itm_suggestion_box}

Verify Search Text Box and Page Will Redirect to Search Page
    [Arguments]    ${search_text}
    Location Should Contain    search2?q=${search_text}
    Get Value And Should Be Equal    ${itm_search_box}    ${search_text}

Verify Everyday Wow Banner
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${everyday_wow_img}
    ${href_wow_logo_link}    Selenium2Library.Get Element Attribute    ${everyday_wow_link}@href
    ${src_wow_logo_img}    Selenium2Library.Get Element Attribute    ${everyday_wow_img}@src
    ${everday_wow_logo_img_path}=    Replace String    ${everday_wow_logo_img_path}    http    ${protocol}
    Should Be Equal As Strings    ${href_wow_logo_link}    ${ITM_URL}/everyday-wow
    Should Be Equal As Strings    ${src_wow_logo_img}    ${everday_wow_logo_img_path}

Verify Language Button
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${language_button}
    Wait Until Page Contains Element    ${TH_language_link}    3s
    Wait Until Page Contains Element    ${EN_language_link}    3s
    ${src_TH_language_img}    Selenium2Library.Get Element Attribute    ${TH_language_img}@src
    ${src_EN_language_img}    Selenium2Library.Get Element Attribute    ${EN_language_img}@src
    ${TH_lang_img_path}=    Replace String    ${TH_lang_img_path}    http    ${protocol}
    ${EN_lang_img_path}=    Replace String    ${EN_lang_img_path}    http    ${protocol}
    Should Contain    ${src_TH_language_img}    ${TH_lang_img_path}
    Should Contain    ${src_EN_language_img}    ${EN_lang_img_path}

Verify Switch to EN
    [Arguments]    ${url_path}    ${protocol}
    Check Location Contain    /en${url_path}    ${protocol}
    Get Text And Should Be Equal    ${language_label} span    Language

Verify Switch to TH
    [Arguments]    ${url_path}    ${protocol}
    Check Location Contain    ${url_path}    ${protocol}
    Get Text And Should Be Equal    ${language_label} span    ภาษา

Verify Register and Login Link Display
    Wait Until Element Is Visible    ${register_link}
    Wait Until Element Is Visible    ${login_link}

Verify Register and Login Link Not Display
    Wait Until Element Is Not Visible    ${register_link}
    Wait Until Element Is Not Visible    ${login_link}

Verify User Display Name
    [Arguments]    ${expected_user_display_name}
    Get Text And Should Be Equal    ${user_name_label}    ${expected_user_display_name}

Verify Mega Menu Section Display
    Wait Until Element Is Visible    ${mega_menu_section}    5s

Verify Mega Menu Section Not Display
    Wait Until Element Is Not Visible    ${mega_menu_section}    5s

Verify Menu Bar Display
    Wait Until Element Is Visible    ${menu_bar_section}    3s
    Get Text And Should Be Equal    ${menu_bar_section} li:eq(0) a    ประเภทสินค้า
    Get Text And Should Be Equal    ${menu_bar_section} li:eq(1) a    ผ่อน 0%
    Get Text And Should Be Equal    ${menu_bar_section} li:eq(2) a    ลดล้างสต๊อก
    Get Text And Should Be Equal    ${menu_bar_section} li:eq(3) a    มือถือ และ แท็บเล็ต
    Get Text And Should Be Equal    ${menu_bar_section} li:eq(4) a    ย้ายค่ายเบอร์เดิม

Verify Cart icon Do Not Show
    Wait Until Element Is Not Visible    ${cart_icon}    5s
    Wait Until Element Is Not Visible    ${cart_quantity_badge}    5s

Check Location Contain
    [Arguments]    ${full_url}    ${protocol}
    ${full_url}=    Replace String    ${full_url}    http    ${protocol}
    Location Should Contain    ${full_url}

Check Cart Badge Quantity
    [Arguments]    ${cart_quantity}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${cart_icon}
    ${result}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${cart_quantity_badge}:contains("${cart_quantity}")    5s
    Run Keyword If    ${result} == False    Sleep    5s
    Wait Until Page Contains Element    ${cart_quantity_badge}:contains("${cart_quantity}")    10s
    # Get Text And Should Be Equal    ${cart_quantity_badge}    ${cart_quantity}

Get Text And Should Be Equal
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}    Get Text    ${locator}
    Should Be Equal As Strings    ${expected_text}    ${actual_text}

Get Value And Should Be Equal
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}    Get Value    ${locator}
    Should Be Equal As Strings    ${expected_text}    ${actual_text}

Selenium2Library.Get Element Attribute And Should Be Equal
    [Arguments]    ${attribute_locator}    ${expected_data}
    ${actual_data}    Selenium2Library.Get Element Attribute    ${attribute_locator}
    Should Be Equal As Strings    ${actual_data}    ${expected_data}

Header - Wemall Logo Is Displayed
    Wait Until Page Contains Element    ${XPATH_HEADER.div_logo_container}    60s
    Wait Until Element Is Visible    ${XPATH_HEADER.div_logo_container}    60s
    #Element Should Be Visible    ${XPATH_HEADER.div_logo_container}

Header - Wemall Header Is Displayed
    Wait Until Element Is Visible    ${XPATH_HEADER.div_header_container}    ${CHECKOUT_TIMEOUT}

Header - Wemall Search Box Is Displayed
    Wait Until Element Is Visible    ${XPATH_HEADER.txt_search}    ${CHECKOUT_TIMEOUT}
    #Element Should Be Visible    ${XPATH_HEADER.txt_search}

Header - Wemall Navigator Is Displayed
    Wait Until Element Is Visible    ${XPATH_HEADER.div_navigator}    ${CHECKOUT_TIMEOUT}
    #Element Should Be Visible    ${XPATH_HEADER.div_navigator}

Header - Wemall Navigator Checkout 1 Is Active
    Wait Until Page Contains Element    ${XPATH_HEADER.div_navigator_checkout1}    60s
    Wait Until Element Is Visible    ${XPATH_HEADER.div_navigator_checkout1}    ${CHECKOUT_TIMEOUT}

Header - Wemall Navigator Checkout 2 Is Active
    Wait Until Page Contains Element    ${XPATH_HEADER.div_navigator_checkout2}    60s
    Wait Until Element Is Visible    ${XPATH_HEADER.div_navigator_checkout2}    ${CHECKOUT_TIMEOUT}

Header - Wemall Navigator Checkout 3 Is Active
    Wait Until Page Contains Element    ${XPATH_HEADER.div_navigator_checkout3}    60s
    Wait Until Element Is Visible    ${XPATH_HEADER.div_navigator_checkout3}    ${CHECKOUT_TIMEOUT}

Header - Wemall Navigator Thankyou Is Active
    Wait Until Page Contains Element    ${XPATH_HEADER.div_navigator_thankyou}    60s
    Wait Until Element Is Visible    ${XPATH_HEADER.div_navigator_thankyou}    ${CHECKOUT_TIMEOUT}

Header - Wemall Should Display User as Guest
    Wait Until Element Is Visible    css=.btn-my-profile    10s
    Wait Until Element Is Visible    css=.icon-user    10s
    ${username}=    Get Text    css=.btn-my-profile .text
    Expected String Equal    ${username}    GUEST

Footer - Wemall Should Display
    Wait Until Element Is Visible    ${XPATH_HEADER.div_footer_container}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_HEADER.div_footer_container}

Header - Wemall Should Display Header And Footer Guest
    Header - Wemall Logo Is Displayed
    Header - Wemall Header Is Displayed
    Header - Wemall Should Display User as Guest
    Footer - Wemall Should Display

Header - Product on Level D
    ${inv_id}=    product.Get Inventory Normal
    Increase Stock By Inventory ID    ${inv_id}    100
    Level D - Open Browser With Any Product

Header - Product on Level D EN
    ${inv_id}=    product.Get Inventory Normal
    Increase Stock By Inventory ID    ${inv_id}    100
    Level D - Open Browser With Any Product EN
    Level D - User Select Sku If Visible And Click Add To Cart Button
    Display Full Cart

Header - User Add to Cart and Go To Checkout 1
    Level D - User Select Sku If Visible And Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart

Header - User Login and Go To Checkout 2
    User Enter Valid Data As Member On Checkout1

Header - User Select Address and Go To Checkout 3
    User Enter Valid Data As Member On Checkout2

Header - User Submit Checkout Button and Go To Thankyou Page
    Checkout3 - Select payment channal    css=.visa
    Checkout3 - Apply CCW    TESTER    5555555555554444    123
    Click Element    css=#step3-submit
    Wait Until Element Is Visible    css=#confirm-payment-submit    15s
    Click Element    css=#confirm-payment-submit

Header - Should Display WeMall Header
    Wait Until Page Contains Element    css=.wm-header    60s
    Wait Until Element Is Visible    css=.wm-header    60s

Header - Should Display WeMall Footer
    Wait Until Page Contains Element    css=.wm-footer-checkout    30s
    Wait Until Element Is Visible    css=.wm-footer-checkout    30s

Header - Should Display WeMall Logo
    Wait Until Page Contains Element    css=.logo-wemall    30s
    Wait Until Element Is Visible    css=.logo-wemall    30s

Header - Should Display User as Guest
    Wait Until Element Is Visible    css=.btn-my-profile    10s
    Wait Until Element Is Visible    css=.icon-user    10s
    ${username}=    Get Text    css=.btn-my-profile .text
    Expected String Equal    ${username}    GUEST

Header - Should Display User as Member
    Wait Until Element Is Visible    css=.btn-my-profile    10s
    Wait Until Element Is Visible    css=.icon-user    10s
    ${username}=    Get Text    css=.btn-my-profile .text
    #Expected String Equal    ${username}    robotautomate
    Expected String Equal    ${username}    robot35

Header - Should Display Checkout Step 1
    Wait Until Element Is Visible    css=.wm-checkout-step-nav.active-step-1

Header - Should Display Checkout Step 2
    Wait Until Element Is Visible    css=.wm-checkout-step-nav.active-step-2

Header - Should Display Checkout Step 3
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.img_nav_checkout3_active}    30s

# ***** Duplicate Keyword With : keywords_common_for_wemall ***** # Date 12/10/2016 [dd/mm/yyyy]
# Not Visible Then If Failed Wait and Check Is Visible Again
#     [Arguments]    ${locator}
#     ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    5s
#     Run Keyword If    ${result} == False    Sleep    1s
# #     #Wait Until Element Is Visible    ${locator}    30s

# Click Then If Failed Wait and Click Again
#     [Arguments]    ${locator}
#     Wait Until Element Is Visible    ${locator}    5s
#     ${result}=    Run Keyword And Return Status    Click Element    ${locator}
#     Run Keyword If    ${result} == False    Sleep    3s
#     Run Keyword If    ${result} == False    Click Element    ${locator}

