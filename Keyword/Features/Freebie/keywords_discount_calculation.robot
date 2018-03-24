*** Keyword ***
Discount Should Be Distributed correctly while last product is freebie
    [Arguments]    ${expected_discount}    ${path}
    File Should Exist    ${path}
    ${total_discount}=    Set Variable    0
    ${row}=    get row count from excel    ${path}
    : For    ${index}    IN RANGE    1    ${row}
    \    ${discount}=    get value from excel    ${path}    ${index}    64
    \    ${total_discount}=    Evaluate    ${total_discount} +${discount}
    \    ${content}=    get value from excel    ${path}    ${index}    54
    \    Run Keyword If    '${content}' == 'Freebie'    Should Be Equal As Numbers    ${discount}    0.0
    Should Be Equal As Numbers    ${total_discount}    ${expected_discount}