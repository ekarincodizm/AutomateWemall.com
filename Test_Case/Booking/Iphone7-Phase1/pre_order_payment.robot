*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     DateTime
Library     String
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/keywords_booking_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/keywords_booking_library.robot
Resource          ${CURDIR}/../../../Resource/TestData/Booking/booking-iphone7_test_data.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Terms and Conditions/keywords_terms_and_conditions.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Terms and Conditions/WebElement_terms_and_conditions.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Pre-Order/keywords_pre_order.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Pre-Order/WebElement_PreOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Confirm-Pre-Order/keywords_confirm_pre_order.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Confirm-Pre-Order/WebElement_ConfirmPreOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Payment/keywords_payment.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/Payment/WebElement_Payment.robot
Library           ${CURDIR}/../../../Python_Library/Booking.py

*** Variable ***
${lang_th}    th
${lang_en}    en
${env_web}    web
${env_mobile}    mobile
${address_type_shipping}    shipping
${address_type_billing}    billing

*** Test Cases ***
TEST
    [Tags]    test
#    Booking Terms and Conditions Page - Open Page

TEST Go To Page4 Web TH
    [Tags]    goto-page4-th    for-test
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next

TEST Go To Page4 Web EN
    [Tags]    goto-page4-en    for-test
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next

TEST Go To Page4 Mobile TH
    [Tags]    goto-page4-mobile-th    for-test
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next

TEST Go To Page4 Mobile EN
    [Tags]    goto-page4-mobile-en    for-test
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next

TEST Payment Success Web TH
    [Tags]      payment-success
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers

TEST Payment Success Web EN
    [Tags]      payment-success
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers

TEST Payment Success Mobile TH
    [Tags]      payment-success
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers

TEST Payment Success Mobile EN
    [Tags]      payment-success
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers

TEST Payment Fail Web TH
    [Tags]      payment-fail
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers

TEST Payment Fail Web EN
    [Tags]      payment-fail
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers

TEST Payment Fail Mobile TH
    [Tags]      payment-fail
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers

TEST Payment Fail Mobile EN
    [Tags]      payment-fail
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    [Teardown]    Close All Browsers