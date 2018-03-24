*** Settings ***
Resource          ../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../Keyword/Portal/PCMS/Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ../../Keyword/API/CAMP_API/keyword_camp.txt
Resource          ../../Keyword/Features/Freebie_Promotion/Create_Freebie.robot
Resource          ../../Resource/WebElement/CAMP/Camp_Freebie.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_promotion/Keywords_CAMP_Promotion.robot
Resource          ../../Resource/Config/${env}/env_config.robot
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/Portal/iTrueMart/registration_page/Keywords_registration.robot
Resource          Test_Data.robot
Resource          ../../Keyword/Portal/iTrueMart/Search_Page/Keywords_SearchPage.robot
Resource          ../../Keyword/Features/Create_Order/Create_order.txt
Resource          ../../Keyword/Portal/iTrueMart/Brand_page/Keywords_BrandPage.robot
Resource          ../../Keyword/Features/Sanity_Test/Keywords_Sanity_Production.robot
Resource          ../../Keyword/Portal/iTrueMart/Category_Page/Keywords_CategoryPage.robot
Resource          ../../Keyword/Features/User_login/User_login.robot
Resource          ../../Resource/init.robot

*** Test Cases ***
Purchase order with freebie and promotion code (COD)
    [Tags]    Sanity
    ${Product_PKEY}    Set Variable    2472478829170    #2513793618792
    ${Product_Color}    Set Variable    ${EMPTY}
    ${Product_Size}    Set Variable    ${EMPTY}
    ${Checkout2_Email}    Set Variable    Sanity@sanity.com
    ${Checkout2_Name}    Set Variable    Sanity
    ${Checkout2_Phone}    Set Variable    0811111111
    ${Checkout2_Address}    Set Variable    1234
    #Production
    ${coupon}    Set Variable    STARKB
    ${CAMP_campaign_ID}    Set Variable    26
    ${CAMP_promotion_ID}    Set Variable    1071
    ${PCMS_campaign_ID}    Set Variable    1063
    ${PCMS_Campaign_Name}    Set Variable    STARK Sanity Test
    ${SKU_ID}    Set Variable    FOAAB1111511
    ${Freebie_SKU_ID}    Set Variable    ALAAE1113411
    #Staging
    Comment    ${coupon}    Set Variable    STTP
    Comment    ${CAMP_campaign_ID}    Set Variable    6401
    Comment    ${CAMP_promotion_ID}    Set Variable    17311
    Comment    ${PCMS_campaign_ID}    Set Variable    1709
    Comment    ${PCMS_Campaign_Name}    Set Variable    Sanity (Don't Touch)
    Comment    ${SKU_ID}    Set Variable    TPAAA1111411
    Comment    ${Freebie_SKU_ID}    Set Variable    ONAAE1111611
    Active freebie promotion on CAMP    ${CAMP_campaign_ID}    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}    ${CAMP_promotion_ID}
    Active Promotion code on PCMS    ${PCMS_campaign_ID}    ${PCMS-HOST}    ${PCMS_Campaign_Name}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    User already login and Purchase Item with COD Payment    ${WEMALL_HOST}/products/item-${Product_PKEY}    \    \    ${Checkout2_Email}    ${Checkout2_Name}    ${Checkout2_Phone}
    ...    ${Checkout2_Address}    ${coupon}    ${PCMS_URL}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}    ${SKU_ID}
    ...    ${Freebie_SKU_ID}
    [Teardown]    Run Keywords    close all browsers
    ...    AND    deactive freebie promotion on CAMP    ${CAMP_campaign_ID}    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}
    ...    ${CAMP_promotion_ID}
    ...    AND    deactive Promotion code on PCMS    ${PCMS_campaign_ID}    ${PCMS-HOST}    ${PCMS_Campaign_Name}    ${PCMS_USERNAME}
    ...    ${PCMS_PASSWORD}

Purchase order with New user
    [Tags]    ready    Sanity
    ${Epoch}    Get current epoch time short
    ${Product_PKEY}    Set Variable    2867492834360    #2513793618792
    #ETC
    ${Product_Color}    Set Variable    ${EMPTY}
    ${Product_Size}    Set Variable    ${EMPTY}
    ${Checkout2_Email}    Set Variable    Sanity@sanity.com
    ${Checkout2_Name}    Set Variable    Sanity
    ${Checkout2_Phone}    Set Variable    0811111111
    ${Checkout2_Address}    Set Variable    1234
    ${New_email}    Set Variable    Sanity_${Epoch}@Sanity.com
    ${New_displayed_name}    Set Variable    Sanity
    ${New_password}    Set Variable    Sanity@1234
    Register New Account    ${New_email}    ${New_displayed_name}    ${New_password}    ${WEMALL_HOST}
    Keywords_Sanity_Production.New User Already Register And Purchase Item With CS Payment    ${WEMALL_HOST}/products/item-${Product_PKEY}    \    \    ${Checkout2_Email}    ${Checkout2_Name}    ${Checkout2_Phone}
    ...    ${Checkout2_Address}    ${PCMS-HOST}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    [Teardown]    Run Keywords    Close All Browsers

*** Keywords ***
