*** Settings ***
Force Tags    WLS_Level_D
Suite Setup       Level D - Delivery Time Suite Setup

Resource          ${CURDIR}/../../../Resource/init.robot
Suite Teardown    Run Keywords    Close All Browsers
#Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_shop.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_setting_policy.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Create_Product/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Common/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/keywords_common_for_wemall.robot
Library           ${CURDIR}/../../../Python_Library/product.py
Library           ${CURDIR}/../../../Python_Library/policy_library.py
Library           ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Library           String

*** Variables ***
# Shop with policies: HULKSHOP
${shop_code}      HULKSHOP
${shop_name}      HULKSHOP
${sku_id}         HULKS1111127
${delivery_day_min}    2
${delivery_day_max}    10
${delivery_title_th}    นโยบายจัดส่งภายใน ${delivery_day_min}-${delivery_day_max} วันทำการ
${return_title_th}    นโยบายรับเปลี่ยนสินค้า
${refund_title_th}    นโยบายคืนเงิน
${delivery_detail_th}    สินค้าจัดส่งภายใน ${delivery_day_min}-${delivery_day_max} วันทำการ
${return_detail_th}    ร้านค้าส่งสินค้าผิดรุ่น, สี หรือขนาด ให้กับลูกค้า
${refund_detail_th}    ร้านค้าจะทำการคืนเงินให้แก่ลูกค้าในกรณีที่ร้านค้าไม่สามารถหาสินค้า มาเปลี่ยน หรือทดแทนสินค้าเดิมที่ลูกค้าได้สั่งซื้อไป
${delivery_title_en}    Delivery within ${delivery_day_min}-${delivery_day_max} working days
${return_title_en}    Return Policies
${refund_title_en}    Refund Policies
${delivery_detail_en}    Ordered items will be delivered within ${delivery_day_min}-${delivery_day_max} working days
${return_detail_en}    In case of delivering wrong type, color, or size of product to the customer
${refund_detail_en}    You may return most new, unopened items sold and fulfilled by iTruemart.com within 30 days of delivery for a full refund.
${shop_expected_delivery_time_txt_th}    สินค้าจะส่งถึงมือคุณภายใน ${delivery_day_min}-${delivery_day_max} วันทำการ
${shop_expected_delivery_time_txt_en}    Order Processing Time within ${delivery_day_min}-${delivery_day_max} working days.
${shop_expected_one_delivery_time_txt_th}    สินค้าจะส่งถึงมือคุณภายใน ${delivery_day_max} วันทำการ
${shop_expected_one_delivery_time_txt_en}    Order Processing Time within ${delivery_day_max} working days.
# Shop without policies: PUEKSHOP
${empty_shop_code}    PUEKSHOP
${empty_shop_name}    PUEKSHOP
${empty_shop_sku}    PUEKS1111117
# Global Shop:
${global_shop_code}    WEMALLGLOBAL
${global_shop_name}    Wemall Global
${global_delivery_day_min}    1
${global_delivery_day_max}    7
${global_delivery_title_th}    global - นโยบายจัดส่งภายใน ${global_delivery_day_min}-${global_delivery_day_max} วันทำการ
${global_return_title_th}    global - นโยบายรับเปลี่ยนสินค้า
${global_refund_title_th}    global - นโยบายคืนเงิน
${global_delivery_detail_th}    global - สินค้าจัดส่งภายใน ${delivery_day_min}-${delivery_day_max} วันทำการ
${global_return_detail_th}    global - ร้านค้าส่งสินค้าผิดรุ่น, สี หรือขนาด ให้กับลูกค้า
${global_refund_detail_th}    global - ร้านค้าจะทำการคืนเงินให้แก่ลูกค้าในกรณีที่ร้านค้าไม่สามารถหาสินค้า มาเปลี่ยน หรือทดแทนสินค้าเดิมที่ลูกค้าได้สั่งซื้อไป
${global_delivery_title_en}    global - Delivery within ${global_delivery_day_min}-${global_delivery_day_max} working days
${global_return_title_en}    global - Return Policies
${global_refund_title_en}    global - Refund Policies
${global_delivery_detail_en}    global - Ordered items will be delivered within ${global_delivery_day_min}-${global_delivery_day_max} working days
${global_return_detail_en}    global - In case of delivering wrong type, color, or size of product to the customer
${global_refund_detail_en}    global - You may return most new, unopened items sold and fulfilled by iTruemart.com within 30 days of delivery for a full refund.
${global_expected_delivery_time_txt_th}    สินค้าจะส่งถึงมือคุณภายใน ${global_delivery_day_min}-${global_delivery_day_max} วันทำการ
${global_expected_delivery_time_txt_en}    Order Processing Time within ${global_delivery_day_min}-${global_delivery_day_max} working days.
${global_expected_one_delivery_time_txt_th}    สินค้าจะส่งถึงมือคุณภายใน ${global_delivery_day_max} วันทำการ
${global_expected_one_delivery_time_txt_en}    Order Processing Time within ${global_delivery_day_max} working days.
# Policies Title for Mobile
${delivery_title_mobile_th}    นโยบายการจัดส่ง
${return_title_mobile_th}    นโยบายเปลี่ยนสินค้า
${refund_title_mobile_th}    นโยบายการคืนเงิน
${delivery_title_mobile_en}    FREE DELIVERY
${return_title_mobile_en}    RETURNS POLICY
${refund_title_mobile_en}    MONEY BACK

*** Test Cases ***
TC_iTM_02343 - [Web] Display merchant policies, min and max delivery times are different.
    [Tags]    TC_iTM_02343    regression    iTM_level_d    ready    WLS_High
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Click Shop Policy Button By Shop Code    ${shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${delivery_day_min}    ${delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${delivery_title_th}    return_title=${return_title_th}    refund_title=${refund_title_th}    delivery_detail=${delivery_detail_th}    return_detail=${return_detail_th}    refund_detail=${refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${delivery_title_en}    return_title=${return_title_en}    refund_title=${refund_title_en}    delivery_detail=${delivery_detail_en}    return_detail=${return_detail_en}    refund_detail=${refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${sku_id}
    #    Go To Level D
    Level D Go to level D with Product No Cache    ${product_pkey}
    Level D - Delivery Time Should Be    ${shop_expected_delivery_time_txt_th}
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${delivery_title_th}
    Level D - Refund Policy Title Should Be    ${refund_title_th}
    Level D - Return Policy Title Should Be    ${return_title_th}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${delivery_detail_th}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${refund_detail_th}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${return_detail_th}
    #    Switch Language to English
    Switch to EN Language
    Go To Current Page No Cache Version
    Level D - Delivery Time Should Be    ${shop_expected_delivery_time_txt_en}
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${delivery_title_en}
    Level D - Refund Policy Title Should Be    ${refund_title_en}
    Level D - Return Policy Title Should Be    ${return_title_en}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${delivery_detail_en}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${refund_detail_en}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${return_detail_en}
    #    Go To Level D Mobile
    Level D Mobile - Go to Level D Mobile with Product No Cache    ${product_pkey}
    Level D Mobile - Delivery Time Should Be    ${shop_expected_delivery_time_txt_th}
    [Teardown]    Close All Browsers

TC_iTM_02344 - [Web] Display merchant policies, min and max delivery times are the same.
    [Tags]    TC_iTM_02344    regression    iTM_level_d    ready    WLS_High
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Click Shop Policy Button By Shop Code    ${shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${delivery_day_max}    ${delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${delivery_title_th}    return_title=${return_title_th}    refund_title=${refund_title_th}    delivery_detail=${delivery_detail_th}    return_detail=${return_detail_th}    refund_detail=${refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${delivery_title_en}    return_title=${return_title_en}    refund_title=${refund_title_en}    delivery_detail=${delivery_detail_en}    return_detail=${return_detail_en}    refund_detail=${refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${sku_id}
    #    Go To Level D
    Level D Go to level D with Product No Cache    ${product_pkey}
    Level D - Delivery Time Should Be    ${shop_expected_one_delivery_time_txt_th}
    #    Switch Language to English
    Switch to EN Language
    Go To Current Page No Cache Version
    Level D - Delivery Time Should Be    ${shop_expected_one_delivery_time_txt_en}
    [Teardown]    Close All Browsers

TC_iTM_02345 - [Web] Display global merchant policies, but set min and max delivery times are different.
    [Tags]    TC_iTM_02345    regression    iTM_level_d    ready    web    WLS_Medium
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${global_shop_name}
    Click Shop Policy Button By Shop Code    ${global_shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${global_delivery_day_min}    ${global_delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${global_delivery_title_th}    return_title=${global_return_title_th}    refund_title=${global_refund_title_th}    delivery_detail=${global_delivery_detail_th}    return_detail=${global_return_detail_th}    refund_detail=${global_refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${global_delivery_title_en}    return_title=${global_return_title_en}    refund_title=${global_refund_title_en}    delivery_detail=${global_delivery_detail_en}    return_detail=${global_return_detail_en}    refund_detail=${global_refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${empty_shop_sku}
    #    Go To Level D
    Level D Go to level D with Product No Cache    ${product_pkey}
    Level D - Delivery Time Should Be    ${global_expected_delivery_time_txt_th}
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${global_delivery_title_th}
    Level D - Refund Policy Title Should Be    ${global_refund_title_th}
    Level D - Return Policy Title Should Be    ${global_return_title_th}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${global_delivery_detail_th}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${global_refund_detail_th}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${global_return_detail_th}
    #    Switch Language to English
    Switch to EN Language
    Go To Current Page No Cache Version
    Level D - Delivery Time Should Be    ${global_expected_delivery_time_txt_en}
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${global_delivery_title_en}
    Level D - Refund Policy Title Should Be    ${global_refund_title_en}
    Level D - Return Policy Title Should Be    ${global_return_title_en}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${global_delivery_detail_en}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${global_refund_detail_en}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${global_return_detail_en}
    [Teardown]    Close All Browsers

TC_iTM_02346 - [Web] Display global merchant policies, but set min and max delivery times are the same.
    [Tags]    TC_iTM_02346    regression    iTM_level_d    ready    web    WLS_Medium
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${global_shop_name}
    Click Shop Policy Button By Shop Code    ${global_shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${global_delivery_day_max}    ${global_delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${global_delivery_title_th}    return_title=${global_return_title_th}    refund_title=${global_refund_title_th}    delivery_detail=${global_delivery_detail_th}    return_detail=${global_return_detail_th}    refund_detail=${global_refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${global_delivery_title_en}    return_title=${global_return_title_en}    refund_title=${global_refund_title_en}    delivery_detail=${global_delivery_detail_en}    return_detail=${global_return_detail_en}    refund_detail=${global_refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${empty_shop_sku}
    #    Go To Level D
    Level D Go to level D with Product No Cache    ${product_pkey}
    Level D - Delivery Time Should Be    ${global_expected_one_delivery_time_txt_th}
    #    Switch Language to English
    Switch to EN Language
    Go To Current Page No Cache Version
    Level D - Delivery Time Should Be    ${global_expected_one_delivery_time_txt_en}
    [Teardown]    Close All Browsers

TC_iTM_02347 - [Web] Display policies in Thaim when english policies are not set.
    [Tags]    TC_iTM_02347    regression    iTM_level_d    ready    web    WLS_Medium
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Click Shop Policy Button By Shop Code    ${shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${delivery_day_min}    ${delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${delivery_title_th}    return_title=${return_title_th}    refund_title=${refund_title_th}    delivery_detail=${delivery_detail_th}    return_detail=${return_detail_th}    refund_detail=${refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${EMPTY}    return_title=${EMPTY}    refund_title=${EMPTY}    delivery_detail=${EMPTY}    return_detail=${EMPTY}    refund_detail=${EMPTY}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${sku_id}
    #    Go To Level D
    Level D Go to level D with Product No Cache    ${product_pkey}
    Level D - Delivery Time Should Be    ${shop_expected_delivery_time_txt_th}
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${delivery_title_th}
    Level D - Refund Policy Title Should Be    ${refund_title_th}
    Level D - Return Policy Title Should Be    ${return_title_th}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${delivery_detail_th}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${refund_detail_th}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${return_detail_th}
    #    Switch Language to English
    Switch to EN Language
    Go To Current Page No Cache Version
    Level D - Delivery Time Should Be    ${shop_expected_delivery_time_txt_en}
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${delivery_title_th}
    Level D - Refund Policy Title Should Be    ${refund_title_th}
    Level D - Return Policy Title Should Be    ${return_title_th}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${delivery_detail_th}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${refund_detail_th}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${return_detail_th}
    [Teardown]    Close All Browsers

TC_iTM_02348 - [Web] Not show delivery time and policies.
    [Tags]    TC_iTM_02348    regression    iTM_level_d    ready    web    WLS_Medium
    Delete DeliveryTime By Shop Code    ${global_shop_code}
    Delete Detail Of Policy    ${global_shop_code}
    ${product_pkey} =    Get Product Pkey    ${empty_shop_sku}
    #    Go To Level D
    Open Browser ITM-levelD No Cache    ${product_pkey}
    Level D - Page Should Not Contain Delivery Time
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${EMPTY}
    Level D - Refund Policy Title Should Be    ${EMPTY}
    Level D - Return Policy Title Should Be    ${EMPTY}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${EMPTY}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${EMPTY}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${EMPTY}
    #    Switch Language to English
    Switch to EN Language
    Go To Current Page No Cache Version
    Level D - Page Should Not Contain Delivery Time
    #    Verify policy titles
    Level D - Delivery Policy Title Should Be    ${EMPTY}
    Level D - Refund Policy Title Should Be    ${EMPTY}
    Level D - Return Policy Title Should Be    ${EMPTY}
    #    Verify policy details
    Level D - Delivery Policy Detail Should Be    ${EMPTY}
    Level D - Click Refund Policy Tab
    Level D - Refund Policy Detail Should Be    ${EMPTY}
    Level D - Click Return Policy Tab
    Level D - Return Policy Detail Should Be    ${EMPTY}
    [Teardown]    Close All Browsers

TC_iTM_02349 - [Mobile] Display level D on mobile, it should display correct policies title in both Thai and English
    [Tags]    TC_iTM_02349    regression    iTM_level_d    ready    mobile    WLS_Medium
    ${product_pkey} =    Get Product Pkey    ${sku_id}
    #    Go To Level D Mobile
    Open Browser    ${ITM_MOBILE_URL}    ${BROWSER}
    Level D Mobile - Go to Level D Mobile with Product No Cache    ${product_pkey}
    #    Verify policy titles in Thai
    Level D Mobile - Delivery Policy Title Should Be    ${delivery_title_mobile_th}
    Level D Mobile - Refund Policy Title Should Be    ${refund_title_mobile_th}
    Level D Mobile - Return Policy Title Should Be    ${return_title_mobile_th}
    #    Switch to English Version
    # Switch to EN Language on Mobile
    ${ENG_URL}=    Get Location
    ${replace_ENG_URL}=    Replace String    ${ENG_URL}    /products/    /en/products/
    ${replace_ENG_URL}=    Remove String    ${replace_ENG_URL}    ?no-cache=1
    Go to    ${replace_ENG_URL}
    Go To Current Page No Cache Version
    #    Verify policy titles in Thai
    Level D Mobile - Delivery Policy Title Should Be    ${delivery_title_mobile_en}
    Level D Mobile - Refund Policy Title Should Be    ${refund_title_mobile_en}
    Level D Mobile - Return Policy Title Should Be    ${return_title_mobile_en}

TC_iTM_02350 - [Mobile] Display merchant policies, min and max delivery times are different.
    [Tags]    TC_iTM_02350    regression    iTM_level_d    ready    mobile    WLS_High
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Click Shop Policy Button By Shop Code    ${shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${delivery_day_min}    ${delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${delivery_title_th}    return_title=${return_title_th}    refund_title=${refund_title_th}    delivery_detail=${delivery_detail_th}    return_detail=${return_detail_th}    refund_detail=${refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${delivery_title_en}    return_title=${return_title_en}    refund_title=${refund_title_en}    delivery_detail=${delivery_detail_en}    return_detail=${return_detail_en}    refund_detail=${refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${sku_id}
    #    Go To Level D Mobile
    Level D Mobile - Go to Level D Mobile with Product No Cache    ${product_pkey}
    #    Verify Delivery Time
    Level D Mobile - Delivery Time Should Be    ${shop_expected_delivery_time_txt_th}
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${delivery_detail_th}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${refund_detail_th}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${return_detail_th}
    #    Switch Language to English
    # Switch to EN Language on Mobile
    ${ENG_URL}=    Get Location
    ${replace_ENG_URL}=    Replace String    ${ENG_URL}    /products/    /en/products/
    ${replace_ENG_URL}=    Remove String    ${replace_ENG_URL}    ?no-cache=1
    Go to    ${replace_ENG_URL}
    Go To Current Page No Cache Version
    #    Verify Delivery Time
    Level D - Delivery Time Should Be    ${shop_expected_delivery_time_txt_en}
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${delivery_detail_en}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${refund_detail_en}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${return_detail_en}
    [Teardown]    Close All Browsers

TC_iTM_02351 - [Mobile] Display merchant policies, min and max delivery times are the same.
    [Tags]    TC_iTM_02351    regression    iTM_level_d    ready    mobile    WLS_Medium
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Click Shop Policy Button By Shop Code    ${shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${delivery_day_max}    ${delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${delivery_title_th}    return_title=${return_title_th}    refund_title=${refund_title_th}    delivery_detail=${delivery_detail_th}    return_detail=${return_detail_th}    refund_detail=${refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${delivery_title_en}    return_title=${return_title_en}    refund_title=${refund_title_en}    delivery_detail=${delivery_detail_en}    return_detail=${return_detail_en}    refund_detail=${refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${sku_id}
    #    Go To Level D Mobile
    Level D Mobile - Go to Level D Mobile with Product No Cache    ${product_pkey}
    #    Verify Delivery Time
    Level D Mobile - Delivery Time Should Be    ${shop_expected_one_delivery_time_txt_th}
    #    Switch Language to English
    # Switch to EN Language on Mobile
    ${ENG_URL}=    Get Location
    ${replace_ENG_URL}=    Replace String    ${ENG_URL}    /products/    /en/products/
    ${replace_ENG_URL}=    Remove String    ${replace_ENG_URL}    ?no-cache=1
    Go to    ${replace_ENG_URL}
    Go To Current Page No Cache Version
    #    Verify Delivery Time
    Level D Mobile - Delivery Time Should Be    ${shop_expected_one_delivery_time_txt_en}
    [Teardown]    Close All Browsers

TC_iTM_02352 - [Mobile] Display global merchant policies, but set min and max delivery times are different.
    [Tags]    TC_iTM_02352    regression    iTM_level_d    ready    mobile    WLS_Medium
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${global_shop_name}
    Click Shop Policy Button By Shop Code    ${global_shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${global_delivery_day_min}    ${global_delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${global_delivery_title_th}    return_title=${global_return_title_th}    refund_title=${global_refund_title_th}    delivery_detail=${global_delivery_detail_th}    return_detail=${global_return_detail_th}    refund_detail=${global_refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${global_delivery_title_en}    return_title=${global_return_title_en}    refund_title=${global_refund_title_en}    delivery_detail=${global_delivery_detail_en}    return_detail=${global_return_detail_en}    refund_detail=${global_refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${empty_shop_sku}
    #    Go To Level D Mobile
    Level D Mobile - Go to Level D Mobile with Product No Cache    ${product_pkey}
    #    Verify Delivery Time
    Level D Mobile - Delivery Time Should Be    ${global_expected_delivery_time_txt_th}
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${global_delivery_detail_th}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${global_refund_detail_th}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${global_return_detail_th}
    #    Switch Language to English
    # Switch to EN Language on Mobile
    ${ENG_URL}=    Get Location
    ${replace_ENG_URL}=    Replace String    ${ENG_URL}    /products/    /en/products/
    ${replace_ENG_URL}=    Remove String    ${replace_ENG_URL}    ?no-cache=1
    Go to    ${replace_ENG_URL}
    Go To Current Page No Cache Version
    Level D Mobile - Delivery Time Should Be    ${global_expected_delivery_time_txt_en}
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${global_delivery_detail_en}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${global_refund_detail_en}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${global_return_detail_en}
    [Teardown]    Close All Browsers

TC_iTM_02353 - [Mobile] Display global merchant policies, but set min and max delivery times are the same.
    [Tags]    TC_iTM_02353    regression    iTM_level_d    ready    mobile    WLS_Medium
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${global_shop_name}
    Click Shop Policy Button By Shop Code    ${global_shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${global_delivery_day_max}    ${global_delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${global_delivery_title_th}    return_title=${global_return_title_th}    refund_title=${global_refund_title_th}    delivery_detail=${global_delivery_detail_th}    return_detail=${global_return_detail_th}    refund_detail=${global_refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${global_delivery_title_en}    return_title=${global_return_title_en}    refund_title=${global_refund_title_en}    delivery_detail=${global_delivery_detail_en}    return_detail=${global_return_detail_en}    refund_detail=${global_refund_detail_en}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${empty_shop_sku}
    #    Go To Level D Mobile
    Level D Mobile - Go to Level D Mobile with Product No Cache    ${product_pkey}
    Level D Mobile - Delivery Time Should Be    ${global_expected_one_delivery_time_txt_th}
    #    Switch Language to English
    # Switch to EN Language on Mobile
    ${ENG_URL}=    Get Location
    ${replace_ENG_URL}=    Replace String    ${ENG_URL}    /products/    /en/products/
    ${replace_ENG_URL}=    Remove String    ${replace_ENG_URL}    ?no-cache=1
    Go to    ${replace_ENG_URL}
    Go To Current Page No Cache Version
    Level D Mobile - Delivery Time Should Be    ${global_expected_one_delivery_time_txt_en}
    [Teardown]    Close All Browsers

TC_iTM_02354 - [Mobile] Display policies in Thaim when english policies are not set
    [Tags]    TC_iTM_02354    regression    iTM_level_d    ready    mobile    WLS_Medium
    Login Pcms
    Go To Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Click Shop Policy Button By Shop Code    ${shop_code}
    Fill Data In Setting Policy Form: Delivery Time    ${delivery_day_min}    ${delivery_day_max}
    Fill Data In Setting Policy Form: TH Policy    delivery_title=${delivery_title_th}    return_title=${return_title_th}    refund_title=${refund_title_th}    delivery_detail=${delivery_detail_th}    return_detail=${return_detail_th}    refund_detail=${refund_detail_th}
    Fill Data In Setting Policy Form: EN Policy    delivery_title=${EMPTY}    return_title=${EMPTY}    refund_title=${EMPTY}    delivery_detail=${EMPTY}    return_detail=${EMPTY}    refund_detail=${EMPTY}
    Setting Policy - User Click Save Button
    Display Setting Policy Success
    ${product_pkey} =    Get Product Pkey    ${sku_id}
    #    Go To Level D Mobile
    Level D Mobile - Go to Level D Mobile with Product No Cache    ${product_pkey}
    Level D Mobile - Delivery Time Should Be    ${shop_expected_delivery_time_txt_th}
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${delivery_detail_th}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${refund_detail_th}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${return_detail_th}
    #    Switch Language to English
    # Switch to EN Language on Mobile
    ${ENG_URL}=    Get Location
    ${replace_ENG_URL}=    Replace String    ${ENG_URL}    /products/    /en/products/
    ${replace_ENG_URL}=    Remove String    ${replace_ENG_URL}    ?no-cache=1
    Go to    ${replace_ENG_URL}
    Go To Current Page No Cache Version
    Level D Mobile - Delivery Time Should Be    ${shop_expected_delivery_time_txt_en}
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${delivery_detail_th}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${refund_detail_th}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${return_detail_th}
    [Teardown]    Close All Browsers

TC_iTM_02355 - [Mobile] Not show delivery time and policies.
    [Tags]    TC_iTM_02355    regression    iTM_level_d    ready    mobile    WLS_Medium
    Delete DeliveryTime By Shop Code    ${global_shop_code}
    Delete Detail Of Policy    ${global_shop_code}
    ${product_pkey} =    Get Product Pkey    ${empty_shop_sku}
    #    Go To Level D Mobile
    Open Browser ITM-levelD Mobile No Cache    ${product_pkey}
    Level D Mobile - Page Should Not Contain Delivery Time
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${EMPTY}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${EMPTY}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${EMPTY}
    #    Switch Language to English
    # Switch to EN Language on Mobile
    ${ENG_URL}=    Get Location
    ${replace_ENG_URL}=    Replace String    ${ENG_URL}    /products/    /en/products/
    ${replace_ENG_URL}=    Remove String    ${replace_ENG_URL}    ?no-cache=1
    Go to    ${replace_ENG_URL}
    Go To Current Page No Cache Version
    Level D Mobile - Page Should Not Contain Delivery Time
    #    Verify policy details
    Level D Mobile - Delivery Policy Detail Should Be    ${EMPTY}
    Level D Mobile - Click Refund Policy Tab
    Level D Mobile - Refund Policy Detail Should Be    ${EMPTY}
    Level D Mobile - Click Return Policy Tab
    Level D Mobile - Return Policy Detail Should Be    ${EMPTY}
    [Teardown]    Close All Browsers

*** Keywords ***
Level D - Delivery Time Suite Setup
    #    Merchant with Policies Specified
    Ensure Merchant Exists    ${shop_code}    ${shop_name}
    #    Merchant without Policies Specified
    Ensure Merchant Exists    ${empty_shop_code}    ${empty_shop_name}
    #    Sample Product of Merchant with Policies Specified
    Ensure Product Exists Bypassing FMS    ${shop_code}    ${shop_name}    ${sku_id}
    #    Sample Product of Merchant without Policies Specified
    Ensure Product Exists Bypassing FMS    ${empty_shop_code}    ${empty_shop_name}    ${empty_shop_sku}

Ensure Merchant Exists
    [Arguments]    ${merchant_code}    ${merchant_name}
    ${merchant_exist}=    Check Merchant Exists By Merchant Code    ${merchant_code}
    Run Keyword If    not ${merchant_exist}    Create Shop    ${merchant_code}    ${merchant_name}

Ensure Product Exists Bypassing FMS
    [Arguments]    ${shop_code}    ${shop_name}    ${sku_id}
    ${pkey}=    Get Product Pkey    ${sku_id}
    Run Keyword If    ${pkey} == ${NONE}    Run Keywords    Create Product Bypassing FMS Using Template Data    ${shop_code}    ${shop_name}    ${sku_id}
    ...    AND    Log to Console    Done creating product with sku: ${sku_id}
    ...    ELSE    Log To Console    SKU ${sku_id} existed with pkey: ${pkey}

Create Product Bypassing FMS Using Template Data
    [Arguments]    ${shop_code}    ${shop_name}    ${sku_id}
    ${product_data} =    Generate Test Data for Create Product
    Create Product Bypassing FMS    ${product_data}    ${shop_code}    ${shop_name}    ${sku_id}
