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
#Library           ${CURDIR}/../../../Python_Library/Booking.py
#Library           ${CURDIR}/../../../Python_Library/DatabaseDataBooking.py

*** Variable ***
${lang_th}    th
${lang_en}    en
${env_web}    web
${env_mobile}    mobile
${address_type_shipping}    shipping
${address_type_billing}    billing

*** Test Cases ***
#product-name

TEST Go To Page3 And Verify Display Input Billing Same Shipping
    [Tags]    goto-page3    for-test
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_th}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Same Shipping
#    [Teardown]    Close All Browsers

TEST Go To Page3 [EN] And Verify Display Input Billing Same Shipping
    [Tags]    goto-page3-EN    for-test
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_web}    ${address_type_shipping}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_en}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Same Shipping    ${lang_en}
    [Teardown]    Close All Browsers

TEST Mobile Go To Page3 And Verify Display Input Billing Same Shipping
    [Tags]    mobile-goto-page3    for-test
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_th}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Same Shipping
    [Teardown]    Close All Browsers

TEST Mobile Go To Page3 [EN] And Verify Display Input Billing Same Shipping
    [Tags]    mobile-goto-page3-EN    for-test
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_mobile}    ${address_type_shipping}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_en}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Same Shipping    ${lang_en}
    [Teardown]    Close All Browsers

TEST Go To Page3 And Verify Display Input Billing Not Same Shipping
    [Tags]    goto-page3-    billing    for-test    111
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_web}    ${address_type_billing}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_th}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Not Same Shipping
    [Teardown]    Close All Browsers

TEST Go To Page3 [EN] And Verify Display Input Billing Not Same Shipping
    [Tags]    goto-page3-EN    for-test
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_web}    ${address_type_billing}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_en}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Not Same Shipping    ${lang_en}
    [Teardown]    Close All Browsers

TEST Mobile Go To Page3 And Verify Display Input Billing Not Same Shipping
    [Tags]    mobile-goto-page3    for-test
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_th}    ${env_mobile}    ${address_type_billing}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_th}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Not Same Shipping
    [Teardown]    Close All Browsers

TEST Mobile Go To Page3 [EN] And Verify Display Input Billing Not Same Shipping
    [Tags]    mobile-goto-page3-EN    for-test
    ${product_name}=    Booking Pre-Order Page - Goto Page 3    ${lang_en}    ${env_mobile}    ${address_type_billing}
    Booking Pre-Order Page - Verify Display Cutomer Info    ${lang_en}    ${product_name}
    Booking Pre-Order Page - Verify Display Billing Address Not Same Shipping    ${lang_en}
    [Teardown]    Close All Browsers

#TEST Go To Page3 And Verify Config Data
#    [Tags]    goto-page3-config    for-test
#    Booking Terms and Conditions Page - Open Page
#    Maximize Browser Window
#    Booking Terms and Conditions Page - Choose Radio Accept
#    Booking Terms and Conditions Page - Click Next
#    Booking Pre-Order Page - Verify Page
#    Booking Pre-Order Page - Display All Input
#    Booking Pre-Order Page - User Enter Valid Identification Document
#    Booking Pre-Order Page - User Select Product Model
#    Booking Pre-Order Page - User Choose Handset Only
#    Booking Pre-Order Page - User Enter Valid Address
#    Booking Pre-Order Page - Click Billing Checkbox
#    Booking Pre-Order Page - Display All Billing Input
#    Booking Pre-Order Page - User Enter Valid Billing Address
#    Booking Pre-Order Page - Click Button Next
#    Booking Pre-Order Page - Verify Display Cutomer Info
#    Booking Pre-Order Page - Verify Display Billing Address Not Same Shipping

