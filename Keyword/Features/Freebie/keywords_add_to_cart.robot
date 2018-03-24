*** Keywords ***
Prepare Main Product A
	Get Main Product A
	Log to console    \n Variable Main Product A = ${Variable_Main_Product_A}

Prepare Main Product A Random
	Get Main Product A Random
	Log to console    \n Variable Main Product A = ${Variable_Main_Product_A}
	Log To Console    Variable_Main_Pkey=${Variable_Main_Pkey}

Prepare Main Product C Random
	Get Main Product C Random
	Log to console    \n Variable Main Product C = ${Variable_Main_Product_C}
	Log To Console    Variable_Main_Pkey_C=${Variable_Main_Pkey_C}

Prepare Main Product C
	Get Main Product C
	Log to console    \n Variable Main Product C = ${Variable_Main_Product_C}
	Log To Console    Variable_Main_Pkey_C=${Variable_Main_Pkey_C}

Prepare Main Product B
	Get Main Product B
	Log to console    \n Variable Main Product B = ${Variable_Main_Product_B}

Prepare Main Product Have 3 Variant Inactive
	Get Main Product Have 3 Variant Inactive
	Log to console    \n Variable_Main_Product_Inactive = ${Variable_Main_Product_Inactive}

Prepare Main Product Have 3 Variant Inactive B
	Get Main Product Have 3 Variant Inactive B
	Log to console    \n Variable_Main_Product_Inactive = ${Variable_Main_Product_B}

Prepare Product Free Public
	Get InventoryID Freebie From Variant
	Log to console    Variable_Freebie_Inventory_ID=${Variable_Freebie_Inventory_ID}

Prepare Product D Free Public
	Get InventoryID Freebie Product D From Variant
	Log to console    Variable_Freebie_Inventory_ID_D=${Variable_Freebie_Inventory_ID_D}

Prepare Main Wow Product A
	Get Main Wow Product A
	Log to console    \n Variable Main Product A = ${Variable_Main_Product_A}

Fix Product Main Public
	[Arguments]    ${inventory_id}=None
	Get Main Product Fix          ${inventory_id}
	Log to console    \n Variable Main Product A = ${Variable_Main_Product_A}

Fix Product B Main Public
	[Arguments]    ${inventory_id}=None
	Get Main Product B Fix          ${inventory_id}
	Log to console    \n Variable Main Product B = ${Variable_Main_Product_A}

Fix Product Free Public
	[Arguments]    ${inventory_id}=None
	Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventory_id}
	Log to console    Variable_Freebie_Inventory_ID=${Variable_Freebie_Inventory_ID}

Prepare Product Free Public Have 3 Variant Active
	Get InventoryID Freebie Have 3 Variant
	Log to console    Variable_Freebie_Inventory_ID=${Variable_Freebie_Inventory_ID}

Prepare Stock Main Product A
	[Arguments]    ${amount}=None
	${return}=    Check Stock By Sku    ${Variable_Main_Product_A}
	${hold}=    Get Json Value    ${return}    /hold/${Variable_Main_Product_A}
	${remaining}=    Get Json Value    ${return}    /remaining/${Variable_Main_Product_A}
	Set Test Variable    ${Variable_Old_Remaining_Main_Product}    ${remaining}
	Log to console   Old Remaining Main Product A=${remaining}
	${total}=    Evaluate    ${amount}+${hold}
	Increase Stock By Inventory ID    ${Variable_Main_Product_A}    ${total}

Prepare Stock Main Product B
	[Arguments]    ${amount}=None
	${return}=    Check Stock By Sku    ${Variable_Main_Product_B}
	${hold}=    Get Json Value    ${return}    /hold/${Variable_Main_Product_B}
	${remaining}=    Get Json Value    ${return}    /remaining/${Variable_Main_Product_B}
	Set Test Variable    ${Variable_Old_Remaining_Main_Product_B}    ${remaining}
	Log to console   Old Remaining Main Product B=${remaining}
	${total}=    Evaluate    ${amount}+${hold}
	Increase Stock By Inventory ID    ${Variable_Main_Product_B}    ${total}

Prepare Stock Main Product C
	[Arguments]    ${amount}=None
	${return}=    Check Stock By Sku    ${Variable_Main_Product_C}
	${hold}=    Get Json Value    ${return}    /hold/${Variable_Main_Product_C}
	${remaining}=    Get Json Value    ${return}    /remaining/${Variable_Main_Product_C}
	Set Test Variable    ${Variable_Old_Remaining_Main_Product_C}    ${remaining}
	Log to console   Old Remaining Main Product C=${remaining}
	${total}=    Evaluate    ${amount}+${hold}
	Increase Stock By Inventory ID    ${Variable_Main_Product_C}    ${total}

Prepare Stock Main Product Inactive
	[Arguments]    ${amount}=None
	${return}=    Check Stock By Sku    ${Variable_Main_Product_Inactive}
	${hold}=    Get Json Value    ${return}    /hold/${Variable_Main_Product_Inactive}
	${remaining}=    Get Json Value    ${return}    /remaining/${Variable_Main_Product_Inactive}
	Set Test Variable    ${Variable_Old_Remaining_Main_Product}    ${remaining}
	Log to console   Old Remaining Main Product Out Of Stock=${remaining}
	${total}=    Evaluate    ${amount}+${hold}
	Increase Stock By Inventory ID    ${Variable_Main_Product_Inactive}    ${total}

Prepare Default Stock Main Product
	Increase Stock By Inventory ID    ${Variable_Main_Product}   ${Variable_Old_Remaining_Main_Product}

Prepare Default Stock Main Product B
	Increase Stock By Inventory ID    ${Variable_Main_Product}   ${Variable_Old_Remaining_Main_Product}

Prepare Default Stock Main Product C
	Increase Stock By Inventory ID    ${Variable_Main_Product_C}   ${Variable_Old_Remaining_Main_Product_C}

Prepare Stock Product Free Public
	[Arguments]    ${amount}=None
	${return}=    Check Stock By Sku    ${Variable_Freebie_Inventory_ID}
	${hold}=    Get Json Value    ${return}    /hold/${Variable_Freebie_Inventory_ID}
	${remaining}=    Get Json Value    ${return}    /remaining/${Variable_Freebie_Inventory_ID}
	Set Test Variable    ${Variable_Old_Remaining_Product_Free}    ${remaining}
	Log to console   Old Remaining Freebie Public=${remaining}
	${total}=    Evaluate    ${amount}+${hold}
	Increase Stock By Inventory ID    ${Variable_Freebie_Inventory_ID}    ${total}

Prepare Stock Product D Free Public
	[Arguments]    ${amount}=None
	${return}=    Check Stock By Sku    ${Variable_Freebie_Inventory_ID_D}
	${hold}=    Get Json Value    ${return}    /hold/${Variable_Freebie_Inventory_ID_D}
	${remaining}=    Get Json Value    ${return}    /remaining/${Variable_Freebie_Inventory_ID_D}
	Set Test Variable    ${Variable_Old_Remaining_Product_Free_D}    ${remaining}
	Log to console   Old Remaining Freebie Public=${remaining}
	${total}=    Evaluate    ${amount}+${hold}
	Increase Stock By Inventory ID    ${Variable_Freebie_Inventory_ID_D}    ${total}

Prepare Default Stock Product Free
	Increase Stock By Inventory ID    ${Variable_Freebie_Inventory_ID}   ${Variable_Old_Remaining_Product_Free}

Prepare Default Stock Product D Free
	Increase Stock By Inventory ID    ${Variable_Freebie_Inventory_ID_D}   ${Variable_Old_Remaining_Product_Free_D}

Set Product A To Main Product
	Set Test Variable   ${Variable_Main_Product}    ${Variable_Main_Product_A}

Set Product C To Main Product
	Set Test Variable   ${Variable_Main_Product_C}    ${Variable_Main_Product_C}

Set Product Inactive To Main Product
	Set Test Variable   ${Variable_Main_Product}    ${Variable_Main_Product_Inactive}
	Set Test Variable   ${Variable_Main_Pkey}    ${Variable_Main_Product_Pkey_Inactive}
	Set Test Variable   ${Variable_Style_PKEY}   ${Variable_Style_PKEY_Inactive}

Set Product B To Main Product
	Set Test Variable   ${Variable_Main_Product_B}    ${Variable_Main_Product_B}
	Set Test Variable   ${Variable_Main_Pkey_B}    ${Variable_Main_Pkey_B}


Set Product Free Public To Main Product Free
	Set Test Variable   ${Variable_Main_Product_Free}    ${Variable_Freebie_Inventory_ID}

Set Product D Free Public To Main Product Free
	Set Test Variable   ${Variable_Main_Product_Free_D}    ${Variable_Freebie_Inventory_ID_D}

Set Style Main Product
	${style_pkey}=        get_style_options_pkey   ${Variable_Main_Product}
	Log To Console        ${style_pkey}
	Set Test Variable     ${Variable_Style_PKEY}   ${style_pkey}

Set Freebie Promotion To Camp Buy A Free B
    [Arguments]         ${main_promotion_total}=None            ${freebie_total}=None       ${promotionname}=None       ${jsonfile}=None
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/${jsonfile}
    ${response_camp}=     Create Promotion Freebie On Camp     ${Variable_Main_Product}    ${main_promotion_total}    ${Variable_Main_Product_Free}    ${freebie_total}    None    None    None    None    None    None    ${promotionname}   ${path_json}
    ${promotion_id}=           Get Json Value     ${response_camp}             /data/id
    Set Test Variable       ${Variable_Promotion_ID}    ${promotion_id}
	Log to console          PromotionID=${Variable_Promotion_ID}

Set Freebie Promotion To Camp Buy C Free D
	[Arguments]    ${main_promotion_total}=None    ${freebie_total}=None    ${promotionname}=None    ${jsonfile}=None
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/${jsonfile}
	${response}=    Create Promotion Freebie On Camp    ${Variable_Main_Product_C}    ${main_promotion_total}    ${Variable_Main_Product_Free_D}    ${freebie_total}    None    None    None    None    None    None    ${promotionname}    ${path_json}
	${promotion_id}=    Get Json Value    ${response}    /data/id
	Set Test Variable    ${Variable_Promotion_ID_2}    ${promotion_id}
	Log to console    PromotionID_2=${Variable_Promotion_ID_2}

Set Freebie Promotion To Camp Buy A-C Free B    [Arguments]    ${main_promotion_total}=None    ${freebie_total}=None    ${promotionname}=None    ${jsonfile}=None
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/${jsonfile}
	${response}=    Create Promotion Freebie On Camp    ${Variable_Main_Product}    ${main_promotion_total}    ${Variable_Main_Product_Free}    ${freebie_total}    ${Variable_Main_Product_B}    None    None    None    None    None    ${promotionname}    ${path_json}
	${promotion_id}=    Get Json Value    ${response}    /data/id
	Set Test Variable    ${Variable_Promotion_ID}    ${promotion_id}
	Log to console    PromotionID=${Variable_Promotion_ID}

Set Freebie Promotion To Camp Buy A-B Free C    [Arguments]    ${main_promotion_total}=None    ${freebie_total}=None    ${promotionname}=None    ${jsonfile}=None
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/${jsonfile}
	${response}=    Create Promotion Freebie On Camp    ${Variable_Main_Product}    ${main_promotion_total}    ${Variable_Main_Product_Free}    ${freebie_total}    ${Variable_Main_Product_B}    None    None    None    None    None    ${promotionname}    ${path_json}

	${promotion_id}=    Get Json Value    ${response}    /data/id
	Set Test Variable    ${Variable_Promotion_ID}    ${promotion_id}
	Log to console    PromotionID=${Variable_Promotion_ID}

Set Freebie Promotion To Camp Buy A Free A Set Repeat
	[Arguments]    ${main_promotion_total}=None    ${freebie_total}=None    ${promotionname}=None    ${jsonfile}=None    ${repeat}=None
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/${jsonfile}
	${response}=    Create Promotion Freebie On Camp    ${Variable_Main_Product}    ${main_promotion_total}    ${Variable_Main_Product}    ${freebie_total}    None    None    None    None    None    None    ${promotionname}    ${path_json}    None    None    None    true    ${repeat}

	${promotion_id}=    Get Json Value    ${response}    /data/id
	Set Test Variable    ${Variable_Promotion_ID}    ${promotion_id}
	Log to console    PromotionID=${Variable_Promotion_ID}

Set Freebie Promotion To Camp Buy A Free B Set Repeat
	[Arguments]    ${main_promotion_total}=None    ${freebie_total}=None    ${promotionname}=None    ${jsonfile}=None    ${repeat}=None
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/${jsonfile}
	${response}=    Create Promotion Freebie On Camp    ${Variable_Main_Product}    ${main_promotion_total}    ${Variable_Main_Product_Free}    ${freebie_total}    None    None    None    None    None    None    ${promotionname}    ${path_json}    None    None    None    true    ${repeat}
	${promotion_id}=    Get Json Value    ${response}    /data/id
	Set Test Variable    ${Variable_Promotion_ID}    ${promotion_id}
	Log to console    PromotionID=${Variable_Promotion_ID}

Set Freebie Promotion To Camp Buy A Free A
	[Arguments]    ${main_promotion_total}=None    ${freebie_total}=None    ${promotionname}=None    ${jsonfile}=None    ${repeat}=None
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/${jsonfile}
	${response}=    Create Promotion Freebie On Camp    ${Variable_Main_Product}    ${main_promotion_total}    ${Variable_Main_Product}    ${freebie_total}    None    None    None    None    None    None    ${promotionname}    ${path_json}
	${promotion_id}=    Get Json Value    ${response}    /data/id
	Set Test Variable    ${Variable_Promotion_ID}    ${promotion_id}
	Log to console    PromotionID=${Variable_Promotion_ID}

Freebie Add To Cart - Delete Promotion Camp
	Delete Promotion Freebie On Camp    ${Variable_Promotion_ID}

Freebie Add To Cart - Delete Promotion Camp 2
	Delete Promotion Freebie On Camp    ${Variable_Promotion_ID_2}

Open Level D Main Product A
	Open Browser  ${ITM_URL}/products/item-${Variable_Main_Pkey}.html    ${BROWSER}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Open Level D Main Product B
	Open Browser    ${ITM_URL}/products/item-${Variable_Main_Pkey_B}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Open Level D Main Product C
	Open Browser      ${ITM_URL}/products/item-${Variable_Main_Pkey_C}.html
	Wait Until Element Is Not Visible     ${LvD_LoadingImg}   15

Open Level D On Mobile Product A
	Open Browser  ${ITM_MOBILE_URL}/products/item-${Variable_Main_Pkey}.html    ${BROWSER}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Go To Level D Main Product A
	Log To Console       ${Variable_Main_Pkey}
	Log To Console    \nURL LvD Product A = ${ITM_URL}/products/item-${Variable_Main_Pkey}.html \n
	Go To      ${ITM_URL}/products/item-${Variable_Main_Pkey}.html
	Wait Until Element Is Not Visible     ${LvD_LoadingImg}   15

Go To Level D Main Product B
	Log To Console    \nURL LvD Product B = ${ITM_URL}/products/item-${Variable_Main_Pkey_B}.html \n
	Go To    ${ITM_URL}/products/item-${Variable_Main_Pkey_B}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Go To Level D Main Product C
	Log To Console       ${Variable_Main_Pkey_C}
	Go To      ${ITM_URL}/products/item-${Variable_Main_Pkey_C}.html
	Wait Until Element Is Not Visible     ${LvD_LoadingImg}   15

Go To Level D On Mobile Main Product B
	Go To    ${ITM_MOBILE_URL}/products/item-${Variable_Main_Pkey_B}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Open Level D Product Free
	Open Browser  ${ITM_URL}/products/item-${Variable_Freebie_Free_Pkey}.html    ${BROWSER}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Go To Level D Product Free
	Go To    ${ITM_URL}/products/item-${Variable_Freebie_Free_Pkey}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Open Level D Product Free D
	Open Browser  ${ITM_URL}/products/item-${Variable_Freebie_Free_Pkey}.html    ${BROWSER}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Go To Level D Product Free D
	Go To    ${ITM_URL}/products/item-${Variable_Freebie_Free_Pkey}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Open Level D Mobile Product Free
	Open Browser  ${ITM_MOBILE_URL}/products/item-${Variable_Freebie_Free_Pkey}.html    ${BROWSER}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Go To Level D From PKeyFreebie
	Go To    ${ITM_URL}/products/item-${Variable_Freebie_Free_Pkey}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Go To Level D From PKeyFreebie Mobile
	Go To   ${ITM_MOBILE_URL}/products/item-${Variable_Freebie_Free_Pkey}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Click Element Variable Style PKEY A
    Sleep           3s
	Wait Until Element Is Not Visible      ${LvD_LoadingImg}   30
	${Variable_Style_PKEY}=     Convert to String           ${Variable_Style_PKEY}
	${element}=     Replace String      ${XPATH_LEVEL_D.btn_style_option_pkey}   ^^style-option-pkey^^   ${Variable_Style_PKEY}
	Wait Until Element Is Visible    ${element}       60
	Click Element    ${element}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20


Click Element Variable Style PKEY A Select Color
    Sleep           3s
	Wait Until Element Is Not Visible      ${LvD_LoadingImg}   30
	#${Variable_Style_PKEY}=     Convert to String           ${Variable_Style_PKEY}
	#${element}=     Replace String      ${XPATH_LEVEL_D.btn_style_option_pkey}   ^^style-option-pkey^^   ${Variable_Style_PKEY}
    #Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_style_option_pkey_select_color}       60
    #${Obj_SelectColor_01}    Get Matching xpath count    ${element}
    #Run Keyword If    ${Obj_SelectColor_01} > 0    Click Element    ${element}
    #Run Keyword If    ${Obj_SelectColor_01} = 0    Click Element    ${XPATH_LEVEL_D.btn_style_option_pkey_select_color}
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_style_option_pkey_select_color}       60
    Click Element    ${XPATH_LEVEL_D.btn_style_option_pkey_select_color}
    Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Check Element Box Amount ReadOnly
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_box_amount_readonly}       60


Click Element Variable Style PKEY B
	Wait Until Element Is Not Visible      ${LvD_LoadingImg}       30s
	${Variable_Style_PKEY_B}=       Convert to String       ${Variable_Style_PKEY_B}
	${element}=     Replace String      ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^       ${Variable_Style_PKEY_B}
	Wait Until Element Is Visible          ${element}              15
	Click Element      ${element}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Click Element Variable Style PKEY A On Mobile
    Sleep           3s
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	${Variable_Style_PKEY}=     Convert to String      ${Variable_Style_PKEY}
	${element}=  Replace String  ${XPATH_LEVEL_D_MOBILE.btn_style_option_pkey}   ^^style-option-pkey^^   ${Variable_Style_PKEY}
	Wait Until Element Is Visible    ${element}       60
	Click Element    ${element}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Click Element Variable Style PKEY B On Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

	${Variable_Style_PKEY_B}=     Convert to String      ${Variable_Style_PKEY_B}
	${element}=  Replace String  ${XPATH_LEVEL_D_MOBILE.btn_style_option_pkey}   ^^style-option-pkey^^   ${Variable_Style_PKEY_B}
	Wait Until Element Is Visible    ${element}       60
	Click Element    ${element}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Increase Product Quantity
    Sleep           3s
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Visible    ${XPATH_LEVEL_D.step_arrow_up}      60
	Click Element    ${XPATH_LEVEL_D.step_arrow_up}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Decrease Product Quantity
    Sleep           3s
	Wait Until Element Is Visible    ${XPATH_LEVEL_D.step_arrow_down}      60
	Click Element    ${XPATH_LEVEL_D.step_arrow_down}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Click Button Add To Cart
	Sleep           3s
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_add_to_cart_enable}      60
	Click Element    ${XPATH_LEVEL_D.btn_add_to_cart_enable}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20

Click Button Add To Cart On Mobile
    Sleep           3s
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   30
	Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.buy_button_id}      60
	Click Element    ${XPATH_LEVEL_D_MOBILE.buy_button_id}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   30

Click Button2 Add To Cart On Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   30
	Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.buy_button_class}      60
	Click Element    ${XPATH_LEVEL_D_MOBILE.buy_button_class}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   30

Increase Product Quantity Mobile
	[Arguments]    ${amount}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Sleep   3
	Select From List    ${select_qty_as_2}    ${amount}

Click Alert Box
	Wait Until Element Is Visible   ${alert-box-popup_ok}   15
	Click Element    ${alert-box-popup_ok}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Click Alert Box Mobile
	Wait Until Element Is Visible   ${alert-box-popup_ok_mobile}   15
	Click Element    ${alert-box-popup_ok_mobile}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15

Expected Result Button Is Disable
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   30
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_add_to_cart_disable}   20
#    Wait Until Element Is Visible    //button[@class="btn_order product-addtocart btn-color-primary disabled"]   20
	Element Should Be Visible    ${XPATH_LEVEL_D.btn_add_to_cart_disable}
#	Element Should Be Visible    //button[@class="btn_order product-addtocart btn-color-primary disabled"]

Expected Result Button Is Disable On Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.btn_add_to_cart_disable}   20
	Element Should Be Visible    ${XPATH_LEVEL_D_MOBILE.btn_add_to_cart_disable}

Expected Result Out Of Stock
 	Element Should Be Visible    ${Cart_Popup_Header}

Expected Result Out Of Stock Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Page Should Contain    สินค้าคงเหลือไม่เพียงพอ

Expected Result Have Button Go Next
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Visible    ${CartLightBox_NextBtn}   60
	Element Should Be Visible    ${CartLightBox_NextBtn}

Expected Result Have Button Go Next Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.btn_go_next}   60
	Element Should Be Visible    ${XPATH_LEVEL_D_MOBILE.btn_go_next}

Expected Result Have Button Go Next Mobile Visible
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.btn_mobile_go_next}   60
	Element Should Be Visible    ${XPATH_LEVEL_D_MOBILE.btn_mobile_go_next}

Expected Result Not Have Free Product
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15
	Element Should Not Be Visible     ${CartLightBox_FreebieItemList}

Expected Result Have Free Product
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   15
	Wait Until Element Is Visible    ${CartLightBox_FreebieItemList}   60
	Element Should Be Visible     ${CartLightBox_FreebieItemList}

Expected Result Not Have Free Product On Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Not Visible   //div[@data-type='freebie']   60
	Element Should Not Be Visible    //div[@data-type='freebie']

Expected Result Have Free Product On Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Visible    //div[@data-type='freebie']    60
	Element Should Be Visible    //div[@data-type='freebie']


Expected Result Amount Have 2 ITEM
	Wait Until Element Is Visible   ${CartLightBox_NextBtn}   15
	Wait Until Element Is Visible    ${amount-in-cart-have-2-item}    60
	Element Should Be Visible    ${amount-in-cart-have-2-item}

Expected Result Amount Mobile
	[Arguments]    ${amount}
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Visible    ${amount-in-cart-mobile}/option${amount}    60
	Element Should Be Visible    ${amount-in-cart-mobile}/option${amount}

Expected Result Have Product A
	Wait Until Element Is Visible   ${CartLightBox_NextBtn}   15
	Wait Until Element Is Visible    ${amount-in-cart-have-2-item}    60
	Element Should Be Visible    ${amount-in-cart-have-2-item}

Expected Result Not Have Camp Short Descript Mobile
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Not Visible   ${camp_short_description-mobile}   60
	Element Should Not Be Visible    ${camp_short_description-mobile}

Expected Result Not Have Camp Short Descript
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Wait Until Element Is Not Visible   ${camp_short_description}   60
	Element Should Not Be Visible    ${camp_short_description}


Expected Result Have Camp Short Descript Mobile
	Wait Until Element Is Visible   ${camp_short_description-mobile}   15
	Wait Until Element Is Visible    ${camp_short_description-mobile}    60
	Element Should Be Visible    ${camp_short_description-mobile}

Expected Result Have Camp Short Descript
	Wait Until Element Is Visible   ${camp_short_description}   15
	Wait Until Element Is Visible    ${camp_short_description}    60
	Element Should Be Visible    ${camp_short_description}

Expected Result Can Not Add Product Wow Duplicate To Cart
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Sleep   3
	Page Should Contain    คุณมีสินค้าชิ้นนี้ในตะกร้าแล้ว ขอสงวนสิทธิ์การสั่งซื้อสินค้าราคาพิเศษ 1 ชิ้นต่อ 1 คำสั่งซื้อเท่านั้นค่ะ

Freebie Add To Cart - Add Product Bundle To Cart
	keywords_prepare_bundle.Random Id Card
    Get TruemoveH Mobile Id     ${var_tmh_mobile_province_id}   ${var_tmh_mobile_type}   ${var_tmh_product_device_inventory_id}    ${var_tmh_price_plan_id}
	${mobile_id}=        Convert To String              ${var_tmh_mobile_id}
	${id_card}=          Convert To String              ${var_random_id_card}
	${price_plan}=       Convert To String              ${var_tmh_price_plan_id}
    ${customer_type}=    Convert To String              ${TV_user_group}
    ${customer_type}=    Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/add_bundle_to_cart.json
	${response}=   API Cart - Add Bundle    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${TV_user_id}   ${customer_type}     ${mobile_id}     ${id_card}    ${price_plan}   None   None   ${path_json}
    Log To Console    ${response}
    ${code}=   Get Json Value   ${response}   /code
    Set Test Variable     ${var_response_add_bundle_to_cart}   ${response}
    Set Test Variable     ${var_code_add_bundle_to_cart}     ${code}

Freebie Add To Cart - Add Product Sim To Cart
    keywords_prepare_bundle.Random Id Card
    Get TruemoveH Data For Search Available Mobile Number Sim
    Get TruemoveH Mobile Id For Sim     ${var_tmh_sim_mobile_province_id}   ${var_tmh_sim_mobile_type}
    ${mobile_id}=        Convert To String              ${var_tmh_sim_mobile_id}
    ${price_plan}=       Convert To String              ${var_tmh_sim_mobile_price_plan_id}
    ${id_card}=          Convert To String              ${var_random_id_card}
    ${customer_type}=    Convert To String              ${TV_user_group}
    ${customer_type}=    Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/add_sim_to_cart.json
    ${response}=   API Cart - Add Sim    ${var_tmh_sim_inventory_id}   ${TV_user_id}   ${customer_type}   ${mobile_id}   ${id_card}   ${price_plan}   None   None   ${path_json}
    Set Test Variable     ${var_response_add_sim_to_cart}     ${response}

Freebie Add To Cart - Add Product Sim To Cart By Inventory Id
    [Arguments]     ${inventory_id}
    keywords_prepare_bundle.Random Id Card
    Get TruemoveH Data For Search Available Mobile Number Sim
    Get TruemoveH Mobile Id For Sim     ${var_tmh_sim_mobile_province_id}   ${var_tmh_sim_mobile_type}
    ${mobile_id}=        Convert To String              ${var_tmh_sim_mobile_id}
    ${price_plan}=       Convert To String              ${var_tmh_sim_mobile_price_plan_id}
    ${id_card}=          Convert To String              ${var_random_id_card}
    ${customer_type}=    Convert To String              ${TV_user_group}
    ${customer_type}=    Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/add_sim_to_cart.json
    ${response}=   API Cart - Add Sim    ${inventory_id}   ${TV_user_id}   ${customer_type}   ${mobile_id}   ${id_card}   ${price_plan}   None   None   ${path_json}
    Set Test Variable     ${var_response_add_sim_to_cart}     ${response}

Freebie Add To Cart - Cannot Add Bundle To Cart
    Should Not Be Equal As Numbers      200     ${var_code_add_bundle_to_cart}

Freebie Add To Cart - Rebuild Stock No Variant
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK-NO-VARIANT}?product_pkey=${Variable_Main_Pkey}&data_inv_id=${Variable_Main_Product_A}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s
