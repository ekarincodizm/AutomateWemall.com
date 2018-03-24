*** Settings ***
Force Tags    WLS_Promotion
Library           Selenium2Library
Library           BuiltIn
Library           Collections
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot
# Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Promotion_code/keywords_promotion_code.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Features/User_login/User_login.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot

# Suite Setup  Create Campaign  ${campaign_name}   No
# Suite Teardown  promotion.Remove Campaign   ${campaign_name}   1
# Test Teardown   Close All Browsers

*** Variables ***

${TrueID}        antrobot001@gmail.com
${TruePWD}       true1234
${guestEmail}    antrobot001@gmail.com


${campaign_name}   Robot Testing Data     # ANTMAM_ROBOT_CAMPAIGN
${products}

&{TC_ITMWM_00034}     name=Single-Unlimit-all cart-Price-Privilege card 496694-PC3
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=500
    ...    dc_maximum=0
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=${EMPTY}    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC3
    ...    card=TMB
    ...    cardno1=4966941111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00035}     name=Single-Brand-Limited-Percent-Max Price-Privilege card 411111-PC1
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=1000
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=brand     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=Apple
    ...    budget=PC1
    ...    card=KRUNGSRI411111
    ...    cardno1=4111111111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00036}     name=Single-Product-Unlimited-Percent-Max Price-Privilege card (41111...11)-PC3
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC3
    ...    card=KRUNGSRI411111
    ...    cardno1=4111111111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00037}     name=Single-variant-Limited-Price-Privilege card-PC1
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=variant     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111
    ...    cardno1=4111111111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00038}     name=Unique-Bundle-Price-Privilege card-PC1
    ...    type=multiple_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=0
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=bundle     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111
    ...    cardno1=4111111111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00039}     name=Unique-Collection-Limited-Percent-Max Price-Privilege card-PC3
    ...    type=multiple_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=0
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC3
    ...    card=KRUNGSRI411111
    ...    cardno1=4111111111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00040}     name=Unique-All cart-Unlimited-Percent-Max Price-Privilege card-PC3
    ...    type=multiple_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=0
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC3
    ...    card=KRUNGSRI411111
    ...    cardno1=4111111111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00041}     name=VIP-All cart-Unlimited-Percent-Max Price-Privilege card 430445-PC3
    ...    type=vip_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=0
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC3
    ...    card=KTC
    ...    cardno1=4304451111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00042}     name=VIP-Product-Limited-Percent-Min/Max Price-Privilege card-454852-PC1
    ...    type=vip_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=1
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=500
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=SCB
    ...    cardno1=4548521111111111
    ...    cardno2=5555555555554444

&{TC_ITMWM_00043}     name=Single-All Cart-Unlimited-Price-Privilege card-496694-PC3
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=10
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=0
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC3
    ...    card=TMB
    ...    cardno1=4966941111111111
    ...    cardno2=5555555555554444

*** Test Cases ***
TC_ITMWM_00034
    [tags]    TC_ITMWM_00034    itma-3189    regression     promotion_code      change_payment_channal      change_credit_card      itm-a-sprint 2016S14    WLS_High
    ${inv_id}=    get_1inventory_id
    Log to console     ${inv_id}
    ${products_name}=   get_product_name    ${inv_id}
    ${brand_name}=   get_brand_name    ${inv_id}
    ${collection_name}=   get_collection_name    ${inv_id}
    # Adjust stock by inventory_id     ${inv_id}
    LOGIN PCMS
    Go To Robot Campaign    ${campaign_name}
    ${coupon}=    Create Promotion    &{TC_ITMWM_00034}
    Log to console   ${coupon}

    Open Browser    ${ITM_URL}/auth/login           ${BROWSER}
    Login_with_TrueID    ${TrueID}    ${TruePWD}
    ${ref}=  Get ACL    3
    clear_cart    ${ref}
    Go To Logout
    Close Browser
    ${rs2}=    Member Buy Product Until Checkout3     ${TrueID}    ${TruePWD}    ${ref}    ${inv_id}    &{TC_ITMWM_00034}[cardno1]
    Checkout3 - Apply Coupon    ${coupon}
    Verify if Coupon code apply successful
    Retry CCW Card No    &{TC_ITMWM_00034}[cardno2]
    Press Key    ${Checkout3_CCWCardNo}    \\9
    Checkout 3 - Verify Popup Coupon code error message
    Click Element     ${Checkout3_Submit_popup_err}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    Log to console   ${order_id}
    Display Summary Discount Price On Thankyou As Zero
    # Go To Logout
    # [teardown]      Remove Promotion     &{TC_ITMWM_00034}[name]

TC_ITMWM_00035
    [tags]    TC_ITMWM_00035    itma-3189    regression     promotion_code      change_payment_channal      change_credit_card      itm-a-sprint 2016S14    WLS_High
    ${inv_id}=    get_1inventory_id
    Log to console     ${inv_id}
    ${products_name}=   get_product_name    ${inv_id}
    ${brand_name}=   get_brand_name    ${inv_id}
    ${collection_name}=   get_collection_name    ${inv_id}
    Set To Dictionary    ${TC_ITMWM_00035}    dc_on_follow_value=${brand_name}
    LOGIN PCMS
    Go To Robot Campaign    ${campaign_name}
    ${coupon}=    Create Promotion    &{TC_ITMWM_00035}
    Log to console   ${coupon}

    Open Browser    ${ITM_URL}           ${BROWSER}
    Maximize Browser Window
    ${ref}=  Get ACL    2
    ${rs2}=    Guest Buy Product Until Checkout3     ${TrueID}    ${TruePWD}    ${ref}    ${inv_id}    &{TC_ITMWM_00035}[cardno1]
    Checkout3 - Apply Coupon    ROBOTGAY    #${coupon}
    Verify if Coupon code apply successful
    User Click Payment Channel COD Tab
    Checkout 3 - Verify Popup Coupon code error message
    Click Element     ${Checkout3_Submit_popup_err}
    User Click Payment Channel CCW Tab
    Retry CCW Card No    &{TC_ITMWM_00035}[cardno2]
    Press Key    ${Checkout3_CCWCardNo}    \\9
    Click Element     ${Checkout3_Submit_popup_err}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    Log to console   ${order_id}
    Display Summary Discount Price On Thankyou As Zero
    [teardown]      Remove Promotion     &{TC_ITMWM_00035}[name]
