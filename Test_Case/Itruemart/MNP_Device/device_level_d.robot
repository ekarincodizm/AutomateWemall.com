*** Settings ***
Force Tags    WLS_MNP
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mnp_handset/keywords_handset.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mnp_verify/keywords_verify.robot
Library           ${CURDIR}/../../../Python_Library/mnp_util.py
Library           ${CURDIR}/../../../Python_Library/truemoveh_order_verify.py
Library           ${CURDIR}/../../../Python_Library/order.py

*** Test Cases ***
TC_iTM_01768 Display active price plan on Level D - package details link for MNP device
    [Tags]    TC_iTM_01768    ready     regression
    Prepare TruemoveH Product MNP Device On PCMS One Priceplan
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}    ${device_discount_type}    ${device_discount}    ${var_tmh_price_plan_code}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=    Get From List    ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}
    LvD - Remove Chatbar
    LvD - Click Mnp Tab
    LvD - Click MNP Device Package Information
    ${count_package}=    LvD - Count Price Plan MNP Device
    Should Be Equal    ${count_package}    1
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS
    ...    AND    Close All Browsers

TC_iTM_01769 No MNP tab displayed when no active price plan at all
    [Tags]    TC_iTM_01769    ready  regression
    ${priceplan_status}=    Set Variable    N
    Prepare TruemoveH Product MNP Device On PCMS One Priceplan    ${priceplan_status}
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}    ${device_discount_type}    ${device_discount}    ${var_tmh_price_plan_code}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=    Get From List    ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}
    LvD - Remove Chatbar
    LvD - Mnp Tab Not Be Visible
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS
    ...    AND    Close All Browsers

TC_iTM_01770 Display active price plan on Level D - package details link for MNP device
    [Tags]    TC_iTM_01770    ready   regression
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
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=    Get From List    ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}
    LvD - Remove Chatbar
    LvD - Click Mnp Tab
    LvD - Click MNP Device Package Information
    ${count_package}=    LvD - Count Price Plan MNP Device
    Log To Console    count_package=${count_package}
    Should Be Equal    ${count_package}    1
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS Two Priceplans    ${priceplan_1}    ${priceplan_2}    ${proposition_map_1}    ${proposition_map_2}
    ...    AND    Close All Browsers

TC_iTM_01771 Display active price plan on Level D - package details link for MNP device
    [Tags]    ready   regression
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
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=    Get From List    ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}
    LvD - Remove Chatbar
    LvD - Mnp Tab Not Be Visible
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS Two Priceplans    ${priceplan_1}    ${priceplan_2}    ${proposition_map_1}    ${proposition_map_2}
    ...    AND    Close All Browsers

TC_iTM_01773 Show error message if no active price plan
    [Tags]    TC_iTM_01773   regression
    ${priceplan_status}=    Set Variable    Y
    Prepare TruemoveH Product MNP Device On PCMS One Priceplan    ${priceplan_status}
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}    ${device_discount_type}    ${device_discount}    ${var_tmh_price_plan_code}
    ${order_return}=    Create Order
    Log To Console    order_return=${order_return}
    ${order_id}=    Get From Dictionary    ${order_return}    lastid
    Log To console    order_id=${order_id}
    # Prepare Data
    ${dict}=    Create Dictionary    idcard=8512551099081    mobile=0961415653    mnp1_status=success    activate_status=success    status=Y
    ...    pcms_order_id=${order_id}
    ${r}=    create_truemoveh_order_verify    ${dict}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=    Get From List    ${variants}    0
    LvD - Remove Chatbar
    LvD - Click Style Option By Variant Pkey    ${variants}
    Wait Until Ajax Loading Is Not Visible
    LvD - Mnp Tab Is Visible
    LvD - User Click Buy Button MNP
    User Enter Mobile No    0961415653
    User Enter Id Card    8512551099081
    #Input Text    //input[@name="msisdn"]    0961415653
    #Input Text    //input[@name="idcard"]    3101200151538
    User Select Valid Birthdate
    User Click Verify Button
    Wait Until Ajax Loading Is Not Visible
    User Click Link Next Operate
    Wait Until Ajax Loading Is Not Visible
    Display Handset Step1 Page
    [Teardown]    Run keywords    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Order Verify By Mobile    0961415653
    ...    AND    Delete TruemoveH Product On PCMS
    ...    AND    Close All Browsers
