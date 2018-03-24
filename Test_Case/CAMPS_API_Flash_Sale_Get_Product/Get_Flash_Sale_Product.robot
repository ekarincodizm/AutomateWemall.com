*** Settings ***
Force Tags        WLS_API_CAMP
Resource          ../../Resource/Config/stark/camps_libs_resources.robot
Test Teardown    Delete Flashsale Via API By List    ${g_flash_sale_id}
*** Test Cases ***


TC_CAMPS_01022 When get non existing Flash sale product by product key, it should return reponse with status 404
    [Tags]    TC_CAMPS_01022    ready    Regression    WLS_Medium
    ${product_key}=    Convert To String    AAAA1010
    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}
    Response Status Code Should Equal    404

TC_CAMPS_01023 When get Wow Extra product by product key, it should return product detail correctly
    [Tags]    TC_CAMPS_01023    ready    Regression    WLS_Medium
    ${product_key}=    Convert To String    AAAA9999
    @{create_variant_id_list}=    Create List    VA1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    99    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}

    Response Status Code Should Equal    200
    Assert Get Product FlashSale    ${body}    ${product_key}    99    50


TC_CAMPS_01024 When get Wow Extra product by product key, it should return product that has the cheapest price with product detail correctly
    [Tags]    TC_CAMPS_01024    ready    Regression    WLS_Medium
    ${product_key}=    Convert To String    AAAA9999
    @{create_variant_id_list}=    Create List    VA1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    99    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VA1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    500    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}

    Response Status Code Should Equal    200
    Assert Get Product FlashSale    ${body}    ${product_key}    99    50

#This test case is not stable when current time has been Flashsale wow banner
TC_CAMPS_01025 When get Wow Banner product by product key, it should return product detail correctly
    [Tags]    TC_CAMPS_01025    ready    Regression    WLS_Medium
    ${product_key}=    Convert To String    AAAA9999
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}     9    99    50
    ${flash_sale_product}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}

    Response Status Code Should Equal    200
    Assert Get Product FlashSale    ${body}    ${product_key}    99    50

#This test case is not stable when current time has been Flashsale wow banner
TC_CAMPS_01026 When get Flashsale product by product key that is set to both Wow Banner and Wow Extra (cheapest price), it should return product with the cheapest product with product detail correctly
    [Tags]    TC_CAMPS_01026    ready    Regression    WLS_High
    ${product_key}=    Convert To String    AAAA9999
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}     9    99    50
    ${flash_sale_product}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    500    20
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}

    Response Status Code Should Equal    200
    Assert Get Product FlashSale    ${body}    ${product_key}    99    50

#This test case is not stable when current time has been Flashsale wow banner
TC_CAMPS_01027 When get Flashsale product by product key that is set to both Wow Banner and Wow Extra1 (cheapest price) and Wow Extra 2,it should return product under live Flashsale with the cheapest product with product detail correctly
    [Tags]    TC_CAMPS_01027    ready    Regression    WLS_High
    ${product_key}=    Convert To String    AAAA9999
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}     9    200    20
    ${flash_sale_product}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    100    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}

    Response Status Code Should Equal    200
    Assert Get Product FlashSale    ${body}    ${product_key}    100    50

#This test case is not stable when current time has been Flashsale wow banner
TC_CAMPS_01028 When get Flashsale product by product key that is set to both Wow Banner and Wow Extra1 (cheapest price) and Wow Extra 2,it should return product under live Flashsale with the cheapest product with product detail correctly
    [Tags]    TC_CAMPS_01028    ready    Regression    WLS_High
    ${product_key}=    Convert To String    AAAA9999
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}     9    500    20
    ${flash_sale_product}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    99    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    200    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${third_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}

    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}

    Response Status Code Should Equal    200
    Assert Get Product FlashSale    ${body}    ${product_key}    200    50

TC_CAMPS_01029 When get Wow Extra product by product key,it should return product under live Wow Extra with the cheapest product with product detail correctly
    [Tags]    TC_CAMPS_01029    ready    Regression    WLS_Medium
    ${product_key}=    Convert To String    AAAA9999
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    99    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-2 day
    ${tomorrow_date}=    Get Current Date    increment=-1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    150    20
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=1 day
    ${tomorrow_date}=    Get Current Date    increment=2 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    200    50
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 3    Product Wow Extra 3
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${third_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    9    500    20
    ${flash_sale_product1}=    Create FlashSaleProduct    ${product_key}    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 3    Product Wow Extra 3
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${fourth_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id},${fourth_flash_sale_id}

    ${status}    ${body}=    Get Flashsale Product By Product Key via API    ${product_key}

    Response Status Code Should Equal    200
    Assert Get Product FlashSale    ${body}    ${product_key}    500    20
