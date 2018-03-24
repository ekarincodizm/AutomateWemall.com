*** Variables ***
${CartLightBox_FreebieCartTitleAndAmount}    //div[@id='cart-box-info']//div[@class='cart-divider'][contains(text(),\"สินค้าแถมฟรีของคุณ\")]
${CartLightBox_NextBtn}    //*[@id="cartlightbox-go-next"]
${CartLightBox_Qualtity}    //*[@id='cartlightbox-item-quantity']
${CartLightBox_FreebieItem}    //*[@class='cart-item'][@data-type='freebie']//*[contains(text(),\"REPLACE_ME\")]/../..
${CartLightBox_FreebieDescription}    //*[@data-id='camp_short_description'][contains(text(),'REPLACE_ME')]
${CartLightBox_FreebieItemList}    //*[@data-type='freebie']
${LoadingImg}     //*[@class="ajaxloading-widget-background"]
${OpenCartLightbox_from_Carticon}    //div[@class="wrapper"][1]
${Delete_itemPosition1_fromCart}    //*[@id="cart-box-info"]/div/div/div[2]/div[6]/ul/li/a
${Close_cart_lightbox}    //div[contains(@class , "cart-close")]
${cart_light_box_popup}    jquery=#cart-box-info
${product_in_cart_list}    ${cart_light_box_popup} .cart-content-wrapper .cart-item
${close_cart_light_box_button}    jquery=#cart-popup .cart-title .cart-quantity-box.cart-close
${delete_link_item_in_cart}    jquery=.delete-item
${delete_item_in_cart_first_item}    jquery=.delete-item:eq(0)
${ajax_loading_widget}    jquery=.ajaxloading-widget-icon-container
${Cart_detail_CartLightBoxPge}    //*[@id="cart-box-info"]
${CartLightBox_ItemQty}    //span[@id="cartlightbox-item-quantity"]
${CartLightBox_EditBtn}    jquery=#btn-edit-cart
${CartLightBox_EditBtn}    jquery=#cart-box-info
${CartLightBox_LoadingItemList}    //div[@id='cart-box-info'][contains(text(),'กำลังโหลดรายการ')]
