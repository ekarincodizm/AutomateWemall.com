*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Main_form/keywords_main_form.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Order_tracking/keywords_order_tracking.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot

Suite Teardown    Close All Browsers
Test Teardown    Close Browser
*** Variables ***
${SS_Email_Test}                 blackpantherautomate@gmail.com
${SS_Order_Test}                 100029390
${SS_Order_Guest}                100037016

*** Test Cases ***
TC_ITMWM_01173 Display error message if a shopper input email of order and payment status checking form is not exist in system
    [Tags]  TC_ITMWM_01173   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${SS_Email_Test}
    SS Main Form - Input Order Id               1
    SS Main Form - Click Next Step
    SS Order Tracking - Display Not Found Order     1   ${SS_Email_Test}

TC_ITMWM_01174 Display error message if a shopper input order id of order and payment status checking form is not exist in system
    [Tags]  TC_ITMWM_01174   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  asasas.-test@mail.com
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Not Found Order         ${var_order_id}         asasas.-test@mail.com

TC_ITMWM_01177 Return to live chat main menu when click back from order tracking
    [Tags]  TC_ITMWM_01177   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      ${SS_Order_Test}
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    SS Main Form - Do not Input Email
    SS Main Form - Do not Input Order Id
    SS Main Form - Do not Buttom Continue

TC_ITMWM_01178 Display order tracking with wow product [guest]
    [Tags]  TC_ITMWM_01178   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047120
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    SS Order Tracking - Display Order Id            ${var_order_id}
    SS Order Tracking - Display Order Date          ${var_order_date}
    SS Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Order Tracking - Display Item Details
    SS Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Order Tracking - Display Delivery Note
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Display Success Button
    SS Common - [Modal] Display Live Chat Button
    SS Common - [Modal] Do not display Submit Button

TC_ITMWM_01179 Display order tracking with normal product [member]
    [Tags]  TC_ITMWM_01179   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100012037
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    SS Order Tracking - Display Order Id            ${var_order_id}
    SS Order Tracking - Display Order Date          ${var_order_date}
    SS Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Order Tracking - Display Item Details
    SS Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Order Tracking - Display Delivery Note
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Display Success Button
    SS Common - [Modal] Display Live Chat Button
    SS Common - [Modal] Do not display Submit Button

TC_ITMWM_01180 Display order tracking with freebie product [guest]
    [Tags]  TC_ITMWM_01180   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047226
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    SS Order Tracking - Display Order Id            ${var_order_id}
    SS Order Tracking - Display Order Date          ${var_order_date}
    SS Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Order Tracking - Display Item Details
    SS Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Order Tracking - Display Delivery Note
    SS Order Tracking - Display Camp short description
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Display Success Button
    SS Common - [Modal] Display Live Chat Button
    SS Common - [Modal] Do not display Submit Button

TC_ITMWM_01181 Display order tracking with bundle product [member]
    [Tags]  TC_ITMWM_01181   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047377
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    SS Order Tracking - Display Order Id            ${var_order_id}
    SS Order Tracking - Display Order Date          ${var_order_date}
    SS Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Order Tracking - Display Item Details
    SS Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Order Tracking - Display Delivery Note
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Display Success Button
    SS Common - [Modal] Display Live Chat Button
    SS Common - [Modal] Do not display Submit Button

TC_ITMWM_01182 Display order tracking with MNP Sim [guest]
    [Tags]  TC_ITMWM_01182   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100000563
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    SS Order Tracking - Display Order Id            ${var_order_id}
    SS Order Tracking - Display Order Date          ${var_order_date}
    SS Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Order Tracking - Display Item Details
    SS Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Order Tracking - Display Delivery Note
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Display Success Button
    SS Common - [Modal] Display Live Chat Button
    SS Common - [Modal] Do not display Submit Button

TC_ITMWM_01183 Display order tracking with MNP Device [member]
    [Tags]  TC_ITMWM_01183   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      1065742
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    SS Order Tracking - Display Order Id            ${var_order_id}
    SS Order Tracking - Display Order Date          ${var_order_date}
    SS Order Tracking - Display Order Sub Total     ${var_order_sub_total}
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    SS Order Tracking - Display Item Details
    SS Order Tracking - Display Order Total Item        ${var_order_total_item}
    SS Order Tracking - Display Delivery Note
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Display Success Button
    SS Common - [Modal] Display Live Chat Button
    SS Common - [Modal] Do not display Submit Button

TC_ITMWM_01184 Order tracking with payment status = payment pending
    [Tags]  TC_ITMWM_01184   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100003833
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          รอการชำระเงิน
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          กำลังจัดเตรียมสินค้าที่คลัง
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01185 Display order tracking with payment status = success
    [Tags]  TC_ITMWM_01185   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047381
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          กำลังจัดเตรียมสินค้าที่คลัง
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01186 Display order tracking with payment status = expired
    [Tags]  TC_ITMWM_01186   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100003484
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          หมดระยะเวลาการชำระเงิน
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          ยังไม่มีสถานะการจัดส่ง
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01187 Display order tracking with payment status = failed
    [Tags]  TC_ITMWM_01187   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047387
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินไม่สำเร็จ
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          ยังไม่มีสถานะการจัดส่ง
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01188 Display order tracking with payment status = replacement pending
    [Tags]  TC_ITMWM_01188   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047393
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          อยู่ระหว่างดำเนินการเปลี่ยนสินค้า
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01189 Display order tracking with payment status = replacement rejected
    [Tags]  TC_ITMWM_01189   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047395
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          ปฏิเสธการเปลี่ยนสินค้า
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01190 Display order tracking with payment status = replacement complete
    [Tags]  TC_ITMWM_01190   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047398
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          เปลี่ยนสินค้าเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01191 Display order tracking with item status = cancel pending
    [Tags]  TC_ITMWM_01191   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100042957
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          ${EMPTY}
        \           SS Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}

TC_ITMWM_01192 Display order tracking with item status = customer cancelled
    [Tags]  TC_ITMWM_01192   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100043507
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          รายการสั่งซื้อถูกยกเลิกเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01193 Display order tracking with item status = activation failed
    [Tags]  TC_ITMWM_01193   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100042716
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          ลงทะเบียนไม่สำเร็จ
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01194 Display order tracking with item status = waiting for activation
    [Tags]  TC_ITMWM_01194   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100041851
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          รอการตรวจสอบจากเจ้าหน้าที่
        \           SS Order Tracking - [item] Display Tracking Number              ${item_id}          ยังไม่มีเลขที่พัสดุ
        \           SS Order Tracking - [item] Do not Display Tracking Number Button                    ${item_id}

TC_ITMWM_01195 Display order tracking with item status = shipped
    [Tags]  TC_ITMWM_01195   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100041256
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          อยู่ระหว่างการจัดส่ง
        \           SS Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}

TC_ITMWM_01196 Display order tracking with item status = delivered
    [Tags]  TC_ITMWM_01196   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100012037
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          ได้รับสินค้าเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}

TC_ITMWM_01197 Display order tracking with item status = failed delivery
    [Tags]  TC_ITMWM_01197   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100047406
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
        : FOR    ${item}    IN    @{var_order_shipment_items}
        \           ${item_id}=                     Get From Dictionary             ${item}             item_id
        \           ${tracking_number}=             Get From Dictionary             ${item}             tracking_number
        \           SS Order Tracking - [item] Display Payment Status Customer      ${item_id}          ชำระเงินเรียบร้อยแล้ว
        \           SS Order Tracking - [item] Display Item Status Customer         ${item_id}          ไม่สามารถติดต่อลูกค้าได้
        \           SS Order Tracking - [item] Display Tracking Details             ${item_id}          ${tracking_number}
