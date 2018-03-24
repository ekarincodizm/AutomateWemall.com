*** Settings ***
Force Tags    WLS_Thank_you_Page    API_PCMS
Library    Collections
Library    Selenium2Library

Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mini cart/Keywords_MiniCart.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_shop.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot
Resource    ${CURDIR}/../../../Keyword/Database/PCMS/keyword_order.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/ThankYou_Page/WebElement_ThankYouPage.robot


Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Email/keywords_email_sms.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot

Library    ${CURDIR}/../../../Python_Library/truemoveh_library.py
Library    ${CURDIR}/../../../Python_Library/mnp_util.py
Library    ${CURDIR}/../../../Python_Library/shop_library.py
Library    ${CURDIR}/../../../Python_Library/policy_library.py


*** Variables ***
${customer_ref_id}    27145880
${customer_email}     robotautomate01@gmail.com

${customer_type}            user
${payment_method_cod}        7
${order_status_new}         new
${payment_status_waiting}   waiting
${delivery_min}             3
${delivery_max}             7
${customer_pwd}             true1234

*** Test Cases ***
TC_iTM_02212 Display delivery text (TH) from configuration on thank you page

    [Tags]  TC_iTM_02212  ready  itma-s082016   regression

    Given Set Test Variable    ${expect.delivery_text}    ‐ หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย
    And Prepare Order    ${customer_ref_id}    ${customer_email}
    When Thankyou - Open Thankyou Page And Get Delivery Text   th   ${customer_email}  ${customer_pwd}
    Then Expect Delivery Text
    [Teardown]    Run Keywords    Delete Prepared Order
     ...    AND    Close Browser

TC_iTM_02213 Display delivery text (EN) from configuration on thank you page
    [Tags]  TC_iTM_02213  ready  itma-s082016   regression


    Given Set Test Variable    ${expect.delivery_text}    ‐ If you order more than 1 item, estimate delivery time will up to the item which has the longest delivery time or it will ship separately by supplier or Thai post.
    And Prepare Order    ${customer_ref_id}    ${customer_email}    8    draft    waiting    en
    When Thankyou - Open Thankyou Page And Get Delivery Text    en  ${customer_email}  ${customer_pwd}
    Then Expect Delivery Text
    [Teardown]    Run Keywords    Delete Prepared Order
    ...    AND    Close Browser

TC_iTM_05228 Display delivery text on thank you page for 2 items with different policy
    [Tags]   TC_iTM_05228   ready   regression
    Given Prepare Two Shops Version 2
    AND Prepare Two Variants
    AND Prepare Order Which Has Two Items With Different Shop Id   ${customer_ref_id}   ${customer_email}
    When Thankyou - Open Thankyou Page And Get Delivery Text   th  ${customer_email}  ${customer_pwd}
    Then Expect Delivery Text Different Merchant And SKU
    [Teardown]    Run Keywords    Delete 2 Shops
                  ...    AND      Delete 2 Shop Policies
                  ...    AND      Email Sms - Assign Backup Shop Id Back To Variant
                  ...    AND      Remove Order
                  ...    AND      Delete Inserted Email-Sms
                  ...    AND      Close Browser

# TC_iTM_Sanity Show Delivery time when buy 2 products - retail and marketplace
#     [Tags]   TC_iTM_Sanity

#     #Get pkey to use it to open levelD
#     Given Insert products by name and collection with marketplace type