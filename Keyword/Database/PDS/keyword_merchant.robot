*** Keywords ***
Create Merchant Alias in DB
    [Arguments]    ${merchant_name}    ${merchant_code}   ${user_id}=35
    Connect DB ITM
    Execute Sql String    INSERT INTO `merchant_alias` (`id`, `name`, `merchant_code`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (NULL, ${merchant_name}, ${merchant_code}, ${user_id}, '2016-06-05 12:00:00', '2016-06-05 12:00:00', NULL)
    ${merchant_alias}=    Query    SELECT id FROM `merchant_alias` where `merchant_code` = ${merchant_code}
    Disconnect From Database

    ${merchant_alias_valid}=        Run Keyword and return status    Set Variable    ${merchant_alias[0][0]}
    ${return_merchant_alias}=        Set Variable If    ${merchant_alias_valid}        ${merchant_alias[0][0]}    ${EMPTY}
    Return From Keyword     ${return_merchant_alias}

Create Merchant in DB
    [Arguments]    ${shop_name}    ${shop_code}    ${merchant_type}="R"
    Connect DB ITM
    Execute Sql String    INSERT INTO `${DB_NAME}`.`shops`(`shop_id`,`name`,`shop_code`,`merchant_type`,`created_at`,`updated_at`)VALUES(null, ${shop_name}, ${shop_code}, ${merchant_type}, '2016-05-26 12:00:00', '2016-05-26 12:00:00');
    ${merchant_shop}=    Query    SELECT shop_id FROM `shops` where `shop_code` = ${shop_code}
    Disconnect From Database

    ${merchant_shop_valid}=        Run Keyword and return status    Set Variable    ${merchant_shop[0][0]}
    ${return_merchant_shop}=        Set Variable If    ${merchant_shop_valid}        ${merchant_shop[0][0]}    ${EMPTY}
    Return From Keyword     ${return_merchant_shop}

Delete Merchant Alias From DB
    [Arguments]    ${merchant_alias_id}
    Connect DB ITM
    Execute Sql String    DELETE FROM `${DB_NAME}`.`merchant_alias` WHERE `id`=${merchant_alias_id};
    Disconnect From Database

Delete Merchant From DB
    [Arguments]    ${merchant_id}
    Connect DB ITM
    Execute Sql String    DELETE FROM `${DB_NAME}`.`shops` WHERE `shop_id`=${merchant_id};
    Disconnect From Database

Get Number of Merchant Alias and Merchant in DB
    Connect DB ITM
    ${number_of_merchant_alias}=    Query    SELECT COUNT(*) AS number_of_merchant_alias FROM `${DB_NAME}`.`merchant_alias` where `name` IS NOT NULL
    ${number_of_merchants}=    Query    SELECT COUNT(*) AS number_of_merchants FROM `${DB_NAME}`.`shops` where `name` IS NOT NULL and `shop_code` IS NOT NULL
    Disconnect From Database
    ${total} =   Evaluate    ${number_of_merchant_alias[0][0]} + ${number_of_merchants[0][0]}
    Return From Keyword    ${total}

Get Merchant ID and Merchant Name from DB by Merchant Code
    [Arguments]    ${merchant_code}
    Connect DB ITM
    ${shop_id}=    Query    SELECT shop_id FROM `shops` WHERE `shop_code` = '${merchant_code}'
    ${shop_name}=    Query    SELECT name FROM `shops` WHERE `shop_code` = '${merchant_code}'
    Disconnect From Database

    ${shop_id_valid}=        Run Keyword and return status    Set Variable    ${shop_id[0][0]}
    ${return_shop_id}=        Set Variable If    ${shop_id_valid}        ${shop_id[0][0]}    ${EMPTY}

    ${shop_name_valid}=        Run Keyword and return status    Set Variable    ${shop_name[0][0]}
    ${return_shop_name}=        Set Variable If    ${shop_name_valid}        ${shop_name[0][0]}    ${EMPTY}

    Return From Keyword     ${return_shop_id}    ${return_shop_name}

Get Merchant Alias ID and Merchant Alias Name from DB by Merchant Code
    [Arguments]    ${merchant_code}
    Connect DB ITM
    ${alias_id}=    Query    SELECT id FROM `merchant_alias` WHERE `merchant_code` = '${merchant_code}'
    ${alias_name}=    Query    SELECT name FROM `merchant_alias` WHERE `merchant_code` = '${merchant_code}'
    Disconnect From Database

    ${alias_id_valid}=        Run Keyword and return status    Set Variable    ${alias_id[0][0]}
    ${return_alias_id}=        Set Variable If    ${alias_id_valid}        ${alias_id[0][0]}    ${EMPTY}

    ${alias_name_valid}=        Run Keyword and return status    Set Variable    ${alias_name[0][0]}
    ${return_alias_name}=        Set Variable If    ${alias_name_valid}        ${alias_name[0][0]}    ${EMPTY}

    Return From Keyword     ${return_alias_id}    ${return_alias_name}
