*** Settings ***
Resource   ${CURDIR}/web_element_shop.robot


*** Keywords ***
Go To Shop Management
    Go To   ${PCMS_URL}/shops

Click Open Menu Shop Management
    Wait Until Element Is Visible   ${xpath-link-menu-shop}
    Click Element                   ${xpath-link-menu-shop}

Click Shop Policy Button By Shop Code
    [Arguments]  ${shop_code}
    Wait Until Element Is Visible   //td[text()="${shop_code}"]/parent::tr/td/a${xpath-btn-shop-policy}
    Click Element                   //td[text()="${shop_code}"]/parent::tr/td/a${xpath-btn-shop-policy}

Search Shop Name in Shop Management
    [Arguments]    ${shop_name}
    Input Text    ${xpath-txt-search-shop-name}    ${shop_name}

Get Shop Name From Search Result
    ${shop_name}=   Get Text    ${xpath-lbl-shop-name}
    [Return]    ${shop_name}

Found Shop From Search Shop Management
    [Arguments]    ${shop_name}    ${search_shop_name}
    Should Be Equal As Strings    ${shop_name}    ${search_shop_name}

Not Found Shop From Search Shop Management
    ${not_found_shop}=    Get Text    ${xpath-lbl-not-found-shop}
    Log To Console    ${not_found_shop}
    Should Be Equal As Strings    ${not_found_shop}    No matching records found

Display Policy Button In Shop Management
    Wait Until Element Is Visible   ${xpath-btn-shop-policy}
    Element Should Be Visible       ${xpath-btn-shop-policy}

