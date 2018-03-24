*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     DateTime
Library     String
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
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Booking/keywords_booking.robot
Resource          ${CURDIR}/../../../Keyword/Features/Booking/Payment/Payment_form_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Library           ${CURDIR}/../../../Python_Library/Booking.py

*** Test Cases ***
ITM_15 : Retrieve Customer Information
    [Tags]  ITM_15
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
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Billing Address
    Booking Pre-Order Page - Display All Billing Input
    Booking Pre-Order Page - User Enter Valid Billing Address
    Booking Pre-Order Page - Get All Billing Location Name
    Booking Pre-Order Page - Check All Billing Location Name EN
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display EN Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Billing Data EN
    Booking Payment Page - Display Booking Data EN

	[Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_16 : Get info from Booking form when cookie normally
    [Tags]  ITM_16
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
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Billing Address
    Booking Pre-Order Page - Display All Billing Input
    Booking Pre-Order Page - User Enter Valid Billing Address
    Booking Pre-Order Page - Get All Billing Location Name
    Booking Pre-Order Page - Check All Billing Location Name EN
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display EN Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Billing Data EN
    Booking Payment Page - Display Booking Data EN

	[Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_17 : Get info from Booking form when cookie normally
    [Tags]  ITM_17
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
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Billing Address
    Booking Pre-Order Page - Display All Billing Input
    Booking Pre-Order Page - User Enter Valid Billing Address
    Booking Pre-Order Page - Get All Billing Location Name
    Booking Pre-Order Page - Check All Billing Location Name
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Bundle Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Billing Data
    Booking Payment Page - Display Booking Data
	[Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_18 : Can be booking device
    [Tags]  ITM_18
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
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Billing Address
    Booking Pre-Order Page - Display All Billing Input
    Booking Pre-Order Page - User Enter Valid Billing Address
    Booking Pre-Order Page - Get All Billing Location Name
    Booking Pre-Order Page - Check All Billing Location Name EN
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display EN Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Billing Data EN
    Booking Payment Page - Display Booking Data EN
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
#    Sleep               30s
#    Confirm Action
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Display Image Product
    Booking ThankYou Page - Display Device Data
    Booking ThankYou Page - Display Customer Data
    Booking ThankYou Page - Display Billing Data EN
    Booking ThankYou Page - Display Booking Data EN

#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_19 : Display out-of-service
    [Tags]  ITM_19
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
    Booking Pre-Order Page - Set Invalid Value Input Inventory Id
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    Booking Error Page - Display Something Wrong
    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_20 : Display out-of-service
    [Tags]  ITM_20
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
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Remove Input Inventory Id
    Booking Pre-Order Page - Click Button Next
    Booking Pre-Order Page - Display Page
    Booking Pre-Order Page - Display Error Validate
    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_22 : Get Booking landing page when cookie is time out
    [Tags]  ITM_22
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
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display Page
    Delete All Cookies
    Booking Payment Page - Go To Page
    Booking Landing Page - Display Page
    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

ITM_23 : Get Booking landing page when opening Payment form URL
    [Tags]  ITM_23
    Booking Payment Page - Open Page
    Booking Landing Page - Display Page
    Booking Payment Page - Go To Page
    Booking Landing Page - Display Page

ITM_24 : Error message for payment form required field
    [Tags]  ITM_24
    Booking - Get Product
    Booking - Adjust Stock Remaining Product          99999
    Booking Landing Page - Open Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Pre-Order Page - Display Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display Page
    Booking Payment Page - Click Pay
    Booking Payment Page - Display Error All CCW Information
    Booking Payment Page - User Enter Valid Card Holder Name
    Booking Payment Page - Click Pay
    Booking Payment Page - Not Display Error Card Holder Name
    Booking Payment Page - Display Error Credit Card Number
    Booking Payment Page - Display Error CVC
    Booking Payment Page - Display Error Card Expired Date
    Booking Payment Page - User Enter Valid Credit Card Number
    Booking Payment Page - Click Pay
    Booking Payment Page - Not Display Error Card Holder Name
    Booking Payment Page - Not Display Error Credit Card Number
    Booking Payment Page - Display Error CVC
    Booking Payment Page - Display Error Card Expired Date
    Booking Payment Page - User Enter Valid CVC
    Booking Payment Page - Click Pay
    Booking Payment Page - Not Display Error Card Holder Name
    Booking Payment Page - Not Display Error Credit Card Number
    Booking Payment Page - Not Display Error CVC
    Booking Payment Page - Display Error Card Expired Date
    Booking Payment Page - User Select Valid Card Expired
    Booking Payment Page - Click Pay
#    Sleep               30s
#    Confirm Action
    Booking ThankYou Page - Display ThankYou Success
    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Bundle
    [Tags]  bundle      bk
    Create Booking - Bundle Success
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Handset Only
    [Tags]  handset      bk
    Create Booking - Handset Only Success
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Bundle EN
    [Tags]  bundle_en      bk
    Create Booking - Bundle Success EN
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Handset Only EN
    [Tags]  handset_en      bk
    Create Booking - Handset Only Success EN
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Bundle With Billing Address
    [Tags]  bundle_bill      bk
    Create Booking - Bundle Success With Billing Address
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Handset Only With Billing Address
    [Tags]  handset_bill      bk
    Create Booking - Handset Only Success With Billing Address
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Bundle With Billing Address EN
    [Tags]  bundle_bill_en      bk
    Create Booking - Bundle Success With Billing Address EN
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product

Test Booking Handset Only With Billing Address EN
    [Tags]  handset_bill_en      bk
    Create Booking - Handset Only Success With Billing Address EN
#    [Teardown]   Run Keywords   Booking - Restore Stock Remaining Product
