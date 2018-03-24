*** Settings ***
Force Tags        WLS_API_PCMS
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTruemart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mini cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_shop.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/keyword_order.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/keyword_holiday.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Thankyou/keywords_thankyou.robot
Library           Collections
Library           Selenium2Library
Library           ${CURDIR}/../../../Python_Library/truemoveh_library.py
Library           ${CURDIR}/../../../Python_Library/mnp_util.py
Library           ${CURDIR}/../../../Python_Library/shop_library.py
Library           ${CURDIR}/../../../Python_Library/policy_library.py

*** Test Cases ***
TC_iTM_02206 API thank you return expected_delivery_min / expected_delivery_max and delivery text (TH/EN) when set min < max
    [Tags]    TC_iTM_02206    ready    ITMA-2852    regression    WLS_High
    Given Set Test Variable    ${expect.delivery_min_day}    "11 มิ.ย. 69"
    And Set Test Variable    ${expect.delivery_max_day}    "17 มิ.ย. 69"
    And Set Test Variable    ${expect.delivery_text}    "หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย"
    And Prepare Order
    And Prepare Product Delivery Day    3    7
    And Create Holiday    2026-06-08
    When Call Thankyou API
    Then Expect Delivery Day
    And Expect Delivery Text
    [Teardown]    Run Keywords    Restore Shop Delivery Day
    ...    AND    Remove Order
    ...    AND    Remove Holiday

TC_iTM_02207 API thank you return delivery date if set for merchant min = max
	[Tags]  TC_iTM_02207  ready  ITMA-2852  regression    WLS_Medium

	Given Set Test Variable    ${expect.delivery_min_day}    "11 มิ.ย. 69"
	  And Set Test Variable    ${expect.delivery_max_day}    "11 มิ.ย. 69"
	  And Set Test Variable    ${expect.delivery_text}       "หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย"
	  And Prepare order
	  And Prepare product delivery day    3    3
	  And Create Holiday    2026-06-08
	 When Call Thankyou API
	 Then Expect Delivery Day
	  And Expect Delivery Text
	[Teardown]    Run Keywords    Restore Shop Delivery Day
	...    AND    Remove Order
	...    AND    Remove Holiday
