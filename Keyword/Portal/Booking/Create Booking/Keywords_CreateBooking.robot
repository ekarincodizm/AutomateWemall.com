*** Keywords ***
Booking Data - Payment Status as waiting
    Should Be Equal	    ${var_booking_payment_status}    waiting

Booking Data - Payment Status as success
    Should Be Equal	    ${var_booking_payment_status}    success

Booking Data - Payment Status as failed
    Should Be Equal	    ${var_booking_payment_status}    failed

Booking Data - Payment Status as expired
    Should Be Equal	    ${var_booking_payment_status}    expired

Booking Data - Payment Status as refund
    Should Be Equal	    ${var_booking_payment_status}    refund

Booking Data - Booking Status as waiting
    Should Be Equal	    ${var_booking_booking_status}    waiting

Booking Data - Booking Status as success
    Should Be Equal	    ${var_booking_booking_status}    success

Booking Data - Booking Status as failed
    Should Be Equal	    ${var_booking_booking_status}    failed

Booking Data - Booking Status as expired
    Should Be Equal	    ${var_booking_booking_status}    expired

Booking Data - Booking Expired as Booking Date Extend 3 Month
    Should Be Equal	    ${var_booking_expired_at}    ${var_booking_booking_at_extend_3_month}

Booking Data - Booking Expired as Booking Date Extend 1 Hour
    Should Be Equal	    ${var_booking_expired_at}    ${var_booking_booking_at_extend_1_hour}

Create Booking - Handset Only Success
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
    Booking Pre-Order Page - Display Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code

Create Booking - Bundle Success
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
    Booking Pre-Order Page - Display Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Bundle Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code

Create Booking - Handset Only Success EN
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To EN Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
    Booking Pre-Order Page - Display EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model EN
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display EN Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data EN
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code

Create Booking - Bundle Success EN
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To EN Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
    Booking Pre-Order Page - Display EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model EN
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display EN Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Bundle Data EN
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data EN
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code








Create Booking - Handset Only Success With Billing Address
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
    Booking Pre-Order Page - Display Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Billing Address
    Booking Pre-Order Page - Display All Billing Input
    Booking Pre-Order Page - User Enter Valid Billing Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code

Create Booking - Bundle Success With Billing Address
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
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
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Bundle Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code

Create Booking - Handset Only Success With Billing Address EN
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To EN Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
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
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display EN Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Data
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data EN
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code

Create Booking - Bundle Success With Billing Address EN
    Booking - Get Product
#    Booking - Adjust Stock Remaining Product          99999
#    Booking - Clear Cache Stock Products
    Booking Landing Page - Go To EN Page
    Booking - Window Desktop Size
    Booking Landing Page - Click Button Pre-Order
    Booking Landing Page - Display T&C
    Booking Landing Page - Click Button Accept
    Booking Landing Page - Display Promotion And Next
    Booking Pre-Order Page - Display EN Page
    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document
    Booking Pre-Order Page - User Select Product Model EN
    Booking Pre-Order Page - Display Image Product
    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - Click Billing Address
    Booking Pre-Order Page - Display All Billing Input
    Booking Pre-Order Page - User Enter Valid Billing Address
    Booking Pre-Order Page - Click Button Next
    Booking Payment Page - Display EN Page
    Booking Payment Page - Display Image Product
    Booking Payment Page - Display Device Bundle Data EN
    Booking Payment Page - Display Customer Data
    Booking Payment Page - Display Booking Data EN
    Booking Payment Page - Enter Valid All CCW Information
    Booking Payment Page - Click Pay
    Booking ThankYou Page - Display ThankYou Success
    Booking ThankYou Page - Get Booking Code





