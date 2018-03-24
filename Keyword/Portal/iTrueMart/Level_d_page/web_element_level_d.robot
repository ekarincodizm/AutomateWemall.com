*** Variables ***
${LvD_Add_to_Cart}    jquery=.prd_price_box .btn_order.product-addtocart
${LvD_Add_to_Cart_mobile}    //*[@id="buy_button"]
${LvD_LoadingImg}    //*[@class="ajaxloading-widget-background"]
${LvD_Active_status}    //*[@class="box_status active box-status-has-stock"]/img
${LvD_Add_item}      //span[@class="stepper-arrow up"]

#### level D -> catetrail under menu bar####
${cate_trail_levelD}        //*[@class="breadcrumb__link"]
${LvD_Product_Out_Of_Stock}    //*[@class='box_status inc_active box-status-no-stock']
${Buy_Product_Button_disabled}    //*[@class='btn_order product-addtocart disabled']
${LvD_Variance_position}    xpath=//*[@class="style-types"][1]/div[contains(@class, "prd_control")]/ul[contains(@data-style-name, "color")]/li[REPLACE_ME]/a    # Require replace string "REPLACE_ME" to position of variance e.g. 1, 2 etc

&{XPATH_LEVEL_D}   tab_bundle=//*[@id="bundle-tab"]
 ...   tab_mnp=//*[@id="mnp-device-tab"]
 ...   btn_buy_mnp=//button[@id="mnp-device-btn-order"]
 ...   btn_buy_bundle=//button[@id="bundle-btn-order"]
 ...   style_option=//a[@class="style-option"][@data-pkey="^^style_pkey^^"]
 ...   chatbar=//*[@id="chatbar"]
 ...   href_bundle_package_information=//*[@id="bundle-package-information"]
 ...   href_mnp_device_package_information=//*[@id="mnp-device-package-information"]
 ...   package_box=//*[@class="package-box"]
 ...   mnp_package=//*[@class="package-name"]
 ...   lbl_normal_price=//span[contains(@class, "normal_price")]
 ...   lbl_special_price=//span[@class="special_price"]
 ...   btn_add_to_cart=//button[contains(@class, "product-addtocart")]
 ...   btn_status_success=//*[@class="box_status active box-status-has-stock"]
 ...   floating_ads=//*[@id="floating-ads"]
 ...   mnp_package=//*[@class="package-name"]
 ...   btn_style_option_pkey=//a[@data-style-option='^^style-option-pkey^^']
 ###   Update Object select color    TC_iTM_00648
 ...   btn_style_option_pkey_select_color=//a[@class="style-option"]
 ...   btn_box_amount_readonly=//input[@class="box_amount product-qty stepper-input" and @readonly="true"]
 ...   div_style_type=//li[@class="style-types"]
 ...   img_freebie_th=//img[@id="freebie_image_promotion"][@data-image-lang="img_web"]
 ...   img_freebie_en=//img[@id="freebie_image_promotion"][@data-image-lang="img_web_translation"]
 ...   img_freebie_id_th=//img[@id="freebie_image_promotion"][@data-image-lang="img_web"][@data-freebie-id="^^promotion_id^^"]
 ...   img_freebie_id_en=//img[@id="freebie_image_promotion"][@data-image-lang="img_web_translation"][@data-freebie-id="^^promotion_id^^"]
 ...   lbl_freebie_note_th=//div[@id="freebie_note"][@data-note-lang="note"]
 ...   lbl_freebie_note_en=//div[@id="freebie_note"][@data-note-lang="note_translation"]
 ...   lbl_freebie_id_note_th=//div[@id="freebie_note"][@data-note-lang="note"][@data-freebie-id="^^promotion_id^^"]
 ...   lbl_freebie_id_note_en=//div[@id="freebie_note"][@data-note-lang="note_translation"][@data-freebie-id="^^promotion_id^^"]
# ...   btn_add_to_cart_enable=//button[@class="btn_order product-addtocart"]
 ...   btn_add_to_cart_enable=//button[@class="btn_order product-addtocart btn-color-primary"]
# ...   btn_add_to_cart_disable=//button[@class="btn_order product-addtocart disabled"]
 ...   btn_add_to_cart_disable=//button[@class="btn_order product-addtocart btn-color-primary disabled"]
 ...   step_arrow_up=//span[@class='stepper-arrow up']
 ...   step_arrow_down=//span[@class='stepper-arrow down']
 ...   product_lvD_name=//div[@class="product__name"]/h1
 ...   wrapper=//div[@class="itm-wrapper-product-detail-desktop"]
 ...   div_installment=//div[@class="product__promotion_container"]
 ...   merchant_header=//div[contains(@class, "iwm-merchant-header")]
 ...   merchant_header_content=//div[contains(@class, "iwm-merchant-header")]/div/div[1]

${arr}=    [1,2,3]
${tab-name-mnp}                             //a[@id="mnp-device-tab"]
${tab-name-bundle}                          //a[@id="bundle-tab"]

${tab-name-bundle-active}                   //li[@class="active"]/a[@id="bundle-tab"]
${tab-name-mnp-active}                   //li[@class="active"]/a[@id="mnp-device-tab"]

${mnp-device-price-special}                 //span[@id="mnp-device-price-special"]
${mnp-device-price-normal}                  //del[@id="mnp-device-price-normal"]
${mnp-device-price-save}                    //span[@id="mnp-device-price-save"]

# ${ld_mnp_variant_style1}               //a[@data-pkey='${test_var_mnp2_style_option_pkey1}']
# ${ld_mnp_variant_style2}               //a[@data-pkey='${test_var_mnp2_style_option_pkey2}']

${ld_mnp_variant_style1}                //li[1]/a[@class='style-option']
${ld_mnp_variant_style2}                //li[1]/a[@class="style-option"]

${ld_normal_variant_style1}            //li[2]/a[@class='style-option']
${ld_normal_variant_style2}            //li[2]/a[@class="style-option"]

${mnp-package-link}                    //*[@id="mnp-device-package-information"]
${mnp-product-sim-link}                //*[@id="mnp-device-product-sim"]
${mnp-modal}                           //*[@id="mnp-modal"]
${mnp-buy-btn}                         //*[@id="mnp-device-btn-order"]
${mnp-from-modal}                      //*[@id="validateFromMnp"]
${mnp-from-msisdn}                     css=#validateFromMnp input[name="msisdn"]
${mnp-from-idcard}                     css=#validateFromMnp input[name="idcard"]
${mnp-from-bdYear}                     css=#validateFromMnp select[name="birthdateYear"]
${mnp-from-bdMonth}                    css=#validateFromMnp select[name="birthdateMonth"]
${mnp-from-bdDay}                      css=#validateFromMnp select[name="birthdateDay"]

${package_name}                        css=.package-name
${package_name_text}                   3G iSmart 299
${package_content}                     css=.package-content .package-info p
${package_content_text}                - โทรทุกเครือข่าย 120 นาที

${wording-mnp-device-btn-order}        สั่งซื้อทั้งหมด

${check-stock-mobile}                  //div[@class="row button-buy add-to-cart"]
${buy_botton}                          jquery=div.button[id="buy_button"]

${leveld-prd-price-list}               //ul[@class="prd_price_list"]@data-inventory-id
${leveld-prd-name}                     //h1[@class="leveld_full_width"]
${leveld-button-bundle-btn-order}      //button[@id="bundle-btn-order"]
${leveld-button-mnp-device-btn-order}  //button[@id="mnp-device-btn-order"]
${leveld-button-mnp-device-btn-order-enable}  //button[@id="mnp-device-btn-order"][not(@disabled)]
# ${leveld-image-mnp}                    //div[@id="wow-pack"]/div[@class="product-bundle-container"]/ul[@class="list-product-bundle"][1]/span[@class="product-bundle-img"]/img
${leveld-image-mnp}                    jQuery=#mnp-device-product-sim img
# ${leveld-image-bundle}                 //div[@id="mnp"]/div[@class="product-bundle-container"]/ul[@class="list-product-bundle"][1]/span[@class="product-bundle-img"]/img
${leveld-image-bundle}                    jQuery=#bundle-product-sim img
${leveld-bundle-price-special}         //span[@id="bundle-price-special"]
${leveld-mnp-price-special}            //span[@id="mnp-device-price-special"]
${leveld-bundle-btn-order}             //button[@id="bundle-btn-order"]
${leveld-mnp-device-btn-order}         //button[@id="mnp-device-btn-order"]
${leveld-mnp-device-btn-order-enable}  //button[@id="mnp-device-btn-order"][not(@disabled)]
${leveld-modal}                        //div[@class="modal"]
${leveld-btn-close-modal}              //img[@data-dismiss="modal"][@class="close"]

#${varaint-color-first}                 //ul[@data-style-name="สี"]/li[1]/a
#${varaint-color-second}                //ul[@data-style-name="สี"]/li[2]/a
#${varaint-color-third}                 //ul[@data-style-name="สี"]/li[3]/a
${varaint-color-first}                 jQuery=ul[data-style-name="สี"] li:eq(0) a
${varaint-color-second}                jQuery=ul[data-style-name="สี"] li:eq(1) a
${varaint-color-third}                 jQuery=ul[data-style-name="สี"] li:eq(2) a

#${varaint-size-first}                  //ul[@data-style-name="Size"]/li[1]/a
#${varaint-size-second}                 //ul[@data-style-name="Size"]/li[2]/a
#${varaint-size-third}                  //ul[@data-style-name="Size"]/li[3]/a
${varaint-size-first}                  jQuery=ul[data-style-name="Size"] li:eq(0) a
${varaint-size-second}                 jQuery=ul[data-style-name="Size"] li:eq(1) a
${varaint-size-third}                  jQuery=ul[data-style-name="Size"] li:eq(2) a

${ajaxloading-widget-background}       //*[@class="ajaxloading-widget-background"]


#wallet
${wallet_img_level_D}    jquery=ul.productPayment_list li img[alt="วอลเล็ท"]
${wallet_img_level_D_EN}    jquery=ul.productPayment_list li img[alt="Wallet by TreuMoney"]
${wallet_img_level_D_mobile}    jquery=div.col-xs-12 img[id="allow_tmn_wallet"]



${button-add-to-cart-enable}      //button[@class="btn_order product-addtocart"]
${button-add-to-cart-disable}     //button[@class="btn_order product-addtocart disabled"]

${style-type-box}                   //li[@class="style-types"]

${leveld-style-option-style-color}    //a[@class="style-option"][@data-pkey="^^style-color^^"]
#${ld_mnp_variant_style1}               //a[@data-pkey='${test_var_mnp2_style_option_pkey1}']
# ${ld_mnp_variant_style2}               //a[@data-pkey='${test_var_mnp2_style_option_pkey2}']

${level-d-freebie-image-promotion}          //img[@id="freebie_image_promotion"]

${level-d-freebie-note-th}        //div[@id="freebie_note"][@data-note-lang="note"]
${level-d-freebie-note-en}        //div[@id="freebie_note"][@data-note-lang="note_translation"]

${level-d-freebie-image-web-th}   //img[@id="freebie_image_promotion"][@data-image-lang="img_web"]
${level-d-freebie-image-web-en}   //img[@id="freebie_image_promotion"][@data-image-lang="img_web_translation"]

${level-d-freebie-image-mobile-th}   //img[@id="freebie_image_promotion"][@data-image-lang="img_mobile"]
${level-d-freebie-image-mobile-en}   //img[@id="freebie_image_promotion"][@data-image-lang="img_mobile_translation"]

${level-d-freebie-id-note-th}        //div[@id="freebie_note"][@data-note-lang="note"][@data-freebie-id="^^promotion_id^^"]
${level-d-freebie-id-note-en}        //div[@id="freebie_note"][@data-note-lang="note_translation"][@data-freebie-id="^^promotion_id^^"]

${level-d-freebie-id-image-web-th}    //img[@id="freebie_image_promotion"][@data-image-lang="img_web"][@data-freebie-id="^^promotion_id^^"]
${level-d-freebie-id-image-web-en}    //img[@id="freebie_image_promotion"][@data-image-lang="img_web_translation"][@data-freebie-id="^^promotion_id^^"]

${level-d-freebie-id-image-mobile-th}    //img[@id="freebie_image_promotion"][@data-image-lang="img_mobile"][@data-freebie-id="^^promotion_id^^"]
${level-d-freebie-id-image-mobile-en}    //img[@id="freebie_image_promotion"][@data-image-lang="img_mobile_translation"][@data-freebie-id="^^promotion_id^^"]


${button-cartlightbox-go-next}          id=cartlightbox-go-next
${variant-data-pkey}                     //a[@data-style-option='^^variant_style_pkey^^']
${variant-data-pkey-mobile}           xpath=//div[@data-style-option-pkey='^^variant_style_pkey^^']
${alert-box-out-of-stock}             xpath=//div[@class='font2 msg-header-danger text-center alert-title']
${step-arrow-up}                      xpath=//span[@class='stepper-arrow up']
${step-arrow-down}                    xpath=//span[@class='stepper-arrow down']

${camp_short_description}                    xpath=//li[@data-id='camp_short_description']
${camp_short_description-mobile}             xpath=//li[@data-id='camp_short_description']
${camp-product-freebie}                    xpath=//div[@data-type='freebie']

${amount-in-cart-have-2-item}       xpath=//select[@class="select-cart cartlightbox-update-item-qty"]/option[2]
${amount-in-cart-have-1-item}       xpath=//select[@class="select-cart cartlightbox-update-item-qty"]/option[1]
${button-disable}             xpath=//button[@class='btn_order product-addtocart disabled']
${button-enable}             xpath=//button[@class='btn_order product-addtocart']

${button-disable-mobile}             xpath=//div[@class='row button-buy add-to-cart disabled']
${select_qty_as_2}                   xpath=//select[@class="form-control qty"]
${buy_button}                        xpath=//div[@id="buy_button"]
${buy_button2}                        xpath=//div[@class="button"]
${button-cartlightbox-go-next-mobile}          xpath=//div[@id="proceed_to_checkout_button"]
${amount-in-cart-mobile}        xpath=//select[@class='form-control item-quantity']

${alert-box-popup_ok}    xpath=//input[@class='popup_ok btn btn-success']
${alert-box-popup_ok_mobile}    xpath=//button[@class='btn btn-primary alert-dialog-continue']

${stock-loading}                     //div[contains(@class, "stock-loading")]

${title_product_description}        //div[@class='product__description_prop leveld_full_width']/h2[@class='product__description_name']
${product_name_level_d}         //div[@class='product__name']
# /h1[@class='leveld_full_width']
${campaign_countdown_level_d}         //div[@class='campaign_countdown']

${close_full_cart}        //div[@class='left cart-close']
${Logout-LavelD}        //div[@class='header__box_misc auth-loggedin']

${Select_Box_Quantity_Value_Max_1}        //div[@class="prd_price_box"]/ul[@class="prd_price_list"]/li/div[@class="prd_control options"]/div[@class="stepper "]/input[@max="1"]

${level_d_delivery_time}                  jquery=.delivery_time
${level_d_delivery_policy_title}          jquery=.policy_title:eq(0)
${level_d_refund_policy_title}            jquery=.policy_title:eq(1)
${level_d_return_policy_title}            jquery=.policy_title:eq(2)
${level_d_delivery_policy_subtitle}       jquery=.policy_sub_title:eq(0)
${level_d_refund_policy_subtitle}         jquery=.policy_sub_title:eq(1)
${level_d_return_policy_subtitle}         jquery=.policy_sub_title:eq(2)
${level_d_delivery_policy_description}    jquery=#freedelivery
${level_d_refund_policy_description}      jquery=#moneyback
${level_d_return_policy_description}      jquery=#return
${level_d_delivery_policy_tab}            xpath=//a[@href="#freedelivery"]
${level_d_refund_policy_tab}              xpath=//a[@href="#moneyback"]
${level_d_return_policy_tab}              xpath=//a[@href="#return"]

${style_color}                            //ul[@data-style-name="สี"]/li[@class="box_type"]
${style_color_value}					  /a/@title

${product_normal_price_element}         xpath=//span[@class="normal_price discount"]
${product_special_price_element}        xpath=//span[@class="special_price"]
${product_discount_percent_element}     xpath=//div[@class="prd_media"]/span/span[@class="price_no"]
