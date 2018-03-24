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
Resource          ../../Portal/PCMS/Login/keywords_login.robot
Resource          ../../Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ../Freebie_Promotion/Create_Freebie.robot
Resource          ../../../Resource/init.robot

*** Keywords ***
User already login and Purchase Item with COD Payment
    [Arguments]    ${Lvl_D_Url}    ${Color}    ${Size}    ${Text_Email}    ${Text_Name}    ${Text_Phone}
    ...    ${Text_Address}    ${coupon}    ${PCMS_URL}    ${PCMS_Email}    ${PCMS_Password}    ${SKU_ID}
    ...    ${Freebie_SKU_ID}
    Open Browser    ${Lvl_D_Url}    chrome
    Maximize Browser Window
    Level D Select Product Variance in Level D    ${Color}    ${Size}
    Level D Click Add To Cart success case
    Keywords_CartLightBox.Next to Checkout 1
    Keywords_Sanity_Production.Guest Fill Data and Submit Checkout1    ${Text_Email}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    keywords_sanity_Production.Checkout3 - Apply Coupon    ${coupon}
    Keywords_Checkout3.Checkout3 - COD payment same address and Submit
    ${order_id}=    Keywords_Sanity_Production.Wait until Purchase Success Appear and retrieve Order ID
    Keywords_Sanity_Production.Sanity Login Pcms    ${PCMS_URL}    ${PCMS_Email}    ${PCMS_Password}
    Cancel Order    ${order_id}    ${SKU_ID}    ${Freebie_SKU_ID}

New user already register and Purchase Item with CS Payment
    [Arguments]    ${Lvl_D_Url}    ${Color}    ${Size}    ${Text_Email}    ${Text_Name}    ${Text_Phone}
    ...    ${Text_Address}    ${PCMS_URL}    ${PCMS_Email}    ${PCMS_Password}
    Go To    ${Lvl_D_Url}
    Maximize Browser Window
    Level D Select Product Variance in Level D    ${Color}    ${Size}
    Level D Click Add To Cart success case
    Keywords_CartLightBox.Next to Checkout 1
    Wait Until Element is ready and click    //*[@id="add-address-btn"]    60s
    Keywords_Sanity_Production.member Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_email}
    Member choose address and submit to check out 3
    Keywords_Sanity_Production.CS Payment Fill Data And Submit Checkout3
    ${order_id}=    Keywords_Sanity_Production.Wait until Purchase Success Appear and retrieve Order ID
    Keywords_Sanity_Production.Sanity Login Pcms    ${PCMS_URL}    ${PCMS_Email}    ${PCMS_Password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    [Return]    ${Order_Id}

Guest user Purchase Item with COD Payment
    [Arguments]    ${Text_ProductName}    ${validate_CouponCode}    ${variance}    ${size}    ${Text_Email}    ${Text_Name}
    ...    ${Text_Phone}    ${Text_Address}
    Level D Go to level D with Product    ${Text_ProductName}
    Maximize Browser Window
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    ${Order_Id&Sale_ID}=    Buy Product Until Checkout3 Guest    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${validate_CouponCode}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    [Return]    ${Order_Id}    ${Sale_Id}

FB user Purchase everyday wow with COD Payment
    [Arguments]    ${validate_CouponCode}    ${variance}    ${size}= ${EMPTY}
    Go To    ${ITM_URL}/everyday-wow
    Wait Until Element is ready and click    //*[@class="btn-order ec-promotion"]    60s
    ${element_Color}    Run Keyword And Return Status    Element Should Be Visible    //*[@class="style-types"][1]/div[contains(@class, "prd_control")]/ul[contains(@data-style-name, "color")]
    Run Keyword If    ${element_Color}    Level D Select Product Variance in Level D    ${variance}
    ${element_size}    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@class="prd_control options"]/ul[contains(@data-style-name, "size")]
    Run Keyword If    ${element_size}    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    ${Order_Id&Sale_ID}=    Keywords_Sanity_Production.User Already Login And Buy Product Until Checkout3 With COD payment    ${validate_CouponCode}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    [Return]    ${Order_Id}    ${Sale_Id}

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

Member choose address and submit to check out 3
    Wait Until Element is ready and click    //*[@type="submit"]    60s
    Wait Until Element Is Not Visible    //*[@class="ajaxloading-widget-icon-container ng-loading-icn"]    60s

member Fill Data and Submit Checkout2
    [Arguments]    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_email}
    Run Keyword If    '//*[@id="add-address-btn"]'=='PASS'    Wait Until Element is ready and click    //*[@id="add-address-btn"]    60s
    Checkout2 - Input Name    ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Run Keyword If    '${Text_email}'!='${EMPTY}'    Input Email    ${Text_email}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Checkout2 - Click Next
    Checkout2 - Wait Loading

Guest Fill Data and Submit Checkout1
    [Arguments]    ${Text_Email}
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Click Next
    Checkout1 - Wait Loading

Wait until Purchase Success Appear and retrieve Order ID
    #    ThankYou - Close Popup
    ${order_id}=    Get Text    ${Order_ID}
    [Return]    ${order_id}

Wait until Purchase Success Appear and retrieve Order ID For Member
    #    No pop-up
    ${order_id}=    Get Text    ${Order_ID}
    [Return]    ${order_id}

Fill Data and Submit Checkout3 with Payment channal CC
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    Checkout3 - Apply CCW    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Checkout3 - Apply Coupon    ${Text_Code}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW

CC Payment Fill Data and Submit Checkout3
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    sleep    5
    Checkout3 - Apply CCW    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Checkout3 - Apply Coupon    ${Text_Code}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW

COD Payment Fill Data and Submit Checkout3
    [Arguments]    ${Text_Code}
    sleep    5
    Wait Until Element is ready and click    //*[@id="payment-channel-selection"]//a[@href="#channel-cod"]    60s
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Checkout3 - Apply Coupon    ${Text_Code}
    Checkout3 - Click Submit

CS Payment Fill Data and Submit Checkout3
    Keywords_Checkout3.Checkout3 - Select payment channal    //*[@id="payment-channel-selection"]//a[@href="#channel-counterservice"]
    Wait Until Ajax Loading Is Not Visible
    Keywords_Checkout3.Checkout3 - Click Submit

Wellet Payment Fill Data and Submit Checkout3
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}    ${Text_Code}
    sleep    5
    Wait Until Element is ready and click    //*[@id="payment-channel-selection"]//a[@href="#channel-tmn_wallet"]    60s
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Checkout3 - Apply Coupon    ${Text_Code}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW

Assert Freebie Item
    [Arguments]    ${freebie_name}
    sleep    3
    ${freebie_item_element}    Replace String    ${CartLightBox_FreebieItemList}    REPLACE_ME    ${freebie_name}
    Wait Until Element Is Visible    ${freebie_item_element}    60
    Wait Until Page Does Not Contain    //*[contains(@class,'text-blink-active')]    30
    Should Not Be Empty    Get Webelement    ${freebie_item_element}
    Wait Until Element Is Visible    ${freebie_item_element}//*[@class='cart-box-price']    15

Input Email
    [Arguments]    ${Text_email}
    Wait Until Element is ready and type    //*[@id="email"]    ${Text_email}    60s

Cancel Order
    [Arguments]    ${order_id}    ${SKU_id}    ${Freebie_SKU_id}
    TrackOrder - Get Sale order ID    ${order_id}
    TrackOrder - Customer Cancel order    ${SKU_id}
    TrackOrder - Customer Cancel order reason    ${SKU_id}
    Run Keyword If    '${Freebie_SKU_id}' != '${EMPTY}'    Customer cancel freebie    ${Freebie_SKU_id}
    Wait Until Element is ready and click    //*[@id="save_all_item_status"]    60s
    Confirm Action

Verify item in cart
    Wait Until Element is ready and click    //*[@id="icn_cart_id"]    60s
    ${Have_item_in_cart}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@class="cart-box"]/div[2]//li[1]/a[contains(text(),"ลบรายการ")]    60s
    Run Keyword If    ${Have_item_in_cart}    delete item in cart
    Wait Until Element is ready and click    //*[@class="left cart-close"]    60s

delete item in cart
    Wait Until Element is ready and click    //*[@class="cart-box"]/div[2]//li[1]/a[contains(text(),"ลบรายการ")]    60s
    Confirm Action
    Wait Until Element Is Not Visible    //*[@class="ajaxloading-widget-icon-container ng-loading-icn"]    60s
    ${Have_item_in_cart}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@class="cart-box"]/div[2]//li[1]/a[contains(text(),"ลบรายการ")]    60s
    Run Keyword If    ${Have_item_in_cart}    Reattempt to delete item in cart

Reattempt to delete item in cart
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Wait Until Element is ready and click    //*[@class="cart-box"]/div[2]//li[1]/a[contains(text(),"ลบรายการ")]    60s
    \    Confirm Action
    \    Wait Until Element Is Not Visible    //*[@class="ajaxloading-widget-icon-container ng-loading-icn"]    60s
    \    ${Have_item_in_cart}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@class="cart-box"]/div[2]//li[1]/a[contains(text(),"ลบรายการ")]
    \    Run Keyword If    ${Have_item_in_cart}==${False}    Exit For Loop

Customer cancel freebie
    [Arguments]    ${Freebie_SKU_id}
    ${element_cancel_order}    Replace String    //table[@class="mws-datatable-fn mws-table dataTable"]//tr[2]/td[2][contains(text(),"${Freebie_SKU_id}")]/../td[9]/select    REPLACE_ME    ${Freebie_SKU_id}
    Wait Until Element is ready and click    ${element_cancel_order}    60s
    Wait Until Element is ready and click    ${element_cancel_order}/option[contains(text(),"Customer Cancelled")]    60s
    Select From List    ${element_cancel_order}    Customer Cancelled
    ${element_cancel_reason}=    Set Variable    //table[@id="orderShipmentTable"]//../td[2][contains(text(),"${Freebie_SKU_id}")]/../td[10]/select
    Wait Until Element Is Visible    ${element_cancel_reason}    60s
    Click Element    ${element_cancel_reason}/option[contains(text(),"Mismatch content")]

Checkout3 - Apply Coupon
    [Arguments]    ${coupon}
    sleep    5
    Click Element    ${Checkout3_InputCoupon}
    Input Text    ${Checkout3_InputCoupon}    ${coupon}
    Comment    Click Element    ${Checkout3_CCWName}
    keywords_sanity_Production.Retry Coupon Code    ${coupon}
    Wait Until Page Does Not Contain    ${Shipping_fee_blink}
    Click Element    ${Checkout3_SubmitCoupon}
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

Active Promotion code on PCMS
    [Arguments]    ${PCMS_campaign_ID}    ${PCMS_URL}    ${PCMS_Campaign_Name}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Keywords_Sanity_Production.Sanity Login Pcms    ${PCMS_URL}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Go To    ${PCMS_URL}/campaigns/edit/${PCMS_Campaign_ID}
    Wait Until Element is ready and click    //*[@type="radio"][@value="activate"]    60s
    Wait Until Element is ready and click    //*[@type="radio"][@value="activate"]    60s
    sleep    2s
    Wait Until Element is ready and click    //*[@type="submit"][@value="Save"]    60s
    Wait Until Element is ready and click    //*[@class="btn pull-right"]    60s
    Wait Until Element is ready and type    //*[@type="text"]    ${PCMS_Campaign_Name}    60s
    Wait Until Element Is Visible    //*[contains(@class,"odd")]//td[1]/../td[6]/img[@title="activate"]    60s
    Close Browser

Active freebie promotion on CAMP
    [Arguments]    ${campaign_ID}    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}    ${Promotion_ID}
    Keywords_Sanity_Production.Login Camp CMS    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}
    Go To    ${CAMPS-HOST}/itm/campaigns
    Wait Until Element is ready and type    //*[@id="campaignId"]    ${campaign_ID}    60s
    ${Campaign}=    Replace String    //*[@id="campaignListTable"]//td[3][contains(text(),"Replace_me")]/..//*[@id="checkboxSpan1"]    Replace_me    ${campaign_ID}
    sleep    4s
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Campaign}    20s
    \    sleep    4s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element is ready and click    //*[@id="filterBtn"]    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    Wait Until Element is ready and click    ${Campaign}    60s
    Wait Until Element is ready and click    //*[@id="enableBtn"]    60s
    sleep    4s
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Campaign}    20s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element Is Not Visible    //div[@class='spinner']    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    ${Campaign_enable}=    Replace String    //*[@id="campaignListTable"]//td[3][contains(text(),"Replace_me")]/../td[2]//i[contains(@style,"green")]    Replace_me    ${campaign_ID}
    Element Should Be Visible    ${Campaign_enable}
    ${Campaign_Promotion_btn}=    Replace String    //*[@id="campaignListTable"]//td[3][contains(text(),"Replace_me")]/../td[9]//div[contains(@id,"promotionBtn1")]    Replace_me    ${campaign_ID}
    Wait Until Element is ready and click    ${Campaign_Promotion_btn}    60s
    ${Promotion}=    Replace String    //*[@id="promotionListTable"]//td[4][contains(text(),"Replace_me")]/..//*[@id="checkboxSpan1"]    Replace_me    ${Promotion_ID}
    Wait Until Element is ready and click    ${Promotion}    60s
    Wait Until Element is ready and click    //*[@id="enableBtn"]    60s
    sleep    4s
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Promotion}    20s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element Is Not Visible    //div[@class='spinner']    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    ${Promotion_enable}=    Replace String    //*[@id="promotionListTable"]//td[4][contains(text(),"Replace_me")]/../td[3]//i[contains(@style,"green")]    Replace_me    ${Promotion_ID}
    Element Should Be Visible    ${Promotion_enable}
    Wait Until Element is ready and click    //*[@id="buildBtn"]    60s
    sleep    4s
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Promotion}    20s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element Is Not Visible    //div[@class='spinner']    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    Wait Until Element is ready and click    //*[@id="modalConfirmBtn"]    60s
    Wait Until Element Is Not Visible    //*[@id="modalConfirmBtn"]    60s
    Close Browser

Deactive Promotion code on PCMS
    [Arguments]    ${PCMS_campaign_ID}    ${PCMS_URL}    ${PCMS_Campaign_Name}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Keywords_Sanity_Production.Sanity Login Pcms    ${PCMS_URL}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Go To    ${PCMS_URL}/campaigns/edit/${PCMS_Campaign_ID}
    Wait Until Element is ready and click    //*[@type="radio"][@value="deactivate"]    60s
    Wait Until Element is ready and click    //*[@type="radio"][@value="deactivate"]    60s
    sleep    2s
    Wait Until Element is ready and click    //*[@type="submit"][@value="Save"]    60s
    Wait Until Element is ready and click    //*[@class="btn pull-right"]    60s
    Wait Until Element is ready and type    //*[@type="text"]    ${PCMS_Campaign_Name}    60s
    Wait Until Element Is Visible    //*[contains(@class,"odd")]//td[1]/../td[6]/img[@title="deactivate"]    60s
    Close Browser

Deactive freebie promotion on CAMP
    [Arguments]    ${campaign_ID}    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}    ${Promotion_ID}
    Keywords_Sanity_Production.Login Camp CMS    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}
    Go To    ${CAMPS-HOST}/itm/campaigns
    Wait Until Element is ready and type    //*[@id="campaignId"]    ${campaign_ID}    60s
    ${Campaign}=    Replace String    //*[@id="campaignListTable"]//td[3][contains(text(),"Replace_me")]/..//*[@id="checkboxSpan1"]    Replace_me    ${campaign_ID}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Campaign}    20s
    \    sleep    4s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element is ready and click    //*[@id="filterBtn"]    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    ${Campaign_Promotion_btn}=    Replace String    //*[@id="campaignListTable"]//td[3][contains(text(),"Replace_me")]/../td[9]//div[contains(@id,"promotionBtn1")]    Replace_me    ${campaign_ID}
    Wait Until Element is ready and click    ${Campaign_Promotion_btn}    60s
    ${Promotion}=    Replace String    //*[@id="promotionListTable"]//td[4][contains(text(),"Replace_me")]/..//*[@id="checkboxSpan1"]    Replace_me    ${Promotion_ID}
    Wait Until Element is ready and click    ${Promotion}    60s
    Wait Until Element is ready and click    //*[@id="disableBtn"]    60s
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Promotion}    20s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element Is Not Visible    //div[@class='spinner']    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    ${Promotion_disable}=    Replace String    //*[@id="promotionListTable"]//td[4][contains(text(),"Replace_me")]/../td[3]//i[contains(@style,"red")]    Replace_me    ${Promotion_ID}
    Element Should Be Visible    ${Promotion_disable}
    Wait Until Element is ready and click    //*[@id="buildBtn"]    60s
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Promotion}    20s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element Is Not Visible    //div[@class='spinner']    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    Wait Until Element is ready and click    //*[@id="modalConfirmBtn"]    60s
    Wait Until Element Is Not Visible    //*[@id="modalConfirmBtn"]    60s
    Go To    ${CAMPS-HOST}/itm/campaigns
    Wait Until Element is ready and type    //*[@id="campaignId"]    ${campaign_ID}    60s
    ${Campaign}=    Replace String    //*[@id="campaignListTable"]//td[3][contains(text(),"Replace_me")]/..//*[@id="checkboxSpan1"]    Replace_me    ${campaign_ID}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Campaign}    20s
    \    sleep    4s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element is ready and click    //*[@id="filterBtn"]    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    Wait Until Element is ready and click    ${Campaign}    60s
    Wait Until Element is ready and click    //*[@id="disableBtn"]    60s
    sleep    4s
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Campaign}    20s
    \    Run Keyword If    ${isCampSidebarVisible}==False    Wait Until Element Is Not Visible    //div[@class='spinner']    20s
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    ${Campaign_disable}=    Replace String    //*[@id="campaignListTable"]//td[3][contains(text(),"Replace_me")]/../td[2]//i[contains(@style,"red")]    Replace_me    ${campaign_ID}
    Element Should Be Visible    ${Campaign_disable}
    Close Browser

Pages access Wemall potal
    Open Browser    http://www.wemall.com/    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Location Should Be    http://www.wemall.com/
    Close Browser
    [Teardown]    Close All Browsers

Pages access Wemall potal mobile
    Open Browser    http://m.wemall.com/    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Location Should Be    http://m.wemall.com/
    [Teardown]    Close All Browsers

Pages access Wemall potal ENG version
    Open Browser    http://www.wemall.com/en/    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Wait Until Element Is Visible    //span[@ng-if="!login"][contains(text(),"My account")]    60s
    Location Should Be    http://www.wemall.com/en/
    [Teardown]    Close All Browsers

Pages access Wemall potal ENG version mobile
    Open Browser    http://m.wemall.com/en/    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Wait Until Element Is Visible    //span[@ng-if="!login"][contains(text(),"My account")]    60s
    Location Should Be    http://m.wemall.com/en/
    [Teardown]    Close All Browsers

Pages access Wemall itruemart
    Open Browser    http://www.wemall.com/itruemart    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //iwm-merchant-header[@merchant-code="ITM"]    60s
    Location Should Be    http://www.wemall.com/itruemart
    [Teardown]    Close All Browsers

Pages access Wemall itruemart mobile
    Open Browser    http://m.wemall.com/itruemart    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //div[@ng-bind-html="logo"]    60s
    Location Should Be    http://m.wemall.com/itruemart
    [Teardown]    Close All Browsers

Pages access Wemall search
    Open Browser    http://www.wemall.com/search2?q=iphone&per_page=72&page=1    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    60s
    Location Should Be    http://www.wemall.com/search2?q=iphone&per_page=72&page=1
    [Teardown]    Close All Browsers

Pages access Wemall search ENG version
    Open Browser    http://www.wemall.com/en/search2?q=iphone&per_page=72&page=1    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    60s
    Location Should Be    http://www.wemall.com/en/search2?q=iphone&per_page=72&page=1
    [Teardown]    Close All Browsers

Pages access Wemall search mobile
    Open Browser    http://m.wemall.com/search2?q=iphone    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    60s
    Wait Until Element Is Visible    //*[@class="btn-side-menu"]    60s
    Location Should Be    http://m.wemall.com/search2?q=iphone
    [Teardown]    Close All Browsers

Pages access Wemall potal HTTPS
    Open Browser    https://www.wemall.com/    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Location Should Be    https://www.wemall.com/
    [Teardown]    Close All Browsers

Pages access Wemall Shop
    Open Browser    http://www.wemall.com/shop/rastar    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Location Should Be    http://www.wemall.com/shop/rastar
    [Teardown]    Close All Browsers

Pages access Wemall Shop mobile
    Open Browser    http://m.wemall.com/shop/rastar    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Location Should Be    http://m.wemall.com/shop/rastar
    [Teardown]    Close All Browsers

Pages access Wemall search redirect from itm url
    Open Browser    http://www.itruemart.com/search2?q=iphone&per_page=60&page=1    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    60s
    Location Should Be    http://www.wemall.com/search2?q=iphone&per_page=72&page=1
    [Teardown]    Close All Browsers

Pages access Wemall search redirect from itm url mobile
    Open Browser    http://m.itruemart.com/search2?q=iphone    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    60s
    Wait Until Element Is Visible    //*[@class="btn-side-menu"]    60s
    Location Should Be    http://m.wemall.com/search2?q=iphone
    [Teardown]    Close All Browsers

Pages access Wemall redirect from itm
    Open Browser    http://www.itruemart.com    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    60s
    Location Should Be    http://www.wemall.com/itruemart/
    [Teardown]    Close All Browsers

Pages access Wemall wow
    Open Browser    http://www.wemall.com/everyday-wow    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="dd-title-name"][contains(text(),"Extra")]    60s
    Location Should Be    http://www.wemall.com/everyday-wow
    [Teardown]    Close All Browsers

Pages access Wemall level D
    Open Browser    http://www.wemall.com/products/iphone-6--2634908634297.html    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="order_container"]    60s
    Location Should Be    http://www.wemall.com/products/iphone-6--2634908634297.html
    [Teardown]    Close All Browsers

Pages access Wemall category
    Open Browser    http://www.wemall.com/category/ip-camera--wired-lan-3853272787829.html    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"CATEGORIES")]    60s
    Location Should Be    http://www.wemall.com/category/ip-camera--wired-lan-3853272787829.html
    [Teardown]    Close All Browsers

Pages access Wemall line campaign
    Open Browser    http://www.wemall.com/campaign/line?campaign=22    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@title="iTrueMart"]    60s
    Location Should Be    http://www.wemall.com/campaign/line?campaign=22
    [Teardown]    Close All Browsers

Pages access Wemall brand
    Open Browser    http://www.wemall.com//brand/samsung-6931849325692.html    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"CATEGORIES")]    60s
    Location Should Be    http://www.wemall.com//brand/samsung-6931849325692.html
    [Teardown]    Close All Browsers

Pages access Wemall truemove h
    Open Browser    http://www.wemall.com/truemove-h    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@name="action"]//*[contains(text(),"เลือกเบอร์สวย เบอร์มงคล")]    60s
    Location Should Be    http://www.wemall.com/truemove-h
    [Teardown]    Close All Browsers

Pages access Wemall itruemart All footer link
    Open Browser    http://www.wemall.com/itruemart    chrome
    Maximize Browser Window
    Wait Until Element is ready and click    //*[@id="footer"]//*[contains(text(),"ข้อมูลส่วนตัว")]    60s
    Comment    Wait Until Element Is Visible    //*[@class="title"]/*[@class="icon-user"]    60s
    Location Should Be    https://www.wemall.com/auth/login?continue=http://www.wemall.com/member/profile
    Go Back
    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="สินค้าในตะกร้า"]    60s
    Comment    Wait Until Element Is Visible    //span[@class="full_cart_title"]    60s
    Location Should Be    http://www.wemall.com/cart
    Go Back
    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="ข้อมูลสินค้าในตะกร้า และการจัดส่ง"]    60s
    Wait Until Element Is Visible    //*[@class="back-to-shopping"]    60s
    Location Should Be    http://www.wemall.com/cart
    Go Back
    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="คู่มือการชำระเงิน"]    60s
    Wait Until Element Is Visible    //*[@class="map"][contains(text(),"คู่มือการชำระเงิน")]    60s
    Location Should Be    http://www.wemall.com/payment-manual
    Go Back
    Comment    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="วิธีการใช้รหัสส่วนลด"]    60s
    Comment    Wait Until Element Is Visible    //*[@class="logo"]    60s
    Comment    Location Should Contain    http://support.wemall.com/
    Comment    Go Back
    Comment    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="คำถามที่พบบ่อย (FAQ)"]    60s
    Comment    Wait Until Element Is Visible    //*[@class="logo"]    60s
    Comment    Location Should Be    http://www.wemall.com/
    Comment    Go Back
    Comment    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="ผ่อนชำระ"]    60s
    Comment    Wait Until Element Is Visible    //*[@class="_iwm_"]/*[@merchant-code="ITM"]    60s
    Comment    Location Should Be    http://www.wemall.com/itruemart#
    Comment    Go Back
    Comment    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="บัตรเครดิต"]    60s
    Comment    Wait Until Element Is Visible    //*[@class="_iwm_"]/*[@merchant-code="ITM"]    60s
    Comment    Location Should Be    http://www.wemall.com/itruemart#
    Comment    Go Back
    Comment    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="เคาท์เตอร์เซอร์วิส"]    60s
    Comment    Wait Until Element Is Visible    //*[@class="_iwm_"]/*[@merchant-code="ITM"]    60s
    Comment    Location Should Be    http://www.wemall.com/itruemart#
    Comment    Go Back
    Comment    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="เก็บเงินปลายทาง"]    60s
    Comment    Wait Until Element Is Visible    //*[@class="_iwm_"]/*[@merchant-code="ITM"]    60s
    Comment    Location Should Be    http://www.wemall.com/itruemart#
    Comment    Go Back
    Comment    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="วอลเล็ท"]    60s
    Comment    Wait Until Element Is Visible    //*[@class="_iwm_"]/*[@merchant-code="ITM"]    60s
    Comment    Location Should Be    http://www.wemall.com/itruemart#
    Comment    Go Back
    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="นโยบายการรับประกันสินค้า"]    60s
    Wait Until Element Is Visible    //*[@class="policy-title"][contains(text(),"นโยบายการรับเปลี่ยน / คืนสินค้า")]    60s
    Location Should Be    http://www.wemall.com/policy/returnpolicy
    Go Back
    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="นโยบายการคืนเงิน"]    60s
    Wait Until Element Is Visible    //*[@class="policy-title"]    60s
    Location Should Be    http://www.wemall.com/policy/moneyback
    Go Back
    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="นโยบายการจัดส่งสินค้า"]    60s
    Wait Until Element Is Visible    //*[@class="policy-title"]    60s
    Location Should Be    http://www.wemall.com/policy/freedelivery
    Go Back
    Wait Until Element is ready and click    //*[@id="footer"]//*[text()="ติดต่อเรา"]    60s
    Wait Until Element Is Visible    //*[@class="header"]    60s
    Location Should Be    http://www.wemall.com/contact_us
    Go Back
    [Teardown]    Close All Browsers

Click Search Button
    Keywords_Sanity_Production.Click Then If Failed Wait and Click Again    //div[@class="btn-search icon-search"]

Search Product in WeMall
    [Arguments]    ${search_text}
    Keywords_Sanity_Production.Not Visible Then If Failed Wait and Check Is Visible Again    //*[@class="search-header-menu float-right"]//input[@ng-model="searchStr"]
    Input Text    //*[@class="search-header-menu float-right"]//input[@ng-model="searchStr"]    ${search_text}
    Keywords_Sanity_Production.Click Search Button

Verify Search Result Label
    [Arguments]    ${expected_search_words}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    jquery=#mi-searchCount    5s
    Run Keyword If    ${result} == False    Sleep    1s
    Wait Until Element Is Visible    jquery=#mi-searchCount    30
    ${actual_search_words}=    Get Text    jquery=#mi-searchCount b
    Should Be Equal As Strings    '${expected_search_words}'    ${actual_search_words}

Verify Search Box Exist
    Keywords_Sanity_Production.Not Visible Then If Failed Wait and Check Is Visible Again    //*[@class="search-header-menu float-right"]//input[@ng-model="searchStr"]

Verify Autosuggestion
    [Arguments]    ${search_text}    ${expected_search_text}
    Input Text    //*[@class="search-header-menu float-right"]//input[@ng-model="searchStr"]    ${search_text}
    Keywords_Sanity_Production.Not Visible Then If Failed Wait and Check Is Visible Again    //div[@class="angucomplete-dropdown"]
    Wait Until Element Is Visible    //div[1][@class='angucomplete-row ng-scope']//*[contains(text(),"${expected_search_text}")]    60s

Verify Search Text Box and Page Will Redirect to Search Page
    [Arguments]    ${search_text}
    Location Should Contain    search2?q=${search_text}
    Keywords_Sanity_Production.Get Value And Should Be Equal    //*[@class="search-header-menu float-right"]//input[@ng-model="searchStr"]    ${search_text}

Not Visible Then If Failed Wait and Check Is Visible Again
    [Arguments]    ${locator}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    5s
    Run Keyword If    ${result} == False    Sleep    1s
    Wait Until Element Is Visible    ${locator}    30s

Click Then If Failed Wait and Click Again
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    5s
    ${result}=    Run Keyword And Return Status    Click Element    ${locator}
    Run Keyword If    ${result} == False    Sleep    3s
    Run Keyword If    ${result} == False    Click Element    ${locator}

Get Value And Should Be Equal
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}    Get Value    ${locator}
    Should Be Equal As Strings    ${expected_text}    ${actual_text}

Retry Coupon Code
    [Arguments]    ${Text_Code}
    ${verify_coupon}    Get Text    ${Checkout3_InputCoupon}
    ${present_coupon}=    Run Keyword And Return Status    Should Be Empty    ${verify_coupon}
    Run Keyword If    ${present_coupon}    Keywords_Sanity_Production.Reattempt to Input Coupon Code    ${Text_Code}

Reattempt to Input Coupon Code
    [Arguments]    ${Text_Code}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Focus    ${Checkout3_InputCoupon}
    \    Input Text    ${Checkout3_InputCoupon}    ${Text_Code}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWName}
    \    ${verify_coupon}    Get Value    ${Checkout3_InputCoupon}
    \    Comment    ${verify_coupon}    Get Text    ${Checkout3_InputCoupon}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_coupon}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Sanity Login PCMS
    [Arguments]    ${PCMS_URL}    ${Text_Email}    ${Text_Password}
    Open Browser    ${PCMS_URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${xpath-login-email}
    Input Text    ${xpath-login-email}    ${Text_Email}
    Input Text    ${xpath-login-password}    ${Text_Password}
    Click Element    ${xpath-login-button}
    Wait Until Element Is Visible    ${xpath-link-logout}    30s

Login Camp CMS
    [Arguments]    ${MC_URL}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}
    Open Browser    ${MC_URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@id="login-username"]    60s
    Input Text    //*[@id="login-username"]    ${CAMP_USERNAME}
    Input Text    //*[@id="login-password"]    ${CAMP_PASSWORD}
    Click Element    //*[@id="btn-login"]
    Wait Until Element Is Visible    //*[@id="MERCHANT_CENTER_MENUS"]    60s
    Click Element    //*[@id="MERCHANT_CENTER_MENUS"]//a[contains(text(),'Promotion')]
    Wait Until Element Is Visible    //*[@id="submitBtn"]    60s
    Click Element    //*[@id="submitBtn"]
