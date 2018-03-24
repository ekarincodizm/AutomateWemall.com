*** Variables ***
${MiniCart_FreebieCartTitleAndAmount}    //div[@class='cart']//div[@class='cart-title'][contains(text(),\"สินค้าแถมฟรีของคุณ\")]
${MiniCart_Qualtity}    //*[@id='minicart-item-quantity']
${MiniCart_FreebieItem}    //*[@data-type='freebie']//*[contains(text(),\"REPLACE_ME\")]/../../*[contains(@class,\"total-list\")]
${MiniCart_FreebieItemList}    //li[@data-type='freebie']
${MINI_CART}      //div[@id="minicart-container"]
${MINI_CART_ROW_ITEM_X_TYPE}    //div[@class="cart"][ul]//li[@data-type="^^type^^"]

${MINI_CART_ROW_ITEM_NORMAL}    //div[@class="cart"][ul]//li[@data-type="normal"]
#${MINI_CART_ROW_ITEM_NORMAL}    //div[@class="no-product-list"]//p//span[@class="select"]
#${MINI_CART_ROW_ITEM_NORMAL}    //ul//li[1]//div[@class="total-list"]//div[@class="no-product-list"]//p//span[@class="select-cart select-disable"]

${MINI_CART_ROW_ITEM_FREEBIE}    //div[@class="cart"][ul]//li[@data-type="freebie"]
${MINI_CART_ROW_ITEM_MNP}    //div[@class="cart"][ul]//li[@data-type="mnp"]
${MINI_CART_ROW_ITEM_BUNDLE}    //div[@class="cart"][ul]//li[@data-type="bundle"]
${MINI_CART_ROW_ITEM_SIM}    //div[@class="cart"][ul]//li[@data-type="sim"]
${MINI_CART_ITEM_PRICE}    /div[contains(@class, "total-list")]/div[contains(@class, "no-product-list")]/p[2]
${MINI_CART_ITEM_QUANTITY}    /div[contains(@class, "total-list")]/div[contains(@class, "no-product-list")]/p[contains(@class, "left")]/span
&{XPATH_MINI_CART}    total_price=//div[contains(@class, "sum_total_price")]
 ...    discount_price=//div[@id="coupon-container"]/following-sibling::div/div[@class="sum text-blink text-blink-animation"]
 ...    sub_total_price=//div[contains(@class, "sum clr-3")]
 ...    shipping_price_free=${MINI_CART}/div/p[contains(text(),'รวมค่าจัดส่ง')]/following-sibling::div/span
 ...    shipping_price=${MINI_CART}/div/p[contains(text(),'รวมค่าจัดส่ง')]/following-sibling::div[@class="sum text-blink text-blink-animation"]
 ...    div_title=//span[@id="minicart-item-quantity"]
   # ...    lbl_first_product_name=//div[contains(@class, "total-list")][1]/p[contains(@class, "product-name")]
 ...    lbl_first_normal_price=//div[contains(@class, "total-list")][1]/div[@class="no-product-list"]/p[2]
 ...    lbl_first_total_price=//div[contains(@class, "total-list")][1]/div[@class="no-product-list"]/p[2]
 ...    lbl_first_quantity=//div[contains(@class, "total-list")][1]/div[@class="no-product-list"]/p[1]/span
 ...    lbl_summary_total_price=${MINI_CART}/div[@class="total-list"][1]/div[1]
 ...    lbl_summary_shipping_price=${MINI_CART}/div[@class="total-list"][2]/div[1]
 ...    lbl_summary_discount_price=${MINI_CART}/div[@class="total-list"][3]/div[1]
 ...    lbl_summary_sub_total_price=${MINI_CART}/div[contains(@class, "total-list")][4]/div[1]
 ...    btn_remove_coupon=//span[contains(@class, "remove-coupon")]
 ...    li_cart_=${MINI_CART}/div[contains(@class, "total-list")][4]/div[1]
 ...    a_edit_cart=${MINI_CART}//a[@id="btn-edit-cart"]
 ...    point_ajax_loading=//div[@class="point-ajaxloading-widget-background"]

 ...    div_cart=//div[@class="cart"]
 ...    row_items=//div[@class="cart"]/ul/li
 ...    lbl_first_product_name=//div[@class="cart"]/ul/li[1]/div/p[contains(@class, "product-name")]




${xpath_quantity_frist_normal_item}    //li[@data-type='normal'][1]/div[@class='total-list']/div[@class='no-product-list']/p[@class='left']/span[@class='select-cart select-disable']
${xpath_quantity_second_normal_item}    //li[@data-type='normal'][2]/div[@class='total-list']/div[@class='no-product-list']/p[@class='left']/span[@class='select-cart select-disable']
${xpath_quantity_frist_freebie_item}    //li[@data-type='freebie'][1]/div[@class='total-list']/div[@class='no-product-list']/p[@class='left']/span[@class='select-cart select-disable']
${xpath_quantity_second_freebie_item}    //li[@data-type='freebie'][2]/div[@class='total-list bdr-btm-none']/div[@class='no-product-list']/p[@class='left']/span[@class='select-cart select-disable']

