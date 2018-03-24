*** Keywords ***
Delete Category By Category ID
    [Arguments]    ${category_id}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Delete    ${PDS-API-URI}/categories/${category_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Delete Collection By Collection ID
    [Arguments]    ${collection_id}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Delete    ${PDS-API-URI}/collections/${collection_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Permanent Delete Category By Category ID
    [Arguments]    ${category_id}
    Create Http Context    ${API_GATEWAY_HOST}    http
    # Next Request May Not Succeed
    HttpLibrary.HTTP.Delete    ${PDS-API-URI}/categories/permanent/${category_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Permanent Delete Collection By Collection ID
    [Arguments]    ${collection_id}
    Create Http Context    ${API_GATEWAY_HOST}    http
    # Next Request May Not Succeed
    HttpLibrary.HTTP.Delete    ${PDS-API-URI}/collections/permanent/${collection_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get All Category
	Create Http Context    ${API_GATEWAY_HOST}    http
	Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/categories
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get All Collection
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/collections
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get All Merchant
	Create Http Context    ${API_GATEWAY_HOST}    http
	Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/merchants
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Category By Category ID
    [Arguments]    ${category_id}
	Create Http Context    ${API_GATEWAY_HOST}    http
	Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/categories/${category_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Category By Category Pkey
    [Arguments]    ${category_pkey}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/categories/pkey/${category_pkey}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Collection By Collection ID
    [Arguments]    ${collection_id}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/collections/${collection_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Category By Merchant Code
    [Arguments]    ${merchant_code}
    Create Http Context    ${API_GATEWAY_HOST}    http
	Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/merchants/${merchant_code}/categories?no-cache=1
    ${response}=    Get Response Body
	Return From Keyword    ${response}

Get Category Root By Merchant Code
    [Arguments]    ${merchant_code}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/merchants/${merchant_code}/categories/root
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Collection By Merchant Code
    [Arguments]    ${merchant_code}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/merchants/${merchant_code}/collections
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Product Under Category By Category ID
    [Arguments]     ${category_pkey}    ${filter}=?display_option=product
    Create Http Context    ${API_GATEWAY_HOST}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/categories/${category_pkey}/products${filter}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Json Value and Convert to List
    [Arguments]    ${json_string}    ${json_pointer}
    ${json_value}=    Get Json Value    ${json_string}    ${json_pointer}
    ${json_value}=    Parse Json    ${json_value}
    # Log List    ${json_value}
    Return From Keyword    ${json_value}

Verify Fail Response Status Code and Message
    [Arguments]    ${expected_status_code}    ${expected_message}    ${expected_data}=${EMPTY}
    Response Status Code Should Equal    ${expected_status_code}
    ${response}=     Get Response Body
    ${message}=      Get Json Value    ${response}    /message
    Should Be Equal As Strings    "${expected_message}"    ${message}
    Return From Keyword If    '${expected_data}'=='${EMPTY}'    No data field
    ${data}=    Get Json Value    ${response}    /data
    Should Be Equal As Strings    "${expected_data}"    ${data}

Verify Success Response Status Code and Message
    [Arguments]    ${expected_status_code}=200    ${expected_message}=success
    Response Status Code Should Equal    ${expected_status_code}
    ${response}=     Get Response Body
    ${message}=    Get Json Value    ${response}    /message
    Should Be Equal As Strings    "${expected_message}"    ${message}

Verify Success Response Status Code and Message From Add/Replace Products To Categories
    Should Be Equal    200    ${response_code}
    Json Value Should Equal    ${response_content}    /message    "success"

Verify Success Response Status Code and Content From Add/Replace Products To Categories
    [Arguments]    ${expected_total_rows}    ${expected_display}
    Verify Success Response Status Code and Message From Add/Replace Products To Categories
    Json Value Should Equal    ${response_content}    /data/total_rows    ${expected_total_rows}
    ${actual_display}=    Get Json Value    ${response_content}    /data/display
    ${actual_display}=    Parse Json    ${actual_display}
    Log    ${actual_display}
    Log    ${expected_display}
    Dictionaries Should Be Equal    ${expected_display}    ${actual_display}

Verify Response Data From Get All Categories
    ${response}=     Get Response Body
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    ${number_of_categories}=    Get Length    ${data}
    ${number_of_categories_db}=    Get Number of Categories in DB
    Should Be Equal    ${number_of_categories}    ${number_of_categories_db}
    ${1st_cat}=    Set Variable    @{data}[0]
    Log List    ${1st_cat}
    Verify Categories Between Data From Response and DB    ${1st_cat}

Verify Response Data From Get All Collections
    ${response}=     Get Response Body
    ${children}=    Get Json Value and Convert to List    ${response}    /data/children
    Log List    ${children}
    ${number_of_collections}=    Get Length    ${children}
    ${number_of_collections_db}=    Get Number of Collections in DB
    Should Be Equal    ${number_of_collections}    ${number_of_collections_db}
    ${1st_coll}=    Set Variable    @{children}[0]
    Log List    ${1st_coll}
    Verify Collections Between Data From Response and DB    ${1st_coll}

Verify Merchants Data From Response is sorted correctly
    # Sorting Condition:
    #    1.upper case A-Z then lower case A-Z
    #    2.ascii order
    [Arguments]    ${merchant_list}
    ${merchant_sorted}=    Copy List    ${merchant_list}
    ${merchant_sorted}=    Evaluate    sorted(${merchant_sorted}, key=lambda a: sum(([a[:i].lower(), a[:i]] for i in range(1, len(a)+1)),[]))
    Log List     ${merchant_list}
    Log List     ${merchant_sorted}
    Lists Should Be Equal    ${merchant_list}    ${merchant_sorted}

Verify Response Data From Get All Merchants
    ${response}=     Get Response Body
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    ${number_of_merchants}=    Get Length    ${data}
    ${number_of_merchants_db}=    Get Number of Merchant Alias and Merchant in DB
    Should Be Equal    ${number_of_merchants}    ${number_of_merchants_db}
    ${merchant_list}=    Create List    ${EMPTY}
    :FOR    ${i}    IN    @{data}
    \    ${merchant_item}=    Get From Dictionary    ${i}    merchant_name
    \    Append To List    ${merchant_list}    ${merchant_item}
    Verify Merchants Data From Response is sorted correctly    ${merchant_list}

Verify Response is Empty Data From Get All Categories
    ${response}=     Get Response Body
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    Should Be Empty    ${data}

Verify Response is Empty Data From Get All Collections
    ${response}=     Get Response Body
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    Should Be Empty    ${data}

Verify Response is Empty Data From Get All Merchants
    ${response}=     Get Response Body
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    Should Be Empty    ${data}

Verify Children Order of Category Root From Response is as Children Order in DB
    [Arguments]    ${response}
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    ${children_order_response}=    Create List
    :FOR    ${item}    IN    @{data}
    \    ${child_id}=    Get From Dictionary    ${item}    id
    \    ${child_id}=    Convert To String    ${child_id}
    \    Append To List    ${children_order_response}    ${child_id}
    ${children_order_db}=    Get Category Children Order of Root from DB
    Log List    ${children_order_response}
    Log List    ${children_order_db}
    Lists Should Be Equal    ${children_order_response}    ${children_order_db}

Verify Products From Response is Empty
    [Arguments]    ${response}
    ${products}=    Get Json Value and Convert to List    ${response}    /data/products
    Log List    ${products}
    Should Be Empty    ${products}

Verify Sub Category From Response is Empty
    [Arguments]    ${response}
    ${children}=    Get Json Value and Convert to List    ${response}    /data/children
    Log List    ${children}
    Should Be Empty    ${children}

Verify Sub Collection From Response is Empty
    [Arguments]    ${response}
    ${children}=    Get Json Value and Convert to List    ${response}    /data/children
    Log List    ${children}
    Should Be Empty    ${children}

Verify Number of Category From Response
    [Arguments]    ${response}    ${expected_number_of_cat}
    ${children}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${children}
    ${count}=    Get Length    ${children}
    Should Be Equal As Numbers    ${expected_number_of_cat}    ${count}

Verify Number of Collection From Response
    [Arguments]    ${response}    ${expected_number_of_coll}
    ${children}=    Get Json Value and Convert to List    ${response}    /data/children
    Log List    ${children}
    ${count}=    Get Length    ${children}
    Should Be Equal As Numbers    ${expected_number_of_coll}    ${count}

Verify Number of Sub Category and Level From Response
    [Arguments]    ${response}    ${expected_number_of_sub_cat}    ${expected_level_of_sub_cat}=2
    ${children}=    Get Json Value and Convert to List    ${response}    /data/children
    # Log List    ${children}
    ${count}=    Get Length    ${children}
    Should Be Equal As Numbers    ${expected_number_of_sub_cat}    ${count}
    @{keys}=    Get Dictionary Keys    ${children}
    :For    ${key}    IN    @{keys}
    \    ${child}=    Get From Dictionary    ${children}    ${key}
    \    ${level}=    Get From Dictionary    ${child}    level
    \    Should Be Equal As Numbers    ${expected_level_of_sub_cat}    ${level}

Verify Number of Sub Collection and Level From Response
    [Arguments]    ${response}    ${expected_number_of_sub_coll}    ${expected_level_of_sub_coll}=2
    ${children}=    Get Json Value and Convert to List    ${response}    /data/children
    Log List    ${children}
    ${count}=    Get Length    ${children}
    Should Be Equal As Numbers    ${expected_number_of_sub_coll}    ${count}
    : FOR    ${i}     IN RANGE    ${count}
    \    Log    i is ${i}
    \    ${level}=    Get From Dictionary    @{children}[${i}]    level
    \    Should Be Equal As Numbers    ${expected_level_of_sub_coll}    ${level}

Verify Response is category that has no product
    [Arguments]    ${response}    ${is_category_code}
    ${category_code}=     Get Json Value    ${response}    /data/category_code
    ${data}=              Get Json Value    ${response}    /data/data
    ${number_of_data}=    Get Json Value    ${response}    /data/number_of_data
    ${page}=              Get Json Value    ${response}    /data/page
    ${total_page}=        Get Json Value    ${response}    /data/total_page
    ${is_last_page}=      Get Json Value    ${response}    /data/is_last_page
    ${total_number_of_data}=    Get Json Value    ${response}    /data/total_number_of_data

    Should Be Equal               ${category_code}           "${is_category_code}"
    Should Be Equal As Strings    ${data}                    []
    Should Be Equal As Numbers    ${number_of_data}          0
    Should Be Equal As Numbers    ${total_number_of_data}    0
    Should Be Equal As Numbers    ${page}                    1
    Should Be Equal As Numbers    ${total_page}              0
    Should Be Equal               ${is_last_page}            true

Verify Response From API GET Product
# Verify Product Detail From Response
    [Arguments]    ${response}    ${product_pkey_list}
    ${data}=           Get Json Value and Convert to List    ${response}    /data
    ${product_list}=      Get From Dictionary    ${data}    data
    Log List    ${product_list}
    Log List    ${product_pkey_list}
    ${actual_number_of_products}=    Get Length    ${product_list}
    ${expected_number_of_products}=    Get Length    ${product_pkey_list}
    Should Be Equal    ${actual_number_of_products}    ${expected_number_of_products}
    :FOR    ${product_pkey}    IN    @{product_pkey_list}
    \      ${product_result}=    Filter Product By Pkey    ${product_list}    ${product_pkey}
    \      ${product_detail}=    Get Product Detail By Product Pkey    ${product_pkey}
    \      ${pkey_from_detail}=    Get From Dictionary    ${product_detail}    pkey
    \      ${pkey_from_result}=    Get From Dictionary    ${product_result}    pkey
    \      Verify Min Normal Price Product     ${product_result}    ${product_detail}
    \      Verify Max Normal Price Product     ${product_result}    ${product_detail}
    \      Verify Max Price Product     ${product_result}    ${product_detail}
    \      Verify Min Price Product     ${product_result}    ${product_detail}
    \      Verify Max Percent Discount Product     ${product_result}    ${product_detail}
    \      Verify Min Percent Discount Product     ${product_result}    ${product_detail}
    \      Verify Image Cover Product     ${product_result}    ${product_detail}
    \      Verify Installment Product     ${product_result}    ${product_detail}
    \      Verify Allow Cod Product     ${product_result}    ${product_detail}
    \      Verify Product Status     ${product_result}    ${pkey_from_result}
    \      Verify Product Active     ${product_result}    ${pkey_from_result}
    \      Should Be Equal     ${pkey_from_detail}     ${pkey_from_result}
    \      Verify stock of product    ${product_result}    ${product_pkey}

Verify stock of product
    [Arguments]    ${product_expect}    ${product_pkey}
    ${stock}=    Get From Dictionary    ${product_expect}    stock
    ${total_stock_remaing}=    Sum stock remaining for product    ${product_pkey}
    Should Be Equal    ${stock}    ${total_stock_remaing}

Filter Product By Pkey
    [Arguments]    ${product_list}     ${product_pkey}
    :FOR    ${product}    IN    @{product_list}
    \      ${pkey}=     Get From Dictionary    ${product}    pkey
    \      ${pkey}=     Convert To String      ${pkey}
    \      Run Keyword If    '${pkey}'=='${product_pkey}'    Return From Keyword     ${product}

Verify Product Status
    [Arguments]    ${product_expect}    ${pkey}
    ${product_status_expect}     Get From Dictionary    ${product_expect}    status
    ${product_status_db}     Get Product Status from DB by Product pkey    ${pkey}
     Should Be Equal     ${product_status_expect}     ${product_status_db}

Verify Product Active
    [Arguments]    ${product_expect}    ${pkey}
    ${product_active_expect}     Get From Dictionary    ${product_expect}    active
    ${product_active_db}     Get Active Status Number from DB by Product pkey    ${pkey}
     Should Be Equal     ${product_active_expect}     ${product_active_db}

Verify Image Cover Product
    [Arguments]    ${product_expect}     ${product_detail}
    ${image_cover_detail}     Get From Dictionary    ${product_detail}    image_cover
    ${image_cover_expect}     Get From Dictionary    ${product_expect}    image_cover
    Dictionaries Should Be Equal     ${image_cover_expect}     ${image_cover_detail}

Verify Installment Product
    [Arguments]    ${product_expect}     ${product_detail}
    ${installment_detail}     Get From Dictionary    ${product_detail}    installment
    ${installment_expect}     Get From Dictionary    ${product_expect}    installment
    Dictionaries Should Be Equal     ${installment_expect}     ${installment_detail}

Verify Allow Cod Product
    [Arguments]    ${product_expect}     ${product_detail}
    ${allow_cod_detail}     Get From Dictionary    ${product_detail}    allow_cod
    ${allow_cod_expect}     Get From Dictionary    ${product_expect}    allow_cod
    Should Be Equal     ${allow_cod_expect}     ${allow_cod_detail}

Verify Min Normal Price Product
    [Arguments]    ${product_expect}     ${product_detail}
    ${net_price_range}     Get From Dictionary    ${product_detail}    net_price_range
    ${min_price_from_detail}     Get From Dictionary    ${net_price_range}    min
    ${min_price_from_result}     Get From Dictionary    ${product_expect}    min_normal_price
    ${min_price_from_detail}  Convert To Integer    ${min_price_from_detail}
    ${min_price_from_result}  Convert To Integer    ${min_price_from_result}
    Should Be Equal     ${min_price_from_result}     ${min_price_from_detail}

Verify Max Normal Price Product
    [Arguments]    ${product_expect}     ${product_detail}
    ${net_price_range}     Get From Dictionary    ${product_detail}    net_price_range
    ${max_price_from_detail}     Get From Dictionary    ${net_price_range}    max
    ${max_price_from_result}     Get From Dictionary    ${product_expect}    max_normal_price
    ${max_price_from_detail}  Convert To Integer    ${max_price_from_detail}
    ${max_price_from_result}  Convert To Integer    ${max_price_from_result}
    Should Be Equal     ${max_price_from_result}     ${max_price_from_detail}

Verify Max Percent Discount Product
     [Arguments]    ${product_expect}     ${product_detail}
    ${percent_discount}     Get From Dictionary    ${product_detail}    percent_discount
    ${max_price_from_detail}     Get From Dictionary    ${percent_discount}    max
    ${max_percent_discount_from_result}     Get From Dictionary    ${product_expect}    max_percent_discount
    ${max_percent_discount_from_result}  Convert To Integer    ${max_percent_discount_from_result}
    ${max_price_from_detail}  Convert To Integer    ${max_price_from_detail}
    Should Be Equal     ${max_percent_discount_from_result}     ${max_price_from_detail}

Verify Min Percent Discount Product
     [Arguments]    ${product_expect}     ${product_detail}
    ${percent_discount}     Get From Dictionary    ${product_detail}    percent_discount
    ${min_price_from_detail}     Get From Dictionary    ${percent_discount}    min
    ${min_percent_discount_from_result}     Get From Dictionary    ${product_expect}    min_percent_discount
    ${min_percent_discount_from_result}  Convert To Integer    ${min_percent_discount_from_result}
    ${min_price_from_detail}  Convert To Integer    ${min_price_from_detail}
    Should Be Equal     ${min_percent_discount_from_result}     ${min_price_from_detail}

Verify Max Price Product
    [Arguments]    ${product_expect}     ${product_detail}
    ${special_price_range}     Get From Dictionary    ${product_detail}    special_price_range
    ${max_price_from_detail}     Get From Dictionary    ${special_price_range}    max
    ${max_price_from_result}     Get From Dictionary    ${product_expect}    max_price
    ${max_price_from_detail}  Convert To Integer    ${max_price_from_detail}
    ${max_price_from_result}  Convert To Integer    ${max_price_from_result}
    Should Be Equal     ${max_price_from_result}     ${max_price_from_detail}

Verify Min Price Product
    [Arguments]    ${product_expect}     ${product_detail}
    ${special_price_range}     Get From Dictionary    ${product_detail}    special_price_range
    ${min_price_from_detail}     Get From Dictionary    ${special_price_range}    min
    ${min_price_from_result}     Get From Dictionary    ${product_expect}    min_price
    ${min_price_from_detail}  Convert To Integer    ${min_price_from_detail}
    ${min_price_from_result}  Convert To Integer    ${min_price_from_result}
    Should Be Equal     ${min_price_from_result}     ${min_price_from_detail}

Verify number of data
    [Arguments]    ${cate_reponse}    ${expected_number_of_data}
    ${number_of_data}=    Get Json Value    ${cate_reponse}    /data/number_of_data
    Should Be Equal As Numbers    ${number_of_data}    ${expected_number_of_data}

Verify total number of data
    [Arguments]    ${cate_reponse}     ${expected_total_number_of_data}
    ${total_number_of_data}=    Get Json Value    ${cate_reponse}    /data/total_number_of_data
    Should Be Equal As Numbers    ${total_number_of_data}    ${expected_total_number_of_data}

Verify page
    [Arguments]     ${cate_reponse}    ${expected_page}
    ${page}=    Get Json Value    ${cate_reponse}    /data/page
    Should Be Equal As Numbers    ${page}    ${expected_page}

Verify total page
    [Arguments]    ${cate_reponse}    ${expected_total_page}
    ${total_page}=     Get Json Value    ${cate_reponse}    /data/total_page
    Should Be Equal As Numbers    ${total_page}    ${expected_total_page}

Verify is last page
    [Arguments]    ${cate_reponse}    ${expected_is_last_page}
    ${is_last_page}=    Get Json Value    ${cate_reponse}    /data/is_last_page
    Should Be Equal    ${is_last_page}    ${expected_is_last_page}

Verify Sort By Updated At
    [Arguments]    ${cate_reponse}    ${sort}=asc
    &{dic_product_update}=    Create Dictionary
    @{list_product_key}=    Create List
    ${data}=            Get Json Value and Convert to List    ${cate_reponse}    /data
    ${product_list}=    Get From Dictionary    ${data}    data
    :FOR    ${product_pkey}    IN    @{product_list}
    \       ${pkey}=    Get From Dictionary    ${product_pkey}    pkey
    \       ${pkey}=    Convert To String      ${pkey}
    \       ${product_detail}    Get Product Detail By Product Pkey    ${pkey}
    \       ${update_at}=        Get From Dictionary      ${product_detail}    updated_at
    \       Append To List    ${list_product_key}    ${pkey}
    \       Set To Dictionary    ${dic_product_update}    ${pkey}    ${update_at}
    log    ${list_product_key}
    log    ${dic_product_update}
    ${asc}=     Evaluate    sorted(&{dic_product_update}, key=&{dic_product_update}.__getitem__)
    ${desc}=    Evaluate    sorted(&{dic_product_update}, key=&{dic_product_update}.__getitem__, reverse=True)
    ${result_update_at}=    Set Variable If    '${sort}'=='asc'     ${asc}     ${desc}
    Lists Should Be Equal    ${list_product_key}    ${result_update_at}

Verify Sort By Published At
    [Arguments]     ${cate_reponse}    ${sort}=asc
    &{dic_product_publish}=    Create Dictionary
    @{list_product_key}=    Create List
    ${data}=            Get Json Value and Convert to List    ${cate_reponse}    /data
    ${product_list}=    Get From Dictionary    ${data}    data
    :FOR    ${product_pkey}    IN    @{product_list}
    \       ${pkey}=    Get From Dictionary    ${product_pkey}    pkey
    \       ${pkey}=    Convert To String      ${pkey}
    \       ${product_detail}    Get Product Detail By Product Pkey    ${pkey}
    \       ${published_at}=        Get From Dictionary      ${product_detail}    published_at
    \       Append To List    ${list_product_key}    ${pkey}
    \       Set To Dictionary    ${dic_product_publish}    ${pkey}    ${published_at}
    Log Dictionary    ${dic_product_publish}
    ${asc}=     Evaluate    sorted(&{dic_product_publish}, key=&{dic_product_publish}.__getitem__)
    ${desc}=    Evaluate    sorted(&{dic_product_publish}, key=&{dic_product_publish}.__getitem__, reverse=True)
    ${result_publish_at}=      Set Variable If    '${sort}'=='asc'     ${asc}     ${desc}
    Lists Should Be Equal    ${list_product_key}    ${result_publish_at}

Verify Sort By Price Order By ASC
    [Arguments]    ${cate_reponse}
    &{dic_product_price}=    Create Dictionary
    @{list_product_key}=     Create List
    ${data}=            Get Json Value and Convert to List    ${cate_reponse}    /data
    ${product_list}=    Get From Dictionary    ${data}    data
    :FOR    ${product_pkey}    IN    @{product_list}
    \       ${pkey}=    Get From Dictionary    ${product_pkey}    pkey
    \       ${pkey}=    Convert To String      ${pkey}
    \       ${product_detail}    Get Product Detail By Product Pkey    ${pkey}
    \       ${special_price_range}      Get From Dictionary    ${product_detail}         special_price_range
    \       ${min_price_from_detail}    Get From Dictionary    ${special_price_range}    min
    \       Append To List       ${list_product_key}     ${pkey}
    \       Set To Dictionary    ${dic_product_price}    ${pkey}    ${min_price_from_detail}
    Log Dictionary    ${dic_product_price}
    Log     list_product_key${list_product_key}
    ${result_price}=    Evaluate    sorted(&{dic_product_price}, key=&{dic_product_price}.__getitem__)
    Lists Should Be Equal    ${list_product_key}    ${result_price}

Verify Sort By Price Order By DESC
    [Arguments]    ${cate_reponse}
    &{dic_product_price}=    Create Dictionary
    @{list_product_key}=     Create List
    ${data}=            Get Json Value and Convert to List    ${cate_reponse}    /data
    ${product_list}=    Get From Dictionary    ${data}    data
    :FOR    ${product_pkey}    IN    @{product_list}
    \       ${pkey}=    Get From Dictionary    ${product_pkey}    pkey
    \       ${pkey}=    Convert To String      ${pkey}
    \       ${product_detail}    Get Product Detail By Product Pkey    ${pkey}
    \       ${special_price_range}      Get From Dictionary    ${product_detail}         special_price_range
    \       ${max_price_from_detail}    Get From Dictionary    ${special_price_range}    max
    \       Append To List       ${list_product_key}     ${pkey}
    \       Set To Dictionary    ${dic_product_price}    ${pkey}    ${max_price_from_detail}
    Log     ${dic_product_price}
    Log     list_product_key${list_product_key}
    ${result_price}=    Evaluate    sorted(&{dic_product_price}, key=&{dic_product_price}.__getitem__, reverse=True)
    Lists Should Be Equal    ${list_product_key}    ${result_price}

Verify Sort By Percent Discoount Order By ASC
    [Arguments]    ${cate_reponse}
    &{dic_product_percent_discount}=    Create Dictionary
    @{list_product_key}=     Create List
    ${data}=            Get Json Value and Convert to List    ${cate_reponse}    /data
    ${product_list}=    Get From Dictionary    ${data}    data
    :FOR    ${product_pkey}    IN    @{product_list}
    \       ${pkey}=    Get From Dictionary    ${product_pkey}    pkey
    \       ${pkey}=    Convert To String      ${pkey}
    \       ${product_detail}    Get Product Detail By Product Pkey    ${pkey}
    \       ${percent_discount_range}    Get From Dictionary    ${product_detail}    percent_discount
    \       ${min_percent_discount_from_detail}    Get From Dictionary    ${percent_discount_range}    min
    \       Append To List       ${list_product_key}     ${pkey}
    \       Set To Dictionary    ${dic_product_percent_discount}    ${pkey}    ${min_percent_discount_from_detail}
    Log Dictionary    ${dic_product_percent_discount}
    Log     list_product_key${list_product_key}
    ${result_percent_discount}=    Evaluate    sorted(&{dic_product_percent_discount}, key=&{dic_product_percent_discount}.__getitem__)
    Lists Should Be Equal    ${list_product_key}    ${result_percent_discount}

Verify Sort By Percent Discoount Order By DESC
    [Arguments]    ${cate_reponse}
    &{dic_product_percent_discount}=    Create Dictionary
    @{list_product_key}=     Create List
    ${data}=            Get Json Value and Convert to List    ${cate_reponse}    /data
    ${product_list}=    Get From Dictionary    ${data}    data
    :FOR    ${product_pkey}    IN    @{product_list}
    \       ${pkey}=    Get From Dictionary    ${product_pkey}    pkey
    \       ${pkey}=    Convert To String      ${pkey}
    \       ${product_detail}    Get Product Detail By Product Pkey    ${pkey}
    \       ${percent_discount_range}    Get From Dictionary    ${product_detail}    percent_discount
    \       ${min_percent_discount_from_detail}    Get From Dictionary    ${percent_discount_range}    max
    \       Append To List       ${list_product_key}     ${pkey}
    \       Set To Dictionary    ${dic_product_percent_discount}    ${pkey}    ${min_percent_discount_from_detail}
    Log Dictionary    ${dic_product_percent_discount}
    Log     list_product_key${list_product_key}
    ${result_percent_discount}=    Evaluate    sorted(&{dic_product_percent_discount}, key=&{dic_product_percent_discount}.__getitem__, reverse=True)
    Lists Should Be Equal    ${list_product_key}    ${result_percent_discount}

Verify Product Inactive Status Between Data From Response and DB
    [Arguments]    ${cat_response}    ${product_pkey_list}
    ${data}=            Get Json Value and Convert to List    ${cat_response}    /data
    ${product_list}=    Get From Dictionary    ${data}    data
    Log List    ${product_list}
    Log List    ${product_pkey_list}
    ${actual_number_of_products}=      Get Length    ${product_list}
    ${expected_number_of_products}=    Get Length    ${product_pkey_list}
    Should Be Equal    ${actual_number_of_products}    ${expected_number_of_products}
    :FOR    ${product_pkey}    IN    @{product_pkey_list}
    \    ${product_result}=    Filter Product By Pkey    ${product_list}    ${product_pkey}
    \    ${pkey_from_result}=    Get From Dictionary    ${product_result}    pkey

    \    ${id_result}=    Get From Dictionary    ${product_result}    id
    \    ${allow_cod_result}=    Get From Dictionary    ${product_result}    allow_cod
    \    ${min_percent_discount_result}=    Get From Dictionary    ${product_result}    min_percent_discount
    \    ${max_percent_discount_result}=    Get From Dictionary    ${product_result}    max_percent_discount
    \    ${min_normal_price_result}=    Get From Dictionary    ${product_result}    min_normal_price
    \    ${max_normal_price_result}=    Get From Dictionary    ${product_result}    max_normal_price
    \    ${min_price_result}=    Get From Dictionary    ${product_result}    min_price
    \    ${max_price_result}=    Get From Dictionary    ${product_result}    max_price
    \    ${title_result}=        Get From Dictionary    ${product_result}    title

    \    ${installment_result}=    Get From Dictionary    ${product_result}    installment
    \    ${installment_result}=    Get Dictionary Values    ${installment_result}

    \    ${active_result}=    Get From Dictionary    ${product_result}    active
    \    ${status_result}=    Get From Dictionary    ${product_result}    status
    \    ${expected_product_id}=    Get Product ID from DB by Product pkey    ${product_pkey}
    \    ${expected_allow_cod}=     Get Allow COD from DB by Product pkey     ${product_pkey}
    \    ${expected_product_status}=    Get Product Status from DB by Product pkey    ${product_pkey}
    \    ${expected_title}=        Get Title from DB by Product pkey           ${product_pkey}
    \    ${expected_active}=       Get Active from DB by Product pkey          ${product_pkey}
    \    ${expected_installment}=    Get Installment from DB by product pkey    ${product_pkey}
    \    ${expected_min_percent}=    Find Min Percent Discount for Product     ${product_pkey}
    \    ${expected_max_percent}=    Find Max Percent Discount for Product     ${product_pkey}
    \    ${expected_min_normal_price}=    Find Min Normal Price for Product    ${product_pkey}
    \    ${expected_max_normal_price}=    Find Max Normal Price for Product    ${product_pkey}
    \    ${expected_min_price}=    Find Min Price for Product    ${product_pkey}
    \    ${expected_max_price}=    Find Max Price for Product    ${product_pkey}

    \    Should Be Equal    ${allow_cod_result}    ${expected_allow_cod}
    \    Should Be Equal    ${id_result}    ${expected_product_id}
    \    Should Be Equal    ${allow_cod_result}    ${expected_allow_cod}
    \    Should Be Equal    ${status_result}     ${expected_product_status}
    \    Should Be Equal    ${title_result}    ${expected_title}
    \    Should Be Equal    ${active_result}    ${expected_active}
    \    Should Be Equal    ${min_percent_discount_result}    ${expected_min_percent}
    \    Should Be Equal    ${max_percent_discount_result}    ${expected_max_percent}
    \    Should Be Equal    ${min_normal_price_result}     ${expected_min_normal_price}
    \    Should Be Equal    ${max_normal_price_result}     ${expected_max_normal_price}
    \    Should Be Equal    ${max_price_result}    ${expected_max_price}
    \    Should Be Equal    ${min_price_result}    ${expected_min_price}
    \    Run Keyword If     @{installment_result}[0]    Should Contain    ${expected_installment}    true
    \    ...    ELSE    Should Contain     ${expected_installment}    false
    \    Verify stock of product    ${product_result}    ${product_pkey}

Verify Categories Between Data From Response and DB
    [Arguments]    ${cat_response}
    # Prepare Response Data
    Log Dictionary    ${cat_response}
    ${pkey}=     Get From Dictionary    ${cat_response}    pkey
    #.. remove nodes that are ignored to verified
    Remove From Dictionary    ${cat_response}    pkey    products    children    children_order    name_trail    name_translation_trail    display_image_desktop    display_image_mobile    slug_trail    total_product
    # Prepare Database Data
    ${cat_db}=    Get All Category Data from DB by Category pkey    ${pkey}
    #.. adjust date time format from DB
    ${is_existing_created_at}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${cat_db}    created_at
    ${is_existing_updated_at}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${cat_db}    updated_at
    ${is_existing_deleted_at}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${cat_db}    deleted_at
    ${adjust_created_at}=    Set Variable If    ${is_existing_created_at}    &{cat_db}[created_at]    ${EMPTY}
    ${adjust_updated_at}=    Set Variable If    ${is_existing_updated_at}    &{cat_db}[updated_at]    ${EMPTY}
    ${adjust_deleted_at}=    Set Variable If    ${is_existing_deleted_at}    &{cat_db}[deleted_at]    ${EMPTY}
    ${adjust_created_at}=    Convert To String    ${adjust_created_at}
    ${adjust_updated_at}=    Convert To String    ${adjust_updated_at}
    ${adjust_deleted_at}=    Convert To String    ${adjust_deleted_at}
    Run Keyword If    ${is_existing_created_at}    Set To Dictionary    ${cat_db}    created_at=${adjust_created_at}
    Run Keyword If    ${is_existing_updated_at}    Set To Dictionary    ${cat_db}    updated_at=${adjust_updated_at}
    Run Keyword If    ${is_existing_deleted_at}    Set To Dictionary    ${cat_db}    deleted_at=${adjust_deleted_at}
    # Log To Console    cat_response=${cat_response}
    Log Dictionary    ${cat_response}
    # Log To Console   cat_db=${cat_db}
    Log Dictionary    ${cat_db}
    # Dictionaries Should Be Equal    ${cat_response}    ${cat_db}
    ${cat_response_items}=    Get Dictionary Items    ${cat_response}
    :FOR    ${key_response}    ${value_response}    IN    @{cat_response_items}
    \    ${value_db}=    Get From Dictionary    ${cat_db}    ${key_response}
    \    Should Be Equal As Strings    ${value_response}    ${value_db}

Verify Collections Between Data From Response and DB
    [Arguments]    ${coll_response}
    # Prepare Response Data
    Log List    ${coll_response}
    ${pkey}=     Get From Dictionary    ${coll_response}    pkey
    #.. remove nodes that are ignored to verified
    Remove From Dictionary    ${coll_response}    pkey    products    children    children_order_string    children_order
    # Prepare Database Data
    ${coll_db}=    Get All Collection Data from DB by Collection pkey    ${pkey}
    #.. adjust date time format from DB
    ${is_existing_created_at}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${coll_db}    created_at
    ${is_existing_updated_at}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${coll_db}    updated_at
    ${is_existing_deleted_at}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${coll_db}    deleted_at
    ${adjust_created_at}=    Set Variable If    ${is_existing_created_at}    &{coll_db}[created_at]    ${EMPTY}
    ${adjust_updated_at}=    Set Variable If    ${is_existing_updated_at}    &{coll_db}[updated_at]    ${EMPTY}
    ${adjust_deleted_at}=    Set Variable If    ${is_existing_deleted_at}    &{coll_db}[deleted_at]    ${EMPTY}
    ${adjust_created_at}=    Convert To String    ${adjust_created_at}
    ${adjust_updated_at}=    Convert To String    ${adjust_updated_at}
    ${adjust_deleted_at}=    Convert To String    ${adjust_deleted_at}
    Run Keyword If    ${is_existing_created_at}    Set To Dictionary    ${coll_db}    created_at=${adjust_created_at}
    Run Keyword If    ${is_existing_updated_at}    Set To Dictionary    ${coll_db}    updated_at=${adjust_updated_at}
    Run Keyword If    ${is_existing_deleted_at}    Set To Dictionary    ${coll_db}    deleted_at=${adjust_deleted_at}
    Log List    ${coll_response}
    Log List    ${coll_db}
    Dictionaries Should Be Equal    ${coll_response}    ${coll_db}

Create Collection
    [Arguments]    ${parent_id}    ${json_data}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${json_data}
    Next Request May Not Succeed
    HttpLibrary.HTTP.POST    ${PDS-API-URI}/collections/${parent_id}/children
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Create Category
    [Arguments]    ${parent_id}    ${json_data}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${json_data}
    Next Request May Not Succeed
    HttpLibrary.HTTP.POST    ${PDS-API-URI}/categories/${parent_id}/children
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Update Category
    [Arguments]    ${category_id}    ${json_data}
    Create Http Context    ${API_GATEWAY_HOST}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${json_data}
    Next Request May Not Succeed
    HttpLibrary.HTTP.PUT    ${PDS-API-URI}/categories/${category_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Category ID After Creating
    ${response}=     Get Response Body
    ${cat_id}=    Get Json Value    ${response}    /data/id
    Return From Keyword    ${cat_id}

Get Category Pkey After Creating
    ${response}=     Get Response Body
    ${cat_pkey}=    Get Json Value    ${response}    /data/pkey
    Return From Keyword    ${cat_pkey}

Get Collection ID After Creating
    ${response}=     Get Response Body
    ${coll_id}=    Get Json Value    ${response}    /data/children/id
    Return From Keyword    ${coll_id}

Verify format code
  [Arguments]    ${m_type}    ${c_type}    ${input}    ${level}
  ${level}=    Evaluate    2 * ${level}
  Run Keyword If    '${m_type}' == 'merchant' and '${c_type}' == 'category'      Code Merchant Cat    ${input}    ${level}
  Run Keyword If    '${m_type}' == 'merchant' and '${c_type}' == 'collection'    Code Merchant Col    ${input}    ${level}
  Run Keyword If    '${m_type}' == 'alias' and '${c_type}' == 'category'         Code Alias Cat       ${input}    ${level}
  Run Keyword If    '${m_type}' == 'alias' and '${c_type}' == 'collection'       Code Alias Col       ${input}    ${level}

Code Merchant Col
  [Arguments]    ${input}    ${level}
  Should Match Regexp    ${input}    WMM[0-9A-Za-z]{1}[0-9A-Za-z]{${level}}

Code Merchant Cat
  [Arguments]    ${input}    ${level}
  Should Match Regexp    ${input}    WMM[0-9A-Za-z]{1}[0-9A-Za-z]{${level}}

Code Alias Col
  [Arguments]    ${input}    ${level}
  Should Match Regexp    ${input}    WMA[0-9A-Za-z]{1}[0-9A-Za-z]{${level}}
  Log To Console    input=${input}

Code Alias Cat
  [Arguments]    ${input}    ${level}
  Should Match Regexp    ${input}    WMA[0-9A-Za-z]{1}[0-9A-Za-z]{${level}}

Get Category By Category Root
	Create Http Context    ${API_GATEWAY_HOST}    http
	Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${PDS-API-URI}/categories/root
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Verify Response Data From Get Root Category
    ${response}=     Get Response Body
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    ${number_of_categories}=       Get Length    ${data}
    ${number_of_categories_db}=    Get Category Children of Root from DB
    ${number_of_categories_db}=    Split String    ${number_of_categories_db}    ,
    ${number_of_categories_db}=    Get Length      ${number_of_categories_db}
    Should Be Equal    ${number_of_categories}     ${number_of_categories_db}
    ${1st_cat}=    Set Variable    @{data}[0]
    Log List    ${1st_cat}
    Verify Categories Between Data From Response and DB    ${1st_cat}

Delete Merchant
    [Arguments]    ${merchant_ids}
    :FOR    ${id_item}    IN    @{merchant_ids}
    \    Delete Merchant from DB    ${id_item}

Delete Merchant Alias
    [Arguments]    ${merchant_alias_ids}
    :FOR    ${id_item}    IN    @{merchant_alias_ids}
    \    Delete Merchant Alias From DB    ${id_item}

Generate Create Category JSON Body
    [Arguments]    ${data}
    ${body}=    Set Variable    ${EMPTY}
    @{keys}=    Get Dictionary Keys    ${data}
    :For    ${key}    IN    @{keys}
    \    ${value}=    Get From Dictionary    ${data}    ${key}
    \    ${body}=    Set Variable    ${body}"${key}": ${value},
    ${body}=    Set Variable    {${body}}
    ${body}=    Replace String    ${body}    ,}    }

    Log    ${body}    console=yes
    Return From Keyword    ${body}

Create Dictionary for Common Creation JSON Category
    [Arguments]    ${json_dict}
    ${tc_number}=    Get Test Case Number
    Set To Dictionary    ${json_dict}    category_name               "${tc_number}"
    Set To Dictionary    ${json_dict}    status                      "active"
    Set To Dictionary    ${json_dict}    owner                       "${MERCHANT_CODE}"
    Set To Dictionary    ${json_dict}    owner_type                  "${MERCHANT_TYPE}"
    Set To Dictionary    ${json_dict}    category_name_translate     "${tc_number}-EN"
    Set To Dictionary    ${json_dict}    slug                        "${tc_number}-slug"
    Set To Dictionary    ${json_dict}    image_url_desktop           "image_url_desktop-${tc_number}"
    Set To Dictionary    ${json_dict}    image_url_mobile            "image_url_mobile-${tc_number}"
    Return From Keyword     ${json_dict}

Update Dictionary for Common Update JSON Category
    [Arguments]    ${json_dict}
    ${tc_number}=    Get Test Case Number
    Set To Dictionary    ${json_dict}    category_name               "${tc_number}-update"
    Set To Dictionary    ${json_dict}    status                      "inactive"
    Set To Dictionary    ${json_dict}    category_name_translate     "${tc_number}-EN-update"
    Set To Dictionary    ${json_dict}    slug                        "${tc_number}-slug-update"
    Set To Dictionary    ${json_dict}    image_url_desktop           "image_url_desktop-${tc_number}-update"
    Set To Dictionary    ${json_dict}    image_url_mobile            "image_url_mobile-${tc_number}-update"
    Return From Keyword     ${json_dict}

Verify Owner From Response Should Be Equal
    [Arguments]    ${response}    ${expected_merchant}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${categories}
    :FOR    ${cat}    IN    @{categories}
    \    ${owner}=    Get From Dictionary    ${cat}    owner
    \    Should Be Equal    ${expected_merchant}    ${owner}

Verify Category Level From Response Should Be Equal
    [Arguments]    ${response}    ${expected_level}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${categories}
    :FOR    ${cat}    IN    @{categories}
    \    ${level}=    Get From Dictionary    ${cat}    level
    \    Should Be Equal As Numbers    ${expected_level}    ${level}

Verify Category is Child of Root
    [Arguments]    ${response}    ${cat_id}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${categories}
    ${child_categories_db}=    Get Category Children of Root from DB
    ${child_categories_db}=    Split String    ${child_categories_db}    ,
    :FOR    ${cat}    IN    @{categories}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${id}=    Convert To String     ${id}
    \    List Should Contain Value    ${child_categories_db}    ${id}

Verify Response Data From Get Root Merchant's Category
    ${response}=     Get Response Body
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log List    ${data}
    ${number_of_categories}=       Get Length    ${data}
    ${number_of_categories_db}=    Get Category Children of Root from DB
    ${number_of_categories_db}=    Split String    ${number_of_categories_db}    ,
    ${number_of_categories_db}=    Get Length      ${number_of_categories_db}
    Should Be Equal    ${number_of_categories}     ${number_of_categories_db}
    ${1st_cat}=    Set Variable    @{data}[0]
    Log List    ${1st_cat}
    Log To Console    1st_cat=${1st_cat}
    Verify Categories Between Data From Response and DB    ${1st_cat}

Verify Category Name Trail From Response Data Should Be Equal
    [Arguments]    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}=${EMPTY}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    Log List    categories=${categories}
    ${cate_id}=       Convert To Integer   ${cat_id}
    ${categories_list}=    Create List    ${categories}
    ${is_an_item}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${categories}    category_code
    ${categories}=    Set Variable If    ${is_an_item}    ${categories_list}    ${categories}
    :FOR    ${cat}    IN    @{categories}
    \    Run Keyword If    '${cat_id}'=='${EMPTY}'    Exit For Loop
    \    Log To Console    rescs=${cat}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${id}=    Convert To Integer    ${id}
    \    ${is_test_cat}=    Run Keyword And Return Status    Should Be Equal As Numbers    ${id}    ${cat_id}
    \    Run Keyword If    ${is_test_cat}    Exit For Loop
    ${name_trail}=    Get From Dictionary    ${cat}    name_trail
    ${name_translation_trail}=    Get From Dictionary    ${cat}    name_translation_trail
    Should Be Equal    ${expected_name_trail}    ${name_trail}
    Should Be Equal    ${expected_name_translation_trail}    ${name_translation_trail}

Verify Display Image From Response Data Should Be Equal
    [Arguments]    ${response}    ${expected_display_image_desktop}    ${expected_display_image_mobile}    ${cat_id}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    ${cate_id}=       Convert To Integer   ${cat_id}
    ${categories_list}=    Create List    ${categories}
    ${is_an_item}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${categories}    category_code
    ${categories}=    Set Variable If    ${is_an_item}    ${categories_list}    ${categories}
    :FOR    ${cat}    IN    @{categories}
    \    Run Keyword If    '${cat_id}'=='${EMPTY}'    Exit For Loop
    \    Log To Console    rescs=${cat}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${id}=    Convert To Integer    ${id}
    \    ${is_test_cat}=    Run Keyword And Return Status    Should Be Equal As Numbers    ${id}    ${cat_id}
    \    Run Keyword If    ${is_test_cat}    Exit For Loop
    ${display_image_desktop}=    Get From Dictionary    ${cat}    display_image_desktop
    ${display_image_mobile}=     Get From Dictionary    ${cat}    display_image_mobile
    Should Be Equal    ${expected_display_image_desktop}    ${display_image_desktop}
    Should Be Equal    ${expected_display_image_mobile}     ${display_image_mobile}

Verify Slug Trail From Response Data Should Be Equal
    [Arguments]    ${response}    ${expected_slug_trail}    ${cat_id}=${EMPTY}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    Log List    categories=${categories}
    ${cate_id}=       Convert To Integer   ${cat_id}
    ${categories_list}=    Create List    ${categories}
    ${is_an_item}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${categories}    category_code
    ${categories}=    Set Variable If    ${is_an_item}    ${categories_list}    ${categories}
    :FOR    ${cat}    IN    @{categories}
    \    Run Keyword If    '${cat_id}'=='${EMPTY}'    Exit For Loop
    \    Log To Console    rescs=${cat}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${id}=    Convert To Integer    ${id}
    \    ${is_test_cat}=    Run Keyword And Return Status    Should Be Equal As Numbers    ${id}    ${cat_id}
    \    Run Keyword If    ${is_test_cat}    Exit For Loop
    ${slug_trail}=    Get From Dictionary    ${cat}    slug_trail
    Should Be Equal    ${expected_slug_trail}    ${slug_trail}

Add Products To Categories
    [Arguments]    ${file_full_path}
    ${response}=    POST Common File    http://${API_GATEWAY_HOST}${PDS-API-URI}/categories/products    ${file_full_path}
    Return From Keyword    ${response}

Replace Products To Categories
    [Arguments]    ${file_full_path}
    ${response}=    PUT Common File    http://${API_GATEWAY_HOST}${PDS-API-URI}/categories/products    ${file_full_path}
    Return From Keyword    ${response}

Max Percent Discount for Product
    [Arguments]    ${list_normal_price}    ${list_special_price}
    ${list_percent_discount}=       Create List
    ${length_list_normal_price}=    Get Length    ${list_normal_price}
    :FOR    ${index}    IN RANGE   ${length_list_normal_price}
    \    log     index=${index}
    \    log    test=${length_list_normal_price}
    \    ${normal_price}=     Convert To Number    @{list_normal_price}[${index}]
    \    ${special_price}=    Convert To Number     @{list_special_price}[${index}]
    \    ${x}=     Evaluate    ${normal_price} - ${special_price}
    \    ${y}=    Evaluate    ${x} * 100
    \    ${z}=    Evaluate    ${y} / ${normal_price}
    \    ${discount_percent_for_display}=    Evaluate    int(${z})
    \    Append To List    ${list_percent_discount}    ${discount_percent_for_display}
    ${list_percent_discount}=    Copy List    ${list_percent_discount}
    Sort List    ${list_percent_discount}
    ${max_percent_discount}=    Get From List    ${list_percent_discount}    -1
    Return From Keyword    ${max_percent_discount}

Min Percent Discount for Product
    [Arguments]    ${list_normal_price}    ${list_special_price}
    ${list_percent_discount}=       Create List
    ${length_list_normal_price}=    Get Length    ${list_normal_price}
    :FOR    ${index}    IN RANGE   ${length_list_normal_price}
    \    log     index=${index}
    \    log    test=${length_list_normal_price}
    \    ${normal_price}=     Convert To Number    @{list_normal_price}[${index}]
    \    ${special_price}=    Convert To Number     @{list_special_price}[${index}]
    \    ${x}=     Evaluate    ${normal_price} - ${special_price}
    \    ${y}=    Evaluate    ${x} * 100
    \    ${z}=    Evaluate    ${y} / ${normal_price}
    \    ${discount_percent_for_display}=    Evaluate    int(${z})
    \    Append To List    ${list_percent_discount}    ${discount_percent_for_display}
    ${list_percent_discount}=    Copy List    ${list_percent_discount}
    Sort List    ${list_percent_discount}
    ${min_percent_discount}=    Get From List    ${list_percent_discount}    0
    Return From Keyword    ${min_percent_discount}

Find Max Normal Price for Product
    [Arguments]    ${product_pkey}
    #product_pkey is list
    ${product_id}=              Get Product ID from DB by Product pkey       ${product_pkey}
    ${list_inventory_id}=       Get Inventory ID from DB by Product ID       ${product_id}
    ${list_normal_price}=       Get Normal Price from DB by Inventory ID     ${list_inventory_id}
    ${list_normal_price}=    Copy List    ${list_normal_price}
    Sort List    ${list_normal_price}
    ${max_normal_price}=    Get From List    ${list_normal_price}    -1
    Return From Keyword    ${max_normal_price}

Find Min Normal Price for Product
    [Arguments]    ${product_pkey}
    #product_pkey is list
    ${product_id}=              Get Product ID from DB by Product pkey       ${product_pkey}
    ${list_inventory_id}=       Get Inventory ID from DB by Product ID       ${product_id}
    ${list_normal_price}=       Get Normal Price from DB by Inventory ID     ${list_inventory_id}
    ${list_normal_price}=    Copy List    ${list_normal_price}
    Sort List    ${list_normal_price}
    ${min_normal_price}=    Get From List    ${list_normal_price}    0
    Return From Keyword    ${min_normal_price}

Find Max Percent Discount for Product
    [Arguments]    ${product_pkey}
    #product_pkey is list
    ${product_id}=              Get Product ID from DB by Product pkey       ${product_pkey}
    ${list_inventory_id}=       Get Inventory ID from DB by Product ID       ${product_id}
    ${list_normal_price}=       Get Normal Price from DB by Inventory ID     ${list_inventory_id}
    ${list_special_price}=      Get Special Price from DB by Inventory ID    ${list_inventory_id}
    ${max_percent_discount}=    Max Percent Discount for Product    ${list_normal_price}    ${list_special_price}
    Return From Keyword     ${max_percent_discount}

Find Min Percent Discount for Product
    [Arguments]    ${product_pkey}
    #product_pkey is list
    ${product_id}=              Get Product ID from DB by Product pkey       ${product_pkey}
    ${list_inventory_id}=       Get Inventory ID from DB by Product ID       ${product_id}
    ${list_normal_price}=       Get Normal Price from DB by Inventory ID     ${list_inventory_id}
    ${list_special_price}=      Get Special Price from DB by Inventory ID    ${list_inventory_id}
    ${min_percent_discount}=    Min Percent Discount for Product    ${list_normal_price}    ${list_special_price}
    Return From Keyword    ${min_percent_discount}

Find Max Price for Product
   [Arguments]    ${product_pkey}
    #product_pkey is list
    ${product_id}=            Get Product ID from DB by Product pkey       ${product_pkey}
    ${list_inventory_id}=     Get Inventory ID from DB by Product ID       ${product_id}
    ${list_special_price}=    Get Special Price from DB by Inventory ID    ${list_inventory_id}
    ${list_special_price}=    Copy List    ${list_special_price}
    Sort List    ${list_special_price}
    ${max_price}=    Get From List    ${list_special_price}    -1
    Return From Keyword    ${max_price}

Find Min Price for Product
   [Arguments]    ${product_pkey}
    #product_pkey is list
    ${product_id}=            Get Product ID from DB by Product pkey       ${product_pkey}
    ${list_inventory_id}=     Get Inventory ID from DB by Product ID       ${product_id}
    ${list_normal_price}=     Get Normal Price from DB by Inventory ID     ${list_inventory_id}
    ${list_special_price}=    Get Special Price from DB by Inventory ID    ${list_inventory_id}
    ${list_special_price}=    Copy List    ${list_special_price}
    Sort List    ${list_special_price}
    ${min_price}=    Get From List    ${list_special_price}    0
    Return From Keyword    ${min_price}

#### Keyword For Total_product ###
Create Category level 1
    ${tc_number1}=    Get Test Case Number
    Set Test Variable    ${tc_number}    ${tc_number1}
    ${CATEGORY_CREATE_JSON1}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON1}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON1}
    Set To Dictionary    ${CATEGORY_CREATE_JSON1}    category_name    "${tc_number}-CAT1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON1}     owner             "AM00003"
    Set Test Variable    ${CATEGORY_CREATE_JSON}     ${CATEGORY_CREATE_JSON1}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON1}
    ${response_1}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    Verify Success Response Status Code and Message
    Set Test Variable    ${cat_id_1}    ${cat_id_1}
    Log To Console    \n Category ID = ${cat_id_1}
    Log To Console    Category Pkey = ${cat_pkey_1}
    Return From Keyword    ${cat_id_1}    ${cat_pkey_1}

Create Category sub level 1-1
    [Arguments]    ${cat_id_1}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}     owner             "AM00003"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1_1}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1}=      Get Category ID After Creating
    ${cat_pkey_1_1}=     Get Category Pkey After Creating
    Verify Success Response Status Code and Message
    Set Test Variable    ${cat_id_1_1}    ${cat_id_1_1}
    Log To Console    \n Sub Category 1-1 ID = ${cat_id_1_1}
    Log To Console    Sub Category 1-1 Pkey = ${cat_pkey_1_1}
    Return From Keyword    ${cat_id_1_1}    ${cat_pkey_1_1}

Create Category sub level 1-2
    [Arguments]    ${cat_id_1}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}     owner             "AM00003"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1_2}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_2}=      Get Category ID After Creating
    ${cat_pkey_1_2}=     Get Category Pkey After Creating
    Verify Success Response Status Code and Message
    Set Test Variable    ${cat_id_1_2}    ${cat_id_1_2}
    Log To Console    \n Sub Category 1-2 ID = ${cat_id_1_2}
    Log To Console    Sub Category 1-2 Pkey = ${cat_pkey_1_2}
    Return From Keyword    ${cat_id_1_2}    ${cat_pkey_1_2}

Create Category sub level 1-2-1
    [Arguments]    ${cat_id_1_2}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-2-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}     owner             "AM00003"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1_2_1}=     Create Category    ${cat_id_1_2}    ${file_data}
    ${cat_id_1_2_1}=      Get Category ID After Creating
    ${cat_pkey_1_2_1}=     Get Category Pkey After Creating
    Verify Success Response Status Code and Message
    Set Test Variable    ${cat_id_1_2_1}    ${cat_id_1_2_1}
    Log To Console    \n Sub Category 1-2-1 ID = ${cat_id_1_2_1}
    Log To Console    Sub Category 1-2-1 Pkey = ${cat_pkey_1_2_1}
    Return From Keyword    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}

Add Product To Category 1 Product A
    [Arguments]    ${cat_pkey}
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    # @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    1
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}
    # Log To Console    expected_total_rows = ${expected_total_rows}
    # Log To Console    display_item_1 = &{display_item_1}
    # Log To Console    category_key_data_value1 = @{data_value1}[0]
    # Log To Console    product_key_data_value1 = @{data_value1}[1]
    # Log To Console    expected_display = &{expected_display}
    # Log To Console    display_item_1 = &{display_item_1}
    # Log To Console    expected_total_rows AGAIN = ${expected_total_rows}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}
    Log To Console    Add Product A Success!!!

Add Product To Category 1 Product B
    [Arguments]    ${cat_pkey}
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-3}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    # @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    1
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}
    Log To Console    Add Product B Success!!!

Add Product To Category 1 Product C
    [Arguments]    ${cat_pkey}
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-3}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    # @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    1
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}
    Log To Console    Add Product C Success!!!

Add Product To Category 1 Product D
    [Arguments]    ${cat_pkey}
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-4}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    # @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    1
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}
    Log To Console    Add Product D Success!!!

Add Product To Category 2 Product
    [Arguments]    ${cat_pkey}
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    # @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    2
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

Add Product To Category 3 Product
    [Arguments]    ${cat_pkey}
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data_value3}=    Create List    ${cat_pkey}       &{product-disc-3}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    # @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    3
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

Add Product To Category 4 Product
    [Arguments]    ${cat_pkey}
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data_value3}=    Create List    ${cat_pkey}       &{product-disc-3}[pkey]
    @{data_value4}=    Create List    ${cat_pkey}       &{product-disc-4}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    # @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    4
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{display_item_4}=    Create Dictionary    category_key=@{data_value4}[0]    product_key=@{data_value4}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}    5=&{display_item_4}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

Get Total Product
    ${response}=     Get Response Body
    ${total_product}=    Get Json Value    ${response}    /data/total_product
    Return From Keyword    ${total_product}

Verify Total Product By Category ID
    [Arguments]    ${cat_id}    ${cat_pkey}   ${expected_product}
    # Log To Console    Verify Total Product By Category ID
    # Log To Console    cat id = ${cat_id}
    # Log To Console    cat pkey = ${cat_pkey}
    # Log To Console    expected product = ${expected_product}
    ${response}=    Get Category By Category ID    ${cat_id}
    # Log To Console    response = ${response}
    ${total_product}=    Get Total Product
    Log To Console    \n Keyword Verify Total Product [Category Pkey : ${cat_pkey}] = ${total_product}
    Should Be Equal As Strings    "${total_product}"    "${expected_product}"

Verify Total Product By Category Pkey
    [Arguments]    ${cat_id}    ${cat_pkey}   ${expected_product}
    # Log To Console    Verify Total Product By Category ID
    # Log To Console    cat id = ${cat_id}
    # Log To Console    cat pkey = ${cat_pkey}
    # Log To Console    expected product = ${expected_product}
    ${response}=    Get Category By Category Pkey    ${cat_pkey}
    # Log To Console    response = ${response}
    ${total_product}=    Get Total Product
    Log To Console    \n Keyword Verify Total Product [Category Pkey : ${cat_pkey}] = ${total_product}
    Should Be Equal As Strings    "${total_product}"    "${expected_product}"

Verify Total Product By Merchant Code
    [Arguments]    ${cat_id}    ${merchant_code}   ${expected_product}
    Log To Console    Verify Total Product By Merchant Code
    Log To Console    Category ID = ${cat_id}
    Log To Console    merchant code = ${merchant_code}
    Log To Console    expected product = ${expected_product}
    ${response}=    Get Category By Merchant Code    ${merchant_code}
    # Log To Console    ${response}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    # Log    ${categories}    console=yes
    ${index}=   Set Variable    1

    :FOR    ${cat}    IN    @{categories}
    \    Run Keyword If    '${cat_id}'=='${EMPTY}'    Exit For Loop
    # \    Log To Console    rescs=${cat}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${total_product}=    Get From Dictionary    ${cat}    total_product
    \    ${is_test_cat}=    Run Keyword And Return Status    Should Be Equal As Numbers    ${id}    ${cat_id}
    \    Log To Console    Round [${index}] : Found ID = ${id} , Expected ID = ${cat_id} , Found = ${is_test_cat}
    \    ${index}=    Evaluate    ${index}+1
    \    Run Keyword If    '${id}' == '${cat_id}'     Log To Console    Total Product = ${total_product}
    \    Run Keyword If    ${is_test_cat}    Exit For Loop
    Log To Console    Keyword Verify Total Product [Category ID : ${cat_id} , Merchant Code : ${merchant_code}] = ${total_product} \n
    Should Be Equal As Strings    "${total_product}"    "${expected_product}"

Verify Total Product By Get All Category
    [Arguments]    ${cat_id}   ${expected_product}
    Log To Console    \n Verify Total Product By Get All Category
    Log To Console    Category ID = ${cat_id} , Expected Product = ${expected_product}
    ${response}=    Get All Category
    # Log To Console    response = ${response}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    ${index}=   Set Variable    1

    :FOR    ${cat}    IN    @{categories}
    \    Run Keyword If    '${cat_id}'=='${EMPTY}'    Exit For Loop
    # \    Log To Console    rescs=${cat}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${total_product}=    Get From Dictionary    ${cat}    total_product
    \    ${is_test_cat}=    Run Keyword And Return Status    Should Be Equal As Numbers    ${id}    ${cat_id}
    \    Log To Console    Round [${index}] : Found ID = ${id} , Expected ID = ${cat_id} , Found = ${is_test_cat}
    \    ${index}=    Evaluate    ${index}+1
    \    Run Keyword If    '${id}' == '${cat_id}'     Log To Console    Total Product = ${total_product}
    \    Run Keyword If    ${is_test_cat}    Exit For Loop
    Log To Console    Keyword Verify Total Product [Category ID : ${cat_id}] = ${total_product} \n
    Should Be Equal As Strings    "${total_product}"    "${expected_product}"

Verify Total Product By Get Category Root
    [Arguments]    ${cat_id}   ${expected_product}
    Log To Console    \n Verify Total Product By Get Category Root
    Log To Console    Category ID = ${cat_id} , Expected Product = ${expected_product}
    ${response}=    Get Category By Category Root
    # Log To Console    response = ${response}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    ${index}=   Set Variable    1

    :FOR    ${cat}    IN    @{categories}
    \    Run Keyword If    '${cat_id}'=='${EMPTY}'    Exit For Loop
    # \    Log To Console    rescs=${cat}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${total_product}=    Get From Dictionary    ${cat}    total_product
    \    ${is_test_cat}=    Run Keyword And Return Status    Should Be Equal As Numbers    ${id}    ${cat_id}
    \    Log To Console    Round [${index}] : Found ID = ${id} , Expected ID = ${cat_id} , Found = ${is_test_cat}
    \    ${index}=    Evaluate    ${index}+1
    \    Run Keyword If    '${id}' == '${cat_id}'     Log To Console    Total Product = ${total_product}
    \    Run Keyword If    ${is_test_cat}    Exit For Loop
    Log To Console    Keyword Verify Total Product [Category ID : ${cat_id}] = ${total_product} \n
    Should Be Equal As Strings    "${total_product}"    "${expected_product}"

Verify Total Product By Get Category Root From Merchant Code
    [Arguments]    ${cat_id}   ${expected_product}
    # ${response}=   Set Variable    ${EMPTY}
    # ${categories}=   Set Variable    ${EMPTY}
    # ${total_product}=   Set Variable    0
    # ${cat}=   Set Variable    ${EMPTY}
    # ${id}=   Set Variable    ${EMPTY}
    # ${is_test_cat}=   Set Variable    ${EMPTY}
    # ${index}=   Set Variable    ${EMPTY}

    Log To Console    \n Verify Total Product By Get Merchant Root
    Log To Console    Merchant Code = ${merchant_code} , Expected Product = ${expected_product}
    ${response}=    Get Category Root By Merchant Code    ${merchant_code}
    # Log To Console    response = ${response}
    ${categories}=    Get Json Value and Convert to List    ${response}    /data
    ${index}=   Set Variable    1

    :FOR    ${cat}    IN    @{categories}
    \    Run Keyword If    '${cat_id}'=='${EMPTY}'    Exit For Loop
    # \    Log To Console    rescs=${cat}
    \    ${id}=    Get From Dictionary    ${cat}    id
    \    ${total_product}=    Get From Dictionary    ${cat}    total_product
    \    ${is_test_cat}=    Run Keyword And Return Status    Should Be Equal As Numbers    ${id}    ${cat_id}
    \    Log To Console    Round [${index}] : Found ID = ${id} , Expected ID = ${cat_id} , Found = ${is_test_cat}
    \    ${index}=    Evaluate    ${index}+1
    \    Run Keyword If    '${id}' == '${cat_id}'     Log To Console    Total Product = ${total_product}
    \    Run Keyword If    ${is_test_cat}    Exit For Loop
    Log To Console    Keyword Verify Total Product [Category ID : ${cat_id} , Merchant Code : ${merchant_code}] = ${total_product} \n
    Should Be Equal As Strings    "${total_product}"    "${expected_product}"