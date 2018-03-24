*** Settings ***
Library           Selenium2Library
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Email - Verify email
    [Arguments]    ${order_id}    ${order_data}    ${count_of_data}    ${action_name}
    ${message_data}=    get message data    ${order_id}
    ${number}=    Get Length    ${message_data}
    Should Not Be Equal    ${message_data}    ${null}
    Should Be Equal As Strings    ${count_of_data}    ${number}
    Should Be Equal As Strings    ${message_data[0][3]}    ${action_name}
    Should Be Equal As Strings    ${message_data[0][1]}    gmail
    Should Be Equal    ${message_data[0][0]}    ${order_data[0]}
    Should Be Equal As Strings    ${message_data[0][2]}    sent

Email - Verify email and sms not be equal
    [Arguments]    ${order_id}    ${order_data}    ${count_of_data}
    ${message_data}=    get message data    ${order_id}    tracking-number
    ${number}=    Get Length    ${message_data}
    Should Not Be Equal    ${message_data}    ${null}
    Should Not Be Equal As Strings    ${count_of_data}    ${number}
