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
Resource          ../../Resource/Config/${env}/Sanity_Test_data.robot

*** Test Cases ***
TC_SANITY_00001
    [Tags]    123
    ${CAMP_USERNAME}    Set Variable    test
    ${CAMP_PASSWORD}    Set Variable    password
    ${PCMS_USERNAME}    Set Variable    admin@domain.com
    ${PCMS_PASSWORD}    Set Variable    12345
    ${CAMPS-HOST}    Set Variable    http://campaign-cms.itruemart-dev.com
    ${PCMS-HOST}    Set Variable    http://pcms.itruemart-dev.com/
    ${WEMALL_HOST}    Set Variable    http://www.wemall-dev.com/
    ${Product_PKEY}    Set Variable    2513793618792
    ${Product_Color}    Set Variable    ${EMPTY}
    ${Product_Size}    Set Variable    ${EMPTY}
    ${Checkout2_Email}    Set Variable    Sanity@sanity.com
    ${Checkout2_Name}    Set Variable    Sanity
    ${Checkout2_Phone}    Set Variable    0811111111
    ${Checkout2_Address}    Set Variable    1234
    ${coupon}    Set Variable    STTP
    ${CAMP_campaign_ID}    Set Variable    6401
    ${CAMP_promotion_ID}    Set Variable    17311
    ${PCMS_campaign_ID}    Set Variable    1709
    ${PCMS_Campaign_Name}    Set Variable    Sanity (Don't Touch)
    Active freebie promotion on CAMP    ${CAMP_campaign_ID}    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}    ${CAMP_promotion_ID}
    Active Promotion code on PCMS    ${PCMS_campaign_ID}    ${PCMS-HOST}    ${PCMS_Campaign_Name}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    User already login and Purchase Item with COD Payment    ${WEMALL_HOST}/products/item-${Product_PKEY}    ${Product_Color}    ${Product_Size}    ${Checkout2_Email}    ${Checkout2_Name}    ${Checkout2_Phone}
    ...    ${Checkout2_Address}    ${coupon}    ${PCMS_URL}    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    [Teardown]    Run Keywords    close all browsers
    ...    AND    deactive freebie promotion on CAMP    ${CAMP_campaign_ID}    ${CAMPS-HOST}    ${CAMP_USERNAME}    ${CAMP_PASSWORD}
    ...    ${CAMP_promotion_ID}
    ...    AND    deactive Promotion code on PCMS    ${PCMS_campaign_ID}    ${PCMS-HOST}    ${PCMS_Campaign_Name}    ${PCMS_USERNAME}
    ...    ${PCMS_PASSWORD}

TC_SANITY_00002
    [Documentation]    Purchase product with new user
    ...    - PCMS create unique code
    ...    - PCMS create PC3
    ...    - Guest user
    ...    - Purchase with COD
    [Tags]    regression    ready
    Comment    ${epoch}    Set Variable    Get current epoch time short
    ${SKU_id}=    Set Variable    GOAAF1116111
    ${Product_name}=    Set Variable    ที่เก็บสายหูฟัง Golette Horsebeen Wire Manager
    ${Pkey}=    Set Variable    2601739166428
    ${Color}=    Set Variable    2    #Product Color on Lv D ....... Please input position (1,2,3...) if not have product Color please input ${EMPTY}
    ${size}=    Set Variable    ${EMPTY}    #Product Size on Lv D ....... Please input position (1,2,3...) if not have product size please input ${EMPTY}
    ${validate_CouponCode}=    Set Variable    ${EMPTY}
    ${data}    Test data sanity_00002    \    ${SKU_id}    ${Product_name}    ${Pkey}    ${Color}
    ...    ${size}
    ${Order_Id&Sale_ID}=    Guest user Purchase Item with COD Payment    ${data.Text_Pkey}    ${validate_CouponCode}    ${data.Variant}    ${data.size}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    Log To Console    ${Order_Id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Delete Campaign by campaign name    ${data.Text_CampaignName}

TC_SANITY_00003
    [Tags]    regression    ready
    Pages access Wemall potal
    Pages access Wemall potal mobile
    Pages access Wemall potal ENG version
    Pages access Wemall potal ENG version mobile
    Pages access Wemall itruemart
    Pages access Wemall itruemart mobile
    Pages access Wemall search
    Pages access Wemall search ENG version
    Pages access Wemall search mobile
    Pages access Wemall potal HTTPS
    Pages access Wemall Shop
    Pages access Wemall Shop mobile
    Pages access Wemall search redirect from itm url
    Pages access Wemall search redirect from itm url mobile
    Pages access Wemall redirect from itm
    Pages access Wemall wow
    Pages access Wemall level D
    Pages access Wemall category
    Pages access Wemall line campaign
    Pages access Wemall brand
    Pages access Wemall truemove h
    [Teardown]    Close All Browsers

Temp
    Active freebie promotion on CAMP    6401    http://campaign-cms.itruemart-dev.com    test    password    17311
    Deactive freebie promotion on CAMP    6401    http://campaign-cms.itruemart-dev.com    test    password    17311
    [Teardown]    close browser

Sanity_03_Pages_Access

*** Keywords ***
Test data sanity_00001
    [Arguments]    ${promotioncode}=sntt    ${SKU_id}=ASAAA1112511    ${Product_name}=Asus Zenfone 5.    ${Freebie_SKU_id}=TRAAA1111711    ${Pkey}=2807712739892    ${Variant}=2
    ...    ${size}=${EMPTY}
    ${epoch_short}=    Get current epoch time short
    ${CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    &{dict}=    Create Dictionary    Text_SKU_id=${SKU_id}    Text_Product_name=${Product_Name}    Text_CampaignName=Sanity_${epoch_short}    Text_PromotionName=Sanity_${epoch_short}    Text_PromotionCode=${promotioncode}
    ...    Text_Detail=Sanity Test    Text_Note=Sanity Test    Text_SingleCode=1    Text_DiscountBath=19    Text_Prefix=${epoch_short}    Text_Email=Sanity@gmail.com
    ...    Text_Name=sanity    Text_Phone=0911111111    Text_Address=Sanity Test    Text_CWName=sanity    Text_CWCardNo=5555555555554444    Text_CWCCV=123
    ...    Text_Code=111    Text_CampaignStart=${CampaignStart}    Text_CampaignEnd=${CampaignEnd}    Text_FreebieStart=${FreebieStart}    Text_FreebieEnd=${FreebieEnd}    Text_CampaignName=TC_Sanity_00001_Campaing_${epoch_short}
    ...    Text_FreebieName=TC_Sanity_00001_Freebie_${epoch_short}    Text_CampaignDetail=Sanity Test    Text_FreebieShortDesc=Freebie shot description ${epoch_short}    Text_FreebieDesc=Freebie description ${epoch_short}    Text_Freebie_Identifyer=${SKU_id}    Text_FreeVariantID=${Freebie_SKU_id}
    ...    Text_PeriTem=1    Text_FreeVariantQuantity=1    Text_RepeatTime=5    sap_material_code=1234    material_id=1234    Text_new_email=Sanity_${epoch_short}@gmail.com
    ...    Text_new_displayed_name=Sanity    Text_new_password=Sanity@1234    Text_Pkey=${Pkey}    Variant=${Variant}    Text_Freebie_CategoryType=Variant    size=${size}
    [Return]    ${dict}

Test data sanity_00002
    [Arguments]    ${promotioncode}=sntt    ${SKU_id}=ACAAA1111111    ${Product_name}=ACME : Toffy Pillow    ${Pkey}=2592065870170    ${Variant}=1    ${size}=1
    ${epoch_short}=    Get current epoch time short
    ${CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    &{dict}=    Create Dictionary    Text_SKU_id=${SKU_ID}    Text_Product_name=${Product_Name}    Text_CampaignName=Sanity_${epoch_short}    Text_PromotionName=Sanity_${epoch_short}    Text_PromotionCode=${promotioncode}
    ...    Text_Detail=Sanity Test    Text_Note=Sanity Test    Text_SingleCode=1    Text_DiscountBath=19    Text_Prefix=${epoch_short}    Text_Email=Sanity@gmail.com
    ...    Text_Name=sanity@1234    Text_Phone=0911111111    Text_Address=Sanity Test    Text_CWName=sanity    Text_CWCardNo=5555555555554444    Text_CWCCV=123
    ...    Text_Code=111    Text_Pkey=${Pkey}    Variant=${Variant}    size=${size}    sap_material_code=1234    material_id=1234
    [Return]    ${dict}

Test data sanity_00003
    [Arguments]    ${promotioncode}=sntt    ${SKU_id}=ASAAA1118511    ${Product_name}=Asus Zenfone C ZC451CG    ${Pkey}=2805995111188    ${Variant}=1    ${size}=${EMPTY}
    ...    ${Email}=robotautomate@gmail.com    ${Password}=true1234
    ${epoch_short}=    Get current epoch time short
    ${CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    &{dict}=    Create Dictionary    Text_SKU_id=${SKU_ID}    Text_Product_name=${Product_Name}    Text_CampaignName=Sanity_${epoch_short}    Text_PromotionName=Sanity_${epoch_short}    Text_PromotionCode=${promotioncode}
    ...    Text_Detail=Sanity Test    Text_Note=Sanity Test    Text_SingleCode=1    Text_DiscountBath=19    Text_Prefix=${epoch_short}    Text_Email=Sanity@gmail.com
    ...    Text_Name=sanity@1234    Text_Phone=0911111111    Text_Address=Sanity Test    Text_CWName=sanity    Text_CWCardNo=5555555555554444    Text_CWCCV=123
    ...    Text_Code=111    Text_Pkey=${Pkey}    Variant=${Variant}    size=${size}    Text_Email=${Email}    Text_Password=${Password}
    ...    sap_material_code=1234    material_id=1234
    [Return]    ${dict}

Test data sanity_00004
    [Arguments]    ${promotioncode}=sntt    ${SKU_id}=ASAAA1118511    ${Product_name}=Asus Zenfone C ZC451CG    ${Pkey}=2805995111188    ${Variant}=1    ${size}=${EMPTY}
    ...    ${Email}=robotautomate@gmail.com    ${Password}=true1234
    ${epoch_short}=    Get current epoch time short
    ${CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    &{dict}=    Create Dictionary    Text_SKU_id=${SKU_ID}    Text_Product_name=${Product_Name}    Text_CampaignName=Sanity_${epoch_short}    Text_PromotionName=Sanity_${epoch_short}    Text_PromotionCode=${promotioncode}
    ...    Text_Detail=Sanity Test    Text_Note=Sanity Test    Text_SingleCode=1    Text_DiscountBath=19    Text_Prefix=${epoch_short}    Text_Email=Sanity@gmail.com
    ...    Text_Name=sanity@1234    Text_Phone=0911111111    Text_Address=Sanity Test    Text_CWName=sanity    Text_CWCardNo=5555555555554444    Text_CWCCV=123
    ...    Text_Code=111    Text_Pkey=${Pkey}    Variant=${Variant}    size=${size}    Text_Email=${Email}    Text_Password=${Password}
    ...    sap_material_code=1234    material_id=1234
    [Return]    ${dict}
