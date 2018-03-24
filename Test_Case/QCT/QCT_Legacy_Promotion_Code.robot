*** Settings ***
Resource          ../../Resource/init.robot
Library           HttpLibrary.HTTP
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_pop_up/Keywords_CartPopUp.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ../../Keyword/Portal/KBANK_Payment_Gateway/Keyword_KBank_PaymentGateway.txt
Resource          ../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Resource/init.robot

*** Test Cases ***
TC_PC_00001 To verify promotion box display "This code can't be used due to code already expired" when "Code Expired"
    [Tags]    QCT    TC_PC_00001
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Email}    Set Variable    loki@loki.com
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    #   Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    sleep    3s
    #   Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIT
    Keywords_Checkout3.Checkout3 - Apply Coupon    WLSJ
    sleep    3s
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    5s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    รหัสคูปองพิเศษหมดอายุแล้ว
    Go To    ${WEMALL_URL_SSL}/en/checkout/step3
    sleep    3s
    #   Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIT
    Keywords_Checkout3.Checkout3 - Apply Coupon    WLSJ
    sleep    3s
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    5s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    Voucher is expired.
    [Teardown]    close browser

TC_PC_00002 To verify promotion box display "This code can't be used due to over limit" when "Code on period but has limited use"
    [Tags]
    ${Text_Email}    Set Variable    lokivip@test.com
    ${Text_Password}    Set Variable    true1234
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Checkout1 - Click Have Member Radio Button
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Input Password    ${Text_Password}
    Keywords_Checkout1.Checkout1 - Click Next
    Keywords_Checkout2.Checkout2 - Click Next Member
    #    Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    sleep    3s
    Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIV
    sleep    3s
    ${Text_Error_message}    Get Text    //*[@class="sub-control-label-total clr-7 text-ani-1"]
    Should Be Equal    ${Text_Error_message}    ส่วนลดเพิ่มเติมจากคูปองพิเศษ Code on period but has limited use
    Go To    ${WEMALL_URL_SSL}/en/checkout/step3
    sleep    3s
    Wait Until Element Is Visible    //*[@class="sub-control-label-total clr-7 text-ani-1"]    20s
    ${Text_Error_message}    Get Text    //*[@class="sub-control-label-total clr-7 text-ani-1"]
    Should Be Equal    ${Text_Error_message}    Voucher Discount Code on period but has limited use
    [Teardown]    close browser

TC_PC_00003 To verify promotion box display "This code can't be used due to amount is not reach minimum price" when "Code on period but not reach minimum price on cart"
    [Tags]    QCT    TC_PC_00003
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Email}    Set Variable    loki@loki.com
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    #    Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    sleep    3s
    #   Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIX
    Keywords_Checkout3.Checkout3 - Apply Coupon    WLST
    sleep    3s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    คุณไม่สามารถใช้รหัสคูปองได้ เนื่องจากยอดรวมทั้งตะกร้าหรือมูลค่าสินค้าขั้นต่ำ ไม่ตรงตามเงื่อนไขการใช้คูปอง
    Go To    ${WEMALL_URL_SSL}/en/checkout/step3
    sleep    3s
    #   Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIX
    Keywords_Checkout3.Checkout3 - Apply Coupon    WLST
    sleep    3s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    Cannot use voucher because these coupon is not accepted under the conditions.
    [Teardown]    close browser

TC_PC_00004 To verify promotion box display "This code can't be used due to not follow the conditions" when "Code on period but has no right to use (VIP code)"
    [Tags]
    ${Text_Email}    Set Variable    lokivip@test.com
    ${Text_Password}    Set Variable    true1234
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Keywords_Checkout1.Checkout1 - Click Have Member Radio Button
    Keywords_Checkout1.Checkout1 - Input Email    ${Text_Email}
    Keywords_Checkout1.Checkout1 - Input Password    ${Text_Password}
    Keywords_Checkout1.Checkout1 - Click Next
    Keywords_Checkout2.Checkout2 - Click Next Member
    #    Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    sleep    3s
    Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIA
    sleep    3s
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    20s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    รหัสคูปองนี้เป็นสิทธิพิเศษสำหรับลูกค้า VIP เท่านั้นค่ะ
    Go To    ${WEMALL_URL_SSL}/en/checkout/step3
    sleep    3s
    Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIA
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    20s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    This coupon is available to VIP members only.
    [Teardown]    close browser

TC_PC_00005 To verify promotion box display "This code already used" when "Code on period but already used (Unique code)"
    [Tags]    QCT
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Email}    Set Variable    loki@loki.com
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    #    Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    sleep    3s
    Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIG
    sleep    3s
    Wait Until Element Is Visible    //*[@class="sub-control-label-total clr-7 text-ani-1"]    20s
    ${Text_Error_message}    Get Text    //*[@class="sub-control-label-total clr-7 text-ani-1"]
    Should Be Equal    ${Text_Error_message}    ส่วนลดเพิ่มเติมจากคูปองพิเศษ Code on period but already used (Unique code)
    Go To    ${WEMALL_URL_SSL}/en/checkout/step3
    sleep    3s
    Wait Until Element Is Visible    //*[@class="sub-control-label-total clr-7 text-ani-1"]    20s
    ${Text_Error_message}    Get Text    //*[@class="sub-control-label-total clr-7 text-ani-1"]
    Should Be Equal    ${Text_Error_message}    Voucher Discount Code on period but already used (Unique code)
    [Teardown]    close browser

TC_PC_00006 To verify promotion box display "This code can't be used due to not follow the conditions" when "Code on period but is not on date & time to use (Specific date & time code)"
    [Tags]    QCT
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Email}    Set Variable    loki@loki.com
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    #    Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    sleep    3s
    Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIN
    sleep    3s
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    20s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    รหัสคูปองพิเศษไม่สามารถใช้ได้ เนื่องจากไม่ตรงตามเงื่อนไขการใช้งาน
    Go To    ${WEMALL_URL_SSL}/en/checkout/step3
    sleep    3s
    Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIN
    sleep    3s
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    20s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    Voucher is incorrect because do not match with the condition
    [Teardown]    close browser

TC_PC_00007 To verify promotion box display "This code can't be used with your item on cart" when "Any product on cart cannot use promotion code"
    [Tags]    QCT    TC_PC_00007
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Email}    Set Variable    loki@loki.com
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    #    Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    sleep    3s
    #   Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIR
    Keywords_Checkout3.Checkout3 - Apply Coupon    WLS7
    sleep    3s
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    5s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    คูปองพิเศษไม่สามารถใช้ร่วมกับสินค้าที่คุณสั่งซื้อ
    Go To    ${WEMALL_URL_SSL}/en/checkout/step3
    sleep    3s
    #   Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIR
    Keywords_Checkout3.Checkout3 - Apply Coupon    WLS7
    sleep    3s
    Wait Until Element Is Visible    //*[@id="coupon_code_error"]    5s
    ${Text_Error_message}    Get Text    //*[@id="coupon_code_error"]
    Should Be Equal    ${Text_Error_message}    Voucher cannot be used with your order
    [Teardown]    close browser

TC_PC_00008 To verify Payment success and Code mark used after check out with used code on period
    [Tags]    QCT
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Email}    Set Variable    loki@loki.com
    ${inv_id}=    Set Variable    CHAAA1111511
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    #    Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    #   Keywords_Checkout3.Checkout3 - Apply Coupon    LOKIP
    Keywords_Checkout3.Checkout3 - Apply Coupon    WLSU
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW
    [Teardown]    close browser
