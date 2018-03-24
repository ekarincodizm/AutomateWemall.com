*** Keywords ***
PCMS API Send Email SMS - Call Api Resend Tracking
    [Arguments]         ${order_id}
    Create Http Context             ${PCMS_URL_API}    http
    Next Request Should Succeed
    HttpLibrary.HTTP.GET            ${RESEND-EMAIL-TRACKING}/?order_id=${order_id}
    ${response}=                    Get Response Body
    Log To Console                  ${response}
    ${code}=                        Get Json Value              ${response}         /code
    ${message}=                     Get Json Value              ${response}         /message
    Set Test Variable               ${var_send_msg_tracking_code}           ${code}
    Set Test Variable               ${var_send_msg_tracking_message}        ${message}

PCMS API Send Email SMS - Call Api Resend Thank You
    [Arguments]         ${order_id}
    Create Http Context             ${PCMS_URL_API}    http
    Next Request Should Succeed
    HttpLibrary.HTTP.GET            ${RESEND-EMAIL-THANK-YOU}/?order_id=${order_id}
    ${response}=                    Get Response Body
    Log To Console                  ${response}
    ${code}=                        Get Json Value              ${response}         /code
    ${message}=                     Get Json Value              ${response}         /message
    Set Test Variable               ${var_send_msg_tracking_code}           ${code}
    Set Test Variable               ${var_send_msg_tracking_message}        ${message}
