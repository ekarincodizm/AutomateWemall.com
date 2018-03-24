*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/A_number/keywords_a_number.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/API/LiveAgent/Tickets/keywords_tickets.robot

Test Teardown    Close All Browsers

*** Variables ***
${Order_Has_Tickets}        100060096

*** Test Cases ***
TC_ITMWM_07442 Add search by order id in the order information section
    [Tags]  TC_ITMWM_07442   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    A number - Open A number page and ready
    A number - Display Input Textbox Search Order
    A number - Display Input Button Search Order

TC_ITMWM_07443 Search the order information section of A number by order id
    [Tags]  TC_ITMWM_07443   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    Orders - Get Order on PCMS by Customer Tel                      ${var_anumber_mobile}
    A number - Open A number page and ready
    A number - Input Search Order and click search                  ${var_order_id}
    A number - Display Order Columns (Search)

TC_ITMWM_07444 Open the order detail page (PCMS web) in the new tab after click link from order id in the result searching section
    [Tags]  TC_ITMWM_07444   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    Orders - Get Order on PCMS by Customer Tel                      ${var_anumber_mobile}
    Login Pcms
    A number - Go To A number page and ready
    A number - Input Search Order and click search                  ${var_order_id}
    A number - Click Link Order to PCMS (Search)                    ${var_order_id}

TC_ITMWM_07445 Open the product detail page in the new tab after click link from item name in the result searching section
    [Tags]  TC_ITMWM_07445   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    Orders - Get Order on PCMS by Customer Tel                      ${var_anumber_mobile}
    A number - Open A number page and ready
    A number - Input Search Order and click search                  ${var_order_id}
    A number - Click View Order Items (Search)                      ${var_order_id}
    A number - Display Order Items Columns (Search)
    Orders - Get Order Shipment Item By Order Id                    ${var_order_id}
    A number - Display Order Items Details (Search)
    A number - [order item] Click Product Name and Display Level D (Search)

TC_ITMWM_07446 Open the ticket detail page in the new tab after click link from ticket id in the result searching section
    [Tags]  TC_ITMWM_07446   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    Set Test Variable           ${var_order_id}                     ${Order_Has_Tickets}
    LA Tickets - Api Get Tickes By Order ID                         ${var_order_id}
    A number - Open A number page and ready
    A number - Input Search Order and click search                  ${var_order_id}
    A number - Click View Ticket (Search)                           ${var_order_id}
    A number - Display Tickets Columns (Search)
    A number - Wait Loading Tickets Hide (Search)
    A number - Display Tickets List (Search)
    A number - [order item] Click Ticket ID and Display detail on Live Agent (Search)

TC_ITMWM_07447 Display error message if not input order id
    [Tags]  TC_ITMWM_07447   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    A number - Open A number page and ready
    A number - Click Search Order
    A number - Display Input Error                    * กรุณากรอก Order ID

TC_ITMWM_07448 Display error message if input order id is not existing in system
    [Tags]  TC_ITMWM_07448   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    A number - Open A number page and ready
    A number - Input Search Order and click search                  99
    A number - Display Order Columns (Search)
    A number - Display Result Error                 ไม่พบข้อมูล

TC_ITMWM_07450 Display error message if input order id is wrong format
    [Tags]  TC_ITMWM_07450   regression   ready   ITMMZ-1535   Support-Sprint-S3-2016
    A number - Open A number page and ready
    A number - Input Search Order                  test
    A number - Input Search has empty value
    A number - Input Search Order                  PCMS
    A number - Input Search has empty value
    A number - Input Search Order                  $%^#
    A number - Input Search has empty value
    A number - Input Search Order                  -
    A number - Input Search has empty value

