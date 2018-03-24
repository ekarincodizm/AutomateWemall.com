*** Settings ***
Suite Setup       Selenium2Library.Open Browser    ${ITM_URL}    ${BROWSER}
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_level_d.robot
Resource          ${CURDIR}/../../Keyword/Features/Freebie/keywords_level_d_web.robot
Resource          ${CURDIR}/../../Keyword/Features/Freebie/keywords_level_d_mobile.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/WebElement_LevelD.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot    # CAMP
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot

*** Variables ***
#เอาไว้สำหรับเลือกโปรดัก เพื่อไม่ให้โปรโมชั่นชนกันกับ test case อื่นจ้า
${start_normal}    9
${start_free}     11

*** Test Cases ***
TC_iTM_00513 : Level D shows "out-of-stock" when primary item is out of stock but free item is enough
    [Tags]    QCT
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
