*** Settings ***
Library    HttpLibrary.HTTP

*** Keywords ***
Call Storefront API
    [Arguments]    ${request_data}
    Create Http Context    ${WWW_WEMALL}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${request_data}
    HttpLibrary.HTTP.POST    /api/storefront
    ${response}=    Get Response Body
    [Return]    ${response}

Get Storefront Info
    [Arguments]    ${request_data}={"merchant_code":"ROBOT"}
    ${response}=    Call Storefront API    ${request_data}
    [Return]    ${response}

Check Storefront Validity
    [Arguments]    ${response}    ${expected_merchant_name}="robot"    ${expected_merchant_name_translate}="robot"
    ${message}=    Get json value    ${response}    /message
    ${merchant_name}=    Get json value    ${response}    /data/name
    ${merchant_name_translate}=    Get json value    ${response}    /data/name_translate

    Should Be Equal    ${message}    "OK"
    Should Be Equal    ${merchant_name}    ${expected_merchant_name}
    Should Be Equal    ${merchant_name_translate}    ${expected_merchant_name_translate}

Get Non Existing Storefront Info
    ${response}=    Get Storefront Info    {"merchant_code":"NON-EXSITING-MERCHANT-CODE"}
    [Return]    ${response}

Check Storefront Validity For Non Existing Storefront
    [Arguments]    ${response}
    Check Storefront Validity    ${response}    null   null
