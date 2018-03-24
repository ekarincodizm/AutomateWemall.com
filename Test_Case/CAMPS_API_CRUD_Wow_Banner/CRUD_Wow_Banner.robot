*** Settings ***
Force Tags        WLS_API_CAMP
Resource          ../../Resource/Config/stark/camps_libs_resources.robot
Test Teardown    Delete Flashsale Via API By List    ${g_flash_sale_id}

*** Test Cases ***
TC_CAMPS_00006 Create Wow Banner FlashSale
    [Tags]    TC_CAMPS_00006    ready    Regression    WLS_High

    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=110 day
    ${tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    Log Json    ${body}
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}

TC_CAMPS_00007 Create Wow Banner FlashSale With invalid Json
    [Tags]    TC_CAMPS_00007    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=100 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${EMPTY}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    ${EMPTY}    ${EMPTY}    wow_banner    ${product_json}
    Response Status Code Should Equal    400
    Response Body Should Contain  flashSale name may not be empty
    Log Json    ${body}

TC_CAMPS_00008 Create Wow Banner FlashSale with invalid Flashsale type
    [Tags]    TC_CAMPS_00008    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=100 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_invalid_type    ${product_json}
    Response Status Code Should Equal    400
    Response Body Should Contain  flashSale type Value specified is not valid
    Log Json    ${body}

TC_CAMPS_00093 Delete Wow Banner FlashSale with existing Flashsale id
    [Tags]    TC_CAMPS_00093    ready    Regression    WLS_High
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=100 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_banner    ${product_json}
    Response Status Code Should Equal    201

    Log Json    ${body}
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    Delete Flashsale Via API By ID    ${flash_sale_id}
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    Response Status Code Should Equal    404

TC_CAMPS_00094 Delete Wow Banner FlashSale with not existing Flashsale id
    [Tags]    TC_CAMPS_00094    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=100 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_banner    ${product_json}
    Response Status Code Should Equal    201

    Log Json    ${body}
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    Delete Flashsale Via API By ID    ${flash_sale_id}
    Delete Flashsale Via API By ID    ${flash_sale_id}
    Response Status Code Should Equal    404


TC_CAMPS_00009 Update Wow Banner FlashSale should return Wow Banner updated
    [Tags]    TC_CAMPS_00009    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=100 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_banner    ${product_json}
    Response Status Code Should Equal    201

    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
  	${mod_current_date}=    Get Current Date    increment=210 day
    ${mod_tomorrow_date}=    Get Current Date    increment=211 day
    ${status}    ${body}=    Update Flash Sale Wow Banner via API    ${flash_sale_id}   modified_name    modified_name_translation
    ...    modified_short_desc    modified_short_desc_translation    2    ATM    ${mod_current_date}
    ...    ${mod_tomorrow_date}    disable    non-member    wow_banner     ${product_json}
    Response Status Code Should Equal    200
    Log Json    ${body}
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    ${name}=    Get Json Value and Convert to List    ${body}    /data/name
    ${name_translation}=    Get Json Value and Convert to List    ${body}    /data/name_translation
    ${short_description}=    Get Json Value and Convert to List    ${body}    /data/short_description
    ${short_description_translation}=    Get Json Value and Convert to List    ${body}    /data/short_description_translation
    Should Be Equal    ${name}    modified_name
    Should Be Equal    ${name_translation}    modified_name_translation
    Should Be Equal    ${short_description}    modified_short_desc
    Should Be Equal    ${short_description_translation}    modified_short_desc_translation

TC_CAMPS_00010 Update Wow Banner FlashSale with Json invalid

    [Tags]    TC_CAMPS_00010    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=99 day
    ${tomorrow_date}=    Get Current Date    increment=100 day

    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
	${mod_current_date}=    Get Current Date    increment=210 day
    ${mod_tomorrow_date}=    Get Current Date    increment=211 day
    ${status}    ${body}=    Update Flash Sale Wow Banner via API    ${flash_sale_id}   modified_name    modified_name_translation
    ...    modified_short_desc    modified_short_desc_translation    2    ATM    ${mod_current_date}
    ...    ${mod_tomorrow_date}    disable    non-member    invalid    ${product_json}
    Response Status Code Should Equal    400

TC_CAMPS_00011 Update Not Existing Wow Banner FlashSale
    [Tags]    TC_CAMPS_00011     ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${mod_current_date}=    Get Current Date    increment=210 day
    ${mod_tomorrow_date}=    Get Current Date    increment=211 day
    ${status}    ${body}=    Update Flash Sale Wow Banner via API    999999999   modified_name    modified_name_translation
    ...    modified_short_desc    modified_short_desc_translation    2    ATM    ${mod_current_date}
    ...    ${mod_tomorrow_date}    disable    non-member    wow_banner    ${product_json}
    Response Status Code Should Equal    404

TC_CAMPS_00012 Update Wow Banner FlashSale with extra-wow type
    [Tags]    TC_CAMPS_00012    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${current_date}=    Get Current Date    increment=110 day
    ${tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_banner        ${product_json}
    Response Status Code Should Equal    201
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
	${mod_current_date}=    Get Current Date    increment=210 day
    ${mod_tomorrow_date}=    Get Current Date    increment=211 day
    ${status}    ${body}=    Update Flash Sale Wow Banner via API    ${flash_sale_id}   modified_name    modified_name_translation
    ...    modified_short_desc    modified_short_desc_translation    2    ATM    ${mod_current_date}
    ...    ${mod_tomorrow_date}    disable    non-member    wow_extra    ${product_json}
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    ${flash_sale_type}=    Get Json Value and Convert to List    ${body}    /data/type
    Should Be Equal    ${flash_sale_type}    wow_banner

TC_CAMPS_00013 Get Wow Banner FlashSale
    [Tags]    TC_CAMPS_00013    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
	  ${current_date}=    Get Current Date    increment=110 day
    ${tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member   wow_banner    ${product_json}
    Response Status Code Should Equal    201
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    ${get_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    Response Status Code Should Equal    200
    Should Be Equal    ${get_flash_sale_id}    ${flash_sale_id}

TC_CAMPS_00014 Get All Wow Banner FlashSale
    [Tags]    TC_CAMPS_00014    ready    Regression    WLS_High
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
	  ${first_current_date}=    Get Current Date    increment=110 day
    ${first_tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${first_current_date}
    ...    ${first_tomorrow_date}    enable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id}
    ${second_current_date}=    Get Current Date    increment=210 day
    ${second_tomorrow_date}=    Get Current Date    increment=211 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${second_current_date}
    ...    ${second_tomorrow_date}    enable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${g_flash_sale_id},${second_flash_sale_id}
    ${status}    ${body}=    Get All Flash Sale Wow Banner
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    id
    \    Append To List    ${flash_sale_id_list}    ${id}
    Response Status Code Should Equal    200
    Log    ${flash_sale_id_list}
    List Should Contain Value    ${flash_sale_id_list}    ${first_flash_sale_id}
    List Should Contain Value    ${flash_sale_id_list}    ${second_flash_sale_id}

TC_CAMPS_00015 Wow Banner should be enabled correctly
    [Tags]    TC_CAMPS_00015    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
	  ${current_date}=    Get Current Date    increment=110 day
    ${tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    disable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
    Should Be Equal    ${false}    ${flash_sale_status}
    Update status flashsale via API    ${flash_sale_id}    enabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${flash_sale_status}
    Update status flashsale via API   ${flash_sale_id}    enabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${flash_sale_status}

TC_CAMPS_00016 Wow Banner should be disabled correctly
    [Tags]    TC_CAMPS_00016    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
  	${current_date}=    Get Current Date    increment=110 day
    ${tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    ${flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${flash_sale_id}
    Should Be Equal    ${true}    ${flash_sale_status}
    Update status flashsale via API    ${flash_sale_id}    disabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${flash_sale_status}
    Update status flashsale via API    ${flash_sale_id}    disabled
    Response Status Code Should Equal    200
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${flash_sale_status}

TC_CAMPS_00017 Wow Banner should be enabled when enable wow banner by batch id correctly
    [Tags]    TC_CAMPS_00017    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${first_current_date}=    Get Current Date    increment=110 day
    ${first_tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${first_current_date}
    ...    ${first_tomorrow_date}    disable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id}
    ${second_current_date}=    Get Current Date    increment=210 day
    ${second_tomorrow_date}=    Get Current Date    increment=211 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${second_current_date}
    ...    ${second_tomorrow_date}    disable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${g_flash_sale_id},${second_flash_sale_id}
    Update status flashsale via API by Batch    ${first_flash_sale_id},${second_flash_sale_id}    enabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${first_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${flash_sale_status}

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${second_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${flash_sale_status}

    Update status flashsale via API by Batch    ${first_flash_sale_id},${second_flash_sale_id}    enabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${first_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${flash_sale_status}

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${second_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${true}    ${flash_sale_status}

TC_CAMPS_00018 Wow Banner should be disabled when disabled wow banner by batch id correctly
    [Tags]    TC_CAMPS_00018    ready    Regression    WLS_Medium
    @{create_variant_id_list}=    Create List    AAAA1111    BBBB1111
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product}=    Create FlashSaleProduct    PD111111    ${create_category_list}    ${flashsale_variant_list}
    ${product_json}=    Stringify JSON    ${flash_sale_product}
    ${first_current_date}=    Get Current Date    increment=110 day
    ${first_tomorrow_date}=    Get Current Date    increment=111 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${first_current_date}
    ...    ${first_tomorrow_date}    enable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id}
    ${second_current_date}=    Get Current Date    increment=210 day
    ${second_tomorrow_date}=    Get Current Date    increment=211 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    short_name    short_name_tran    1    cod    ${second_current_date}
    ...    ${second_tomorrow_date}    disable    member    wow_banner   ${product_json}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${g_flash_sale_id},${second_flash_sale_id}
    Update status flashsale via API by Batch    ${first_flash_sale_id},${second_flash_sale_id}    disabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${first_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${flash_sale_status}

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${second_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${flash_sale_status}

    Update status flashsale via API by Batch    ${first_flash_sale_id},${second_flash_sale_id}    disabled
    Response Status Code Should Equal    200

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${first_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${flash_sale_status}

    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    ${second_flash_sale_id}
    ${flash_sale_status}=    Get Json Value and Convert to List    ${body}    /data/enable
    Should Be Equal    ${false}    ${flash_sale_status}

TC_CAMPS_00019 Error message should be returned when enable not existing Wow Banner
    [Tags]    TC_CAMPS_00019    ready    Regression    WLS_Medium
  	Update status flashsale via API    999999999    enabled
    Response Status Code Should Equal    404

TC_CAMPS_00020 Error message should be returned when disable not existing Wow Banner
    [Tags]    TC_CAMPS_00020    ready    Regression    WLS_Medium
	Update status flashsale via API    999999999    disabled
    Response Status Code Should Equal    404

TC_CAMPS_00095 Get Not Existing Wow Extra FlashSale should return error message
    [Tags]    TC_CAMPS_00095    ready    Regression    WLS_Medium
    ${status}    ${body}=    Get Flash Sale Wow Banner by Flash Sale Id via API    999999999
    Response Status Code Should Equal    404
