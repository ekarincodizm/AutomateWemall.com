*** Settings ***
Library           Collections
Library           DateTime
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/env_config.robot
Library           RequestsLibrary
Library           HttpLibrary
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Library           OperatingSystem    # Resource    ${CURDIR}/../../WebElement_Common.robot
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/database.robot
Resource          ${CURDIR}/../../../../Keyword/API/common/api_keywords.robot

*** Keywords ***
Adjust stock by inventory_id
    [Arguments]    ${inv_id}
    ${stock-data}=    Check Stock By Sku    ${inv_id}
    ${remain}=    Get Json Value    ${stock-data}    /remaining/${inv_id}
    Run Keyword If    '${remain}' < '1'    Adjust Out of Stock By Inventory ID    ${inv_id}    ${stock-data}

Adjust stock by inventory_id at least five
    [Arguments]    ${inv_id}
    ${stock-data}=    Check Stock By Sku    ${inv_id}
    ${remain}=    Get Json Value    ${stock-data}    /remaining/${inv_id}
    Run Keyword If    '${remain}' < '5'    Adjust Out of Stock By Inventory ID    ${inv_id}    ${stock-data}

Check Stock By Sku
    [Arguments]    ${sku}
    ${responseJSON}=    Send Http Get Request    ${PCMS_URL_API}    80    /api/45311375168544/inventories/${sku}/remaining    None
    ${data}=    Get Json Value    ${responseJSON}    /data
    Return From Keyword    ${data}

Adjust Out of Stock By Inventory ID
    [Arguments]    ${inv_id}    ${stock-data}
    ${hold}=    Get Json Value    ${stock-data}    /hold/${inv_id}
    ${hold}=    Convert To Integer    ${hold}
    ${new_total}=    Evaluate    ${hold}+200
    ${content}=    Set Variable    [{"sku":"${inv_id}","total" : "${new_total}","note": "Set Stock by Robot","quantity": "${hold}"}]
    ${responseJSON}=    Send Http Post Request    ${PCMS_URL_API}    80    /api/v4/stock/increase    ${content}    Content-type=application/json

Adjust Stock Remaining By Inventory ID
    [Arguments]    ${inventory_id}    ${remaining}
    ${stock}=    Check Stock By Sku    ${inventory_id}
    ${hold}=    Get Json Value    ${stock}    /hold/${inventory_id}
    ${new_total}=    Evaluate    ${hold}+${remaining}
    ${content}=    Set Variable    [{"sku":"${inventory_id}","total" : "${new_total}","note": "Set Stock by Robot","quantity": "${remaining}"}]
    ${responseJSON}=    Send Http Post Request    ${PCMS_URL_API}    ${PCMS_PORT}    /api/v4/stock/increase    ${content}    Content-type=application/json

Increase Stock By Inventory ID
    [Arguments]    ${inventory_id}    ${total}
    ${content}=    Set Variable    [{"sku":"${inventory_id}","total" : "${total}","note": "Set Stock by Robot","quantity": "${total}"}]
    ${responseJSON}=    Send Http Post Request    ${PCMS_URL_API}    ${PCMS_PORT}    /api/v4/stock/increase    ${content}    Content-type=application/json

Verify status in stock hold table
    [Arguments]    ${item_id}    ${status}
    ${status_in_stock_hold}=    get status in stock hold table    ${item_id}
    Should Be Equal    ${status_in_stock_hold}    ${status}

Increase Stock After Check Remaining Stock Number
    [Arguments]    ${inv_id}    ${stock_number}
    ${stock-data}=    Check Stock By Sku    ${inv_id}
    ${remain}=    Get Json Value    ${stock-data}    /remaining/${inv_id}
    Run Keyword If    '${remain}' < '${stock_number}'    Adjust Out of Stock By Inventory ID    ${inv_id}    ${stock-data}
