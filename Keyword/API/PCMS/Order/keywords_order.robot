*** Keyword ***
Call Api Get Order By Custormer Ref ID
    [Arguments]   ${customer_ref_id}  ${lang}=th
    ${order_data}=   Api Get Order   ${customer_ref_id}   mock_email@mail.com   0999999999   sso   ${lang}
    Set Test Variable   ${TV_order_data}   ${order_data}

Api Get Order
    [Arguments]    ${customer_ref_id}=mock_id  ${email}=mock_email@mail.com  ${phone}=0999999999  ${type}=sso  ${lang}=th  ${limit}=1  ${page}=1
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    HttpLibrary.HTTP.GET    /api/45311375168544/customers/orders?customer_ref_id=${customer_ref_id}&email=${email}&phone=${phone}&type=${type}&limit=${limit}&page=${page}&lang=${lang}
    ${response}=    Get Response Body
    # Log to console   Api Get Order=${response}
    [Return]    ${response}

Get Image Path URL Of Api Get Order
    [Arguments]   ${order}
    ${img}=   Get Json Value   ${order}   /data/orders/0/shipments/0/shipment_items/0/images
    ${img}=   Replace String   ${img}      "    ${EMPTY}
    log to console   image_path=${img}
    [return]   ${img}

Get Expect Delivery Min Of Api Get Order
    [Arguments]   ${order}=${TV_order_data}
    ${delivery_min}=   GetStringFromJson   ${order}   /data/orders/0/shipments/0/shipment_items/0/expected_delivery_min
    log to console   expected_delivery_min=${delivery_min}
    [return]   ${delivery_min}

Get Expect Delivery Max Of Api Get Order
    [Arguments]   ${order}=${TV_order_data}
    ${delivery_max}=   GetStringFromJson   ${order}   /data/orders/0/shipments/0/shipment_items/0/expected_delivery_max
    log to console   expected_delivery_max=${delivery_max}
    [return]   ${delivery_max}

Get Delivery Text Of Api Get Order
    [Arguments]   ${order}=${TV_order_data}
    ${delivery_text}=   GetStringFromJson   ${order}   /data/orders/0/delivery_text
    log to console   delivery_text=${delivery_text}
    [return]   ${delivery_text}

Delivery Date Min Should Be Equal
    [Arguments]   ${expect_delivery_min}    ${order}=${TV_order_data}
    ${delivery_min}=   Get Expect Delivery Min Of Api Get Order   ${order}
    Should Be Equal As Strings   ${expect_delivery_min}   ${delivery_min}

Delivery Date Max Should Be Equal
    [Arguments]   ${expect_delivery_max}    ${order}=${TV_order_data}
    ${delivery_max}=   Get Expect Delivery Max Of Api Get Order   ${order}
    Should Be Equal As Strings   ${expect_delivery_max}   ${delivery_max}

Delivery Text From Api Get Order Should Be Equal
    [Arguments]   ${expect_delivery_text}   ${order}=${TV_order_data}
    ${delivery_text}=         Get Delivery Text Of Api Get Order         ${order}
    Should Be Equal As Strings   ${delivery_text}   ${expect_delivery_text}

Update order status from order pending to pending shipment
    [Arguments]    ${order_id}    ${order_shipment_item_id}    ${pathJson}=${RESOURCE-PATH}/json
    Log Many    ${order_id}    ${order_shipment_item_id}
    ${request_body}=    Read Template File    ${pathJson}/updateOrder.json    order_id=${order_id}     order_shipment_item_id=${order_shipment_item_id}
      Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${request_body}
      Next Request May Not Succeed
    HttpLibrary.HTTP.Post    /api/v4/orders/update-status
    Response Status Code Should Equal    200
    ${response}=    Get Response Body
    ${item_status}=    Get Json Value and Convert to List    ${response}    /data/0/item_status
    Should Be Equal    ${item_status}    pending_shipment

Update orders status from order pending to pending shipment
    [Arguments]    ${order_id}    ${order_shipment_item_ids}    ${pathJson}=${RESOURCE-PATH}/json
    : For    ${item}    IN    @{order_shipment_item_ids}
    \    Update order status from order pending to pending shipment    ${order_id}    ${item}    ${pathJson}
