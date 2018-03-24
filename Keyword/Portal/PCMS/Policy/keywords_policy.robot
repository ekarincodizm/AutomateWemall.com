*** Settings ***
Resource   ${CURDIR}/web_element_policy.robot


*** Keywords ***

Go To Menu Policy Management
    Go To    ${PCMS_URL}/policies/assigns

Search Shop Policy In Policy Management
    [Arguments]    ${shop_name}
    Input Text    ${xpath-txt-search-policy-by-shop-name}    ${shop_name}

    Run Keyword If   '${BROWSER}' == 'chrome'   Click Element    ${xpath-select-shop-name-policy}
    Sleep    3s
    Click Element    ${xpath-btn-search-policy}

Get Shop Name From Search Policy Result
    ${shop_id}=     Get Text    ${xpath-lbl-search-policy}
    [Return]    ${shop_id}

Found Shop From Policy Management
    [Arguments]    ${shop_id}    ${search_policy_shop_id}
    Should Be Equal As Strings    ${shop_id}    ${search_policy_shop_id}

Not Found Shop From Policy Management
    [Arguments]    ${shop_name}
    Input Text    ${xpath-txt-search-policy-by-shop-name}    ${shop_name}
    Element Should Not Be Visible    ${xpath-select-shop-name-policy}
