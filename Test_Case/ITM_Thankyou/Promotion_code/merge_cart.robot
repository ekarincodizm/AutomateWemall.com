*** Settings ***
Force Tags    WLS_Promotion
Library   Selenium2Library
Library   String
Resource  ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Features/Discount_campaign/crud_everyday_wow.robot
Resource  ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot
#Resource  ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_promotion.robot

Library   ${CURDIR}/../../../Python_Library/promotion.py
Library   ${CURDIR}/../../../Python_Library/product.py
Library   ${CURDIR}/../../../Python_Library/DatabaseData.py
Library   ${CURDIR}/../../../Python_Library/order_promotion_log.py
Library   ${CURDIR}/../../../Python_Library/message_library.py
Library   ${CURDIR}/../../../Python_Library/formatnumber.py
Resource  ${CURDIR}/../../../Keyword/Portal/PCMS/Product/keywords_product.robot
Resource  ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot

Resource   ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTruemart/Level_d_page/keywords_leveld.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mini cart/Keywords_MiniCart.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource   ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource   ${CURDIR}/../../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource   ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot

Resource          ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource          ${CURDIR}/../../..//Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_add_to_cart.robot

Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot

Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie_Promotion/Create_Freebie.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_level_d.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_level_d_web.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Create_Product/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Manage_variant/keywords_manage_variant.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Logout/keywords_logout.robot
Resource          ${CURDIR}/../../../Keyword/Features/User_login/User_login.robot


Suite Setup  Promotion - Create Campaign  ${campaign_name}   No
Suite Teardown  promotion.Remove Campaign   ${campaign_name}   1
Test Teardown   Close All Browsers

*** Variables ***

${login_email}     robotautomate01@gmail.com
${login_password}   true1234
# ${customer_ref_id}   27115272


${campaign_name}  ANTMAN ROBOT CAMPAIGN
${start_normal}    1
${start_3variant}    2
${start_free}     3

&{TC1}     name=Single-Unlimit-All_Cart-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=${EMPTY}    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC2}     name=Single-Unlimit-Brand-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=brand     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=Apple
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC3}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    # ...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC4}     name=Single-All_cart-Price-PC1-Limit
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=100
    ...    dc_maximum=0
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=${EMPTY}     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC5}     name=Unique-Bundle-Price-min-PC1-Unlimited
    ...    type=multiple_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=5
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=${EMPTY}
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC6}     name=Unique-Collection-Percent-Privilege-card-max-price-limit
    ...    type=multiple_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=${EMPTY}
    ...    card=KRUNGSRI411111

&{TC7}     name=VIP-AllCart-Percent_max-price-PC3-Unlimited
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC8}     name=Single-limited-cart-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=${EMPTY}     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC9}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC10}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC11}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=2
    ...    dc_type=price    #  price / percent
    ...    dc_value=50
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=brand     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC12}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC13}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC14}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC15}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111


&{TC16}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC17}     name=VIP-limited-collection-percent
    ...    type=vip_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=30
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}

&{PROMOTION_NAME}   TC_ITMWM_00001=Antman Promotion # 1
 ...   TC_ITMWM_00002=Antman Promotion # 2
 ...   TC_ITMWM_00003=Antman Promotion # 3
 ...   TC_ITMWM_00004=Antman Promotion # 4
 ...   TC_ITMWM_00005=Antman Promotion # 5
 ...   TC_ITMWM_00006=Antman Promotion # 6
 ...   TC_ITMWM_00007=Antman Promotion # 7
 ...   TC_ITMWM_00008=Antman Promotion # 8
 ...   TC_ITMWM_00009=Antman Promotion # 9
 ...   TC_ITMWM_00010=Antman Promotion # 10
 ...   TC_ITMWM_00011=Antman Promotion # 11
 ...   TC_ITMWM_00012=Antman Promotion # 12
 ...   TC_ITMWM_00013=Antman Promotion # 13
 ...   TC_ITMWM_00014=Antman Promotion # 14
 ...   TC_ITMWM_00015=Antman Promotion # 15
 ...   TC_ITMWM_00016=Antman Promotion # 16
 ...   TC_ITMWM_00017=Antman Promotion # 17

&{user}   email=robot.mergecart@gmail.com
 ...      password=true1234

*** Keywords ***
Create campaign - everyday wow 1 bath with product list
    [Arguments]  ${product_name_list}   ${discount_value_percent}=90
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    everyday wow 1 bath
    ${discount_value}=    Set Variable    ${discount_value_percent}
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day

    ${tc_name}=   Set Variable    RobotMergeCart
    ${code}=      Set Variable    ${tc_name}
    ${name}=      Set Variable    ${tc_name}
    ${desc}=      Set Variable    ${tc_name}

    ${camp_name}=    Set Variable    ${tc_name}
    Create campaign - everyday wow 1 bath      ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ${camp_id}=      Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Wow Campaign    ${product_name_list}

    Wemall Common - Assign Value To Test Variable   wow_campaign_name   ${camp_name}
    Wemall Common - Assign Value To Test Variable   wow_campaign_id     ${camp_id}

Create campaign - everyday wow with product list
    [Arguments]  ${product_name_list}   ${discount_value_percent}=90
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    everyday wow 1 bath
    ${discount_value}=    Set Variable    ${discount_value_percent}
    ${discount_type}=     Set Variable    percent
    ${pre_start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${start_period}=      Get Date From Today As PCMS Format

    ${tc_name}=   Set Variable    RobotMergeCart
    ${code}=      Set Variable    ${tc_name}
    ${name}=      Set Variable    ${tc_name}
    ${desc}=      Set Variable    ${tc_name}

    ${camp_name}=    Set Variable    ${tc_name}
    Create campaign - everyday wow      ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${pre_start_period}    ${end_period}
    ${camp_id}=      Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Wow Campaign    ${product_name_list}
    Edit campaign - period  ${camp_name}  ${start_period}  ${end_period}

    Wemall Common - Assign Value To Test Variable   wow_campaign_name   ${camp_name}
    Wemall Common - Assign Value To Test Variable   wow_campaign_id     ${camp_id}

Create campaign - everyday wow with inventory id
    [Arguments]  ${inv_id}   ${discount_value_percent}=90
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    everyday wow 1 bath
    ${discount_value}=    Set Variable    ${discount_value_percent}
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day

    ${tc_name}=   Set Variable    RobotMergeCart
    ${code}=      Set Variable    ${tc_name}
    ${name}=      Set Variable    ${tc_name}
    ${desc}=      Set Variable    ${tc_name}

    ${camp_name}=    Set Variable    ${tc_name}
    Create campaign - everyday wow      ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ${camp_id}=      Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Variant to Wow Campaign by Inventory ID    ${inv_id}

    Wemall Common - Assign Value To Test Variable   wow_campaign_name   ${camp_name}
    Wemall Common - Assign Value To Test Variable   wow_campaign_id     ${camp_id}

User Enter Valid Data As Member For Suite Test Case On Checkout1
    Display Checkout Step1 Page
    User Select Buy As Member
    Display Form Login At Checkout1
    Checkout1 - Input Email   ${user.email}
    Checkout1 - Input Password   ${user.password}
    User Click Next Button On Checkout1

Merge Cart Prepare Freebie
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    1    1
    Set Remaining Level D Main Product    5
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Open Level D Main Product

Temp Prepare Bundle
    Prepare TruemoveH Product Bundle On PCMS
    ${token-data}=    AAD Login And Get Token
    Wemall Common - Assign Value To Test Variable   ADD-token-data   ${token-data}
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    ${camp_response}=    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}    ${var_tmh_device_sub_inventory_id}    ${campaign_id}    30    50
    Prepare TruemoveH Product Bundle On CAMP
    Adjust Stock Remaining By Inventory ID    ${var_tmh_product_device_inventory_id}    100
    ${tmh_product_device_name}=   get_product_name_by_pkey   ${var_tmh_product_device_pkey}
    Set Test Variable  ${var_tmh_product_device_name}  ${tmh_product_device_name}

    ${product_bundle}=   Create Dictionary
    ...  campaign_id=${campaign_id}
    ...  tmh_product_device_id=${var_tmh_product_device_product_id}
    ...  tmh_product_device_name=${tmh_product_device_name}
    ...  tmh_product_device_pkey=${var_tmh_product_device_pkey}
    ...  tmh_product_device_variant_id=${var_tmh_product_device_variant_id}
    ...  tmh_product_device_inventory_id=${var_tmh_product_device_inventory_id}
    ...  tmh_product_device_sub_inventory_id=${var_tmh_device_sub_inventory_id}
    Wemall Common - Assign Value To Test Variable   productBundle   ${product_bundle}

    # Freebie Add To Cart - Add Product Bundle To Cart
    # # ...    AND    Delete Campaign On Camp    ${token-data}    ${campaign_id}
    # # ...    AND    Delete TruemoveH Product Bundle On PCMS

*** Test Cases ***
TC_ITMWM_00001 Not calculate promotion code (Normal, Normal)
 	[Tags]  TC_ITMWM_00001  ITM-A-Sprint 2016S14  2_products  inactive_product  code_expired  merge_cart   promotion_code    regression    ready    WLS_High

	Given Login PCMS
    and Go To Robot Campaign    ${campaign_name}
    and Promotion - Prepare Promotion Code To Test Variable    &{TC1}
   	and DB Product - Prepare 2 Sku Normal Same Collection Diff Product To Test Variable
    and DB Product - Prepare Inv Id 1 To Test Variable Inv Id
    and Wemall Common - Go To iTruemart Home Page
    and Login User to WeMall   ${login_email}  ${login_password}
    ${customer_ref_id} =  Get ACL    3
    ${customer_ref_id}=   Remove String   ${customer_ref_id}   "
    and Clear Cart   ${customer_ref_id}

    and Go To Level D By Pkey   ${TEST_VAR.product_pkey_1}
    and Level D - User Select Style Options   ${TEST_VAR.inv_id_1}
    and Level D - Get Level D Sale Price
    ${product_price1}=   Set Variable  ${TEST_VAR.level_d_price}
    and Level D - User Click Add To Cart Button
    and Display Full Cart
    and User Click Next Process On Full Cart
    #and Stock - Increase Stock By Inventory Id   ${TEST_VAR.inv_id}

    Log To Console   customer_ref_id_product_1=${customer_ref_id}
    #and API Add Cart  ${PCMS_API_URL}  /api/v2/45311375168544/cart/add-item   ${customer_ref_id}   user   ${TEST_VAR.inv_id}  1
    #and Display Full Cart
    #and User Click Next Process On Full Cart

    Log To Console  product-price-1=${product_price1}

    and Go To Checkout 2
    and Display Checkout Step2 Page

    and User Click First Member Address
    and Checkout3 - Display Checkout Step3 Page
    and Checkout3 - Apply Coupon   ${TEST_VAR.code}

    and Wemall Common - Go To Wemall Home Page
    and Wemall Common - Logout
    and DB Product - Prepare Inv Id 2 To Test Variable Inv Id
    and Go To Level D By Pkey   ${TEST_VAR.product_pkey_2}
    and Level D - User Select Style Options   ${TEST_VAR.inv_id_2}
    and Level D - Get Level D Sale Price
    ${product_price2}=   Set Variable  ${TEST_VAR.level_d_price}
    and Level D - User Click Add To Cart Button
    and Display Full Cart
    and User Click Next Process On Full Cart

    Log To console  TEST_VAR.level_d_price=${TEST_VAR.level_d_price}

    and Set Promotion Expire   &{TC1}[name]
    and Product - Set Inactive Product By Product name   ${TEST_VAR.product_name_1}
    and Checkout1 - Go To Checkout1

    Log To Console  ${TEST_VAR}

    ${total_price}=   Evaluate   ${product_price1} + ${product_price2}
    Log To Console   total_price=${total_price}

    When User Enter Valid Data As Member On Checkout1  ${login_email}  ${login_password}
    Then Display Checkout Step2 Page
    and Not Display Coupon On Mini Cart
    and Display Product Name Of First Product On Mini Cart As   ${TEST_VAR.product_name_2}
    and Mini Cart - Expect Sub Total Price As  ${product_price2}
    and Mini Cart - Expect Total Items    1
    #and Mini Cart - Expect Product Is Displayed    ${TEST_VAR.product_name_2}
    #and Mini Cart - Expect Product Is Not Displayed   ${TEST_VAR.product_name_1}

    When User Enter Valid Data As Member On Checkout2
    Then Checkout 3 - Display Checkout Step3 Page
    and Not Display Coupon On Mini Cart
    and Mini Cart - Expect Sub Total Price As  ${product_price2}
    and Display Product Name Of First Product On Mini Cart As   ${TEST_VAR.product_name_2}
    and Mini Cart - Expect Total Items    1

    #and Mini Cart - Expect Product Is Displayed    ${TEST_VAR.product_name_2}
    #and Mini Cart - Expect Product Is Not Displayed   ${TEST_VAR.product_name_1}

    When Checkout 3 - User Enter Valid Data Master Card As Member
    and Display Thankyou Page
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    Then Display Summary Discount Price On Thankyou As Zero

    and Thankyou Page - Expect Product Is Not Displayed   ${TEST_VAR.product_name_1}
    and Thankyou Page - Expect Product Is Displayed   ${TEST_VAR.product_name_2}
    and Thankyou Page - Expect Sub Total Price   ${product_price2}
    ${format_price}=     Formatnumber     ${product_price2}
    and Thankyou Page - Check DB Send Email     ${order_id}    ${login_email}    ${format_price}
    and Thankyou Page - Check Order Promotiom Log    ${order_id}

	[Teardown]   Run keywords    Product - Set Active Product By Product Name    ${TEST_VAR.product_name_1}
    ...    AND    Close All Browsers

# TC_ITMWM_00002 Not calculate promotion code (Wow1Baht, Freebie)
# 	[Tags]  TC_ITMWM_00002  ITM-A-Sprint 2016S14   Pop

# TC_ITMWM_00003 Not calculate promotion code for product (Wow Extra, MNP1)
# 	[Tags]  TC_ITMWM_00003  ITM-A-Sprint 2016S14   Pop

TC_ITMWM_00004 Not calculate promotion code (Freebie, Normal)
	[Tags]  TC_ITMWM_00004  ITM-A-Sprint 2016S14    regression     ready    WLS_High

    &{productA}=    Prepare 1 Product Normal Not Has Variant
    &{productB}=    Prepare 1 Product Normal Not Has Variant
    &{product_free}=    Prepare 1 Product Normal Not Has Variant
    # ${productA}=    Get From Dictionary    ${product}    0
    # ${productB}=    Get From Dictionary    ${product}    1
    ${invA}=    Get From Dictionary    ${productA}    inventory_id
    ${invB}=    Get From Dictionary    ${productB}    inventory_id
    ${invC}=    Get From Dictionary    ${product_free}    inventory_id
    Log to console   INV_1====${productA.inventory_id}
    Log to console   INV_2====${productB.inventory_id}
    Log to console   INV_3====${product_free.inventory_id}
    ${productB_pkey}=    get_product_pkey    ${invB}
    ${productB_id}=    get_product_id     ${invB}
    ${productB_name}=   get_product_name    ${invB}
    # ${collectionB_id}=   get_collection_id    ${invB}
    Given Adjust Stock By inventory_id    ${invA}
    and Adjust Stock By inventory_id    ${invB}
    and Login PCMS
    # ====== [START] Prepare Freebit
    and Set Inventory Id Product Main With Specific Variant And Freebie 1Variant     ${productA}
    and Get Main Product 1Variant A
    and Set Test Variable     ${var_freebie_main_1VariantB}    ${invC}
    and Get Free Product 1Variant B
    and Check Current Stock Level D Main Product
    and Check Current Stock Level D Free Product
    and Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    and Set Freebie On Camp Level D    1    1
    and Set Remaining Level D Main Product    5
    and Set Remaining Level D Free Product    10
    and Rebuild Stock No Variant
    and Adjust Stock By inventory_id    ${var_freebie_free_level_d_inventory}
    # ====== [END] Prepare Freebit
    ${productA_name}=   get_product_name    ${var_freebie_main_level_d_inventory}
    ${productA_id}=   get_product_id    ${var_freebie_main_level_d_inventory}
    ${productA_pkey}=    get_product_pkey    ${var_freebie_main_level_d_inventory}
    # ${collectionA_id}=   get_collection_id    ${var_freebie_main_level_d_inventory}
    # ${collectionA_name}=   get_collection_name    ${var_freebie_main_level_d_inventory}
    Log to console   ${productA_id}==${productA_name}==${var_freebie_main_level_d_inventory}
    Log to console   ${productB_id}==${productB_name}==${invB}

    and Go To Robot Campaign    ${campaign_name}
    and Promotion - Prepare Promotion Code To Test Variable    &{TC4}
    and Wemall Common - Go To Wemall Home Page
    and Login_with_TrueID    ${login_email}  ${login_password}
    ${customer_ref_id} =  Get ACL    3
    ${customer_ref_id}=   Remove String   ${customer_ref_id}   "
    and Clear Cart   ${customer_ref_id}

    and Go to Level D by Pkey   ${productA_pkey}
    and Level D - Get Level D Sale Price

    Log To console  TEST_VAR.level_d_price=${TEST_VAR.level_d_price}

    ${productA_price}=   Set Variable  ${TEST_VAR.level_d_price}
    # and API Add Cart   ${customer_ref_id}   user   ${var_freebie_main_level_d_inventory}
    When API Add Cart    ${PCMS_API_URL}    ${add-cart}   ${customer_ref_id}   user   ${var_freebie_main_level_d_inventory}    1
    and Go To Checkout 2
    and Display Checkout Step2 Page
    and User Click First Member Address
    and Checkout3 - Display Checkout Step3 Page
    and Mini Cart - Wait Until Point Ajax Loading Is Not Display
    and Checkout3 - Apply Coupon   ${TEST_VAR.code}
    Then Verify if Coupon code apply successful
    When Wemall Common - Go To Wemall Home Page
    and Wemall Common - Logout
    and Set Promotion Expire   &{TC4}[name]
    ${ref} =  Get ACL    2
    ${ref}=   Remove String   ${ref}   "

    and Go to Level D by Pkey   ${productB_pkey}
    and Level D - Get Level D Sale Price
    Log To console  TEST_VAR.level_d_price=${TEST_VAR.level_d_price}
    ${productB_price}=   Set Variable  ${TEST_VAR.level_d_price}

    and API Add Cart    ${PCMS_API_URL}    ${add-cart}   ${ref}   non-user   ${invB}    1
    # API Add Cart    ${PCMS_URL_API}    ${add-cart}    ${ref}    non-user    ${invB}    1
    and Go To    ${ITM_URL}/checkout/step1

    ${total_price}=   Evaluate   ${productA_price} + ${productB_price}
    Log To Console   total_price=${total_price}

    and Checkout1 - Click Have Member Radio Button
    and Checkout1 - Input Email    ${login_email}
    and Checkout1 - Input Password    ${login_password}
    and Checkout1 - Click Next
    and Display Checkout Step2 Page

    Then Not Display Coupon On Mini Cart
    # and Display Product Name Of First Product On Mini Cart As   ${productA_name}
    and Mini Cart - Expect Sub Total Price As  ${total_price}
    and Mini Cart - Expect Total Items    3

    When User Enter Valid Data As Member On Checkout2
    Then Not Display Coupon On Mini Cart
    and Mini Cart - Expect Sub Total Price As  ${total_price}
    and Mini Cart - Expect Total Items    3

    When Checkout 3 - User Enter Valid Data Master Card As Member
    and Display Thankyou Page
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    Then Display Summary Discount Price On Thankyou As Zero
    and Thankyou Page - Expect Sub Total Price   ${total_price}
    and Thankyou Page - Check Order Promotiom Log    ${order_id}
    ${format_price}=     Formatnumber     ${total_price}
    and Thankyou Page - Check DB Send Email     ${order_id}    ${login_email}    ${format_price}

    [teardown]    Run keywords    Remove Promotion     &{TC4}[name]
    ...    AND    Close All Browsers

TC_ITMWM_00005 Not calculate promotion code (Bundle, Wow1baht)
    [Tags]  TC_ITMWM_00005  ITM-A-Sprint 2016S14    ready    regression    WLS_High

    # ===== Prepare Product A
    ${product}=   py_get_product_normal_has_variant    1   ${PRODUCT-MATCH-FREEBIE}
    ${product_pkey}=   Get From Dictionary   ${product}   product_pkey
    ${inventory_id}=   Get From Dictionary   ${product}   inventory_id
    ${variant_id}=   Get From Dictionary   ${product}   variant_id
    ${variant_price}=   Get From Dictionary   ${product}   variant_price
    ${product_name}=   get_product_name_by_pkey   ${product_pkey}
    Adjust Stock Remaining By Inventory ID    ${inventory_id}    100

    ${productA}=   Create Dictionary
    ...   product_pkey=${product_pkey}
    ...   inventory_id=${inventory_id}
    ...   variant_price=${variant_price}
    ...   variant_id=${variant_id}
    ...   product_name=${product_name}
    Wemall Common - Assign Value To Test Variable   productA   ${productA}

    # ===== Prepare Product B
    ${product}=   py_get_product_normal_not_has_variant    1   ${PRODUCT-MATCH-FREEBIE}
    ${product_pkey}=   Get From Dictionary   ${product}   product_pkey
    ${inventory_id}=   Get From Dictionary   ${product}   inventory_id
    ${variant_id}=   Get From Dictionary   ${product}   variant_id
    ${variant_price}=   Get From Dictionary   ${product}   variant_price
    ${product_name}=   get_product_name_by_pkey   ${product_pkey}
    Adjust Stock Remaining By Inventory ID    ${inventory_id}    100

    # [Tags]  TC_ITMWM_00005  ITM-A-Sprint 2016S14


    # ===== Prepare Product
    Given Prepare 1 Normal Product Has Variant To Test Variable     productA
    And Prepare 1 Normal Product Not Has Variant To Test Variable   productB

    # ===== Set A to Everyday wow
    ${product_name_list}=   Create List   ${TEST_VAR.productA.product_name}
    And Login PCMS
    And Create campaign - everyday wow with inventory id   ${TEST_VAR.productA.inventory_id}

    # ===== Prepare Code
    And Go To Robot Campaign    ${campaign_name}
    And Set To Dictionary   ${TC5}   dc_on_follow_value=${TEST_VAR.productA.product_name}
    And Promotion - Prepare Promotion Code To Test Variable    &{TC5}

    # ===== Clear User Cart
    And Clear Cart Member By Login Then Logout    ${user.email}   ${user.password}

    # ===== Buy A, Login, Apply coupon, Logout
    When User Open Home page
    And Get User ID
    And API Add Cart   ${PCMS_API_URL}    ${add-cart}   ${TV_user_id}    ${TV_user_type}    ${TEST_VAR.productA.inventory_id}    1

    And Checkout1 - Go To Checkout1
    And User Enter Valid Data As Member For Suite Test Case On Checkout1
    And User Enter Valid Data As Member On Checkout2
    And Display All CCW Information
    ${coupon_code}=   Wemall Common - Get Value From Test Variable   code
    And Checkout3 - Apply Coupon   ${coupon_code}
    And Verify if Coupon code apply successful
    And Go To Logout

    # ===== Disabled Bundle variant of product A
    And Login Pcms
    And User set specific variant status   ${TEST_VAR.productA.product_name}    ${TEST_VAR.productA.variant_id}    disable

    # ===== Buy B, Login
    And User Open Home page
    And Get User ID
    And API Add Cart   ${PCMS_API_URL}    ${add-cart}   ${TV_user_id}    ${TV_user_type}    ${TEST_VAR.productB.inventory_id}    1

    ## Checkout1
    And Checkout1 - Go To Checkout1
    And User Enter Valid Data As Member For Suite Test Case On Checkout1

    ## Checkout2
    And Display Existing Address
    And Not Display Coupon On Mini Cart

    # ==>> Expect
    Then Display Product Name Of First Product On Mini Cart As   ${TEST_VAR.productB.product_name}
    And Mini Cart - Expect Sub Total Price As  ${TEST_VAR.productB.variant_price}
    And Mini Cart - Expect Total Items    1

    When User Enter Valid Data As Member On Checkout2

    ## Checkout3
    And Display All CCW Information

    # ==>> Expect
    Then Not Display Coupon On Mini Cart
    And Display Product Name Of First Product On Mini Cart As   ${TEST_VAR.productB.product_name}
    And Mini Cart - Expect Sub Total Price As  ${TEST_VAR.productB.variant_price}
    And Mini Cart - Expect Total Items    1

    And Checkout 3 - User Enter Valid Data Master Card As Member
    And Display Thankyou Page
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    Then Display Summary Discount Price On Thankyou As Zero
    and Thankyou Page - Expect Sub Total Price   ${TEST_VAR.productB.variant_price}
    and Thankyou Page - Check Order Promotiom Log    ${order_id}
    ${format_price}=     Formatnumber     ${TEST_VAR.productB.variant_price}
    and Thankyou Page - Check DB Send Email     ${order_id}    ${user.email}    ${format_price}

    [Teardown]     Run keywords   Login Pcms
    ...    AND    Remove Promotion     &{TC5}[name]
    ...    AND    User set specific variant status   ${TEST_VAR.productA.product_name}    ${TEST_VAR.productA.variant_id}    active
    ...    AND    Delete campaign - delete by campaign name    ${TEST_VAR.wow_campaign_name}
    ...    AND    Close All Browsers

# TC_ITMWM_00006 Not calculate promotion code (MNP1, Normal)
# 	[Tags]  TC_ITMWM_00006  ITM-A-Sprint 2016S14   Onn

# TC_ITMWM_00007 Not calculate promotion code (MNP2, Wow extra)
# 	[Tags]  TC_ITMWM_00007  ITM-A-Sprint 2016S14    Onn

# TC_ITMWM_00008 Not calculate promotion code (Normal, Freebie)
# 	[Tags]  TC_ITMWM_00008  ITM-A-Sprint 2016S14   mol1
#     # ${customer_ref_id}=    Set Variable    30374831
#     # ${customer_email}=    Set Variable    robot.mergecart@gmail.com
#     # ${customer_pass}=    Set Variable    true1234
#     ${customer_ref_id}=    Set Variable    30378
#     ${customer_email}=    Set Variable    beliefmyheart@gmail.com
#     ${customer_pass}=    Set Variable    1234567

#     keywords_cart.Clear Cart By Customer Email    ${customer_email}
#     Go To Robot Campaign    ${campaign_name}
#     ${code}=    Create Promotion    &{TC8}
#     Log To Console    ======== Promotion Name =========&{TC8}[name]
#     Log To Console    ======== CODE =========${code}

#     # 1.ITM => Add Product A (Normal) to cart
#     Level D - Add Normal Product Not Has Variant To Cart

#     # 2. Buy as guest until checkout 3
#     Go To    http://antman-www.wemall-dev.com/checkout/step1
#     Go To    http://antman-www.wemall-dev.com/checkout/step1
#     Checkout1 - Input Email    ${customer_email}
#     Checkout1 - Wait Loading
#     Checkout1 - Click Next
#     User Enter Valid Data As Guest On Checkout2    ${customer_email}

#     # 3. Apply promo code at checkout 3
#     Checkout3 - Apply Coupon    ${code}

#     # 4. Go to home page
#     # 5. Login
#     Go To    ${ITM_URL}/auth/login
#     # 6. Logout

#     Go To    ${ITM_URL}/auth/logout

#     # 7. PCMS => Campaign => promotion => set expired date< today
#     Set Promotion Expire    &{TC8}[name]

#     # 8. Add Product B (Freebie) to cart
#     Merge Cart Prepare Freebie
#     Level D Click Add To Cart success case
#     Go To    http://antman-www.wemall-dev.com/checkout/step1
#     Go To    http://antman-www.wemall-dev.com/checkout/step1
#     # check total price at mini cart
#     Checkout1 - Click Have Member Radio Button

#     # 9. Login as member at checkout 1 (merge cart)
#     Checkout 1 - User Enter Valid Data on Checkout1    ${customer_email}    ${customer_pass}

#     # 10. Go to chekcout 2
#     Checkout1 - Click Next
#     # Expect :
#     # 10.1 Total price at mini cart = Product A + Product B

#     # 10.2 Coupon code is displayed at mini cart
#     # 10.3 Product A, B is in mini cart checkout 2

#     # 11. Go to checkout 3
#     # Expect :
#     # 11.1 Total price at mini cart = Product A + Product B
#     # 11.2 Coupon code is displayed at mini cart
#     # 11.3 Product A, B is in mini cart checkout 3

#     # 12. Buy success until thank you page
#     # Expect :
#     # 12.1 Total price at thank you page = Product A + Product B
#     # 12.2 Product A, B is in Thank you page.
#     # 12.3 Discount price = 0 at thank you page
#     # 12.4 Total price is in email = Product A + Product B
#     # 12.5 Discount price = 0 in email
#     # 12.6 Product A, B is in Email
#     # 12.7 No data is in 'order_promotion_log' of this order


# TC_ITMWM_00009 No product in cart
# 	[Tags]  TC_ITMWM_00009  ITM-A-Sprint 2016S14   Mol

# TC_ITMWM_00010 Not calculate promotion code multi product (Normal, Normal, Normal)
# 	[Tags]  TC_ITMWM_00010  ITM-A-Sprint 2016S14   Mol

# TC_ITMWM_00011 Not calculate promotion code multi product (Freebie, wow1baht, Normal)
# 	[Tags]  TC_ITMWM_00011  ITM-A-Sprint 2016S14   Korn

#     ${product}=    Prepare 3 Product different brand

#     ${product1}=    Get From Dictionary    ${product}    0
#     ${product2}=    Get From Dictionary    ${product}    1
#     Log to Console    ${product1}

#     ${customer_ref_id}=    Set Variable    30399413
#     ${customer_email}=    Set Variable    dimitri.piet12@gmail.com
#     ${customer_pass}=    Set Variable    true1234

#     # Prepare Freebie
#     Login Pcms
#     Set Inventory Id Product Main With Specific Variant And Freebie 1Variant     ${product1}
#     Get Main Product 1Variant A
#     Get Free Product 1Variant B
#     Check Current Stock Level D Main Product
#     Check Current Stock Level D Free Product
#     Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
#     Set Freebie On Camp Level D    1    1
#     Set Remaining Level D Main Product    5
#     Set Remaining Level D Free Product    10
#     Rebuild Stock No Variant

#     # Prepare Everyday Wow
#     ${product_pkey}=   Get From Dictionary   ${product2}   product_pkey
#     ${product_name}=   get_product_name_by_pkey   ${product_pkey}
#     ${product_name_list}=   Create List   ${product_name}
#     Create campaign - everyday wow 1 bath with product list   ${product_name_list}

#     # Prepare Promotion code
#     Go To Robot Campaign    ${campaign_name}
#     ${brand_name}=    Get From Dictionary    ${product1}    brand_name
#     Set To Dictionary   ${TC11}   dc_on_follow_value=${brand_name}
#     ${promotion_code}=    Create Promotion    &{TC11}

#     # Add to cart Product1
#     ${product1_pkey}=    Get From Dictionary    ${product1}    product_pkey
#     Open Browser ITM-levelD    ${product1_pkey}
#     Level D Click Add To Cart success case

#     # Add to cart Product2
#     ${product2_pkey}=    Get From Dictionary    ${product2}    product_pkey
#     Open Browser ITM-levelD    ${product2_pkey}
#     Level D Click Add To Cart success case


#     Go To    ${ITM_URL}/checkout/step1
#     Checkout 1 - Click Have Member Redio Button
#     Keywords_Checkout1.Checkout1 - Click Have Member Radio Button    ${customer_email}    ${customer_pass}
#     Checkout1 - Click Next

#     Go To    ${ITM_URL}/checkout/step2
#     User Enter Valid Data As Member On Checkout2

#     Go To    ${ITM_URL}/checkout/step3
#     Checkout3 - Apply Coupon   ${promotion_code}

#     Logout Page - Go To Logout Page

#     #set disable product
#     #Update DB product active status    ${products_id}    0



#     [Teardown]    Run keywords    Restore Remaining And Promotion Level D
#     ...    AND    Delete campaign - delete by campaign name    ${TEST_VAR.wow_campaign_name}
#     ...    AND    Close All Browsers

# TC_ITMWM_00012 Not calculate promotion code multi product (MNP1, Wow Extra, Freebie)
# 	[Tags]  TC_ITMWM_00012  ITM-A-Sprint 2016S14   Korn

# TC_ITMWM_00013 Not calculate promotion code multi product (MNP2, Freebie, Normal)
# 	[Tags]  TC_ITMWM_00013  ITM-A-Sprint 2016S14   Korn

# TC_ITMWM_00014 Not calculate promotion code multi product (Bundle, Wow1Baht, Wow1Baht)
# 	[Tags]  TC_ITMWM_00014  ITM-A-Sprint 2016S14   Golf

# TC_ITMWM_00015 Not calculate promotion code multi product (Simple, MNP1, WowExtra)
# 	[Tags]  TC_ITMWM_00015  ITM-A-Sprint 2016S14    Golf

# TC_ITMWM_00016 Not calculate promotion code multi product (Wow Extra, MNP2, Simple)
# 	[Tags]  TC_ITMWM_00016  ITM-A-Sprint 2016S14

# TC_ITMWM_00017 Not calculate promotion code multi product (Freebie, Simple, Bundle)
#     [Tags]  TC_ITMWM_00017  ITM-A-Sprint 2016S14   Golf
#     # ${product}=    Prepare 3 Product different brand
#     # ${productB}=    Get From Dictionary    ${product}    0
#     # ${inv_id}=    Get From Dictionary     ${productB}    inventory_id
#     # ${product_pkey}=    Get From Dictionary     ${productB}    product_pkey
#     # ${product_id}=    Get From Dictionary     ${productB}    product_id
#     # ${product_name}=   get_product_name    ${inv_id}
#     # ${collection_id}=   get_collection_id    ${inv_id}

#     # Log to console   ${product_id}==${product_name}==${collection_id}
#     # Login PCMS
#     # # ====== [START] Prepare Freebit
#     # Set Inventory Id Product Main With Specific Variant And Freebie 1Variant     ${product1}
#     # Get Main Product 1Variant A
#     # Get Free Product 1Variant B
#     # Check Current Stock Level D Main Product
#     # Check Current Stock Level D Free Product
#     # Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
#     # Set Freebie On Camp Level D    1    1
#     # Set Remaining Level D Main Product    5
#     # Set Remaining Level D Free Product    10
#     # Rebuild Stock No Variant
#     # # Open Level D Main Product
#     # # ====== [END] Prepare Freebit



#     # ${productA_name}=   get_product_name    ${var_freebie_main_level_d_inventory}
#     # ${productA_id}=   get_product_id    ${var_freebie_main_level_d_inventory}
#     #  ${productA_pkey}=    get_product_pkey    ${var_freebie_main_level_d_inventory}
#     # # ${brand_name}=   get_brand_name    ${var_freebie_main_level_d_inventory}
#     # ${collectionA_id}=   get_collection_id    ${var_freebie_main_level_d_inventory}
#     # ${collection_name}=   get_collection_name    ${var_freebie_main_level_d_inventory}
#     # Log to console   ${productA_id}==${productA_name}==${collectionA_id}
#     # Set Product Collection By ID    ${product_id}    ${collectionA_id}

#     # Set To Dictionary    ${TC17}    dc_on_follow_value=${collection_name}

#     # Given Login PCMS
#     # and Go To Robot Campaign    ${campaign_name}
#     # # and DB Product - Prepare 2 Sku Normal Same Collection Diff Product To Test Variable

#     # and DB Product - Prepare Inv Id 1 To Test Variable Inv Id

#     # and Promotion - Prepare Promotion Code To Test Variable    &{TC17}
#     # and Wemall Common - Go To Wemall Home Page
#     # and Login User to WeMall   ${login_email}  ${login_password}
#     # # and Level D - Go To Level D And Choose Style Options And Add To Cart And Adjust Stock    ${var_freebie_main_level_d_inventory}
#     # Go To    ${WEMALL_URL}/products/${productA_name}-${productA_pkey}
#     # Level D - User Click Add To Cart Button
#     # Level D - Back to buy product
#     # Go To    ${WEMALL_URL}/products/${product_name}-${product_pkey}
#     # Level D - User Click Add To Cart Button
#     # # 0 = Disavle    1 = Active
#     # # Update DB product active status    ${products_id}    0
#     # # Set Promotion Expire   &{TC3}[name]
#     # [teardown]    Run Keywords    Remove Promotion     &{TC17}[name]
#     # ...    AND    Set Product Collection By ID    ${product_id}    ${collection_id}
