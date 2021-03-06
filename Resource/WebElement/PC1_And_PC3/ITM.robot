*** Variables ***
${Filter_PromotionName}    //*[@id="DataTables_Table_0_filter"]/label/input
${Table_Selected_Promotion}    //*[contains(@class,'mws-datatable-fn')]//tbody//tr/td[1][contains(text(),'REPLACE_ME')]/../td[7]/div/a[1]
${Table_CounponList}    //*[contains(@class,'coupon-list')]//tbody//tr/td[1]
${LoadingImg}     //*[@class="ajaxloading-widget-background"]
${Active_status}    //*[@class="box_status active box-status-has-stock"]/img
${Add_to_Cart}    //*[@class="btn_order product-addtocart"]
${Next_to_Checkout1}    //*[@id="cartlightbox-go-next"]
${Next_to_Checkout2}    //*[@id="btnNext"]
${Input_Email_Checkout1}    //*[@id="step1-username"]
${Next_to_Checkout3}    //*[@id="btnSave"]
${Input_Name_Checkout2}    //*[@id="name"]
${Input_Phone_Checkout2}    //*[@id="telephone"]
${Input_Address_Checkout2}    //*[@id="address"]
${List_Province}    //*[@id="province-control"]
${List_District}    //*[@id="district-control"]
${List_sub-district}    //*[@id="sub-district-control"]
${List_zip-code}    //*[@id="zip-code-control"]
${Submit_Checkout3}    //*[@id="step3-submit"]
${Input_Coupon_Checkout3}    //*[@id="coupon-text"]
${Submit_Coupon_Checkout3}    //*[@id="coupon_button"]
${Sum_Checkout3}    //*[@class="sum clr-3"]
${Close_POPUP}    //*[@id="popup-regis"]/div/div/div[1]/div[2]/img
${Order_ID}       //*[@id="thank_order_id"]
${CCW_Name}       //*[@id="ccw-info-name"]
${CCW_CardNo}     //*[@id="ccw-info-no"]
${CCW_Month}      //*[@id="month"]
${CCW_Year}       //*[@id="year"]
${CCW_CCV}        //*[@id="channel-ccw"]/div[4]/div[4]/div/input
${ConfirmCCW}     //*[@id="confirm-payment-submit"]
