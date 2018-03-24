*** Settings ***

*** Keyword ***
Create New Sku
    [Arguments]    ${request_data}
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${request_data}
    HttpLibrary.HTTP.POST    /api/v4/sku/create
    ${response}=    Get Response Body
    [Return]    ${response}

Delete Imported Sku By sku_id
    [Arguments]    ${sku_id}
    ${result}=    py_delete_sku_from_imported_material    ${sku_id}
    [Return]    ${result} #case: success = true, otherwise false

Is SKU Show On Dashboard
    [Arguments]    ${sku_id}
    Login Pcms
    ${result}=    Run Keyword And Return Status    Page Should Contain    ${sku_id}
    Close Browser
    [Return]    ${result}

Is SKU Show On Dashboard Only One
    [Arguments]    ${sku_id}
    Login Pcms
    ${count}=    Get Matching Xpath Count    //td[text()="${sku_id}"]
    Close Browser
    ${result}=    Run Keyword IF    ${count} > 1    Set Variable    ${False}
    ...    ELSE    Set Variable    ${True}
    [Return]    ${result}

Delete Variant By sku_id
    [Arguments]    ${sku_id}
    ${result}=    py_delete_sku_from_varaint    ${sku_id}
    [Return]    ${result} #case: success = true, otherwise false

Delete Product By Title
    [Arguments]    ${product_title}
    ${result}=    py_delete_product_by_title    ${product_title}
    [Return]    ${result} #case: success = true, otherwise false
