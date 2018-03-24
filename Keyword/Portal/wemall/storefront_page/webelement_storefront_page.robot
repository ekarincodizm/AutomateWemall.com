*** Variables ***
${BUTTON_CART}                   css=.btn-cart
${MICROCART_BOX}                 css=.cart-box
${LOGO_ITRUEMART}                css=img[src="/images/logo/logo-itruemart.png"]
${MICROCART_BOX_ACCTIVE}         css=.cart-box.active
${LOGIN_BOX_ACCTIVE}             css=.btn-my-profile.active
${MEGAMENU_HAMBURGER}            css=.btn-cetagory-mini
${BUTTON_MY_PROFILE}             css=.btn-my-profile
${ITM_USERNAME_INPUT}            css=#login_username
${ITM_PASSWORD_INPUT}            css=#login_password
${ITM_BUTTON_LOGIN}              css=#btn_login
${PROFILE_LINK}                  css=.list-menu-login a[ng-click="profile()"]
${MY_ORDER_LINK}                 css=.list-menu-login a[ng-click="orderview()"]
${LOGOUT_LINK}                   css=.list-menu-login a[ng-click="logout()"]
${COUPON_LINK}                   css=.list-menu-login a[ng-click="newUserCoupon()"]
${DISPLAY_NAME_TEXT}             css=.btn-my-profile > div > span[ng-if="login"]
${LANGUAGE_BAR}                  css=.btn-select-lang
${PRIMARY_LANGUAGES_BUTTON}      jquery=.btn-select-lang a.btn-lang:eq(0)
${SECONDARY_LANGUAGES_BUTTON}    jquery=.btn-select-lang a.btn-lang:eq(1)
${CART_BADGE}                    jquery=span.icon-cart@data-noti-number
${SEARCH_BUTTON}                 css=.btn-search
${SEARCH_INPUT}                  css=.input-wrapper.search > input
${ITM_SEARCH_TEXT}               css=#mi-searchCount > b
${SEARCH_DROPDOWN}               jquery=.angucomplete-dropdown
${MENU_LOGO_LINK}                li.brand-name a
${MENU_LV1}                      [data-menu='1']
${MENU_LV2}                      [data-menu='2']
${MENU_LV1_HAS_CHILD}            li.sub a span[data-menu="1"]
${PAGE_ALIAS}                    storefront
${MENU_NAV}                      jquery=#store-vendor-nav
${secondary_language}            /en
${noscript}                      $('noscript')
${banner_storefront_index}       jquery=.wm-store-highlight-banner.ng-isolate-scope .owl-item:not(.cloned)
${banner_carousel_dot}           jquery=.wm-store-highlight-banner.ng-isolate-scope div.owl-dots

${element_header}           .iwm-header
${wm_header}                jquery=${element_header}
# ${wm_footer}                jquery=#iwm_ct_footer
${chat_online_button}       ${wm_header} .btn-chat.float-left
${language_button}          ${wm_header} .btn-select-lang
# ${language_dropdown}        //a[@data-toggle="dropdown"]
# ${EN_switch_link}           //li[@ng-class="{'active':currentLang=='en'}"]/a[@href="/en/itruemart/"]
${TH_language_link}         ${language_button} .dropdown-menu li a[data-lang='th']:not('.ng-hide')
${EN_language_link}         ${language_button} .dropdown-menu li a[data-lang='en']:not('.ng-hide')