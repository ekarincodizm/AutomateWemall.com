*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Resource          ../../Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Library           Collections
Resource          ../../Common/Keywords_Common.robot
Resource          ../../Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ../../Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ../../Portal/iTrueMart/ThankYou_page/Keywords_ThankYouPage.robot
Resource          ../../../Resource/WebElement/PC1_And_PC3/ITM.robot
Resource          ../../../Resource/WebElement/PC1_And_PC3/PCMS.robot
Resource          ../../Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource          ../../Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ../../../Keyword/Database/PCMS/keyword_pcms.robot
Resource          ../../Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ../../Common/keywords_wemall_common.robot
Resource          ../../../Resource/init.robot

*** Keywords ***
Purchase Item and Verify PC1
    [Arguments]    ${Text_PromotionName}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}
    ...    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_ProductName}    ${validate_CouponCode}    ${variance}
    Level D Go to level D with Product    ${Text_ProductName}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    ${Order_Id&Sale_ID}=    Buy Product Until Checkout3 Guest PC1    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}
    ...    ${Text_CWCardNo}    ${Text_CWCCV}    ${validate_CouponCode}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    [Return]    ${Order_Id}    ${Sale_Id}

Purchase Item and Verify PC3
    [Arguments]    ${Text_PromotionName}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}
    ...    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_ProductName}    ${validate_CouponCode}    ${variance}
    Level D Go to level D with Product    ${Text_ProductName}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    ${Order_Id&Sale_ID}=    Buy Product Until Checkout3 Guest PC3    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}
    ...    ${Text_CWCardNo}    ${Text_CWCCV}    ${validate_CouponCode}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    [Return]    ${Order_Id}    ${Sale_Id}

Buy Product Until Checkout3 Guest PC1
    [Arguments]    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}
    ...    ${Text_CWCCV}    ${Text_Code}
    Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Comment    Verify PC1    ${order_id}
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Return]    ${order_id}    ${Sale order _id}

Buy Product Until Checkout3 Guest PC3
    [Arguments]    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}
    ...    ${Text_CWCCV}    ${Text_Code}
    Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Comment    Verify PC3    ${order_id}
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Return]    ${order_id}    ${Sale order _id}

Verify Counpon Code
    [Arguments]    ${Text_PromotionName}
    Wait Until Element is ready and type    ${Filter_PromotionName}    ${Text_PromotionName}    10s
    ${element_Table_PromotionName}=    Replace String    ${Table_Selected_Promotion}    REPLACE_ME    ${Text_PromotionName}
    Wait Until Element Is Visible    ${element_Table_PromotionName}    20s
    ${URL}=    Selenium2Library.Get Element Attribute    ${element_Table_PromotionName}@href
    Wait Until Element is ready and click    ${element_Table_PromotionName}    10s
    Select Window    url=${URL}
    Wait Until Element Is Visible    ${Table_CounponList}    20s
    ${validate_CouponCode}=    Get Text    ${Table_CounponList}
    [Return]    ${validate_CouponCode}

Verify PC1
    [Arguments]    ${order_id}
    Connect DB ITM
    Row Count Is Equal To X    SELECT budget_type FROM order_promotion_logs WHERE budget_type LIKE 'PC1' AND `order_id` = ${order_id}    1

Verify PC3
    [Arguments]    ${order_id}
    Connect DB ITM
    Row Count Is Equal To X    SELECT budget_type FROM order_promotion_logs WHERE budget_type LIKE 'PC3' AND `order_id` = ${order_id}    1

Guest Fill Data and Submit Checkout2
    [Arguments]    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Run Keyword If    '//*[@id="add-address-btn"]'=='PASS'    Wait Until Element is ready and click    //*[@id="add-address-btn"]    60s
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    Keywords_Checkout2.Checkout2 - Wait Loading

Guest Fill Data and Submit Checkout1
    [Arguments]    ${Text_Email}
    Keywords_Checkout1.Checkout1 - Input Email    ${Text_Email}
    Keywords_Checkout1.Checkout1 - Click Next
    Keywords_Checkout1.Checkout1 - Wait Loading

Wait until Purchase Success Appear and retrieve Order ID
    # ThankYou - Close Popup
    ThankYou - Close Popup If Exist
    ${order_id}=    Get Text    ${Order_ID}
    [Return]    ${order_id}

Wait until Purchase Success Appear and retrieve Order ID For Mobile
    #    ThankYou - Close Popup Thor
    ${order_id}=    Get Text    ${Order_ID}
    [Return]    ${order_id}

Wait until Purchase Success Appear and retrieve Order ID For Member
    #    No pop-up
    ${order_id}=    Get Text    ${Order_ID}
    [Return]    ${order_id}

Fill Data and Submit Checkout3 with Payment channal CC
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Keywords_Checkout3.Checkout3 - Apply Coupon    ${Text_Code}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW

CC Payment Fill Data and Submit Checkout3
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    sleep    5
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Keywords_Checkout3.Checkout3 - Apply Coupon    ${Text_Code}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW

COD Payment Fill Data and Submit Checkout3
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    sleep    5
    Wait Until Element is ready and click    //*[@id="payment-channel-selection"]//a[@href="#channel-cod"]    60s
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Keywords_Checkout3.Checkout3 - Apply Coupon    ${Text_Code}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW

CS Payment Fill Data and Submit Checkout3
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    sleep    5
    Wait Until Element is ready and click    //*[@id="payment-channel-selection"]//a[@href="#channel-counterservice"]    60s
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Keywords_Checkout3.Checkout3 - Apply Coupon    ${Text_Code}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW

Wellet Payment Fill Data and Submit Checkout3
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    sleep    5
    Wait Until Element is ready and click    //*[@id="payment-channel-selection"]//a[@href="#channel-tmn_wallet"]    60s
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Keywords_Checkout3.Checkout3 - Apply Coupon    ${Text_Code}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW
