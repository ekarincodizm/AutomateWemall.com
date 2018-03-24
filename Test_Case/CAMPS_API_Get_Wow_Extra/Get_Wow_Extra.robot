*** Settings ***
Force Tags        WLS_API_CAMP
Resource          ../../Resource/Config/stark/camps_libs_resources.robot
Test Teardown    Delete Flashsale Via API By List    ${g_flash_sale_id}
*** Test Cases ***


TC_CAMPS_00130 When get Product Wow Extra, it should return Product Wow Extra with paging order by ascending start period.
    [Tags]    TC_CAMPS_00130    ready    Regression    WLS_Medium
    #first_promotion
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    BBBB9999    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-2 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id

   #second_promotion
   @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
   @{create_category_list_second}=    Create List    Category3    Category4
   ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
   ${flash_sale_product2}=    Create FlashSaleProduct    AAAA9999    ${create_category_list_second}    ${flashsale_variant_list_second}

   @{create_product_list_second}=    Create List    ${flash_sale_product2}
   ${product_json_second}=    Stringify JSON    ${create_product_list_second}

   ${current_date_second}=    Get Current Date    increment=-1 minutes
   ${tomorrow_date_second}=    Get Current Date    increment=1 day
   ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
   ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
   ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
   Response Status Code Should Equal    201
   ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
   ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

   ${status}    ${body}=    Get Product Wow Extra
   ${content}=    Get Json Value and Convert to List    ${body}    /data/content
   LOG    ${content}

   ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
   ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
   Should Be True      ${product_AAAA9999}<${product_BBBB9999}

TC_CAMPS_00131 When get Product Wow Extra order by ASC, it should return Product Wow Extra with paging and order by ascending start period.
   [Tags]    TC_CAMPS_00131    ready    Regression    WLS_High
   #first_promotion
   @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
   @{create_category_list}=    Create List    Category1    Category2
   ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
   ${flash_sale_product1}=    Create FlashSaleProduct    BBBB9999    ${create_category_list}    ${flashsale_variant_list}
   @{create_product_list}=    Create List    ${flash_sale_product1}
   ${product_json}=    Stringify JSON    ${create_product_list}

   ${current_date}=    Get Current Date    increment=-2 minutes
   ${tomorrow_date}=    Get Current Date    increment=1 day
   ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
   ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
   ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
   Response Status Code Should Equal    201
   ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  #second_promotion
  @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
  @{create_category_list_second}=    Create List    Category3    Category4
  ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
  ${flash_sale_product2}=    Create FlashSaleProduct    AAAA9999    ${create_category_list_second}    ${flashsale_variant_list_second}

  @{create_product_list_second}=    Create List    ${flash_sale_product2}
  ${product_json_second}=    Stringify JSON    ${create_product_list_second}

  ${current_date_second}=    Get Current Date    increment=-1 minutes
  ${tomorrow_date_second}=    Get Current Date    increment=1 day
  ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
  ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
  ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
  Response Status Code Should Equal    201
  ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

  ${status}    ${body}=    Get Product Wow Extra    ASC
  ${content}=    Get Json Value and Convert to List    ${body}    /data/content
  LOG    ${content}

  ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
  ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
  Should Be True      ${product_AAAA9999}<${product_BBBB9999}

TC_CAMPS_00132 When get Product Wow Extra order by DESC, it should return Product Wow Extra with paging and order by descending start period.
   [Tags]    TC_CAMPS_00132    ready    Regression    WLS_Medium
   #first_promotion
   @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
   @{create_category_list}=    Create List    Category1    Category2
   ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
   ${flash_sale_product1}=    Create FlashSaleProduct    BBBB9999    ${create_category_list}    ${flashsale_variant_list}
   @{create_product_list}=    Create List    ${flash_sale_product1}
   ${product_json}=    Stringify JSON    ${create_product_list}

   ${current_date}=    Get Current Date    increment=-2 minutes
   ${tomorrow_date}=    Get Current Date    increment=1 day
   ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
   ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
   ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
   Response Status Code Should Equal    201
   ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  #second_promotion
  @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
  @{create_category_list_second}=    Create List    Category3    Category4
  ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
  ${flash_sale_product2}=    Create FlashSaleProduct    AAAA9999    ${create_category_list_second}    ${flashsale_variant_list_second}

  @{create_product_list_second}=    Create List    ${flash_sale_product2}
  ${product_json_second}=    Stringify JSON    ${create_product_list_second}

  ${current_date_second}=    Get Current Date    increment=-1 minutes
  ${tomorrow_date_second}=    Get Current Date    increment=1 day
  ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
  ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
  ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
  Response Status Code Should Equal    201
  ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

  ${status}    ${body}=    Get Product Wow Extra    DESC
  ${content}=    Get Json Value and Convert to List    ${body}    /data/content
  LOG    ${content}

  ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
  ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
  Should Be True      ${product_BBBB9999}<${product_AAAA9999}


TC_CAMPS_00133 When get Products Wow Extra specify perpage and order by ASC, it should return Paging Product Wow Extra correctly.
  [Tags]    TC_CAMPS_00133    ready    Regression    WLS_Medium
  #first_promotion
   @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
   @{create_category_list}=    Create List    Category1    Category2
   ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
   ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
   @{create_product_list}=    Create List    ${flash_sale_product1}
   ${product_json}=    Stringify JSON    ${create_product_list}

   ${current_date}=    Get Current Date    increment=-2 minutes
   ${tomorrow_date}=    Get Current Date    increment=1 day
   ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
   ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
   ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
   Response Status Code Should Equal    201
   ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  #second_promotion
  @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
  @{create_category_list_second}=    Create List    Category3    Category4
  ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
  ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

  @{create_product_list_second}=    Create List    ${flash_sale_product2}
  ${product_json_second}=    Stringify JSON    ${create_product_list_second}

  ${current_date_second}=    Get Current Date    increment=-1 minutes
  ${tomorrow_date_second}=    Get Current Date    increment=1 day
  ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
  ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
  ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
  Response Status Code Should Equal    201
  ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

  ${status}    ${body}=    Get Product Wow Extra    ASC    latest    2
  ${content}=    Get Json Value and Convert to List    ${body}    /data/content
  LOG    ${content}
  ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
  ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
  ${flash_sale_id_list}=    Create List    {}
  Log    ${content}
  :FOR    ${each}    IN    @{content}
  \    ${id}=    Get From Dictionary    ${each}    product_key
  \    Append To List    ${flash_sale_id_list}    ${id}
  Log    ${flash_sale_id_list}

  List Should Contain Value    ${flash_sale_id_list}    AAAA9999
  List Should Contain Value    ${flash_sale_id_list}    BBBB9999
  Should Be True      ${product_BBBB9999}<${product_AAAA9999}

TC_CAMPS_00134 When get Products Wow Extra specify perpage and order by DESC should, it return Paging Product Wow Extra correctly.
    [Tags]    TC_CAMPS_00134    ready    Regression    WLS_High
    #first_promotion
    @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
    @{create_category_list}=    Create List    Category1    Category2
    ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
    ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
    @{create_product_list}=    Create List    ${flash_sale_product1}
    ${product_json}=    Stringify JSON    ${create_product_list}

    ${current_date}=    Get Current Date    increment=-2 minutes
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
    ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
    Response Status Code Should Equal    201
    ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-1 minutes
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    ${status}    ${body}=    Get Product Wow Extra    DESC    latest    50
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
    ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    Append To List    ${flash_sale_id_list}    ${id}
    Log    ${flash_sale_id_list}

    List Should Contain Value    ${flash_sale_id_list}    AAAA9999
    List Should Contain Value    ${flash_sale_id_list}    BBBB9999
    Should Be True      ${product_BBBB9999}>${product_AAAA9999}

TC_CAMPS_00135 When get Products Wow Extra sort by updated and order by ASC should, it return Paging Product Wow Extra correctly.
    [Tags]    TC_CAMPS_00135    ready    Regression    WLS_High
    #first_promotion
     @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
     @{create_category_list}=    Create List    Category1    Category2
     ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
     ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
     @{create_product_list}=    Create List    ${flash_sale_product1}
     ${product_json}=    Stringify JSON    ${create_product_list}

     ${current_date}=    Get Current Date    increment=-1 minutes
     ${tomorrow_date}=    Get Current Date    increment=1 day
     ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
     ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
     ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
     Response Status Code Should Equal    201
     ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-2 minutes
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Product Wow Extra    ASC
    Response Status Code Should Equal    200
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
    ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    Append To List    ${flash_sale_id_list}    ${id}
    Log    ${flash_sale_id_list}

    List Should Contain Value    ${flash_sale_id_list}    AAAA9999
    List Should Contain Value    ${flash_sale_id_list}    BBBB9999
    Should Be True      ${product_AAAA9999}<${product_BBBB9999}

TC_CAMPS_00136 When get products Wow Extra sort by updated and order by Desc, it should return paging Product wow Extra correctly
    [Tags]    TC_CAMPS_00136    ready    Regression    WLS_Medium
    #first_promotion
     @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
     @{create_category_list}=    Create List    Category1    Category2
     ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
     ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
     @{create_product_list}=    Create List    ${flash_sale_product1}
     ${product_json}=    Stringify JSON    ${create_product_list}

     ${current_date}=    Get Current Date    increment=-1 minutes
     ${tomorrow_date}=    Get Current Date    increment=1 day
     ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
     ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
     ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
     Response Status Code Should Equal    201
     ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-2 minutes
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Product Wow Extra    DESC
    Response Status Code Should Equal    200
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
    ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    Append To List    ${flash_sale_id_list}    ${id}
    Log    ${flash_sale_id_list}

    List Should Contain Value    ${flash_sale_id_list}    AAAA9999
    List Should Contain Value    ${flash_sale_id_list}    BBBB9999
    Should Be True      ${product_BBBB9999}<${product_AAAA9999}

TC_CAMPS_00137 When get products Wow Extra sort by price and order by ASC, it should return Paging Product Wow Extra correctly.
    [Tags]    TC_CAMPS_00137    ready    Regression    WLS_Medium
    #first_promotion
     @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
     @{create_category_list}=    Create List    Category1    Category2
     ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    5    99999    50
     ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
     @{create_product_list}=    Create List    ${flash_sale_product1}
     ${product_json}=    Stringify JSON    ${create_product_list}

     ${current_date}=    Get Current Date
     ${tomorrow_date}=    Get Current Date    increment=1 day
     ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
     ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
     ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
     Response Status Code Should Equal    201
     ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}    5    88888    60
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-1 day
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Product Wow Extra    ASC    promotionPrice
    Response Status Code Should Equal    200
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
    ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    Append To List    ${flash_sale_id_list}    ${id}
    Log    ${flash_sale_id_list}

    List Should Contain Value    ${flash_sale_id_list}    AAAA9999
    List Should Contain Value    ${flash_sale_id_list}    BBBB9999
    Should Be True      ${product_BBBB9999}<${product_AAAA9999}

TC_CAMPS_00138 When get products Wow Extra sort by price and order by DESC, it should return Paging Product Wow Extra correctly
    [Tags]    TC_CAMPS_00138    ready    Regression    WLS_High
    #first_promotion
     @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
     @{create_category_list}=    Create List    Category1    Category2
     ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    5    99999    25
     ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
     @{create_product_list}=    Create List    ${flash_sale_product1}
     ${product_json}=    Stringify JSON    ${create_product_list}

     ${current_date}=    Get Current Date
     ${tomorrow_date}=    Get Current Date    increment=1 day
     ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
     ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
     ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
     Response Status Code Should Equal    201
     ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}    5    88888    34
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-1 day
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Product Wow Extra    DESC    promotionPrice
    Response Status Code Should Equal    200
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
    ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    Append To List    ${flash_sale_id_list}    ${id}
    Log    ${flash_sale_id_list}

    List Should Contain Value    ${flash_sale_id_list}    AAAA9999
    List Should Contain Value    ${flash_sale_id_list}    BBBB9999
    Should Be True      ${product_AAAA9999}<${product_BBBB9999}

TC_CAMPS_00139 When get products Wow Extra sort by discount percent and order by ASC,it should return Paging Product Wow Extra correctly
    [Tags]    TC_CAMPS_00139    ready    Regression    WLS_High
    #first_promotion
     @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
     @{create_category_list}=    Create List    Category1    Category2
     ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    5    99999    50
     ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
     @{create_product_list}=    Create List    ${flash_sale_product1}
     ${product_json}=    Stringify JSON    ${create_product_list}

     ${current_date}=    Get Current Date
     ${tomorrow_date}=    Get Current Date    increment=1 day
     ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
     ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
     ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
     Response Status Code Should Equal    201
     ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}    5    88888    90
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-1 day
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Product Wow Extra    ASC    discountPercent
    Response Status Code Should Equal    200
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
    ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    Append To List    ${flash_sale_id_list}    ${id}
    Log    ${flash_sale_id_list}

    List Should Contain Value    ${flash_sale_id_list}    AAAA9999
    List Should Contain Value    ${flash_sale_id_list}    BBBB9999
    Should Be True      ${product_AAAA9999}<${product_BBBB9999}

TC_CAMPS_00140 When get products Wow Extra sort by discount percent and order byDESC should return Paging Product Wow Extra correctly
    [Tags]    TC_CAMPS_00140    ready    Regression    WLS_Medium
    #first_promotion
     @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
     @{create_category_list}=    Create List    Category1    Category2
     ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    5    99999    50
     ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
     @{create_product_list}=    Create List    ${flash_sale_product1}
     ${product_json}=    Stringify JSON    ${create_product_list}

     ${current_date}=    Get Current Date
     ${tomorrow_date}=    Get Current Date    increment=1 day
     ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
     ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
     ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
     Response Status Code Should Equal    201
     ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}    5    88888    90
    ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-1 day
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Product Wow Extra    DESC    discountPercent
    Response Status Code Should Equal    200
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
    ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
    ${flash_sale_id_list}=    Create List    {}
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    Append To List    ${flash_sale_id_list}    ${id}
    Log    ${flash_sale_id_list}

    List Should Contain Value    ${flash_sale_id_list}    AAAA9999
    List Should Contain Value    ${flash_sale_id_list}    BBBB9999
    Should Be True      ${product_BBBB9999}<${product_AAAA9999}

TC_CAMPS_00141 When get Wow Extra products, it should return the cheapest price when live flash sales contain the same Product with different price
    [Tags]    TC_CAMPS_00141    ready    Regression    WLS_Medium
    #first_promotion
     @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
     @{create_category_list}=    Create List    Category1    Category2
     ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}    5    500    50
     ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
     @{create_product_list}=    Create List    ${flash_sale_product1}
     ${product_json}=    Stringify JSON    ${create_product_list}

     ${current_date}=    Get Current Date    increment=-1 minutes
     ${tomorrow_date}=    Get Current Date    increment=1 day
     ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
     ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
     ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
     Response Status Code Should Equal    201
     ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    #second_promotion
    @{create_variant_id_list_second}=    Create List    VBBB9991    VBBB9991
    @{create_category_list_second}=    Create List    Category3    Category4
    ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}    5    1000    90
    ${flash_sale_product2}=    Create FlashSaleProduct    AAAA9999    ${create_category_list_second}    ${flashsale_variant_list_second}

    @{create_product_list_second}=    Create List    ${flash_sale_product2}
    ${product_json_second}=    Stringify JSON    ${create_product_list_second}

    ${current_date_second}=    Get Current Date    increment=-2 minutes
    ${tomorrow_date_second}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
    ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
    ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
    Response Status Code Should Equal    201
    ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
    ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    ${status}    ${body}=    Get Product Wow Extra    DESC    discountPercent
    Response Status Code Should Equal    200
    ${content}=    Get Json Value and Convert to List    ${body}    /data/content
    LOG    ${content}
    ${result_dictionary}=    Create Dictionary
    Log    ${content}
    :FOR    ${each}    IN    @{content}
    \    ${flashSale_variants}=    Get From Dictionary    ${each}    flashsale_variants
    \    ${variant_in_fs}=    Get From List    ${flashSale_variants}    0
    \    ${id}=    Get From Dictionary    ${each}    product_key
    \    ${promotion_price}=    Get From Dictionary    ${variant_in_fs}    promotion_price
    \    Set To Dictionary    ${result_dictionary}    ${id}    ${promotion_price}

    ${actual_promotion_price}=    Get From Dictionary    ${result_dictionary}    AAAA9999
    Should Be Equal As Numbers    ${actual_promotion_price}    500.0

TC_CAMPS_01005 When get Wow Extra Product with specific per page,it should return number of products in paging Product Wow Extra correctly.
  [Tags]    TC_CAMPS_01005    ready    Regression    WLS_Medium
  #first_promotion
   @{create_variant_id_list}=    Create List    VBBB9991    VBBB9991
   @{create_category_list}=    Create List    Category1    Category2
   ${flashsale_variant_list}=    Create FlashSaleVariant    ${create_variant_id_list}
   ${flash_sale_product1}=    Create FlashSaleProduct    AAAA9999    ${create_category_list}    ${flashsale_variant_list}
   @{create_product_list}=    Create List    ${flash_sale_product1}
   ${product_json}=    Stringify JSON    ${create_product_list}

   ${current_date}=    Get Current Date    increment=-1 minutes
   ${tomorrow_date}=    Get Current Date    increment=1 day
   ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 1    Product Wow Extra 1
   ...    shortDest    shortDescTrans    1    paymentCod    ${current_date}
   ...    ${tomorrow_date}    enable    both    wow_extra    ${product_json}
   Response Status Code Should Equal    201
   ${first_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  #second_promotion
  @{create_variant_id_list_second}=    Create List    VAAA9991    VAAA9992
  @{create_category_list_second}=    Create List    Category3    Category4
  ${flashsale_variant_list_second}=    Create FlashSaleVariant    ${create_variant_id_list_second}
  ${flash_sale_product2}=    Create FlashSaleProduct    BBBB9999    ${create_category_list_second}    ${flashsale_variant_list_second}

  @{create_product_list_second}=    Create List    ${flash_sale_product2}
  ${product_json_second}=    Stringify JSON    ${create_product_list_second}

  ${current_date_second}=    Get Current Date    increment=-2 minutes
  ${tomorrow_date_second}=    Get Current Date    increment=1 day
  ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
  ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_second}
  ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_second}
  Response Status Code Should Equal    201
  ${second_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  #third_promotion
  @{create_variant_id_list_third}=    Create List    VCCC9991    VCCC9992
  @{create_category_list_third}=    Create List    Category3    Category4
  ${flashsale_variant_list_third}=    Create FlashSaleVariant    ${create_variant_id_list_third}
  ${flash_sale_product_third}=    Create FlashSaleProduct    CCCC9999    ${create_category_list_third}    ${flashsale_variant_list_third}

  @{create_product_list_third}=    Create List    ${flash_sale_product_third}
  ${product_json_third}=    Stringify JSON    ${create_product_list_third}
  ${current_date_third}=    Get Current Date    increment=-3 minutes
  ${tomorrow_date_third}=    Get Current Date    increment=1 day
  ${status}    ${body}=    Create Flash Sale Wow Extra via API   Product Wow Extra 2    Product Wow Extra 2
  ...    shortDest    shortDescTrans    1    paymentCod    ${current_date_third}
  ...    ${tomorrow_date_second}    enable    both    wow_extra    ${product_json_third}
  Response Status Code Should Equal    201
  ${third_flash_sale_id}=    Get Json Value and Convert to List    ${body}    /data/id
  ${g_flash_sale_id}    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}

  ${status}    ${body}=    Get Product Wow Extra    ASC    latest    2
  ${content}=    Get Json Value and Convert to List    ${body}    /data/content
  LOG    ${content}
  ${product_BBBB9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    BBBB9999
  ${product_AAAA9999}=    Get Index Product Wow Extra From List By Product Key    ${content}    AAAA9999
  ${flash_sale_id_list}=    Create List    {}
  Log    ${content}
  :FOR    ${each}    IN    @{content}
  \    ${id}=    Get From Dictionary    ${each}    product_key
  \    Append To List    ${flash_sale_id_list}    ${id}
  Log    ${flash_sale_id_list}

  List Should Contain Value    ${flash_sale_id_list}    AAAA9999
  List Should Contain Value    ${flash_sale_id_list}    BBBB9999
  Should Be True      ${product_AAAA9999}<${product_BBBB9999}
  ${number_of_elements}=    Get Json Value and Convert to List    ${body}    /data/number_of_elements
  Should Be Equal As Integers    ${number_of_elements}    2
