*** Settings ***
Force Tags    WLS_Bill_Cancelled
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/Keywords_upload_operation_status.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/KBANK_Payment_Gateway/Keyword_KBank_PaymentGateway.txt
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_add_to_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Bundle/Keywords_CAMP_Bundle.robot

Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/order_report/keywords_truemoveh_order_report.robot
#Library           ${CURDIR}/../../../Python_Library/order_shipment_items_library.py

*** Variable ***
${email}            guest@email.com
${material_id}      robot_material_id_123
${serial_number}    123456
${pcms_email}       admin@domain.com
${pcms_password}    12345
${default_inventoryID_cs}       LOAAB1111111
${bank_ref_tmn}     bankref_123

*** Test Cases ***
TC_ITMWM_04610 Can cancel bill when operation status is Refund Completed and buy CCW (Retail)
    [Tags]  TC_ITMWM_04610  TC1   ready   ITMA-3220  ITM-A-Sprint 2016S15
    ${order_id}=    Create Order - Guest buy single product success with CCW   ${default_inventoryID_retail}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save             ${order_shipment_item[0][0]}

    TrackOrder - Set Operation status   ${order_shipment_item[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save             ${order_shipment_item[0][0]}

    Run PCMS Order
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${order_shipment_item[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save             ${order_shipment_item[0][0]}

    TrackOrder - Check Item Status on UI            ${order_shipment_item[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[0][0]}    ${operation_db_refund_complete}

    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    4
    [Teardown]   Close All Browsers

TC_ITMWM_04611 Can cancel bill when operation status is Refund Completed buy installment (Item A=Market place, Item B=Market Place) (Partial item)
    [Tags]    TC_ITMWM_04611   ready   ITMA-3220  ITM-A-Sprint 2016S15
    ${order_id}=    Create Order - Guest buy multi product success with Installment Kbank   ${default_inventoryID_market_place}   ${default_inventoryID_market_place}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save             ${order_shipment_item[0][0]}

    TrackOrder - Set Operation status   ${order_shipment_item[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save             ${order_shipment_item[0][0]}

    Run PCMS Order
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${order_shipment_item[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all

    TrackOrder - Check Item Status on UI            ${order_shipment_item[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item[0][0]}    ${operation_db_refund_complete}    ${pcms_email}

    TrackOrder - Check Item Status on UI            ${order_shipment_item[1][0]}    ${item_status_ui_order_pending}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[1][0]}    ${item_status_db_order_pending}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[1][0]}    ${operation_ui_none}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[1][0]}    ${operation_db_none}

    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    None
    [Teardown]   Close All Browsers

TC_ITMWM_04612 Can cancel bill when operation status is Refund Completed buy CCW (Item A=Retail, Item B=Retail) (All item)
    [Tags]    TC_ITMWM_04612   ready   ITMA-3220  ITM-A-Sprint 2016S15
    ${order_id}=    Create Order - Guest buy multi product success with CCW   ${default_inventoryID_retail}   ${default_inventoryID_retail}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Item status        ${order_shipment_item[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all

    TrackOrder - Set Operation status   ${order_shipment_item[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation status   ${order_shipment_item[1][0]}    ${operation_db_pending_tmn}
    Sleep   1
    TrackOrder - Click save all

    Run PCMS Order
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Set Operation status        ${order_shipment_item[1][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${order_shipment_item[0][0]}    ${bank_ref_tmn}
    Input Text    id=bank_ref_tmn_${order_shipment_item[1][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all

    TrackOrder - Check Item Status on UI            ${order_shipment_item[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item[0][0]}    ${operation_db_refund_complete}    ${pcms_email}

    TrackOrder - Check Item Status on UI            ${order_shipment_item[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[1][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item[1][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item[1][0]}    ${operation_db_refund_complete}    ${pcms_email}

    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    4
    [Teardown]   Close All Browsers

TC_ITMWM_04613 Can cancel bill when operation status is Refund Completed buy installment (Item A=Retail, Item B=Market place ) (All item)
    [Tags]    TC_ITMWM_04613   ready   ITMA-3220   ITM-A-Sprint 2016S15
    ${order_id}=    Create Order - Guest buy multi product success with Installment Kbank   ${default_inventoryID_retail}   ${default_inventoryID_market_place}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Item status        ${order_shipment_item[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all

    TrackOrder - Set Operation status   ${order_shipment_item[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation status   ${order_shipment_item[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all

    Run PCMS Order
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Set Operation status        ${order_shipment_item[1][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${order_shipment_item[0][0]}    ${bank_ref_tmn}
    Input Text    id=bank_ref_tmn_${order_shipment_item[1][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all

    TrackOrder - Check Item Status on UI            ${order_shipment_item[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item[0][0]}    ${operation_db_refund_complete}    ${pcms_email}

    TrackOrder - Check Item Status on UI            ${order_shipment_item[1][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[1][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[1][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item[1][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item[1][0]}    ${operation_db_refund_complete}    ${pcms_email}

    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    4
    [Teardown]   Close All Browsers

TC_ITMWM_04614 Can cancel bill when operation status is Refund Completed buy CS (Item A=Market place ) (All item)
    # CS/Pay = success/customer_cancelled/product=normal/Market place/
    [Tags]    TC_ITMWM_04614   ready   ITMA-3220  ITM-A-Sprint 2016S15
    ${order_id}=    Create Order API - Guest buy single product success with CS    ${default_inventoryID_market_place}
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_item[0][0]}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    TrackOrder - Set Item status        ${order_shipment_item_id}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save             ${order_shipment_item_id}
    TrackOrder - Set Operation status        ${order_shipment_item_id}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save             ${order_shipment_item_id}
    TrackOrder - Set Operation status        ${order_shipment_item_id}    ${operation_db_scm_verified}
    TrackOrder - Click save             ${order_shipment_item_id}
    TrackOrder - Set Operation status        ${order_shipment_item_id}    ${operation_db_pending_tmn}
    TrackOrder - Click save             ${order_shipment_item_id}

    Run PCMS Order
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item_id}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Operation status        ${order_shipment_item_id}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${order_shipment_item_id}    ${bank_ref_tmn}
    TrackOrder - Click save all

    TrackOrder - Check Item Status on UI            ${order_shipment_item_id}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item_id}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item_id}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item_id}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item_id}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item_id}    ${operation_db_refund_complete}    ${pcms_email}

    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    4
    [Teardown]    Close All Browsers

TC_ITMWM_04615 Can cancel bill when operation status is Refund Completed buy COD (Item A=Retail, Item B=Market place ) (Partial item)
    [Tags]    TC_ITMWM_04615   ready   ITMA-3220   ITM-A-Sprint 2016S15
    ${order_id}=    Create Order API - Guest buy multi product success with COD    ${default_inventoryID_retail}    ${default_inventoryID_market_place}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Set Item status        ${order_shipment_item[1][0]}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_shipped}
    TrackOrder - Set Item status        ${order_shipment_item[1][0]}    ${item_status_db_shipped}
    TrackOrder - Click save all

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_delivered}
    TrackOrder - Set Item status        ${order_shipment_item[1][0]}    ${item_status_db_delivered}
    TrackOrder - Click save all

    Run PCMS Order
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all

    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save all

    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save all

    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all

    Run PCMS Order
    Order Shipment Item - Update Create At Change Time Backwords    ${order_shipment_item[0][0]}    32 days
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${order_shipment_item[0][0]}    ${bank_ref_tmn}
    TrackOrder - Click save all

    TrackOrder - Check Item Status on UI            ${order_shipment_item[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item[0][0]}    ${operation_db_refund_complete}    ${pcms_email}

    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_04616 To verity that bill is cancelled when operation status is refund completed (User cancel by mass update satus , Buy 2 items retail)
	[Tags]   TC_ITMWM_04616   ready   ITMA-3220   ITM-A-Sprint 2016S15

	${order_id}=    Create Order API - Guest buy multi product success with CS
    #${order_id}=    Guest Buy Product Success with CCW    ${email}    ${default_inventoryID}
    Create_order.Set Payment Success For CS    ${order_id}
    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    #${order_shipment_item_id}=    Set Variable    ${order_shipment_item[0][0]}
    Close All Browsers

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}

    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Item status        ${order_shipment_item[1][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all

    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Set Operation status        ${order_shipment_item[1][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save all

    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Set Operation status        ${order_shipment_item[1][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save all

    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Set Operation status        ${order_shipment_item[1][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all

    Run PCMS Order
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    None
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    #TrackOrder - Go To Upload Operation Status Page

    ${order_id_list}=   Create List   ${order_id}
    Log To Console   order_id_list=${order_id_list}
    @{content}=   Pending TMN To Refund Complete - Append Header To List

    Log TO Console  content=${content}


    Pending TMN To Refund Complete - Append Data  ${order_shipment_item}  ${order_id}  ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Verify Section Appear
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button
    Upload Operation Status - verify success only    2

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Operation Status on UI    ${order_shipment_item[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on UI    ${order_shipment_item[1][0]}    ${operation_ui_refund_complete}

    [Teardown]   Close All Browsers

TC_ITMWM_04617 To verity that bill is cancelled when operation status is refund completed (Buy 2 items retail, item A=bundle, item B=normal)
    [Tags]   TC_ITMWM_04617    regression    WLS_High   bundle_product  ready   ITMA-3220   ITM-A-Sprint 2016S15

    Wemall Common - Open Web Wemall Homepage

    Get User ID

    Prepare TruemoveH Product Bundle On PCMS
    Prepare TruemoveH Product Bundle On CAMP
    Freebie Add To Cart - Add Product Bundle To Cart
    API Add Cart  ${PCMS_API_URL}    ${add-cart}   ${TV_user_id}    non-user    ${default_inventoryID_retail}    1


    Checkout1 - Go To Checkout1
    User Enter Valid Data As Guest On Checkout1    robotautomate@gmail.com
    User Enter Valid Data As Guest On Checkout2
    User Enter Valid Data As Guest On Checkout3
    Display Thankyou Page
    Display Payment Status On Thankyou Page As Success

    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    # ${order_id}=    Set Variable    100082239

    Log To console  order_id=${order_id}

    LOGIN PCMS    ${pcms_email}    ${pcms_password}

    Truemoveh Order Report - Go To Order Report   ${order_id}
    Truemoveh Order Report - User Click Approve Button
    Truemoveh Order Report - User Click Confirm


    ${order_shipment_item}=       TrackOrder - Get Order Shipment id      ${order_id}
    Log To Console   order_shipment_item=${order_shipment_item}
    Run PCMS Order

    TrackOrder - Go To Order Detail Page    ${order_id}


    TrackOrder - Set Item status        ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Click save all

    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_pending_tmn}
    SLeep    3
    TrackOrder - Click save all

    Run PCMS Order
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    None

    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Operation status        ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    Input Text    id=bank_ref_tmn_${order_shipment_item[0][0]}    ${bank_ref_tmn}
    SLeep    3
    TrackOrder - Click save all

    TrackOrder - Check Item Status on UI            ${order_shipment_item[0][0]}    ${item_status_ui_customer_cancelled}
    TrackOrder - Check Item Status on DB            ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}
    TrackOrder - Check Operation Status on UI       ${order_shipment_item[0][0]}    ${operation_ui_refund_complete}
    TrackOrder - Check Operation Status on DB       ${order_shipment_item[0][0]}    ${operation_db_refund_complete}
    TrackOrder - Verify Log OrderShipment by User       ${order_shipment_item[0][0]}    ${item_status_db_customer_cancelled}    ${pcms_email}
    TrackOrder - Verify Log OperationStatus by User     ${order_shipment_item[0][0]}    ${operation_db_refund_complete}    ${pcms_email}

    Close All Browsers
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[0][0]}    4
    Order - Together Check Item Status In DB     ${order_id}    ${order_shipment_item[1][0]}    None



    [Teardown]   Run Keywords    Delete TruemoveH Product Bundle On CAMP
    ...   Delete TruemoveH Product Bundle On PCMS


