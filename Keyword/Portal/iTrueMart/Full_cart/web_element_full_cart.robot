*** Variables ***
${CART_LIGHTBOX_SUMMARY_BOTTOM}   //div[@id="cartlightbox-sumary-bottom"]
${CART_BOX_SUMMARY_BOTTOM}   //div[@id="cartbox-sumary-bottom"]
${CART_TITLE_LIST}  //div[@class="cart-content-wrapper"]/div[@class="cart-item"]
${ROW_FIRST_ITEM_MNP}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and @data-type="mnp"][1]
${ROW_FIRST_ITEM_NO_MNP}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and not(@data-type="mnp")][1]
${ROW_FIRST_ITEM_NORMAL}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and @data-type="normal"][1]
${ROW_X_ITEM_X_TYPE}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and @data-type="^^type^^"][^^position^^]
${ROW_X_TYPE}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and @data-type="^^type^^"]

${ROW_SECOND_ITEM_MNP}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and @data-type="mnp"][2]
${ROW_SECOND_ITEM_NO_MNP}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and not(@data-type="mnp")][2]
${ROW_SECOND_ITEM_NORMAL}  //div[@class="cart-content-wrapper"]/div[@class="cart-item" and @data-type="normal"][2]

${SelectBox_NormalProduct_FirstItem_Value1}    //div[@class="cart-content-wrapper"]/div[@class="cart-item"][1]/div[@class="cart-column quantity"]/select[@class="select-cart cartlightbox-update-item-qty"]/option[@value="1"]
${SelectBox_NormalProduct_FirstItem_Value2}    //div[@class="cart-content-wrapper"]/div[@class="cart-item"][1]/div[@class="cart-column quantity"]/select[@class="select-cart cartlightbox-update-item-qty"]/option[@value="2"]
${SelectBox_NormalProduct_FirstItem_Value3}    //div[@class="cart-content-wrapper"]/div[@class="cart-item"][1]/div[@class="cart-column quantity"]/select[@class="select-cart cartlightbox-update-item-qty"]/option[@value="3"]
${SelectBox_NormalProduct_FirstItem_Value4}    //div[@class="cart-content-wrapper"]/div[@class="cart-item"][1]/div[@class="cart-column quantity"]/select[@class="select-cart cartlightbox-update-item-qty"]/option[@value="4"]
${SelectBox_NormalProduct_FirstItem_Value5}    //div[@class="cart-content-wrapper"]/div[@class="cart-item"][1]/div[@class="cart-column quantity"]/select[@class="select-cart cartlightbox-update-item-qty"]/option[@value="5"]


${cart_light_box}                 jquery=#cart-box-info
${product_in_cart_list}           ${cart_light_box} .cart-content-wrapper .cart-item

&{XPATH_FULL_CART}  div_full_cart=//div[@id="cart-popup"]
 ...  btn_next=//*[@id="cartlightbox-go-next"]
 ...  lbl_summary_normal_price=${CART_LIGHTBOX_SUMMARY_BOTTOM}/div[contains(@class, "total-list")][1]/div[@class="sum"]
 ...  lbl_summary_shipping_price=${CART_LIGHTBOX_SUMMARY_BOTTOM}/div[contains(@class, "total-list")][2]/div[1]/span
 ...  lbl_summary_discount_price=${CART_LIGHTBOX_SUMMARY_BOTTOM}/div[contains(@class, "total-list")][3]/div[1]
 ...  lbl_summary_sub_total_price=${CART_LIGHTBOX_SUMMARY_BOTTOM}/div[contains(@class, "total-list")][4]/div[1]
 ...  lbl_summary_shipping_price_fullcart=${CART_BOX_SUMMARY_BOTTOM}/div[contains(@class, "total-list")][2]/div[1]/span
 ...  row_items=${CART_TITLE_LIST}
 ...  lbl_first_product_name=${CART_TITLE_LIST}[1]/div[@class="cart-box-name"]/h2
 ...  lbl_first_normal_price=${CART_TITLE_LIST}[1]/div[@class="cart-box-price"]/span
 ...  lbl_first_claim_price=${CART_TITLE_LIST}[1]/div[@class="cart-box-price"]/span[@class="line-through"]
 ...  lbl_first_special_price=${CART_TITLE_LIST}[1]/div[@class="cart-box-price"]/span[@class="alert"]
 ...  lbl_first_sub_total_price=${CART_TITLE_LIST}[1]/div[@class="cart-box-price2"]
 ...  lnk_first_remove_item=${CART_TITLE_LIST}[1]/div[@class="cart-box-action"]/ul/li/a
 ...  lnk_first_remove_item_text=ลบรายการ
 ...  lnk_second_remove_item=${CART_TITLE_LIST}[2]/div[@class="cart-box-action"]/ul/li/a
 ...  lnk_second_remove_item_text=ลบรายการ
 ...  cbo_first_quantity=${CART_TITLE_LIST}[1]/div[@class="cart-column quantity"]/select
 ...  cbo_quantity=//div[@class="cart-column quantity"]/select
 ...  cbo_quantity_inventory=//div[@class="cart-column quantity"]/select[@data-inventory-id="^^inventory^^"]
 ...  lbl_quantity=//div[@class="cart-column quantity"]
 ...  lbl_second_product_name=${CART_TITLE_LIST}[2]/div[@class="cart-box-name"]/h2
 ...  lbl_second_normal_price=${CART_TITLE_LIST}[2]/div[@class="cart-box-price"]/span[@class="line-through"]
 ...  lbl_second_special_price=${CART_TITLE_LIST}[2]/div[@class="cart-box-price"]/span[@class="alert"]
 ...  lbl_second_sub_total_price=${CART_TITLE_LIST}[2]/div[@class="cart-box-price2"]
 ...  div_no_item_in_cart_container=//div[@id="cart-box-info"]
 ...  lbl_no_item_in_cart=//div[@id="cart-box-info"]/div
 ...  lbl_no_item_in_cart_text=ไม่พบสินค้าในตะกร้า
 ...  div_title_no_of_items=//span[@id="cartlightbox-item-quantity"]
 ...  row_first_mnp=${ROW_FIRST_ITEM_MNP}
 ...  row_first_no_mnp=${ROW_FIRST_ITEM_NO_MNP}
 ...  row_first_normal=${ROW_FIRST_ITEM_NORMAL}
 ...  row_second_mnp=${ROW_SECOND_ITEM_MNP}
 ...  row_second_no_mnp=${ROW_SECOND_ITEM_NO_MNP}
 ...  row_second_normal=${ROW_SECOND_ITEM_NORMAL}
# ...  lnk_close=//div[@class="left cart-close"]/img
 ...  lnk_close=//div[@class="cart-quantity-box cart-close"]/img
 ...  count_item_normal_in_cart=count(//div[@class="cart-box"]/div[@class="cart-item" and @data-type="normal"])
 ...  camp_short_description=//li[@data-id="camp_short_description"]
 ...  icn_cart_amount=//span[@id="icn_cart_id"]/span[contains(@class, "icn_cart_amount")]
 ...  full_cart_item_quantity=//span[@id="cartlightbox-item-quantity"]
 ...  lbl_bundle_price=//img[contains(@class,"bundle")]/parent::div[@class="cart-item"]/div/div[@class="cart-box-price"]

${XPATH_FULL_CART_SHIPPING_PRICE_FOR_MOBILE}  jquery=.checkout-total_shipping_fee

${XPATH_FULL_CART_HAVE_SHIPPING_PRICE_FOR_MOBILE}   jquery=.checkout-total_shipping_fee





























