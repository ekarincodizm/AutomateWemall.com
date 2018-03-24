*** Keywords ***

Point API - Create Request Api Request Token
    [Arguments]     ${api_token}="a2603e7ab7cfba512c8e168640cf44"    ${user_id}="1234"    ${username}="j_atthapon@hotmail.com"    ${password}="99999999"    ${partner_id}="1"
    ${body_shipped}=    Get Binary File      ${CURDIR}/../../../../Resource/json/point/request_token.json

    ${body_shipped}=    Set Json Value       ${body_shipped}    /0/api_token    "${api_token}"
    ${body_shipped}=    Set Json Value       ${body_shipped}    /0/user_id    "${user_id}"
    ${body_shipped}=    Set Json Value       ${body_shipped}    /0/username    "${username}"
    ${body_shipped}=    Set Json Value       ${body_shipped}    /0/password    "${password}"
    ${body_shipped}=    Set Json Value       ${body_shipped}    /0/partner_id    "${partner_id}"

    Return From Keyword     ${body_shipped}