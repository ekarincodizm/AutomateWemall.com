*** Settings ***
Force Tags    WLS_Freebie
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_add_to_cart.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_add_to_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/WebElement_CartLightBox.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_pop_up/Keywords_CartPopUp.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_pop_up/WebElement_CartPopUp.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Bundle/Keywords_CAMP_Bundle.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/WebElement_LevelD.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot

#Suite Teardown  Selenium2Library.Close All Browsers
*** Variables ***
${start_normal}               13
${start_normal_c}             15
${start_free}                 17

*** Test Cases ***
TC_iTM_00649 : Merge cart between bundle with freebie item (same SKU)
    [Tags]    TC_iTM_00649    regression    WLS_High    freebie     ready
    User Open Home page
#    Clear Cart Current User
    Prepare TruemoveH Product Bundle On PCMS
    Prepare TruemoveH Product Bundle On CAMP
    Fix Product Main Public     ${var_tmh_product_device_inventory_id}
    Prepare Stock Main Product A    10
    Set Product A To Main Product
    Set Style Main Product
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${var_tmh_product_device_inventory_id}
    Set Freebie Promotion To Camp Buy A Free B   2    1   Buy 2 (product A Bundle) Get 1 (Product B) Free    camp_json_1main_1free.json
    User Open Home page
    Login User to iTrueMart With User Freebie
    Clear Cart Current User
    Freebie Add To Cart - Add Product Bundle To Cart
    Go To Level D Main Product A
    #
    Click Element Variable Style PKEY A Select Color
    #
    Click Button Add To Cart
    #Click Cart Box Button
    Full Cart - Display Bundle Product First Item 1 Qty
    Go To Logout
    Sleep           3s
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    Increase Product Quantity
    Click Button Add To Cart
    Display Full Cart
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    Display Checkout Step1 Page
    User Select Buy As Member
    Checkout 1 - User Enter Valid Data As Member Freebie on Checkout1
    User Click Next Button On Checkout1
    Display Checkout Step2 Page
    Mini Cart - Display Normal Product First Item 2 Qty
    Mini Cart - Display Free Product First Item 1 Qty
    User Click Edit Cart On Mini Cart
    Display Full Cart
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description
    [Teardown]  Run Keywords  Prepare Default Stock Main Product
                              Prepare Default Stock Product Free
                              Freebie Add To Cart - Delete Promotion Camp
                              Delete TruemoveH Product Bundle On CAMP
	                          Delete TruemoveH Product Bundle On PCMS

TC_iTM_00650 : Merge cart between freebie with bundle item (same SKU)
    [Tags]    TC_iTM_00650    regression    WLS_Medium    freebie     ready
    User Open Home page
    Clear Cart Current User
    Prepare TruemoveH Product Bundle On PCMS
    Prepare TruemoveH Product Bundle On CAMP
    Fix Product Main Public     ${var_tmh_product_device_inventory_id}
    Log To Console    \nvar_tmh_product_device_inventory_id =${var_tmh_product_device_inventory_id}\n
    Prepare Stock Main Product A    10
    Set Product A To Main Product
    Set Style Main Product
    Fix Product Free Public    ${var_tmh_device_sub_inventory_id}
	Prepare Stock Product Free Public    10
	Set Product Free Public To Main Product Free
    User Open Home page
    Login User to iTrueMart With User Freebie
    Clear Cart Current User
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    Click Button Add To Cart
    Freebie Add To Cart - Add Product Sim To Cart By Inventory Id      ${var_tmh_device_sub_inventory_id}
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    #Click Cart Box Button
    #keywords_header.Click Cart Box Button
    #keywords_wemall_header.Click Cart Box Button
    Click Button Add To Cart
    Display Full Cart
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Sim Product First Item 1 Qty
    Full Cart - Do Not Display Product Free On Full Cart
    Full Cart - Do Not Display Camp Short Description
    Go To Logout
    Sleep           3s
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${var_tmh_product_device_inventory_id}
    Set Freebie Promotion To Camp Buy A Free B   2    1   Buy 2 (product A Bundle) Get 1 (Product B) Free    camp_json_1main_1free.json
    Clear Cart Current User
    Freebie Add To Cart - Add Product Bundle To Cart
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    Click Button Add To Cart
    Click Alert Box
    Go To           ${WEMALL_URL}/checkout/step1
    User Click Edit Cart On Mini Cart
    Display Full Cart
    Full Cart - Display Bundle Product First Item 1 Qty
    [Teardown]  Run Keywords  Prepare Default Stock Main Product
                              Prepare Default Stock Product Free
                              Freebie Add To Cart - Delete Promotion Camp
                              Delete TruemoveH Product Bundle On CAMP
	                          Delete TruemoveH Product Bundle On PCMS

TC_iTM_00652 : Merge cart between freebie item 1 promotion
    [Tags]    TC_iTM_00652    regression    WLS_High    freebie     ready
	User Open Home page
	Login User to iTrueMart With User Freebie
	Clear Cart Current User
    Sleep           3s
	Prepare Main Product A
	Set Product A To Main Product
	Prepare Product Free Public
	Prepare Stock Main Product A    10
	Prepare Stock Product Free Public    10
	Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
	Set Freebie Promotion To Camp Buy A Free B Set Repeat    1    1   Buy 1 (variant A of product A) Get 1 (variant A of product A) Free    camp_json_1main_1free.json    2
	Go To Level D Main Product A
	Increase Product Quantity
	Click Button Add To Cart
	Wait Until Ajax Loading Is Not Visible
    User Click Next Process On Full Cart
	Go To Logout
	Go To Level D Main Product A
	Increase Product Quantity
	Click Button Add To Cart
    Sleep           3s
	Expected Result Have Free Product
	Expected Result Have Camp Short Descript
	User Click Next Process On Full Cart
	Display Checkout Step1 Page
	User Select Buy As Member
    Checkout 1 - User Enter Valid Data As Member Freebie on Checkout1
	User Click Next Button On Checkout1
	Mini Cart - Display Normal Product First Item 4 Qty
    Mini Cart - Display Free Product First Item 2 Qty
	[Teardown]  Run Keywords  Prepare Default Stock Main Product
                              Prepare Default Stock Product Free
                              Freebie Add To Cart - Delete Promotion Camp

TC_iTM_00653 : Merge cart between freebie item 2 promotion
	[Tags]    TC_iTM_00653    regression    WLS_High    freebie     ready
	User Open Home page
	Login User to iTrueMart With User Freebie
	Clear Cart Current User
	Sleep           3s
	Prepare Main Product A
	Set Product A To Main Product
	Prepare Product Free Public
	Prepare Stock Main Product A    10
	Prepare Stock Product Free Public    10
	Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
	Set Freebie Promotion To Camp Buy A Free B    2    1   Buy 1 (variant A of product B) Get 1 (variant A of product B) Free    camp_json_1main_1free.json
	Prepare Main Product C
	Set Product C To Main Product
	Prepare Product D Free Public
	Prepare Stock Main Product C    10
	Prepare Stock Product D Free Public    10
	Set Product D Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_C}
	Set Freebie Promotion To Camp Buy C Free D    2    3   Buy 1 (variant C of product D) Get 1 (variant C of product D) Free    camp_json_1main_1free.json
	Go To Level D Main Product C
	Increase Product Quantity
	Click Button Add To Cart
	Wait Until Ajax Loading Is Not Visible
	User Click Next Process On Full Cart
	Go To Logout
	Go To Level D Main Product A
	Increase Product Quantity
	Click Button Add To Cart
	Expected Result Have Free Product
	Expected Result Have Camp Short Descript
	User Click Next Process On Full Cart
	Display Checkout Step1 Page
	User Select Buy As Member
    Checkout 1 - User Enter Valid Data As Member Freebie on Checkout1
	User Click Next Button On Checkout1
	Mini Cart - Display Normal Product First Item 2 Qty
    Mini Cart - Display Free Product First Item 1 Qty
    Mini Cart - Display Normal Product Second Item 2 Qty
    Mini Cart - Display Free Product Second Item 3 Qty
	[Teardown]  Run Keywords  Prepare Default Stock Main Product
                              Prepare Default Stock Main Product C
                              Prepare Default Stock Product Free
                              Prepare Default Stock Product D Free
                              Freebie Add To Cart - Delete Promotion Camp
                              Freebie Add To Cart - Delete Promotion Camp 2
