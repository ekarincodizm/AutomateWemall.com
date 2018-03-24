*** Settings ***
Force Tags    WLS_Freebie
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
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

*** Variables ***
${start_normal}    0
${start_3variant}    0
${start_free}     3
#${start_normal}               14
#${start_normal_b}             16
${start_normal_b}             10
${start_normal_c}             18
#${start_free}                 3

*** Test Cases ***
TC_iTM_00625 : Can not be added primary item to cart when primary item is out of stock but free item is enough
    [Tags]    TC_iTM_00625    regression    WLS_Low    out_of_stock    freebie    ready
    Prepare Main Product Have 3 Variant Inactive
    Prepare Stock Main Product Inactive    0
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product Inactive To Main Product
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_Inactive}
    Set Freebie Promotion To Camp Buy A Free B    2    1    Buy 2 (variant C of product A) Get 1 (product B)    camp_json_1main_1free.json
    Open Level D Main Product A
    Click Element Variable Style PKEY A
    Log To Console    *** Expected Result Button Is Disable *** \n Button_Add_To_Cart=${XPATH_LEVEL_D.btn_add_to_cart_disable}
    Expected Result Button Is Disable
    Open Level D On Mobile Product A
    Click Element Variable Style PKEY A On Mobile
    Expected Result Button Is Disable On Mobile
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Selenium2Library.Close All Browsers
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00626 :Can not be added primary item to cart when primary item is out of stock and free item is not enough for freebie campaign
    [Tags]    TC_iTM_00626    regression    WLS_Low    out_of_stock    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    0
    Prepare Product Free Public Have 3 Variant Active
    Prepare Stock Product Free Public    10
    Set Product A To Main Product
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    2    3    Buy 2 (product A) Get 3 (variant A of product B) Free    camp_json_1main_1free.json
    Open Level D Main Product A
    Expected Result Button Is Disable
    Open Level D On Mobile Product A
    Expected Result Button Is Disable On Mobile
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Selenium2Library.Close All Browsers
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00627 : Can buy free item same as normal product althought that free item is not enough for freebie campaign
    [Tags]    TC_iTM_00627    regression    WLS_Medium    add_to_cart_success    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    5
    Prepare Product Free Public
    Prepare Stock Product Free Public    1
    Set Product A To Main Product
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    5    2    Buy 5 (product A) Get 2 (product B) Free    camp_json_1main_1free.json
    Open Level D Product Free
    Click Button Add To Cart
    Expected Result Have Button Go Next
    Open Level D Mobile Product Free
    Click Button Add To Cart On Mobile
    Expected Result Have Button Go Next Mobile
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Selenium2Library.Close All Browsers
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00628 : Can be added bundle item but not added primary item to cart when primary and free items are out of stock
    [Tags]    TC_iTM_00628    regression    WLS_Low    bundle    freebie    ready    WLS_Bundle
    Prepare Main Product Have 3 Variant Inactive
    Prepare Stock Main Product Inactive    0
    #Prepare Stock Main Product Inactive    9999
    Set Product Inactive To Main Product
    Prepare Main Product Have 3 Variant Inactive B
    Prepare Stock Main Product B    0
    Set Product B To Main Product
    Prepare Product Free Public
    Prepare Stock Product Free Public    0
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_Inactive}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_B}
    Set Freebie Promotion To Camp Buy A-B Free C    2    1    Buy 2 (variant C of product A, variant C of product B) Get 2 (product C) Free    camp_json_2main_1free.json
    User Open Home page
    Clear Cart Current User
    Prepare TruemoveH Product Bundle On PCMS
    Prepare TruemoveH Product Bundle On CAMP
    Freebie Add To Cart - Add Product Bundle To Cart
#    Go To Level D Main Product A
#    Click Element Variable Style PKEY A
    #Increase Product Quantity
#    Click Button Add To Cart
#    Click Cart Box Button
    Go To    ${WEMALL_URL}/checkout/step1
    Sleep    2s
    User Click Edit Cart On Mini Cart
    Full Cart - Display Bundle Product First Item 1 Qty
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    Expected Result Button Is Disable
    Go To Level D Main Product B
    Click Element Variable Style PKEY B
    Expected Result Button Is Disable
    Open Level D Product Free
    Expected Result Button Is Disable
    Prepare Default Stock Main Product B
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Delete TruemoveH Product Bundle On CAMP
    Delete TruemoveH Product Bundle On PCMS
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00629 : Can be added primary item to cart but not get free item when stock of primary item is not enough for freebie campaign but free item is enough
    [Tags]    TC_iTM_00629    regression    WLS_Low    add_to_cart_success    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    1
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product A To Main Product
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    3    2    Buy 3 (product A) Get 2 (product B) Free    camp_json_1main_1free.json
    Open Level D Main Product A
    Click Button Add To Cart
    Expected Result Have Button Go Next
    Expected Result Not Have Free Product
    Open Level D On Mobile Product A
    Click Button Add To Cart On Mobile
    Log To Console    \n*** Expected Result Button Is Disable *** \n Button_Buy_OnMobile=${XPATH_LEVEL_D_MOBILE.btn_go_next}\n
    Expected Result Have Button Go Next Mobile
    Expected Result Not Have Free Product On Mobile
    Expected Result Not Have Camp Short Descript Mobile
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00630 : Add primary item more than the number of items in stock
    [Tags]    TC_iTM_00630    regression    WLS_Low    out_of_stock    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    1
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product A To Main Product
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    2    1    Buy 3 (product A) Get 2 (product B) Free    camp_json_1main_1free.json
    Open Level D Main Product A
    Increase Product Quantity
    Click Button Add To Cart
    Expected Result Out Of Stock
    Open Level D On Mobile Product A
    Increase Product Quantity Mobile    2
    Click Button Add To Cart On Mobile
    Expected Result Out Of Stock Mobile
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00631 : Can be added primary item to cart but not get free item when stock of primary and free items are not enough for freebie campaign
    [Tags]    TC_iTM_00631    regression    WLS_Low    add_to_cart_success    freebie    ready
    Prepare Main Product Have 3 Variant Inactive
    Prepare Stock Main Product Inactive    2
    Prepare Product Free Public
    Prepare Stock Product Free Public    1
    Set Product Inactive To Main Product
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_Inactive}
    Set Freebie Promotion To Camp Buy A Free B    3    2    Buy 3 (variant B of product A) Get 2 (product B) Free    camp_json_1main_1free.json
    Open Level D Main Product A
    Click Element Variable Style PKEY A
    Increase Product Quantity
    Click Button Add To Cart
    Expected Result Amount Have 2 ITEM
    Expected Result Have Button Go Next
    Open Level D On Mobile Product A
    Click Element Variable Style PKEY A On Mobile
    Increase Product Quantity Mobile    2
    Click Button Add To Cart On Mobile
    Expected Result Amount Mobile    [2]
    #Expected Result Have Button Go Next Mobile
    Expected Result Have Button Go Next Mobile Visible
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00632 : Can be added primary item to cart but not get free item when stock of primary item is not enough for freebie campaign and free item is out of stock
    [Tags]    TC_iTM_00632    regression    WLS_Low    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    1
    Prepare Main Product B
    Prepare Stock Main Product B    1
    Prepare Product Free Public
    Prepare Stock Product Free Public    1
    Set Product A To Main Product
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_B}
    Set Freebie Promotion To Camp Buy A-C Free B    3    2    Buy 3 (product A, B) Get 2 (product C) Free    camp_json_2main_1free.json
    Open Level D Main Product A
    Click Button Add To Cart
    Go To Level D Main Product B
    Click Button Add To Cart
    Expected Result Not Have Free Product
    Expected Result Not Have Camp Short Descript
    Open Level D On Mobile Product A
    Click Button Add To Cart On Mobile
    Go To Level D On Mobile Main Product B
    Click Button Add To Cart On Mobile
    Expected Result Not Have Free Product On Mobile
    Expected Result Not Have Camp Short Descript Mobile
    Prepare Default Stock Main Product B
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Selenium2Library.Close All Browsers
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00633 : Can be added freebie items with shipping fee and assign unlimited of freebie campaign
    [Tags]    TC_iTM_00633    regression    WLS_High    freebie    ready
    Prepare Main Product Have 3 Variant Inactive
    Prepare Stock Main Product Inactive    10
    Set Product Inactive To Main Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_Inactive}
    Set Freebie Promotion To Camp Buy A Free A Set Repeat    2    1    Buy 2 (variant A of product A) Get 1 (variant A of product A) Free    camp_json_1main_1free.json    5
    Open Level D Main Product A
    Click Element Variable Style PKEY A
    Increase Product Quantity
    Increase Product Quantity
    Increase Product Quantity
    Click Button Add To Cart
    Full Cart - Display Normal Product First Item 4 Qty
    Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Camp Short Description
    User Click Close Button On Full Cart
    Decrease Product Quantity
    Decrease Product Quantity
    Click Button Add To Cart
    Full Cart - Display Normal Product First Item 6 Qty
    Full Cart - Display Free Product First Item 3 Qty
    Full Cart - Display Camp Short Description
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00635 : Can be added freebie items when assign freebie campaign with multiple primary and some primary item is out of stock
    [Tags]    TC_iTM_00635    regression    WLS_High    freebie    ready
    Prepare Main Product Have 3 Variant Inactive
    Prepare Stock Main Product Inactive    0
    Set Product Inactive To Main Product
    Prepare Main Product Have 3 Variant Inactive B
    Prepare Stock Main Product B    10
    Set Product B To Main Product
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_Inactive}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_B}
    Set Freebie Promotion To Camp Buy A-B Free C    3    2    Buy 3 (variant C of product A, variant A of product B) Get 2 (product C) Free    camp_json_2main_1free.json
    Open Level D Main Product A
    Click Element Variable Style PKEY A
    Expected Result Button Is Disable
    Go To Level D Main Product B
    Click Element Variable Style PKEY B
    Increase Product Quantity
    Increase Product Quantity
    Click Button Add To Cart
    Expected Result Have Free Product
    Expected Result Have Camp Short Descript
    Open Level D On Mobile Product A
    Click Element Variable Style PKEY A On Mobile
    Go To Level D On Mobile Main Product B
    Click Element Variable Style PKEY B On Mobile
    Increase Product Quantity Mobile    3
    Click Button Add To Cart On Mobile
    Expected Result Have Free Product On Mobile
    Expected Result Have Camp Short Descript Mobile
    Prepare Default Stock Main Product B
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00636 : Can be added freebie items when assign freebie campaign with multiple primary and some primary item is not enough for freebie campaign
    [Tags]    TC_iTM_00636    regression    WLS_High    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    2
    Set Product A To Main Product
    Prepare Main Product B
    Prepare Stock Main Product B    10
    Set Product B To Main Product
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_B}
    Set Freebie Promotion To Camp Buy A-C Free B    3    2    Buy 3 (product A, product B) Get 2 (product C) Free    camp_json_2main_1free.json
    Open Level D On Mobile Product A
    Increase Product Quantity Mobile    2
    Click Button Add To Cart On Mobile
    Go To Level D On Mobile Main Product B
    Click Button Add To Cart On Mobile
    Expected Result Have Free Product On Mobile
    Expected Result Have Camp Short Descript Mobile
    Open Level D Main Product A
    Increase Product Quantity
    Click Button Add To Cart
    Go To Level D Main Product B
    Click Button Add To Cart
    Expected Result Have Free Product
    Expected Result Have Camp Short Descript
    Prepare Default Stock Main Product B
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00637 : Can be added primary item to cart but not get free item when stock of parent item is enough but stock of free item is not enough (different item)
    [Tags]    TC_iTM_00637    regression    WLS_High    freebie    ready
    Prepare Main Product Have 3 Variant Inactive
    Prepare Stock Main Product Inactive    10
    Set Product Inactive To Main Product
    Prepare Product Free Public
    Prepare Stock Product Free Public    1
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_Inactive}
    Set Freebie Promotion To Camp Buy A Free B    5    2    Buy 5 (variant A of product A) Get 2 (product B) Free    camp_json_1main_1free.json
    Open Level D Main Product A
    Click Element Variable Style PKEY A
    Increase Product Quantity
    Increase Product Quantity
    Increase Product Quantity
    Click Button Add To Cart
    Expected Result Not Have Free Product
    Expected Result Not Have Camp Short Descript
    Open Level D On Mobile Product A
    Click Element Variable Style PKEY A On Mobile
    Increase Product Quantity Mobile    1
    Click Button Add To Cart On Mobile
    Expected Result Not Have Free Product On Mobile
    Expected Result Not Have Camp Short Descript Mobile
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00638 : Can be added primary item to cart but not get free item when stock of parent item is enough but stock of free item is not enough (same item)
    [Tags]    TC_iTM_00638    regression    WLS_High    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    6
    Set Product A To Main Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free A    5    2    Buy 5 (product A) Get 2 (product A) Free    camp_json_1main_1free.json
    Open Level D Main Product A
    Increase Product Quantity
    Increase Product Quantity
    Increase Product Quantity
    Increase Product Quantity
    Click Button Add To Cart
    Click Alert Box
    Decrease Product Quantity
    Click Button Add To Cart
    Sleep    3
    Expected Result Have Button Go Next
    Expected Result Not Have Free Product
    Expected Result Not Have Camp Short Descript
    Open Level D On Mobile Product A
    Increase Product Quantity Mobile    5
    Click Button Add To Cart On Mobile
    Click Alert Box Mobile
    Increase Product Quantity Mobile    4
    Click Button2 Add To Cart On Mobile
    Expected Result Have Button Go Next Mobile
    Expected Result Not Have Free Product On Mobile
    Expected Result Not Have Camp Short Descript Mobile
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00639 : Can be added primary item to cart but not get free item when stock of primary item is enough but free item is out of stock
    [Tags]    TC_iTM_00639    regression    WLS_Low    freebie    ready
    Prepare Main Product A
    Prepare Stock Main Product A    10
    Set Product A To Main Product
    Prepare Product Free Public
    Prepare Stock Product Free Public    0
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    2    1    Buy 2 (product A) Get 1 (product B) Free    camp_json_1main_1free.json
    Open Level D Main Product A
    Increase Product Quantity
    Increase Product Quantity
    Click Button Add To Cart
    Click Alert Box
    Decrease Product Quantity
    Decrease Product Quantity
    Click Button Add To Cart
    Expected Result Have Button Go Next
    Expected Result Not Have Free Product
    Expected Result Not Have Camp Short Descript
    Open Level D On Mobile Product A
    Increase Product Quantity Mobile    3
    Click Button Add To Cart On Mobile
    Click Alert Box Mobile
    Increase Product Quantity Mobile    1
    Click Button2 Add To Cart On Mobile
    Expected Result Have Button Go Next Mobile
    Expected Result Not Have Free Product On Mobile
    Expected Result Not Have Camp Short Descript Mobile
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00640 : Add to cart between SIM and Freebie (free item is SIM)
    [Tags]    TC_iTM_00640    regression    WLS_Medium    freebie    ready
    User Open Home page
    Clear Cart Current User
    Log To Console    \n*** Freebie Add To Cart - Add Product Sim To Cart ***\n
    Freebie Add To Cart - Add Product Sim To Cart
    Prepare Main Product A
    Prepare Stock Main Product A    10
    Set Product A To Main Product
    Log To Console    \n*** Fix Product Free Public ***\n
    Fix Product Free Public    ${var_tmh_sim_inventory_id}
    Log To Console    \n*** Prepare Stock Product Free Public ***\n
    Prepare Stock Product Free Public    9999
    Log To Console    \n*** Set Product Free Public To Main Product Free ***\n
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    2    1    Buy 2 (product A) Get 1 (product B) Free    camp_json_1main_1free.json
    Go To Level D Main Product A
    Increase Product Quantity
#    Click Element Variable Style PKEY A
    Click Button Add To Cart
    Sleep    3s
    Capture Page Screenshot
    Click Alert Box
    #Click Cart Box Button
    Go To    ${WEMALL_URL}/checkout/step1
    Sleep    2s
    User Click Edit Cart On Mini Cart
    Full Cart - Display Sim Product First Item 1 Qty
    Prepare Default Stock Main Product B
    # Prepare Default Stock Product Free
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00641 : Add to cart between bundle and Freebie (primary item has SKU as same as bundle)
    [Tags]    TC_iTM_00641    regression    WLS_Low    bundle    freebie    ready    WLS_Bundle
    User Open Home page
    Clear Cart Current User
    Prepare TruemoveH Product Bundle On PCMS
    Prepare TruemoveH Product Bundle On CAMP
    Freebie Add To Cart - Add Product Bundle To Cart
    Fix Product Main Public    ${var_tmh_product_device_inventory_id}
    Prepare Stock Main Product A    10
    Set Product A To Main Product
    Set Style Main Product
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    #Click Cart Box Button

    Go To    ${WEMALL_URL}/checkout/step1
    Sleep    3s
    User Click Edit Cart On Mini Cart

    Full Cart - Display Bundle Product First Item 1 Qty
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    2    1    Buy 2 (product A Bundle) Get 1 (Product B) Free    camp_json_1main_1free.json
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    Increase Product Quantity
    Click Button Add To Cart
    Click Alert Box
    #Click Cart Box Button

    Sleep    2s
    Capture Page Screenshot
    Go To    ${WEMALL_URL}/checkout/step1
    Sleep    3s
    User Click Edit Cart On Mini Cart

    Full Cart - Display Bundle Product First Item 1 Qty
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Delete TruemoveH Product Bundle On CAMP
    Delete TruemoveH Product Bundle On PCMS
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00642 : Add to cart between bundle and Freebie (free item has SKU as same as bundle)
    [Tags]    TC_iTM_00642    regression    WLS_Low    bundle    freebie    ready    WLS_Bundle
    User Open Home page
    Clear Cart Current User
    Prepare TruemoveH Product Bundle On PCMS
    Prepare TruemoveH Product Bundle On CAMP
    Fix Product Main Public    ${var_tmh_product_device_inventory_id}
    Prepare Stock Main Product A    10
    Set Product A To Main Product
    Set Style Main Product
    Prepare Product Free Public
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    2    1    Buy 2 (product A Bundle) Get 1 (Product B) Free    camp_json_1main_1free.json
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    Increase Product Quantity
    Click Button Add To Cart
    Display Full Cart
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description
    Freebie Add To Cart - Add Product Bundle To Cart
    Freebie Add To Cart - Cannot Add Bundle To Cart
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Delete TruemoveH Product Bundle On CAMP
    Delete TruemoveH Product Bundle On PCMS
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00643 : Add bundle item to cart and get free item too
    [Tags]    TC_iTM_00643    regression    WLS_Low    bundle    freebie    ready    WLS_Bundle
    User Open Home page
    Clear Cart Current User
    Prepare TruemoveH Product Bundle On PCMS
    Prepare TruemoveH Product Bundle On CAMP
    Get TruemoveH Data For Search Available Mobile Number Sim
    Fix Product Main Public    ${var_tmh_product_device_inventory_id}
    Prepare Stock Main Product A    10
    Set Product A To Main Product
    Set Style Main Product
    Fix Product B Main Public    ${var_tmh_sim_inventory_id}
    Prepare Stock Main Product B    10
    Set Product B To Main Product
    Prepare Product Free Public
    Log To Console    \n*** Prepare Stock Product Free Public ***\n
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A-C Free B    2    1    Buy 3 (product A, product B) Get 2 (product C) Free    camp_json_2main_1free.json
    Go To Level D Main Product A
    Click Element Variable Style PKEY A
    Click Button Add To Cart
    Full Cart - Display Normal Product First Item 1 Qty
    Full Cart - Do Not Display Product Free On Full Cart
    Full Cart - Do Not Display Camp Short Description
    Freebie Add To Cart - Add Product Sim To Cart By Inventory Id    ${var_tmh_sim_inventory_id}
    #Go To Level D Main Product A
    #Click Cart Box Button
    #Click Element Variable Style PKEY A
    #Click Button Add To Cart

    Go To    ${WEMALL_URL}/checkout/step1
    Sleep    3s
    User Click Edit Cart On Mini Cart

    Display Full Cart
    Full Cart - Display Normal Product First Item 1 Qty
    #Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Sim Product First Item 1 Qty
    Full Cart - Do Not Display Product Free On Full Cart
    Full Cart - Do Not Display Camp Short Description
    Prepare Default Stock Main Product B
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    Delete TruemoveH Product Bundle On CAMP
    Delete TruemoveH Product Bundle On PCMS
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00646 : Can not update quantity of wow item in full cart
    [Tags]    TC_iTM_00646    regression    WLS_Low    wow    freebie    ready
    User Open Home page
    Login User to iTrueMart With User Freebie
    Clear Cart Current User
    Prepare Main Wow Product A
    Set Product A To Main Product
    Prepare Product Free Public
    Prepare Stock Main Product A    10
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    2    1    Buy 1 (variant A of product B) Get 2 (variant A of product B) Free    camp_json_1main_1free.json
    Go To Level D Main Product A
    Increase Product Quantity

    #Click Element Variable Style PKEY A
    #
    Click Element Variable Style PKEY A Select Color
    #
    Click Button Add To Cart
    Full Cart - Select Box Quantity Max 1
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00647 : Can not add quantity of wow item > 1
    [Tags]    TC_iTM_00647    regression    WLS_Low    wow    freebie    ready
    User Open Home page
    Login User to iTrueMart With User Freebie
    Clear Cart Current User
    Prepare Main Wow Product A
    Set Product A To Main Product
    Prepare Product Free Public
    Prepare Stock Main Product A    10
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    3    2    Buy 1 (variant A of product B) Get 3 (variant A of product B) 2 Free    camp_json_1main_1free.json
    Go To Level D Main Product A
    Click Element Variable Style PKEY A Select Color
    Check Element Box Amount ReadOnly
    #Wait Until Element Is Visible    //input[@class="box_amount product-qty stepper-input" and @readonly="true"]    10s
    #Increase Product Quantity
    #Level D - Box Amount Max 1
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product

TC_iTM_00648 : Can not update quantity of wow item > 1
    [Tags]    TC_iTM_00648    regression    WLS_Low    wow    freebie    ready
    User Open Home page
    Login User to iTrueMart With User Freebie
    Clear Cart Current User
    Prepare Main Wow Product A
    Set Product A To Main Product
    Prepare Product Free Public
    Prepare Stock Main Product A    10
    Prepare Stock Product Free Public    10
    Set Product Free Public To Main Product Free
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${Variable_Main_Product_A}
    Set Freebie Promotion To Camp Buy A Free B    3    2    Buy 1 (variant A of product B) Get 3 (variant A of product B) 2 Free    camp_json_1main_1free.json
    Go To Level D Main Product A
    #
    Click Element Variable Style PKEY A Select Color
    #
    Click Button Add To Cart
    User Click Close Button On Full Cart
    Click Button Add To Cart
    Full Cart - Cannot Add Duplicate Product Wow
    Prepare Default Stock Product Free
    Freebie Add To Cart - Delete Promotion Camp
    [Teardown]    Run Keywords    Prepare Default Stock Main Product
