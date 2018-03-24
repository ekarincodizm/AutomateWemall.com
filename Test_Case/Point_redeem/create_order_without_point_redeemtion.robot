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
#Resource          ${CURDIR}/../../Resource/Config/${ENV}/env_config.robot
Resource          ../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/Features/User_login/User_login.robot
Test Setup        Test Setup


*** Test Cases ***
[Single] Guest buy product with CC payment
    [Tags]    TC_25
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2951108269824

    Guest buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via CCW
    [Teardown]    Run Keywords    close browser

[Single] Member buy Freebie with Installment payment
    [Tags]    TC_26
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2849437225742

    Member buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via Installment
    [Teardown]    Run Keywords    close browser

[Single] Mobile Member buy Freebie with CC payment
    [Tags]    TC_27
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2298509757205

    Mobile Member buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via CCW
    [Teardown]    Run Keywords    close browser

[Single] Facebook Member buy Everyday Wow with CS payment
    [Tags]    TC_28
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2922107055441

    Facebook Member buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via CS
    #[Teardown]    Run Keywords    close browser

[Single] Guest buy Extra Wow with COD payment
    [Tags]    TC_29
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2677038659576

    Guest buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via COD
    #[Teardown]    Run Keywords    close browser

[Multi] Guest buy 2-normal products with CC payment
    [Tags]    TC_34
    # แฟลชไดรฟ์ infothink Avengers - Captain America 8 GB - R - 2951108269824
    # กล้องเสริม เลนส์ซูม 8XLens Zoom Telescope - R - 2567561313663
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2951108269824     2567561313663

    Guest buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via CCW    PPC6
    #[Teardown]    Run Keywords    close browser

[Multi] Member buy freebie and wow1baht and wow1baht with Installment payment
    [Tags]    TC_35
    # แฟลชไดรฟ์ infothink Avengers - Captain America 8 GB - R - 2951108269824
    # Nikon D7200 Kit (18-140mm VR) - M - 2298509757205
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2951108269824     2298509757205

    Member buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via Installment    PRON
    #[Teardown]    Run Keywords    close browser

[Multi] Mobile Member buy normal and extra wow with CS payment
    [Tags]    TC_36
    # JHI ขาตั้งกล้องสำหรับ SmartPhone รุ่น 2120W - R - 2849437225742
    # Nikon D7200 Kit (18-140mm VR) - M - 2298509757205
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2849437225742     2298509757205

    Mobile Member buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via CS    PPC6
    #[Teardown]    Run Keywords    close browser

[Multi] Facebook Member buy normal and everyday wow with COD payment
    [Tags]    TC_37
    ${variance}    Set Variable
    ${size}    Set Variable
    @{PkeyList}=    Create List    2229102859732     2184138670265

    Facebook Member buy Product    ${variance}    ${size}   @{PkeyList}
    ${order_id}=    Make Payment via COD    PRON
    #[Teardown]    Run Keywords    close browser

*** Keywords ***
Test Setup
    Clear Cart     27459065

Guest buy Product
    [Arguments]     ${variance}    ${size}    @{Pkey}
    ${Text_Email}    Set Variable    robot_point@test.com
    ${Text_Name}    Set Variable    aaaaa
    ${Text_Phone}    Set Variable    0999999999
    ${Text_Address}    Set Variable    bbbbbbb
    Open Browser    ${ITM_URL}    chrome

    :FOR    ${product}    IN    @{Pkey}
    \    Level D Go to level D with Product    ${product}
    \    Wemall Common - Close Live Chat
    \    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    \    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    \    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    \    Level D Click Add To Cart success case
    Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Guest Fill Data and Submit Checkout2    ${Text_Name}    ${Text_Phone}    ${Text_Address}

Member buy Product
    [Arguments]     ${variance}    ${size}    @{Pkey}
    Open Browser    ${ITM_URL}    chrome
    Login_with_TrueID    oak@test.com    welcome
    Sleep    5s

    :FOR    ${product}    IN    @{Pkey}
    \    Level D Go to level D with Product    ${product}
    \    Wemall Common - Close Live Chat
    \    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    \    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    \    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    \    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address

Mobile Member buy Product
    [Arguments]     ${variance}    ${size}    @{Pkey}
    Open Browser    ${ITM_URL}    chrome
    Login_with_TrueID    0979366979    GeingAcc1
    Sleep    15s

    :FOR    ${product}    IN    @{Pkey}
    \    Level D Go to level D with Product    ${product}
    \    Wemall Common - Close Live Chat
    \    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    \    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    \    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    \    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address

Facebook Member buy Product
    [Arguments]     ${variance}    ${size}    @{Pkey}
    ${Text_FBUsername}=    Set Variable    benzascend@gmail.com
    ${Text_FBPassword}=    Set Variable    P@ssw0rd
    ${user_id}=     Set Variable    fb113419022389023
    Clear Cart    ${user_id}
    Open Browser    ${ITM_URL}    chrome
    Login_with_Facebook(Existing user)    ${Text_FBUsername}    ${Text_FBPassword}
    Sleep    5s

    :FOR    ${product}    IN    @{Pkey}
    \    Level D Go to level D with Product    ${product}
    \    Wemall Common - Close Live Chat
    \    Run Keyword If    '${variance}' != '${EMPTY}'    Level D Select Product Variance in Level D    ${variance}
    \    Run Keyword If    '${size}' != '${EMPTY}'    Level D Select Product size in Level D    ${size}
    \    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    \    Level D Click Add To Cart success case
    Next to Checkout 1
    Checkout2 - Choose 1stShipping Address

Make Payment via CCW
    [Arguments]     ${Text_Code}=${EMPTY}
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    CC Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Log To Console    Order ID = ${order_id}
    Return From Keyword     ${order_id}

Make Payment via Installment
    [Arguments]     ${Text_Code}=${EMPTY}
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    Sleep    10
    Run Keyword If    '${Text_Code}' != '${EMPTY}'    Checkout3 - Apply Coupon    ${Text_Code}
    Checkout3 - Installment payment and Submit    กสิกรไทย    2
    Fill in KBank CC payment gateway and submit    Master    ${Text_CWCardNo}    ${Text_CWCCV}    01    2026    ${Text_CWName}
    sleep    30
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Log To Console    Order ID = @{order_id}
    Return From Keyword     ${order_id}

Make Payment via CS
    [Arguments]     ${Text_Code}=${EMPTY}
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
    CS Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Log To Console    Order ID = @{order_id}
    Return From Keyword     ${order_id}

Make Payment via COD
    [Arguments]     ${Text_Code}=${EMPTY}
    ${Text_CWName}    Set Variable    abc
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable
    COD Payment Fill Data and Submit Checkout3    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    Log To Console    Order ID = @{order_id}
    Return From Keyword     ${order_id}
