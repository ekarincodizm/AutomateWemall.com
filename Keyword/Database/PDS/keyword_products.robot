*** Keywords ***
Get Title from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_title}=    Query    SELECT title FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database

    ${product_title_valid}=        Run Keyword and return status    Set Variable    ${product_title[0][0]}
    ${return_product_title}=        Set Variable If    ${product_title_valid}        ${product_title[0][0]}    ${EMPTY}
    Return From Keyword     ${return_product_title}

Get Active Status from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_active_status}=    Query    SELECT active FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database

    ${product_active_status_valid}=        Run Keyword and return status    Set Variable    ${product_active_status[0][0]}
    ${return_product_active_status}=        Set Variable If    ${product_active_status_valid}        ${product_active_status[0][0]}    ${EMPTY}

    ${return_product_active_status_string}=    Set Variable If    '${return_product_active_status}'=='1'    Active    Disable
    Return From Keyword     ${return_product_active_status_string}

Get ID from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_id}=    Query    SELECT id FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database

    ${product_id_valid}=        Run Keyword and return status    Set Variable    ${product_id[0][0]}
    ${return_product_id}=        Set Variable If    ${product_id_valid}        ${product_id[0][0]}    ${EMPTY}
    Return From Keyword     ${return_product_id}

Get Stock Sums from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_id}=    Get ID from DB by Product pkey    ${product_pkey}
    ${variant_id}=    Query    SELECT inventory_id FROM `variants` where `product_id` = '${product_id[0][0]}'
    ${stock_sums}=    Query    SELECT quantity FROM `stock_sums` where `sku_id` = '${variant_id[0][0]}'
    Disconnect From Database

    ${stock_sums_valid}=        Run Keyword and return status    Set Variable    ${stock_sums[0][0]}
    ${return_stock_sums}=        Set Variable If    ${stock_sums_valid}        ${stock_sums[0][0]}    ${EMPTY}
    Return From Keyword     ${return_stock_sums}

Get Product Status from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_status}=    Query    SELECT status FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database
    ${product_status_valid}=        Run Keyword and return status    Set Variable    ${product_status[0][0]}
    ${return_product_status}=        Set Variable If    ${product_status_valid}        ${product_status[0][0]}    ${EMPTY}
    Return From Keyword     ${return_product_status}

Get Active Status Number from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_active_status}=    Query    SELECT active FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database

    ${product_active_status_valid}=        Run Keyword and return status    Set Variable    ${product_active_status[0][0]}
    ${return_product_active_status}=        Set Variable If    ${product_active_status_valid}        ${product_active_status[0][0]}    ${EMPTY}
    Return From Keyword     ${return_product_active_status}

Get Product ID from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_id}=    Query    SELECT id FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database
    Return From Keyword     ${product_id[0][0]}

Get Allow COD from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_allow_cod}=    Query    SELECT allow_cod FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database
    Return From Keyword     ${product_allow_cod[0][0]}

Get Active from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_active}=    Query    SELECT active FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database
    Return From Keyword     ${product_active[0][0]}

Get Installment from DB by product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_installment}=    Query    SELECT installment FROM `products` where `pkey` = '${product_pkey}'
    Disconnect From Database
    Return From Keyword     ${product_installment[0][0]}