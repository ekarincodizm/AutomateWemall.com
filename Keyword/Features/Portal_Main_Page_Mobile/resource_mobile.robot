# *** Settings ***
# Resource        ${CURDIR}/../../../Resource/Config/alpha/env_config.robot
# Resource        ${CURDIR}/../../../Resource/Config/local/Env_config.robot
# Resource        ${CURDIR}/../../../Resource/Config/staging/env_config.robot

*** Variables ***
${mainPage}                 page1
${promotionPage}            page2
${everydayWowPage}          page3
# ${categoryPage}
# ${searchPage}
${home}                     portal/page1

@{promotion_discount_wow_pkey}    2777325666854    2292546446610    2878556048317    2618121434276    2265929090549    2764986688669    2677964486537    2401989291858    2215014923867    2314618164149    2599061866193    2834508773917




&{XPATH_CMS}   link_category_manage_portal=//li/a[@class='menu-dropdown']/span[contains(.,' Manage Portal ')]
 ...   link_manage_portal_menubar=//ul[@class='submenu']/li/a/span[contains(.,'Menubar')]
 ...   wait_manage_portal_menubar_respond=//div[@class='col-lg-6 col-sm-6 col-xs-12 layer-parent'][2]//div[2]//li[1]
 ...   cnt_manage_portal_menubar_category=//div[@class='col-lg-6 col-sm-6 col-xs-12 layer-parent'][2]//div[2]//li

 ...   link_manage_portal_megamenu=//ul[@class='submenu']/li/a/span[contains(.,'Mega Menu')]
 ...   wait_manage_portal_megamenu_respond=//div[@class='dd dd-draghandle darker']//li[1]
 ...   cnt_manage_portal_megamenu_level1=//div[@class='col-lg-4 col-sm-4 col-xs-12 layer-parent']//li
 ...   cnt_manage_portal_megamenu_pic_att=//div[@class='template-wrapper'][2]//ul//li

 ...   link_manage_portal_merchantzone=//ul[@class='submenu']/li/a/span[contains(.,'Merchant Zone')]
 ...   wait_manage_portal_merchantzone_respond=//div[@class='ng-pristine ng-untouched ng-valid ng-isolate-scope ui-sortable']
 ...   Cnt_manage_portal_merchantzone_category=//div[@class='ng-pristine ng-untouched ng-valid ng-isolate-scope ui-sortable']/div[@class='wm-tab-groups ng-scope']
 ...   btn_save_draft_merchantzone=//button[@ng-click='btnSaveDraftClicked()']
 ...   btn_publish_merchantzone=//a[@ng-click='btnPublishedClicked()']
 ...   btn_save_draft_megamenu_cat=//a[@ng-click="saveDraft('')"]
 ...   btn_publish_megamenu_cat=//a[@ng-click='savePublish()']
 ...   txt_highlights=//span[contains(.,'Highlights')]
 ...   btn_highlights_banner_group_management=//a[@class='btn btn-xs banner-add']
 ...   wait_banner_group_management_respond=//div[@class='col-lg-4 col-sm-4 col-xs-12 layer-parent']
 ...   wait_preview_pic_respond=//div[@id='showroom']//div[@class='widget-body']
 ...   cnt_banner_group_pic=//ul[@id='showroom-list']/li
 ...   cnt_mobile_preview_pic=//div[@id='showroom']//div[@class='widget-body']/div[2]/ul/li


 ...   get_attribute_highlights_picture=//ul[@class='mock-template ng-pristine ng-untouched ng-valid']/li

 ...   txt_merchantzone_category_name=//div/span[@class='ng-binding']
 ...   get_attribute_banner_left=//div/a/img[@ng-show='bannerLeft.src_web']@src
 ...   get_attribute_banner_right=//div/a/img[@ng-show='bannerRight.src_web']@src
 ...   cnt_pic_number=//div[@class='brands-container']/div
 ...   popup_edit_merchantzone_pic=//div[@class='modal-content']
 ...   popup_mobile_merchant_pic=//div[@class='modal-content']//div[@class='form-group'][3]//img
 ...   popup_cancel_btn=//button[@data-id='btn-cancel']


 ...   link_manage_portal_showroom=//ul[@class='submenu']/li/a/span[contains(.,'Showroom')]
 ...   txt_first_showroom=//ul/li[1]/div[2]/span
 ...   btn_showroom_manage_pic=//li[1]/div[span]/div/div/a[1]
 ...   wait_manage_portal_showroom_respond=//div[@class='dd no-max-width dd-draghandle darker']/ul/li[1]
 ...   cnt_manage_portal_showroom_category=//div[@class='dd no-max-width dd-draghandle darker']/ul/li
 ...   wait_showroom_pic_respond=//li[@class='mock-banner ng-scope'][1]
 ...   cnt_max_showroom_pic=//li[@class='mock-banner ng-scope']
 ...   btn_back_to_manage_showroom=//ul[@class='breadcrumb ng-scope ng-isolate-scope']/li[2]/a
 ...   btn_manage_showroom_brand_pic=//li/div[@class="btn btn-info wm-btn-add"]
 ...   wait_manage_showroom_brand_respond=//ul[@class='dd-list ng-pristine ng-untouched ng-valid ng-isolate-scope ui-sortable']/li[1]
 ...   cnt_showroom_brand_pic=//ul[@class='dd-list ng-pristine ng-untouched ng-valid ng-isolate-scope ui-sortable']/li
 ...   merchant_left_banner_edit_btn=//div[@class='banner-v']//button
 # ...   merchant_right_banner_edit_btn=//div[@class='banner-v hidden-md']//button
 ...   merchant_right_banner_edit_btn=$('.banner-v.hidden-md > div').eq(0).find('button').click()

&{XPATH_storefront}    wait_shop_list_display=//tbody
 ...   wait_edit_shop_logo_popup=//div[@class='modal-content']
 ...   shop_logo_attribute=//*[@id='sfbImgLogoMobileP']
 ...   btn_cancel_shop_logo_popup=//button[@class='btn btn-warning']
 ...   wait_storefront_management_menu_display=//div[@class='widget-body']
 ...   btn_menu_header=//tbody//span[contains(.,'Header')]
 ...   btn_menu_menu=//tbody//span[contains(.,'Menu')]
 ...   wait_menu_edit_display=//div[@class='col-lg-3 col-sm-3 col-xs-12 layer-parent']/div
 ...   menu_status_on=//*[@id='sfbStatus'][@class='checkbox-slider colored-palegreen ng-pristine ng-untouched ng-valid']
 ...   menu_status_off=//*[@id='sfbStatus'][@class='checkbox-slider colored-palegreen ng-valid ng-dirty ng-valid-parse ng-touched']
 ...   memu_field=//*[@id='level-1']
 ...   btn_menu_banner=//tbody//span[contains(.,'Banner')]
 ...   btn_menu_content=//tbody//span[contains(.,'Content')]
 ...   btn_menu_footer=//tbody//span[contains(.,'Footer')]
 ...   btn_back_to_storefront_menu=//ul[@class='breadcrumb ng-scope ng-isolate-scope']/li[contains(.,'Storefront Management')]
 ...   banner_list=//table[@class='table table-striped table-hover']
 ...   cnt_banner_number=//table[@class='table table-striped table-hover']/tbody/tr[@class='ng-scope']
 ...   banner_picture_TH=//*[@id='sfbImgWebImageTH']
 ...   banner_picture_popup_cancel_button=//*[@id='btnCancel']

&{XPATH_PCMS}   input_email_login=//input[@name='email']
 ...   input_password_login=//input[@name='password']
 ...   btn_login=//input[@type='submit']
 ...   wait_homepage_respond=//div[@class='row clearfix']

 ...   link_collection=//div[@id='mws-navigation']/ul/li/a[contains(.,' Collection')]
 ...   link_manage_collection=//div[@id='mws-navigation']/ul//a[contains(.,'Manage Collection')]
 ...   wait_manage_collection_respond=//tbody
 ...   get_iTruemart_collection_number=//tr[td[2][contains(.,'iTruemart')]]
 ...   txt_name=//input[@id='name']
 ...   btn_display=//input[@name='is_category'][@checked='checked']
 ...   btn_PDS_type_Collection_is_check=//li[label[contains(.,'Collection')]]//input[@checked='checked']
 ...   btn_PDS_type_Category_is_check=//li[label[contains(.,'Category')]]//input[@checked='checked']
 ...   btn_Publishes_for_iTruemart_is_check=//li[label[contains(.,'iTruemart')]]//input[@checked='checked']
 ...   btn_goto_Collection_management=//li/a[contains(.,'Collections Management')]

 ...  link_promotion=//div[@id='mws-navigation']/ul/li/a[contains(.,' Promotion')]
 ...  link_discount_campiagn=//div[@id='mws-navigation']/ul//a[contains(.,'Discount Campaign')]
 ...  wait_discount_campiagn_respond=//tbody
 ...  btn_select_discount_campiagn=//tr[1][td[3][contains(.,'Everyday-Wow')]]/td[7]/a[1]
 ...  wait_discount_campaign_product_respond=//div[@class='mws-panel-body no-padding']
 ...  cnt_pcms_wow_product=//tr[td/h4]

 ...  link_product=//div[@id='mws-navigation']/ul/li/a[contains(.,' Product')]
 ...  link_product_list=//div[@id='mws-navigation']/ul//a[contains(.,'Product List')]
 ...  wait_product_list_respond=//tbody
 ...  txt_input_product_name=//input[@name='product']
 ...  btn_search=//input[@type='submit']



&{XPATH_WeMall}   btn_search_main_page=//div/span[@class='icon-search']
 ...   btn_cart_main_page=//div[@class='btn-cart ng-isolate-scope']/a/span[2]
 ...   btn_wemall_icon=//div[@class='box-center']//img
 ...   btn_footer_change_view=//div[@class='desktop-btn-wrapper']//span
 ...   wait_footer_change_view_respond=//body[@class='page-portal']
 ...   btn_view_more=//div[@class='wm-floor-box ng-isolate-scope']/div[1]//div[@class='btn-view-more']

 ...   pic_highlight=//div[@class='lb-section-content']
 ...   btn_change_highlight_pic=//div[@class='lb-section-content']//div[@class='owl-dots']/div

 ...   txt_menubar=//ul[@class='list-menu']
 ...   btn_main_menu=//div[@class='btn-side-menu']/span
 ...   wait_showroom_respond=//div[@class='wm-floor-box ng-isolate-scope']
 ...   btn_Promotion_page=//ul/li[contains(.,'โปรโมชั่น')][1]
 ...   wait_Promotion_page_respond=//div[@class='wm-level-b ng-isolate-scope']
 ...   wait_Merchantzone_respond=//div[@class='wm-brand-box ng-isolate-scope']
 ...   Merchantzone_name=//div[@class='wm-brand-box ng-isolate-scope']//span[2]
 ...   Merchant_brand=//div[@class='owl-item active']//ul/li

 ...   btn_change_Merchantzone_banner_field=//div[@class='wm-brand-box ng-isolate-scope']//div[@class='owl-dots']
 ...   get_attribute_banner_right=//div[@class='owl-item active']/div/div[1]/a/img
 ...   get_attribute_banner_left=//div[@class='owl-item active']/div/div[1]/a/img

 ...   txt_search=//input[@type='search']
 ...   btn_cancle_search_page=//div[@class='btn-cancle-search']

 ...   txt_auto_suggestion_field=//ul[@class='search-suggestion__list']
 ...   txt_auto_suggestion=//ul[@class='search-suggestion__list']/li
 ...   txt_select_auto_suggestion=//ul[@class='search-suggestion__list']/li[1]

 ...   wait_wow_respond=//div[@class='super-deals-box ng-isolate-scope']
 ...   cnt_wow_product=//div[@class='superdeals-card-wrapper not-swipe']/div


 ...   btn_search_skrit=//li[contains(.,'แม่และเด็ก')][1]
 ...   wait_search_skrit_respond=//div[@class='product-list']
 ...   cnt_item_in_search_skrit=//div[@class='product-list']/div[@class='over_lvb ng-scope']
 ...   btn_sort=//button[contains(.,'จัดเรียงตาม')]
 ...   btn_sort_expand=//ul[@class='dropdown-menu']
 ...   cbo_sort_keyword=//ul[@class='dropdown-menu']/li[1]
 ...   cbo_sort_latest=//ul[@class='dropdown-menu']/li[2]
 ...   cbo_sort_low_to_high_price=//ul[@class='dropdown-menu']/li[3]
 ...   cbo_sort_high_to_low_price=//ul[@class='dropdown-menu']/li[4]
 ...   cbo_sort_low_to_high_discount=//ul[@class='dropdown-menu']/li[5]
 ...   cbo_sort_high_to_low_discount=//ul[@class='dropdown-menu']/li[6]

 ...   btn_filter=//button[contains(.,'รายการที่แสดง')]
 ...   btn_filter_expand=//div[@class='tab-wrapper']/div[@style='transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);']

 ...   shopinshop_burger_menu=//div[@class='btn-right-menu btn-show-slide-menu ng-scope ng-isolate-scope']
 ...   shopinshop_burger_menu_popup=//div[@class='wm-store-front-slide-menu ng-isolate-scope']
 ...   cnt_shopinshop_category_name=//div[@class='wm-store-front-slide-content']/ul/li
 ...   shopinshop_back_btn=//div[@class='storefront-back-button']
 ...   shopinshop_logo=//div[@class='storefront-logo ng-binding']/img
 ...   shopinshop_header=//div[@class='storefront-header']/div/p/img
 ...   shopinshop_close_btn_popup=//div[@class='close-sidemenu-container']/i
 ...   shopinshop_banner_field=//div[@class='owl-stage-outer']
 ...   shopinshop_banner_dot=//div[@class='owl-dots']/div
 ...   shopinshop_shortcut_wemall=//div[@class='shortcut-menu-box']/div[1]
 ...   shopinshop_shortcut_cart=//div[@class='shortcut-menu-box']/div[2]
 ...   shopinshop_shortcut_search=//div[@class='shortcut-menu-box']/div[3]
 ...   shopinshop_shortcut_language=//div[@class='shortcut-menu-box']/div[4]

&{Mega_Menu}   login=//div[@ng-click='sendLogin()']
 ...   user_name=//div[@class='content-box']/div[@class='text-box']
 ...   home=//li[@id='home']
 ...   wow=//li[@id='everyday-wow']
 ...   category=//li[@id='category']
 ...   wait_category_respond=//ul[@id='sub-list-1']
 ...   cnt_category_number=//ul[@id='sub-list-1']/li
 ...   promotion=//li[@id='promotion']
 ...   wait_promotion_respond=//ul[@id='sub-list-2']
 ...   cnt_promotion_number=//ul[@id='sub-list-2']/li
 ...   itruemart=//li[@id='itruemart']
 ...   cart=//li[@id='cart']
 ...   order_tracking=//li[@id='order-tracking']
 ...   return_policty=//li[@id='return-policy']
 ...   shipment_policy=//li[@id='shipment-policy']
 ...   refund_policy=//li[@id='refund-policy']
 ...   discount_code=//li[@id='discount-code']
 ...   contact_us=//li[@id='contact-us']
 ...   contact_us_Java=$('#contact-us span').click()
 ...   language=//a[@id='btn-en-lang']


&{Check_URL}   login=${ITM_MOBILE}/auth/login?continue=${WEMALL_WEB}/portal/page1
 ...   wait_login_respond=//div[@class='col-xs-12 userForm']

 ...   home=${WEMALL_WEB}/portal/${mainPage}/

 ...   wow=${ITM_MOBILE}/everyday-wow
 ...   wait_wow_respond=//a/img[@alt[contains(.,'iTrueMart')]]

 ...   itruemart=${ITM_MOBILE}/
 ...   wait_itruemart_respond=//a/img[@alt[contains(.,'iTrueMart')]]

 ...   cart=${ITM_MOBILE}/cart
 ...   wait_cart_respond=//a/img[@alt[contains(.,'iTrueMart')]]

 ...   order_tracking=${ITM_MOBILE}/member/orders

 ...   return_policty=${ITM_MOBILE}/policy/returnpolicy
 ...   wait_return_policty_respond=//a[@title='iTruemart']/img

 ...   shipment_policy=${ITM_MOBILE}/policy/freedelivery
 ...   wait_shipment_policy_respond=//a[@title='iTruemart']/img

 ...   refund_policy=${ITM_MOBILE}/policy/moneyback
 ...   wait_refund_policy_respond=//a[@title='iTruemart']/img

 ...   discount_code=http://support.itruemart.com/116901-%E0%B8%82%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%81%E0%B8%A3%E0%B8%AD%E0%B8%81%E0%B8%84%E0%B8%9B%E0%B8%AD%E0%B8%87%E0%B9%83%E0%B8%AA%E0%B8%A5%E0%B8%94%E0%B9%83%E0%B8%99%E0%B8%AB%E0%B8%99%E0%B8%B2%E0%B9%80%E0%B8%A7%E0%B8%9A?r=1
 ...   wait_discount_code_respond=//a/img[@alt[contains(.,'iTrueMart')]]

 ...   contact_us=${ITM_MOBILE}/contact_us
 ...   wait_contact_us_respond=//div[@id='contactus-map']

 ...   view_more=http://www.wemall.com/itruemart/
 ...   wait_view_more_respond=//a[@title='iTruemart']/img

 ...   th_language=${WEMALL_WEB}/portal/${mainPage}/
 ...   en_language=${WEMALL_WEB}/en/portal/${mainPage}/


&{XPATH_iTrueMart}   username=//input[@name='username']
 ...   password=//input[@name='password']
 ...   btn_submit_login=//button[@id='login-submit']
 ...   txt_id=//span[@id='userName']
 ...   icon_cart=//div[@data-type='main-menu']/a
 ...   icon_item_number_in_cart=//div[@data-type='main-menu']/a/span[@class='icon-cart']
 ...   icon_item_number_in_cart_rebrand=//div[@data-type='main-menu']/a/span[@class='icon-cart ']
 ...   user_contain=//div[@id='userContainer']/span[contains(.,'Hello')]
 ...   buy_button=//div[@id='buy_button']
 ...   wait_cart_page_loading=//div[@class='col-xs-12 title-cart'][contains(.,'สินค้าในตะกร้า')]
 ...   checkout_button=//div[@id='proceed_to_checkout_button']
 ...   checkout_by_guest=//input[@id='guest']
 ...   checkout_by_member=//input[@id='user1']
 ...   checkout_step1_next_button=//button[@name='btnNext']
 ...   checkout_step2_input_name=//input[@id='name']
 ...   checkout_step2_input_phone=//input[@id='telephone']
 ...   checkout_step2_select_province=//select[@id='province-control']
 ...   checkout_step2_select_city=//select[@id='city-control']
 ...   checkout_step2_select_district=//select[@id='district-control']
 ...   checkout_step2_select_zip=//select[@id='zip-code-control']
 ...   checkout_step2_select_address=//textarea[@id='address']
 ...   checkout_step2_next_button=//div[@class='button']
 ...   checkout_step2_by_member_next_button=//div[@id='proceed_with_indicated_address']
 ...   checkout_step3_payment_ccw=//input[@value='credit-card']
 ...   checkout_step3_ccw_name=//input[@id='ccw-info-name']
 ...   checkout_step3_ccw_number=//input[@name='creditnum']
 ...   checkout_step3_ccw_ex_month=//select[@name='expiremonth']/option[2]
 ...   checkout_step3_ccw_ex_year=//select[@name='expireyear']/option[10]
 ...   checkout_step3_ccw_ccv=//input[@name='ccv']
 ...   checkout_step3_next_button=//div[@class='button']
 ...   confirm_checkout=//a[@id='confirm-payment-submit']

#### Web View
 ...   level_D_product_status_message=//div[@class='box_msg style-option-status']/span[2]
 ...   level_D_product_status_out_of_stock_status=//div[@class='box_status inc_active box-status-no-stock']
 ...   level_D_product_status_have_stock=//div[@class='box_status active box-status-has-stock']
 # ...   btn_buy_enable=//button[@class='btn_order product-addtocart']
 # ...   btn_buy_disable=//button[@class='btn_order product-addtocart disabled']
 ...   btn_buy_enable=//button[@class='btn_order product-addtocart btn-color-primary']
 ...   btn_buy_disable=//button[@class='btn_order product-addtocart btn-color-primary disabled']


#### Profile Mobile View
 ...   btn_create_new_address=//div[@class='profile-block-body']/a/span[@class='text']
 ...   link_order_tracking=//div[@class='profile-block profile-payment-delivery-status']
 ...   link_cart=//div[@class='profile-block profile-product-cart']/div/a
 ...   btn_edit=//div[@class='address-block address-card'][1]//div[@class='btn-edit']/span[2]

&{Check_URL_iTrueMart}   login=${ITM_MOBILE}/auth/login?continue=${ITM_MOBILE}/${home}/
 ...   home=${WEMALL_MOBILE_URL}/portal/page1
 ...   https_home=${WEMALL_MOBILE_URL_SSL}/portal/page1
 ...   wow=${WEMALL_MOBILE_URL}/everyday-wow
 ...   https_wow=${WEMALL_MOBILE_URL_SSL}/everyday-wow
 ...   itruemart=${WEMALL_MOBILE_URL}/itruemart
 ...   https_itruemart=${WEMALL_MOBILE_URL_SSL}/itruemart
 ...   cart=${WEMALL_MOBILE_URL}/cart
 ...   order_tracking=${WEMALL_MOBILE_URL}/member/orders
 ...   return_policty=${WEMALL_MOBILE_URL}/policy/returnpolicy
 ...   https_return_policty=${WEMALL_MOBILE_URL_SSL}/policy/returnpolicy
 ...   shipment_policy=${WEMALL_MOBILE_URL}/policy/freedelivery
 ...   https_shipment_policy=${WEMALL_MOBILE_URL_SSL}/policy/freedelivery
 ...   refund_policy=${WEMALL_MOBILE_URL}/policy/moneyback
 ...   https_refund_policy=${WEMALL_MOBILE_URL_SSL}/policy/moneyback
 ...   discount_code=http://support.wemall.com/116901-%E0%B8%82%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%81%E0%B8%A3%E0%B8%AD%E0%B8%81%E0%B8%84%E0%B8%9B%E0%B8%AD%E0%B8%87%E0%B9%83%E0%B8%AA%E0%B8%A5%E0%B8%94%E0%B9%83%E0%B8%99%E0%B8%AB%E0%B8%99%E0%B8%B2%E0%B9%80%E0%B8%A7%E0%B8%9A?r=1
 ...   https_discount_code=https://support.wemall.com/116901-%E0%B8%82%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%81%E0%B8%A3%E0%B8%AD%E0%B8%81%E0%B8%84%E0%B8%9B%E0%B8%AD%E0%B8%87%E0%B9%83%E0%B8%AA%E0%B8%A5%E0%B8%94%E0%B9%83%E0%B8%99%E0%B8%AB%E0%B8%99%E0%B8%B2%E0%B9%80%E0%B8%A7%E0%B8%9A?r=1
 ...   contact_us=${WEMALL_MOBILE_URL}/contact_us
 ...   https_contact_us=${WEMALL_MOBILE_URL_SSL}/contact_us

# ...   view_more=http://m.itruemart.com/
 ...   view_more=http://www.itruemart.com/
 ...   wait_view_more_respond=//a[@title='iTruemart']/img
 ...   th_language=${WEMALL_MOBILE_URL}/${home}
 ...   https_th_language=${WEMALL_MOBILE_URL_SSL}/${home}
 ...   en_language=${WEMALL_MOBILE_URL}/en/${home}
 ...   https_en_language=${WEMALL_MOBILE_URL_SSL}/en/${home}

 ...   btn_cart_main_page=//div[contains(@class,'btn-cart')]/a/span[1]
 ...   btn_popup=//div[@id='floating-ads']//area[@id='area-2']

&{VALID}   txt_search_auto_suggestion=iPhone
 ...   iTruemart_id=robot31@mail.com
 ...   iTruemart_password=123456
 ...   iTruemart_member_ID=robot32@mail.com
 ...   iTruemart_member_password=123456
 ...   checkout_step2_name=robot automate
 ...   checkout_step2_phone=0861234321
 ...   checkout_step2_address=robot automate testing
 ...   checkout_step3_ccw_name=robot automate
 ...   checkout_step3_ccw_number=5555555555554444
 ...   checkout_step3_ccw_ccv=123
 ...   Edit_name=RobotEditName
 ...   Edit_phone=0861112222
 ...   Edit_Address=Robot_Edit_Address



&{INVALID}   txt_search_not_found=xxx

&{SAMPLE_DATA}   INVALID=&{INVALID}
 ...   VALID=&{VALID}

































