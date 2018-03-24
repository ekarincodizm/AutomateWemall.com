*** Settings ***
Library           HttpLibrary.HTTP
Resource          ${CURDIR}/../../../../Keyword/Common/keywords_wemall_common.robot

*** Keywords ***
Increase Stock
    [Arguments]    ${SKU_ID}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    [{"sku":"${SKU_ID}","quantity":"${Stock_Quantity}","note":"${Stock_Note}","total":"${Stock_Total}"}]
    HttpLibrary.HTTP.POST    /api/v4/stock/increase
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Stock - Increase Stock 100 Qtys
    Log To Console    inv_1 ===> ${var.inventory_id_1}
    Log To Console    inv_2 ===> ${var.inventory_id_2}
    Stock - Increase Stock By Inventory Id    ${var.inventory_id_1}    100
    Stock - Increase Stock By Inventory Id    ${var.inventory_id_2}    100

Stock - Increase Stock By Inventory Id
    [Arguments]    ${inv_id}    ${qty}=10000
    Log To Console    increase inv_id ===> ${inv_id}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    [{"sku":"${inv_id}","quantity":"${qty}","note":"Stock Note","total":"${qty}"}]
    HttpLibrary.HTTP.POST    /api/v4/stock/increase
    ${result}=    Get Response Body

    Log to console   increase stock response = ${result}


    Wemall Common - Debug    ${result}    Response Body From Increase stock
    ${status}    Get Response Status
    Should Start With    ${status}    200

Stock - Increase Stock By Test Variable
    [Arguments]    ${qty}=100    ${inv_id}=None
    #${inv_id}=    Wemall Common - Get Value From Test Variable    inv_id
    Log To Console    increase inv ===> ${inv_id}
    Wemall Common - Debug    ${inv_id}    inv_id is in increase stock
    Run Keyword If    '${inv_id}' == 'DO_NOT_FOUND_KEY_IN_TEST_VARIABLE'    Return From Keyword    ${EMPTY}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    [{"sku":"${inv_id}","quantity":"${qty}","note":"Stock Note","total":"${qty}"}]
    HttpLibrary.HTTP.POST    /api/v4/stock/increase
    ${result}=    Get Response Body
    Wemall Common - Debug    ${result}    Response Body From Increase stock
    ${status}    Get Response Status
    Should Start With    ${status}    200
