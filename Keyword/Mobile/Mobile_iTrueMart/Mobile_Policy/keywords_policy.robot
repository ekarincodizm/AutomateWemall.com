*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Policy/webelement_policy.robot

*** Keywords ***
Mobile Policy - Select Return Policy Page
    [Arguments]    ${lang}=th    ${URL}=${ITM_URL}
    Run Keyword If    '${lang}'=='th'    Select Window    url=${URL}${return_policy_uri}
    ...    ELSE    Select Window    url=${URL}/${lang}${return_policy_uri}

Mobile Policy - Select Delivery Policy Page
    [Arguments]    ${lang}=th    ${URL}=${ITM_URL}
    Run Keyword If    '${lang}'=='th'    Select Window    url=${URL}${delivery_policy_uri}
    ...    ELSE    Select Window    url=${URL}/${lang}${delivery_policy_uri}

Mobile Policy - Select Money Back Policy Page
    [Arguments]    ${lang}=th    ${URL}=${ITM_URL}
    Run Keyword If    '${lang}'=='th'    Select Window    url=${URL}${moneyback_policy_uri}
    ...    ELSE    Select Window    url=${URL}/${lang}${moneyback_policy_uri}

Mobile Policy - Display Policy Page
    Wait Until Page Contains Element    ${M_POLICY.txt_content}    60
    Element Should Be Visible    ${M_POLICY.txt_content}
