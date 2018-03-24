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
# Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Payment/keywords_payment.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Payment/WebElement_Payment.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/Booking/ThankYou Page/Keywords_ThankYouPage.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/Booking/ThankYou Page/WebElement_ThankYouPage.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Error Page/Keywords_ErrorPage.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Error Page/WebElement_ErrorPage.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Create Booking/Keywords_CreateBooking.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Booking/Keywords_Booking.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Booking/WebElement_Booking.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/web_element_login.robot

# Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Booking/keywords_booking.robot
# Resource          ${CURDIR}/../../../Keyword/Features/Booking/Payment/Payment_form_keywords.robot
# Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
# Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Library           ${CURDIR}/../../../Python_Library/Booking.py

*** Test Cases ***
TEST
    [Tags]    test
    Booking Terms and Conditions Page - Open Page

TEST Go To Page2
    [Tags]    goto-page2    for-test
    Booking Terms and Conditions Page - Open Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Display All Input

TEST Page2 : Input Information without choosing radio button or clicking submit button
    [Tags]    fill    for-test
    Booking Terms and Conditions Page - Open Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Enter Valid Address

TEST Page2 : [EN] - Input Information without choosing radio button or clicking submit button
    [Tags]    fill-en    for-test
    Booking Terms and Conditions Page - Open EN Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Enter Valid Address

TEST Page2 Mobile : Input Information without choosing radio button or clicking submit button
    [Tags]    fill-m    for-test
    Booking Terms and Conditions Page - Open Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Enter Valid Address

TEST Page2 Mobile : [EN] - Input Information without choosing radio button or clicking submit button
    [Tags]    fill-en-m    for-test
    Booking Terms and Conditions Page - Open EN Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Enter Valid Address

Page2 : Input All Information And Submit
    [Tags]    page2-submit    page2
    Booking Terms and Conditions Page - Open Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button
    [Teardown]    Close All Browsers

Page2 : [EN] - Input All Information And Submit
    [Tags]    page2-submit-en    page2
    Booking Terms and Conditions Page - Open EN Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model EN
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    [Teardown]    Close All Browsers

Page2 : Submit form and verify that validate fields work correctly
    [Tags]    page2-validate    page2    ready
    Booking Terms and Conditions Page - Open Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - Click Billing Checkbox
    Booking Pre-Order Page - Click Button Next
    Booking Pre-Order Page - Verify error fields are appeared
    Booking Pre-Order Page - Verify error billing fields are appeared
    [Teardown]    Close All Browsers

Page2 : [EN] - Submit form and verify that validate fields work correctly
    [Tags]    page2-validate-en    page2    ready
    Booking Terms and Conditions Page - Open EN Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - Click Billing Checkbox
    Booking Pre-Order Page - Click Button Next
    Booking Pre-Order Page - Verify error fields are appeared
    Booking Pre-Order Page - Verify error billing fields are appeared
    [Teardown]    Close All Browsers

Page2 Mobile : Submit form and verify that validate fields work correctly
    [Tags]     page2    ready
    Booking Terms and Conditions Page - Open Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - Click Billing Checkbox
    Booking Pre-Order Page - Click Button Next
    Booking Pre-Order Page - Verify error fields are appeared
    Booking Pre-Order Page - Verify error billing fields are appeared
    [Teardown]    Close All Browsers

Page2 Mobile : [EN] - Submit form and verify that validate fields work correctly
    [Tags]     page2    ready
    Booking Terms and Conditions Page - Open EN Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - Click Billing Checkbox
    Booking Pre-Order Page - Click Button Next
    Booking Pre-Order Page - Verify error fields are appeared
    Booking Pre-Order Page - Verify error billing fields are appeared
    [Teardown]    Close All Browsers




# ITM_15 : Create booking order success case
#     [Tags]  ITM_15

#     Booking Pre-Order Page - Display All Input
#     Booking Pre-Order Page - User Enter Valid Identification Document
#     Booking Pre-Order Page - User Select Product Model
#     Booking Pre-Order Page - User Choose Handset Only
#     Booking Pre-Order Page - User Enter Valid Address
#     Booking Pre-Order Page - Click Button Next

#     Booking Payment Page - Display Page
#     Booking Payment Page - Enter Valid All CCW Information
#     Booking Payment Page - Click Pay
#     Booking ThankYou Page - Display EN Page
#     Booking ThankYou Page - Display ThankYou Success
#     Booking ThankYou Page - Get Booking Code
#     Booking Py - Get Booking Data By Booking Code
#     Booking Data - Payment Status as success
#     Booking Data - Booking Status as waiting
#     Booking Data - Booking Expired as Booking Date Extend 3 Month
# 	[Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

# ITM_16 : Create booking order failed case
#     [Tags]  ITM_16
#     Booking - Get Product
#     Booking - Adjust Stock Remaining Product          10
#     Booking Landing Page - Open Page
#     Maximize Browser Window
#     Booking Landing Page - Click Button Pre-Order
#     Booking Landing Page - Display T&C
#     Booking Landing Page - Click Button Accept

#     Booking Pre-Order Page - Display Page
#     Booking Pre-Order Page - Display All Input
#     Booking Pre-Order Page - User Enter Valid Identification Document
#     Booking Pre-Order Page - User Select Product Model
#     Booking Pre-Order Page - User Choose Bundle
#     Booking Pre-Order Page - User Enter Valid Address
#     Booking Pre-Order Page - Click Button Next

#     Booking Payment Page - Display Page
#     Booking Payment Page - Enter Invalid CCW Information
#     Booking Payment Page - Click Pay
#     Booking ThankYou Page - Display EN Page
#     Booking ThankYou Page - Display ThankYou Fail
#     Booking ThankYou Page - Get Booking Code
#     Booking Py - Get Booking Data By Booking Code
#     Booking Data - Payment Status as failed
#     Booking Data - Booking Status as waiting
#     Booking Data - Booking Expired as Booking Date Extend 1 Hour
# 	[Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

# ITM_17 : Create booking order failed case
#     [Tags]  ITM_17
#     Booking - Get Product
#     Booking - Adjust Stock Remaining Product          10
#     Booking Landing Page - Open EN Page
#     Maximize Browser Window
#     Booking Landing Page - Click Button Pre-Order
#     Booking Landing Page - Display T&C
#     Booking Landing Page - Click Button Accept

#     Booking Pre-Order Page - Display EN Page
#     Booking Pre-Order Page - Display All Input
#     Booking Pre-Order Page - User Enter Valid Identification Document
#     Booking Pre-Order Page - User Select Product Model EN
#     Booking Pre-Order Page - User Choose Handset Only
#     Booking Pre-Order Page - User Enter Valid Address
#     Booking Pre-Order Page - Click Button Next

#     Booking Payment Page - Display EN Page
#     Booking Payment Page - Enter Invalid CCW Information
#     Booking Payment Page - Click Pay
#     [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

