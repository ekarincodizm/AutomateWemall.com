*** Settings ***
Force Tags        WLS_API_PCMS
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/CAMP_API/get_priceplan_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Manage_Price_Plan/WebElement_Manage_PricePlan.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Library           ${CURDIR}/../../../Python_Library/mnp_util.py
Library           ${CURDIR}/../../../Python_Library/truemoveh_order_verify.py
Library           ${CURDIR}/../../../Python_Library/order.py

*** Test Cases ***
TC_ITMWM_05655 Bundle Lv.D 2 price plans (A disable, B enable) Should Be Show B Not show A
    [Tags]   TC_ITMWM_05655   Bundle Lv.D 2 price plans (A disable, B enable) Should Be Show B Not show A    ready   regression    WLS_High
    ${expect_priceplan_shown}    Set Variable    1
    ${priceplan_1_status}    Set Variable    N
    ${priceplan_2_status}    Set Variable    Y
    ${priceplan_1_short_desc}    Set Variable    Priceplan 1 Short Description
    ${priceplan_2_short_desc}    Set Variable    Priceplan 2 Short Description
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    ${run_data}=    Prepare TruemoveH Product Bundle On PCMS Two Priceplans    ${priceplan_1_status}    ${priceplan_2_status}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    API Return Price Plan Status The Same As Prepare Data Step For 2 Price Plan Diable 1 and Enable 1    ${var_tmh_product_device_inventory_id}    ${priceplan_2_status}    bundle
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product Bundle On PCMS Two Priceplans    ${run_data}

TC_ITMWM_05656 Bundle Lv.D 1 price plan (A disable) Should Be Not Show A
    [Tags]    TC_ITMWM_05656    Bundle Lv.D 1 price plan (A disable) Should Be Not Show A    ready   regression    WLS_Medium
    ${expect_priceplan_shown}    Set Variable    0
    ${priceplan_1_status}    Set Variable    N
    ${priceplan_1_short_desc}    Set Variable    Priceplan 1 Short Description
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    Prepare TruemoveH Product Bundle On PCMS    ${priceplan_1_status}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    API Return Price Plan Status The Same As Prepare Data Step For 1 Price Plan and Disable    ${var_tmh_product_device_inventory_id}    bundle
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product Bundle On PCMS

TC_ITMWM_05657 Bundle Lv.D 1 price plan (A enable) Should Be Show A
    [Tags]    TC_ITMWM_05657    Bundle Lv.D 1 price plan (A enable) Should Be Show A    ready   regression    WLS_Medium
    ${expect_priceplan_shown}    Set Variable    1
    ${priceplan_1_status}    Set Variable    Y
    ${priceplan_1_short_desc}    Set Variable    Priceplan 1 Short Description
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    Prepare TruemoveH Product Bundle On PCMS    ${priceplan_1_status}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    API Return Price Plan Status The Same As Prepare Data Step For 1 Price Plan And Enable    ${var_tmh_product_device_inventory_id}    ${priceplan_1_status}    bundle
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product Bundle On PCMS

TC_ITMWM_05658 Bundle Lv.D 2 price plans (A,B enable) Should Be Show A,B
    [Tags]    TC_ITMWM_05658    Bundle Lv.D 2 price plans (A,B enable) Should Be Show A,B    ready   regression    WLS_High
    ${expect_priceplan_shown}    Set Variable    2
    ${priceplan_1_status}    Set Variable    Y
    ${priceplan_2_status}    Set Variable    Y
    ${priceplan_1_short_desc}    Set Variable    Priceplan 1 Short Description
    ${priceplan_2_short_desc}    Set Variable    Priceplan 2 Short Description
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    ${run_data}=    Prepare TruemoveH Product Bundle On PCMS Two Priceplans    ${priceplan_1_status}    ${priceplan_2_status}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    API Return Price Plan Status The Same As Prepare Data Step For 2 Price Plan And Enable    ${var_tmh_product_device_inventory_id}    ${priceplan_1_status}    ${priceplan_2_status}    bundle
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product Bundle On PCMS Two Priceplans    ${run_data}

TC_ITMWM_05659 MNP2 Lv.D 2 price plans (A disable, B enable) Should Be Show B, Not show A
    [Tags]    TC_ITMWM_05659    MNP2, 2 price plans (A disable, B enable) Should Be Show B, Not show A    ready   regression    WLS_Medium
    ${priceplan_1_status}=    Set Variable    N
    ${priceplan_2_status}=    Set Variable    Y
    ${run_data}=    Prepare TruemoveH Product MNP Device On PCMS Two Priceplan    ${priceplan_1_status}    ${priceplan_2_status}
    ${priceplan_1}=    Get From Dictionary    ${run_data}    priceplan_1
    ${priceplan_2}=    Get From Dictionary    ${run_data}    priceplan_2
    ${proposition_map_1}=    Get From Dictionary    ${run_data}    proposition_map_1
    ${proposition_map_2}=    Get From Dictionary    ${run_data}    proposition_map_2
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data 2    ${var_tmh_product_device_inventory_id}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    API Return Price Plan Status The Same As Prepare Data Step For 2 Price Plan Diable 1 and Enable 1    ${var_tmh_product_device_inventory_id}    ${priceplan_2_status}    mnp_device
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS Two Priceplans    ${priceplan_1}    ${priceplan_2}    ${proposition_map_1}    ${proposition_map_2}

TC_ITMWM_05660 Lv.D 1 price plans (A disable) Should Be Show B Only
    [Tags]    TC_ITMWM_05660    MNP2 Lv.D, 1 price plans (A disable) Should Be Show B Only    ready   regression    WLS_Medium
    ${priceplan_status}=    Set Variable    N
    Prepare TruemoveH Product MNP Device On PCMS One Priceplan    ${priceplan_status}
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}    ${device_discount_type}    ${device_discount}    ${var_tmh_price_plan_code}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    API Return Price Plan Status The Same As Prepare Data Step For 1 Price Plan and Disable    ${var_tmh_product_device_inventory_id}    mnp_device
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS

TC_ITMWM_05661 MNP2 Lv.D 1 price plan (A enable) Should Be Show A
    [Tags]    TC_ITMWM_05661    MNP2 Lv.D 1 price plan (A enable) Should Be Show A    ready   regression    WLS_Medium
    Prepare TruemoveH Product MNP Device On PCMS One Priceplan
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}    ${device_discount_type}    ${device_discount}    ${var_tmh_price_plan_code}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    API Return Price Plan Status The Same As Prepare Data Step For 1 Price Plan And Enable    ${var_tmh_product_device_inventory_id}    Y    mnp_device
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS

TC_ITMWM_05662 MNP2 Lv.D 2 price plans (A,B disable) Should Be Not show A,B
    [Tags]    TC_ITMWM_05662    MNP2 Lv.D 2 price plans (A,B disable) Should Be Not show A,B    ready   regression    WLS_High
    ${priceplan_1_status}=    Set Variable    N
    ${priceplan_2_status}=    Set Variable    N
    ${run_data}=    Prepare TruemoveH Product MNP Device On PCMS Two Priceplan    ${priceplan_1_status}    ${priceplan_2_status}
    ${priceplan_1}=    Get From Dictionary    ${run_data}    priceplan_1
    ${priceplan_2}=    Get From Dictionary    ${run_data}    priceplan_2
    ${proposition_map_1}=    Get From Dictionary    ${run_data}    proposition_map_1
    ${proposition_map_2}=    Get From Dictionary    ${run_data}    proposition_map_2
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data 2    ${var_tmh_product_device_inventory_id}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    API Return Price Plan Status The Same As Prepare Data Step For 2 Price Plan And Disable    ${var_tmh_product_device_inventory_id}    mnp_device
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS Two Priceplans    ${priceplan_1}    ${priceplan_2}    ${proposition_map_1}    ${proposition_map_2}
