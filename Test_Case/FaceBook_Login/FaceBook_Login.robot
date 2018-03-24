*** Settings ***
Force Tags    WLS_FaceBook_Login
Test Teardown     Close Browser
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Log-in/Keywords_LoginPage.robot
Resource          ${CURDIR}/../../Resource/Config/${ENV}/Env_config.robot
Resource          ${CURDIR}/../../Resource/Config/${ENV}/database.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Light_Box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Pop_Up/Keywords_CartPopUp.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/User_Information_Page/Keywords_UserInformationPage.robot
Resource          ../../Keyword/Features/User_login/User_login.robot
Resource          ../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/Features/Sanity_test/Keywords_Sanity_Production.robot
Resource          ../../Keyword/API/CAMP_API/keyword_camp.txt

*** Variables ***
${Product_Pkey}    2613442373522
${Product_Pkey2}    2653599985921
${Product_SKU1}    TRAAA1112111
${Product_SKU2}    TRAAA1111711
${Text_ProductName}    flash 12X iPhone 4/4S
${Text_EmptyCart}    ไม่พบสินค้าในตะกร้า
${Text_ProductName2}    เลนส์ เทเลซูม 12X Samsung Galaxsy S3

*** Test Cases ***
TC_iTM_02067 Log-in with facebook user that already have itruemart id with facebook type in the system
    [TAGS]    ready    regression    facebook    TC_iTM_02067    WLS_High
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    Open browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    #Location Should Be    ${ITM_URL}/
    Sleep    5s
    Verify displayname on header    ${FB_firstname} ${FB_lastname}

TC_iTM_02068 Add new address from both facebook and trueID user which use the same email
    [TAGS]    ready    regression    facebook    TC_iTM_02068    WLS_High
    ${Text_Username}    Set Variable    benzascend@gmail.com
    ${Text_Password}    Set Variable    P@ssw0rd
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    ${Text_Displayname}    Set Variable    NEWADDTESTFORTRUE
    ${Text_Address}    Set Variable    999
    ${Text_Postcode}    Set Variable    10400
    ${Text_Mobile}    Set Variable    0800000000
    ${Text_email}    Set Variable    benzascend@gmail.com
    ${Text_Displayname2}    Set Variable    NEWADDTESTFORFB
    ${Text_Address2}    Set Variable    888
    ${Text_Postcode2}    Set Variable    10400
    ${Text_Mobile2}    Set Variable    0800000002
    ${Text_email2}    Set Variable    benzascend@gmail.com
    Obsolete delete customer address by email    benzascend@gmail.com
    Open browser    ${ITM_URL}    chrome
    Login_with_TrueID    ${Text_Username}    ${Text_Password}
    Sleep    5s
    #Location Should Be    ${ITM_URL}/
    Go to user information page
    Enter add new address formation    ${Text_Displayname}    ${Text_Address}    ${Text_Postcode}    ${Text_Mobile}    ${Text_Email}
    Sleep    5s
    Click submit add new address
    Sleep    5s
    Go To    ${ITM_URL}
    Logout user from itruemart
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    5s
    Go to user information page
    Verify if Address Should be Empty
    Enter add new address formation    ${Text_Displayname2}    ${Text_Address2}    ${Text_Postcode2}    ${Text_Mobile2}    ${Text_Email2}
    Sleep    5s
    Click submit add new address
    Sleep    5s

TC_iTM_02069 Log-in Itruemart with trueID user then place any order to cart but not check out, then log-in with facebook user which use the same email as trueID user then place any order to cart, then check cart
    [TAGS]    ready    regression    facebook    TC_iTM_02069    WLS_High
    ${Text_Username}    Set Variable    benzascend@gmail.com
    ${Text_Password}    Set Variable    P@ssw0rd
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    ${Text_Phone}    Set Variable    0812345678
    ${Text_Address}    Set Variable    AIA Tower floor19
    Stock - Increase Stock By Inventory Id    ${Product_SKU1}
    Stock - Increase Stock By Inventory Id    ${Product_SKU2}
    Open browser    ${ITM_URL}    chrome
    Login TrueUser and Clear all items in cart    ${Text_Username}    ${Text_Password}
    Sleep    3s
    Logout user from itruemart
    Login FaceBook and Clear all items in cart    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    3s
    Go to    ${ITM_URL}/products/item-${product_pkey}.html
    Level D Choose Product Color
    Comment    Level D Add Quality
    Level D Click Add To Cart success case
    sleep    5
    Check Avaliable items on Cart Light Box by Item Name    ${Text_ProductName}
    Close Cart Light Box
    Logout user from itruemart
    Login_with_TrueID    ${Text_Username}    ${Text_Password}
    Sleep    3s
    Open cartLightBox from MiniCart
    Sleep    3s
    Check Avaliable items on Cart Light Box by Item Name    ${Text_EmptyCart}
    Go to    ${ITM_URL}/products/item-${product_pkey2}.html
    Level D Choose Product Color
    Comment    Level D Add Quality
    Level D Click Add To Cart success case
    sleep    5
    Check Avaliable items on Cart Light Box by Item Name    ${Text_ProductName2}
    Items Should not Avaliable in CartLightBox    ${Text_ProductName}
    Close Cart Light Box
    Logout user from itruemart
    Login_Facebook_while_FBCookies_is_Avaliable(Existing user)
    Sleep    3s
    Open cartLightBox from MiniCart
    Sleep    3s
    Check Avaliable items on Cart Light Box by Item Name    ${Text_ProductName}
    Items Should not Avaliable in CartLightBox    ${Text_ProductName2}

TC_iTM_02080 User that log-in with facebook should not be able to use promotion code if log-in with existing email that taken by trueID user and he have already use that code.
    [TAGS]    ready    regression    facebook    TC_iTM_02080    WLS_High
    ${epoch}=    Get current epoch time
    ${epoch_short}=    Get current epoch time short
    ${Text_CampaignName}    Set Variable    STS_${epoch}
    ${Text_PromotionName}    Set Variable    STS_${epoch}
    ${Text_PromotionCode}    Set Variable    stsa
    ${Text_Detail}    Set Variable    test
    ${Text_Note}    Set Variable    test
    ${Text_SingleCode}    Set Variable    1
    ${Text_DiscountBath}    Set Variable    33
    ${Text_Prefix}    Set Variable    ${epoch_short}
    ${Text_Email}    Set Variable    storm_test@gmail.com
    ${Text_Name}    Set Variable    storm_test
    ${Text_Phone}    Set Variable    0987654321
    ${Text_Address}    Set Variable    test storm
    ${Text_CWName}    Set Variable    test storm
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable    111
    ${Text_Username}    Set Variable    benzascend@gmail.com
    ${Text_Password}    Set Variable    P@ssw0rd
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${Text_ProductURL}     Set Variable    12x-iphone-44s-2613442373522
    ${variance}    Set Variable    ${EMPTY}
    ${size}    Set Variable    ${EMPTY}
    ${Text_Limited}    Set Variable    1
    ${Counpon_error_message1}    Set Variable    รหัสคูปองพิเศษหมดอายุแล้ว
    Login Pcms
    Go To Create Campaign page and Create Campaign    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}
    Go To Create Promotion page and Create Promotion with limited Usage    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}    ${Text_Limited}
    ${validate_CouponCode}    ITM.Verify Counpon Code    ${Text_PromotionName}
    Go to    ${ITM_URL}
    Login_with_TrueID    ${Text_Username}    ${Text_Password}
    Sleep    5s
    Create Order and Apply promotion code with choosing COD as payment    ${validate_CouponCode}
    Verify if Coupon code apply successful
    Sleep    2
    Checkout3 - Click Submit
    Go to    ${ITM_URL}
    Logout user from itruemart
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    5s
    Create Order and Apply promotion code with choosing COD as payment    ${validate_CouponCode}
    Verify Coupon code error message    ${Counpon_error_message1}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign by campaign name    ${Text_CampaignName}

TC_iTM_02087 Re-login with existing facebook user
    [TAGS]    ready    regression    facebook    TC_iTM_02087    WLS_High
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    ${Text_Phone}    Set Variable    0812345678
    ${Text_Address}    Set Variable    AIA Tower floor19
    Open browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    5
    #Location Should Be    ${ITM_URL}/
    Logout user from itruemart
    Go to log-in page
    Click login with facebook on login page
    Sleep    5
    #Location Should Be    ${ITM_URL}/

TC_iTM_02088 Log-in with facebook user then verify display name on header
    [TAGS]    ready    regression    facebook    TC_iTM_02088    WLS_Medium
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    Open browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    5s
    #Location Should Be    ${ITM_URL}/
    Verify displayname on header    ${FB_firstname} ${FB_lastname}

TC_iTM_02089 User login with facebook all valid step
    [TAGS]    ready    regression    facebook    TC_iTM_02089    WLS_High
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    Open browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    5s
    #Location Should Be    ${ITM_URL}/

TC_iTM_02092 System can merge cart from guest to Facebook user
    [TAGS]    ready    regression    facebook    TC_iTM_02092    WLS_High
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    ${Text_Phone}    Set Variable    0812345678
    ${Text_Address}    Set Variable    AIA Tower floor19
    Open browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    3s
    Open cartLightBox from MiniCart
    Sleep    3s
    Delete all items in cart
    Logout user from itruemart
    Go to    ${ITM_URL}/products/item-${product_pkey}.html
    Level D Choose Product Color
    Comment    Level D Add Quality
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    sleep    2
    Checkout1 - Click login with facebook on Checkout1 page
    Checkout2 - Check an Avaliable Items On MiniCart    ${Text_ProductName}

TC_iTM_02093 Check merge cart if Facebook user have item in cart then log-out and add item with guest then log-in again
    [TAGS]    ready    regression    facebook    TC_iTM_02093    WLS_High
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    ${Text_Phone}    Set Variable    0812345678
    ${Text_Address}    Set Variable    AIA Tower floor19
    Stock - Increase Stock By Inventory Id    ${Product_SKU1}
    Stock - Increase Stock By Inventory Id    ${Product_SKU2}
    Open browser    ${ITM_URL}    chrome
    Login FaceBook and Clear all items in cart    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    3s
    Go to    ${ITM_URL}/products/item-${product_pkey}.html
    Level D Choose Product Color
    Comment    Level D Add Quality
    Level D Click Add To Cart success case
    sleep    5
    Check Avaliable items on Cart Light Box by Item Name    ${Text_ProductName}
    Close Cart Light Box
    sleep    3s
    Logout user from itruemart
    Sleep    3s
    Go to    ${ITM_URL}/products/item-${product_pkey2}.html
    Level D Choose Product Color
    Comment    Level D Add Quality
    Level D Click Add To Cart success case
    sleep    5
    Check Avaliable items on Cart Light Box by Item Name    ${Text_ProductName2}
    Items Should not Avaliable in CartLightBox    ${Text_ProductName}
    Close Cart Light Box
    Login_Facebook_while_FBCookies_is_Avaliable(Existing user)
    Sleep    5s
    Open cartLightBox from MiniCart
    Sleep    3s
    Check Avaliable items on Cart Light Box by Item Name    ${Text_ProductName}
    Check Avaliable items on Cart Light Box by Item Name    ${Text_ProductName2}

TC_iTM_02094 Pick item with guess to cart then login with facebook at Checkout1 page to purchase order
    [TAGS]    ready    regression    Facebook    TC_iTM_02094    WLS_High
    ${Text_FBUsername}    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}    Set Variable    P@ssw0rd
    ${FB_firstname}    Set Variable    Benz
    ${FB_lastname}    Set Variable    Ascend
    ${Text_Phone}    Set Variable    0812345678
    ${Text_Address}    Set Variable    AIA Tower floor19
    Stock - Increase Stock By Inventory Id    ${Product_SKU1}
    Open browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    3
    Go to    ${ITM_URL}/products/item-${product_pkey}.html
    Level D Choose Product Color
    Comment    Level D Add Quality
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    sleep    2
    Checkout2 - Wait Loading
    Checkout2 - Choose 1stShipping Address
    Sleep    2
    Checkout3 - Select payment channal    ${Payment_Channal_COD}
    Sleep    2
    Checkout3 - Click Submit
    ${order_id}=    ITM.Wait until Purchase Success Appear and retrieve Order ID For Member
