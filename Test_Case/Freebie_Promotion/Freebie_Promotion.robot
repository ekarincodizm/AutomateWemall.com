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
Resource          Test data.txt
Resource          ../../Keyword/Portal/iTrueMart/Header/Keywords_Header.txt
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/env_config.robot
Resource          ../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot

*** Test Cases ***
TC_ITMWME2E_00155 - User can buy a merchandise with freebie buy A get A
    [Tags]    ready
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00155 freebie 2E ${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00155 Campaign detail ${epoch}
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00155 ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    TC_ITMWME2E_00155 Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer}    Set Variable    BOAAC1111111
    ${Text_FreeVariantID}    Set Variable    BOAAC1111111
    ${pkey}    Set Variable    2854712898105
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Comment    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Comment    Maximize Browser Window
    Comment    Level D Select Product Variance in Level D    2
    Comment    Level D Click Add To Cart success case
    Comment    sleep    5
    Comment    Keywords_CartLightBox.Assert Freebie Item    HTC Desire Eye เครื่องศูนย์ HTC (จ่ายเต็ม หรือ ผ่อนชำระ) (น้ำเงิน)    15,900.00    2
    Comment    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Comment    Keywords_CartLightBox.Assert total cart item    3
    Comment    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Comment    Keywords_CartLightBox.Next to Checkout 1
    Comment    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Comment    sleep    5
    Comment    Keywords_MiniCart.Assert total cart item    3
    Comment    Keywords_MiniCart.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Comment    Keywords_MiniCart.Assert Freebie Item    HTC Desire Eye เครื่องศูนย์ HTC (จ่ายเต็ม หรือ ผ่อนชำระ) (น้ำเงิน)    2
    Comment    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Comment    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    Comment    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with CC payment    ${ITM_URL}/products/${pkey}.html    ${EMPTY}    กล้องดิจิตอล Bonzart รุ่น Ampel สีดำ    5,350.00    2
    ...    3    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    ...    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

TC_ITMWME2E_00154 - User can buy a merchandise with freebie buy A get B
    [Tags]    ready
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00154 Campaing ${epoch}
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00154 Freebie ${epoch}
    ${Text_CampaignDetail}    Set Variable    ${Test_Name} Campaign detail ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer}    Set Variable    ASAAA1127111
    ${Text_FreeVariantID}    Set Variable    ASAAA1127311
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Comment    Go to    ${ITM_URL}products/asus-zenfone-2-selfie-2795565691346.html
    Comment    Maximize Browser Window
    Comment    Level D Select Product Variance in Level D    1
    Comment    Level D Click Add To Cart success case
    Comment    sleep    5
    Comment    Keywords_CartLightBox.Assert Freebie Item    HTC Desire Eye เครื่องศูนย์ HTC (จ่ายเต็ม หรือ ผ่อนชำระ) (น้ำเงิน)    15,900.00    2
    Comment    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Comment    Keywords_CartLightBox.Assert total cart item    3
    Comment    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Comment    Keywords_CartLightBox.Next to Checkout 1
    Comment    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Comment    sleep    5
    Comment    Keywords_MiniCart.Assert total cart item    3
    Comment    Keywords_MiniCart.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Comment    Keywords_MiniCart.Assert Freebie Item    HTC Desire Eye เครื่องศูนย์ HTC (จ่ายเต็ม หรือ ผ่อนชำระ) (น้ำเงิน)    2
    Comment    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Comment    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    Comment    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with COD payment    ${ITM_URL}/products/asus-zenfone-2-selfie-2795565691346.html    1    Asus Zenfone 2 Selfie (Red)    8,999.00    2
    ...    3    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

TC_ITMWME2E_00156 - User can buy difference merchandises with difference freebies in one cart from difference campaign
    [Tags]    ready
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
    ${Text_Freebie_Identifyer_2}    Set Variable    ASAAA1117411
    ${Text_FreeVariantID_1}    Set Variable    SOAAA1115611
    ${Text_FreeVariantID_2}    Set Variable    SOAAA1115711
    ${Text_PeriTem}    Set Variable    1
    ${Text_RepeatTime}    Set Variable    5
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
    Go to    ${ITM_URL}/products/2807712739892.html
    Maximize Browser Window
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert Freebie Item    Sony Xperia T3 D5102 3G Single sim ศูนย์โซนี่ประเทศไทย (Purple)    11,990    2
    Keywords_CartLightBox.Assert total cart item    3
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Go to    ${ITM_URL}/products/2922643085136.html
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (5 ชิ้น)
    Keywords_CartLightBox.Assert Freebie Item    Sony Xperia T3 D5102 3G Single sim ศูนย์โซนี่ประเทศไทย (Purple)    11,990    2
    Keywords_CartLightBox.Assert Freebie Item    Sony Xperia T3 D5102 3G Single sim ศูนย์โซนี่ประเทศไทย (White)    11,990    3
    Keywords_CartLightBox.Assert total cart item    7
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_2
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Comment    Keywords_MiniCart.Assert total cart item    7
    Comment    Keywords_MiniCart.Assert Freebie amount    สินค้าฟรีของคุณ (5 ชิ้น)
    Comment    Keywords_MiniCart.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    2
    Comment    Keywords_MiniCart.Assert Freebie Item    Kingston แฟลชไดรฟ์ รุ่น DTSE9    3
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Checkout3 - COD payment same address and Submit
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Assert item on thank you page
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id_1}
    ...    AND    sleep    2
    ...    AND    Delete Campaign    ${campaign_id_2}

TC_ITMWME2E_00157 - User can buy difference merchandises with difference freebies in one cart from same campaign
    [Tags]    ready
    [Setup]    Delete Hold stock from DB by SKU    MYAAB1112111
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00157 freebie 2E ${epoch}
    ${Text_CampaignDetail}    Set Variable    Campaign detail ${epoch}
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer_1}    Set Variable    HTAAA1112211
    ${Text_Freebie_Identifyer_2}    Set Variable    MYAAB1112111
    ${Text_FreeVariantID_1}    Set Variable    MYAAB1111711
    ${Text_FreeVariantID_2}    Set Variable    KIAAC1111211
    ${Text_PeriTem}    Set Variable    1
    ${Text_RepeatTime}    Set Variable    5
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}_1    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}_1    ${Text_FreebieShortDesc}_1    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer_1}    ${Text_PeriTem}    ${Text_FreeVariantID_1}    2    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}_2    ${Text_FreebieShortDesc}_2    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer_2}    ${Text_PeriTem}    ${Text_FreeVariantID_2}    1    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Maximize Browser Window
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    4,990.00    2
    Keywords_CartLightBox.Assert total cart item    3
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Go to    http://www.itruemart-dev.com/products/smart-watch-mykronoz-zesplash-2624639764719.html
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (3 ชิ้น)
    Keywords_CartLightBox.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    4,990.00    2
    Keywords_CartLightBox.Assert Freebie Item    Kingston แฟลชไดรฟ์ รุ่น DTSE9    290.00    1
    Keywords_CartLightBox.Assert total cart item    5
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_2
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_MiniCart.Assert total cart item    5
    Keywords_MiniCart.Assert Freebie amount    สินค้าฟรีของคุณ (3 ชิ้น)
    Keywords_MiniCart.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    2
    Keywords_MiniCart.Assert Freebie Item    Kingston แฟลชไดรฟ์ รุ่น DTSE9    1
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Checkout3 - COD payment same address and Submit
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    sleep    2

TC_ITMWME2E_00158 - User can buy difference merchandises with same freebies in one cart
    [Tags]    ready
    [Setup]    Delete Hold stock from DB by SKU    MYAAB1112111
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00158 Campaign name ${epoch}
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00158 Freebie name ${epoch}
    ${Text_CampaignDetail}    Set Variable    Campaign detail ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer_1}    Set Variable    HTAAA1112211
    ${Text_Freebie_Identifyer_2}    Set Variable    MYAAB1112111
    ${Text_FreeVariantID_1}    Set Variable    KIAAC1111211
    ${Text_FreeVariantID_2}    Set Variable    KIAAC1111211
    ${Text_PeriTem}    Set Variable    1
    ${Text_RepeatTime}    Set Variable    5
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}_1    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}_1    ${Text_FreebieShortDesc}_1    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer_1}    ${Text_PeriTem}    ${Text_FreeVariantID_1}    2    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}_2    ${Text_FreebieShortDesc}_2    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer_2}    ${Text_PeriTem}    ${Text_FreeVariantID_2}    1    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Maximize Browser Window
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert Freebie Item    Kingston แฟลชไดรฟ์ รุ่น DTSE9    290.00    2
    Keywords_CartLightBox.Assert total cart item    3
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Go to    http://www.itruemart-dev.com/products/smart-watch-mykronoz-zesplash-2624639764719.html
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (3 ชิ้น)
    ${freebie1}    Create List    Kingston แฟลชไดรฟ์ รุ่น DTSE9    290.00    2
    ${freebie2}    Create List    Kingston แฟลชไดรฟ์ รุ่น DTSE9    290.00    1
    ${freebie_items_list}    Create List    ${freebie1}    ${freebie2}
    Keywords_CartLightBox.Assert Freebie Item list    ${freebie_items_list}
    Keywords_CartLightBox.Assert total cart item    5
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_1
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}_2
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    sleep    5
    Keywords_MiniCart.Assert total cart item    5
    Keywords_MiniCart.Assert Freebie amount    สินค้าฟรีของคุณ (3 ชิ้น)
    ${freebie1}    Create List    Kingston แฟลชไดรฟ์ รุ่น DTSE9    0.00    2
    ${freebie2}    Create List    Kingston แฟลชไดรฟ์ รุ่น DTSE9    0.00    1
    ${freebie_items_list}    Create List    ${freebie1}    ${freebie2}
    Keywords_MiniCart.Assert Freebie Item list    ${freebie_items_list}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Checkout3 - COD payment same address and Submit
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    sleep    2

TC_ITMWME2E_00159 - User can buy same merchandises with freebies from same campaigns
    [Tags]    ready
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00159 Campaign name ${epoch}
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00159 Freebie \ name ${epoch}
    ${Text_CampaignDetail}    Set Variable    Campaign detail ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer}    Set Variable    HTAAA1112211
    ${Text_FreeVariantID}    Set Variable    KIAAC1111211
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Comment    sleep    2
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Maximize Browser Window
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert Freebie Item    Kingston แฟลชไดรฟ์ รุ่น DTSE9    290.00    2
    Keywords_CartLightBox.Assert total cart item    3
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (4 ชิ้น)
    ${freebie1}    Create List    Kingston แฟลชไดรฟ์ รุ่น DTSE9    290.00    4
    ${freebie_items_list}    Create List    ${freebie1}
    sleep    5
    Keywords_CartLightBox.Assert Freebie Item list    ${freebie_items_list}
    Keywords_CartLightBox.Assert total cart item    6
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_MiniCart.Assert total cart item    6
    Keywords_MiniCart.Assert Freebie amount    สินค้าฟรีของคุณ (4 ชิ้น)
    ${freebie1}    Create List    Kingston แฟลชไดรฟ์ รุ่น DTSE9    0.00    4
    ${freebie_items_list}    Create List    ${freebie1}
    Keywords_MiniCart.Assert Freebie Item list    ${freebie_items_list}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Checkout3 - COD payment same address and Submit
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    sleep    2

TC_ITMWME2E_00160 - User cannot checkout cart if the cart contain a merchandise with out of stock freebie
    [Tags]    ready
    [Setup]    Delete Hold stock from DB by SKU    MYAAB1111711
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00160 freebie Campaign name ${epoch}
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00160 freebie name ${epoch}
    ${Text_CampaignDetail}    Set Variable    Campaign detail ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer}    Set Variable    HTAAA1112211
    ${Text_FreeVariantID}    Set Variable    MYAAB1111711
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    Update to specific stock number by SKUID    ${Text_FreeVariantID}    3
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html?no-cache=1
    Maximize Browser Window
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    4,990.00    2
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert total cart item    3
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html?no-cache=1
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart fail case
    Assert Add cart fail    ขออภัยค่ะ คุณไม่สามารถเพิ่มสินค้ารายการนี้ลงตะกร้าได้ เนื่องจากสินค้าแถมฟรีมีไม่เพียงพอ ขออภัยในความไม่สะดวกค่ะ
    Close add cart pop up
    Header - Click Cart icon
    sleep    5
    Keywords_CartLightBox.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    4,990.00    2
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert total cart item    3
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Update to Full stock    ${Text_FreeVariantID}

TC_ITMWME2E_00161 - User can checkout cart with over repeat freebie but will not get freebie
    [Tags]    ready
    ${epoch}=    Get current epoch time
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00161 freebie 2E ${epoch}
    ${Text_CampaignDetail}    Set Variable    Campaign detail ${epoch}
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_Freebie_Identifyer}    Set Variable    HTAAA1112211
    ${Text_FreeVariantID}    Set Variable    MYAAB1111711
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantQuantity}    Set Variable    1
    ${Text_RepeatTime}    Set Variable    2
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Maximize Browser Window
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    4,990.00    1
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (1 ชิ้น)
    Keywords_CartLightBox.Assert total cart item    2
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    4,990.00    2
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert total cart item    4
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Go to    http://www.itruemart-dev.com/products/htc-desire-eye-htc--2215014923867.html
    Level D Select Product Variance in Level D    1
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    4,990.00    2
    Keywords_CartLightBox.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_CartLightBox.Assert total cart item    5
    Keywords_CartLightBox.Assert Freebie short description    ${Text_FreebieShortDesc}
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    sleep    5
    Keywords_MiniCart.Assert total cart item    5
    Keywords_MiniCart.Assert Freebie amount    สินค้าฟรีของคุณ (2 ชิ้น)
    Keywords_MiniCart.Assert Freebie Item    Smart watch MyKronoz รุ่น ZeWatch2 (Blue)    2
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Checkout3 - COD payment same address and Submit
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Update to Full stock    ${Text_FreeVariantID}
    ...    AND    Update to Full stock    ${Text_Freebie_Identifyer}

Delete campaign
    ${tokens}=    Get access token
    ${access_token}    Get From List    ${tokens}    0
    ${refresh_token}    Get From List    ${tokens}    1
    ${response}    CAMP DELETE /cmp/v1/itm/campaigns/campaign_id    864    ${access_token}    ${refresh_token}

*** Keywords ***
