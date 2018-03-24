*** Settings ***
Force Tags        WLS_API_PCMS
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
	${is_exist}=   Is Exist Campaign   ${campaign_name}
	#Log To Console   is_exist=${is_exist}
	Run Keyword If  '${is_exist}' == '${False}'   Promotion - Create Campaign  ${campaign_name}   No


*** Variables ***

${campaign_name}   ANTMAN MANAGE DISPLAY ROBOT

&{TC_ITMWM_05393}  name=TC_ITMWM_05393
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC2}     name=Single-Unlimit-All_Cart-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC3}     name=Single-Unlimit-All_Cart-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=100
    ...    dc_maximum=${EMPTY}
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
   # ...    dc_on_follow_value=
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC4}     name=Single-Unlimit-All_Cart-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=100
    ...    dc_maximum=${EMPTY}
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
   # ...    dc_on_follow_value=
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC_ITMWM_05397}    name=TC_ITMWM_05397
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=100
    ...    dc_maximum=${EMPTY}
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
   # ...    dc_on_follow_value=
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC_ITMWM_05398}    name=TC_ITMWM_05398
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=100
    ...    dc_maximum=${EMPTY}
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
   # ...    dc_on_follow_value=
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC_ITMWM_05399}    name=TC_ITMWM_05399
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=100
    ...    dc_maximum=${EMPTY}
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
   # ...    dc_on_follow_value=
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC_ITMWM_05400}   name=TC_ITMWM_05400
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    #...    dc_on_exclude_value=TRUE BEYOND 4G
    ...    budget=PC1
    ...    card=${EMPTY}


&{TC9}     name=TC_ITMWM_05401
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=
    #...    dc_on_exclude_value=TRUE BEYOND 4G
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC10}     name=TC_ITMWM_05402
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=product    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=
    #...    dc_on_exclude_value=TRUE BEYOND 4G
    ...    budget=PC1
    ...    card=${EMPTY}



*** Test Cases ***
TC_ITMWM_05393 To verify that API get promtion level C is returned 2 pkey and total code product A is 0 and product B = 0 if do not have any promotion effect with product A and product B

	[Tags]   TC_ITMWM_05393   ready  regression    WLS_Medium
	### For Antman
	#${pkey1}=   Set Variable    2259507458632
	#${pkey2}=   Set Variable    2208581723976

	#### For Alpha  #####
	${pkey1}=   Set Variable   2664786660556
	${pkey2}=   Set Variable   2536354175614

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])



	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	Log To Console  body=${body}
	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	Should Be Equal As Integers   ${total_code_product_1}   0
	Should Be Equal As Integers   ${total_code_product_2}   0


	[Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC_ITMWM_05393}[name]
	...   AND   Close All Browsers



TC_ITMWM_05394 To verify that API get promotion level C is returned 2 pkey and total code product A = 0 and product B = 0 if promotion code is effect with product A, B is not set allow display on web
	[Tags]   TC_ITMWM_05394   ready  regression    WLS_Medium
	### For Antman
	${pkey1}=   Set Variable    2259507458632
	${pkey2}=   Set Variable    2438379742814

	#### For Alpha  #####
	#${pkey1}=   Set Variable   2664786660556
	#${pkey2}=   Set Variable   2536354175614

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	#Log to console   product-Pkey=${product_pkey}

	${product_name_lists}=   Set Variable   ${product_names[0]}
	# ${product_name_lists}=   Evaluate   ','.join(${product_names})


	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])

	Log To Console  pkey_lists=${pkey_lists}

	Set To Dictionary   ${TC2}   dc_on_follow_value=${product_name_lists}

	Log To Console   campaign_name=${campaign_name}
	Login Pcms
	Go To Robot Campaign    ${campaign_name}
	${code}=   Create Promotion   &{TC2}
	Log To Console  coupon_code=${code}

	${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC2}[name]
	Log To Console   promotion_id=${promotion_id}

	Promotion - Manage Display   ${promotion_id}  0  1   Text Title Th     Text Title En
	 ...  Code Text Th    Code Text En
	 ...  Discount Text Th    Discount Text En
	 ...  1

	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	Log To Console  body=${body}
	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
	${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code


	Should Be Equal As Integers   ${total_code_product_1}   0
	Should Be Equal As Integers   ${total_code_product_2}   0

	Should Be Equal    ${promotion_code_1}   []
	Should Be Equal    ${promotion_code_2}   []


	[Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC2}[name]
	...   AND   Close All Browsers

TC_ITMWM_05395 To verify that API get promotion level C is returned 2 pkey and total code product A = 0 and product B = 0 if promotion code that effect with product B is set excluded product B
	[Tags]  TC_ITMWM_05395  ready   regression    WLS_Medium

	### For Antman
	${pkey1}=   Set Variable    2259507458632
	${pkey2}=   Set Variable    2438379742814

	#### For Alpha  #####
	#${pkey1}=   Set Variable   2664786660556
	#${pkey2}=   Set Variable   2536354175614

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Log To Console   row=${row}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	Log To console  product_names=${product_names}

	${product_name_lists}=   Set Variable   ${product_names[0]}



	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])

	Log To Console  pkey_lists=${pkey_lists}

	Set To Dictionary   ${TC3}   dc_on_follow_value=${product_name_lists}

	Login Pcms
	Go To Robot Campaign    ${campaign_name}
	${code}=   Create Promotion   &{TC3}
	Log To Console  coupon_code=${code}

	${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC3}[name]
	Log To Console   promotion_id=${promotion_id}

	Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
	 ...  Code Text Th    Code Text En
	 ...  Discount Text Th    Discount Text En
	 ...  1


	Log To Console   product_pkey=${product_pkey}
	Promotion - Go To Mass Upload Excluded Product   ${promotion_id}
	Promotion - Choose File For Mass Upload Excluded Product    ${product_pkey}


	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	Log To Console  body=${body}

	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
	${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

	Should Be Equal As Integers   ${total_code_product_1}   0
	Should Be Equal As Integers   ${total_code_product_2}   0

	Should Be Equal   ${promotion_code_1}   []
	Should Be Equal   ${promotion_code_2}   []

	[Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC3}[name]
	...   AND    Close All Browsers

TC_ITMWM_05396 To verify that API get promotion level C is returned 2 pkey and total code product A = 0 and product B = 0 if campaign is deactivated
	[Tags]  TC_ITMWM_05396   ready    regression    WLS_Medium

	### For Antman
	#${pkey1}=   Set Variable    2259507458632
	#${pkey2}=   Set Variable    2208581723976

	#### For Alpha  #####
	${pkey1}=   Set Variable   2664786660556
	${pkey2}=   Set Variable   2438379742814

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Log To Console   row=${row}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	Log To console  product_names=${product_names}

	${product_name_lists}=   Set Variable   ${product_names[0]}



	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])

	Log To Console  pkey_lists=${pkey_lists}

	Set To Dictionary   ${TC4}   dc_on_follow_value=${product_name_lists}

	Login Pcms
	Go To Robot Campaign    ${campaign_name}


	${code}=   Create Promotion   &{TC4}
	Log To Console  coupon_code=${code}
	${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC4}[name]
	Log To Console   promotion_id=${promotion_id}


	${campaign_id}=   Get Campaign Id By Name   ${campaign_name}
	Log To Console  campaign_id=${campaign_id}

	${r}=   Set Campaign Deactivate   ${campaign_id}
	Log To Console   r=${r}

	Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
	 ...  Code Text Th    Code Text En
	 ...  Discount Text Th    Discount Text En
	 ...  1


	Log To Console   product_pkey=${product_pkey}




	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	Log To Console  body=${body}

	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
	${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

	Should Be Equal As Integers   ${total_code_product_1}   0
	Should Be Equal As Integers   ${total_code_product_2}   0

	Should Be Equal   ${promotion_code_1}   []
	Should Be Equal   ${promotion_code_2}   []

	[Teardown]   Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC4}[name]
	...   AND    Close All Browsers
	...   AND    Set Campaign activate   ${campaign_id}

TC_ITMWM_05397 To verify that API get promotion level C is returned 2 pkey and total code product A = 0 and product B = 0 if campaign is expired
	[Tags]  TC_ITMWM_05397   ready   regression    WLS_Medium
	### For Antman
	#${pkey1}=   Set Variable    2259507458632
	#${pkey2}=   Set Variable    2208581723976

	#### For Alpha  #####
	${pkey1}=   Set Variable   2664786660556
	${pkey2}=   Set Variable   2438379742814

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Log To Console   row=${row}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	Log To console  product_names=${product_names}

	${product_name_lists}=   Set Variable   ${product_names[0]}

	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])

	Log To Console  pkey_lists=${pkey_lists}

	Set To Dictionary   ${TC_ITMWM_05397}   dc_on_follow_value=${product_name_lists}

	Login Pcms
	Go To Robot Campaign    ${campaign_name}


	${code}=   Create Promotion   &{TC_ITMWM_05397}
	Log To Console  coupon_code=${code}

	${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC_ITMWM_05397}[name]
	Log To Console   promotion_id=${promotion_id}


	${campaign_id}=   Get Campaign Id By Name   ${campaign_name}
	Log To Console  campaign_id=${campaign_id}

	${r}=   Set Campaign Expire   ${campaign_id}
	Log To Console   r=${r}

	Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
	 ...  Code Text Th    Code Text En
	 ...  Discount Text Th    Discount Text En
	 ...  1


	Log To Console   product_pkey=${product_pkey}




	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	Log To Console  body=${body}
	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
	${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

	Should Be Equal As Integers   ${total_code_product_1}   0
	Should Be Equal As Integers   ${total_code_product_2}   0

	Should Be Equal   ${promotion_code_1}   []
	Should Be Equal   ${promotion_code_2}   []



	[Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC_ITMWM_05397}[name]
	...   AND   Set Campaign Not Expire   ${campaign_id}
	...   AND   Close All Browsers

TC_ITMWM_05398 To verify that API get promotion level C is returned 2 pkey and unique code product A = 0 and product B = 0 if promotion code is deactivated
	[Tags]  TC_ITMWM_05398   ready    regression    WLS_High

	### For Antman
	#${pkey1}=   Set Variable    2259507458632
	#${pkey2}=   Set Variable    2208581723976

	#### For Alpha  #####
	${pkey1}=   Set Variable   2664786660556
	${pkey2}=   Set Variable   2438379742814

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Log To Console   row=${row}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	Log To console  product_names=${product_names}

	${product_name_lists}=   Set Variable   ${product_names[0]}



	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])

	Log To Console  pkey_lists=${pkey_lists}

	Set To Dictionary   ${TC_ITMWM_05398}   dc_on_follow_value=${product_name_lists}

	Login Pcms
	Go To Robot Campaign    ${campaign_name}


	${code}=   Create Promotion   &{TC_ITMWM_05398}
	#Log To Console  coupon_code=${code}



	${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC_ITMWM_05398}[name]
	Log To Console   promotion_id=${promotion_id}

	${r}=   Set Promotion Deactivate   ${promotion_id}
	Log To Console   r=${r}

	Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
	 ...  Code Text Th    Code Text En
	 ...  Discount Text Th    Discount Text En
	 ...  1


	#Log To Console   product_pkey=${product_pkey}




	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	#Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	#Log To Console  body=${body}
	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
	${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

	Should Be Equal As Integers   ${total_code_product_1}   0
	Should Be Equal As Integers   ${total_code_product_2}   0

	Should Be Equal   ${promotion_code_1}    []
	Should Be Equal   ${promotion_code_2}    []

	[Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC_ITMWM_05398}[name]
	...   AND    Close All Browsers

TC_ITMWM_05399 To verify that API get promotion level C is returned 2 pkey and total code product A = 1 and product B = 0 if promotion code is expired
	[Tags]  TC_ITMWM_05399   promotion_expired   regression    ready    WLS_High

	#### For Alpha  #####
	${pkey1}=   Set Variable   2664786660556
	${pkey2}=   Set Variable   2438379742814

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Log To Console   row=${row}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	Log To console  product_names=${product_names}

	${product_name_lists}=   Set Variable   ${product_names[0]}

	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])
	Log To Console  pkey_lists=${pkey_lists}
	Set To Dictionary   ${TC_ITMWM_05399}   dc_on_follow_value=${product_name_lists}

	Login Pcms
	Go To Robot Campaign    ${campaign_name}


	${code}=   Create Promotion   &{TC_ITMWM_05399}
	Log To Console  coupon_code=${code}

	${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC_ITMWM_05399}[name]
	Log To Console   promotion_id=${promotion_id}


	${campaign_id}=   Get Campaign Id By Name   ${campaign_name}
	Log To Console  campaign_id=${campaign_id}

	${r}=   Py Set Promotion Expire   ${promotion_id}
	Log To Console   r=${r}

	Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
	 ...  Code Text Th    Code Text En
	 ...  Discount Text Th    Discount Text En
	 ...  1


	Log To Console   product_pkey=${product_pkey}




	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	Log To Console  body=${body}
	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
	${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

	Should Be Equal As Integers   ${total_code_product_1}   0
	Should Be Equal As Integers   ${total_code_product_2}   0

	Should Be Equal   ${promotion_code_1}   []
	Should Be Equal   ${promotion_code_2}   []

	[Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC_ITMWM_05399}[name]
	...    AND   Close All Browsers

TC_ITMWM_05400 To verify that API get promotion level C is returned 2 pkey and unique_code product A = 1 and product B = 1 if promotion code A, B is not set specific date
	[Tags]  TC_ITMWM_05400   ready   regression    WLS_High
	#### For Alpha  #####
	${pkey1}=   Set Variable   2664786660556
	${pkey2}=   Set Variable   2438379742814

	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
	${product_name_2}=   Get product Name By Pkey    ${pkey2}



	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
	@{products}=   Create List  ${product_1}  ${product_2}

	${product_names}=  Create List
	${product_pkey}=   Create List
	:FOR  ${row}  IN   @{products}
	\   Log To Console   row=${row}
	\   Append To List  ${product_names}  ${row[2]}
	\   Append To List  ${product_pkey}   ${row[1]}

	Log To console  product_names=${product_names}

	${product_name_lists}=   Set Variable   ${product_names[0]}



	${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])

	Log To Console  pkey_lists=${pkey_lists}

	Set To Dictionary   ${TC_ITMWM_05400}   dc_on_follow_value=${product_name_lists}

	Login Pcms
	Go To Robot Campaign    ${campaign_name}


	${code}=   Create Promotion   &{TC_ITMWM_05400}
	Log To Console  coupon_code=${code}

	${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC_ITMWM_05400}[name]
	Log To Console   promotion_id=${promotion_id}


	Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
	 ...  Code Text Th    Code Text En
	 ...  Discount Text Th    Discount Text En
	 ...  1

	Log To Console   product_pkey=${product_pkey}

	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
	${body}=  Get Response Body
	Log To Console  body=${body}
	${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
	${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

	${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
	${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

	Should Be Equal As Integers   ${total_code_product_1}   1
	Should Be Equal As Integers   ${total_code_product_2}   0

	Should Not Be Equal     ${promotion_code_1}   []
	Should Be Equal     ${promotion_code_2}   []

	[Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC_ITMWM_05400}[name]
	 ...    AND   Close All Browsers


# TC_ITMWM_05401 To verify that API get promotion level C is returned 2 pkey and unique_code product A = 1 and product B = 1 if specific date of product A, B is matched
# 	[Tags]  TC_ITMWM_05401   ready   regression


#     ${pkey1}=   Set Variable   2664786660556
# 	${pkey2}=   Set Variable   2536354175614

# 	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
# 	${product_name_2}=   Get product Name By Pkey    ${pkey2}



# 	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
# 	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
# 	@{products}=   Create List  ${product_1}  ${product_2}

#     ${product_names}=  Create List
#     ${product_pkey}=   Create List
#     :FOR  ${row}  IN   @{products}
#     \   Append To List  ${product_names}  ${row[2]}
#     \   Append To List  ${product_pkey}   ${row[1]}

#     #Log to console   product-Pkey=${product_pkey}
#     ${product_name_lists}=   Set Variable   ${product_names[0]}
#     ${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])
#     # Log To Console  pkey_lists=${pkey_lists}

#     Set To Dictionary   ${TC10}   dc_on_follow_value=${product_name_lists}


# ## Prepare Promotions
#     Login Pcms
#     Go To Robot Campaign    ${campaign_name}
#     ${code}=   Create Promotion   &{TC10}

#     ${campaign_id}=   Get Campaign Id By Name   ${campaign_name}
# 	Log To Console  campaign_id=${campaign_id}

#     ${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC10}[name]
#     Log To Console   promotion_id=${promotion_id}

#     Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
#      ...  Code Text Th    Code Text En
#      ...  Discount Text Th    Discount Text En
#      ...  1


# ## Expected
#     Create Http Context   ${PCMS_URL_API}   http
#     HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
#     Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
#     ${body}=  Get Response Body
#     Log To Console  body=${body}
#     ${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
#     ${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

#     ${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
#     ${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

#     Should Be Equal As Integers   ${total_code_product_1}   1
#     Should Be Equal As Integers   ${total_code_product_2}   0

#     Should Not Be Equal   ${promotion_code_1}  []
#     Should Be Equal   ${promotion_code_2}  []


#     #[Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC10}[name]
#     # ...   AND   Close All Browsers



# TC_ITMWM_05402 To verify that API get promotion level C is returned 2 pkey and unique_code product A = 0 and product B = 0 if specific date of product A, B is not matched
# 	[Tags]  TC_ITMWM_05402   ready  regression


#     ${pkey1}=   Set Variable   2664786660556
# 	${pkey2}=   Set Variable   2536354175614

# 	${product_name_1}=   Get Product Name By Pkey    ${pkey1}
# 	${product_name_2}=   Get product Name By Pkey    ${pkey2}



# 	${product_1}=   Create List  111   ${pkey1}  ${product_name_1}
# 	${product_2}=   Create List  222   ${pkey2}  ${product_name_2}
# 	@{products}=   Create List  ${product_1}  ${product_2}

#     ${product_names}=  Create List
#     ${product_pkey}=   Create List
#     :FOR  ${row}  IN   @{products}
#     \   Append To List  ${product_names}  ${row[2]}
#     \   Append To List  ${product_pkey}   ${row[1]}

#     #Log to console   product-Pkey=${product_pkey}
#     ${product_name_lists}=   Set Variable   ${product_names[0]}
#     ${pkey_lists}=   Evaluate  ','.join([str(i) for i in ${product_pkey}])
#     # Log To Console  pkey_lists=${pkey_lists}

#     Set To Dictionary   ${TC10}   dc_on_follow_value=${product_name_lists}


# ## Prepare Promotions
#     Login Pcms
#     Go To Robot Campaign    ${campaign_name}
#     ${code}=   Create Promotion   &{TC10}

#     ${promotion_id}=   Py Get Promotion Id    ${campaign_name}    &{TC10}[name]
#     Log To Console   promotion_id=${promotion_id}

#     Promotion - Manage Display   ${promotion_id}  1  1   Text Title Th     Text Title En
#      ...  Code Text Th    Code Text En
#      ...  Discount Text Th    Discount Text En
#      ...  1


# ## Expected
#     Create Http Context   ${PCMS_URL_API}   http
#     HttpLibrary.HTTP.GET    ${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
#     Log TO Console   ${PCMS_URL_API}${PCMS_PKEY}/get-promotions?pkey_list=${pkey_lists}
#     ${body}=  Get Response Body
#     Log To Console  body=${body}
#     ${total_code_product_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/unique_code
#     ${total_code_product_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/unique_code

#     ${promotion_code_1}=  Get Json Value  ${body}  /data/${product_pkey[0]}/promotion_code
#     ${promotion_code_2}=  Get Json Value  ${body}  /data/${product_pkey[1]}/promotion_code

#     Should Be Equal As Integers   ${total_code_product_1}   0
#     Should Be Equal As Integers   ${total_code_product_2}   0

#     Should Be Equal   ${promotion_code_1}   []
#     Should Be Equal   ${promotion_code_2}   []

#     [Teardown]    Run Keywords   Promotion - Remove Promotion By Campaign Name And Promotion Name  ${campaign_name}  &{TC10}[name]
#     ...   AND   Close All Browsers
