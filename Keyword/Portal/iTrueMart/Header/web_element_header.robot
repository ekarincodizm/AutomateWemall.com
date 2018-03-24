*** Variables ***
&{XPATH_HEADER}   lnk_login=//span[contains(text(), "บัญชีของฉัน")]
 ...  lnk_login_wm=//div[@class="btn-my-profile last-menu"]
 ...  img_itm_logo=//div[@class="header__logo"]/a
 ...  img_itm_logo_checkout=//img[contains(@src, "assets/images/logo.png")]
 ...  ico_cart=//span[@id="icn_cart_id"]
 ...  display_name=//div[contains(@class, "auth-loggedin")]/a
 ...  profile_sub_menu=//div[contains(@class, "auth-loggedin")]/ul[1]/li[2]/a
 ...  div_header_container=//div[@class="wm-header"]
 ...  div_logo_container=//div[@class="wm-header"]/div[@class="wm-container"]/div[@class="col-logo"]
 ...  div_navigator_checkout1=//div[contains(@class, "active-step-1")]
 ...  div_navigator_checkout2=//div[contains(@class, "active-step-2")]
 ...  div_navigator_checkout3=//div[contains(@class, "active-step-3")]
 ...  div_navigator_thankyou=//div[contains(@class, "active-step-4")]
 ...  div_wm_header_login_name_container=//div[contains(@class, "btn-my-profile")]/div/span[2]
 ...  lnk_logged_in=//span[@ng-if="login"]
 ...  lnk_profile_sub_menu=//div[@class="btn-my-profile last-menu active"]
 ...  lnk_profile=//*[@ng-click="profile()"]

&{XPATH_HEADER_MOBILE}      lnk_login=//a[@data-user-detail]
 ...  lnk_switch_language=//a[@data-id="switch-language-icon"]
 ...  lnk_header_menu_wm=//*[contains(@class, "btn-side-menu")]
 ...  lnk_switch_thai_wm=//a[@id="btn-thai-lang"]
 ...  lnk_switch_eng_wm=//a[@id="btn-en-lang"]


${chat_online_button}       jquery=.header__contact
${chat_online_iframe}       jquery=iframe:eq(4)
${itm_logo_link}            jquery=.header__logo a[title='iTruemart']
${itm_logo_img}             jquery=.header__logo a[title='iTruemart'] img
${itm_search_box}           jquery=#search-text
${itm_suggestion_box}       jquery=#suggest-result
${search_button}            jquery=.btn_search
${everyday_wow_link}        jquery=a.header__nav_banner.ec-promotion
${everyday_wow_img}         jquery=a.header__nav_banner.ec-promotion img
${language_button_itm}      jquery=#language
${language_button_wm}       //div[contains(@class, "btn-select-lang float-right")]
${language_button}          jquery=#language
${language_label}           jquery=.header__box_misc
${TH_language_link}         ${language_label} li:eq(0) a
${TH_language_img}          ${language_label} li:eq(0) img
${EN_language_link}         ${language_label} li:eq(1) a
${EN_language_link_itm}		${language_label} li:eq(1) a
${EN_language_link_wm}      ${language_button_wm}/div/ul

${EN_language_img}          ${language_label} li:eq(1) img
${register_link}            ${language_label} [alt="register"]
${login_link}               ${language_label} [alt="login"]
${user_name_label}          jquery=.header__box_login #user
${user_profile_dropdown}    jquery=.dropdown-menu[aria-labelledby="user"]
${user_profile_link}        ${user_profile_dropdown} a[href$="/member/profile"]
${order_history_link}       ${user_profile_dropdown} a[href$="/member/orders"]
${new_memeber_coupon_link}  ${user_profile_dropdown} li:eq(2)
${logout_link}              ${user_profile_dropdown} a[href$="/auth/logout"]
${mega_menu_button}         jquery=.header__inner_wrapper .header__nav_container li:eq(0) a
${mega_menu_section}        jquery=.header__inner_wrapper .sidebar_1
${menu_bar_section}         jquery=.header__bar_nav .header__nav_container
${cart_box_button}          jquery=.header__box_cart
${cart_icon}                jquery=#icn_cart_id
${cart_quantity_badge}      ${cart_icon} .icn_cart_amount.cart-quantity
