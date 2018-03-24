*** Settings ***
Suite Setup       Selenium2Library.Open Browser    ${ITM_URL}    ${BROWSER}
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_level_d.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_level_d_web.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_level_d_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/WebElement_LevelD.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot    # CAMP
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot

*** Variables ***
#เอาไว้สำหรับเลือกโปรดัก เพื่อไม่ให้โปรโมชั่นชนกันกับ test case อื่นจ้า
${start_normal}    9
${start_free}     11

*** Test Cases ***
TC_iTM_00513 : Level D shows "out-of-stock" when primary item is out of stock but free item is enough
    [Tags]    TC_iTM_00513    ready    out_of_stock    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    0
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00514 : Level D shows "out-of-stock" when primary item is out of stock and free item is not enough for freebie campaign
    [Tags]    TC_iTM_00514    ready    out_of_stock    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    0
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00515 : Level D shows "out-of-stock" when primary and free items are out of stock
    [Tags]    TC_iTM_00515    ready    out_of_stock    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Main2 Product 1Variant B
    Get Free Product 1Variant C
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D Two Main Product    2    1
    Set Remaining Level D Main Product    0
    Set Remaining Level D Main2 Product    0
    Set Remaining Level D Free Product    0
    Rebuild Stock No Variant
    Rebuild Stock No Variant Main2
    Open Level D Main Product
    Button Add To Cart Disabled
    Open Level D Main2 Product
    Button Add To Cart Disabled
    Rebuild Stock No Variant Mobile
    Rebuild Stock No Variant Main2 Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    Open Level D Main2 Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D Main2

TC_iTM_00516 : Level D shows "in-stock" when stock of primary item is not enough for freebie campaign but free item is enough
    [Tags]    TC_iTM_00516    ready    in_stcok    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    3    2
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00517 : Level D - In stockLevel D shows "in-stock" when stock of primary and free items are not enough for freebie campaign
    [Tags]    TC_iTM_00517    ready    in_stcok    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    3    2
    Set Remaining Level D Main Product    1
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00518 : Level D shows "in-stock" when stock of primary item is not enough for freebie campaign but free item is out of stock
    [Tags]    TC_iTM_00518    ready    in_stcok    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Main2 Product 1Variant B
    Get Free Product 1Variant C
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D Two Main Product    2    1
    Set Remaining Level D Main Product    1
    Set Remaining Level D Main2 Product    1
    Set Remaining Level D Free Product    0
    Rebuild Stock No Variant
    Rebuild Stock No Variant Main2
    Open Level D Main Product
    Button Add To Cart Enable
    Open Level D Main2 Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Rebuild Stock No Variant Main2 Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    Open Level D Main2 Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D Main2

TC_iTM_00519 : Level D shows "in-stock" when stock of primary and free items are enough
    [Tags]    TC_iTM_00519    ready    in_stcok    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00520 : Level D shows "in-stock" when stock of primary item is enough but stock of free item is not enough for freebie campaign
    [Tags]    TC_iTM_00520    ready    in_stcok    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    1
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00521 : Level D shows "in-stock" when stock of primary item is enough but stock of free item is out of stock
    [Tags]    TC_iTM_00521    ready    in_stcok    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    0
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00522 : Level D shows "out-of-stock" when stock of primary = 1 which is equal to the amount of primary item returning from camp and stock of free item is enough
    [Tags]    TC_iTM_00522    ready    out_of_stock    set1    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    1    2
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00523 : Level D shows "out-of-stock" when stock of primary = 1 which is equal to the amount of primary item returning from camp but stock of free item is not enough for freebie campaign
    [Tags]    TC_iTM_00523    ready    out_of_stock    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    1    2
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    1
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00524 : Level D shows "out-of-stock" when stock of primary = 1 which is equal to the amount of primary item returning from camp but free item is out of stock
    [Tags]    TC_iTM_00524    ready    out_of_stock    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    1    2
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    0
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00525 : Level D shows "in-stock" when stock of primary >1 which is equal to the amount of primary item returnning from camp and stock of free item is enough
    [Tags]    TC_iTM_00525    ready    in_stcok    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00526 : Level D shows "in-stock" when stock of parent > 1 which is equal to the amount of primary item returning from camp but stock of free item is not enough for freebie campaign
    [Tags]    TC_iTM_00526    ready    in_stcok    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    1
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00527 : Level D shows "in-stock" when stock of primary > 1 which is equal to the amount of primary item returning from camp but free item is out of stock
    [Tags]    TC_iTM_00527    ready    in_stcok    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    0
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00528 : Level D shows "in-stock" when stock of product A is equal to the total amount of product A returning from camp
    [Tags]    TC_iTM_00528    ready    in_stcok    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    5
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00529 : Level D shows "in-stock" when stock of product A is more than the total amount of product A returning from camp
    [Tags]    TC_iTM_00529    ready    in_stcok    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    10
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00530 : Level D shows "in-stock" when stock of product A > 1 which is less than the total amount of product A returning from camp
    [Tags]    TC_iTM_00530    ready    in_stcok    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    4
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00531 : Level D shows "out-of-stock" when stock of product A = 1 which is less than the total amount of product A returning from camp
    [Tags]    TC_iTM_00531    ready    out_of_stock    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    1
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00532 : Can buy normal product when that product is in stock but it is not in freebie campaign
    [Tags]    TC_iTM_00532    ready    set2    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant C
    Check Current Stock Level D Main Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantC}
    Set Remaining Level D Main Product    10
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining Main Product Level D

TC_iTM_00533 : Can not buy normal product when that product is out of stock and it is not in freebie campaign
    [Tags]    TC_iTM_00533    ready    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant C
    Check Current Stock Level D Main Product
    Set Remaining Level D Main Product    0
    Rebuild Stock No Variant
    Open Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock No Variant Mobile
    Open Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining Main Product Level D

TC_iTM_00534 : D shows "out-of-stock" after a user selects option if that product is out of stock
    [Tags]    TC_iTM_00534    ready    out_of_stock    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant D
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantD}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    0
    Set Remaining Level D Free Product    10
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00535 : Level D shows "in-stock" after a user selects option if stock of primary item is not enough for freebie campaign
    [Tags]    TC_iTM_00535    ready    in_stcok    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    10
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00536 : Level D shows "in-stock" after a user selects option if stock of primary and free items are enough
    [Tags]    TC_iTM_00536    ready    in_stcok    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00537 : Level D shows "in-stock" after a user selects option if stock of primary item is enough but stock of free item is not enough for freebie campaign
    [Tags]    TC_iTM_00537    ready    in_stcok    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    1
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00538 : Level D shows "in-stock" after a user selects option if stock of primary item is enough but stock of free item is out of stock
    [Tags]    TC_iTM_00538    ready    in_stcok    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    0
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00539 : Level D shows "in-stock" after a user selects option if stock of primary = 1 which is equal to the amount of primary item returning from camp and stock of free item is enough
    [Tags]    TC_iTM_00539    ready    in_stcok    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Set Freebie On Camp Level D    1    2
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    10
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00540 : Level D shows "out-of-stock" after a user selects option if stock of primary = 1 which is equal to the amount of primary item returning from camp but stock of free item is not enough for freebie campaign
    [Tags]    TC_iTM_00540    ready    out_of_stock    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Set Freebie On Camp Level D    1    2
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    1
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00541 : Level D shows "out-of-stock" after a user selects option if stock of primary = 1 which is equal to the amount of primary item returning from camp but free item is out of stock
    [Tags]    TC_iTM_00541    ready    out_of_stock    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Set Freebie On Camp Level D    1    2
    Set Remaining Level D Main Product    1
    Set Remaining Level D Free Product    0
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00542 : Level D shows "in-stock" after a user selects option if stock of primary >1 which is equal to the amount of primary item returning from camp and stock of free item is enough
    [Tags]    TC_iTM_00542    ready    in_stcok    set3    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    10
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00543 : Level D shows "in-stock" after a user selects option if stock of primary > 1 which is equal to the amount of primary item returning from camp but stock of free item is not enough for freebie campaign
    [Tags]    TC_iTM_00543    ready    in_stcok    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    1
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00544 : Level D shows "in-stock" after a user selects option if stock of primary > 1 which is equal to the amount of primary item returning from camp but free item is out of stock
    [Tags]    TC_iTM_00544    ready    in_stcok    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    0
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00545 : Level D shows "in-stock" after a user selects option if stock of product A is equal to the total amount of product A returning from camp
    [Tags]    TC_iTM_00545    ready    in_stcok    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 4Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    5
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00546 : Level D shows "in-stock" after a user selects option if stock of product A is more than the total amount of product A returning from camp
    [Tags]    TC_iTM_00546    ready    in_stcok    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 4Variant A
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    10
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00547 : Level D shows "in-stock" after a user selects option if stock of product A > 1 item which is less than the total amount of product A returning from camp
    [Tags]    TC_iTM_00547    ready    in_stcok    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Get Free Product 4Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    4
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00548 : Level D shows "out-of-stock" after a user selects option if stock of product A = 1 item which is less than the total amount of product A returning from camp
    [Tags]    TC_iTM_00548    ready    out-of-stock    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Get Free Product 4Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Get Style Option Main Product From InventoryId
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Set Freebie On Camp Level D    2    3
    Set Remaining Level D Main Product    1
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00549 : Can buy normal product after a user selects option if that product is in stock but it is not in freebie campaign
    [Tags]    TC_iTM_00549    ready    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Check Current Stock Level D Main Product
    Get Style Option Main Product From InventoryId
    Set Remaining Level D Main Product    1
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Enable
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining Main Product Level D

TC_iTM_00550 : Can not buy normal product after a user selects option if that product is out of stock and it is not in freebie campaign
    [Tags]    TC_iTM_00550    ready    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant B
    Check Current Stock Level D Main Product
    Get Style Option Main Product From InventoryId
    Set Remaining Level D Main Product    0
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Rebuild Stock More Than 1Variant
    Open Level D Main Product
    Choose Style Option Main Level D Main Product
    Button Add To Cart Disabled
    Rebuild Stock More Than 1Variant Mobile
    Open Level D Main Product Mobile
    Choose Style Option Main Level D Main Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining Main Product Level D

TC_iTM_00551 : Buy free item same as normal product althought that free item is not enough for freebie campaign
    [Tags]    TC_iTM_00551    ready    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    1
    Rebuild Stock No Variant
    Open Level D Free Product
    Button Add To Cart Enable
    Rebuild Stock No Variant Mobile
    Open Level D Free Product Mobile
    Button Add To Cart Enable Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00552 : Buy free item same as normal product when that free item is out of stock
    [Tags]    TC_iTM_00552    ready    set4    btn_add_to_cart
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    5    2
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    0
    Rebuild Stock No Variant
    Open Level D Free Product
    Button Add To Cart Disabled
    Rebuild Stock No Variant Mobile
    Open Level D Free Product Mobile
    Button Add To Cart Disabled Mobile
    [Teardown]    Restore Remaining And Promotion Level D

TC_iTM_00661 : Level D show freebie image and promotion text when freebie campaign and promotion are enable&live on web
    [Tags]    TC_iTM_00661    ready    set1    display_promotion
    # TC15: Campaing On, In Period - Promotion On, In Period - Promotion Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true    # -1month +6month
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Display
    Freebie Promotion Note TH Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00662 : Level D show freebie image and promotion text of first promotion when primary item has multiple variants and all variants are assign freebie campaign and promotion are enable&live on web
    [Tags]    TC_iTM_00662    ready    set1    display_promotion
    # TC16: Campaing On, In Period - Promotion On, In Period - Promotion Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Main2 Product 4Variant B
    Get Main3 Product 4Variant C
    Get Free Product 1Variant B
    Get Style Option Main Product From InventoryId
    Get Style Option Main2 Product From InventoryId
    Get Style Option Main3 Product From InventoryId
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Main3 Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantC}
    Create Campagin Freebie On Camp Level D    -30    180    true    #01-03-2016 - 30-06-2016
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    true
    Set Freebie On Camp Level D Main2 By Campaign Id    2    1    -30    180    true
    Set Freebie On Camp Level D Main3 By Campaign Id    2    1    -30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Main2 Product    10
    Set Remaining Level D Main3 Product    10
    Set Remaining Level D Free Product    10
    Open Level D Main Product No Cache
    Choose Style Option Main Level D Main Product
    Freebie Image Web TH Display Main
    Freebie Promotion Note TH Display Main
    Open Level D Main2 Product No Cache
    Choose Style Option Main Level D Main2 Product
    Freebie Image Web TH Display Main2
    Freebie Promotion Note TH Display Main2
    Open Level D Main3 Product No Cache
    Choose Style Option Main Level D Main3 Product
    Freebie Image Web TH Display Main3
    Freebie Promotion Note TH Display Main3
    [Teardown]    Restore Remaining And Promotion And Campaign Level D 3Main

TC_iTM_00663 : Level D show freebie image and promotion text of first promotion when primary item has multiple variants and some variant is assign freebie campaign and promotion are enable&live on web
    [Tags]    TC_iTM_00663    ready    set1    display_promotion
    # TC17: Campaing On, In Period - Promotion On, In Period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Main2 Product 4Variant C
    Get Free Product 1Variant B
    Get Style Option Main Product From InventoryId
    Get Style Option Main2 Product From InventoryId
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantC}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantB}
    Create Campagin Freebie On Camp Level D    -30    180    true    #01-03-2016 - 30-06-2016
    Set Freebie On Camp Level D Main2 By Campaign Id    2    1    -30    180    true
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Main2 Product    10
    Set Remaining Level D Free Product    10
    Open Level D Main Product No Cache
    Freebie Image Web TH Display Main2
    Freebie Promotion Note TH Display Main2
    Choose Style Option Main Level D Main Product
    Freebie Image Web TH Display Main
    Freebie Promotion Note TH Display Main
    Choose Style Option Main Level D Main2 Product
    Freebie Image Web TH Display Main2
    Freebie Promotion Note TH Display Main2
    [Teardown]    Restore Remaining And Promotion And Campaign Level D 2Main

TC_iTM_00664 : Level D does not show freebie image and promotion text when freebie campaign is enable&live on web and promotion is enable but not live on web
    [Tags]    TC_iTM_00664    ready    set1    not_display_promotion
    # TC18: Campaing On, In Period - Promotion On, In Period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true    #01-03-2016 - 30-06-2016
    Set Freebie On Camp Level D By Campaign Id    2    1    30    120
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00665 : Level D does not show freebie image and promotion text when freebie campaign is enable&live on web and promotion is disabled
    [Tags]    TC_iTM_00665    ready    set1    not_display_promotion
    # TC19: Campaing On, In Period - Promotion Off, In Period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true    #01-03-2016 - 30-06-2016
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00666 : Level D does not show freebie image and promotion text when freebie campaign is enable&live on web and promotion is expired
    [Tags]    TC_iTM_00666    ready    set1    not_display_promotion
    # TC20: Campaing On, In Period - Promotion On, out of period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true    #01-03-2016 - 30-06-2016
    Set Freebie On Camp Level D By Campaign Id    2    1    -60    -30    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00667 : Level D does not show freebie image and promotion text when freebie campaign and promotion are enable but not live on web
    [Tags]    TC_iTM_00667    ready    set1    not_display_promotion
    # TC21: Campaing On, In the future - Promotion On, In the future - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    30    180    true    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00668 : Level D does not show freebie image and promotion text when freebie campaign is enable but not live on web and promotion is disabled
    [Tags]    TC_iTM_00668    ready    set1    not_display_promotion
    # TC22: Campaing On, In the future - Promotion Off, In the future - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    30    60    true
    Set Freebie On Camp Level D By Campaign Id    2    1    30    60    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00669 : Level D does not show freebie image and promotion text when freebie campaign is disable and promotion is enable&live on web
    [Tags]    TC_iTM_00669    ready    set1    not_display_promotion
    # TC23: Campaing Off, In period - Promotion On, In period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    -30    60    false    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    60    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00670 : Level D does not show freebie image and promotion text when freebie campaign is disable and promotion is enable but not live on web
    [Tags]    TC_iTM_00670    ready    set1    not_display_promotion
    # TC24: Campaing Off, In period - Promotion On, In the future - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    false
    Set Freebie On Camp Level D By Campaign Id    2    1    30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00671 : Level D does not show freebie image and promotion text when freebie campaign and promotion are disabled
    [Tags]    TC_iTM_00671    ready    set2    not_display_promotion
    # TC25: Campaing Off, In period - Promotion Off, In period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    -30    60    false    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    60    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00672 : Level D does not show freebie image and promotion text when freebie campaign is disable and promotion is expired
    [Tags]    TC_iTM_00672    ready    set2    not_display_promotion
    # TC26: Campaing Off, In period - Promotion Off, Out of period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    false
    Set Freebie On Camp Level D By Campaign Id    2    1    -60    -30    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00673 : Level D does not show freebie image and promotion text when freebie campaign is expired
    [Tags]    TC_iTM_00673    ready    set2    not_display_promotion
    # TC27: Campaing On, Out of period - Promotion On, Out of period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    -60    -30    true    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    -60    -30    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00675 : Level D does not show freebie image and promotion text when that product dose not assign freebie campaign in camp
    [Tags]    TC_iTM_00675    ready    set2    not_display_promotion
    # TC29: No Campaing - No Promotion - Promotion Not Display
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Main2 Product 4Variant B
    Get Main3 Product 4Variant C
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Main3 Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantC}
    Set Remaining Level D Main Product    10
    Set Remaining Level D Main2 Product    15
    Set Remaining Level D Main3 Product    20
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining Main3 Product Level D

TC_iTM_00676 : Level D on mobile show freebie image and promotion text when freebie campaign and promotion are enable&live
    [Tags]    TC_iTM_00676    ready    set2    display_promotion
    # TC30: Campaing On, In Period - Promotion On, In Period - Promotion Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true    # -1month +6month
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Mobile TH Display
    Freebie Promotion Note TH Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00677 : Level D on mobile show freebie image and promotion text of first promotion when primary item has multiple variants and all variants are assign freebie campaign and promotion are enable&live
    [Tags]    TC_iTM_00677    ready    set2    display_promotion
    # TC16: Campaing On, In Period - Promotion On, In Period - Promotion Display Mobile
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Main2 Product 4Variant B
    Get Main3 Product 4Variant C
    Get Free Product 1Variant B
    Get Style Option Main Product From InventoryId
    Get Style Option Main2 Product From InventoryId
    Get Style Option Main3 Product From InventoryId
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Main3 Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantC}
    Create Campagin Freebie On Camp Level D    -30    180    true    #01-03-2016 - 30-06-2016
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    true
    Set Freebie On Camp Level D Main2 By Campaign Id    2    1    -30    180    true
    Set Freebie On Camp Level D Main3 By Campaign Id    2    1    -30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Main2 Product    10
    Set Remaining Level D Main3 Product    10
    Set Remaining Level D Free Product    10
    Open Level D Main Product No Cache Mobile
    Choose Style Option Main Level D Main Product Mobile
    Freebie Image Mobile TH Display Main
    Freebie Promotion Note TH Display Main
    Open Level D Main2 Product No Cache Mobile
    Choose Style Option Main Level D Main2 Product Mobile
    Freebie Image Mobile TH Display Main2
    Freebie Promotion Note TH Display Main2
    Open Level D Main3 Product No Cache Mobile
    Choose Style Option Main Level D Main3 Product Mobile
    Freebie Image Mobile TH Display Main3
    Freebie Promotion Note TH Display Main3
    [Teardown]    Restore Remaining And Promotion And Campaign Level D 3Main

TC_iTM_00678 : Level D on mobile show freebie image and promotion text of first promotion when primary item has multiple variants and some variant is assign freebie campaign and promotion are enable&live
    [Tags]    TC_iTM_00678    ready    set2    display_promotion
    # TC17: Campaing On, In Period - Promotion On, In Period - Promotion Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Main2 Product 4Variant C
    Get Free Product 1Variant B
    Get Style Option Main Product From InventoryId
    Get Style Option Main2 Product From InventoryId
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantC}
    Create Campagin Freebie On Camp Level D    -30    180    true    #01-03-2016 - 30-06-2016
    Set Freebie On Camp Level D Main2 By Campaign Id    2    1    -30    180    true
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Main2 Product    10
    Set Remaining Level D Free Product    10
    Open Level D Main Product No Cache Mobile
    Freebie Image Mobile TH Display Main2
    Freebie Promotion Note TH Display Main2
    Choose Style Option Main Level D Main Product Mobile
    Freebie Image Mobile TH Display Main
    Freebie Promotion Note TH Display Main
    Choose Style Option Main Level D Main2 Product Mobile
    Freebie Image Mobile TH Display Main2
    Freebie Promotion Note TH Display Main2
    [Teardown]    Restore Remaining And Promotion And Campaign Level D 2Main

TC_iTM_00679 : Level D on mobile does not show freebie image and promotion text when freebie campaign is enable&live on web and promotion is enable but not live
    [Tags]    TC_iTM_00679    ready    set2    not_display_promotion
    # TC33: Campaing On, In period - Promotion On, In the future - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true    # -1month +6month
    Set Freebie On Camp Level D By Campaign Id    2    1    30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00680 : Level D on mobile does not show freebie image and promotion text when freebie campaign is enable&live on web and promotion is disabled
    [Tags]    TC_iTM_00680    ready    set2    not_display_promotion
    # TC34: Campaing On, In Period - Promotion Off, In Period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    180    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00681 : Level D on mobile does not show freebie image and promotion text when freebie campaign is enable&live on web and promotion is expired
    [Tags]    TC_iTM_00681    ready    set2    not_display_promotion
    # TC35: Campaing On, In Period - Promotion On, Out of Period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    true    # -1month +6month
    Set Freebie On Camp Level D By Campaign Id    2    1    -60    -30    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00682 : Level D on mobile does not show freebie image and promotion text when freebie campaign and promotion are enable but not live
    [Tags]    TC_iTM_00682    ready    set3    not_display_promotion
    # TC36: Campaing On, In the future - Promotion On, In the future - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    30    180    true    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00683 : Level D on mobile does not show freebie image and promotion text when freebie campaign is enable but not live on web and promotion is disabled
    [Tags]    TC_iTM_00683    ready    set3    not_display_promotion
    # TC37: Campaing On, In the future - Promotion Off, In the future - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    30    60    true
    Set Freebie On Camp Level D By Campaign Id    2    1    30    60    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00684 : Level D on mobile does not show freebie image and promotion text when freebie campaign is disable and promotion is enable&live
    [Tags]    TC_iTM_00684    ready    set3    not_display_promotion
    # TC38: Campaing Off, In period - Promotion On, In period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    -30    60    false    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    60    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00685 : Level D on mobile does not show freebie image and promotion text when freebie campaign is disable and promotion is enable but not live
    [Tags]    TC_iTM_00685    ready    set3    not_display_promotion
    # TC39: Campaing Off, In period - Promotion On, In the future - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    false
    Set Freebie On Camp Level D By Campaign Id    2    1    30    180    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00686 : Level D on mobile does not show freebie image and promotion text when freebie campaign and promotion are disabled
    [Tags]    TC_iTM_00686    ready    set3    not_display_promotion
    # TC40: Campaing Off, In period - Promotion Off, In period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    60    false    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    -30    60    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00687 : Level D on mobile does not show freebie image and promotion text when freebie campaign is disable and promotion is expired
    [Tags]    TC_iTM_00687    ready    set3    not_display_promotion
    # TC41: Campaing Off, In period - Promotion Off, Out of period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Create Campagin Freebie On Camp Level D    -30    180    false
    Set Freebie On Camp Level D By Campaign Id    2    1    -60    -30    false
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00688 : Level D on mobile does not show freebie image and promotion text when freebie campaign is expired
    [Tags]    TC_iTM_00688    ready    set3    not_display_promotion
    # TC42: Campaing On, Out of period - Promotion On, In period - Promotion Not Display
    Set Inventory Id Product Main And Freebie 1Variant
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Create Campagin Freebie On Camp Level D    -60    -30    true    # start +30 days    end +180 days
    Set Freebie On Camp Level D By Campaign Id    2    1    -60    -30    true
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache Mobile
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining And Promotion And Campaign Level D

TC_iTM_00690 : Level D on mobile does not show freebie image and promotion text when that product dose not assign freebie campaign in camp
    [Tags]    TC_iTM_00690    ready    set3    not_display_promotion
    # TC44: No Campaing - No Promotion - Promotion Not Display
    Set Inventory Id Product Main And Freebie More Than 1Variant
    Get Main Product 4Variant A
    Get Main2 Product 4Variant B
    Get Main3 Product 4Variant C
    Check Current Stock Level D Main Product
    Check Current Stock Level D Main2 Product
    Check Current Stock Level D Main3 Product
    Set Remaining Level D Main Product    10
    Set Remaining Level D Main2 Product    15
    Set Remaining Level D Main3 Product    20
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantA}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantB}
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_4VariantC}
    Rebuild Stock No Variant Mobile
    Open Level D Main Product No Cache
    Freebie Image Web TH Not Display
    Freebie Image Web EN Not Display
    Freebie Image Mobile TH Not Display
    Freebie Image Mobile EN Not Display
    Freebie Promotion Note TH Not Display
    Freebie Promotion Note EN Not Display
    [Teardown]    Restore Remaining Main3 Product Level D
