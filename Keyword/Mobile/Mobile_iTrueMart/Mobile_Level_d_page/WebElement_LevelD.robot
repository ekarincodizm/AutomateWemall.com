*** Variables ***
&{XPATH_LEVEL_D_MOBILE}   btn_style_option_pkey=//*[@data-style-option-pkey="^^style-option-pkey^^"]
 ...   div_style_type=//div[@class="product-style_types"]
 ...   img_freebie_th=//img[@id="freebie_image_promotion"][@data-image-lang="img_mobile"]
 ...   img_freebie_en=//img[@id="freebie_image_promotion"][@data-image-lang="img_mobile_translation"]
 ...   img_freebie_id_th=//img[@id="freebie_image_promotion"][@data-image-lang="img_mobile"][@data-freebie-id="^^promotion_id^^"]
 ...   img_freebie_id_en=//img[@id="freebie_image_promotion"][@data-image-lang="img_mobile_translation"][@data-freebie-id="^^promotion_id^^"]
 ...   btn_add_to_cart_enable=//div[@class="row button-buy add-to-cart"]
 ...   btn_add_to_cart_disable=//div[@class='row button-buy add-to-cart disabled']
 ...   buy_button_id=//div[@id="buy_button"]
 ...   buy_button_class=//div[@class="button"]
# ...   btn_go_next=//div[@id="proceed_to_checkout_button"]
 ...   btn_go_next=//div[@id="buy_button"]
 ...   btn_mobile_go_next=//div[@id="proceed_to_checkout_button"]
# ...   20161026   comment update fix case freebie mobile level D
# ...   btn_go_next=//a[@id="cartlightbox-go-next"]
 ...   lbl_special_price=//div[@class="variant-price"]/div[contains(@class, "row special-price")]/div[2]/span[1]
 ...   lbl_special_price_product=//div[@class="product-price"]/div[contains(@class, "row special-price")]/div[2]/span[1]
 ...   lbl_normal_price=//div[@class="variant-price"]/div[contains(@class, "row normal-price")]/div[2]/span[1]

 ...   div_container=//div[@class="itm-wrapper-product-details-mobile"]
 ...   div_installment=//div[contains(@class, "row-promotion")]

${level_d_mobile_delivery_time}                  jquery=.delivery_time
${level_d_mobile_delivery_policy_title}          jquery=a[href="#freedelivery"] p
${level_d_mobile_refund_policy_title}            jquery=a[href="#moneyback"] p
${level_d_mobile_return_policy_title}            jquery=a[href="#returns"] p
${level_d_mobile_delivery_policy_description}    jquery=#freedelivery
${level_d_mobile_refund_policy_description}      jquery=#moneyback
${level_d_mobile_return_policy_description}      jquery=#returns
${level_d_mobile_delivery_policy_tab}            jquery=a[href="#freedelivery"]
${level_d_mobile_refund_policy_tab}              jquery=a[href="#moneyback"]
${level_d_mobile_return_policy_tab}              jquery=a[href="#returns"]
