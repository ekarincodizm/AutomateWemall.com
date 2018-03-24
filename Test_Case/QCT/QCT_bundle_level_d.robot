*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Library           HttpLibrary.HTTP
Library           DateTime
Library           Collections
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Manage_Price_Plan/WebElement_Manage_PricePlan.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Library           ${CURDIR}/../../Python_Library/mnp_util.py
Resource          ../../Resource/init.robot

*** Test Cases ***
Display active price plan on Level D - package details link for bundle
    [Tags]    QCT
    ${expect_priceplan_shown}    Set Variable    1
    ${priceplan_1_status}    Set Variable    N
    ${priceplan_2_status}    Set Variable    Y
    ${priceplan_1_short_desc}    Set Variable    Priceplan 1 Short Description
    ${priceplan_2_short_desc}    Set Variable    Priceplan 2 Short Description
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    ${run_data}=    Prepare TruemoveH Product Bundle On PCMS Two Priceplans    ${priceplan_1_status}    ${priceplan_2_status}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    ${product_pkey}=    Set Variable    ${var_tmh_product_device_pkey}
    LvD - Open Level D Page By Product Pkey    ${product_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    LvD - Click Style Option By Variant Pkey    ${variants}
    LvD - Remove Chatbar
    LvD - Click Bundle Tab
    LvD - Click Bundle Package Information
    ${actual_priceplan_shown}=    LvD - Count Price Plan Bundle
    Should Be Equal    ${actual_priceplan_shown}    ${expect_priceplan_shown}
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product Bundle On PCMS Two Priceplans    ${run_data}
    ...    AND    Close Browser

No bundle tab displayed when no active price plan at all
    [Tags]    QCT
    ${expect_priceplan_shown}    Set Variable    0
    ${priceplan_1_status}    Set Variable    N
    ${priceplan_1_short_desc}    Set Variable    Priceplan 1 Short Description
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    Prepare TruemoveH Product Bundle On PCMS    ${priceplan_1_status}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    ${product_pkey}=    Set Variable    ${var_tmh_product_device_pkey}
    LvD - Open Level D Page By Product Pkey    ${product_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    LvD - Click Style Option By Variant Pkey    ${variants}
    LvD - Remove Chatbar
    LvD - Bundle Tab Not Be Visible
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product Bundle On PCMS
    ...    AND    Close Browser
