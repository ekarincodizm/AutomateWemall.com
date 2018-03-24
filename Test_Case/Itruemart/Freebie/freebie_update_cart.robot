*** Settings ***
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

Suite Teardown  Selenium2Library.Close All Browsers

*** Variables ***
${start_normal}               14
${start_normal_b}             16
${start_normal_c}             18
${start_free}                 3

*** Test Cases ***
TC_iTM_00654 : Decrease primary item till not apply the rule in camp
    [Tags]    TC_iTM_00654        set6      ready
    Prepare Main Product A
	Prepare Stock Main Product A            10
	Prepare Main Product B
	Prepare Stock Main Product B            10
	Prepare Product Free Public
	Prepare Stock Product Free Public       10
	Set Product A To Main Product
	Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_B}
	Set Freebie Promotion To Camp Buy A-C Free B    5    2   Buy 3 (product A, B) Get 2 (product C) Free    camp_json_2main_1free.json

#	Login User to iTrueMart With User Freebie
    Open Level D Main Product A
    Increase Product Quantity
    Increase Product Quantity
    Click Button Add To Cart

	Go To Level D Main Product B
	Increase Product Quantity
	Increase Product Quantity
	Click Button Add To Cart
	Display Full Cart
    Sleep             5s
	Full Cart - Display Normal Product First Item 3 Qty
	Full Cart - Display Normal Product Second Item 3 Qty
	Full Cart - Display Free Product First Item 2 Qty
	Full Cart - Display Camp Short Description

	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_A}   2
	Wait Until Ajax Loading Is Not Visible
	Full Cart - Display Normal Product First Item 2 Qty
	Full Cart - Display Normal Product Second Item 3 Qty
	Full Cart - Display Free Product First Item 2 Qty
	Full Cart - Display Camp Short Description

	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_A}   1
	Wait Until Ajax Loading Is Not Visible
	Full Cart - Display Normal Product First Item 1 Qty
	Full Cart - Display Normal Product Second Item 3 Qty
	Full Cart - Do Not Display Product Free On Full Cart
	Full Cart - Do Not Display Camp Short Description

	[Teardown]  Run Keywords  Prepare Default Stock Main Product
	                          Prepare Default Stock Main Product B
	                          Prepare Default Stock Product Free
	                          Freebie Add To Cart - Delete Promotion Camp

TC_iTM_00655 : Increase primary item but not apply the rule in camp
    [Tags]    TC_iTM_00655        set6      ready
    Prepare Main Product A
	Prepare Stock Main Product A    10
	Prepare Main Product B
	Prepare Stock Main Product B    10
	Prepare Product Free Public
	Prepare Stock Product Free Public    10
	Set Product A To Main Product
	Set Product Free Public To Main Product Free
	Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_B}
	Set Freebie Promotion To Camp Buy A-C Free B    5    2   Buy 3 (product A, B) Get 2 (product C) Free    camp_json_2main_1free.json

#	Login User to iTrueMart With User Freebie
    Open Level D Main Product A
    Click Button Add To Cart

	Go To Level D Main Product B
	Click Button Add To Cart
	Display Full Cart
    Sleep             5s
	Full Cart - Display Normal Product First Item 1 Qty
	Full Cart - Display Normal Product Second Item 1 Qty
	Full Cart - Do Not Display Product Free On Full Cart
	Full Cart - Do Not Display Camp Short Description

	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_A}   3
	Wait Until Ajax Loading Is Not Visible
	Full Cart - Display Normal Product First Item 3 Qty
	Full Cart - Display Normal Product Second Item 1 Qty
	Full Cart - Do Not Display Product Free On Full Cart
	Full Cart - Do Not Display Camp Short Description
#
	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_A}   2
	Wait Until Ajax Loading Is Not Visible
	Full Cart - Display Normal Product First Item 2 Qty
	Full Cart - Display Normal Product Second Item 1 Qty
	Full Cart - Do Not Display Product Free On Full Cart
	Full Cart - Do Not Display Camp Short Description

	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_A}   1
	Wait Until Ajax Loading Is Not Visible
	Full Cart - Display Normal Product First Item 1 Qty
	Full Cart - Display Normal Product Second Item 1 Qty
	Full Cart - Do Not Display Product Free On Full Cart
	Full Cart - Do Not Display Camp Short Description

	[Teardown]  Run Keywords  Prepare Default Stock Main Product
	                          Prepare Default Stock Main Product B
	                          Prepare Default Stock Product Free
	                          Freebie Add To Cart - Delete Promotion Camp

TC_iTM_00656 : Increase primary item and match the rule in camp
	[Tags]    TC_iTM_00656        set6      ready
	Prepare Main Product A
	Set Product A To Main Product
	Prepare Product Free Public
	Prepare Stock Main Product A    10
	Prepare Stock Product Free Public    10
	Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
	Set Freebie Promotion To Camp Buy A Free B    2    1   Buy 1 (variant A of product B) Get 2 (variant A of product B) Free    camp_json_1main_1free.json
	Prepare Main Product C
	Set Product C To Main Product
	Prepare Product D Free Public
	Prepare Stock Main Product C    10
	Prepare Stock Product D Free Public    10
	Set Product D Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_C}
	Set Freebie Promotion To Camp Buy C Free D    5    2   Buy 1 (variant C of product D) Get 5 (variant C of product D) Free    camp_json_1main_1free.json

#    Login User to iTrueMart With User Freebie
	Open Level D Main Product A
	Increase Product Quantity
	Click Button Add To Cart
	Go To Level D Product Free
	Click Button Add To Cart
    Go To Level D Main Product C
    Click Button Add To Cart
    Display Full Cart
    Sleep             5s

	Full Cart - Display Normal Product First Item 2 Qty
	Full Cart - Display Normal Product Second Item 1 Qty
	Full Cart - Display Normal Product Third Item 1 Qty
	Full Cart - Display Free Product First Item 1 Qty
	Full Cart - Display Camp Short Description

	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_C}   5
    Wait Until Ajax Loading Is Not Visible
    Full Cart - Display Normal Product First Item 2 Qty
	Full Cart - Display Normal Product Second Item 1 Qty
	Full Cart - Display Normal Product Third Item 5 Qty
	Full Cart - Display Free Product First Item 1 Qty
	Full Cart - Display Free Product Second Item 2 Qty
	Full Cart - Display Camp Short Description
    Full Cart - Count Camp Short Description            2

	[Teardown]  Run Keywords  Prepare Default Stock Main Product
                              Prepare Default Stock Main Product C
                              Prepare Default Stock Product Free
                              Prepare Default Stock Product D Free
                              Freebie Add To Cart - Delete Promotion Camp
                              Freebie Add To Cart - Delete Promotion Camp 2

TC_iTM_00657 : Increase primary item till some primary item is out of stock
    [Tags]    TC_iTM_00657        set6      ready
    Prepare Main Product A
	Prepare Stock Main Product A    5
	Prepare Main Product B
	Prepare Stock Main Product B    3
	Prepare Product Free Public
	Prepare Stock Product Free Public    10
	Set Product A To Main Product
	Set Product Free Public To Main Product Free
	Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_B}
	Set Freebie Promotion To Camp Buy A-C Free B    3    2   Buy 3 (product A, B) Get 2 (product C) Free    camp_json_2main_1free.json

	Open Level D Main Product A
	Increase Product Quantity
	Increase Product Quantity
	Click Button Add To Cart

    Go To Level D Product Free
    Increase Product Quantity
	Click Button Add To Cart

	Go To Level D Main Product B
	Increase Product Quantity
	Increase Product Quantity
	Click Button Add To Cart
	Display Full Cart
    Sleep             5s

	Full Cart - Display Normal Product First Item 3 Qty
	Full Cart - Display Normal Product Second Item 2 Qty
	Full Cart - Display Normal Product Third Item 3 Qty
	Full Cart - Display Free Product First Item 4 Qty
	Full Cart - Display Camp Short Description

	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_B}   5
	Confirm Action
	Wait Until Ajax Loading Is Not Visible
    Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Normal Product Second Item 2 Qty
	Full Cart - Display Normal Product Third Item 3 Qty
	Full Cart - Display Free Product First Item 4 Qty
	Full Cart - Display Camp Short Description
	[Teardown]  Run Keywords  Prepare Default Stock Main Product
	                          Prepare Default Stock Main Product B
	                          Prepare Default Stock Product Free
	                          Freebie Add To Cart - Delete Promotion Camp

TC_iTM_00658 : Increase primary item till free item is out of stock
    [Tags]    TC_iTM_00658        set6      ready
    Prepare Main Product A
	Prepare Stock Main Product A    10
	Prepare Main Product B
	Prepare Stock Main Product B    10
	Prepare Product Free Public
	Prepare Stock Product Free Public    5
	Set Product A To Main Product
	Set Product Free Public To Main Product Free
	Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_B}
	Set Freebie Promotion To Camp Buy A-C Free B    3    2   Buy 3 (product A, B) Get 2 (product C) Free    camp_json_2main_1free.json
    User Open Home page
    Freebie Add To Cart - Rebuild Stock No Variant
	Open Level D Main Product A
	Increase Product Quantity
	Increase Product Quantity
	Click Button Add To Cart
    Go To Level D Main Product B
	Increase Product Quantity
	Increase Product Quantity
	Click Button Add To Cart
	Display Full Cart
	Sleep             5s
	Full Cart - Display Normal Product First Item 3 Qty
	Full Cart - Display Normal Product Second Item 3 Qty
	Full Cart - Display Free Product First Item 4 Qty
	Full Cart - Display Camp Short Description
	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_B}   5
	Wait Until Ajax Loading Is Not Visible
	CartLightBox - Select Quantity Product Normal By Inventory Id   ${Variable_Main_Product_A}   4
    Sleep             5s
	Confirm Action
	Wait Until Ajax Loading Is Not Visible
	Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Normal Product Second Item 5 Qty
    Full Cart - Display Free Product First Item 4 Qty
    Full Cart - Display Camp Short Description
	[Teardown]  Run Keywords  Prepare Default Stock Main Product
	                          Prepare Default Stock Main Product B
	                          Prepare Default Stock Product Free
	                          Freebie Add To Cart - Delete Promotion Camp

TC_iTM_00659 : Remove some parimary item from cart
    [Tags]    TC_iTM_00659        set6      ready
    Prepare Main Product A
	Prepare Stock Main Product A    10
	Prepare Main Product B
	Prepare Stock Main Product B    10
	Prepare Product Free Public
	Prepare Stock Product Free Public    5
	Set Product A To Main Product
	Set Product Free Public To Main Product Free
	Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_B}
	Set Freebie Promotion To Camp Buy A-C Free B    3    2   Buy 3 (product A, B) Get 2 (product C) Free    camp_json_2main_1free.json
	Open Level D Main Product A
	Increase Product Quantity
	Click Button Add To Cart
    Go To Level D Main Product B
	Click Button Add To Cart
	Sleep               5s
	Full Cart - Display Normal Product First Item 2 Qty
	Full Cart - Display Normal Product Second Item 1 Qty
	Full Cart - Display Free Product First Item 2 Qty
	Full Cart - Display Camp Short Description
	User Click Remove Second Item
    Wait Until Ajax Loading Is Not Visible
    Sleep              5s
	Full Cart - Display Normal Product First Item 2 Qty
	Full Cart - Do Not Display Normal Product Second Item
	Full Cart - Do Not Display Product Free On Full Cart
	Full Cart - Do Not Display Camp Short Description
	[Teardown]  Run Keywords  Prepare Default Stock Main Product
	                          Prepare Default Stock Main Product B
	                          Prepare Default Stock Product Free
	                          Freebie Add To Cart - Delete Promotion Camp

TC_iTM_00660 : Remove all parimary item from cart
	[Tags]    TC_iTM_00660        set6      ready
	Prepare Main Product A
	Set Product A To Main Product
	Prepare Product Free Public
	Prepare Stock Main Product A            10
	Prepare Stock Product Free Public       10
	Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_A}
	Set Freebie Promotion To Camp Buy A Free B    2    1   Buy 1 (variant A of product B) Get 2 (variant A of product B) Free    camp_json_1main_1free.json
	Prepare Main Product C
	Set Product C To Main Product
	Prepare Product D Free Public
	Prepare Stock Main Product C    10
	Prepare Stock Product D Free Public    10
	Set Product D Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id     ${Variable_Main_Product_C}
	Set Freebie Promotion To Camp Buy C Free D    5    2   Buy 1 (variant C of product D) Get 5 (variant C of product D) Free    camp_json_1main_1free.json
	Open Level D Main Product A
	Increase Product Quantity
	Click Button Add To Cart
	Go To Level D Main Product C
	Increase Product Quantity
	Increase Product Quantity
	Increase Product Quantity
	Increase Product Quantity
	Click Button Add To Cart
    Sleep               5s
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Normal Product Second Item 5 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Free Product Second Item 2 Qty
    Full Cart - Display Camp Short Description
    Full Cart - Count Camp Short Description        2
	User Click Remove First Item
	Full Cart - Display Normal Product First Item 5 Qty
    Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Camp Short Description
    Full Cart - Count Camp Short Description        1
	User Click Remove First Item
    Sleep               5s
	No Items In Cart
	Full Cart - Do Not Display Camp Short Description
	[Teardown]  Run Keywords  Prepare Default Stock Main Product
                              Prepare Default Stock Main Product C
                              Prepare Default Stock Product Free
                              Prepare Default Stock Product D Free
                              Freebie Add To Cart - Delete Promotion Camp
                              Freebie Add To Cart - Delete Promotion Camp 2