*** Variables ***
${Text_CWName}     test
${Text_CWCardNo}   5555555555554444
${Text_Invalid_CWCardNo}   5555555555554442
${Text_CWCCV}      123

*** Keywords ***
Checkout CCW Success
    Go To   ${ITM_URL}/checkout/step2
    Checkout2 Click Next Member
    Wait Until Element Is Visible    //*[@id="ccw-info-name"]    60s
    Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
#    Sleep               15s
#    Confirm Action
    ${order_id}=           Thankyou - Get Order ID II
    [Return]    ${order_id}

Checkout CCW Failed
    Go To   ${ITM_URL}/checkout/step2
    Checkout2 Click Next Member
    Wait Until Element Is Visible    //*[@id="ccw-info-name"]    60s
    Checkout3 - Apply CCW    ${Text_CWName}    ${Text_Invalid_CWCardNo}    ${Text_CWCCV}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
#    Sleep               15s
#    Confirm Action
    ${order_id}=           Thankyou - Get Order ID II
    [Return]    ${order_id}

Checkout CCW Expired
    Go To   ${ITM_URL}/checkout/step2
    Checkout2 Click Next Member
    Wait Until Element Is Visible    //*[@id="ccw-info-name"]    60s
    Checkout3 - Apply CCW    ${Text_CWName}    ${Text_Invalid_CWCardNo}    ${Text_CWCCV}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
#    Sleep               8s
#    Close Browser

Remove Test Data on Truemoveh Order Verifys
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number                 ${var_data_tel}