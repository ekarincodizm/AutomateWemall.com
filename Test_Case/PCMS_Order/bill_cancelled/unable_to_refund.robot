*** Settings ***
Force Tags    WLS_Bill_Cancelled
Library    Selenium2Library
Resource   ${CURDIR}/../../../Resource/init.robot
Resource   ${CURDIR}/../../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource   ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource   ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource   ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource   ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource   ${CURDIR}/../../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Features/Create_Order/WebElement_order.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot

*** Test Cases ***
TC_ITMWM_04603 Can cancel bill when operation status is unable_to_refund and buy COD (Market place)
    [Tags]  TC_ITMWM_04603    regression    WLS_High    TC1  ready  ITMA-3220  ITM-A-Sprint 2016S15    regression
    ${order_id}=   Create Order API - Guest buy single product success with COD   ${default_inventoryID_market_place}

    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item_id=${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    #TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    [Teardown]   Close All Browsers

TC_ITMWM_04604 Can cancel bill when operation status is unable_to_refund and buy COD (Item A=Market place, Item B=Market Place) (Partial item)
    [Tags]  TC_ITMWM_04604    regression    WLS_High    ready  ITMA-3220  ITM-A-Sprint 2016S15
    ${order_id}=   Create Order API - Guest buy multi product success with COD   ${default_inventoryID_market_place}   ${default_inventoryID_market_place}

    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item_id=${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item Status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click Save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    #TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    [Teardown]   Close All Browsers

TC_ITMWM_04605 Can cancel bill when operation status is unable_to_refund and buy COD (item A = Retail, item B=Retail)
    [Tags]  TC_ITMWM_04605    regression    WLS_High    ready  2items_retail  ITMA-3220  ITM-A-Sprint 2016S15
    ${order_id}=   Create Order API - Guest buy multi product success with COD   ${default_inventoryID_retail}   ${default_inventoryID_retail}

    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item_id=${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}

    TrackOrder - Set Item Status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Item Status    ${item_id[1][0]}    customer_cancelled

    TrackOrder - Click Save All
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    #TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    [Teardown]   Close All Browsers

TC_ITMWM_04606 Can cancel bill when operation status is unable_to_refund and buy COD (item A=Retail, Item B=Market place)
	[Tags]   TC_ITMWM_04606    regression    WLS_High    1_item_retail   1_item_market_place  ready  ITMA-3220  ITM-A-Sprint 2016S15   QCT
	${order_id}=   Create Order API - Guest buy 1 item for retail and 1 item for market place and pay successfully with COD
	LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item_id=${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${item_id[0][0]}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    #TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}     4

    [Teardown]   Close All Browsers


TC_ITMWM_04607 Can cancel bill when operation status is unable_to_refund and buy COD (item A=Retail, item B=Market place) (Partial)
#    Comment Tag Duplicate
#    [Tags]   1_item_retail   1_item_market_place   TC5    ITMA-3220   ready  ITM-A-Sprint 2016S15   TC_ITMWM_04607    regression
    [Tags]  TC_ITMWM_04607    regression    WLS_High   1_item_retail   1_item_market_place    ITMA-3220   ready  ITM-A-Sprint 2016S15

    ${order_id}=   Create Order API - Guest buy 1 item for retail and 1 item for market place and pay successfully with COD
    LOGIN PCMS


    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item_id=${item_id}
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    #TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    1
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}     4
    [Teardown]  Close All Browsers

TC_ITMWM_04608 Can cancel bill when operation status is unable_to_refund and buy COD (item A=Retail, Item B=Market place))
    [Tags]  TC_ITMWM_04608    regression    WLS_High    WLS_High1_item_retail   1_item_market_place     ITMA-3220   ready  ITM-A-Sprint 2016S15
    ${order_id}=   Create Order API - Guest buy 1 item for retail and 1 item for market place and pay successfully with COD

    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Log To Console    item_id=${item_id}
    Open PCMS And Sync Order Together
    Order Shipment Item - Update Create At Change Time Backwords    ${item_id[0][0]}    32 days
    Order Shipment Item - Update Create At Change Time Backwords    ${item_id[1][0]}    32 days

    TrackOrder - Go To Order Detail Page    ${order_id}


    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Order Pending
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_none}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    order_pending
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_none}
    TrackOrder - Set Item status    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Set Item status    ${item_id[1][0]}    customer_cancelled
    TrackOrder - Click save all
    TrackOrder - Check Item Status on UI    ${item_id[0][0]}    Customer Cancelled
    TrackOrder - Check Payment Status on UI    ${item_id[0][0]}    Payment Pending
    TrackOrder - Check Operation Status on UI    ${item_id[0][0]}    ${operation_ui_unable_to_refund}
    TrackOrder - Check Item Status on DB    ${item_id[0][0]}    customer_cancelled
    TrackOrder - Check Payment Status on DB    ${item_id[0][0]}    payment_pending
    TrackOrder - Check Operation Status on DB    ${item_id[0][0]}    ${operation_db_unable_to_refund}
    #TrackOrder - Set Operation Status    ${item_id[0][0]}    ${operation_db_scm_require_doc}

    Order - Together Check Order Status In DB    ${order_id}    2
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[0][0]}     4
    Order - Together Check Item Status In DB     ${order_id}    ${item_id[1][0]}     4
    [Teardown]   Close All Browsers
