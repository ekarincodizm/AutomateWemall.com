*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/Main_form/keywords_main_form.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/Order_tracking/keywords_order_tracking.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot

Suite Teardown    Close All Browsers
Test Teardown    Close Browser
*** Variables ***
${SS_Email_Test}                 blackpantherautomate@gmail.com

*** Test Cases ***
TC_ITMWM_01202 [Mobile] Display error message if a shopper input email of order and payment status checking form is not exist in system
    [Tags]  TC_ITMWM_01202   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther   blackpanther
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${SS_Email_Test}
    SS Mobile Main Form - Input Order Id               1
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Not Found Order     1   ${SS_Email_Test}

TC_ITMWM_01203 [Mobile] Display error message if a shopper input order id of order and payment status checking form is not exist in system
    [Tags]  TC_ITMWM_01203   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  asasas.-test@mail.com
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Not Found Order         ${var_order_id}         asasas.-test@mail.com

TC_ITMWM_01207 [Mobile] Display order tracking with wow product [guest]
    [Tags]  TC_ITMWM_01207   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047120
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    SS Mobile Order Tracking - Display Order Id            ${var_order_id}
    SS Mobile Order Tracking - Display Order Date          ${var_order_date}
    SS Mobile Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Mobile Order Tracking - Display Item Details
    SS Mobile Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Mobile Order Tracking - Display Delivery Note
    SS Mobile Main Form - Do not Input Email
    SS Mobile Main Form - Do not Input Order Id
    SS Mobile Main Form - Do not Buttom Continue
    SS Mobile Common - Display Check Success Button
    SS Mobile Common - Display Other Question Button

TC_ITMWM_01208 Display order tracking with normal product [member]
    [Tags]  TC_ITMWM_01208   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100012037
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    SS Mobile Order Tracking - Display Order Id            ${var_order_id}
    SS Mobile Order Tracking - Display Order Date          ${var_order_date}
    SS Mobile Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Mobile Order Tracking - Display Item Details
    SS Mobile Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Mobile Order Tracking - Display Delivery Note
    SS Mobile Common - Display Back Button
    SS Mobile Common - Display Check Success Button
    SS Mobile Common - Display Other Question Button

TC_ITMWM_01209 [Mobile] Display order tracking with freebie product [guest]
    [Tags]  TC_ITMWM_01209   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047226
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    SS Mobile Order Tracking - Display Order Id            ${var_order_id}
    SS Mobile Order Tracking - Display Order Date          ${var_order_date}
    SS Mobile Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Mobile Order Tracking - Display Item Details
    SS Mobile Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Mobile Order Tracking - Display Delivery Note
    SS Mobile Order Tracking - Display Camp short description
    SS Mobile Common - Display Back Button
    SS Mobile Common - Display Check Success Button
    SS Mobile Common - Display Other Question Button

TC_ITMWM_01210 [Mobile] Display order tracking with bundle product [member]
    [Tags]  TC_ITMWM_01210   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047377
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    SS Mobile Order Tracking - Display Order Id            ${var_order_id}
    SS Mobile Order Tracking - Display Order Date          ${var_order_date}
    SS Mobile Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Mobile Order Tracking - Display Item Details
    SS Mobile Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Mobile Order Tracking - Display Delivery Note
    SS Mobile Common - Display Back Button
    SS Mobile Common - Display Check Success Button
    SS Mobile Common - Display Other Question Button

TC_ITMWM_01211 [Mobile] Display order tracking with MNP Sim [guest]
    [Tags]  TC_ITMWM_01211   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100000563
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    SS Mobile Order Tracking - Display Order Id            ${var_order_id}
    SS Mobile Order Tracking - Display Order Date          ${var_order_date}
    SS Mobile Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Mobile Order Tracking - Display Item Details
    SS Mobile Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Mobile Order Tracking - Display Delivery Note
    SS Mobile Common - Display Back Button
    SS Mobile Common - Display Check Success Button
    SS Mobile Common - Display Other Question Button

TC_ITMWM_01212 [Mobile] Display order tracking with MNP Device [member]
    [Tags]  TC_ITMWM_01212   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      1065742
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    SS Mobile Order Tracking - Display Order Id            ${var_order_id}
    SS Mobile Order Tracking - Display Order Date          ${var_order_date}
    SS Mobile Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Mobile Order Tracking - Display Item Details
    SS Mobile Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Mobile Order Tracking - Display Delivery Note
    SS Mobile Common - Display Back Button
    SS Mobile Common - Display Check Success Button
    SS Mobile Common - Display Other Question Button

TC_ITMWM_01213 [Mobile] Order tracking with payment status = payment pending
    [Tags]  TC_ITMWM_01213   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100003833
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          รอการชำระเงิน
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          กำลังจัดเตรียมสินค้าที่คลัง
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01214 [Mobile] Display order tracking with payment status = success
    [Tags]  TC_ITMWM_01214   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047381
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          กำลังจัดเตรียมสินค้าที่คลัง
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01215 [Mobile] Display order tracking with payment status = expired
    [Tags]  TC_ITMWM_01215   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100003484
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          หมดระยะเวลาการชำระเงิน
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          ยังไม่มีสถานะการจัดส่ง
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01216 [Mobile] Display order tracking with payment status = failed
    [Tags]  TC_ITMWM_01216   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047387
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินไม่สำเร็จ
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          ยังไม่มีสถานะการจัดส่ง
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01217 [Mobile] Display order tracking with payment status = replacement pending
    [Tags]  TC_ITMWM_01217   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047393
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          อยู่ระหว่างดำเนินการเปลี่ยนสินค้า
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01218 [Mobile] Display order tracking with payment status = replacement rejected
    [Tags]  TC_ITMWM_01218   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047395
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          ปฏิเสธการเปลี่ยนสินค้า
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01219 [Mobile] Display order tracking with payment status = replacement complete
    [Tags]  TC_ITMWM_01219   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047398
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          เปลี่ยนสินค้าเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01220 [Mobile] Display order tracking with item status = cancel pending
    [Tags]  TC_ITMWM_01220   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100042957
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          ${EMPTY}
        \           SS Mobile Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}

TC_ITMWM_01221 [Mobile] Display order tracking with item status = customer cancelled
    [Tags]  TC_ITMWM_01221   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100043507
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          รายการสั่งซื้อถูกยกเลิกเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01222 [Mobile] Display order tracking with item status = activation failed
    [Tags]  TC_ITMWM_01222   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100042716
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          ลงทะเบียนไม่สำเร็จ
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01223 [Mobile] Display order tracking with item status = waiting for activation
    [Tags]  TC_ITMWM_01223   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100041851
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          รอการตรวจสอบจากเจ้าหน้าที่
        \           SS Mobile Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01224 [Mobile] Display order tracking with item status = shipped
    [Tags]  TC_ITMWM_01224   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100041256
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          อยู่ระหว่างการจัดส่ง
        \           SS Mobile Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}

TC_ITMWM_01225 [Mobile] Display order tracking with item status = delivered
    [Tags]  TC_ITMWM_01225   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100012037
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          ได้รับสินค้าเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}

TC_ITMWM_01226 [Mobile] Display order tracking with item status = failed delivery
    [Tags]  TC_ITMWM_01226   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047406
    SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Mobile Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Mobile Order Tracking - [item] Display Item Status Customer         ${item_id}          ไม่สามารถติดต่อลูกค้าได้
        \           SS Mobile Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}
