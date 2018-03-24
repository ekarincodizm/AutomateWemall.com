*** Settings ***
Resource          web_element_a_number.robot
Resource          ../../../Common/Keywords_Common.robot

*** Variables ***
${var_anumber_mobile_key}               n66YpJifoqmeow%3D%3D
${var_anumber_mobile}                   0837333396
${Anumber_PHP_AUTH_PW}                  admin_clt
${Anumber_PHP_AUTH_USER}                ;u,v]ot0Ut
${Anumber_URL}                          http://${Anumber_PHP_AUTH_PW}:${Anumber_PHP_AUTH_USER}@${SELF_SERVICE_URL_HTTP}/number/search?

*** Keywords ***
A number - Open A number page
    Open Browser                                ${Anumber_URL}mobile=${var_anumber_mobile_key}           ${BROWSER}

A number - Go To A number page
    Go To                                       ${Anumber_URL}mobile=${var_anumber_mobile_key}

A number - Open A number page and ready
    A number - Open A number page
    Wait Until Element Is Visible               ${A_number_Header}            15s
    Element Should Be Visible                   ${A_number_Header}

A number - Go To A number page and ready
    A number - Go To A number page
    Wait Until Element Is Visible               ${A_number_Header}            15s
    Element Should Be Visible                   ${A_number_Header}

A number - Display Input Textbox Search Order
    Wait Until Element Is Visible               ${A_number_Input_Text_Search_Order}            15s
    Element Should Be Visible                   ${A_number_Input_Text_Search_Order}

A number - Input Search Order
    [Arguments]         ${order_id}
    A number - Display Input Textbox Search Order
    Input Text          ${A_number_Input_Text_Search_Order}      ${order_id}

A number - Input Search Order and click search
    [Arguments]         ${order_id}
    A number - Display Input Textbox Search Order
    Input Text          ${A_number_Input_Text_Search_Order}      ${order_id}
    A number - Click Search Order

A number - Click Search Order
    A number - Display Input Button Search Order
    Click Element       ${A_number_Button_Search_Order}

A number - Input Search has empty value
    ${val}=             Get Value               ${A_number_Input_Text_Search_Order}
    Should Contain      ${val}            ${EMPTY}

A number - Display Input Button Search Order
    Wait Until Element Is Visible               ${A_number_Button_Search_Order}            15s
    Element Should Be Visible                   ${A_number_Button_Search_Order}

A number - Display Order Columns (Search)
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.no}                    15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.items_tickets}         15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.order_id}              15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.order_date}            15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.cyb_id}                15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.cus_address}           15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.pay_status}            15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.pay_ch}                15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_COL.total_price}           15s

A number - Display Order Items Columns (Search)
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_ITEMS_COL.item_id}          15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_ITEMS_COL.product_name}     15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_ITEMS_COL.product_price}    15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_ITEMS_COL.product_qty}      15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_ITEMS_COL.payment_status}   15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_ITEMS_COL.item_status}      15s

A number - Display Tickets Columns (Search)
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_TICKETS_COL.no}             15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_TICKETS_COL.dep}            15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_TICKETS_COL.title}          15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_TICKETS_COL.id}             15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_TICKETS_COL.status}         15s
    Wait Until Element Is Visible               ${XPATH_A_NUMBER_OS_TICKETS_COL.created}        15s

A number - Click View Order Items (Search)
    [Arguments]         ${order_id}
    ${icon_view_items}=          Replace string in WebElelment           ${A_number_OS_Btn_View_Items}                   ${order_id}_search
    Wait Until Element Is Visible           ${icon_view_items}           15s
    Click Element                           ${icon_view_items}

A number - Click View Ticket (Search)
    [Arguments]         ${order_id}
    ${icon_view_items}=          Replace string in WebElelment           ${A_number_OS_Btn_View_Ticket}                   ${order_id}_search
    Wait Until Element Is Visible           ${icon_view_items}           15s
    Click Element                           ${icon_view_items}

A number - Click View Order Items
    [Arguments]         ${order_id}
    Set Test Variable                       ${var_icon_view_order_id}                       ${order_id}
    Wait Until Element Is Visible           ${A_number_OS_Btn_View_Items}                   15s
    Click Element                           ${A_number_OS_Btn_View_Items}

A number - Click Link Order to PCMS (Search)
    [Arguments]         ${order_id}
    ${url_order_detail}=                    Convert To String                   ${PCMS_URL}/orders/detail/${order_id}
    ${element}=         Replace string in WebElelment       ${A_number_OS_Link_Order}         ${url_order_detail}
    Wait Until Element Is Visible           ${element}                   15s
    Click Element                           ${element}
    Select Window                           url=${url_order_detail}
    Location Should Contain                 ${url_order_detail}

A number - Display Order Items Details (Search)
    : FOR    ${item}    IN    @{var_order_shipment_items}
    \           ${item_id}=                     Get From Dictionary         ${item}       item_id
    \           ${item_id}=                     Convert To String           ${item_id}
    \           Set Test Variable               ${var_anumber_item_id}      ${item_id}
    \           ${item_name}=                   Get From Dictionary         ${item}       item_name
    \           ${quantity}=                    Get From Dictionary         ${item}       quantity
    \           ${item_price}=                  Get From Dictionary         ${item}       item_price
    \           ${payment_status}=              Get From Dictionary         ${item}       payment_status
    \           ${item_status}=                 Get From Dictionary         ${item}       item_status
    \           A number - [order item] Display Itme Id (Search)            ${item_id}
    \           A number - [order item] Display Product Name (Search)       ${item_name}
    \           A number - [order item] Display Product Price (Search)      ${item_price}
    \           A number - [order item] Display Product Qty (Search)        ${quantity}
    \           A number - [order item] Display Payment Status (Search)     ${payment_status}
    \           A number - [order item] Display Item Status (Search)        ${item_status}

A number - Display Tickets List (Search)
    ${tickets}=              evaluate           json.loads('''${var_la_tickets}''')    json
    : FOR       ${ticket}    IN    @{tickets}
    \           ${ticket_id}=                    Get From Dictionary            ${ticket}       code
    \           ${dep}=                          Get From Dictionary            ${ticket}       departmentname
    \           ${title}=                        Get From Dictionary            ${ticket}       subject
    \           Set Test Variable                ${var_anumber_ticket_id}       ${ticket_id}
    \           A number - [ticket item] Display Department Name (Search)               ${dep}
    \           A number - [ticket item] Display Ticket (Search)                        ${title}
    \           A number - [ticket item] Display Ticket ID (Search)                     ${ticket_id}
    \           A number - [ticket item] Display Status (Search)
    \           A number - [ticket item] Display Created At (Search)

A number - [order item] Display Itme Id (Search)
    [Arguments]     ${item_id}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_ITEMS.item_id}          ${var_anumber_item_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${item_id}

A number - [order item] Display Product Name (Search)
    [Arguments]     ${item_name}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_ITEMS.product_name}     ${var_anumber_item_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${item_name}

A number - [order item] Click Product Name and Display Level D (Search)
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_ITEMS.product_name}     ${var_anumber_item_id}
    Wait Until Element Is Visible        ${element}                     15s
    Click Element                        ${element}
    ${product_pkey}=                     Get Element Attribute          ${element}/a@data-product-pkey
    ${window_titles}                     Get Window Titles
    : FOR    ${title}    IN    @{window_titles}
    \                                    Select Window                  title=${title}
    ${current_url}=                      Get Location
    Should Contain                       ${current_url}                 ${product_pkey}

A number - [order item] Display Product Price (Search)
    [Arguments]     ${item_price}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_ITEMS.product_price}    ${var_anumber_item_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${item_price}

A number - [order item] Display Product Qty (Search)
    [Arguments]     ${quantity}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_ITEMS.product_qty}      ${var_anumber_item_id}
    Wait Until Element Is Visible           ${element}           15s
    ${quantity}=    Convert To String       ${quantity}
    Element Should Contain                  ${element}           ${quantity}

A number - [order item] Display Payment Status (Search)
    [Arguments]     ${payment_status}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_ITEMS.payment_status}   ${var_anumber_item_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${payment_status}

A number - [order item] Display Item Status (Search)
    [Arguments]     ${item_status}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_ITEMS.item_status}      ${var_anumber_item_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${item_status}

A number - Wait Loading Tickets Hide (Search)
    ${element}=         Replace string in WebElelment       ${A_number_OS_Loading_Ticket}       ${var_order_id}_search
    Wait Until Element Is Not Visible                       ${element}                          15s

A number - [ticket item] Display Department Name (Search)
    [Arguments]     ${departmentname}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_TICKETS.dep}     ${var_anumber_ticket_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${departmentname}

A number - [ticket item] Display Ticket (Search)
    [Arguments]     ${title}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_TICKETS.title}     ${var_anumber_ticket_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${title}

A number - [ticket item] Display Ticket ID (Search)
    [Arguments]     ${ticket_id}
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_TICKETS.id}     ${var_anumber_ticket_id}
    Wait Until Element Is Visible           ${element}           15s
    Element Should Contain                  ${element}           ${ticket_id}

A number - [ticket item] Display Status (Search)
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_TICKETS.status}     ${var_anumber_ticket_id}
    Wait Until Element Is Visible           ${element}           15s

A number - [ticket item] Display Created At (Search)
    ${element}=     Replace string in WebElelment   ${XPATH_A_NUMBER_OS_TICKETS.created}     ${var_anumber_ticket_id}
    Wait Until Element Is Visible           ${element}           15s

A number - [order item] Click Ticket ID and Display detail on Live Agent (Search)
    ${element}=                          Replace string in WebElelment   ${XPATH_A_NUMBER_OS_TICKETS.id}     ${var_anumber_ticket_id}
    Wait Until Element Is Visible        ${element}                     15s
    Click Element                        ${element}/a
    ${ticket_url}=                      Get Element Attribute          ${element}/a@href
    Select Window                       url=${ticket_url}
    Location Should Contain             ${ticket_url}

A number - Display Input Error
    [Arguments]     ${error_txt}
    Wait Until Element Is Visible        ${A_number_OS_Input_Error}                     15s
    Element Should Contain               ${A_number_OS_Input_Error}                     ${error_txt}

A number - Display Result Error
    [Arguments]     ${error_txt}
    Wait Until Element Is Visible        ${A_number_OS_Result_Error}                    15s
    Element Should Contain               ${A_number_OS_Result_Error}                    ${error_txt}
