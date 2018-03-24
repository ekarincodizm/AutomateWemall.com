*** Settings ***
Test Teardown     Close All Browsers
Suite Teardown    Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/TruemoveH/keywords_sim.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/TruemoveH/keywords_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_order_detail.robot
Resource          ${CURDIR}/../../../Keyword/Features/Order_detail/keywords_update_customer_info.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot

*** Variables ***
${CHECKOUT_TIMEOUT}    20s
${username_login}    blackpantherautomate2@gmail.com
${password_login}    true1234

*** Test Cases ***
TC_iTM_04787 Can not buy TMH no. again if has already been successfully purchased [Sim only]
    [Tags]      TC_iTM_04787   ready   TruemoveH   ITMMZ-1458   X-Support-2016S14       blackpanther
    Update Customer Info - Login and Clear Cart
    TruemoveH Sim - Add Sim To Cart     ${TV_user_id}       ${TV_user_type}
    Update Customer Info - Pay Failed
    Update Customer Info - Get Order Id
    Update Customer Info - Login and Clear Cart
    TruemoveH Sim - Add Sim To Cart II     ${var_tmh_sim_inventory_id}      ${TV_user_id}       ${TV_user_type}     ${var_tmh_sim_mobile_id}        ${var_random_id_card}       ${var_tmh_sim_mobile_price_plan_id}
    Update Customer Info - Pay Success
    Update Customer Info - Update Customer Address on Pcms
    Update Customer Info - Expect Not found TMH Number Available on web [Sim Only]
    [Teardown]          Run Keywords            Update Customer Info - Hold Cancel [Sim]

TC_iTM_04788 Can not buy TMH no. again if has already been successfully purchased [Bundle]
    [Tags]      TC_iTM_04788        ready       TruemoveH       ITMMZ-1458      X-Support-2016S14      blackpanther
    Update Customer Info - Login and Clear Cart
    TruemoveH Bundle - Add Bundle To Cart           ${TV_user_id}       ${TV_user_type}
    Update Customer Info - Pay Failed
    Update Customer Info - Get Order Id
    Update Customer Info - Login and Clear Cart
    TruemoveH Bundle - Add Bundle To Cart Fixed Data       ${var_data_bundle_product_inventory_id}     ${var_data_bundle_product_sim_inventory_id}     ${TV_user_id}       ${TV_user_type}     ${var_data_mobile_id}       ${var_random_id_card}       ${var_data_bundle_price_plan_id}
    Update Customer Info - Pay Success
    Update Customer Info - Update Customer Address on Pcms
    Update Customer Info - Expect Not found TMH Number Available on web [Bundle]
    [Teardown]          Run Keywords            Update Customer Info - Hold Cancel [Bndle]
    ...     Update Customer Info - Delete Promotion Bundle on Camp
    ...     Close All Browsers

TC_iTM_04791 Can not buy TMH no. again although a PCMS user update customer info in successfully order [Sim only]
    [Tags]      TC_iTM_04791        ready       TruemoveH       ITMMZ-1458      X-Support-2016S14       blackpanther
    Update Customer Info - Login and Clear Cart
    TruemoveH Sim - Add Sim To Cart     ${TV_user_id}       ${TV_user_type}
    Update Customer Info - Pay Success
    Update Customer Info - Get Order Id
    Update Customer Info - Update Customer Address on Pcms
    Update Customer Info - Expect Not found TMH Number Available on web [Sim Only]
    [Teardown]          Run Keywords            Update Customer Info - Hold Cancel [Sim]
    ...     Close All Browsers

TC_iTM_04792 Can not buy TMH no. again although a PCMS user update customer info in successfully order [Bundle]
    [Tags]      TC_iTM_04792        ready       TruemoveH       ITMMZ-1458      X-Support-2016S14       blackpanther
    Update Customer Info - Login and Clear Cart
    TruemoveH Bundle - Add Bundle To Cart           ${TV_user_id}       ${TV_user_type}
    Update Customer Info - Pay Success
    Update Customer Info - Get Order Id
    Update Customer Info - Update Customer Address on Pcms
    Update Customer Info - Expect Not found TMH Number Available on web [Bundle]
    [Teardown]          Run Keywords            Update Customer Info - Hold Cancel [Bndle]
    ...     Update Customer Info - Delete Promotion Bundle on Camp
    ...     Close All Browsers
