*** Settings ***
Resource        ${CURDIR}/../../../Resource/config/${ENV}/env_config.robot

*** Variables ***
${mainPage}                 page1
${promotionPage}            page2
${everydayWowPage}          page3
${categoryPage}
${searchPage}
${home}                     portal/page1

@{promotion_discount_wow_pkey}    2777325666854    2292546446610    2878556048317    2618121434276    2265929090549    2764986688669    2677964486537    2401989291858    2215014923867    2314618164149    2599061866193    2834508773917




&{XPATH_CMS}   link_category_manage_portal=//li/a[@class='menu-dropdown']/span[contains(.,' Manage Portal ')]
 ...   link_manage_portal_menubar=//ul[@class='submenu']/li/a/span[contains(.,'Menubar')]
 ...   wait_manage_portal_menubar_respond=//div[@class='col-lg-6 col-sm-6 col-xs-12 layer-parent'][2]//div[2]//li[1]
 ...   cnt_manage_portal_menubar_category=//div[@class='col-lg-6 col-sm-6 col-xs-12 layer-parent'][2]//div[2]//li

 ...   link_manage_portal_megamenu=//ul[@class='submenu']/li/a/span[contains(.,'Mega Menu')]
 ...   wait_manage_portal_megamenu_respond=//div[@class='dd dd-draghandle darker']//li[1]
 ...   cnt_manage_portal_megamenu_level1=//div[@class='dd dd-draghandle darker']//li

 ...   link_manage_portal_merchantzone=//ul[@class='submenu']/li/a/span[contains(.,'Merchant Zone')]
 ...   wait_manage_portal_merchantzone_respond=//div[@class='dd2-content bg-azure']

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
 ...   txt_current_page=//ul/li[@class='item ng-scope active'][1]/a
 ...   btn_view_more=//div[@class='wm-floor-box ng-isolate-scope']/div[1]//div[@class='btn-view-more']

 ...   pic_highlight=//div[@class='lb-section-content']
 ...   btn_change_highlight_pic=//div[@class='lb-section-content']//div[@class='owl-dots']/div

 ...   txt_menubar=//ul[@class='list-menu']
 ...   btn_main_menu=//div[@class='btn-side-menu']/span
 ...   wait_showroom_respond=//div[@class='wm-floor-box ng-isolate-scope']
# ...   btn_Promotion_page=//ul/li[contains(.,'เทส2')][1]
 ...   wait_Promotion_page_respond=//div[@class='wm-level-b ng-isolate-scope']
 ...   wait_Merchantzone_respond=//div[@class='wm-brand-box ng-isolate-scope']
 ...   Merchantzone_name=//div[@class='wm-brand-box ng-isolate-scope']//span[2]
 ...   Merchant_brand=//div[@class='owl-item active']//ul/li

 ...   btn_change_Merchantzone_banner=//div[@class='wm-brand-box ng-isolate-scope']//div[@class='owl-dot']
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


&{Mega_Menu}   login=//div[@ng-click='sendLogin()']
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
 ...   TH_language=//a[@id='btn-thai-lang']
 ...   ENG_language=//a[@id='btn-en-lang']


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

# ...   view_more=http://m.itruemart.com/
 ...   view_more=http://www.itruemart.com/
 ...   wait_view_more_respond=//a[@title='iTruemart']/img

 ...   th_language=${WEMALL_WEB}/portal/${mainPage}/
 ...   en_language=${WEMALL_WEB}/en/portal/${mainPage}/


&{XPATH_iTrueMart}   login_default=http://alpha-m.itruemart-dev.com/auth/login
 ...   username=//input[@name='username']
 ...   password=//input[@name='password']
 ...   btn_submit_login=//button[@id='login-submit']
 ...   txt_id=//span[@id='userName']
 ...   icon_cart=//div[@data-type='main-menu']/a
 ...   icon_item_number_in_cart=//div[@data-type='main-menu']/a/span[@class='icon-cart']
 ...   user_contain=//div[@id='userContainer']/span[contains(.,'Hello')]

&{Check_URL_iTrueMart}   login=${ITM_MOBILE}/auth/login?continue=${ITM_MOBILE}/${home}/
 ...   home=${ITM_MOBILE}/
 ...   wow=${ITM_MOBILE}/everyday-wow
 ...   itruemart=${ITM_MOBILE}/
 ...   cart=${ITM_MOBILE}/cart
 ...   order_tracking=${ITM_MOBILE}/member/orders
 ...   return_policty=${ITM_MOBILE}/policy/returnpolicy
 ...   shipment_policy=${ITM_MOBILE}/policy/freedelivery
 ...   refund_policy=${ITM_MOBILE}/policy/moneyback
 ...   discount_code=http://support.itruemart.com/116901-%E0%B8%82%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%81%E0%B8%A3%E0%B8%AD%E0%B8%81%E0%B8%84%E0%B8%9B%E0%B8%AD%E0%B8%87%E0%B9%83%E0%B8%AA%E0%B8%A5%E0%B8%94%E0%B9%83%E0%B8%99%E0%B8%AB%E0%B8%99%E0%B8%B2%E0%B9%80%E0%B8%A7%E0%B8%9A?r=1
 ...   contact_us=${ITM_MOBILE}/contact_us

# ...   view_more=http://m.itruemart.com/
 ...   view_more=http://www.itruemart.com/
 ...   wait_view_more_respond=//a[@title='iTruemart']/img
 ...   th_language=${ITM_MOBILE}/${home}/
 ...   en_language=${ITM_MOBILE}/en/${home}/

 ...   btn_cart_main_page=//div[@class='btn-cart ng-scope']/a/span[1]
 ...   btn_popup=//div[@id='floating-ads']//area[@id='area-2']

&{VALID}   txt_search_auto_suggestion=iPhone
 ...   iTruemart_id=robot30@mail.com
 ...   iTruemart_password=123456



&{INVALID}   txt_search_not_found=xxx

&{SAMPLE_DATA}   INVALID=&{INVALID}
 ...   VALID=&{VALID}




# &{TH_language}   login=เข้าสู่ระบบ
#  ...   home=หน้าหลัก
#  ...   wow=Everyday Wow
#  ...   category=หมวดหมู่สินค้า
#  ...   promotion=โปรโมชั่นและกิจกรรม
#  ...   cart=สินค้าในตระกร้า
#  ...   order_tracking=สถานะการชำระเงินและการจัดส่ง
#  ...   return_policty=นโยบายรับประกันสินค้า
#  ...   shipment_policy=นโยบายการจัดส่งสินค้า
#  ...   refund_policy=นโยบายการคืนเงิน
#  ...   discount_code=วิธีการใช้รหัสส่วนลด
#  ...   contact_us=ติดต่อเรา
#  ...   language=เลือกภาษา


# &{ENG_language}   login=Login
#  ...   home=Home
#  ...   wow=Everyday Wow
#  ...   category=Category
#  ...   promotion=Promotion
#  ...   cart=Cart
#  ...   order_tracking=Order Tracking
#  ...   return_policty=Return Policy
#  ...   shipment_policy=Shipment Policy
#  ...   refund_policy=Refund Policy
#  ...   discount_code=Discount Code
#  ...   contact_us=Contact Us
#  ...   language=Language



# &{iTruemart}   select_item=//div[@class='col-xs-15 mi-product-card-container-mobile ng-isolate-scope']/div[1]
#  ...   wait_search_respond=//div[@class='itm-text-search-result ng-binding']/span
#  ...   txt_input_search_keyword=//input[@id='search-text']
#  ...   txt_auto_suggestion_field=//div[@id='suggest-result']
#  ...   txt_select_auto_suggestion=//div[@id='suggest-result']/ul/li[1]
#  ...   btn_next_view=//div[@data-id='btnSelectView']
#  ...   btn_next_view_attribute=//div[@class='btn mi-btn-dropdown-icon mi-icon-size thumbnail']

#  ...   txt_item_out_of_stock=//div[@class='mi-product-card-view']/a[div[div[@style='display: block;']]]/div/div
# #[contains(.,'iPhone 5S (16GB) เครื่องเปล่าศูนย์ทรู  (จ่ายเต็ม หรือ ผ่อนชำระ)')]


































