*** Settings ***

Library    HttpLibrary.HTTP
Library    Collections
Library    ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library    ${CURDIR}/../../../../Python_Library/product.py
Library    ${CURDIR}/../../../../Python_Library/csv_library.py
Library    ${CURDIR}/../../../../Python_Library/common/csvlibrary.py

Resource   ${CURDIR}/../../../../Keyword/Common/keywords_wemall_common.robot

Resource   ${CURDIR}/../../../../Keyword/API/api_storefronts/storefront_keywords.robot
*** Keywords ***

Database Product - Get Sku Normal
	Wemall Common - Init Test Variable
	# ${inv_id}=   get_1inventory_id
    ${inv_id}=    product.get_inventory_normal
	@{product}=   Get Product Detail   ${inv_id}
    # Log To Console    inv id = ${inv_id}
    # Log To Console    product = @{product}
	Wemall Common - Assign Value To Test Variable   inv_id   ${inv_id}
	Wemall Common - Assign Value To Test Variable   product_pkey   @{product}[1]
	Wemall Common - Assign Value To Test Variable   product_slug   @{product}[3]
    # Log To Console    inv id = ${inv_id}
    # Log To Console    product1 = @{product}[1]
    # Log To Console    product3 = @{product}[3]
	[Return]   ${inv_id}

#get_2inventory_ids_same_collection_diff_product
DB Product - Prepare 2 Sku Normal Same Collection Diff Product To Test Variable
	@{inv_id}=   get_2inventory_ids_same_collection_diff_product

	${product_1}=  Get Product Detail   @{inv_id}[0]
	${product_2}=  Get Product Detail   @{inv_id}[1]

	Log To Console   product_1=${product_1}
	Log To Console   product_2=${product_2}
	#Wemall Common - Debug   ${product_1}   product_1
	#Wemall Common - Debug   ${product_2}   product_2

	Wemall Common - Assign Value To Test Variable  inv_id_1   @{inv_id}[0]
	Wemall Common - Assign Value To Test Variable  inv_id_2   @{inv_id}[1]

	${product_id_1}=   Get From List   ${product_1}  0
	${product_pkey_1}=   Get From List   ${product_1}  1
	${product_name_1}=   Get From List   ${product_1}  2
	${product_slug_1}=   Get From List   ${product_1}  3
	${product_has_variant_1}=  Get From List  ${product_1}   4

	${product_id_2}=   Get From List   ${product_2}  0
	${product_pkey_2}=   Get From List   ${product_2}  1
	${product_name_2}=   Get From List   ${product_2}  2
	${product_slug_2}=   Get From List   ${product_2}  3
	${product_has_variant_2}=  Get From List  ${product_2}   4

	Wemall Common - Assign Value To Test Variable  product_id_1  ${product_id_1}
	Wemall Common - Assign Value To Test Variable  product_pkey_1  ${product_pkey_1}
	Wemall Common - Assign Value To Test Variable  product_name_1  ${product_name_1}
	Wemall Common - Assign Value To Test Variable  product_slug_1  ${product_slug_1}
	Wemall Common - Assign Value To Test Variable  product_has_variant_1  ${product_has_variant_1}

	Wemall Common - Assign Value To Test Variable  product_id_2  ${product_id_2}
	Wemall Common - Assign Value To Test Variable  product_pkey_2  ${product_pkey_2}
	Wemall Common - Assign Value To Test Variable  product_name_2  ${product_name_2}
	Wemall Common - Assign Value To Test Variable  product_slug_2  ${product_slug_2}
	Wemall Common - Assign Value To Test Variable  product_has_variant_2  ${product_has_variant_2}

	@{products}=   Create List   ${product_1}   ${product_2}
	[Return]   @{products}
	#Log Variables

DB Product - Prepare 2 Sku Normal
	@{inv_id}=   get_2inventory_ids_same_product_diff_variant
	@{product_1}=   Get Product Detail  @{inv_id}[0]
	@{product_2}=   Get Product Detail  @{inv_id}[1]


DB Product - Prepare Product To Excel
	@{product}=   product.Py Get Product Normal Without Alias   4
	${file_name}=   helper.get_canonical_path  ${CURDIR}/../../../../Resource/TestData/Alias/template_mass_alias_upload.csv
	Log To console   robot_file_name=${file_name}


	${header}=   Create List  Product Pkey
	${product_list}=   Create List   ${header}
	:FOR  ${index}  IN  @{product}
	\   ${product_pkey}=   Get From Dictionary   ${index}   product_pkey
	\   ${append_key}=   Create List    ${product_pkey}
	\   Append To List   ${product_list}   ${append_key}


	#Empty Csv File   ${file_name}
	Log TO console   ${product_list}


	#Log TO console   product=${product}
	csvlibrary.create_file    ${file_name}   ${product_list}

	#Py Write Data To Csv  ${product}  ${file_name}


DB Product - Get Product
	[Arguments]   ${total}=1
	@{product}=   Py Get Product Normal Without Alias   ${total}
	[Return]   @{product}

DB Product - Prepare 2 Products To Test Variable
	${products}=   DB Product - Get Product   2
	Log To Console   ${products}

DB Product - Prepare Inv Id 1 To Test Variable Inv Id
	${inv_id}=   Wemall Common - Get Value From Test Variable  inv_id_1
	Wemall Common - Debug   ${inv_id}    inv_id_prepare_inv_id_1_to_Test
	Wemall Common - Assign Value To Test Variable  inv_id   ${inv_id}

DB Product - Prepare Inv Id 2 To Test Variable Inv Id
	${inv_id}=   Wemall Common - Get Value From Test Variable  inv_id_2
	Wemall Common - Assign Value To Test Variable  inv_id   ${inv_id}

DB Product - Prepare Inv Id 3 To Test Variable Inv Id
	${inv_id}=   Wemall Common - Get Value From Test Variable  inv_id_3
	Wemall Common - Assign Value To Test Variable  inv_id   ${inv_id}


DB Product - Get Merchant Code From Product API

	${list_product_pkey}=   Wemall Common - Get Value From Test Variable    list_product_pkey

	${total_pkey}=   Get Length  ${list_product_pkey}

	:FOR  ${index}  IN RANGE  0  ${total_pkey}
	\  Create Http Context    ${PCMS_API_URL}   http
	\  HttpLibrary.HTTP.GET    ${PCMS_PKEY}/products/${list_product_pkey[${index}]}

	\  ${body}=   Get Response Body
	\  ${merchant_code}=   Get Json Value  ${body}  /data/merchant_code
	\  ${merchant_name}=   Get Json Value  ${body}  /data/merchant_name
	\  ${merchant_code}=  Replace String  ${merchant_code}  "  ${EMPTY}
	\  ${storefront}=   API Storefront - Get Storefront Detail   ${merchant_code}
	\  ${header}=  Get Json Value  ${storefront}  /data/header

	\  ${merchant_list_exist}=  Run Keyword And Return Status  Variable Should Exist  ${merchant_header_list}

	\  Wemall Common - Debug   ${merchant_list_exist}   merchant_header_exist
	\  Wemall Common - Debug   ${list_product_pkey[${index}]}  product_pkey
	\  Wemall Common - Debug   ${merchant_code}  merchant_code
	\  Wemall Common - Debug   ${merchant_name}  merchant_name
	\  Wemall Common - Debug   ${index}   index
	\  Wemall Common - Debug   ${header}   header

	# \  Run Keyword If  '${merchant_list_exist}' == '${True}'  Append To List  ${merchant_header_list}  ${header}
	# \  ${merchant_header_list}=   Run Keyword If  '${merchant_list_exist}' == '${False}'  Create List  ${header}   ELSE  Continue For Loop
	\  Run Keyword If  '${merchant_list_exist}' == '${True}'  Append To List  ${merchant_header_list}  ${merchant_code}
	\  ${merchant_header_list}=   Run Keyword If  '${merchant_list_exist}' == '${False}'  Create List  ${merchant_code}   ELSE  Continue For Loop

	Wemall Common - Assign Value To Test Variable  merchant_header_list  ${merchant_header_list}





Get 1 Sku Is In Product That Other Sku Has Price Not Equal

	${test_var_exist}=   Run Keyword And Return Status   Variable Should Exist  ${TEST_VAR}

	Run Keyword If   '${test_var_exist}' == '${False}'   Run Keywords   ${dict}=   Create Dictionary   page=mobile_level_d
	...  AND   Set Test Variable  ${TEST_VAR}   ${dict}

	${product_id}=     get_product_has_sku_diff_price

	${return}=   get_sku_by_product_id  ${product_id}

	${inv_id}=   Get From Dictionary   ${return}   inv_id
	Log to console  inv_id=${inv_id}

	${style_options}=   Get From Dictionary   ${return}   data


	${product}=   Get Product Detail    ${inv_id}
	${product_pkey}=   Get From List   ${product}   1
	${product_slug}=   Get From List   ${product}   3

	Log to console   ===============================================================${\n}
	Log to console   product_pkey=${product_pkey} ${\n}
	Log to console   product_slug=${product_slug} ${\n}
	Log to console   default_inv_id=${inv_id} ${\n}
	Log to console   style_options=${style_options} ${\n}
	Log to console   ===============================================================${\n}


	${dict}=   Set Variable   ${TEST_VAR}
	Set To Dictionary   ${dict}   product_pkey=${product_pkey}
	Set To Dictionary   ${dict}   product_slug=${product_slug}
	Set To Dictionary   ${dict}   default_inv_id=${inv_id}
	Set To Dictionary   ${dict}   style_options=${style_options}
	Set Test Variable   ${TEST_VAR}  ${dict}

Set Product Collection By ID
    [Arguments]    ${ProductID}    ${CollectionID}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    Follow Response
    ${status}    Get Response Status
    Should Start With    ${status}    200
    #Set Product Collection
    Set Request Header    Location    ${PCMS_URL}/products/collection
    Set Request Body    collection[]=${CollectionID}
    HttpLibrary.HTTP.POST    /products/collection/set/${ProductID}?return-collection=
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Prepare 3 Product different brand
    ${brand_id_arr}=    py_get_product_different_brand    3

    ${brand_id1}=    Get From List    ${brand_id_arr[0]}    0
    ${brand_id2}=    Get From List    ${brand_id_arr[1]}    0
    ${brand_id3}=    Get From List    ${brand_id_arr[2]}    0

    ${product1}=     py_get_product_normal_by_brand_id    ${brand_id1}
    ${product2}=     py_get_product_normal_by_brand_id    ${brand_id2}
    ${product3}=     py_get_product_normal_by_brand_id    ${brand_id3}

    ${product} =   Create Dictionary    0=${product1}    1=${product2}    2=${product3}

    [Return]    ${product}

Prepare 1 Product Normal Not Has Variant
    &{product}=   py_get_product_normal_not_has_variant
    # Log To Console    ${product}
    [Return]    &{product}

Prepare 1 Normal Product Has Variant To Test Variable
    [Arguments]   ${product_dic_key}=normal_product   #u se to call in ${TEST_VAR} ex.${TEST_VAR.normal_product}
    ${product}=   py_get_product_normal_has_variant    1   ${PRODUCT-MATCH-FREEBIE}
    ${product_pkey}=    Get From Dictionary   ${product}   product_pkey
    ${inventory_id}=    Get From Dictionary   ${product}   inventory_id
    ${variant_id}=      Get From Dictionary   ${product}   variant_id
    ${variant_price}=   Get From Dictionary   ${product}   variant_price
    ${product_name}=    get_product_name_by_pkey   ${product_pkey}
    Adjust Stock Remaining By Inventory ID    ${inventory_id}    100

    ${prepared_product}=   Create Dictionary
    ...   product_pkey=${product_pkey}
    ...   inventory_id=${inventory_id}
    ...   variant_price=${variant_price}
    ...   variant_id=${variant_id}
    ...   product_name=${product_name}
    Wemall Common - Assign Value To Test Variable   ${product_dic_key}   ${prepared_product}

Prepare 1 Normal Product Not Has Variant To Test Variable
    [Arguments]   ${product_dic_key}=normal_product   #u se to call in ${TEST_VAR} ex.${TEST_VAR.normal_product}
    ${product}=   py_get_product_normal_not_has_variant    1   ${PRODUCT-MATCH-FREEBIE}
    ${product_pkey}=    Get From Dictionary   ${product}   product_pkey
    ${inventory_id}=    Get From Dictionary   ${product}   inventory_id
    ${variant_id}=      Get From Dictionary   ${product}   variant_id
    ${variant_price}=   Get From Dictionary   ${product}   variant_price
    ${product_name}=    get_product_name_by_pkey   ${product_pkey}
    Adjust Stock Remaining By Inventory ID    ${inventory_id}    100

    ${prepared_product}=   Create Dictionary
    ...   product_pkey=${product_pkey}
    ...   inventory_id=${inventory_id}
    ...   variant_price=${variant_price}
    ...   variant_id=${variant_id}
    ...   product_name=${product_name}
    Wemall Common - Assign Value To Test Variable   ${product_dic_key}   ${prepared_product}

Prepare 1 Product Normal Not Has Variant Allow COD
    &{product}=   py_get_product_normal_not_has_variant_allow_cod
    # Log To Console    ${product}
    [Return]    &{product}

DB Product - Get 2 Inventory Ids Diff Brand
	@{products}=   get_2inventory_ids_diff_brand
	[Return]   @{products}

DB Product - Get 2 Inventory Ids Diff Collection
	@{products}=    get_2inventory_ids_diff_collection
	[Return]   @{products}