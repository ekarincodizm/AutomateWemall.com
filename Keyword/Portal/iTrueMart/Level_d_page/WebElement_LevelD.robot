*** Variables ***
${LvD_Add_to_Cart}    jquery=.prd_price_box .btn_order.product-addtocart
${LvD_LoadingImg}    //*[@class="ajaxloading-widget-background"]
${LvD_LoadingStock}    //*[contains(@class, "stock-loading")]
${LvD_Active_status}    //*[@class="box_status active box-status-has-stock"]/img
${LvD_Add_item}    //span[@class="stepper-arrow up"]
${LvD_Product_Out_Of_Stock}    //*[@class='box_status inc_active box-status-no-stock']
${Buy_Product_Button_disabled}    //*[@class='btn_order product-addtocart disabled']
${LvD_Color_position}    xpath=//ul[contains(@data-style-name, "สี")]/li[REPLACE_ME]/a    # Require replace string "REPLACE_ME" to position of variance e.g. 1, 2 etc
${LvD_Size_position}    xpath=//*[@class="prd_control options"]/ul[contains(@data-style-name, "ขนาด")]/li[REPLACE_ME]/a
${LvD_wow_pack_loading}    //*[@class='wow-pack-loading']
${LvD_Select_Box_Quantity_Max1}    //div[@class="prd_price_box"]/ul[@class="prd_price_list"]/li/div[@class="prd_control options"]/div[@class="stepper "]/input[@max="1"]
${LvD_back_to_buy_product}    //a[@class="cart-close float-left"]
&{MSG_FULL_CART}    one_piece_one_order=คุณมีสินค้าชิ้นนี้ในตะกร้าแล้ว ขอสงวนสิทธิ์การสั่งซื้อสินค้าราคาพิเศษ 1 ชิ้นต่อ 1 คำสั่งซื้อเท่านั้นค่ะ
