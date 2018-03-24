*** Variables ***
${element_header}           .iwm-header
${wm_header}                jquery=${element_header}
${wm_footer}                jquery=#iwm_ct_footer
${chat_online_button}       ${wm_header} .btn-chat.float-left
${login_button}             ${wm_header} .btn-my-profile
${login_label}              ${login_button} .text
${member_box}               ${wm_header} .list-menu-login
${user_profile_link}        ${member_box} li a[ng-click="profile()"]
${order_history_link}       ${member_box} li a[ng-click="orderview()"]
${member_coupon_link}       ${member_box} li a[ng-click="newUserCoupon()"]
${logout_link}              ${member_box} li a[ng-click="logout()"]
${payment_status_link}      ${wm_header} .link-check-payment-order-status
${everyday_wow_link}        ${wm_header} .btn-wow
${everyday_wow_img}         ${everyday_wow_link} img
${wm_logo_link}             ${wm_header} .main-menu .float-left
${wm_logo_img}              ${wm_logo_link} img
${language_button}          ${wm_header} .btn-select-lang
${language_dropdown}        //a[@data-toggle="dropdown"]
${EN_switch_link}           //li[@ng-class="{'active':currentLang=='en'}"]/a[@href="/en/itruemart/"]
${TH_language_link}         ${language_button} .dropdown-menu li a[data-lang='th']:not('.ng-hide')
${EN_language_link}         ${language_button} .dropdown-menu li a[data-lang='en']:not('.ng-hide')
${language_label}           ${wm_header} .btn-select-lang a:eq(0)
${wm_search_box}            ${wm_header} .input-wrapper.search .search-input-box
${wm_suggestion_box}        ${wm_header} .input-wrapper.search .angucomplete-dropdown
${search_button}            ${wm_header} .input-wrapper.search .btn-search.icon-search
${cart_icon}                ${wm_header} .main-menu-container .btn-cart
${cart_quantity_badge}      ${cart_icon} .icon-cart
${menubars_div}             ${wm_header} .category-menu ul.ng-isolate-scope
${categories_button}        ${wm_header} .category-menu .btn-cetagory
${mega_menus_box}           ${wm_header} .white.mega-menu.ng-isolate-scope
${cart_light_box}           jquery=#cart-box-info
${levelD_header_btn}        jquery=.btn-cetagory-mini

&{XPATH_WM_HEADER}   lnk_login=//span[contains(text(), "บัญชีของฉัน")]
 ...  lnk_logged_in=//span[@ng-if="login"]
 ...  lnk_profile_sub_menu=//div[@class="btn-my-profile last-menu active"]
 ...  lnk_profile=//*[@ng-click="profile()"]