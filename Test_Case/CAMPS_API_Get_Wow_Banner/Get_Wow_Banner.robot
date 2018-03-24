*** Settings ***
Force Tags        WLS_API_CAMP
Resource          ../../Resource/Config/stark/camps_libs_resources.robot
Test Teardown    Delete Flashsale Via API By List    ${g_flash_sale_id}
*** Test Cases ***


TC_CAMPS_01006 When get Product Wow Banner with current time, it should return Product WowBanner Correctly (1 promotion).
    [Tags]    TC_CAMPS_01006    ready    Regression    WLS_Medium
    #first_promotion
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    BBBB9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id}

    ${time_for_get_wow_banner}=    Get Current Date    increment=100 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    Assert Product Wow Banner    ${body}    /current_wow    "BBBB9999"    "Get Wow Banner Robot"
    ${next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /next_wow
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${next_wow_dictionary}    null
    Should Be Equal    ${after_next_wow_dictionary}    null

TC_CAMPS_01007 When get Product Wow Banner with current time, it should return Product WowBanner Correctly (2 promotion).
    [Tags]    TC_CAMPS_01007    ready    Regression    WLS_Medium
    #first_promotion
    @{create_variant_id_list}=    Create List    VA9991    VA9992
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    #second_promotion
    @{create_variant_id_list_second}=    Create List    VB9991    VB9992
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product_second}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${product_json_second}=    Stringify JSON    ${flash_sale_product_second}

    ${current_date_second}=    Get Current Date    increment=101 day
    ${tomorrow_date_second}=    Get Current Date    increment=102 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot 2    Get Wow Banner Robot 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_banner    ${product_json_second}
    Response Status Code Should Equal    201
    ${first_flash_sale_id_second}=    Get Json Value and Convert to List    ${body}    /data/id


    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${first_flash_sale_id_second}

    ${time_for_get_wow_banner}=    Get Current Date    increment=100 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    Assert Product Wow Banner    ${body}    /current_wow    "AAAA9999"    "Get Wow Banner Robot"
    Assert Product Wow Banner    ${body}    /next_wow    "BBBB9999"    "Get Wow Banner Robot 2"
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${after_next_wow_dictionary}    null


TC_CAMPS_01008 When get Product Wow Banner with current time, it should return Product WowBanner Correctly (3 promotion).
    [Tags]    TC_CAMPS_01008    ready    Regression    WLS_High
    #first_promotion
    @{create_variant_id_list}=    Create List    VA9991    VA9992
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    #second_promotion
    @{create_variant_id_list_second}=    Create List    VB9991    VB9992
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product_second}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${product_json_second}=    Stringify JSON    ${flash_sale_product_second}

    ${current_date_second}=    Get Current Date    increment=101 day
    ${tomorrow_date_second}=    Get Current Date    increment=102 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot 2    Get Wow Banner Robot 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_banner    ${product_json_second}
    Response Status Code Should Equal    201
    ${first_flash_sale_id_second}=    Get Json Value and Convert to List    ${body}    /data/id
    #Third_promotion
    @{create_variant_id_list_third}=    Create List    VC9991    VC9992
    @{create_category_list_third}=    Create List    Category1    Category2
    ${flashsale_variant_list_third}=    Create FlashSaleVariant    ${create_variant_id_list_third}
    ${flash_sale_product_third}=    Create FlashSaleProduct    CCCC9999    ${create_category_list_third}    ${flashsale_variant_list_third}
    ${product_json_third}=    Stringify JSON    ${flash_sale_product_third}

    ${current_date_second}=    Get Current Date    increment=102 day
    ${tomorrow_date_second}=    Get Current Date    increment=103 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot 3    Get Wow Banner Robot 3
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_banner    ${product_json_third}
    Response Status Code Should Equal    201
    ${first_flash_sale_id_third}=    Get Json Value and Convert to List    ${body}    /data/id

    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${first_flash_sale_id_second},${first_flash_sale_id_third}

    ${time_for_get_wow_banner}=    Get Current Date    increment=100 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    Assert Product Wow Banner    ${body}    /current_wow    "AAAA9999"    "Get Wow Banner Robot"
    Assert Product Wow Banner    ${body}    /next_wow    "BBBB9999"    "Get Wow Banner Robot 2"
    Assert Product Wow Banner    ${body}    /after_next_wow    "CCCC9999"    "Get Wow Banner Robot 3"

TC_CAMPS_01009 When get Product Wow Banner with current time and not have promotion Wow Banner ,it should return Product Wow Banner correctly.
    [Tags]    TC_CAMPS_01009    ready    Regression    WLS_High
    #first_promotion
    @{create_variant_id_list}=    Create List    VAAA9991    VAAA9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id}

    ${time_for_get_wow_banner}=    Get Current Date    increment=150 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    ${current_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /current_wow
    ${next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /next_wow
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${current_wow_dictionary}    null
    Should Be Equal    ${next_wow_dictionary}    null
    Should Be Equal    ${after_next_wow_dictionary}    null

TC_CAMPS_01010 When get Product Wow Banner with current time and promotion Wow Banner status is disabled ,it should return Product Wow Banner correctly.
    [Tags]    TC_CAMPS_01010    ready    Regression    WLS_High
    #first_promotion
    @{create_variant_id_list}=    Create List    VAAA9991    VAAA9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id}

    ${time_for_get_wow_banner}=    Get Current Date    increment=100 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    ${current_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /current_wow
    ${next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /next_wow
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${current_wow_dictionary}    null
    Should Be Equal    ${next_wow_dictionary}    null
    Should Be Equal    ${after_next_wow_dictionary}    null

TC_CAMPS_01011 When get Product Wow Banner with current time and current time not have promotion enable,it should return promotion start period nearest current time.
    [Tags]    TC_CAMPS_01011    ready    Regression    WLS_Medium
    #first_promotion
    @{create_variant_id_list}=    Create List    VA9991    VA9992
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    #second_promotion
    @{create_variant_id_list_second}=    Create List    VB9991    VB9992
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product_second}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${product_json_second}=    Stringify JSON    ${flash_sale_product_second}

    ${current_date_second}=    Get Current Date    increment=101 day
    ${tomorrow_date_second}=    Get Current Date    increment=102 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot 2    Get Wow Banner Robot 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_banner    ${product_json_second}
    Response Status Code Should Equal    201
    ${first_flash_sale_id_second}=    Get Json Value and Convert to List    ${body}    /data/id


    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${first_flash_sale_id_second}

    ${time_for_get_wow_banner}=    Get Current Date    increment=100 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    Assert Product Wow Banner    ${body}    /current_wow    "BBBB9999"    "Get Wow Banner Robot 2"
    ${next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /next_wow
    Should Be Equal    ${next_wow_dictionary}    null
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${after_next_wow_dictionary}    null

TC_CAMPS_01012 When get Product Wow Banner with current time and current time not have promotion,it should return promotion start period nearest current time.
    [Tags]    TC_CAMPS_01012    ready    Regression    WLS_Medium
    #first_promotion
    @{create_variant_id_list}=    Create List    VA9991    VA9992
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=101 day
    ${tomorrow_date}=    Get Current Date    increment=102 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id}

    ${time_for_get_wow_banner}=    Get Current Date    increment=100 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    Assert Product Wow Banner    ${body}    /current_wow    "AAAA9999"    "Get Wow Banner Robot"
    ${next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /next_wow
    Should Be Equal    ${next_wow_dictionary}    null
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${after_next_wow_dictionary}    null

TC_CAMPS_01013 When get Product Wow Banner with current time and current time not have promotion enable,it should return promotion start period nearest current time.
    [Tags]    TC_CAMPS_01013    ready    Regression    WLS_Medium
    #first_promotion
    @{create_variant_id_list}=    Create List    VA9991    VA9992
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    #second_promotion
    @{create_variant_id_list_second}=    Create List    VB9991    VB9992
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product_second}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${product_json_second}=    Stringify JSON    ${flash_sale_product_second}

    ${current_date_second}=    Get Current Date    increment=101 day
    ${tomorrow_date_second}=    Get Current Date    increment=102 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot 2    Get Wow Banner Robot 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_banner    ${product_json_second}
    Response Status Code Should Equal    201
    ${first_flash_sale_id_second}=    Get Json Value and Convert to List    ${body}    /data/id


    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${first_flash_sale_id_second}

    ${time_for_get_wow_banner}=    Get Current Date    increment=150 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    ${current_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /current_wow
    ${next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /next_wow
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${current_wow_dictionary}    null
    Should Be Equal    ${next_wow_dictionary}    null
    Should Be Equal    ${after_next_wow_dictionary}    null

TC_CAMPS_01014 When get Product Wow Banner with current time and if any Wow Extra live ,it should return Product Wow Banner with out Wow Extra promotion.
    [Tags]    TC_CAMPS_01014    ready    Regression    WLS_High
    #first_promotion
    @{create_variant_id_list}=    Create List    VA9991    VA9992
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}

    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   Get Wow Banner Robot    Get Wow Banner Robot
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

    #second_promotion
    @{create_variant_id_list_second}=    Create List    VBBB9991    VBBB9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=101 day
    ${tomorrow_date_second}=    Get Current Date    increment=102 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id


    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${time_for_get_wow_banner}=    Get Current Date    increment=100 day
    ${time_for_get_wow_banner}=    Get Epoch Time Wow Extra    ${time_for_get_wow_banner}

    ${status}    ${body}=    Get Product Wow Banner    ${time_for_get_wow_banner}
    Response Status Code Should Equal    200

    Assert Product Wow Banner    ${body}    /current_wow    "AAAA9999"    "Get Wow Banner Robot"
    ${next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /next_wow
    Should Be Equal    ${next_wow_dictionary}    null
    ${after_next_wow_dictionary}=    Get Wow Banner node by json field name    ${body}    /after_next_wow
    Should Be Equal    ${after_next_wow_dictionary}    null
