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
Resource          ../../Keyword/Features/Sanity_test/Keywords_Sanity_Production.robot
Resource          ../../Keyword/Portal/iTrueMart/Category_Page/Keywords_CategoryPage.robot
Resource          ../../Keyword/Features/User_login/User_login.robot
Resource          ../../Resource/Config/${env}/Sanity_Test_data.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/User_Information_Page/Keywords_UserInformationPage.robot

*** Test Cases ***
TC_SANITY_00001
    [Documentation]    Purchase product with new user (Register First)
    ...    - PCMS create single code
    ...    - PCMS create PC1
    ...    - CAMP create freebie
    ...    - Register ITM
    ...    - Purchase with COD
    [Tags]    regression    ready
    ${epoch}    Set Variable    Get current epoch time short
    ${promotioncode}=    Set Variable    S${epoch}    #Promotion Code on PCMS Potal
    ${SKU_id}=    Set Variable    ASAAA1112511
    ${Freebie_SKU_id}=    Set Variable    TRAAA1111711
    ${Product_name}=    Set Variable    Asus Zenfone 5.
    ${Pkey}=    Set Variable    2807712739892
    ${Color}=    Set Variable    2    #Product Color on Lv D ....... Please input position (1,2,3...) if not have product Color please input ${EMPTY}
    ${size}=    Set Variable    ${EMPTY}    #Product Size on Lv D ....... Please input position (1,2,3...) if not have product size please input ${EMPTY}
    ${data}    Test data sanity_00001    ${promotioncode}    ${SKU_id}    ${Product_name}    ${Freebie_SKU_id}    ${Pkey}
    ...    ${Color}    ${size}
    Login Pcms
    Go To Create Campaign page and Create Campaign    ${data.Text_CampaignName}    ${data.Text_Detail}    ${data.Text_Note}
    Go To Create Promotion page and Create Promotion with Single Code and PC1    ${data.Text_PromotionName}    ${data.Text_PromotionCode}    ${data.Text_Detail}    ${data.Text_Note}    ${data.Text_DiscountBath}    ${data.Text_SingleCode}
    ...    ${data.Text_Prefix}
    ${validate_CouponCode}    Keywords_Sanity.Verify Counpon Code    ${data.Text_PromotionName}
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${data.Text_CampaignName}    ${data.Text_CampaignDetail}    ${data.Text_CampaignStart}    ${data.Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${data.Text_FreebieName}    ${data.Text_FreebieShortDesc}    ${data.Text_FreebieDesc}    ${data.Text_FreebieStart}    ${data.Text_FreebieEnd}    ${data.Text_Freebie_CategoryType}
    ...    ${data.Text_Freebie_Identifyer}    ${data.Text_PeriTem}    ${data.Text_FreeVariantID}    ${data.Text_FreeVariantQuantity}    ${data.Text_RepeatTime}    ${data.Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    Register New Account    ${data.Text_new_email}    ${data.Text_new_displayed_name}    ${data.Text_new_password}
    ${Order_Id&Sale_ID}=    New user already register and Purchase Item with COD Payment    ${data.Text_Pkey}    ${data.Variant}    ${EMPTY}    ${data.Text_FreebieName}    ${data.Text_Name}
    ...    ${data.Text_Phone}    ${data.Text_Address}    ${validate_CouponCode}    ${data.Text_new_email}    ${validate_CouponCode}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    Change status to Picked and Packed with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Change status to shipped with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Run PCMS Order
    Cancel Order    ${Order_Id}    ${SKU_id}    ${Freebie_SKU_id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Delete Campaign by campaign name    ${data.Text_CampaignName}

TC_SANITY_00002
    [Documentation]    Purchase product with new user
    ...    - PCMS create unique code
    ...    - PCMS create PC3
    ...    - Guest user
    ...    - Purchase with COD
    [Tags]    regression    ready
    ${promotioncode}=    Set Variable    Get current epoch time short    #Promotion Code on PCMS Potal
    ${SKU_id}=    Set Variable    URAAA1111511
    ${Product_name}=    Set Variable    หูฟัง Urbanz รุ่น Sportz    # Product Name
    ${Pkey}=    Set Variable    2707114596366
    ${Color}=    Set Variable    1    #Product Color on Lv D ....... Please input position (1,2,3...) if not have product Color please input ${EMPTY}
    ${size}=    Set Variable    1    #Product Size on Lv D ....... Please input position (1,2,3...) if not have product size please input ${EMPTY}
    ${data}    Test data sanity_00002    ${promotioncode}    ${SKU_id}    ${Product_name}    ${Pkey}    ${Color}
    ...    ${size}
    Login Pcms
    Go To Create Campaign page and Create Campaign    ${data.Text_CampaignName}    ${data.Text_Detail}    ${data.Text_Note}
    Go To Create Promotion page and Create Promotion with Single Code and PC3    ${data.Text_PromotionName}    ${data.Text_PromotionCode}    ${data.Text_Detail}    ${data.Text_Note}    ${data.Text_DiscountBath}    ${data.Text_SingleCode}
    ...    ${data.Text_Prefix}
    ${validate_CouponCode}    Keywords_Sanity.Verify Counpon Code    ${data.Text_PromotionName}
    ${Order_Id&Sale_ID}=    Guest user Purchase Item with COD Payment    ${data.Text_Pkey}    ${validate_CouponCode}    ${data.Variant}    ${data.size}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    Change status to Picked and Packed with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Change status to shipped with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Run PCMS Order
    Cancel Order    ${Order_Id}    ${SKU_id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Delete Campaign by campaign name    ${data.Text_CampaignName}

TC_SANITY_00003
    [Documentation]    Purchase product with existing user
    ...    - PCMS create VIP code
    ...    - Login Home Page
    ...    - Purchase with COD
    [Tags]    regression    ready
    ${promotioncode}=    Set Variable    Get current epoch time short    #Promotion Code on PCMS Potal
    ${SKU_id}=    Set Variable    URAAA1111511
    ${Product_name}=    Set Variable    หูฟัง Urbanz รุ่น Sportz
    ${Pkey}=    Set Variable    2707114596366
    ${Color}=    Set Variable    1    #Product Color on Lv D ....... Please input position (1,2,3...) if not have product Color please input ${EMPTY}
    ${size}=    Set Variable    1    #Product Size on Lv D ....... Please input position (1,2,3...) if not have product size please input ${EMPTY}
    ${Email}    Set Variable    sanity_test@mail.com    #Exitsting Email
    ${Password}    Set Variable    test@1234
    ${data}    Test data sanity_00003    ${promotioncode}    ${SKU_id}    ${Product_name}    ${Pkey}    ${Color}
    ...    ${size}    ${Email}    ${Password}
    Login Pcms
    Go To Create Campaign page and Create Campaign    ${data.Text_CampaignName}    ${data.Text_Detail}    ${data.Text_Note}
    Go To Create Promotion page and Create Promotion with VIP Code and PC3    ${data.Text_PromotionName}    ${data.Text_PromotionCode}    ${data.Text_Detail}    ${data.Text_Note}    ${data.Text_DiscountBath}    ${data.Text_SingleCode}
    ...    ${data.Text_Prefix}
    ${validate_CouponCode}    Keywords_Sanity.Verify Counpon Code    ${data.Text_PromotionName}
    User Login From login page    ${data.Text_Email}    ${data.Text_Password}
    Verify item in cart
    ${Order_Id&Sale_ID}=    User already login and Purchase Item with COD Payment    ${data.Text_Pkey}    ${validate_CouponCode}    ${data.Variant}    ${data.size}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    Change status to Picked and Packed with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Change status to shipped with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Run PCMS Order
    Cancel Order    ${Order_Id}    ${SKU_id}
    [Teardown]    Run Keywords    Close All Browsers
    ...    AND    Delete Campaign by campaign name    ${data.Text_CampaignName}

TC_SANITY_00004
    [Documentation]    Purchase \ extra wow with FB user
    ...
    ...    - Login with fackbook
    ...
    ...    - Purchase extra wow with COD
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${promotioncode}=    Set Variable    Get current epoch time short    #Promotion Code on PCMS Potal
    ${SKU_id}=    Set Variable    URAAA1111511
    ${Product_name}=    Set Variable    หูฟัง Urbanz รุ่น Sportz
    ${Pkey}=    Set Variable    2707114596366
    ${Color}=    Set Variable    1    #Product Color on Lv D ....... Please input position (1,2,3...) if not have product Color please input ${EMPTY}
    ${size}=    Set Variable    1    #Product Size on Lv D ....... Please input position (1,2,3...) if not have product size please input ${EMPTY}
    ${data}    Test data sanity_00004    ${promotioncode}    ${SKU_id}    ${Product_name}    ${Pkey}    ${Color}
    ...    ${size}
    Open browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    sleep    3s
    ${Order_Id&Sale_ID}=    FB user Purchase everyday wow with COD Payment    ${EMPTY}    ${data.Variant}    ${data.size}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    Change status to Picked and Packed with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Change status to shipped with Order ID    ${Order_Id}    ${Sale_Id}    ${data.sap_material_code}    ${data.material_id}
    Run PCMS Order
    Cancel Order    ${Order_Id}    ${SKU_id}
    [Teardown]    Close All Browsers

Temp
    ${Text_Username}    Set Variable    benzascend@gmail.com
    ${Text_Password}    Set Variable    P@ssw0rd
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    ${Text_Displayname}    Set Variable    NEWADDTEST
    ${Text_Address}    Set Variable    999
    ${Text_Postcode}    Set Variable    10400
    ${Text_Mobile}    Set Variable    0800000000
    ${Text_Email}    Set Variable    benzascend@gmail.com
    Open browser    ${ITM_URL}    chrome
    Login_with_TrueID    ${Text_Username}    ${Text_Password}
    Sleep    5s
    Location Should Be    ${ITM_URL}/
    Go to user information page
    ${address}    Get From List    //*[@id="shipping_address_list"]
    Should Not Be Equal    ${address}    test
    [Teardown]

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
