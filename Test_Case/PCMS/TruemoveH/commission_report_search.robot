*** Settings ***
Force Tags        WLS_TruemoveH
Test Teardown     Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Features/Cms_Template/keywords_mail_and_sms.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_order_report.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_activate_sim_report.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_commission_report.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_commission_report.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_track_orders.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_order_detail.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot


Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_super_number.robot
Resource          ${CURDIR}/../../../Keyword/API/api_super_number/keyword_super_number_common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot



*** Variable ***
${mobile_number}     0000009992
${mobile_list}    Seer_nitikit=0000009992
${sub_description_1}    Robot Sub_Desc_1
${description_1}    Robot Long_Desc_1
${recommend_y}    Y
${user_itm}    thorfortest@gmail.com
${pass_itm}    thorthor

*** Test Cases ***
TC_ITMWM_05008 Add "All" in Activated dropdown
    [Tags]    TC_ITMWM_05008    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Activated Display Default Value    ${ACTIVATED.all}
    TMVH Commission Report - Activated has value    ${ACTIVATED.all}
    TMVH Commission Report - Activated has value    ${ACTIVATED.more_than_15days}
    TMVH Commission Report - Activated has value    ${ACTIVATED.less_than_15days}

TC_ITMWM_05009 Add "All" in Downloaded dropdown
    [Tags]    TC_ITMWM_05009    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Activated Display Default Value    ${DOWNLOADED.all}
    TMVH Commission Report - Activated has value    ${DOWNLOADED.all}
    TMVH Commission Report - Activated has value    ${DOWNLOADED.undownloaded}
    TMVH Commission Report - Activated has value    ${DOWNLOADED.downloaded}

TC_ITMWM_05010 Add search by order id in the filtering section of type sim only
    [Tags]    TC_ITMWM_05010    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Display textbox Search By Order ID
    TMVH Commission Report - Activated Display Default Value    ${ACTIVATED.all}
    TMVH Commission Report - Downloaded Display Default Value    ${DOWNLOADED.all}
    TMVH Commission Report - Start Date Display Default Value    ${EMPTY}
    TMVH Commission Report - End Date Display Default Value    ${EMPTY}
    TMVH Commission Report - Display Search Button
    TMVH Commission Report - Display Reset Button

TC_ITMWM_05011 Add search by order id in the filtering section of type bundle
    [Tags]    TC_ITMWM_05011    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.bundle}
    TMVH Commission Report - Display textbox Search By Order ID
    TMVH Commission Report - Activated Display Default Value    ${ACTIVATED.all}
    TMVH Commission Report - Downloaded Display Default Value    ${DOWNLOADED.all}
    TMVH Commission Report - Start Date Display Default Value    ${EMPTY}
    TMVH Commission Report - End Date Display Default Value    ${EMPTY}
    TMVH Commission Report - Display Search Button
    TMVH Commission Report - Display Reset Button

TC_ITMWM_05012 Add search by order id in the filtering section of type MNP SIM
    [Tags]    TC_ITMWM_05012    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.mnp}
    TMVH Commission Report - Display textbox Search By Order ID
    TMVH Commission Report - Activated Display Default Value    ${ACTIVATED.all}
    TMVH Commission Report - Downloaded Display Default Value    ${DOWNLOADED.all}
    TMVH Commission Report - Start Date Display Default Value    ${EMPTY}
    TMVH Commission Report - End Date Display Default Value    ${EMPTY}
    TMVH Commission Report - Display Search Button
    TMVH Commission Report - Display Reset Button

TC_ITMWM_05013 Add search by order id in the filtering section of type MNP Device
    [Tags]    TC_ITMWM_05013    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.mnp_device}
    TMVH Commission Report - Display textbox Search By Order ID
    TMVH Commission Report - Activated Display Default Value    ${ACTIVATED.all}
    TMVH Commission Report - Downloaded Display Default Value    ${DOWNLOADED.all}
    TMVH Commission Report - Start Date Display Default Value    ${EMPTY}
    TMVH Commission Report - End Date Display Default Value    ${EMPTY}
    TMVH Commission Report - Display Search Button
    TMVH Commission Report - Display Reset Button

TC_ITMWM_05014 Display error message if a PCMS user not input required field
    [Tags]    TC_ITMWM_05014    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Display Search Button
    TMVH Commission Report - Click Search Button
    Sleep                  5s
    Confirm Action
    Location Should Contain    ${PCMS_URL}/truemoveh/commission-report

TC_ITMWM_05015 Search commission report of Sim Only by order id
    [Tags]    TC_ITMWM_05015    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report DB - Get Commission Report Data    sim
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${var_tmvh_commission_bundle_type_value}
    ${var_tmvh_commission_pcms_order_id_str}=    Convert To String    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Input Order ID    ${var_tmvh_commission_pcms_order_id_str}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${var_tmvh_commission_pcms_order_id}

TC_ITMWM_05016 Search commission report of Bundle by order id
    [Tags]    TC_ITMWM_05016    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report DB - Get Commission Report Data    bundle
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${var_tmvh_commission_bundle_type_value}
    ${var_tmvh_commission_pcms_order_id_str}=    Convert To String    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Input Order ID    ${var_tmvh_commission_pcms_order_id_str}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${var_tmvh_commission_pcms_order_id}

TC_ITMWM_05017 Search commission report of MNP SIM by order id
    [Tags]    TC_ITMWM_05017    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report DB - Get Commission Report Data Mnp
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${var_tmvh_commission_bundle_type_value}
    ${var_tmvh_commission_pcms_order_id_str}=    Convert To String    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Input Order ID    ${var_tmvh_commission_pcms_order_id_str}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${var_tmvh_commission_pcms_order_id}

TC_ITMWM_05018 Search commission report of MNP Device by order id
    [Tags]    TC_ITMWM_05018    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report DB - Get Commission Report Data    mnp_device
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${var_tmvh_commission_bundle_type_value}
    ${var_tmvh_commission_pcms_order_id_str}=    Convert To String    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Input Order ID    ${var_tmvh_commission_pcms_order_id_str}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${var_tmvh_commission_pcms_order_id}

TC_ITMWM_05019 Search order ID of Sim Only with criteria : Activated=All, Downloaded=Undownloaded
    [Tags]    TC_ITMWM_05019    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report DB - Get Commission Report Data    sim    ${EQUAL}
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${var_tmvh_commission_bundle_type_value}
    TMVH Commission Report - Select Downloaded    ${DOWNLOADED.undownloaded}
    ${var_tmvh_commission_pcms_order_id_str}=    Convert To String    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Input Order ID    ${var_tmvh_commission_pcms_order_id_str}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Display Download Count    ${var_tmvh_commission_download_count}

TC_ITMWM_05024 Search order ID of Bundle with criteria : Activated=All, Downloaded=Downloaded
    [Tags]    TC_ITMWM_05024    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report DB - Get Commission Report Data    bundle    ${MORE_THAN}
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${var_tmvh_commission_bundle_type_value}
    TMVH Commission Report - Select Downloaded    ${DOWNLOADED.downloaded}
    ${var_tmvh_commission_pcms_order_id_str}=    Convert To String    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Input Order ID    ${var_tmvh_commission_pcms_order_id_str}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Display Download Count    ${var_tmvh_commission_download_count}

TC_ITMWM_05029 Search order ID of Sim Only with criteria : Activated=Equal or mare than 15 days, Downloaded=All
    [Tags]    TC_ITMWM_05029    regression    ready    ITMMZ-1456    BP-2016S13    blackpanther
    TMVH Commission Report DB - Get Commission Report Data with Activate Date    sim    ${EQUAL_OR_MORE_THAN}
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${var_tmvh_commission_bundle_type_value}
    TMVH Commission Report - Select Activated    ${ACTIVATED.more_than_15days}
    ${var_tmvh_commission_pcms_order_id_str}=    Convert To String    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Input Order ID    ${var_tmvh_commission_pcms_order_id_str}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${var_tmvh_commission_pcms_order_id}
    TMVH Commission Report - Display Download Count    ${var_tmvh_commission_download_count}

TC_ITMWM_07837 To verify that system display only Super Number order when user search commission report by type = Sim Only and merchant type = Seer Nitikit.
    [Tags]    TC_ITMWM_07837    regression    ready
    ######################################## Create super number order ########################################
    ${current_date} =    Get Current Date
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot
    ${inventory_id}=    Run Keyword If    '${ENV}' == 'staging'    Set Variable    THOOR1111111
    ...    ELSE    Set Variable    APAAE1116111
    ${zone_id}=    Set Variable    1
    User Login From login page   ${user_itm}   ${pass_itm}
    Clear Cart Current User
    remove_mobile_by_number    ${mobile_number}
    ${redirect_url_response}    ${proposition_id}    ${price_plan_id}=    Supernumber - Prepare cart and return redirect redirect_url    ${unique_id}    ${mobile_number}    ${sub_description_1}    ${description_1}    ${recommend_y}
    Go To    ${redirect_url_response}
    Maximize Browser Window
    Supernumber - Verify Field on Register Page    ${mobile_number}    ${sub_description_1}
    Sleep   3
    Supernumber - Input Information on Register Page    sim_model=${inventory_id}
    Supernumber - Set Shipping Address to be the same as Customer Address
    Supernumber - Accept Policy
    Supernumber - Submit Register Page
    Supernumber - Confirm Register
    ${order_id}=    Supernumber - Submit Order
    Log to Console    ${order_id}
    ######################################## Activated SIM ########################################
    Set Test Variable        ${var_mail_sms_order_id}       ${order_id}
    Set Test Variable        ${var_tmh_sim_inventory_id}    ${inventory_id}
    Cms Template Mail Sms - Approve Thai ID
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    20161111    1
    Send Api update status    ${body}
    Cms Template Mail Sms - Activate Sim to Status Success    1
    ######################################## Commission Report ########################################
    ${current_date} =    Get Current Date
    ${current_date} =    Convert Date    ${current_date}    result_format=%Y-%m-%d
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Select Dealer    1
    TMVH Commission Report - Input Start Date        ${current_date}
    TMVH Commission Report - Input End Date        ${current_date}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${order_id}
    TMVH Commission Report - Click Reset Button
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Select Dealer    0
    TMVH Commission Report - Input Start Date        ${current_date}
    TMVH Commission Report - Input End Date        ${current_date}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - No Row Data Is Displayed    ${order_id}
    TMVH Commission Report - Click Reset Button
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Select Dealer    1
    TMVH Commission Report - Select Activated    ${ACTIVATED.less_than_15days}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - Display Row Data    ${order_id}
    TMVH Commission Report - Select Activated    ${ACTIVATED.more_than_15days}
    TMVH Commission Report - Click Search Button
    TMVH Commission Report - No Row Data Is Displayed    ${order_id}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07835 To verify that value on merchant type dropdown list is composed of iTrueMart and data on truemoveh_merchants table
    [Tags]     TC_ITMWM_07835     regression    ready
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    ${mobile_type_ui_raw_data}=    Get List Items     ${tmvh_commission_merchant_type}
    ${merchant_type_db}=    TMVH Commission Report - Get Dealer List From DB
    TMVH Commission Report - Check Dealer List Match With DB    ${mobile_type_ui_raw_data}    ${merchant_type_db}
    TMVH Commission Report - Click Reset Button
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.bundle}
    ${mobile_type_ui_raw_data}=    Get List Items     ${tmvh_commission_merchant_type}
    ${merchant_type_db}=    TMVH Commission Report - Get Dealer List From DB
    TMVH Commission Report - Check Dealer List Match With DB    ${mobile_type_ui_raw_data}    ${merchant_type_db}
    TMVH Commission Report - Click Reset Button
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.mnp}
    ${mobile_type_ui_raw_data}=    Get List Items     ${tmvh_commission_merchant_type}
    ${merchant_type_db}=    TMVH Commission Report - Get Dealer List From DB
    TMVH Commission Report - Check Dealer List Match With DB    ${mobile_type_ui_raw_data}    ${merchant_type_db}
    TMVH Commission Report - Click Reset Button
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.mnp_device}
    ${mobile_type_ui_raw_data}=    Get List Items     ${tmvh_commission_merchant_type}
    ${merchant_type_db}=    TMVH Commission Report - Get Dealer List From DB
    TMVH Commission Report - Check Dealer List Match With DB    ${mobile_type_ui_raw_data}    ${merchant_type_db}

TC_ITMWM_07834 To verify that new filter 'merchant type' is displayed and default value is iTrueMart on truemove h commission report menu.
    [Tags]     TC_ITMWM_07834     regression    ready
    TMVH Commission Report - Login PCMS    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    TMVH Commission Report - Go To TruemoveH Commission Report
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.sim_only}
    TMVH Commission Report - Check Dealer Default Value
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.bundle}
    TMVH Commission Report - Check Dealer Default Value
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.mnp}
    TMVH Commission Report - Check Dealer Default Value
    TMVH Commission Report - Select Type    ${BUNDLE_TYPE.mnp_device}
    TMVH Commission Report - Check Dealer Default Value