*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Library           ${CURDIR}/../../../Python_Library/mnp_util.py
Library           ${CURDIR}/../../../Python_Library/promotion_code.py
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Customer_info/customer_info.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Promotion_code/apply_coupon.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_add_to_cart.robot

*** Test Cases ***
TC_iTM_01329 API returns error when apply same promotion code more than 1 time
    [Tags]    TC1    TC_iTM_01329    promotion_code    API_cart    apply_coupon    ready
    LOGIN PCMS
    Set up Robot Campaign    No
    Go To Robot Campaign
    ${coupon_discount}=    Set Variable    10
    ${code}=    Create Promotion All Cart    TC_iTM_01329    single_code    percent    ${coupon_discount}
    Log to console    code=${code}
    User Open Home page
    Get User ID
    Buy Normal Product And Set Customer Info
    Apply Coupon And Success    ${code}
    ${cart1}=    Get Cart Data With Api    ${TV_user_id}    ${TV_user_type}
    Apply Coupon And Error 4119    ${code}
    ${cart2}=    Get Cart Data With Api    ${TV_user_id}    ${TV_user_type}
    Compare Cart Total And Discount Price Should Be Equal    ${cart1}    ${cart2}

TC_iTM_01330 API returns error when apply different promotion code with bundle condition more than 1 code
    [Tags]    TC2    TC_iTM_01330    promotion_code    API_cart    apply_coupon    ready    QCT
    #Log to console    context_root=${context_root}
    User Open Home page
    Get User ID
    Buy Bundle Product And Set Customer Info
    LOGIN PCMS
    Set up Robot Campaign    No
    Go To Robot Campaign
    ${coupon_discount}=    Set Variable    10
    ${code1}=    Create Promotion By Bundle    ${var_tmh_product_device_inventory_id}    TC_iTM_01330 No.1    single_code    percent    ${coupon_discount}
    Apply Coupon And Success    ${code1}
    ${cart1}=    Get Cart Data With Api    ${TV_user_id}    ${TV_user_type}
    LOGIN PCMS
    Set up Robot Campaign    No    No
    Go To Robot Campaign
    ${coupon_discount}=    Set Variable    20
    ${code2}=    Create Promotion By Bundle    ${var_tmh_product_device_inventory_id}    TC_iTM_01330 No.2    single_code    percent    ${coupon_discount}
    Apply Coupon And Error 4119    ${code2}
    ${cart2}=    Get Cart Data With Api    ${TV_user_id}    ${TV_user_type}
    Compare Cart Total And Discount Price Should Be Equal    ${cart1}    ${cart2}
