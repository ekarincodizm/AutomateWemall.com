*** Settings ***
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Library           ${CURDIR}/../../Python_Library/common.py
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variables ***
${email-guest}    test@domain.com
${username}       admin@domain.com
${password}       12345
${user_id}        35
${ID_file}        ${CURDIR}/../../Resource/PIC/pds.pdf
${book_bank_file}    ${CURDIR}/../../Resource/PIC/600w.png
${slip_file}      ${CURDIR}/../../Resource/PIC/400p.jpg
${company_book_bank_file}    ${CURDIR}/../../Resource/PIC/pds.pdf
${company_certificate_file}    ${CURDIR}/../../Resource/PIC/600w.png
${marriage_certificate_file}    ${CURDIR}/../../Resource/PIC/400p.jpg
${other_file}     ${CURDIR}/../../Resource/PIC/pds.pdf
${file_bigger_than_5MB}    ${CURDIR}/../../Resource/TestData/file_bigger_than_5MB.pdf
${file_text}      ${CURDIR}/../../Resource/TestData/test_text_file.txt
${file_gif}       ${CURDIR}/../../Resource/PIC/400g.gif
${ID_id}          1
${book_bank_id}    2
${slip_id}        3
${company_book_bank_id}    4
${company_certificate_id}    5
${marriage_certificate_id}    6
${other_id}       7
${inventory_id}    LOAAB1111111
#เมาส์พร้อมคีย์บอร์ด Logitech Wireless mouse MK240 (Black)

*** Test Cases ***
TC_iTM_01_Verify that CLT doc upload is shown after cancel order (operation status is not none)
    [Tags]    TC_iTM_01    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    #TrackOrder - Go To Order Detail Page    3000495
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    [Teardown]    Close All Browsers

TC_iTM_02_Verify that user can upload and preview ID file in CLT doc upload
    [Tags]    TC_iTM_02    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${ID_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${ID_id}
    [Teardown]    Close All Browsers

TC_iTM_03_Verify that user can upload and preview book bank file in CLT doc upload
    [Tags]    TC_iTM_03    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${book_bank_file}    ${book_bank_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${book_bank_id}
    [Teardown]    Close All Browsers

TC_iTM_04_Verify that user can upload and preview SLIP file in CLT doc upload
    [Tags]    TC_iTM_04    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${slip_file}    ${slip_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${slip_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${slip_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${slip_id}
    [Teardown]    Close All Browsers

TC_iTM_05_Verify that user can upload and preview company book bank file in CLT doc upload
    [Tags]    TC_iTM_05    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${company_book_bank_file}    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${company_book_bank_id}
    [Teardown]    Close All Browsers

TC_iTM_06_Verify that user can upload and preview company certificate file in CLT doc upload
    [Tags]    TC_iTM_06    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${company_certificate_file}    ${company_certificate_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${company_certificate_id}
    [Teardown]    Close All Browsers

TC_iTM_07_Verify that user can upload and preview marriage certificate file in CLT doc upload
    [Tags]    TC_iTM_07    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${marriage_certificate_file}    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${marriage_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${marriage_certificate_id}
    [Teardown]    Close All Browsers

TC_iTM_08_Verify that user can upload and preview other file in CLT doc upload
    [Tags]    TC_iTM_08    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${other_id}
    [Teardown]    Close All Browsers

TC_iTM_09_Verify that user can upload multiple files in CLT doc upload
    [Tags]    TC_iTM_09    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    TrackOrder - CLT doc upload - Upload file    ${slip_file}    ${slip_id}
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${ID_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${slip_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${slip_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    [Teardown]    Close All Browsers

TC_iTM_10_Verify that user can upload all files in CLT doc upload
    [Tags]    TC_iTM_10    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    TrackOrder - CLT doc upload - Upload file    ${book_bank_file}    ${book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${slip_file}    ${slip_id}
    TrackOrder - CLT doc upload - Upload file    ${company_book_bank_file}    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${company_certificate_file}    ${company_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${marriage_certificate_file}    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${ID_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${slip_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${slip_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${marriage_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    [Teardown]    Close All Browsers

TC_iTM_11_Verify that user can delete ID file in CLT doc upload
    [Tags]    TC_iTM_11    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Click to delete file    ${ID_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${ID_id}
    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${ID_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${ID_id}
    [Teardown]    Close All Browsers

TC_iTM_12_Verify that user can delete book bank file in CLT doc upload
    [Tags]    TC_iTM_12    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${book_bank_file}    ${book_bank_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Click to delete file    ${book_bank_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${book_bank_file}    ${book_bank_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${book_bank_id}
    [Teardown]    Close All Browsers

TC_iTM_13_Verify that user can delete SLIP file in CLT doc upload
    [Tags]    TC_iTM_13    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${slip_file}    ${slip_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Click to delete file    ${slip_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${slip_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${slip_id}
    TrackOrder - CLT doc upload - Upload file    ${slip_file}    ${slip_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${slip_id}    ${user_id}
    TrackOrder - CLT doc upload - Verify file name on UI    ${slip_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${slip_id}
    [Teardown]    Close All Browsers

TC_iTM_14_Verify that user can delete company book bank file in CLT doc upload
    [Tags]    TC_iTM_14    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${company_book_bank_file}    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Click to delete file    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${company_book_bank_file}    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_book_bank_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_book_bank_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${company_book_bank_id}
    [Teardown]    Close All Browsers

TC_iTM_15_Verify that user can delete company certificate file in CLT doc upload
    [Tags]    TC_iTM_15    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${company_certificate_file}    ${company_certificate_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Click to delete file    ${company_certificate_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${company_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${company_certificate_file}    ${company_certificate_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${company_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${company_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${company_certificate_id}
    [Teardown]    Close All Browsers

TC_iTM_16_Verify that user can delete marriage certificate file in CLT doc upload
    [Tags]    TC_iTM_16    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${marriage_certificate_file}    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Click to delete file    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Upload file    ${marriage_certificate_file}    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${marriage_certificate_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${marriage_certificate_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${marriage_certificate_id}
    [Teardown]    Close All Browsers

TC_iTM_17_Verify that user can delete other file in CLT doc upload
    [Tags]    TC_iTM_17    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Click to delete file    ${other_id}
    TrackOrder - CLT doc upload - Confirm delete
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${other_id}
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    TrackOrder - CLT doc upload - Click to preview file    ${order_id}    ${other_id}
    [Teardown]    Close All Browsers

TC_iTM_18_Verify that user can cancel delete after click delete file in CLT doc upload
    [Tags]    TC_iTM_18    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Click to delete file    ${other_id}
    TrackOrder - CLT doc upload - Cancel delete
    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    [Teardown]    Close All Browsers

TC_iTM_19_[1 file] Verify that user cannot upload file if file size is more than 5MB.
    [Tags]    TC_iTM_19    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${ID_id}
    TrackOrder - CLT doc upload - Verify error message if upload big file
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${ID_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${ID_id}
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${ID_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    [Teardown]    Close All Browsers

TC_iTM_22_[1 file] Verify that cannot upload file if file type is not .jpg, .png or .pdf.
    [Tags]    TC_iTM_22    ready
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id = ${order_id}
    LOGIN PCMS
    #${order_id}=    Set Variable    3000495
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - CLT doc upload - Upload file    ${file_gif}    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify error message if upload invalid file
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${file_text}    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify error message if upload invalid file
    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${book_bank_id}
    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${book_bank_id}
    TrackOrder - CLT doc upload - Click upload button
    TrackOrder - CLT doc upload - Verify upload success
    # TC_iTM_20_[Multi files] Verify that cannot upload file if some file size is more that 5MB.
    #    [Tags]    TC_iTM_20    not-ready
    #    #[Teardown]    Close All Browsers
    #    #${order_id}=    Guest Buy Product Success with CS    ${email-guest}    ${inventory_id}
    #    #Log To Console    order_id = ${order_id}
    #    LOGIN PCMS
    #    ${order_id}=    Set Variable    3000495
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    #${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #    #TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    #    #TrackOrder - Click save    ${item_id[0][0]}
    #    #TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    #    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    #    TrackOrder - CLT doc upload - Upload file    ${ID_file}    ${ID_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${slip_id}
    #    TrackOrder - CLT doc upload - Upload file    ${other_file}    ${other_id}
    #    TrackOrder - CLT doc upload - Click upload button
    #    TrackOrder - CLT doc upload - Verify error message if upload big file
    #    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${ID_id}    ${user_id}
    #    TrackOrder - CLT doc upload - Verify file name on UI    ${ID_id}
    #    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${other_id}    ${user_id}
    #    TrackOrder - CLT doc upload - Verify file name on UI    ${other_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${slip_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${slip_id}
    # TC_iTM_21_[Multi files] Verify that cannot upload file if all file size is more that 5MB.
    #    [Tags]    TC_iTM_21    not-ready
    #    #[Teardown]    Close All Browsers
    #    #${order_id}=    Guest Buy Product Success with CS    ${email-guest}    ${inventory_id}
    #    #Log To Console    order_id = ${order_id}
    #    LOGIN PCMS
    #    ${order_id}=    Set Variable    3000495
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    #${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #    #TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    #    #TrackOrder - Click save    ${item_id[0][0]}
    #    #TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    #    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${ID_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${slip_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${company_certificate_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_bigger_than_5MB}    ${other_id}
    #    TrackOrder - CLT doc upload - Click upload button
    #    TrackOrder - CLT doc upload - Verify error message if upload big file
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${ID_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${ID_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${slip_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${slip_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${company_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${other_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${other_id}
    # TC_iTM_23_[Multi files] Verify that cannot upload file if some file type is not .jpg, .png or .pdf.
    #    [Tags]    TC_iTM_23    not-ready
    #    #[Teardown]    Close All Browsers
    #    #${order_id}=    Guest Buy Product Success with CS    ${email-guest}    ${inventory_id}
    #    #Log To Console    order_id = ${order_id}
    #    LOGIN PCMS
    #    ${order_id}=    Set Variable    3000495
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    #${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #    #TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    #    #TrackOrder - Click save    ${item_id[0][0]}
    #    #TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    #    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    #    TrackOrder - CLT doc upload - Upload file    ${file_gif}    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Upload file    ${marriage_certificate_file}    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_text}    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Click upload button
    #    TrackOrder - CLT doc upload - Verify error message if upload invalid file
    #    TrackOrder - CLT doc upload - Verify file path in DB    ${order_id}    ${marriage_certificate_id}    ${user_id}
    #    TrackOrder - CLT doc upload - Verify file name on UI    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${company_book_bank_id}
    # TC_iTM_24_[Multi files] Verify that cannot upload file if all file type is not .jpg, .png or .pdf.
    #    [Tags]    TC_iTM_24    not-ready
    #    #[Teardown]    Close All Browsers
    #    #${order_id}=    Guest Buy Product Success with CS    ${email-guest}    ${inventory_id}
    #    #Log To Console    order_id = ${order_id}
    #    LOGIN PCMS
    #    ${order_id}=    Set Variable    3000495
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    #${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #    #TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    #    #TrackOrder - Click save    ${item_id[0][0]}
    #    #TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    #    TrackOrder - CLT doc upload - Verify CLT doc upload section is shown
    #    TrackOrder - CLT doc upload - Upload file    ${file_gif}    ${ID_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_text}    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_gif}    ${slip_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_text}    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_gif}    ${company_certificate_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_text}    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Upload file    ${file_gif}    ${other_id}
    #    TrackOrder - CLT doc upload - Click upload button
    #    TrackOrder - CLT doc upload - Verify error message if upload invalid file
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${ID_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${ID_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${slip_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${slip_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${company_book_bank_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${company_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${company_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${marriage_certificate_id}
    #    TrackOrder - CLT doc upload - Verify file name is not shown on UI    ${other_id}
    #    TrackOrder - CLT doc upload - Verify file is not exist in DB    ${order_id}    ${other_id}
    [Teardown]    Close All Browsers
