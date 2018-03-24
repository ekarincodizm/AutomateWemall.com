*** Settings ***
Library           String
Library           OperatingSystem
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource          ${CURDIR}/../../iTrueMart/Login/web_element_login.robot
Resource          ${CURDIR}/webelement_wemall_header.robot
Resource          ${CURDIR}/../keywords_common_for_wemall.robot

*** Variables ***
${everday_wow_logo_img_path}    http://alpha-cdn.wemall-dev.com/th/content/16560266-b2a3-4f26-9d38-2229018e59e2_web_images/everyday-wow-iwm.png?v=91386d91
${wm_logo_image_path}    //cdn.wemall-dev.com/th/wemall/wemall/logo-wemall-portal@x.png?v=6a19c920

*** Keywords ***
Go to Specific URL
    [Arguments]    ${full_url}
    Go to    ${full_url}
    Wait Until Element Is Visible    ${wm_logo_link}    30s
    # Wait Until Element Is Visible    ${chat_online_button}:contains("แชทออนไลน์")    30s

Click Everyday Wow Logo
    Click Then If Failed Wait and Click Again    ${everyday_wow_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    jquery=#superdeal

Click WeMall Logo
    Click Then If Failed Wait and Click Again    ${wm_logo_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${wm_logo_img}

Switch to TH Language
    Not Visible Then If Failed Wait and Check Is Visible Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${TH_language_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("แชทออนไลน์")

Switch to EN Language
    Not Visible Then If Failed Wait and Check Is Visible Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${language_button}
    Click Then If Failed Wait and Click Again    ${EN_language_link}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("Online chat")

Click Search Button
    Click Then If Failed Wait and Click Again    ${search_button}

Click My Account Link
    keywords_common_for_wemall.Not Visible Then If Failed Wait and Check Is Visible Again    ${login_button}
    keywords_common_for_wemall.Click Then If Failed Wait and Click Again    ${login_button}
    keywords_common_for_wemall.Not Visible Then If Failed Wait and Check Is Visible Again    ${XPATH_LOGIN.txt_username}

Click My Account To Login
    Wait Until Page Contains Element    //span[@ng-click="sendLogin()"]
    Click Element and Wait Angular Ready    ${login_button}

Mouse Over on My Account
    Mouse Over    ${login_button}

Mouse Over On Hamburger
    Mouse Over    ${levelD_header_btn}

Click Hambergur
    Click Element and Wait Angular Ready    ${levelD_header_btn}

Click User Profile Link
    Mouse Over on My Account
    Click Then If Failed Wait and Click Again    ${user_profile_link}

Click Order History Link
    Mouse Over on My Account
    Click Then If Failed Wait and Click Again    ${order_history_link}

Click New Member Coupon Link
    Mouse Over on My Account
    Click Then If Failed Wait and Click Again    ${member_coupon_link}

Click Log Out Link
    # Mouse Over on My Account
    # keywords_common_for_wemall.Click Then If Failed Wait and Click Again    ${logout_link}
    # keywords_common_for_wemall.Not Visible Then If Failed Wait and Check Is Visible Again    ${login_button}
    Mouse Over on My Account
    ${logout_link_visible}=    Run Keyword And Return Status    keywords_common_for_wemall.Click Then If Failed Wait and Click Again    ${logout_link}
    Run Keyword If    '${logout_link_visible}' == 'False'     Execute Javascript    $('.iwm-header .list-menu-login li a[ng-click="logout()"]').click()
    keywords_common_for_wemall.Not Visible Then If Failed Wait and Check Is Visible Again    ${login_button}

Click Order and Payment status Checking Link
    Click Then If Failed Wait and Click Again    ${payment_status_link}

Check Location Contain
    [Arguments]    ${full_url}    ${protocol}
    ${full_url}=    Replace String    ${full_url}    http    ${protocol}
    Location Should Contain    ${full_url}

Click Categories Button
    Click Then If Failed Wait and Click Again    ${categories_button}

Click Cart Box Button
    Click Then If Failed Wait and Click Again    ${cart_icon} a
    Not Visible Then If Failed Wait and Check Is Visible Again    ${cart_light_box}
    Wait Until Page Does Not Contain Element    ${cart_light_box}:contains("กำลังโหลดรายการ...")    30s

Click Cart Box Button_keywords_wemall_header
    Click Then If Failed Wait and Click Again    ${cart_icon} a
    Not Visible Then If Failed Wait and Check Is Visible Again    ${cart_light_box}
    Wait Until Page Does Not Contain Element    ${cart_light_box}:contains("กำลังโหลดรายการ...")    30s

Search Product in WeMall
    [Arguments]    ${search_text}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${wm_search_box}
    Input Text    ${wm_search_box}    ${search_text}
    Click Search Button

Login User to WeMall
    [Arguments]    ${username}    ${password}
    Click My Account Link
    Wait Until Element Is Visible    ${XPATH_LOGIN.txt_username}    15s
    Location Should Contain    /auth/login
    Input Text    ${XPATH_LOGIN.txt_username}    ${username}
    Wait Until Element Is Visible    ${XPATH_LOGIN.txt_password}    15s
    Input Text    ${XPATH_LOGIN.txt_password}    ${password}
    Wait Until Element Is Visible    ${XPATH_LOGIN.btn_login}    15s
    Click Element and Wait Angular Ready    ${XPATH_LOGIN.btn_login}
    Sleep    1s

Display Wemall Header And Footer
    Wait Until Element Is Visible    ${wm_header}
    Wait Until Element Is Visible    ${wm_footer}
    Page Should Contain Element    ${wm_header}
    Page Should Contain Element    ${wm_footer}

Verify Login Link Display As Not Login
    Not Visible Then If Failed Wait and Check Is Visible Again    ${login_label}:contains("บัญชีของฉัน")
    Selenium2Library.Get Element Attribute And Should Be Equal    ${login_label}@ng-if    !login
    Verify Member Box is Not Display

Verify Member Box is Not Display
    Mouse Over on My Account
    Wait Until Element Is Not Visible    ${member_box}
    Wait Until Element Is Not Visible    ${user_profile_link}
    Wait Until Element Is Not Visible    ${order_history_link}
    Wait Until Element Is Not Visible    ${member_coupon_link}
    Wait Until Element Is Not Visible    ${logout_link}

Verify Login Link Display As Member
    Wait Until Element Is Not Visible    ${login_label}:contains("บัญชีของฉัน")    10s
    Selenium2Library.Get Element Attribute And Should Be Equal    ${login_label}@ng-if    login

Verify User Display Name
    [Arguments]    ${expected_user_display_name}
    Get Text And Should Be Equal    ${login_label}    ${expected_user_display_name}

Verify Everyday Wow Banner
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${everyday_wow_img}
    ${ng-src_wow_logo_img}    Selenium2Library.Get Element Attribute    ${everyday_wow_img}@ng-src
    ${src_wow_logo_img}    Selenium2Library.Get Element Attribute    ${everyday_wow_img}@src
    ${everday_wow_logo_img_path}=    Replace String    ${everday_wow_logo_img_path}    http    ${protocol}
    Should Be Equal As Strings    ${ng-src_wow_logo_img}    ${everday_wow_logo_img_path}
    Should Be Equal As Strings    ${src_wow_logo_img}    ${everday_wow_logo_img_path}

Verify Wow Logo Display
    Element Should Be Visible    jquery=img.logo[src="${everday_wow_logo_img_path}"]

Verify WeMall Logo
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${wm_logo_img}
    ${src_wm_logo_img}    Selenium2Library.Get Element Attribute    ${wm_logo_img}@ng-src
    ${wm_logo_image_path}=    Replace String    ${wm_logo_image_path}    http    ${protocol}
    Should Be Equal As Strings    ${src_wm_logo_img}    ${wm_logo_image_path}

Verify Chat Online Link Display
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button} .icon-bubble
    Not Visible Then If Failed Wait and Check Is Visible Again    ${chat_online_button}:contains("แชทออนไลน์")

Verify Language Button
    [Arguments]    ${protocol}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${language_button}
    Wait Until Page Contains Element    ${TH_language_link}    3s
    Wait Until Page Contains Element    ${EN_language_link}    3s

Verify Switch to EN
    [Arguments]    ${url_path}    ${protocol}
    Check Location Contain    /en${url_path}    ${protocol}
    Get Text And Should Be Equal    ${language_label}    เปลี่ยนภาษา

Verify Switch to TH
    [Arguments]    ${url_path}    ${protocol}
    Check Location Contain    ${url_path}    ${protocol}
    Get Text And Should Be Equal    ${language_label}    select language

Verify Search Box Exist
    Not Visible Then If Failed Wait and Check Is Visible Again    ${wm_search_box}

Verify Autosuggestion
    [Arguments]    ${search_text}
    Input Text    ${wm_search_box}    ${search_text}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${wm_suggestion_box}

Verify Search Text Box and Page Will Redirect to Search Page
    [Arguments]    ${search_text}
    Location Should Contain    search2?q=${search_text}
    Get Value And Should Be Equal    ${wm_search_box}    ${search_text}

Check Cart Badge Quantity
    [Arguments]    ${cart_quantity}
    Not Visible Then If Failed Wait and Check Is Visible Again    ${cart_icon}
    Wait Until Page Contains Element    ${cart_quantity_badge}[data-noti-number="${cart_quantity}"]    20s

Verify Menu Bar Display
    [Arguments]    ${json_data_file}    ${locator}
    Verify Menu Bar Text from Json File    ${json_data_file}    ${locator}
    Verify Menu Bar Link from Json File    ${json_data_file}
    Verify Menu Bar Target from Json File    ${json_data_file}

Verify Menu Bar Text from Json File
    [Arguments]    ${json_data_file}    ${locator}
    ${json_data}=    Get File    ${json_data_file}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/0/title
    Get Text And Should Be Equal    ${menubars_div} li:eq(0) a    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/1/title
    Get Text And Should Be Equal    ${menubars_div} li:eq(1) a    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/2/title
    Get Text And Should Be Equal    ${menubars_div} li:eq(2) a    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/3/title
    # Get Text And Should Be Equal    ${menubars_div} li:eq(3) a    ${expected_data}
    ${status}   ${value} =  Run Keyword And Ignore Error    Get Text And Should Be Equal    ${menubars_div} li:eq(3) a    ${expected_data}
    Run Keyword If  '${status}' == 'FAIL'    Check Menu Bar Text Reponsive    ${locator}    ${expected_data}

Verify Menu Bar Link from Json File
    [Arguments]    ${json_data_file}
    ${json_data}=    Get File    ${json_data_file}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/0/link_url
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(0) a@href    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/1/link_url
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(1) a@href    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/2/link_url
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(2) a@href    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/3/link_url
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(3) a@href    ${expected_data}

Verify Menu Bar Target from Json File
    [Arguments]    ${json_data_file}
    ${json_data}=    Get File    ${json_data_file}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/0/link_target
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(0) a@target    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/1/link_target
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(1) a@target    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/2/link_target
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(2) a@target    ${expected_data}
    ${expected_data}=    Get Value from Json Node    ${json_data}    /th_TH/3/link_target
    Selenium2Library.Get Element Attribute And Should Be Equal    ${menubars_div} li:eq(3) a@target    ${expected_data}

Verify Mega Menu Not Display
    Wait Until Element Is Not Visible    ${mega_menus_box}

Verify Mega Menu Display
    Not Visible Then If Failed Wait and Check Is Visible Again    ${mega_menus_box}

Header - User Click Login Link
    Wait Until Page Contains Element   ${XPATH_WM_HEADER.lnk_login}   ${TIMEOUT}
    Click Element and Wait Angular Ready   ${XPATH_WM_HEADER.lnk_login}

Header - User Move Mouse Over Link Profile
    Wait Until Page Contains Element    ${XPATH_WM_HEADER.lnk_logged_in}   ${TIMEOUT}
    Mouse Over   ${XPATH_WM_HEADER.lnk_logged_in}

Header - Profile Sub Menu Is Displayed
    Wait Until Page Contains Element  ${XPATH_WM_HEADER.lnk_profile_sub_menu}  ${TIMEOUT}
    Wait Until Element Is Visible   ${XPATH_WM_HEADER.lnk_profile_sub_menu}  ${TIMEOUT}
    Element Should Be Visible  ${XPATH_HEADER.lnk_profile_sub_menu}

Header - User Click Link Profile
    Wait Until Page Contains Element  ${XPATH_WM_HEADER.lnk_profile}   ${TIMEOUT}
    Wait Until Element Is Visible   ${XPATH_WM_HEADER.lnk_profile}  ${TIMEOUT}
    Click Element and Wait Angular Ready   ${XPATH_WM_HEADER.lnk_profile}

Check Menu Bar Text Reponsive
    [Arguments]    ${locator}    ${expected_data}
    Wait Until Element Is Visible    //*[@id="portal-menu-bars-dropdown"]   ${TIMEOUT}
    Click Element    //*[@id="portal-menu-bars-dropdown"]
    Wait Until Element Is Visible    ${locator}   ${TIMEOUT}
    ${actual_text}    Get Text    ${locator}
    Should Be Equal    ${actual_text}    ${expected_data}

Check Location Contain HTTPS
    [Arguments]    ${full_url}    ${protocol}
    ${full_url}=    Replace String    ${full_url}    https    ${protocol}
    Location Should Contain    ${full_url}
