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
TC_ITMWM_06667 Page1 : Accept Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06667    ready
    Booking Terms and Conditions Page - Open Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Verify URL
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Verify URL
    [Teardown]    Close All Browsers

TC_ITMWM_06680 Page1 : [EN] - Accept Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06680    ready
    Booking Terms and Conditions Page - Open EN Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Verify EN URL
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify EN Page
    Booking Pre-Order Page - Verify EN URL
    [Teardown]    Close All Browsers

xxx Page1 Mobile : Accept Terms and Conditions
    [Tags]    Page1    ready
    Booking Terms and Conditions Page - Open Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Verify URL
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify Page
    Booking Pre-Order Page - Verify URL
    [Teardown]    Close All Browsers

xxx Page1 Mobile : [EN] - Accept Terms and Conditions
    [Tags]    Page1    ready
    Booking Terms and Conditions Page - Open EN Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Verify EN URL
    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next
    Booking Pre-Order Page - Verify EN Page
    Booking Pre-Order Page - Verify EN URL
    [Teardown]    Close All Browsers

TC_ITMWM_06668 Page1 : Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06668    ready
    Booking Terms and Conditions Page - Open Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Verify URL
    Booking Terms and Conditions Page - Choose Radio Not Accept
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers

TC_ITMWM_06681 Page1 : [EN] - Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06681    ready
    Booking Terms and Conditions Page - Open EN Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Verify EN URL
    Booking Terms and Conditions Page - Choose Radio Not Accept
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - EN - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers

TC_ITMWM_06674 Page1 Mobile : Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06674    ready
    Booking Terms and Conditions Page - Open Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Verify URL
    Booking Terms and Conditions Page - Choose Radio Not Accept
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers

TC_ITMWM_06687 Page1 Mobile : [EN] - Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06687    ready
    Booking Terms and Conditions Page - Open EN Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Verify EN URL
    Booking Terms and Conditions Page - Choose Radio Not Accept
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - EN - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers

TC_ITMWM_06669 Page1 : Not Choose Accept or Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06669    ready
    Booking Terms and Conditions Page - Open Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Verify URL
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers

TC_ITMWM_06682 Page1 : [EN] - Not Choose Accept or Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06682    ready
    Booking Terms and Conditions Page - Open EN Page
    Maximize Browser Window
    Booking Terms and Conditions Page - Verify EN URL
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - EN - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers

TC_ITMWM_06675 Page1 Mobile : Not Choose Accept or Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06675    ready
    Booking Terms and Conditions Page - Open Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Verify URL
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers

TC_ITMWM_06688 Page1 Mobile : [EN] - Not Choose Accept or Decline Terms and Conditions
    [Tags]    Page1    TC_ITMWM_06688    ready
    Booking Terms and Conditions Page - Open EN Page
    Booking - Window Mobile Size
    Booking Terms and Conditions Page - Verify EN URL
    Booking Terms and Conditions Page - Click Next
    Booking Terms and Conditions Page - EN - Verify Alert Message
    Booking Terms and Conditions Page - Close Alert Message
    Booking Terms and Conditions Page - Display T&C
    [Teardown]    Close All Browsers
