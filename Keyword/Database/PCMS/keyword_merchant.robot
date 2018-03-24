*** Settings ***
Library           DatabaseLibrary
Library           String
Resource          ${CURDIR}../../../../Resource/Config/${ENV}/env_config.robot
Resource          ${CURDIR}../../../../Resource/Config/${ENV}/database.robot
Resource          ../../Common/Keywords_Common.robot

*** Variables ***
${shop_name_empty}         -
${shop_code_empty}         -

*** Keywords ***
Get Merchant Code and Name from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
	${product_id}=    Query    SELECT id FROM `products` where `pkey` = '${product_pkey}'
	${shop_id}=    Query    SELECT shop_id FROM `variants` WHERE `product_id` = '${product_id[0][0]}'
	${shop_name}=    Query    SELECT name FROM `shops` WHERE `shop_id` = '${shop_id[0][0]}'
	${shop_code}=    Query    SELECT shop_code FROM `shops` WHERE `shop_id` = '${shop_id[0][0]}'
	${length_code}=      Get Length     ${shop_code}
	${length_name}=      Get Length     ${shop_name}
	Run Keyword If    ${length_code} == 0
	...    Return From Keyword     ${shop_code_empty}    ${shop_name_empty}
	Run Keyword If    ${length_code} != 0
	...    Return From Keyword     ${shop_code[0][0]}    ${shop_name[0][0]}

Get Merchant Code and Name from DB by Inventory id
    [Arguments]    ${inventory_id}
    Connect DB ITM
    ${shop_id}=    Query    SELECT shop_id FROM `variants` WHERE `inventory_id` = '${inventory_id}'
    Log To Console    shop=${shop_id}
    ${shop_name}=    Query    SELECT name FROM `shops` WHERE `shop_id` = '${shop_id[0][0]}'
    Log To Console    shop_name=${shop_name}
    ${shop_code}=    Query    SELECT shop_code FROM `shops` WHERE `shop_id` = '${shop_id[0][0]}'
    Log To Console    shop_code=${shop_code}
    ${length_code}=      Get Length     ${shop_code}
	${length_name}=      Get Length     ${shop_name}
	Run Keyword If    ${length_code} == 0
	...    Return From Keyword     ${shop_code_empty}    ${shop_name_empty}
	Run Keyword If    ${length_code} != 0
	...    Return From Keyword     ${shop_code[0][0]}    ${shop_name[0][0]}

Get Product Alias Code and Name from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
	${product_id}=    Query    SELECT id FROM `products` where `pkey` = '${product_pkey}'
	${shop_id}=    Query    SELECT `merchant_alias`.* from `merchant_alias` inner join `product_merchant_alias` on `merchant_alias`.`id` = `product_merchant_alias`.`merchant_alias_id` where `merchant_alias`.`deleted_at` is null and `product_merchant_alias`.`product_id` = '${product_id[0][0]}'
  ${code_valid}=    Run Keyword and return status    Set Variable    ${shop_id[0][2]}
  ${name_valid}=    Run Keyword and return status    Set Variable    ${shop_id[0][1]}
  ${ret_code}=    Set Variable If    ${code_valid}    ${shop_id[0][2]}    ${EMPTY}
  ${ret_name}=    Set Variable If    ${code_valid}    ${shop_id[0][1]}    ${EMPTY}
	Return From Keyword    ${ret_code}    ${ret_name}

Get Shop ID from DB by Product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
	${product_id}=    Query    SELECT id FROM `products` where `pkey` = '${product_pkey}'
	${shop_id}=    Query    SELECT shop_id FROM `variants` WHERE `product_id` = '${product_id[0][0]}'
	Return From Keyword    ${shop_id[0][0]}

