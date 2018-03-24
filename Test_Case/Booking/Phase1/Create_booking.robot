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
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/keywords_booking_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/keywords_booking_library.robot
Resource          ${CURDIR}/../../../Resource/TestData/Booking/booking_test_data.robot

Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Landing/keywords_landing.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Landing/WebElement_Landing.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Pre-Order/keywords_pre_order.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Pre-Order/WebElement_PreOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Payment/keywords_payment.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Payment/WebElement_Payment.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/ThankYou Page/Keywords_ThankYouPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/ThankYou Page/WebElement_ThankYouPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Error Page/Keywords_ErrorPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Error Page/WebElement_ErrorPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Booking/Create Booking/Keywords_CreateBooking.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Booking/Keywords_Booking.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Booking/WebElement_Booking.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/web_element_login.robot

Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Booking/keywords_booking.robot
Resource          ${CURDIR}/../../../Keyword/Features/Booking/Payment/Payment_form_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Library           ${CURDIR}/../../../Python_Library/Booking.py

*** Test Cases ***
TEST
    [Tags]  test
    Login Pcms
    Booking - Window Desktop Size
    PCMS Booking - Go To Report Booking Page
    PCMS Booking - Search By Booking Code       bk10151
    PCMS Booking - Report Booking Display Payment Success By Booking ID     10151

    PCMS Booking - Go To Report TMVH Order Booking Page
    PCMS Booking - Search By Booking Code       bk1234
    PCMS Booking - TMVH Order Booking Display No Data

    PCMS Booking - Go To Report TMVH Order Tracking Page
    PCMS Booking - Search By Booking Code       bk1234
    PCMS Booking - TMVH Order Tracking Display No Data

ITM_15 : Create booking order success case
    [Tags]  ITM_15
    Booking - Get Product
    Booking - Adjust Stock Remaining Product          10
    Booking Landing Page - Open Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept

    Booking Pre-Order Page - Display Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next

    Booking Payment Page - Display Page
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display EN Page
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Payment Status as success
    Booking Data - Booking Status as waiting
    Booking Data - Booking Expired as Booking Date Extend 3 Month
	[Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_16 : Create booking order failed case
    [Tags]  ITM_16
    Booking - Get Product
    Booking - Adjust Stock Remaining Product          10
    Booking Landing Page - Open Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept

    Booking Pre-Order Page - Display Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next

    Booking Payment Page - Display Page
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display EN Page
    Booking ThankYou Page - Display ThankYou Fail
    Booking ThankYou Page - Get Booking Code
    Booking Py - Get Booking Data By Booking Code
    Booking Data - Payment Status as failed
    Booking Data - Booking Status as waiting
    Booking Data - Booking Expired as Booking Date Extend 1 Hour
	[Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_17 : Create booking order failed case
    [Tags]  ITM_17
    Booking - Get Product
    Booking - Adjust Stock Remaining Product          10
    Booking Landing Page - Open EN Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept

    Booking Pre-Order Page - Display EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model EN
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next

    Booking Payment Page - Display EN Page
    Booking Payment Page - Enter Invalid CCW Information
    Booking Payment Page - Click Pay
    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

