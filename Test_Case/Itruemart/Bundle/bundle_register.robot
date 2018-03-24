*** Settings ***
Force Tags    WLS_Bundle
Library           Selenium2Library
Library           OperatingSystem
Library           HttpLibrary.HTTP
Library           DateTime
Library           Collections
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Manage_Price_Plan/WebElement_Manage_PricePlan.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Library           ${CURDIR}/../../../Python_Library/mnp_util.py
Library           ${CURDIR}/../../../Python_Library/product.py

*** Test Cases ***
TC_iTM_Dummy Check Price Plans Bundle have Priceplan1 Y
    [Tags]    TC1    Bundle    ready
    ${expect_priceplan_shown}    Set Variable    1
    ${priceplan_1_status}    Set Variable    Y
    ${priceplan_1_short_desc}    Set Variable    Priceplan 1 Short Description
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    Prepare TruemoveH Product Bundle On PCMS    ${priceplan_1_status}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    ${product_pkey}=    Set Variable    ${var_tmh_product_device_pkey}
    LvD - Open Level D Page By Product Pkey    ${product_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    LvD - Click Style Option By Variant Pkey    ${variants}
    Sleep    10s
    Update Priceplan Status    ${var_tmh_price_plan_id}
    LvD - Click Buy All
    LvD - Remove Chatbar
    Should Be Without PricePlan
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product Bundle On PCMS
    ...    AND    Close Browser
