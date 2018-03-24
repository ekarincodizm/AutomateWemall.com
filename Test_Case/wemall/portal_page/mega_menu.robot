# *** Settings ***
# Library           Selenium2Library
# Library           ${CURDIR}/../../../Python_Library/ExtendedSelenium/
# Resource          ${CURDIR}/../../../Resource/init.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/megamenus_keywords.robot
# #Resource         ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
# Resource          ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot

# Suite Setup       Open Wemall Page
# Suite Teardown    Close All Browsers And Restore Mega Menu
# Test Setup        Prepare Data and Open Page

# *** Variables ***
# ${wow_url}                  http://www.itruemart.com/everyday-wow
# ${category_url_page}        /category/mobile-tablet-accessories-3713634511853.html
# ${pagenotfound_url_page}    /pagenotfound
# ${wow_url_page}             /everyday-wow
# ${search_url_page}          /search2
# ${brand_url_page}           /brand/true-store-6623709521879.html
# ${login_url_page}           /auth/login
# ${register_url_page}        /users/register
# ${forgot_password_url}      /forgot_password
# ${lvld_url}                 /products/ipad-mini-wi-fi-2345442496456.html
# ${shop_url_page}            /shop/itm
# ${GLOBAL_MEGAMENU_TYPE}     1
# ${OWL_CAROSEL_VERSION}      2
# ${menu_id}                  portal
# ${lang_th}                  th_TH
# ${lang_en}                  en_US
# ${fix_menu_index}           7
# ${carousel_menu_index}      8
# ${fix_template_id}          1
# ${carousel_template_id}     2
# ${visible_check}            1
# ${visible_uncheck}          0
# ${draft_version}            draft

# ${main_megamenu_path}              ${CURDIR}/../../../Resource/TestData/portals/mega_menus/mega_menu.json
# ${showroom_carousel_data2_path}         ${CURDIR}/../../../Resource/TestData/portals/mega_menus/showroom_data2.json
# ${showroom_carousel_data3_path}              ${CURDIR}/../../../Resource/TestData/portals/mega_menus/showroom_data3.json
# ${showroom_carousel_data4_path}              ${CURDIR}/../../../Resource/TestData/portals/mega_menus/showroom_data4.json
# ${showroom_carousel_data5_path}              ${CURDIR}/../../../Resource/TestData/portals/mega_menus/showroom_data5.json

# ${showroom_image_data_path_th}          ${CURDIR}/../../../Resource/TestData/portals/mega_menus/image_data_th.json
# ${showroom_image_data_path_en}          ${CURDIR}/../../../Resource/TestData/portals/mega_menus/image_data_en.json

# ${showroom_image_data_folder_th}        ${CURDIR}/../../../Resource/TestData/portals/mega_menus/banners/th
# ${showroom_image_data_folder_en}        ${CURDIR}/../../../Resource/TestData/portals/mega_menus/banners/en

# ${banner_image_th_1}            //cdn.wemall-dev.com/th/showrooms/showroom_id/Screen Shot 2558-09-24 at 19.19.44.png
# ${banner_image_en_1}            //cdn.wemall-dev.com/th/showrooms/showroom_id/Screen Shot 2558-09-24 at 19.19.44.png
# ${banner_link_th_1}             link_url_1
# ${banner_link_en_1}             link_url_1

# ${banner_image_th_2}            //cdn.wemall-dev.com/th/showrooms/showroom_id/a7.png
# ${banner_image_en_2}            //cdn.wemall-dev.com/th/showrooms/showroom_id/a7.png
# ${banner_link_th_2}             link_url_2
# ${banner_link_en_2}             link_url_2

# ${banner_image_th_3}            //cdn.wemall-dev.com/th/showrooms/showroom_id/a8.png
# ${banner_image_en_3}            //cdn.wemall-dev.com/th/showrooms/showroom_id/a8.png
# ${banner_link_th_3}             link_url_3
# ${banner_link_en_3}             link_url_3

# ${ITM_OWL}                       1
# ${WM_OWL}                        2

# *** Keywords ***
# Prepare Data and Open Page
#     Update Mega Menu Child Data     ${menu_id}      ${main_megamenu_path}      draft
#     Publish Mega Menu Data          ${menu_id}

# Open Wemall Page
#     Open Wemall Browser
#     Set Window Size    ${1440}    ${900}

# Close All Browsers And Restore Mega Menu
#     Update Mega Menu Child Data     ${menu_id}      ${main_megamenu_path}      draft
#     Publish Mega Menu Data          ${menu_id}
#     Close All Browsers

# *** Test Cases ***
# TC_WMALL_01316-01322 - Flip mega menu on/off [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Flip mega menu on/off                          ${WEMALL_WEB}
#     [EN] Flip mega menu on/off                          ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Mega menu showroom - carousel have 1 banner [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Mega menu showroom - carousel have 1 banner     ${WEMALL_WEB}
#     [EN] Mega menu showroom - carousel have 1 banner     ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${WEMALL_WEB}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Mega menu showroom - carousel switch image [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Mega menu showroom - carousel switch image      ${WEMALL_WEB}
#     [EN] Mega menu showroom - carousel switch image      ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Mega menu level 1 display on portal page [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Mega menu level 1 display on portal page        ${WEMALL_WEB}
#     [EN] Mega menu level 1 display on portal page        ${WEMALL_WEB}


# TC_WMALL_01316-01322 - Mega menu level 2 display on portal page [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Mega menu level 2 display on portal page        ${WEMALL_WEB}
#     [EN] Mega menu level 2 display on portal page        ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Mega menu showroom banner display on portal page [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Mega menu showroom banner display on portal page       ${WEMALL_WEB}
#     [EN] Mega menu showroom banner display on portal page       ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Click link menu level 1 action [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Click link menu level 1 action     ${WEMALL_WEB}
#     [EN] Click link menu level 1 action     ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Click link menu level 2 action [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Click link menu level 2 action     ${WEMALL_WEB}
#     [EN] Click link menu level 2 action     ${WEMALL_WEB}

# TC_WMALL_01316-01322 - Click Link banner action [Wemall Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu    Wemall
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      1
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     [TH] Click Link banner action    ${WEMALL_WEB}
#     [EN] Click Link banner action    ${WEMALL_WEB}

# TC_WMALL_01630-01639 - Flip mega menu on/off [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01630-01639 - Mega menu showroom - carousel have 1 banner [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01630-01639 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01630-01639 - Mega menu showroom - carousel switch image [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01630-01639 - Mega menu level 1 display on portal page [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01630-01639 - Mega menu level 2 display on portal page [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01630-01639 - Mega menu showroom banner display on portal page [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01630-01639 - Click link menu level 1 action [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01630-01639 - Click link menu level 2 action [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01630-01639 - Click Link banner action [Wemall Shop In Shop Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      Wemall    ShopInShop
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${WM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${shop_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01540-01549 - Flip mega menu on/off [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom - carousel have 1 banner [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom - carousel switch image [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01540-01549 - Mega menu level 1 display on portal page [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01540-01549 - Mega menu level 2 display on portal page [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom banner display on portal page [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01540-01549 - Click link menu level 1 action [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01540-01549 - Click link menu level 2 action [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01540-01549 - Click Link banner action [ITM Portal Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPortalPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01540-01549 - Flip mega menu on/off [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom - carousel have 1 banner [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom - carousel switch image [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01540-01549 - Mega menu level 1 display on portal page [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01540-01549 - Mega menu level 2 display on portal page [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01540-01549 - Mega menu showroom banner display on portal page [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01540-01549 - Click link menu level 1 action [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01540-01549 - Click link menu level 2 action [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01540-01549 - Click Link banner action [ITM Category Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMCategoryPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${category_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01550 - Flip mega menu on/off [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01550 - Mega menu showroom - carousel have 1 banner [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01550 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01550 - Mega menu showroom - carousel switch image [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01550 - Mega menu level 1 display on portal page [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01550 - Mega menu level 2 display on portal page [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01550 - Mega menu showroom banner display on portal page [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01550 - Click link menu level 1 action [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01550 - Click link menu level 2 action [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01550 - Click Link banner action [ITM Brand Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMBrandPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${brand_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01560 - Flip mega menu on/off [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01560 - Mega menu showroom - carousel have 1 banner [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01560 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01560 - Mega menu showroom - carousel switch image [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01560 - Mega menu level 1 display on portal page [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01560 - Mega menu level 2 display on portal page [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01560 - Mega menu showroom banner display on portal page [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01560 - Click link menu level 1 action [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01560 - Click link menu level 2 action [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01560 - Click Link banner action [ITM Wow Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMWowPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${wow_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01570 - Flip mega menu on/off [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01570 - Mega menu showroom - carousel have 1 banner [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01570 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01570 - Mega menu showroom - carousel switch image [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01570 - Mega menu level 1 display on portal page [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01570 - Mega menu level 2 display on portal page [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01570 - Mega menu showroom banner display on portal page [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01570 - Click link menu level 1 action [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01570 - Click link menu level 2 action [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01570 - Click Link banner action [ITM Search Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMSearchPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${search_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01580 - Flip mega menu on/off [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01580 - Mega menu showroom - carousel have 1 banner [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01580 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01580 - Mega menu showroom - carousel switch image [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01580 - Mega menu level 1 display on portal page [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01580 - Mega menu level 2 display on portal page [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01580 - Mega menu showroom banner display on portal page [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01580 - Click link menu level 1 action [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01580 - Click link menu level 2 action [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01580 - Click Link banner action [ITM Page Not Found Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMPageNotFoundPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      2
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${pagenotfound_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01590 - Flip mega menu on/off [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01590 - Mega menu showroom - carousel have 1 banner [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01590 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01590 - Mega menu showroom - carousel switch image [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01590 - Mega menu level 1 display on portal page [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01590 - Mega menu level 2 display on portal page [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01590 - Mega menu showroom banner display on portal page [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01590 - Click link menu level 1 action [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01590 - Click link menu level 2 action [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01590 - Click Link banner action [ITM Register Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMRegisterPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${register_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01600 - Flip mega menu on/off [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01600 - Mega menu showroom - carousel have 1 banner [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01600 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01600 - Mega menu showroom - carousel switch image [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01600 - Mega menu level 1 display on portal page [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01600 - Mega menu level 2 display on portal page [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01600 - Mega menu showroom banner display on portal page [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01600 - Click link menu level 1 action [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01600 - Click link menu level 2 action [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01600 - Click Link banner action [ITM Login Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLoginPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${login_url_page}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01610 - Flip mega menu on/off [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01610 - Mega menu showroom - carousel have 1 banner [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01610 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01610 - Mega menu showroom - carousel switch image [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01610 - Mega menu level 1 display on portal page [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01610 - Mega menu level 2 display on portal page [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01610 - Mega menu showroom banner display on portal page [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01610 - Click link menu level 1 action [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01610 - Click link menu level 2 action [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01610 - Click Link banner action [ITM Forgot Password Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMForgotPasswordPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${forgot_password_url}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# TC_WMALL_01620 - Flip mega menu on/off [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}

# TC_WMALL_01620 - Mega menu showroom - carousel have 1 banner [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}

# TC_WMALL_01620 - Mega menu showroom - carousel have more than 1 banners but maximum 15 banners [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}

# TC_WMALL_01620 - Mega menu showroom - carousel switch image [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}

# TC_WMALL_01620 - Mega menu level 1 display on portal page [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}

# TC_WMALL_01620 - Mega menu level 2 display on portal page [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}

# TC_WMALL_01620 - Mega menu showroom banner display on portal page [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}

# TC_WMALL_01620 - Click link menu level 1 action [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}

# TC_WMALL_01620 - Click link menu level 2 action [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}

# TC_WMALL_01620 - Click Link banner action [ITM LevelD Page]
#     [tags]    SanityTest      Regression      Portal      MegaMenu      ITM     ITMLevelDPage
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}      3
#     Set Global Variable     ${OWL_CAROSEL_VERSION}       ${ITM_OWL}
#     ${full_url}=     Set Variable    ${ITM_URL}${lvld_url}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# *** Keyword ***
# Mega Menu All
#     [Arguments]    ${full_url}      ${owl_version}     ${megamenu_type}
#     #Prepair Data
#     Set Global Variable     ${GLOBAL_MEGAMENU_TYPE}    ${megamenu_type}
#     Set Global Variable     ${OWL_CAROSEL_VERSION}     ${owl_version}
#     Update Mega Menu Child Data     ${menu_id}      ${main_megamenu_path}      draft
#     Publish Mega Menu Data          ${menu_id}

#     [TH] Flip mega menu on/off                          ${full_url}
#     [EN] Flip mega menu on/off                          ${full_url}
#     [TH] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [EN] Mega menu showroom - carousel have 1 banner    ${full_url}
#     [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners      ${full_url}
#     [TH] Mega menu showroom - carousel switch image     ${full_url}
#     [EN] Mega menu showroom - carousel switch image     ${full_url}
#     [TH] Mega menu level 1 display on portal page       ${full_url}
#     [EN] Mega menu level 1 display on portal page       ${full_url}
#     [TH] Mega menu level 2 display on portal page       ${full_url}
#     [EN] Mega menu level 2 display on portal page       ${full_url}
#     [TH] Mega menu showroom banner display on portal page       ${full_url}
#     [EN] Mega menu showroom banner display on portal page       ${full_url}
#     [TH] Click link menu level 1 action     ${full_url}
#     [EN] Click link menu level 1 action     ${full_url}
#     [TH] Click link menu level 2 action     ${full_url}
#     [EN] Click link menu level 2 action     ${full_url}
#     [TH] Click Link banner action    ${full_url}
#     [EN] Click Link banner action    ${full_url}

# [TH] Mega menu showroom - carousel have 1 banner
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Mega menu showroom - carousel have 1 banner
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}      ${carousel_template_id}     ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Mouse Over Menu             ${carousel_menu_index}
#     sleep   1s
#     Verify Carousel Banner      ${carousel_menu_index}       1       ${banner_image_th_1}        ${banner_link_th_1}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       2       ${banner_image_th_2}        ${banner_link_th_2}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       3       ${banner_image_th_3}        ${banner_link_th_3}        ${visible_check}
#     sleep   5s
#     Verify Carousel Banner      ${carousel_menu_index}       1       ${banner_image_th_1}        ${banner_link_th_1}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       2       ${banner_image_th_2}        ${banner_link_th_2}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       3       ${banner_image_th_3}        ${banner_link_th_3}        ${visible_check}
#     sleep   5s
#     Verify Carousel Banner      ${carousel_menu_index}       1       ${banner_image_th_1}        ${banner_link_th_1}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       2       ${banner_image_th_2}        ${banner_link_th_2}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       3       ${banner_image_th_3}        ${banner_link_th_3}        ${visible_check}

# [EN] Mega menu showroom - carousel have 1 banner
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Mega menu showroom - carousel have 1 banner
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}      ${carousel_template_id}     ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Mouse Over Menu             ${carousel_menu_index}
#     Verify Carousel Banner      ${carousel_menu_index}       1       ${banner_image_en_1}        ${banner_link_en_1}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       2       ${banner_image_en_2}        ${banner_link_en_2}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       3       ${banner_image_en_3}        ${banner_link_en_3}        ${visible_check}
#     sleep   5s
#     Verify Carousel Banner      ${carousel_menu_index}       1       ${banner_image_en_1}        ${banner_link_en_1}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       2       ${banner_image_en_2}        ${banner_link_en_2}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       3       ${banner_image_en_3}        ${banner_link_en_3}        ${visible_check}
#     sleep   5s
#     Verify Carousel Banner      ${carousel_menu_index}       1       ${banner_image_en_1}        ${banner_link_en_1}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       2       ${banner_image_en_2}        ${banner_link_en_2}        ${visible_check}
#     Verify Fix Banner           ${carousel_menu_index}       3       ${banner_image_en_3}        ${banner_link_en_3}        ${visible_check}

# [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data3_path}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Mouse Over Menu             ${carousel_menu_index}
#     Verify Carousel Banner By File      15      3      ${carousel_menu_index}      ${showroom_image_data_path_th}       ${visible_uncheck}

# [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Mega menu showroom - carousel have more than 1 banners but maximum 15 banners
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data3_path}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Mouse Over Menu             ${carousel_menu_index}
#     Verify Carousel Banner By File      15      3      ${carousel_menu_index}      ${showroom_image_data_path_en}       ${visible_uncheck}

# [TH] Mega menu showroom - carousel switch image
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Mega menu showroom - carousel switch image
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data4_path}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Mouse Over Menu             ${carousel_menu_index}
#     Verify Carousel Banner By File      3      3      ${carousel_menu_index}      ${showroom_image_data_path_th}        ${visible_check}
#     Verify Carousel Banner By File      3      3      ${carousel_menu_index}      ${showroom_image_data_path_th}        ${visible_check}

# [EN] Mega menu showroom - carousel switch image
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Mega menu showroom - carousel switch image
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data4_path}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Mouse Over Menu             ${carousel_menu_index}
#     Verify Carousel Banner By File      3      3      ${carousel_menu_index}      ${showroom_image_data_path_en}        ${visible_check}
#     Verify Carousel Banner By File      3      3      ${carousel_menu_index}      ${showroom_image_data_path_en}        ${visible_check}


# [TH] Mega menu level 1 display on portal page
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Mega menu level 1 display on portal page
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     verify Mega Menu Level 1       ${menu_id}      ${lang_th}

# [EN] Mega menu level 1 display on portal page
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Mega menu level 1 display on portal page
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     verify Mega Menu Level 1       ${menu_id}      ${lang_en}

# [TH] Mega menu level 2 display on portal page
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Mega menu level 2 display on portal page
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     verify Mega Menu Level 2       ${menu_id}      ${lang_th}

# [EN] Mega menu level 2 display on portal page
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Mega menu level 2 display on portal page
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     verify Mega Menu Level 2       ${menu_id}      ${lang_en}

# [TH] Mega menu showroom banner display on portal page
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Mega menu showroom banner display on portal page
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Verify Showroom Banner On Mega Menu       ${menu_id}      ${lang_th}

# [EN] Mega menu showroom banner display on portal page
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Mega menu showroom banner display on portal page
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}           ${carousel_template_id}          ${showroom_carousel_data2_path}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Verify Showroom Banner On Mega Menu       ${menu_id}      ${lang_en}

# [TH] Flip mega menu on/off
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Flip mega menu on/off
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     ${elm}=     Set Variable if
#     ...         '${GLOBAL_MEGAMENU_TYPE}' != '3'     ${mege-menu-icon-button}
#     ...         '${GLOBAL_MEGAMENU_TYPE}' == '3'     ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     Page Should Contain Element    ${mege-menu-element}
#     Click Element and Wait Angular Ready    ${elm}
#     Wait Until Angular Ready    30s
#     Page Should Not Contain Element    ${mege-menu-element}


# [EN] Flip mega menu on/off
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Flip mega menu on/off
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     ${elm}=     Set Variable if
#     ...         '${GLOBAL_MEGAMENU_TYPE}' != '3'     ${mege-menu-icon-button}
#     ...         '${GLOBAL_MEGAMENU_TYPE}' == '3'     ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     Page Should Contain Element    ${mege-menu-element}
#     Click Element and Wait Angular Ready    ${elm}
#     Wait Until Angular Ready    30s
#     Page Should Not Contain Element    ${mege-menu-element}

# [TH] Click link menu level 1 action
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Click link menu level 1 action
#     Prepare Mega Menu Link Lv 1      ${menu_id}      ${fix_menu_index}     ${wow_url}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Click Link Menu Lv1     ${fix_menu_index}
#     Verify Click Link       ${wow_url}

# [EN] Click link menu level 1 action
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Click link menu level 1 action
#     Prepare Mega Menu Link Lv 1      ${menu_id}      ${fix_menu_index}     ${wow_url}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Click Link Menu Lv1     ${fix_menu_index}
#     Verify Click Link       ${wow_url}

# [TH] Click link menu level 2 action
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Click link menu level 2 action
#     Prepare Mega Menu Link Lv 2      ${menu_id}      1      2      ${wow_url}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep       2s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'      Mouse Over Menu         1

#     Click Link Menu Lv2     1       2
#     Verify Click Link       ${wow_url}

# [EN] Click link menu level 2 action
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Click link menu level 2 action
#     Prepare Mega Menu Link Lv 2      ${menu_id}      1      2      ${wow_url}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep       2s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'      Mouse Over Menu         1

#     Click Link Menu Lv2     1       2
#     Verify Click Link       ${wow_url}

# [TH] Click Link banner action
#     [Arguments]    ${full_url}
#     #Log to console      [TH] Click Link banner action
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}      ${carousel_template_id}          ${showroom_carousel_data5_path}
#     Go to          ${full_url}
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Click Showroom Banner       ${carousel_menu_index}      1
#     Verify Click Link       ${wow_url}

# [EN] Click Link banner action
#     [Arguments]    ${full_url}
#     #Log to console      [EN] Click Link banner action
#     Prepare Mega Menu Showroom Banner From File     ${menu_id}      ${carousel_menu_index}      ${carousel_template_id}          ${showroom_carousel_data5_path}
#     Go to          ${full_url}
#     Switch to EN Language
#     Wait Until Angular Ready    30s
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '2'     Click Element and Wait Angular Ready    ${mege-menu-icon-button}
#     Run Keyword if    '${GLOBAL_MEGAMENU_TYPE}' == '3'     Mouse Over    ${icon_hamburger}
#     Wait Until Angular Ready    30s
#     sleep    2s
#     Click Showroom Banner       ${carousel_menu_index}      1
#     Verify Click Link       ${wow_url}
