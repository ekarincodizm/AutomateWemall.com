*** Settings ***
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ../../Keyword/Features/Freebie_Promotion/Create_Freebie.robot
Resource          ../../Resource/WebElement/CAMP/Camp_Freebie.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_promotion/Keywords_CAMP_Promotion.robot
Resource          ../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource          ../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ../../Keyword/Portal/iTrueMart/Cart_pop_up/Keywords_CartPopUp.robot
Resource          ../../Keyword/Features/Create_Order/Create_order.txt
Resource          ../../Keyword/Portal/iTrueMart/Header/Keywords_Header.txt
Resource          ../../Resource/init.robot
Resource          ../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource          ../../Keyword/Common/keywords_wemall_common.robot
Resource          ../../Keyword/API/PCMS/Stock/keywords_stock.robot

*** Variables ***
${Text_Freebie_CategoryType}    ${Variant}
${Text_Note}      Note
${Text_Phone}     0911111111
${Text_Address}    Customer address
${Text_Code}      111
${Text_CWName}    CC Name
${Text_CWCardNo}    4111111111111111
${Text_CWCCV}     123
${Text_Name}      Customer name
${Text_Email}     test@dummy.com
${img_160x80}     \\160x80.jpg
${img_220x110}    \\220x110.jpg
${img_320x160}    \\320x160.jpg
#&{XPATH_COMMON}    ajax_loading=//div[@class="ajaxloading-widget-background"]    ajax_loading_mobile=//div[@class="ajaxloading-widget-background"]    live_chat=//*[@id="chatbar"]    # ...    ajax_loading_mobile=//div[contains(@class, "ajaxloading-widget-icon-container")]

*** Test Cases ***
User can buy difference merchandises with difference freebies in one cart from difference campaign
    [Tags]    QCT
    [Setup]    Delete Hold stock from DB by SKU    MYAAB1112111
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00156 freebie 2E ${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00156 Campaign detail ${epoch}
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00156 ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    TC_ITMWME2E_00156 Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    TC_ITMWME2E_00156 Freebie description ${epoch}
    ${Text_Freebie_Identifyer_1}    Set Variable    ASAAA1112411
    ${Text_Freebie_Identifyer_2}    Set Variable    URAAA1115511
    ${Text_FreeVariantID_1}    Set Variable    ASAAA1112411
    ${Text_FreeVariantID_2}    Set Variable    SKAAA1114411
    ${Text_PeriTem}    Set Variable    1
    ${Text_RepeatTime}    Set Variable    1
    Stock - Increase Stock By Inventory Id    ASAAA1112411
    Stock - Increase Stock By Inventory Id    URAAA1115511
    Stock - Increase Stock By Inventory Id    SKAAA1114411
    Stock - Increase Stock By Inventory Id    TRAAA1113211
    Go To Camp CMS
    ${campaign_id_1}    Create Campaign    ${Text_CampaignName}_1    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}_1    ${Text_FreebieShortDesc}_1    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer_1}    ${Text_PeriTem}    ${Text_FreeVariantID_1}    2    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Wait Until Element Is Visible    //*[@id="/itm/create-campaignSidebar"]
    ${campaign_id_2}    Create Campaign    ${Text_CampaignName}_2    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}_2    ${Text_FreebieShortDesc}_2    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer_2}    ${Text_PeriTem}    ${Text_FreeVariantID_2}    3    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Open Browser    ${ITM_URL}    chrome
    Maximize Browser Window
    Go to    ${ITM_URL}/products/2807712739892.html
    Wemall Common - Close Live Chat
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Go to    ${ITM_URL}/products/2947791572418.html
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_2
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Keywords_Checkout3.Checkout3 - COD payment same address and Submit
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Assert item on thank you page
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Delete Campaign    ${campaign_id_1}
    ...    AND    sleep    2
    ...    AND    Delete Campaign    ${campaign_id_2}

User can buy a merchandise with freebie
    [Tags]    QCT    TC2
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    QCT_${epoch}
    ${Text_CampaignDetail}    Set Variable    QCT Campaign detail ${epoch}
    ${Text_FreebieName}    Set Variable    QCT_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    QCT Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer}    Set Variable    URAAA1115511
    ${Text_FreeVariantID}    Set Variable    URAAA1115511
    ${pkey}    Set Variable    2947791572418
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    Stock - Increase Stock By Inventory Id    QCT_1626
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with COD payment    ${ITM_URL}/products/${pkey}.html    \    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}
    ...    ${Text_Phone}    ${Text_Address}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Delete Campaign    ${campaign_id}
