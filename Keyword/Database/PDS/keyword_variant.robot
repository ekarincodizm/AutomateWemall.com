*** Keywords ***
Get Inventory ID from DB by Product ID
    [Arguments]    ${product_id}
    Connect DB ITM
    ${inventory_id}=    Query    SELECT inventory_id from variants where `product_id`='${product_id}';
    Disconnect From Database
    ${list_inventory_id}=     Convert Tuple To List    ${inventory_id}
    Return From Keyword    ${list_inventory_id}

Get Normal Price from DB by Inventory ID
    [Arguments]    ${inventory_id}
    #arguments is list
    Log     inventory_id${inventory_id}
    ${list_normal_price}=    Create List
    Connect DB ITM
    :FOR    ${data}    IN    @{inventory_id}
    \    ${inventory_id}     Remove String     ${data}    '
    \    ${normal_price}=    Query    SELECT normal_price from variants where `inventory_id`='${inventory_id}';
    \    log    ${normal_price[0][0]}
    \    ${price}=    Query    SELECT price from variants where `inventory_id`='${inventory_id}';
    \    log    ${price[0][0]}
    \    ${valid_normal_price}=    Set Variable If      '${normal_price[0][0]}'=='0.00'    ${price[0][0]}    ${normal_price[0][0]}
    \    Append To List      ${list_normal_price}    ${valid_normal_price}
    \    log    list_normal_price=${list_normal_price}
    Disconnect From Database
    Return From Keyword    ${list_normal_price}

Get Special Price from DB by Inventory ID
    [Arguments]    ${inventory_id}
    #arguments is list
    Log     inventory_id${inventory_id}
    ${list_special_price}=    Create List
    Connect DB ITM
    :FOR    ${data}    IN    @{inventory_id}
    \    ${inventory_id}    Remove String     ${data}    '
    \    ${special_discounts}=    Query    SELECT discount_price from special_discounts where `inventory_id` = '${inventory_id}';
    \    ${price}=    Query    SELECT price from variants where `inventory_id`='${inventory_id}';
    \    ${valiad_special_price}=    Set Variable If    '${special_discounts}'=='()'     ${price[0][0]}     ${special_discounts[0][0]}
    \    Append To List     ${list_special_price}    ${valiad_special_price}
    Disconnect From Database
    Return From Keyword    ${list_special_price}

