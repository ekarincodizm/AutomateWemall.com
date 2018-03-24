*** Keywords ***
Input Type Api Search Order
    [Arguments]               ${typename}=null
    Set test variable         ${variable-typename}                type=${typename}

Input Name Api Search Order
    [Arguments]               ${value_name}=null
    Set test variable         ${variable-value_name}                value=${value_name}

Input Date Start Api Search Order
    [Arguments]               ${date_start}=null
    Set test variable         ${variable-date_start}                created_at_start=${date_start}

Input Date End Api Search Order
    [Arguments]               ${date_end}=
    Set test variable         ${variable-date_end}                created_at_end=${date_end}

Input Page Number
    [Arguments]               ${page_num}=null
    Set test variable         ${variable-page_num}                page=${page_num}

Input Payment Status Api Search Order
    [Arguments]               ${paytype}=
    Set test variable         ${variable-paytype}                paytype=${paytype}


Input Item Status Api Search Order
    [Arguments]               ${itemtype}=
    Set test variable         ${variable-itemtype}                itemtype=${itemtype}

Call Api Search Order
     ${body}=    Set Variable        ${order-live-agent}?${variable-typename}&${variable-value_name}&${variable-date_start}&${variable-date_end}&${variable-page_num}&${variable-paytype}&${variable-itemtype}
     create HTTP context             ${PCMS_URL_API}                http
     Next Request Should Succeed
     GET       ${body}
     ${variable-response}          Get response body
     Set test variable          ${variable-response}

Expect Api Search Order Success Status Is200
     ${result-status}=    Get Json Value               ${variable-response}                      /status
     ${result-code}=      Get Json Value               ${variable-response}                      /code
     ${result-total}=     Get Json Value               ${variable-response}                      /total
     ${result-status}=    Replace String               ${result-status}  "              ${EMPTY}
     ${result-code}=      Replace String               ${result-code}  "                ${EMPTY}
	 ${result-total}=     Replace String               ${result-total}  "               ${EMPTY}
     ${result}=  Create Dictionary       status=${result-status}             code=${result-code}              total=${result-total}
     should be equal as integers       ${result-code}                    200
     Should Be Equal As Strings        ${result-status}                 success

Expect Api Search Order 404 Notfound Status Is404
     ${result-message}=    Get Json Value               ${variable-response}                      /message
     ${result-code}=      Get Json Value               ${variable-response}                      /code
     ${result-message}=    Replace String               ${result-message}  "              ${EMPTY}
     ${result-code}=      Replace String               ${result-code}  "                ${EMPTY}
     ${result}=  Create Dictionary       message=${result-message}             code=${result-code}
     should be equal as integers       ${result-code}                    404
     Should Be Equal As Strings        ${result-message}                404 Not Found

Expect Api Search Order 422 Unprocessable Entity Is422
     ${result-message}=    Get Json Value               ${variable-response}                      /message
     ${result-code}=      Get Json Value               ${variable-response}                      /code
     ${result-message}=    Replace String               ${result-message}  "              ${EMPTY}
     ${result-code}=      Replace String               ${result-code}  "                ${EMPTY}
     ${result}=  Create Dictionary       message=${result-message}             code=${result-code}

     should be equal as integers       ${result-code}                    422
     Should Be Equal As Strings        ${result-message}                422 Unprocessable Entity