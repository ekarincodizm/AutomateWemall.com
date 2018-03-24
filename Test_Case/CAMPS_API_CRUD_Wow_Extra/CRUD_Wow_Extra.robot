*** Settings ***
Force Tags        WLS_API_CAMP
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_00096 Create Wow Extra FlashSale should return Wow Extra created
    [Tags]    TC_CAMPS_00096    ready    Regression    WLS_High
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=20 day
    ${tomorrow_date}=    Get Current Date    increment=21 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id
    Delete Flashsale Via API By ID    ${promotion_id}


TC_CAMPS_00097 Create Wow Extra FlashSale With invalid Json should return error message
    [Tags]    TC_CAMPS_00097    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=100 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    invalid_type    ${product_json}
    Response Status Code Should Equal    400
    log    ${body}


TC_CAMPS_00098 Create Wow Extra FlashSale with invalid Flashsale type should return error mesasge
    [Tags]    TC_CAMPS_00098    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}
    ${current_date}=    Get Current Date    increment=100 day
    ${tomorrow_date}=    Get Current Date    increment=101 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    invalid_type    ${product_json}
    Response Status Code Should Equal    400
    log    ${body}

TC_CAMPS_00099 Update Wow Extra FlashSale should return Wow Extra updated
    [Tags]    TC_CAMPS_00099    ready    Regression    WLS_High

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=20 day
    ${tomorrow_date}=    Get Current Date    increment=21 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list_update}=    Create List    AAAA2222    BBBB2222
    @{create_category_list_update}=    Create List    Category1Upddate    Category2Upddate
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list_update}
    ${flash_sale_product1_update}=    Create FlashSaleProduct    PD111111    ${create_category_list_update}    ${flashsale_variant_list}
    ${flash_sale_product2_update}=    Create FlashSaleProduct    PD222222    ${create_category_list_update}    ${flashsale_variant_list}
    @{create_product_list_update}=    Create List    ${flash_sale_product1_update}    ${flash_sale_product2_update}
    ${product_json_update}=    Stringify JSON    ${create_product_list_update}

    ${status}    ${body}=    Update Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json_update}    ${promotion_id}

    Response Status Code Should Equal    200
    Delete Flashsale Via API By ID    ${promotion_id}

TC_CAMPS_00100 Update Wow Extra FlashSale with Json invalid should return error message
    [Tags]    TC_CAMPS_00100    ready    Regression    WLS_Medium

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=20 day
    ${tomorrow_date}=    Get Current Date    increment=21 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id


    @{create_variant_id_list_update}=    Create List    AAAA2222    BBBB2222
    @{create_category_list_update}=    Create List    Category1update    Category2update
    ${flashsale_variant_list_update}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1_update}=    Create FlashSaleProduct    PD111111    ${create_category_list_update}    ${flashsale_variant_list_update}
    ${flash_sale_product2_update}=    Create FlashSaleProduct    PD222222    ${create_category_list_update}    ${flashsale_variant_list_update}
    @{create_product_list_update}=    Create List    ${flash_sale_product1_update}    ${flash_sale_product2_update}
    ${product_json_update}=    Stringify JSON    ${create_product_list_update}

    ${status}    ${body}=    Update Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_invalid    ${product_json_update}    ${promotion_id}

    Response Status Code Should Equal    400
    Delete Flashsale Via API By ID    ${promotion_id}


TC_CAMPS_00101 Update Wow Extra FlashSale with Json invalid should return error message
    [Tags]    TC_CAMPS_00101    ready    Regression    WLS_Medium

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=20 day
    ${tomorrow_date}=    Get Current Date    increment=21 day

    ${status}    ${body}=    Update Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}    9999999999

    Response Status Code Should Equal    404

TC_CAMPS_00102 Type should not Updated when update Wow extra with type
    [Tags]    TC_CAMPS_00102    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=20 day
    ${tomorrow_date}=    Get Current Date    increment=21 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list_update}=    Create List    AAAA2222    BBBB2222
    @{create_category_list_update}=    Create List    Category1update    Category2update
    ${flashsale_variant_list_update}=    Create FlashSaleVariant    ${create_variant_id_list_update}
    ${flash_sale_product1_update}=    Create FlashSaleProduct    PD111111    ${create_category_list_update}    ${flashsale_variant_list_update}
    ${flash_sale_product2_update}=    Create FlashSaleProduct    PD222222    ${create_category_list_update}    ${flashsale_variant_list_update}
    @{create_product_list_update}=    Create List    ${flash_sale_product1_update}    ${flash_sale_product2_update}
    ${product_json_update}=    Stringify JSON    ${create_product_list_update}

    ${status}    ${body}=    Update Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_banner    ${product_json_update}    ${promotion_id}

    Response Status Code Should Equal    200
    ${wow_type}=    Get Json Value and Convert to List    ${body}    /data/type
    Should Be Equal    ${wow_type}    wow_extra
    Delete Flashsale Via API By ID    ${promotion_id}

TC_CAMPS_00103 Get Wow Extra FlashSale should return Wow Extra correctly
   [Tags]    TC_CAMPS_00103    ready    Regression    WLS_Medium

   @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
   @{create_category_list}=    Create List    Category1    Category2
   ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
   ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
   ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
   @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
   ${product_json}=    Stringify JSON    ${create_product_list}

   ${current_date}=    Get Current Date    increment=20 day
   ${tomorrow_date}=    Get Current Date    increment=21 day
   ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
   ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
   ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
   Response Status Code Should Equal    201
   log    ${body}
   ${promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

   ${status}    ${body}=    Get Wow Extra By Id via API    ${promotion_id}
   log     ${body}
   Response Status Code Should Equal    200

   Delete Flashsale Via API By ID    ${promotion_id}

TC_CAMPS_00104 Get Not Existing Wow Extra FlashSale should return error message
  [Tags]    TC_CAMPS_00104    ready    Regression    WLS_Medium

  ${status}    ${body}=    Get Wow Extra By Id via API    999999
  log    ${body}
  log    ${status}
  Response Status Code Should Equal    404


TC_CAMPS_00105 Get All Wow Extra FlashSale should return pagination Wow Extra correctly
    [Tags]    TC_CAMPS_00105    ready    Regression    WLS_Medium

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=10 day
    ${tomorrow_date}=    Get Current Date    increment=11 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${promotion_id_first}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list_second}=    Create List    AAAA1111    BBBB1111
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product1_second}=    Create FlashSaleProduct    PD111111    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${flash_sale_product2_second}=    Create FlashSaleProduct    PD222222    ${create_category_list_second}    ${flashsale_variant_list_second}
    @{create_product_list_second}=    Create List    ${flash_sale_product1_second}    ${flash_sale_product2_second}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date}=    Get Current Date    increment=12 day
    ${tomorrow_date}=    Get Current Date    increment=13 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    log    ${body}
    ${promotion_id_second}=    Get Json Value and Convert to List    ${body}    /data/id

    ${status}    ${body}=    Get All Flash Sale Wow Banner
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    ${promotion_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    id
    \    Append To List    ${promotion_id_list}    ${id}
    Response Status Code Should Equal    200
    Log    ${promotion_id_list}
    List Should Contain Value    ${promotion_id_list}    ${promotion_id_first}
    List Should Contain Value    ${promotion_id_list}    ${promotion_id_second}
    Delete Flashsale Via API By ID    ${promotion_id_first}
    Delete Flashsale Via API By ID    ${promotion_id_second}

TC_CAMPS_00106 Wow Extra should be enabled when enable wow Extra by id correctly
    [Tags]    TC_CAMPS_00106   ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=10 day
    ${tomorrow_date}=    Get Current Date    increment=11 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${promotion_status}
    Update status flashsale via API    ${promotion_id}    enabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Wow Extra By Id via API    ${promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${promotion_status}
    Update status flashsale via API   ${promotion_id}    enabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Wow Extra By Id via API    ${promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${promotion_status}
    Delete Flashsale Via API By ID    ${promotion_id}

TC_CAMPS_00107 Wow Extra should be disable when disable wow Extra by id correctly
    [Tags]    TC_CAMPS_00107   ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=10 day
    ${tomorrow_date}=    Get Current Date    increment=11 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${promotion_status}
    Update status flashsale via API    ${promotion_id}    disabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Wow Extra By Id via API    ${promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${promotion_status}
    Update status flashsale via API   ${promotion_id}    disabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Wow Extra By Id via API    ${promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${promotion_status}
    Delete Flashsale Via API By ID    ${promotion_id}

TC_CAMPS_00108 Wow Extra should be enabled when enble wow Extra by batch id correctly
    [Tags]    TC_CAMPS_00108    ready    Regression    WLS_Medium

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=10 day
    ${tomorrow_date}=    Get Current Date    increment=11 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${first_promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list_second}=    Create List    AAAA1111    BBBB1111
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product1_second}=    Create FlashSaleProduct    PD111111    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${flash_sale_product2_second}=    Create FlashSaleProduct    PD222222    ${create_category_list_second}    ${flashsale_variant_list_second}
    @{create_product_list_second}=    Create List    ${flash_sale_product1_second}    ${flash_sale_product2_second}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date}=    Get Current Date    increment=12 day
    ${tomorrow_date}=    Get Current Date    increment=13 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    disable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    log    ${body}
    ${second_promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    Update status flashsale via API by Batch    ${first_promotion_id},${second_promotion_id}    enabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Wow Extra By Id via API    ${first_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${promotion_status}

    ${status}    ${body}=    Get Wow Extra By Id via API    ${second_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${promotion_status}

    Update status flashsale via API by Batch    ${first_promotion_id},${second_promotion_id}    enabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Wow Extra By Id via API    ${first_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${promotion_status}

    ${status}    ${body}=    Get Wow Extra By Id via API    ${second_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${promotion_status}

    Delete Flashsale Via API By ID    ${first_promotion_id}
    Delete Flashsale Via API By ID    ${second_promotion_id}

TC_CAMPS_00109 Wow Extra should be disabled when disable wow Extra by batch id correctly
    [Tags]    TC_CAMPS_00109    ready    Regression    WLS_Medium

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=10 day
    ${tomorrow_date}=    Get Current Date    increment=11 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    log    ${body}
    ${first_promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list_second}=    Create List    AAAA1111    BBBB1111
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product1_second}=    Create FlashSaleProduct    PD111111    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${flash_sale_product2_second}=    Create FlashSaleProduct    PD222222    ${create_category_list_second}    ${flashsale_variant_list_second}
    @{create_product_list_second}=    Create List    ${flash_sale_product1_second}    ${flash_sale_product2_second}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date}=    Get Current Date    increment=12 day
    ${tomorrow_date}=    Get Current Date    increment=13 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    log    ${body}
    ${second_promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    Update status flashsale via API by Batch    ${first_promotion_id},${second_promotion_id}    disabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Wow Extra By Id via API    ${first_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${promotion_status}

    ${status}    ${body}=    Get Wow Extra By Id via API    ${second_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${promotion_status}

    Update status flashsale via API by Batch    ${first_promotion_id},${second_promotion_id}    disabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Wow Extra By Id via API    ${first_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${promotion_status}

    ${status}    ${body}=    Get Wow Extra By Id via API    ${second_promotion_id}
    ${promotion_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${promotion_status}

    Delete Flashsale Via API By ID    ${first_promotion_id}
    Delete Flashsale Via API By ID    ${second_promotion_id}

TC_CAMPS_00110 Error message should be returned when enable not existing Wow Extra
    [Tags]    TC_CAMPS_00110    ready    Regression    WLS_Medium
	Update status flashsale via API    999999999    enabled
    Response Status Code Should Equal    404


TC_CAMPS_00111 Error message should be returned when disable not existing Wow Extra
    [Tags]    TC_CAMPS_00111    ready    Regression    WLS_Medium
	Update status flashsale via API    999999999    disabled
    Response Status Code Should Equal    404

TC_CAMPS_00113 Create Wow Extra FlashSale under the same period should return Wow Extra created
    [Tags]    TC_CAMPS_00113    ready    Regression    WLS_Medium

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${flash_sale_product2}=    Create FlashSaleProduct    PD222222    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}    ${flash_sale_product2}
    ${product_json}=    Stringify JSON    ${create_product_list}
    ${current_date}=    Get Current Date    increment=20 day
    ${tomorrow_date}=    Get Current Date    increment=21 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${first_promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    @{create_variant_id_list_second}=    Create List    AAAA1111    BBBB1111
    @{create_category_list_second}=    Create List    Category1    Category2
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product1_second}=    Create FlashSaleProduct    PD111111    ${create_category_list_second}    ${flashsale_variant_list_second}
    ${flash_sale_product2_second}=    Create FlashSaleProduct    PD222222    ${create_category_list_second}    ${flashsale_variant_list_second}
    @{create_product_list_second}=    Create List    ${flash_sale_product1_second}    ${flash_sale_product2_second}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}
    ${current_date}=    Get Current Date    increment=20 day
    ${tomorrow_date}=    Get Current Date    increment=21 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   ${TEST_NAME}    ${TEST_NAME}
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_promotion_id}=    Get Json Value and Convert to List    ${body}    /data/id

    Delete Flashsale Via API By ID    ${first_promotion_id}
    Delete Flashsale Via API By ID    ${second_promotion_id}
