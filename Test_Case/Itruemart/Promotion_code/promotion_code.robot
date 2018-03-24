*** Settings ***
Library           Selenium2Library
Library           BuiltIn
Library           Collections
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot
# Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Promotion_code/keywords_promotion_code.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Create_Product/Create_Product/Create_Product.robot

*** Variables ***
${campaign-name}    Robot Testing Data
${products}    Samsung Galaxy Note 4 เครื่องเปล่า ศูนย์ทรู
${collections}    สมาร์ทโฟน

&{TC1}     name=Single-Unlimit-All_Cart-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=${EMPTY}    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC2}     name=Single-Unlimit-Brand-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=brand     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=Apple
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC3}     name=Single-limited-product-percent
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${products}
    ...    budget=PC1
    ...    card=KRUNGSRI411111

&{TC4}     name=Single-Unlimit-Brand-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=10
    ...    dc_type=percent    #  price / percent
    ...    dc_value=15
    ...    dc_maximum=35
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${collections}
    ...    budget=PC3
    ...    card=${EMPTY}


*** Test Cases ***


# Test Create Promotion
#     [Tags]      create
#     ${inv_id}=    get_1inventory_id
#     ${products_name}=   get_product_name    ${inv_id}
#     Log To Console    ${inv_id} = ${products_name}
#     Adjust stock by inventory_id     ${inv_id}


#     Remove Promotion     &{TC3}[name]


#     LOGIN PCMS
#     Go To Robot Campaign    ${campaign-name}
#     ${coupon}=    Create Promotion    &{TC3}
#     Log to console   ${coupon}
#     [teardown]    Remove Promotion     &{TC3}[name]


# Test Create Remove Promotion
#     [Tags]     remove_promotion
#     Remove Promotion By Name And Campaign    ${campaign-name}    Single 100 baht min 150 #Remove PromotionPromotion Test Data TC16

# Test Remove Robot Testing Data
#     [Tags]   remove_robot_testing_data
#     remove_campaign     ${campaign-name}     Yes

# Test Create Campaign
#     [Tags]  create_campaign
#     Create Campaign    ${campaign-name}
#     [teardown]    Run Keywords    Close Browser


# Test Create Campaign Expired
#     [Tags]      create_expired_campaign
#     Create Expired Campaign    Robot Expired Campaign
#     [teardown]    Run Keywords    Close Browser



# Test Create Promotion By Product
#     [Tags]      create_by_product


#     ${inv_id}=    get_1inventory_id
#     ${products_name}=   get_product_name    ${inv_id}
#     Log To Console    ${inv_id} = ${products_name}
#     Adjust stock by inventory_id     ${inv_id}

#     LOGIN PCMS
#     Go To Robot Campaign    ${campaign-name}
#     ${coupon}=    Create Promotion    &{TC3}
#     Log to console   ${coupon}
#     [teardown]    Remove Promotion     &{TC3}[name]

# Test Create Campaign
#     [Tags]  create_campaign
#     Create Campaign    ${campaign-name}
#     [teardown]    Run Keywords    Close Browser

Update product status
    [Tags]  update
    ${inv_id}=    get_1inventory_id
    ${products_name}=   get_product_name    ${inv_id}
    ${products_id}=   get_product_id    ${inv_id}

    ${brand_name}=   get_brand_name    ${inv_id}
    ${collection_id}=   get_collection_id    ${inv_id}
    ${collection_name}=   get_collection_name    ${inv_id}
    Log to console   ${products_id}=${collection_id}
    # 0 = Disavle    1 = Active
    # Update DB product active status    ${products_id}    0
    # Update DB product active status    ${products_id}    1
    Set Product Collection   ${products_name}    342


# update promotion Period
#     Set Promotion Expire   &{TC3}[name]
