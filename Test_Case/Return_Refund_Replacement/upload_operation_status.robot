*** Settings ***
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot    # Resource    ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/WebElement_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track Order/keywords_ApiTrackOrder.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/Keywords_upload_operation_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Orders/web_element_upload_operation_status.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variable ***
${email}          guest@email.com
${material_id}    robot_material_id_123
${serial_number}    123456
${pcms_email_test}    admin@domain.com
${pcms_password_test}    12345
${png_file}       40r.png
#${bank_ref_tmn}    12345
${inventory_id}    INAAC1112611

*** Test Cases ***
TC_ITMWM_02248 [Pending TMN] To verify that user cannot upload file if file type is not .xlsx
    [Tags]    TC_iTM_1759_16    TC_ITMWM_02248
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${png_file}
    ${result}=    Get Alert Message
    Should Be Equal    ${result}    ${error_incorrect_file_type}
    [Teardown]    Close All Browsers

TC_ITMWM_02249 [Pending TMN][Single record] To Verify that system display error message and operation status is not updated if user update operation status without order id.
    [Tags]    TC_iTM_1759_17    TC_ITMWM_02249
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    2    ${EMPTY}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Refund Request To Pending TMN - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02250 [Pending TMN][Multiple records - error some record] To Verify that system display error message and operation status is not updated if user update operation status without order id.
    [Tags]    TC_iTM_1759_18    TC_ITMWM_02250
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002192
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    2    ${EMPTY}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02251 [Pending TMN][Multiple records - error all records] To Verify that system display error message and operation status is not updated if user update operation status without order id.
    [Tags]    TC_iTM_1759_19    TC_ITMWM_02251
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    2    ${EMPTY}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    3    ${EMPTY}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Refund Request To Pending TMN - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02252 [Pending TMN][Single record] To Verify that system display error message and operation status is not updated if user update operation status without item id.
    [Tags]    TC_iTM_1759_20    rerun    TC_ITMWM_02252
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    2    ${EMPTY}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Refund Request To Pending TMN - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02253 [Pending TMN][Multiple records - error some record] To Verify that system display error message and operation status is not updated if user update operation status without item id.
    [Tags]    TC_iTM_1759_21    rerun    TC_ITMWM_02253
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    3    ${EMPTY}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02254 [Pending TMN][Multiple records - error all records] To Verify that system display error message and operation status is not updated if user update operation status without item id.
    [Tags]    TC_iTM_1759_22    rerun    TC_ITMWM_02254
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    2    ${EMPTY}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    3    ${EMPTY}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Refund Request To Pending TMN - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02255 [Pending TMN][Single record] To verify that system display error message and operation status is not updated if order not found.
    [Tags]    TC_iTM_1759_26     TC_ITMWM_02255
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    2    no${order_id}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02256 [Pending TMN][Multiple records - error some record] To verify that system display error message and operation status is not updated if order not found.
    [Tags]    TC_iTM_1759_27     TC_ITMWM_02256
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002192
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    3    no${order_id}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02257 [Pending TMN][Multiple records - error all records] To verify that system display error message and operation status is not updated if order not found.
    [Tags]    TC_iTM_1759_28    TC_ITMWM_02257
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    2    no${order_id}
    @{content}=    Refund Request To Pending TMN - Excel Edit Order Id    ${content}    3    no${order_id}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02258 [Pending TMN][Single record] To verify that system display error message and operation status is not updated if Item not found.
    [Tags]    TC_iTM_1759_29    run     TC_ITMWM_02258
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    2    no${order_id}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02259 [Pending TMN][Multiple records - error some record] To verify that system display error message and operation status is not updated if Item not found.
    [Tags]    TC_iTM_1759_30    run    TC_ITMWM_02259
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    3    no${order_id}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02260 [Pending TMN][Multiple records - error all records] To verify that system display error message and operation status is not updated if Item not found.
    [Tags]    TC_iTM_1759_31    run     TC_ITMWM_02260
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    2    no${items_id[0][0]}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    3    no${items_id[1][0]}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02261 [Pending TMN][Single record] To verify that system display error message and operation status is not updated if Item not match with order id.
    [Tags]    TC_iTM_1759_32    TC_ITMWM_02261
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    ${not_match_item_id}=    Evaluate    ${items_id[0][0]}-1
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    2    ${not_match_item_id}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item not match with order id    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02262 [Pending TMN][Multiple records - error some record] To verify that system display error message and operation status is not updated if Item not match with order id.
    [Tags]    TC_iTM_1759_33    TC_ITMWM_02262
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    ${not_match_item_id}=    Evaluate    ${items_id[1][0]}-2
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    3    ${not_match_item_id}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item not match with order id    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02263 [Pending TMN][Multiple records - error all records] To verify that system display error message and operation status is not updated if Item not match with order id.
    [Tags]    TC_iTM_1759_34    TC_ITMWM_02263
    # [Teardown]    Close All Browsers
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    ${not_match_item_id1}=    Evaluate    ${items_id[0][0]}-3
    ${not_match_item_id2}=    Evaluate    ${items_id[1][0]}-2
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    2    ${not_match_item_id1}
    @{content}=    Refund Request To Pending TMN - Excel Edit Item Id    ${content}    3    ${not_match_item_id2}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item not match with order id    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}

TC_ITMWM_02265 [Pending TMN][Multiple records - duplicate some record] To verify that system update operation status and display summary message correctly if user update operation status with duplicate record.
    [Tags]    TC_iTM_1759_39    TC_ITMWM_02265
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id1}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id1}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    #${order_id2}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id2}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}    ${order_id1}
    @{content}=    Refund Request To Pending TMN - Append Data Multiple Orders    ${orders_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    customer_cancelled
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    6    7
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Duplicate records    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id1}    ${operation_db_refund_request}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id2}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02266 [Pending TMN][Multiple records - duplicate all records] To verify that system update operation status and display summary message correctly if user update operation status with duplicate record.
    [Tags]    TC_iTM_1759_40    TC_ITMWM_02266
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id1}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id1}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    #${order_id2}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id2}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}    ${order_id1}    ${order_id2}
    @{content}=    Refund Request To Pending TMN - Append Data Multiple Orders    ${orders_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    customer_cancelled
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    6    7    8    9
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Duplicate records    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id1}    ${operation_db_refund_request}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id2}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02268 [Pending TMN][Single record] To verify that system display error message and operation status is not updated if user update operation status by using offline order.
    [Tags]    TC_ITMWM_02268
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Incorrect payment channel    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02269 [Pending TMN][Multiple records - error some record] To verify that system display error message and operation status is not updated if user update operation status by using offline order.
    [Tags]    TC_iTM_1759_43    TC_ITMWM_02269
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id1}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id1}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_id2}=    Guest Buy Product Success with CS    ${email}    ${default_inventoryID_cs}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}
    @{content}=    Refund Request To Pending TMN - Append Data Multiple Orders    ${orders_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    customer_cancelled
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    4
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Incorrect payment channel    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id1}    ${operation_db_refund_request}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id2}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02270 [Pending TMN][Multiple records - error all records] To verify that system display error message and operation status is not updated if user update operation status by using offline order.
    [Tags]    TC_iTM_1759_44    TC_ITMWM_02270
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Incorrect payment channel    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02271 [Pending TMN][Single record] To verify that system display error message and operation status is not updated if user update operation status by using COD order.
    [Tags]    TC_iTM_1759_45    TC_ITMWM_02271
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}    Create Order API - Guest buy single product success with COD
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    #@{content}=    Refund Request To Pending TMN - Excel Remove Order Id    ${content}    2
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Incorrect payment channel    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02272 [Pending TMN][Multiple records - error some record] To verify that system display error message and operation status is not updated if user update operation status by using COD order.
    [Tags]    TC_iTM_1759_46     TC_ITMWM_02272
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id1}=    Guest Buy Product Success with COD    ${email}    ${default_inventoryID_cod}
    #${order_id2}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id2}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Item status    ${items_id1[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id1[0][0]}
    TrackOrder - Set Item status    ${items_id1[0][0]}    shipped
    TrackOrder - Click save    ${items_id1[0][0]}
    TrackOrder - Set Item status    ${items_id1[0][0]}    delivered
    TrackOrder - Click save    ${items_id1[0][0]}
    TrackOrder - Set Item status    ${items_id1[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id1[0][0]}
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    @{content}=    Refund Request To Pending TMN - Append Data Multiple Orders    ${orders_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Incorrect payment channel    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id1}    ${operation_db_refund_request}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id2}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02273 [Pending TMN][Multiple records - error all records] To verify that system display error message and operation status is not updated if user update operation status by using COD order.
    [Tags]    TC_iTM_1759_47    TC_ITMWM_02273
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id1}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    ${order_id2}=    Guest Buy Multiple-item Success with COD    ${email}    ${default_inventoryID_cod}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    pending_shipment
    TrackOrder - Set Items status    ${items_id1}    shipped
    TrackOrder - Set Items status    ${items_id1}    delivered
    TrackOrder - Set Item status    ${items_id1[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${items_id1[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    pending_shipment
    TrackOrder - Set Items status    ${items_id2}    shipped
    TrackOrder - Set Items status    ${items_id2}    delivered
    TrackOrder - Set Item status    ${items_id2[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${items_id2[1][0]}    customer_cancelled
    TrackOrder - Click save all
    @{content}=    Refund Request To Pending TMN - Append Data Multiple Orders    ${orders_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2    3    4    5
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Incorrect payment channel    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id1}    ${operation_db_refund_request}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id2}    ${operation_db_refund_request}
    [Teardown]    Close All Browsers

TC_ITMWM_02274 [Pending TMN][Single record] To verify that system display error message and operation status is not updated if user update operation status to Pending TMN but current status is None.
    [Tags]    TC_iTM_1759_48    TC_ITMWM_02274
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_none}
    [Teardown]    Close All Browsers

TC_ITMWM_02275 [Pending TMN][Multiple records - error some record] To verify that system display error message and operation status is not updated if user update operation status to Pending TMN but current status is None.
    [Tags]    TC_iTM_1759_49    TC_ITMWM_02275
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_none}
    [Teardown]    Close All Browsers

TC_ITMWM_02276 [Pending TMN][Multiple records - error all records] To verify that system display error message and operation status is not updated if user update operation status to Pending TMN but current status is None.
    [Tags]    TC_iTM_1759_50    TC_ITMWM_02276
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_none}
    [Teardown]    Close All Browsers

TC_ITMWM_02277 [Pending TMN][Single record] To verify that system display error message and operation status is not updated if user update operation status to Pending TMN but current status is Refund Complete.
    [Tags]    TC_iTM_1759_51     TC_ITMWM_02277
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    refund_complete
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    [Teardown]    Close All Browsers

TC_ITMWM_02278 [Pending TMN][Multiple records - error some record] To verify that system display error message and operation status is not updated if user update operation status to Pending TMN but current status is Refund Complete.
    [Tags]    TC_iTM_1759_52     TC_ITMWM_02278
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order id=${order_id}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    refund_complete
    Input Text    id=bank_ref_tmn_${items_id[1][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    [Teardown]    Close All Browsers

TC_ITMWM_02279 [Pending TMN][Multiple records - error all records] To verify that system display error message and operation status is not updated if user update operation status to Pending TMN but current status is Refund Complete.
    [Tags]    TC_iTM_1759_53    TC_ITMWM_02279
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order id=${order_id}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    refund_complete
    Input Text    id=bank_ref_tmn_${items_id[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    refund_complete
    Input Text    id=bank_ref_tmn_${items_id[1][0]}    ${bank_ref_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    [Teardown]    Close All Browsers

TC_ITMWM_02280 [Pending TMN][Single record] To verify that user can update operation status from Refund Request to Pending TMN by using CCW order successfully.
    [Tags]    TC_iTM_1759_54    TC_ITMWM_02280
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_request}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    [Teardown]    Close All Browsers

TC_ITMWM_02281 [Pending TMN][Multiple (items) records] To verify that user can update operation status from Refund Request to Pending TMN by using CCW order successfully.
    [Tags]    TC_iTM_1759_55     TC_ITMWM_02281
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order id=${order_id}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[1][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_request}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    2
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on UI    ${item_sid[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    [Teardown]    Close All Browsers

TC_ITMWM_02282 [Pending TMN][Multiple (order) records] To verify that user can update operation status from Refund Request to Pending TMN by using CCW order successfully.
    [Tags]    TC_iTM_1759_56    TC_ITMWM_02282
    @{content}=    Refund Request To Pending TMN - Append Header To List
    #${order_id1}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id1}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    #${order_id2}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id2}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}
    @{content}=    Refund Request To Pending TMN - Append Data Multiple Orders    ${orders_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    customer_cancelled
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    4
    TrackOrder - Go To Order Detail Page    ${order_id1}
    TrackOrder - Check Operation Status on UI    ${items_id1[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on UI    ${items_id1[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id1[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id1[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id1[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id1[1][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Go To Order Detail Page    ${order_id2}
    TrackOrder - Check Operation Status on UI    ${items_id2[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on UI    ${items_id2[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id2[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id2[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id2[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id2[1][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    [Teardown]    Close All Browsers

TC_ITMWM_02283 [Pending TMN][Single record] To verify that user can update operation status from Refund Request to Pending TMN by using installment order successfully.
    [Tags]    TC_iTM_1759_57    TC_ITMWM_02283
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}=    Guest Buy Product Success with Installment payment    ${email}    กสิกรไทย    2    ${default_inventoryID_cod}
    Log To Console    order id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_request}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    [Teardown]    Close All Browsers

TC_ITMWM_02284 [Pending TMN][Multiple (items) records] To verify that user can update operation status from Refund Request to Pending TMN by using installment order successfully.
    [Tags]    TC_iTM_1759_58    TC_ITMWM_02284
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id}=    Guest Buy Multiple-item Success with installment    ${email}    กสิกรไทย    2    ${default_inventoryID_cod}
    Log To Console    order id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[1][0]}
    Refund Request To Pending TMN - Append Data    ${items_id}    ${order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_request}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_request}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    2
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    Log To Console    item_id=${items_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    [Teardown]    Close All Browsers

TC_ITMWM_02285 [Pending TMN][Multiple (order) records] To verify that user can update operation status from Refund Request to Pending TMN by using installment order successfully.
    [Tags]    TC_iTM_1759_59    TC_ITMWM_02285
    @{content}=    Refund Request To Pending TMN - Append Header To List
    ${order_id1}=    Guest Buy Multiple-item Success with installment    ${email}    กสิกรไทย    2    ${default_inventoryID_cod}
    ${order_id2}=    Guest Buy Multiple-item Success with installment    ${email}    กสิกรไทย    2    ${default_inventoryID_cod}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}
    @{content}=    Refund Request To Pending TMN - Append Data Multiple Orders    ${orders_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Log To Console    content=${content}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    customer_cancelled
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    4
    TrackOrder - Go To Order Detail Page    ${order_id1}
    TrackOrder - Check Operation Status on UI    ${items_id1[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on UI    ${items_id1[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id1[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id1[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id1[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id1[1][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Go To Order Detail Page    ${order_id2}
    TrackOrder - Check Operation Status on UI    ${items_id2[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on UI    ${items_id2[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id2[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id2[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id2[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id2[1][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    [Teardown]    Close All Browsers

TC_ITMWM_02286 [Pending TMN] To Verify that system display error message if user upload empty file to system.
    [Tags]    TC_iTM_1759_60    TC_ITMWM_02286
    @{content}    Create List    ${EMPTY}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Refund Request To Pending TMN - Upload Operation Status - Verify error message - Empty file
    [Teardown]    Close All Browsers

TC_ITMWM_02287 [Pending TMN] To Verify that system display error message if user click upload file but didn't upload.
    [Tags]    TC_iTM_1759_61    TC_ITMWM_02287
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Click Upload Button
    Refund Request To Pending TMN - Upload Operation Status - Verify error message - No file uploaded
    [Teardown]    Close All Browsers

TC_ITMWM_02289 [Refund Complete] To verify that user cannot upload file if file type is not .xlsx
    [Tags]    TC_iTM_1759_64    TC_ITMWM_02289
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${png_file}
    ${result}=    Get Alert Message
    Should Be Equal    ${result}    ${error_incorrect_file_type}
    [Teardown]    Close All Browsers

TC_ITMWM_02290 [Refund Complete] [Single record] To Verify that system display error message and operation status is not updated if user update operation status without order id.
    [Tags]    TC_iTM_1759_65    TC_ITMWM_02290
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    2    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Pending TMN To Refund Complete - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02291 [Refund Complete] [Multiple records - error some record] To Verify that system display error message and operation status is not updated if user update operation status without order id.
    [Tags]    TC_iTM_1759_66    TC_ITMWM_02291
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002717
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    2    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02292 [Refund Complete] [Multiple records - error all records] To Verify that system display error message and operation status is not updated if user update operation status without order id.
    [Tags]    TC_iTM_1759_67
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    2    ${EMPTY}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    3    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Pending TMN To Refund Complete - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02293 [Refund Complete] [Single record] To Verify that system display error message and operation status is not updated if user update operation status without item id.
    [Tags]    TC_iTM_1759_68     TC_ITMWM_02293
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Pending TMN To Refund Complete - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02294 [Refund Complete] [Multiple records - error some record] To Verify that system display error message and operation status is not updated if user update operation status without item id.
    [Tags]    TC_iTM_1759_69    TC_ITMWM_02294
    #[Teardown]    Close All Browsers
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002717
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}

TC_ITMWM_02295 [Refund Complete] [Multiple records - error all records] To Verify that system display error message and operation status is not updated if user update operation status without item id.
    [Tags]    TC_iTM_1759_70    TC_ITMWM_02295
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    ${EMPTY}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    3    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Pending TMN To Refund Complete - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02296 [Refund Complete] [Single record] To Verify that system display error message and operation status is not updated if user update operation status without TMN Payment Ref.
    [Tags]    TC_iTM_1759_74    TC_ITMWM_02296
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Payment Ref    ${content}    2    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Pending TMN To Refund Complete - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02297 [Refund Complete] [Multiple records - error some record] To Verify that system display error message and operation status is not updated if user update operation status without TMN Payment Ref.
    [Tags]    TC_iTM_1759_75     TC_ITMWM_02297
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002717
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Payment Ref    ${content}    2    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - TMN Payment Ref not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02298 [Refund Complete] [Multiple records - error all records] To Verify that system display error message and operation status is not updated if user update operation status without TMN Payment Ref.
    [Tags]    TC_iTM_1759_76    TC_ITMWM_02298
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    ${EMPTY}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    3    ${EMPTY}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Pending TMN To Refund Complete - Upload Operation Status - Verify error message - Required field
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02299 [Refund Complete] [Single record] To verify that system display error message and operation status is not updated if order not found.
    [Tags]    TC_iTM_1759_77    TC_ITMWM_02299
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    2    no${order_id}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02300 [Refund Complete] [Multiple records - error some record] To verify that system display error message and operation status is not updated if order not found.
    [Tags]    TC_iTM_1759_78    TC_ITMWM_02300
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002717
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    2    no${order_id}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02301 [Refund Complete] [Multiple records - error all records] To verify that system display error message and operation status is not updated if order not found.
    [Tags]    TC_iTM_1759_79    TC_ITMWM_02301
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    2    no${order_id}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Order Id    ${content}    3    no${order_id}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Order id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02302 [Refund Complete] [Single record] To verify that system display error message and operation status is not updated if Item not found.
    [Tags]    TC_iTM_1759_80    TC_ITMWM_02302
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    no${order_id}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02303 [Refund Complete] [Multiple records - error some record] To verify that system display error message and operation status is not updated if Item not found.
    [Tags]    TC_iTM_1759_81    TC_ITMWM_02303
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002717
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    no${items_id[0][0]}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02304 [Refund Complete] [Multiple records - error all records] To verify that system display error message and operation status is not updated if Item not found.
    [Tags]    TC_iTM_1759_82    TC_ITMWM_02304
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    no${items_id[0][0]}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    3    no${items_id[1][0]}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item id not found    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02305 [Refund Complete] [Single record] To verify that system display error message and operation status is not updated if Item not match with order id.
    [Tags]    TC_iTM_1759_83     TC_ITMWM_02305
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    ${not_match_item_id}=    Evaluate    ${items_id[0][0]}-1
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    ${not_match_item_id}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item not match with order id    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02306 [Refund Complete] [Multiple records - error some record] To verify that system display error message and operation status is not updated if Item not match with order id.
    [Tags]    TC_iTM_1759_84    TC_ITMWM_02306
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    #${order_id}=    Set Variable    3002717
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    ${not_match_item_id}=    Evaluate    ${items_id[1][0]}-2
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    ${not_match_item_id}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item not match with order id    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02307 [Refund Complete] [Multiple records - error all records] To verify that system display error message and operation status is not updated if Item not match with order id.
    [Tags]    TC_iTM_1759_85    TC_ITMWM_02307
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    ${not_match_item_id1}=    Evaluate    ${items_id[0][0]}-3
    ${not_match_item_id2}=    Evaluate    ${items_id[1][0]}-2
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    2    ${not_match_item_id1}
    @{content}=    Pending TMN To Refund Complete - Excel Edit Item Id    ${content}    3    ${not_match_item_id2}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Item not match with order id    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02309 [Refund Complete] [Multiple records - duplicate some record] To verify that system update operation status and display summary message correctly if user update operation status with duplicate record.
    [Tags]    TC_iTM_1759_90    TC_ITMWM_02309
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id1}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id1}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    #${order_id2}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id2}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}    ${order_id1}
    @{content}=    Pending TMN To Refund Complete - Append Data Multiple Orders    ${orders_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    customer_cancelled
    TrackOrder - Set Operation Status    ${items_id1[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id1[0][0]}
    TrackOrder - Set Operation Status    ${items_id1[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id1[1][0]}
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    TrackOrder - Set Operation Status    ${items_id2[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id2[0][0]}
    TrackOrder - Set Operation Status    ${items_id2[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id2[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    6    7
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Duplicate records    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id1}    ${operation_db_pending_tmn}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id2}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02310 [Refund Complete] [Multiple records - duplicate all records] To verify that system update operation status and display summary message correctly if user update operation status with duplicate record.
    [Tags]    TC_iTM_1759_91    TC_ITMWM_02310
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id1}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id1}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    #${order_id2}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id2}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    @{orders_id}    Create List    ${order_id1}    ${order_id2}    ${order_id1}    ${order_id2}
    @{content}=    Pending TMN To Refund Complete - Append Data Multiple Orders    ${orders_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id1}
    ${items_id1}=    TrackOrder - Get Order Shipment id    ${order_id1}
    TrackOrder - Set Items status    ${items_id1}    customer_cancelled
    TrackOrder - Set Operation Status    ${items_id1[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation Status    ${items_id1[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all
    TrackOrder - Go To Order Detail Page    ${order_id2}
    ${items_id2}=    TrackOrder - Get Order Shipment id    ${order_id2}
    TrackOrder - Set Items status    ${items_id2}    customer_cancelled
    TrackOrder - Set Operation Status    ${items_id2[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation Status    ${items_id2[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    6    7    8    9
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Duplicate records    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id1}    ${operation_db_pending_tmn}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id2}    ${operation_db_pending_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02311 [Refund Complete] [Single record] To verify that system display error message and operation status is not updated if user update operation status to Refund Complete but current status is not Pending TMN.
    [Tags]    TC_iTM_1759_92    TC_ITMWM_02311
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    ####### none
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_none}
    ####### refund request
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    ####### clt doc uploaded
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_clt_doc_uploaded}
    ####### scm require doc
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_scm_require_doc}
    ####### clt doc uploaded
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_clt_doc_uploaded}
    ####### scm verified
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_scm_verified}
    [Teardown]    Close All Browsers

TC_ITMWM_02312 [Refund Complete] [Multiple records - error some record] To verify that system display error message and operation status is not updated if user update operation status to Refund Complete but current status is not Pending TMN.
    [Tags]    TC_iTM_1759_93    TC_ITMWM_02312
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    ####### none
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_none}
    ####### refund request
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Item status    ${items_id[0][0]}    ${operation_db_customer_cancel}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_request}
    ####### clt doc uploaded
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ####### scm require doc
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    ####### clt doc uploaded
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    ####### scm verified
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_scm_verified}
    [Teardown]    Close All Browsers

TC_ITMWM_02313 [Refund Complete] [Multiple records - error all records] To verify that system display error message and operation status is not updated if user update operation status to Refund Complete but current status is is not Pending TMN.
    [Tags]    TC_iTM_1759_94    TC_ITMWM_02313
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Log To Console    order_id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    ####### none
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_none}
    ####### refund request
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    TrackOrder - Set Items status    ${items_id}    ${operation_db_customer_cancel}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_refund_request}
    ####### clt doc uploaded
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_clt_doc_uploaded}
    ####### scm require doc
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_scm_require_doc}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_scm_require_doc}
    ####### clt doc uploaded
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_clt_doc_uploaded}
    ####### scm verified
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[1][0]}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    @{error_line}    Create List    2    3
    ${line_error_format}=    Upload Operation Status - Set line error format    @{error_line}
    Upload Operation Status - Verify pop up error message - Cannot change operation status    ${line_error_format}
    TrackOrder - Check Multiple items Operation Status on DB    ${items_id}    ${operation_db_scm_verified}
    [Teardown]    Close All Browsers

TC_ITMWM_02314 [Refund Complete] [Single record] To verify that user can update operation status from Pending TMN to Refund Complete by using CCW order successfully.
    [Tags]    TC_iTM_1759_95    TC_ITMWM_02314
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cs}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_pending_tmn}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Log To Console    content=${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete- Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02315 [Refund Complete] [Multiple (items) records] To verify that user can update operation status from Pending TMN to Refund Complete by using CCW order successfully.
    [Tags]    TC_iTM_1759_96    TC_ITMWM_02315
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cs}
     ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Log To Console    order id=${order_id}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[1][0]}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_pending_tmn}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Log To Console    content=${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete- Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    2
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02316 [Refund Complete] [Multiple (order) records] To verify that user can update operation status from Pending TMN to Refund Complete by using CCW order successfully.
    [Tags]    TC_iTM_1759_97    TC_ITMWM_02316
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    ${order_id_list}=    Create List
    : FOR    ${index}    IN RANGE    1    3
    \    #${order_id}=    Guest Buy Multiple-item Success with CCW    ${email}    ${default_inventoryID_cs}
    \    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    \    Append To List    ${order_id_list}    ${order_id}
    \    Close All Browsers
    \    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    \    TrackOrder - Go To Order Detail Page    ${order_id}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    \    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    \    TrackOrder - Set Item status    ${items_id[1][0]}    pending_shipment
    \    TrackOrder - Click save all
    \    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    \    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    \    TrackOrder - Click save all
    \    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    \    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    \    TrackOrder - Click save all
    @{content}=    Pending TMN To Refund Complete - Append Data Multiple Orders    ${order_id_list}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    4
    : FOR    ${index}    IN RANGE    0    2
    \    TrackOrder - Go To Order Detail Page    ${order_id_list[${index}]}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id_list[${index}]}
    \    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    \    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    \    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    \    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    \    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    \    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    \    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    \    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02317 [Refund Complete] [Single record] To verify that user can update operation status from Pending TMN to Refund Complete by using offline order successfully.
    [Tags]    TC_iTM_1759_98    TC_ITMWM_02317
    ${order_id}    Create Order API - Guest buy single product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02318 [Refund Complete] [Multiple (items) records] To verify that user can update operation status from Pending TMN to Refund Complete by using offline order successfully.
    [Tags]    TC_iTM_1759_99    TC_ITMWM_02318
    ${order_id}    Create Order API - Guest buy multi product success with CS
    Create_order.Set Payment Success For CS    ${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    TrackOrder - Set Item status    ${items_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    TrackOrder - Set Item status    ${items_id[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    2
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02319 [Refund Complete] [Multiple (order) records] To verify that user can update operation status from Pending TMN to Refund Complete by using offline order successfully.
    [Tags]    TC_iTM_1759_100    TC_ITMWM_02319
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    ${order_id_list}=    Create List
    : FOR    ${index}    IN RANGE    1    3
    \    ${order_id}    Create Order API - Guest buy multi product success with CS
    \    Create_order.Set Payment Success For CS    ${order_id}
    \    Append To List    ${order_id_list}    ${order_id}
    \    Close All Browsers
    \    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    \    TrackOrder - Go To Order Detail Page    ${order_id}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    \    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    \    TrackOrder - Set Item status    ${items_id[1][0]}    pending_shipment
    \    TrackOrder - Click save all
    \    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    \    TrackOrder - Set Item status    ${items_id[1][0]}    shipped
    \    TrackOrder - Click save all
    \    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    \    TrackOrder - Set Item status    ${items_id[1][0]}    delivered
    \    TrackOrder - Click save all
    \    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    \    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    \    TrackOrder - Click save all
    \    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    \    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_clt_doc_uploaded}
    \    TrackOrder - Click save all
    \    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    \    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_scm_verified}
    \    TrackOrder - Click save all
    \    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    \    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    \    TrackOrder - Click save all
    @{content}=    Pending TMN To Refund Complete - Append Data Multiple Orders    ${order_id_list}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    4
    : FOR    ${index}    IN RANGE    0    2
    \    TrackOrder - Go To Order Detail Page    ${order_id_list[${index}]}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id_list[${index}]}
    \    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    \    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    \    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    \    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    \    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    \    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    \    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    \    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02320 [Refund Complete] [Single record] To verify that user can update operation status from Pending TMN to Refund Complete by using COD order successfully.
    [Tags]    TC_iTM_1759_101    TC_ITMWM_02320
    ${order_id}    Create Order API - Guest buy single product success with COD
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save    ${items_id[0][0]}
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save    ${items_id[0][0]}
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02321 [Refund Complete] [Multiple (items) records] To verify that user can update operation status from Pending TMN to Refund Complete by using COD order successfully.
    [Tags]    TC_iTM_1759_102    TC_ITMWM_02321
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    TrackOrder - Set Item status    ${items_id[1][0]}    pending_shipment
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    TrackOrder - Set Item status    ${items_id[1][0]}    shipped
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    TrackOrder - Set Item status    ${items_id[1][0]}    delivered
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    2
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02322 [Refund Complete] [Multiple (order) records] To verify that user can update operation status from Pending TMN to Refund Complete by using COD order successfully.
    [Tags]    TC_iTM_1759_103    TC_ITMWM_02322
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    ${order_id_list}=    Create List
    : FOR    ${index}    IN RANGE    1    3
    \    ${order_id}    Create Order API - Guest buy multi product success with COD
    \    Append To List    ${order_id_list}    ${order_id}
    \    Close All Browsers
    \    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    \    TrackOrder - Go To Order Detail Page    ${order_id}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    \    TrackOrder - Set Item status    ${items_id[0][0]}    pending_shipment
    \    TrackOrder - Set Item status    ${items_id[1][0]}    pending_shipment
    \    TrackOrder - Click save all
    \    TrackOrder - Set Item status    ${items_id[0][0]}    shipped
    \    TrackOrder - Set Item status    ${items_id[1][0]}    shipped
    \    TrackOrder - Click save all
    \    TrackOrder - Set Item status    ${items_id[0][0]}    delivered
    \    TrackOrder - Set Item status    ${items_id[1][0]}    delivered
    \    TrackOrder - Click save all
    \    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    \    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    \    TrackOrder - Click save all
    \    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_clt_doc_uploaded}
    \    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_clt_doc_uploaded}
    \    TrackOrder - Click save all
    \    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_scm_verified}
    \    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_scm_verified}
    \    TrackOrder - Click save all
    \    TrackOrder - Set Operation Status    ${items_id[0][0]}    ${operation_db_pending_tmn}
    \    TrackOrder - Set Operation Status    ${items_id[1][0]}    ${operation_db_pending_tmn}
    \    TrackOrder - Click save all
    @{content}=    Pending TMN To Refund Complete - Append Data Multiple Orders    ${order_id_list}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    4
    : FOR    ${index}    IN RANGE    0    2
    \    TrackOrder - Go To Order Detail Page    ${order_id_list[${index}]}
    \    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id_list[${index}]}
    \    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_refund_complete}
    \    TrackOrder - Check Operation Status on UI    ${items_id[1][0]}    ${operation_ui_refund_complete}
    \    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_refund_complete}
    \    TrackOrder - Check Operation Status on DB    ${items_id[1][0]}    ${operation_db_refund_complete}
    \    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    \    TrackOrder - Verify Log OperationStatus by User    ${items_id[1][0]}    ${operation_db_refund_complete}    ${pcms_email_test}
    \    TrackOrder - Check Multiple Bank Ref on DB    ${items_id}    ${bank_ref_tmn}
    \    TrackOrder - Verify Log Multiple Bank Ref TMN    ${items_id}    ${bank_ref_tmn}
    [Teardown]    Close All Browsers

TC_ITMWM_02323 [Refund Complete] To Verify that system display error message if user upload empty file to system.
    [Tags]    TC_iTM_1759_104    TC_ITMWM_02323
    @{content}    Create List    ${EMPTY}
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Refund Request To Pending TMN - Upload Operation Status - Verify error message - Empty file
    [Teardown]    Close All Browsers

TC_ITMWM_02324 [Refund Complete] To Verify that system display error message if user click upload file but didn't upload.
    [Tags]    TC_iTM_1759_105    TC_ITMWM_02324
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Click Upload Button
    Pending TMN To Refund Complete - Upload Operation Status - Verify error message - No file uploaded
    [Teardown]    Close All Browsers

TC_ITMWM_02267 [Pending TMN] To verify that system doesn't update TMN Payment Ref. if user update operation status from Refund Request to Pending TMN.
    [Tags]    TC_iTM_1759_41    TC_ITMWM_02267
    @{content}=    Pending TMN To Refund Complete - Append Header To List
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID_cod}
     ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Log To Console    order id=${order_id}
    Close All Browsers
    LOGIN PCMS    ${pcms_email_test}    ${pcms_password_test}
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item id=${items_id}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Pending TMN To Refund Complete - Append Data    ${items_id}    ${order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Verify Section Appear
    Refund Request To Pending TMN - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    Upload Operation Status - verify success only    1
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${items_id[0][0]}    ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB    ${items_id[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Verify Log OperationStatus by User    ${items_id[0][0]}    ${operation_db_pending_tmn}    ${pcms_email_test}
    TrackOrder - Check Bank Ref on DB is Empty    ${items_id[0][0]}
    TrackOrder - Verify No Log Bank Ref TMN    ${items_id[0][0]}
    [Teardown]    Close All Browsers
