*** Settings ***
Force Tags        WLS_Supernumber
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           DateTime
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/TruemoveH/keywords_super_number.robot
Library           ${CURDIR}/../../Python_Library/truemoveh_import_mobile_number.py
Library           ${CURDIR}/../../Python_Library/truemoveh_super_number.py
Resource          ${CURDIR}/../../Keyword/API/api_super_number/keyword_super_number_common.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Login/keywords_login.robot


*** Variable ***
${mobile_number}     0200099991
${mobile_number_2}     0200099992
${sub_description_1}    Robot Sub_Desc_1
${sub_description_2}    Robot Sub_Desc_2
${description_1}    Robot Long_Desc_1
${description_2}    Robot Long_Desc_2
${recommend_y}    Y
${user_itm}    thorfortest@gmail.com
${pass_itm}    thorthor


*** Test Cases ***

TC_ITMWM_07606 To verify that API can create cart mobile number successful.
    [Tags]    TC_ITMWM_07606    regression    ready    WLS_High

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    ${inventory_id}=    Run Keyword If    '${ENV}' == 'staging'    Set Variable    THOOR1111211
    ...    ELSE    Set Variable    APAAE1116211

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
    ${mobile_id}=     SuperNumber - Get Mobile Id By Mobile Number     ${mobile_number}

    Log To Console    order_id=${order_id}
    Log To Console    inventory_id=${inventory_id}
    Log To Console    mobile_id=${mobile_id}
    Log To Console    mobile=${mobile_number}
    Log To Console    price_plan_id=${price_plan_id}
    Log To Console    import_lot=${unique_id}
    Log To Console    zone_id=${zone_id}
    Log To Console    proposition_id=${proposition_id}

    Supernumber - Verify Orders Table     ${order_id}
    Supernumber - Verify Order Shipment Items Table     ${order_id}    ${inventory_id}
    Supernumber - Verify Truemoveh Order Verify Table   ${order_id}    ${mobile_id}   ${mobile_number}    ${price_plan_id}
    Supernumber - Verify Stock Hold Table   ${order_id}
    Supernumber - Verify Truemoveh Hold Mobile Log Table    ${mobile_number}
    Supernumber - Verify Truemoveh Mobiles Table    ${mobile_number}  ${unique_id}    ${zone_id}    ${proposition_id}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}


TC_ITMWM_07657 To verify that validation on super number page works correctly.
    [Tags]    TC_ITMWM_07657    regression    ready    WLS_High
    ${file_name}=    Set Variable    cat_ID.jpg
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot
    ${inventory_id}=    Run Keyword If    '${ENV}' == 'staging'    Set Variable    THOOR1111211
    ...    ELSE    Set Variable    APAAE1116211

    ${zone_id}=    Set Variable    1
    User Login From login page   ${user_itm}   ${pass_itm}
    Clear Cart Current User
    remove_mobile_by_number    ${mobile_number}

    ${redirect_url_response}    ${proposition_id}    ${price_plan_id}=    Supernumber - Prepare cart and return redirect redirect_url    ${unique_id}    ${mobile_number}    ${sub_description_1}    ${description_1}    ${recommend_y}
    Go To    ${redirect_url_response}
    Maximize Browser Window

    Sleep   3
    Supernumber - Verify Field on Register Page    ${mobile_number}    ${sub_description_1}
    Supernumber - Upload Nation ID file    ${file_name}
    Supernumber - Accept Policy
    Supernumber - Submit Register Page
    Supernumber - Verify Error Message on Register Page
    Supernumber - Input Information on Register Page    sim_model=${inventory_id}
    Supernumber - Set Shipping Address to be the same as Customer Address
    Sleep   3
    Supernumber - Verify No Error Message on Register Page
    Supernumber - Submit Register Page
    Supernumber - Confirm Register
    ${order_id}=    Supernumber - Submit Order
    ${mobile_id}=     SuperNumber - Get Mobile Id By Mobile Number     ${mobile_number}
    Supernumber - Verify Orders Table     ${order_id}
    Supernumber - Verify Order Shipment Items Table     ${order_id}    ${inventory_id}
    Supernumber - Verify Truemoveh Order Verify Table   ${order_id}    ${mobile_id}   ${mobile_number}    ${price_plan_id}
    Supernumber - Verify Stock Hold Table   ${order_id}
    Supernumber - Verify Truemoveh Hold Mobile Log Table    ${mobile_number}
    Supernumber - Verify Truemoveh Mobiles Table    ${mobile_number}  ${unique_id}    ${zone_id}    ${proposition_id}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}


TC_ITMWM_07780 To verify that no limit order(no max allow) for super number on registeration page and on create order step, user can create order twice successfully.
    [Tags]    TC_ITMWM_07780    regression    ready    WLS_High

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    ${inventory_id}=    Run Keyword If    '${ENV}' == 'staging'    Set Variable    THOOR1111211
    ...    ELSE    Set Variable    APAAE1116211

    ${zone_id}=    Set Variable    1
    User Login From login page   ${user_itm}   ${pass_itm}
    Clear Cart Current User
    remove_mobile_by_number    ${mobile_number}

    ${redirect_url_response}    ${proposition_id}    ${price_plan_id}=    Supernumber - Prepare cart and return redirect redirect_url    ${unique_id}    ${mobile_number}    ${sub_description_1}    ${description_1}    ${recommend_y}
    Go To    ${redirect_url_response}
    Maximize Browser Window
    Supernumber - Verify Field on Register Page    ${mobile_number}    ${sub_description_1}

    ${national_id_fix}=    Supernumber - Input Random ID card

    Sleep   3
    Supernumber - Input Information on Register Page    sim_model=${inventory_id}    national_id=${national_id_fix}
    Supernumber - Set Shipping Address to be the same as Customer Address
    Supernumber - Accept Policy
    Supernumber - Submit Register Page

    Supernumber - Confirm Register
    ${order_id}=    Supernumber - Submit Order
    ${mobile_id}=     SuperNumber - Get Mobile Id By Mobile Number     ${mobile_number}

    Log To Console    order_id=${order_id}
    Log To Console    inventory_id=${inventory_id}
    Log To Console    mobile_id=${mobile_id}
    Log To Console    mobile=${mobile_number}
    Log To Console    price_plan_id=${price_plan_id}
    Log To Console    import_lot=${unique_id}
    Log To Console    zone_id=${zone_id}
    Log To Console    proposition_id=${proposition_id}

####
    ${unique_id_2}=    SuperNumber - Prepare Data Get Import Lot

    ${zone_id_2}=    Set Variable    1
    User Login From login page   ${user_itm}   ${pass_itm}
    Clear Cart Current User
    remove_mobile_by_number    ${mobile_number_2}

    ${redirect_url_response_2}    ${proposition_id_2}    ${price_plan_id_2}=    Supernumber - Prepare cart and return redirect redirect_url    ${unique_id_2}    ${mobile_number_2}    ${sub_description_2}    ${description_2}    ${recommend_y}
    Go To    ${redirect_url_response_2}
    Maximize Browser Window
    Supernumber - Verify Field on Register Page    ${mobile_number_2}    ${sub_description_2}

    Sleep   3
    Supernumber - Input Information on Register Page    sim_model=${inventory_id}    national_id=${national_id_fix}
    Supernumber - Set Shipping Address to be the same as Customer Address
    Supernumber - Accept Policy
    Supernumber - Submit Register Page

    Supernumber - Confirm Register
    ${order_id_2}=    Supernumber - Submit Order
    ${mobile_id_2}=     SuperNumber - Get Mobile Id By Mobile Number     ${mobile_number_2}

    Log To Console    order_id=${order_id_2}
    Log To Console    inventory_id=${inventory_id}
    Log To Console    mobile_id=${mobile_id_2}
    Log To Console    mobile=${mobile_number_2}
    Log To Console    price_plan_id=${price_plan_id_2}
    Log To Console    import_lot=${unique_id_2}
    Log To Console    zone_id=${zone_id_2}
    Log To Console    proposition_id=${proposition_id_2}

    Supernumber - Verify Orders Table     ${order_id}
    Supernumber - Verify Orders Table     ${order_id_2}
    Supernumber - Verify Order Shipment Items Table     ${order_id}    ${inventory_id}
    Supernumber - Verify Order Shipment Items Table     ${order_id_2}    ${inventory_id}
    Supernumber - Verify Truemoveh Order Verify Table   ${order_id}    ${mobile_id}   ${mobile_number}    ${price_plan_id}
    Supernumber - Verify Truemoveh Order Verify Table   ${order_id_2}    ${mobile_id_2}   ${mobile_number_2}    ${price_plan_id_2}
    Supernumber - Verify Stock Hold Table   ${order_id}
    Supernumber - Verify Stock Hold Table   ${order_id_2}
    Supernumber - Verify Truemoveh Hold Mobile Log Table    ${mobile_number}
    Supernumber - Verify Truemoveh Hold Mobile Log Table    ${mobile_number_2}
    Supernumber - Verify Truemoveh Mobiles Table    ${mobile_number}  ${unique_id}    ${zone_id}    ${proposition_id}
    Supernumber - Verify Truemoveh Mobiles Table    ${mobile_number_2}  ${unique_id_2}    ${zone_id_2}    ${proposition_id_2}

    [Teardown]    Run Keywords    Clear Proposition and Price Plan and Mobile number    ${unique_id}
    ...    AND    Clear Proposition and Price Plan and Mobile number    ${unique_id_2}

TC_ITMWM_07784 To verify that system use number of max allow from DB amd map with correct mobile type.
    [Tags]    TC_ITMWM_07784    ready

    ${seer_nitikit_max_allow_day_old}=    Supernumber - Get Data Truemoveh Mobile Number Types    seer_nitikit
    ${gold_allow_day_old}=    Supernumber - Get Data Truemoveh Mobile Number Types    gold
    ${silver_max_allow_day_old}=    Supernumber - Get Data Truemoveh Mobile Number Types    silver
    ${lucky_max_allow_day_old}=    Supernumber - Get Data Truemoveh Mobile Number Types    lucky

    ${unique_id}=      SuperNumber - Prepare Data Get Import Lot
    ${unique_id_2}=    SuperNumber - Prepare Data Get Import Lot
    ${zone_id}=        Set Variable    1
    ${zone_id_2}=      Set Variable    1

    ${inventory_id}=    Run Keyword If    '${ENV}' == 'staging'    Set Variable    THOOR1111211
    ...    ELSE    Set Variable    APAAE1116211


    User Login From login page   ${user_itm}   ${pass_itm}
    Clear Cart Current User
    remove_mobile_by_number    ${mobile_number}

    ${redirect_url_response}    ${proposition_id}    ${price_plan_id}=    Supernumber - Prepare cart and return redirect redirect_url    ${unique_id}    ${mobile_number}    ${sub_description_1}    ${description_1}    ${recommend_y}
    Go To    ${redirect_url_response}
    Maximize Browser Window
    Supernumber - Verify Field on Register Page    ${mobile_number}    ${sub_description_1}

    ${national_id_fix}=    Supernumber - Input Random ID card

    Sleep   3
    Supernumber - Input Information on Register Page    sim_model=${inventory_id}    national_id=${national_id_fix}
    Supernumber - Set Shipping Address to be the same as Customer Address
    Supernumber - Accept Policy
    Supernumber - Submit Register Page

    Supernumber - Confirm Register
    ${order_id}=    Supernumber - Submit Order
    ${mobile_id}=     SuperNumber - Get Mobile Id By Mobile Number     ${mobile_number}

    Log To Console    order_id=${order_id}
    Log To Console    inventory_id=${inventory_id}
    Log To Console    mobile_id=${mobile_id}
    Log To Console    mobile=${mobile_number}
    Log To Console    price_plan_id=${price_plan_id}
    Log To Console    import_lot=${unique_id}
    Log To Console    zone_id=${zone_id}
    Log To Console    proposition_id=${proposition_id}

    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    1    seer_nitikit
    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    0    gold
    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    0    silver
    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    0    lucky

####2

    User Login From login page   ${user_itm}   ${pass_itm}
    Clear Cart Current User
    remove_mobile_by_number    ${mobile_number_2}

    ${redirect_url_response_2}    ${proposition_id_2}    ${price_plan_id_2}=    Supernumber - Prepare cart and return redirect redirect_url    ${unique_id_2}    ${mobile_number_2}    ${sub_description_2}    ${description_2}    ${recommend_y}
    Go To    ${redirect_url_response_2}
    Maximize Browser Window
    Supernumber - Verify Field on Register Page    ${mobile_number_2}    ${sub_description_2}
    Sleep   3
    Supernumber - Input Information on Register Page    sim_model=${inventory_id}    national_id=${national_id_fix}
    Supernumber - Set Shipping Address to be the same as Customer Address
    Supernumber - Accept Policy
    Supernumber - Submit Register Page
    Supernumber - Verify Message Error Max Allow From Tcc    [00001] ขออภัย คุณได้มีการจดทะเบียนผ่านช่องทาง iTrueMart ไปแล้ว คุณสามารถจดทะเบียนผ่านช่องทาง iTrueMart ได้อีกหลังจากครบ 90 วัน นับจากวันจดทะเบียนก่อนหน้านี้
    Supernumber - Click Button Close Error Message

    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    0    seer_nitikit

    Supernumber - Submit Register Page
    Supernumber - Confirm Register
    ${order_id_2}=    Supernumber - Submit Order
    ${mobile_id_2}=     SuperNumber - Get Mobile Id By Mobile Number     ${mobile_number_2}

    Log To Console    order_id=${order_id_2}
    Log To Console    inventory_id=${inventory_id}
    Log To Console    mobile_id=${mobile_id_2}
    Log To Console    mobile=${mobile_number_2}
    Log To Console    price_plan_id=${price_plan_id_2}
    Log To Console    import_lot=${unique_id_2}
    Log To Console    zone_id=${zone_id_2}
    Log To Console    proposition_id=${proposition_id_2}

    [Teardown]    Run Keywords    Clear Proposition and Price Plan and Mobile number    ${unique_id}
        ...    AND    Clear Proposition and Price Plan and Mobile number    ${unique_id_2}
        ...    AND    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    ${seer_nitikit_max_allow_day_old}    seer_nitikit
        ...    AND    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    ${gold_allow_day_old}    gold
        ...    AND    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    ${silver_max_allow_day_old}    silver
        ...    AND    Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types    ${lucky_max_allow_day_old}    lucky


To verify that API can create cart mobile number successful.
    [Tags]    test

    remove_mobile_by_number    ${mobile_number}
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot
    ${inventory_id}=    Run Keyword If    '${ENV}' == 'staging'    Set Variable    THOOR1111211
    ...    ELSE    Set Variable    APAAE1116211
    ${zone_id}=    Set Variable    1

    ${redirect_url_response}    ${proposition_id}    ${price_plan_id}=    Supernumber - Prepare cart and return redirect redirect_url    ${unique_id}    ${mobile_number}    ${sub_description_1}    ${description_1}    ${recommend_y}
    Log To Console    redirect_url_response=${redirect_url_response}
    # Open Browser    ${redirect_url_response}    chrome
    # Maximize Browser Window
    # Supernumber - Verify Field on Register Page    ${mobile_number}    ${sub_description_1}

    # Sleep   3
    # Supernumber - Input Information on Register Page    sim_model=${inventory_id}
    # Supernumber - Set Shipping Address to be the same as Customer Address
    #[Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

