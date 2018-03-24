*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Footer/webelement_footer.robot

*** Keywords ***
Click Return Policy
    Wait Until Element Is Visible    ${M_FOOTER.lk_return_policy}    20
    Click Element    ${M_FOOTER.lk_return_policy}

Click Delivery Policy
    Wait Until Element Is Visible    ${M_FOOTER.lk_delivery_policy}    20
    Click Element    ${M_FOOTER.lk_delivery_policy}

Click Money Back Policy
    Wait Until Element Is Visible    ${M_FOOTER.lk_moneyback_policy}    20
    Click Element    ${M_FOOTER.lk_moneyback_policy}

Click Payment Manual
    Wait Until Element Is Visible    ${M_FOOTER.lk_payment_manual}    20
    Click Element    ${M_FOOTER.lk_payment_manual}
