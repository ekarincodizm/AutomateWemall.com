*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/Features/Mnp/keywords_mnp_register.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_verify_thai_id.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_order_detail.robot
Suite Teardown    Close All Browsers

*** Variables ***
${var_username}         blackpantherautomate2@gmail.com
${var_password}         true1234
${var_data_firstname}    Blackpanther
${var_data_lastname}     Automate
${var_data_gender}       female
${var_data_tel}          0800000001
${var_data_idcard}       4410464455153

${mnp_device_idcard}                        1356818078716
${mnp_device_mobile_number}                 เบอร์ทรู

*** Test Cases ***
TEST : Add Mnp Device
    [Tags]    test
#    TruemoveH - Get Truemvoeh Data For Buy Mnp Deice
#    Set camp
#    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number     ${mnp_device_mobile_number}
#    TruemoveH - [MNP Device] Prepare Mnp Order Verify               ${mnp_device_idcard}
#    ...     ${mnp_device_mobile_number}
#    API Cart - Add MNP Device       APAAA1116211
#    ...     22465193        # customer_ref_id
#    ...     user            # customer_type
#    ...     ${mnp_device_mobile_number}
#    ...     ${mnp_device_idcard}
#    ...     2               # price_plan
#    ...     mnp_device

TC_iTM_04776 - Can move to TMH again if the previous MNP1 has thai id status = rejected
    [Tags]  TC_iTM_04776        blackpanther
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number                 ${var_data_tel}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}5       mnp
    ${order_id}=    Checkout CCW Success
    Login Pcms
    MNP1 has Reject Thai ID    ${order_id}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}5       mnp
    API Cart - Expect Add Mnp Success
    [Teardown]          Run Keywords            Remove Test Data on Truemoveh Order Verifys

TC_iTM_04777 - Can move to TMH again if the previous MNP1 has thai id status = customer canceled
    [Tags]  TC_iTM_04777        blackpanther
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number                 ${var_data_tel}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}5       mnp
    ${order_id}=    Checkout CCW Success
    Login Pcms
    MNP1 has Customer Cancel    ${order_id}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}5       mnp
    API Cart - Expect Add Mnp Success
    [Teardown]          Run Keywords            Remove Test Data on Truemoveh Order Verifys

TC_iTM_04778 - Can move to TMH again if the previous MNP1 has item status = customer cancelled
    [Tags]  TC_iTM_04778        blackpanther
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number                 ${var_data_tel}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}5       mnp
    ${order_id}=    Checkout CCW Success
    Login Pcms
    MNP1 has Approve    ${order_id}
    Set Item Status Customer Cancel    ${order_id}
    Order Detail - Change All Items Status To Customer Cancel    ${order_id}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}5       mnp
    API Cart - Expect Add Mnp Success
    [Teardown]          Run Keywords            Remove Test Data on Truemoveh Order Verifys

TC_iTM_04779 Can move to TMH again after payment status = failed
    [Tags]  TC_iTM_04779  blackpanther
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number                 ${var_data_tel}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}5       mnp
    Checkout CCW Failed
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}       mnp
    Checkout CCW Success
    [Teardown]          Run Keywords            Remove Test Data on Truemoveh Order Verifys

TC_iTM_04780 Cannot move to TMH again after payment status = waiting
    [Tags]  TC_iTM_04780
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number                 ${var_data_tel}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}       mnp
    Checkout CCW Expired
    Sleep               5s
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}       mnp
    API Cart - Expect Cannot Add Mnp
    [Teardown]          Run Keywords            Remove Test Data on Truemoveh Order Verifys

TC_iTM_04781 Can move to TMH again after payment status = expired
    [Tags]  TC_iTM_04781  blackpanther
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number                 ${var_data_tel}
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}       mnp
    Checkout CCW Expired
    Sleep               5s
    TruemoveH - Get Pcms Order Id By Mobile and IdCard      ${var_data_tel}     ${var_data_idcard}
    Orders - Update Order Expired           ${var_tmh_pcms_order_id}
    Orders - Clear Expired Order
    User Login From login page         ${var_username}           ${var_password}
    Clear Cart Current User
    API Cart - Add MNP Sim    ${var_tmh_mnp_sim_inventory_id}        ${TV_user_id}       ${TV_user_type}     ${var_data_tel}          ${var_data_idcard}           ${var_tmh_price_plan_mnp_sim}       mnp
    Checkout CCW Success
    [Teardown]          Run Keywords            Remove Test Data on Truemoveh Order Verifys
