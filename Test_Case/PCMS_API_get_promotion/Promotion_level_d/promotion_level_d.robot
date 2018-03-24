*** Settings ***
Library    Selenium2Library
Library    HttpLibrary.HTTP
Library    Collections
Resource   ${CURDIR}/../../../Resource/init.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/Keywords_Promotion.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Payment_method/keywords_payment_method.robot
Library    ${CURDIR}/../../../Python_Library/promotion_code.py
Library    ${CURDIR}/../../../Python_Library/campaign.py
Library    ${CURDIR}/../../../Python_Library/promotion.py

Suite Setup   Init Suite


*** Keywords ***
Init Suite
    ${is_exist}=   Is Exist Campaign   ${campaign_normal}
    #Log To Console   is_exist=${is_exist}
    Run Keyword If  '${is_exist}' == '${False}'   Promotion - Create Campaign  ${campaign_normal}   No


*** Variables ***
## normal campaign
${campaign_normal}   Cha - Normal
${campaign_deactive}   Cha - Deactivate
${campaign_expire}   Cha - Expired


&{TC2}     name=TC_ITMWM_05404
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}



&{TC3}     name=TC_ITMWM_05405
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC4}     name=TC_ITMWM_05406
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC5}     name=TC_ITMWM_05407
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}



&{TC6}     name=TC_ITMWM_05408
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    status=deactivate       # active ,  deactivate
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC7}     name=TC_ITMWM_05409
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    status=deactivate       # active ,  deactivate
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    end_period=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC8}     name=TC_ITMWM_05410
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    status=Activate       # active ,  deactivate
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    promo_group=Bundle
    ...    end_period=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC9_1}     name=TC_ITMWM_05411_1
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    status=Activate       # active ,  deactivate
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    end_period=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC9_2}     name=TC_ITMWM_05411_2
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    status=Activate       # active ,  deactivate
    ...    usetime=2
    ...    userlimit=unlimited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    promo_group=Bundle
    ...    end_period=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


*** Test Cases ***
TC_ITMWM_05403 - To verify that API get promtion level D is returned 1 pkey and total code product A is 0 if do not have any promotion effect with product A
    [Tags]       ITMA-3293   TC_ITMWM_05403      TC1
##Prerequisite
# AAA is pkey of product A

    ${product}=         DB Product - Get Product
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey

## Test steps
# Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA

    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}

## Expected result
# 1.1 API is returned total code of pkey AAA is 0
# 1.2 API is returned promotion_code of pkey AAA is null
    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
    Should Be Equal As Integers   ${total_code}   0
    Should Be Equal    ${promotion_code}   []



TC_ITMWM_05404 - To verify that API get promotion level D is returned 1 pkey and total code product A = 0 if promotion code is effect with product A is not allowed display on web
    [Tags]       ITMA-3293   TC_ITMWM_05404      TC2

## Prerequisite
# 1. Create promotion code A cart with condition type as 'single_code' effect product A,(Product)
# 2. Promotion A is in Campaign C1
# 3. promotion A is not allowed display on web
# 4. promotion A is not excluded product A
# 5. Campaign C1 is activated.
# 6. Campaign C1 is not expired
# 7. promotion A is activated.
# 8. promotion A is not expired
# 9. promotion A is not set specific date

    ${product}=         DB Product - Get Product
    Log To Console      ${product}
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
    ${product_title}=    Get From Dictionary    ${product[0]}    product_title

    Set To Dictionary   ${TC2}   dc_on_follow_value=${product_title}

    Login Pcms
    Go To Robot Campaign    ${campaign_normal}
    ${code}=   Create Promotion   &{TC2}
    ${promotion_id}=   Py Get Promotion Id    ${campaign_normal}    &{TC2}[name]

## Test steps
# Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA

    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}

## Expected result
# 1.1 API is returned total code of pkey AAA is 0
# 1.2 API is returned first_promotion_code of pkey AAA is null
# 1.3 API is returned 'display_thumb' = "1"
# 1.4 API is returned 'th_TH' and 'en_EN'

    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
    ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
    Should Be Equal As Integers   ${total_code}   0
    Should Be Equal    ${promotion_code}   []
    Should Be Equal As Integers   ${display_thumb}   1
    # 1.4 API is returned 'th_TH' and 'en_EN'

    [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_normal}  &{TC2}[name]
    ...   AND   Close All Browsers

TC_ITMWM_05405 - To verify that 'get promotion level D' API​ returns 1 pkey and total code product P1​ = 0 if promotion code has excluded product P1 from mass upload
    [Tags]       ITMA-3293   TC_ITMWM_05405      TC3

# # Prerequisite
# 1. Create promotion code A cart with condition type as 'single_code' effect product P1 (Product)
# 2. Promotion A is in Campaign C1
# 3. promotion A is allowed display on web
# 4. promotion A -> mass upload excluded product P1
# 5. Campaign C1 is activated.
# 6. Campaign C1 is not expired
# 7. promotion A is activated.
# 8. promotion A is not expired
# 9. promotion A is not set specific date

    ${product}=         DB Product - Get Product
    #Log To Console      ${product}
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
    ${product_title}=    Get From Dictionary    ${product[0]}    product_title
    ${product_pkeys}=   Create List         ${product_pkey}

    Log To Console      ${product_pkeys}


    Set To Dictionary   ${TC3}   dc_on_follow_value=${product_title}

    Login Pcms
    Go To Robot Campaign    ${campaign_normal}
    ${code}=   Create Promotion   &{TC3}
    ${promotion_id}=   Py Get Promotion Id    ${campaign_normal}    &{TC3}[name]

    Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
     ...  Code Text Th    Code Text En
     ...  Discount Text Th    Discount Text En
     ...  1

    Promotion - Go To Mass Upload Excluded Product   ${promotion_id}
    Promotion - Choose File For Mass Upload Excluded Product    ${product_pkeys}        Promotion_level_d

# 1. Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get...

    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}

## Expected result
# 1.1 API is returned total code of pkey AAA is 0
# 1.2 API is returned first_promotion_code of pkey AAA is null
# 1.3 API is returned 'display_thumb' = "0"

    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
    ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
    Should Be Equal As Integers   ${total_code}   0
    Should Be Equal    ${promotion_code}   []
    Should Be Equal As Integers   ${display_thumb}   1

    [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_normal}  &{TC3}[name]
    ...   AND   Close All Browsers



TC_ITMWM_05406 - To verify that API get promotion level D is returned 1 pkey and total code product A = 0 if campaign is deactivated
    [Tags]       ITMA-3293   TC_ITMWM_05406      TC4

## Prerequisite
# 1. Create promotion code A cart with condition type as 'single_code' effect product A (Product)
# 2. Promotion A is in Campaign C1
# 3. promotion A is allowed display on web and display on thumbnail
# 4. promotion A is not excluded product A
# 5. Campaign C1 is deactivated.
# 6. Campaign C1 is not expired
# 7. promotion A is activated.
# 8. promotion A is not expired
# 9. promotion A is not set specific date

    ${product}=         DB Product - Get Product
    #Log To Console      ${product}
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
    ${product_title}=    Get From Dictionary    ${product[0]}    product_title

    Set To Dictionary   ${TC4}   dc_on_follow_value=${product_title}

    Login Pcms
    Go To Robot Campaign    ${campaign_deactive}
    ${code}=   Create Promotion   &{TC4}
    ${promotion_id}=   Py Get Promotion Id    ${campaign_deactive}    &{TC4}[name]

    Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
     ...  Code Text Th    Code Text En
     ...  Discount Text Th    Discount Text En
     ...  1

## Test steps
# 1. Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA
    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}


## Expected result
# 1.1 API is returned total code of pkey AAA is 0
# 1.2 API is returned promotion_code of pkey AAA is null
# 1.3 API is returned 'display_thumb' = "1"

    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
    ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
    Should Be Equal As Integers   ${total_code}   0
    Should Be Equal    ${promotion_code}   []
    Should Be Equal As Integers   ${display_thumb}   1

    [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_deactive}  &{TC4}[name]
    ...   AND   Close All Browsers


TC_ITMWM_05407 - TC_ITMWM_05407 To verify that API get promotion level D is returned 1 pkey and total code product A = 0 and if campaign is expired
    [Tags]       ITMA-3293   TC_ITMWM_05407      TC5

## Prerequisite
# 1. Create promotion code A cart with condition type as 'single_code' effect product A (Product)
# 2. Promotion A is in Campaign C1
# 3. promotion A is allowed display on web and display on thumbnail
# 4. promotion A is not excluded product A
# 5. Campaign C1 is activated.
# 6. Campaign C1 is expired
# 7. promotion A is activated.
# 8. promotion A is not expired
# 9. promotion A is not set specific date


    ${product}=         DB Product - Get Product
    #Log To Console      ${product}
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
    ${product_title}=    Get From Dictionary    ${product[0]}    product_title

    Set To Dictionary   ${TC5}   dc_on_follow_value=${product_title}

    Login Pcms
    Go To Robot Campaign    ${campaign_expire}
    ${code}=   Create Promotion   &{TC5}
    ${promotion_id}=   Py Get Promotion Id    ${campaign_expire}    &{TC5}[name]

    Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
     ...  Code Text Th    Code Text En
     ...  Discount Text Th    Discount Text En
     ...  1

# Test steps
# 1. Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA

    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}


## Expected result
# 1.1 API is returned total code of pkey AAA is 0
# 1.2 API is returned promotion_code of pkey AAA is null
# 1.3 API is returned 'display_thumb' = "1"

    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
    ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
    Should Be Equal As Integers   ${total_code}   0
    Should Be Equal    ${promotion_code}   []
    Should Be Equal As Integers   ${display_thumb}   1

    [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_expire}  &{TC5}[name]
    ...   AND   Close All Browsers



TC_ITMWM_05408 - To verify that API get promotion level D is returned 1 pkey and unique code product A = 0 if promotion code is deactivated
    [Tags]       ITMA-3293   TC_ITMWM_05408      TC6

## Prerequisite
# 1. Create promotion code A cart with condition type as 'single_code' effect product A (Product)
# 2. Promotion A is in Campaign C1
# 3. promotion A is allowed display on web and display on thumbnail
# 4. promotion A is not excluded product A
# 5. Campaign C1 is activated.
# 6. Campaign C1 is not expired
# 7. promotion A is deactivated.
# 8. promotion A is not expired
# 9. promotion A is not set specific date

    ${product}=         DB Product - Get Product
    #Log To Console      ${product}
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
    ${product_title}=    Get From Dictionary    ${product[0]}    product_title

    Set To Dictionary   ${TC6}   dc_on_follow_value=${product_title}

    Login Pcms
    Go To Robot Campaign    ${campaign_normal}
    ${code}=   Create Promotion   &{TC6}
    ${promotion_id}=   Py Get Promotion Id    ${campaign_normal}    &{TC6}[name]

    Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
     ...  Code Text Th    Code Text En
     ...  Discount Text Th    Discount Text En
     ...  1

## Test steps
# 1. Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA

    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}

## Expected result
# 1.1 API is returned total code of pkey AAA is 0
# 1.2 API is returned promotion_code of pkey AAA is null
# 1.3 API is returned 'display_thumb' = "1"

    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
    ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
    Should Be Equal As Integers   ${total_code}   0
    Should Be Equal    ${promotion_code}   []
    Should Be Equal As Integers   ${display_thumb}   1

    [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_normal}  &{TC6}[name]
    ...   AND   Close All Browsers



TC_ITMWM_05409 - To verify that API get promotion level D is returned 1 pkey and total code product A = 0 if promotion code is expired
    [Tags]       ITMA-3293   TC_ITMWM_05409      TC7

#     ${product}=         DB Product - Get Product
#     #Log To Console      ${product}
#     ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
#     ${product_title}=    Get From Dictionary    ${product[0]}    product_title

#     Set To Dictionary   ${TC7}   dc_on_follow_value=${product_title}

#     Login Pcms
#     Go To Robot Campaign    ${campaign_normal}
#     ${code}=   Create Promotion   &{TC7}
#     ${promotion_id}=   Py Get Promotion Id    ${campaign_normal}    &{TC7}[name]

#     Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
#      ...  Code Text Th    Code Text En
#      ...  Discount Text Th    Discount Text En
#      ...  1

# ## Test steps
# # 1. Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA

#     Create Http Context   ${PCMS_URL_API}   http
#     HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
#     ${body}=  Get Response Body
#     Log To Console  body=${body}

# ## Expected result
# # 1.1 API is returned total code of pkey AAA is 0
# # 1.2 API is returned promotion_code of pkey AAA is null
# # 1.3 API is returned 'display_thumb' = "1"

#     ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
#     ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
#     ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
#     Should Be Equal As Integers   ${total_code}   0
#     Should Be Equal    ${promotion_code}   []
#     Should Be Equal As Integers   ${display_thumb}   1

#     [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_normal}  &{TC7}[name]
#     ...   AND   Close All Browsers


TC_ITMWM_05410 - To verify that API get promotion level D is returned 2 pkey and unique_code product A = 1 if promotion code A, promotion code B is not set specific date
    [Tags]       ITMA-3293   TC_ITMWM_05410      TC8

## Prerequisite
# 1. Create promotion code A cart with condition type as 'single_code' effect product A (Product)
# 2. Promotion A is in Campaign C1
# 3. promotion A is allowed display on web
# 4. promotion A is not excluded product A
# 5. Campaign C1 is activated.
# 6. Campaign C1 is not expired
# 7. promotion A is activated.
# 8. promotion A is not expired
# 9. promotion A is not set specific date time
# 10. Promotion A is in group bundle

    ${product}=         DB Product - Get Product
    #Log To Console      ${product}
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
    ${product_title}=    Get From Dictionary    ${product[0]}    product_title

    Set To Dictionary   ${TC8}   dc_on_follow_value=${product_title}

    Login Pcms
    Go To Robot Campaign    ${campaign_normal}
    ${code}=   Create Promotion   &{TC8}
    ${promotion_id}=   Py Get Promotion Id    ${campaign_normal}    &{TC8}[name]

    Promotion - Manage Display   ${promotion_id}  1  0   Text Title Th     Text Title En
     ...  Code Text Th    Code Text En
     ...  Discount Text Th    Discount Text En
     ...  1

## Test steps
# 1. Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA
# Test data  (Optional)

    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}

## Expected result
# 1.1 API is returned total code of pkey AAA is 1
# 1.2 API is returned first_promotion_code of pkey AAA is not null
# 1.3 API is returned 'display_thumb' = "0"
# 1.4 API is returned 'th_TH', 'en_US'

    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${promotion_code}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code
    ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
    Should Be Equal As Integers   ${total_code}   1
    Should Not Be Equal    []]    ${promotion_code}    Promotion Code is null
    Should Be Equal As Integers   ${display_thumb}   0

    [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_normal}  &{TC8}[name]
    ...   AND   Close All Browsers



TC_ITMWM_05411 - To verify that API get promotion level D is returned 1 pkey and unique_code product A = 2 if specific date of promotion A, promotion B is matched
    [Tags]       ITMA-3293   TC_ITMWM_05411      TC9

## Prerequisite
# 1. Create promotion code A cart with condition type as 'single_code' effect product A (Product)
# 2. Promotion A is in Campaign C1
# 3. promotion A is allowed display on web
# 4. promotion A is not excluded product A
# 5. Campaign C1 is activated.
# 6. Campaign C1 is not expired
# 7. promotion A is activated.
# 8. promotion A is not expired
# 9. promotion A is matched with specific date time
# 10. Promotion A is in group general
# 11. Promotion B is in group bundle

    ${product}=         DB Product - Get Product
    #Log To Console      ${product}
    ${product_pkey}=    Get From Dictionary    ${product[0]}    product_pkey
    ${product_title}=    Get From Dictionary    ${product[0]}    product_title

    Set To Dictionary   ${TC9_1}   dc_on_follow_value=${product_title}
    Set To Dictionary   ${TC9_2}   dc_on_follow_value=${product_title}

    Login Pcms
    Go To Robot Campaign    ${campaign_normal}
    ${code_1}=   Create Promotion   &{TC9_1}
    ${promotion_id_1}=   Py Get Promotion Id    ${campaign_normal}    &{TC9_1}[name]

    Promotion - Manage Display   ${promotion_id_1}  1  0   Text Title Th     Text Title En
     ...  Code Text Th    Code Text En
     ...  Discount Text Th    Discount Text En
     ...  1

    Go To Robot Campaign    ${campaign_normal}
    ${code_2}=   Create Promotion   &{TC9_2}
    ${promotion_id_2}=   Py Get Promotion Id    ${campaign_normal}    &{TC9_2}[name]

    Promotion - Manage Display   ${promotion_id_2}  1  0   Text Title Th     Text Title En
     ...  Code Text Th    Code Text En
     ...  Discount Text Th    Discount Text En
     ...  1

## Test steps
# 1. Call API http://pcms-report.itruemart-dev.com/api/xxxxx/get-promotions/AAA
# Test data  (Optional)

    Create Http Context   ${PCMS_URL_API}   http
    HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions/${product_pkey}
    ${body}=  Get Response Body
    Log To Console  body=${body}


# Expected result
# 1.1 API is returned total code of pkey AAA is 2
# 1.2 API is returned first_promotion_code of pkey AAA is null
# 1.3 API is returned 'display_thumb' = "0"
# 1.4 API is returned 'th_TH', 'en_US'
# 1.5 Display Promotion sort as promotion A , Promotion B

    ${total_code}=  Get Json Value  ${body}  /data/${product_pkey}/total_code
    ${display_thumb}=  Get Json Value  ${body}  /data/${product_pkey}/display_thumb
    Should Be Equal As Integers   ${total_code}   2
    Should Be Equal As Integers   ${display_thumb}   0

    ${th}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code/0/th_TH
    ${en}=  Get Json Value  ${body}  /data/${product_pkey}/promotion_code/0/en_US

    Should Not Be Equal    []]    ${th}    Promotion Code (TH) is null
    Should Not Be Equal    []]    ${en}    Promotion Code (EN) is null


    [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_normal}  &{TC9_1}[name]
    ...   AND   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_normal}  &{TC9_2}[name]
    ...   AND   Close All Browsers
