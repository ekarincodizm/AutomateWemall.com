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
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/Features/User_login/User_login.robot

*** Test Cases ***
Guest buy freebie product
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
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with CC payment    ${ITM_URL}/products/${pkey}.html    ${EMPTY}    กล้องดิจิตอล Bonzart รุ่น Ampel สีดำ    5,350.00    2
    ...    3    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    ...    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

Member buy products with CC payment
    ${Text_ProductName1}    Set Variable    2773544654216
    ${Text_ProductName2}    Set Variable    2773544654216
    ${Text_ProductName3}    Set Variable    dummy_pkey
    ${Text_ProductName4}    Set Variable    dummy_pkey
    ${Text_ProductName5}    Set Variable    dummy_pkey
    ${variance}    Set Variable    1
    ${size}    Set Variable
    ${Text_Email}    Set Variable    dummy@test.com
    ${Text_Name}    Set Variable    aaaaa
    ${Text_Phone}    Set Variable    0999999999
    ${Text_Address}    Set Variable    bbbbbbb
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
    Open Browser ITM-levelD    ${Text_ProductName1}
    Login_with_TrueID    oak@test.com    welcome
    Sleep    5s
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Level D Go to level D with Product    ${Text_ProductName2}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address
    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    close browser
    Login Pcms
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Teardown]    Run Keywords    close browser

Member buy products with COD payment
    ${Text_ProductName1}    Set Variable    2773544654216
    ${Text_ProductName2}    Set Variable    2773544654216
    ${Text_ProductName3}    Set Variable    dummy_pkey
    ${Text_ProductName4}    Set Variable    dummy_pkey
    ${Text_ProductName5}    Set Variable    dummy_pkey
    ${variance}    Set Variable    1
    ${size}    Set Variable
    ${Text_Email}    Set Variable    dummy@test.com
    ${Text_Name}    Set Variable    aaaaa
    ${Text_Phone}    Set Variable    0999999999
    ${Text_Address}    Set Variable    bbbbbbb
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
    Open Browser ITM-levelD    ${Text_ProductName1}
    Login_with_TrueID    oak@test.com    welcome
    Sleep    5s
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Level D Go to level D with Product    ${Text_ProductName2}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address
    COD Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    close browser
    Login Pcms
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Teardown]    close browser

Member buy products with CS payment
    ${Text_ProductName1}    Set Variable    2773544654216
    ${Text_ProductName2}    Set Variable    2773544654216
    ${Text_ProductName3}    Set Variable    dummy_pkey
    ${Text_ProductName4}    Set Variable    dummy_pkey
    ${Text_ProductName5}    Set Variable    dummy_pkey
    ${variance}    Set Variable    1
    ${size}    Set Variable
    ${Text_Email}    Set Variable    dummy@test.com
    ${Text_Name}    Set Variable    aaaaa
    ${Text_Phone}    Set Variable    0999999999
    ${Text_Address}    Set Variable    bbbbbbb
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
    Open Browser ITM-levelD    ${Text_ProductName1}
    Login_with_TrueID    oak@test.com    welcome
    Sleep    5s
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Level D Go to level D with Product    ${Text_ProductName2}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address
    CS Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    close browser
    Login Pcms
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Teardown]    close browser

Member buy products with Installment payment
    ${Text_ProductName1}    Set Variable    2773544654216
    ${Text_ProductName2}    Set Variable    2773544654216
    ${Text_ProductName3}    Set Variable    dummy_pkey
    ${Text_ProductName4}    Set Variable    dummy_pkey
    ${Text_ProductName5}    Set Variable    dummy_pkey
    ${variance}    Set Variable    1
    ${size}    Set Variable
    ${Text_Email}    Set Variable    dummy@test.com
    ${Text_Name}    Set Variable    aaaaa
    ${Text_Phone}    Set Variable    0999999999
    ${Text_Address}    Set Variable    bbbbbbb
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
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
    Level D Go to level D with Product    ${Text_ProductName1}
    Login_with_TrueID    oak@test.com    welcome
    Sleep    5s
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Level D Go to level D with Product    ${Text_ProductName2}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address
    Checkout3 - Installment payment and Submit    กสิกรไทย    2
    Fill in KBank CC payment gateway and submit    Master    ${Text_CWCardNo}    ${Text_CWCCV}    01    2026    ${Text_CWName}
    sleep    30
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    close browser
    Login Pcms
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Teardown]    close browser

Guest buy products with CC payment
    ${Text_ProductName1}    Set Variable    2773544654216
    ${Text_ProductName2}    Set Variable    2773544654216
    ${Text_ProductName3}    Set Variable    dummy_pkey
    ${Text_ProductName4}    Set Variable    dummy_pkey
    ${Text_ProductName5}    Set Variable    dummy_pkey
    ${variance}    Set Variable    1
    ${size}    Set Variable
    ${Text_Email}    Set Variable    dummy@test.com
    ${Text_Name}    Set Variable    aaaaa
    ${Text_Phone}    Set Variable    0999999999
    ${Text_Address}    Set Variable    bbbbbbb
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
    Open Browser ITM-levelD    ${Text_ProductName1}
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Level D Go to level D with Product    ${Text_ProductName2}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    close browser
    Login Pcms
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Teardown]    Run Keywords    close browser

FB Member buy products with CC payment
    ${Text_ProductName1}    Set Variable    2773544654216
    ${Text_ProductName2}    Set Variable    2773544654216
    ${Text_ProductName3}    Set Variable    dummy_pkey
    ${Text_ProductName4}    Set Variable    dummy_pkey
    ${Text_ProductName5}    Set Variable    dummy_pkey
    ${variance}    Set Variable    1
    ${size}    Set Variable
    ${Text_Email}    Set Variable    dummy@test.com
    ${Text_Name}    Set Variable    aaaaa
    ${Text_Phone}    Set Variable    0999999999
    ${Text_Address}    Set Variable    bbbbbbb
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
    ${Text_FBUsername}    Set Variable    dummy FB
    ${Text_FBPassword}    Set Variable    dummy password
    Open Browser ITM-levelD    ${Text_ProductName1}
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    5s
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Level D Go to level D with Product    ${Text_ProductName2}
    Maximize Browser Window
    Wemall Common - Close Live Chat
    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address
    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    close browser
    Login Pcms
    ${Sale order _id}=    TrackOrder - Get Sale order ID    ${order_id}
    [Teardown]    Run Keywords    close browser

*** Keywords ***
