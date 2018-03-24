*** Settings ***
Library    Selenium2Library
Library    OperatingSystem
Library    HttpLibrary.HTTP
Library    DateTime
Library    Collections

Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource    ${CURDIR}/../../../Keyword/Database/PCMS/keyword_order.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_shop.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Email/keywords_email_sms.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot

*** Variables ***
${customer_ref_id}          27148753
${customer_email}           robotautomate02@gmail.com
${customer_type}            user
${payment_method_cod}        7
${order_status_new}         new
${payment_status_waiting}   waiting
${lang_th}                  th
${lang_en}                  en
${delivery_min}             2
${delivery_max}             7


*** Testcase ***
TC_iTM_02250 Can received email/sms with delivery date if create order success CCW 1 item (TH)
    [Tags]  TC_iTM_02250    tc1    ready    ITMA-2857     regression
    Given Set Expect Variable TH
      And Prepare Order   ${customer_ref_id}   ${customer_email}
      And Prepare Product Delivery Day
        ...    ${delivery_min}
        ...    ${delivery_max}
    When Call Payment Detail API
        ...    ${var.order_id}
        ...   ${customer_ref_id}
        ...    ${customer_type}
    Then Expect Email Step1 With Delivery Time And Text
        ...    ${var.order_id}
        ...    ${customer_email}
        ...    ${expect.delivery_min_day}
        ...    ${expect.delivery_max_day}
        ...    ${expect.delivery_text}
      And Expect Sms Delivery Time
        ...    ${var.order_id}
        ...    ${delivery_min}
        ...    ${delivery_max}
    [Teardown]    Run Keywords    Remove Order
    ...    AND    Remove Order
    ...    AND    Delete Log Email And Sms From Table Message By Order Id    ${var.order_id}



TC_iTM_02251 Can received email/sms with delivery date if create order success COD 1 item (EN)
    [Tags]   TC_iTM_02251  ready    ITMA-2857     regression
    Given Set Expect Variable EN
      And Prepare Order
        ...    ${customer_ref_id}
        ...   ${customer_email}
        ...    ${payment_method_cod}
        ...    ${order_status_new}
        ...    ${payment_status_waiting}
        ...    ${lang_en}
      And Prepare Product Delivery Day
        ...    ${delivery_min}
        ...    ${delivery_max}
    When Call Payment Detail API
        ...    ${var.order_id}
        ...   ${customer_ref_id}
        ...    ${customer_type}
    Then Expect Email Step1 With Delivery Time And Text
        ...    ${var.order_id}
        ...    ${customer_email}
        ...    ${expect.delivery_min_day}
        ...    ${expect.delivery_max_day}
        ...    ${expect.delivery_text}
      And Expect Sms Delivery Time
        ...    ${var.order_id}
        ...    ${delivery_min}
        ...    ${delivery_max}
    [Teardown]    Run Keywords    Remove Order
    ...    AND    Remove Order
    ...    AND    Delete Log Email And Sms From Table Message By Order Id    ${var.order_id}


TC_iTM_02252 Can received email/sms with delivery date if create order success CCW 2 items (TH)
    [Tags]   TC_iTM_02252   ready    ITMA-2857     regression
    Given Prepare Two Shops Version 3
    AND Prepare Two Variants
    AND Prepare Order Which Has Two Items With Different Shop Id
    When Send Mail And Sms Using Payment Detail API
    Then Expect Email Has Two Item With Delivery Time And Text
    And Expect Sms Delivery Time With Combined Date For Two Items

    [Teardown]    Run Keywords    Delete 2 Shops
                  ...    AND      Delete 2 Shop Policies
                  ...    AND      Email Sms - Assign Backup Shop Id Back To Variant
                  ...    AND      Remove Order
                  ...    AND      Delete Inserted Email-Sms
