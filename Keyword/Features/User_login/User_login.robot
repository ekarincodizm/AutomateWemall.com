*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Library           RequestsLibrary
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_wemall_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Log-in/Keywords_LoginPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource          ../../../Resource/WebElement/PC1_And_PC3/PCMS.robot
Resource          ../../Portal/PCMS/Campaign/Keywords_Campaign.robot
Resource          ../../Portal/PCMS/Promotion/Keywords_Promotion.robot

*** Keywords ***
Login_with_TrueID
    [Arguments]    ${Text_Username}    ${Text_Password}
    Go to log-in page
    Enter log-in with trueID formation    ${Text_Username}    ${Text_Password}
    Click submit login with trueID button

Login_with_Facebook(Existing user)
    [Arguments]    ${Text_FBUsername}    ${Text_FBPassword}
    Go to log-in page
    Click login with facebook on login page
    Select Window    title=Facebook
    Enter log-in with facebook formation    ${Text_FBUsername}    ${Text_FBPassword}
    Click submit login with facebook button
    Select Window    title=เข้าสู่ระบบ | Wemall.com

Checkout1_Login_with_faceBook(Existing user)
    [Arguments]    ${Text_FBUsername}    ${Text_FBPassword}
    Checkout1 - Click login with facebook on Checkout1 page
    Sleep    2s
    Select Window    title=Facebook
    Enter log-in with facebook formation    ${Text_FBUsername}    ${Text_FBPassword}
    Click submit login with facebook button
    Select Window    title=เข้าสู่ระบบ | Wemall.com

Login TrueUser and Clear all items in cart
    [Arguments]    ${Text_Username}    ${Text_Password}
    Login_with_TrueID    ${Text_Username}    ${Text_Password}
    Sleep    5s
    Open cartLightBox from MiniCart
    Sleep    5s
    Delete all items in cart

Login FaceBook and Clear all items in cart
    [Arguments]    ${Text_FBUsername}    ${Text_FBPassword}
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    3s
    Open cartLightBox from MiniCart
    Sleep    5s
    Delete all items in cart

Login_Facebook_while_FBCookies_is_Avaliable(Existing user)
    Go to log-in page
    Click login with facebook on login page

Checkout1_Login_while_FBCookies_is_Avaliable(Existing user)
    Checkout1 - Click login with facebook on Checkout1 page

Go To Create Promotion page and Create Promotion with limited Usage
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}    ${Text_Limited}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select limited Single Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}    ${Text_Limited}
    Promotion - Select PC1 to Create Promotion
    Promotion - Save Promotion

Create Order and Apply promotion code with choosing COD as payment
    [Arguments]    ${validate_CouponCode}
    Go to    ${ITM_URL}/products/item-${product_pkey}.html
    Level D Choose Product Color
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    sleep    2
    Checkout2 - Wait Loading
    Checkout2 - Choose 1stShipping Address
    Sleep    2
    Checkout3 - Select payment channal    ${Payment_Channal_COD}
    Wemall Common - Close Live Chat
    sleep    3
    #Checkout3 - Apply Coupon    ${validate_CouponCode}
    Keywords_Checkout3.Checkout3 - Apply Coupon    ${validate_CouponCode}

Checkout1 Login With trueID User
    [Arguments]    ${Text_Username}    ${Text_Password}
    Checkout1 - Click Have Member Radio Button
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Input Password    ${Text_Password}
    Checkout1 - Click Next