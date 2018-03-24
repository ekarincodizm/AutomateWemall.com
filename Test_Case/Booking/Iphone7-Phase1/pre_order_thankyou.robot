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
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/ThankYou Page/Keywords_ThankYouPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking_Iphone7/ThankYou Page/WebElement_ThankYouPage.robot
Library           ${CURDIR}/../../../Python_Library/Booking.py

*** Variable ***
${lang_th}    th
${lang_en}    en
${env_web}    web
${env_mobile}    mobile
${address_type_shipping}    shipping
${address_type_billing}    billing
${payment_status_success}    success
${payment_status_failed}    failed
${booking_status}    waiting
${product_type_normal}    normal
${product_type_bundle}    bundle

*** Test Cases ***
TEST Thankyou Handset Only Success Web TH
    [Tags]      thankyou-handset-success
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_normal}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Handset Only Success Web EN
    [Tags]      thankyou-handset-success-en
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_normal}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    [Teardown]    Close All Browsers

TEST Thankyou Handset Only Success Mobile TH
    [Tags]      thankyou-handset-success-mobile
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_normal}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Handset Only Success Mobile EN
    [Tags]      thankyou-handset-success-mobile-en
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_normal}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page EN
    [Teardown]    Close All Browsers

TEST Thankyou Handset Only Fail Web TH
    [Tags]      thankyou-handset-fail
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail     ${product_type_normal}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Handset Only Fail Web EN
    [Tags]      thankyou-handset-fail-en
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail     ${product_type_normal}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page EN
    [Teardown]    Close All Browsers

TEST Thankyou Handset Only Fail Mobile TH
    [Tags]      thankyou-handset-fail-mobile
    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail     ${product_type_normal}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Handset Only Fail Mobile EN
    [Tags]      thankyou-handset-fail-mobile-en
    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail     ${product_type_normal}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page EN
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Success Web TH
    [Tags]      thankyou-bundle-success
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_bundle}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Success Web EN
    [Tags]      thankyou-bundle-success-en
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_bundle}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page EN
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Success Mobile TH
    [Tags]      thankyou-bundle-success-mobile
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_bundle}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Success Mobile EN
    [Tags]      thankyou-bundle-success-mobile-en
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success     ${product_type_bundle}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_success}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page EN
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Only Fail Web TH
    [Tags]      thankyou-bundle-fail
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail        ${product_type_bundle}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Only Fail Web EN
    [Tags]      thankyou-bundle-fail-en
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail        ${product_type_bundle}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page EN
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Only Fail Mobile TH
    [Tags]      thankyou-bundle-fail-mobile
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail        ${product_type_bundle}     ${lang_th}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page TH
    [Teardown]    Close All Browsers

TEST Thankyou Bundle Only Fail Mobile EN
    [Tags]      thankyou-bundle-fail-mobile-en
    Booking Pre-Order Page - Goto Page 3 Bundle    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Fail        ${product_type_bundle}     ${lang_en}
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Check Payment Status     ${payment_status_failed}
    Booking Data - Check Booking Status     ${booking_status}
    Booking ThankYou Page - Verify Label Thank You Page EN
    [Teardown]    Close All Browsers