*** Setting ***
Resource          ../../../Resource/Config/stark/camps_libs_resources.robot

*** Keywords ***
Create Deal via API
    [Arguments]    ${dealName}    ${enabledStatus}    ${criteria_values}    ${discount_percent}    ${setPomotionPrice}    ${promotionPrice}
    ...    ${start}=${startDeal}    ${end}=${endDeal}
    ${request_body}=    Read Template File    ${RESOURCE-PATH}\json\createDeal.json    dealName=${dealName}    enabledStatus=${enabledStatus}    criteria_values=${criteria_values}    discount_percent=${discount_percent}
    ...    setPomotionPrice=${setPomotionPrice}    promotionPrice=${promotionPrice}    start=${startDeal}    end=${endDeal}
    Create Http Context    ${CAMPS-HOST}:${CAMPS-PORT}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${request_body}
    Next Request May Not Succeed
    Post    /api/v1/deals
    ${response}=    Get Response Body
    Log    ${response}
    Return From Keyword    ${response}

Create Flash Sale Wow Banner via API
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${payment_channel}=cod
    ...    ${start_date}=${EMPTY}    ${end_date}=${EMPTY}    ${status}=disable    ${apply_with}=both    ${type}=wow_banner    ${flash_sale_product}=${EMPTY}    ${pathJson}=${RESOURCE-PATH}/json/wowBannerCreate.json
    ${member}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='member'    true    false
    ${nonmember}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='nonmember'    true    false
    ${enable}=    Set Variable If    '${status}'=='enable'    true    false
    ${start_date}    ${end_date}=    Convert Date Time to Epoch    ${start_date}    ${end_date}
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    ${request_body}=    Read Template File    ${pathJson}    name="${name}"    name_trans="${name_trans}"    short_desc="${short_desc}"    short_desc_trans="${short_desc_trans}"
    ...    limit=${limit}    member=${member}    nonmember=${nonmember}    enable=${enable}    start_date=${start_date}    end_date=${end_date}    flash_sale_product=${flash_sale_product}
    ...    type="${type}"
    Login to CAMPS via API
    Log Json    ${request_body}
    Set Request Body    ${request_body}
    Next Request May Not Succeed
    Post    /cmp/v1/flashsales
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Create Flash Sale Wow Extra via API
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${payment_channel}=cod
    ...    ${start_date}=${EMPTY}    ${end_date}=${EMPTY}    ${status}=disable    ${apply_with}=both    ${type}=wow_extra    ${flash_sale_product}=${EMPTY}
    ...    ${pathJson}=${RESOURCE-PATH}/json/wowExtraCreate.json
    ${member}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='member'    true    false
    ${nonmember}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='nonmember'    true    false
    ${enable}=    Set Variable If    '${status}'=='enable'    true    false
    ${start_date}    ${end_date}=    Convert Date Time to Epoch    ${start_date}    ${end_date}
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    ${request_body}=    Read Template File    ${pathJson}    name="${name}"    name_trans="${name_trans}"    short_desc="${short_desc}"    short_desc_trans="${short_desc_trans}"
    ...    limit=${limit}    member=${member}    nonmember=${nonmember}    enable=${enable}    start_date=${start_date}    end_date=${end_date}
    ...    type="${type}"    flash_sale_product=${flash_sale_product}
    Login to CAMPS via API
    Log    ${request_body}
    Set Request Body    ${request_body}
    Next Request May Not Succeed
    Post    /cmp/v1/flashsales
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Create Promotion Freebie via API
    [Arguments]    ${name}    ${camp_id}    ${criteria_values}    ${free_variant}    ${pathJson}=${RESOURCE-PATH}/json/
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    # ${current_date}=    Get Current Date
    # ${current_date}=    Convert Date    ${current_date}    epoch    exclude_millis=yes
    # ${current_date}=    Convert To Integer    ${current_date}
    Log Many    ${name}    ${camp_id}    ${criteria_values}    ${free_variant}
    ${request_body}=    Read Template File    ${pathJson}createFreebie.json    name=${name}    camp_id=${camp_id}    criteria_values=${criteria_values}    free_variant=${free_variant}
    Create Http Context    ${CAMPS-API}    http
    Set Request Header    x-wm-accessToken    ${access_token}
    Set Request Header    x-wm-refreshToken    ${refresh_token}
    Set Request Header    Content-Type    application/json
    Set Request Body    ${request_body}
    Next Request May Not Succeed
    Post    /cmp/v1/itm/promotions
    ${response}=    Get Response Body
    Log    ${response}
    # ${campaign_suggested}=    Get Json Value and Convert to List    ${response}    /body/campaign_suggested
    # Return From Keyword If    ${campaign_suggested} == ${null}    None
    # ${promo_ids}=    Create List
    # : FOR    ${matched_promotion}    IN    @{campaign_suggested}
    # \    ${promo_id}=    Get From Dictionary    ${matched_promotion}    id
    # \    Append To List    ${promo_ids}    ${promo_id}
    # Return From Keyword    ${promo_ids}

Create FlashSaleVariant
    [Arguments]    ${variant_ids}    ${limit_quantity}=5    ${promotion_price}=99    ${discount_percent}=45
    @{variant_list}=    Create List
    : FOR    ${variant}    IN    @{variant_ids}
    \    &{variant_dict}=    Create Dictionary    variant_id=${variant}    limit_quantity=${limit_quantity}    promotion_price=${promotion_price}
    \    ...    discount_percent=${discount_percent}
    \    Append To List    ${variant_list}    ${variant_dict}
    Return From Keyword    ${variant_list}

Create FlashSaleProduct
    [Arguments]    ${product_id}    ${category_id}     ${variant_list}
    &{flash_sale_product}=    Create Dictionary    product_key=${product_id}    category_ids=${category_id}    flashsale_variants=${variant_list}
    Return From Keyword    ${flash_sale_product}


Delete Code Group By ID via API
    [Arguments]    ${code_group_id}
    @{code_group_id}=    Split String    ${code_group_id}    ,
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    : FOR    ${id}    IN    @{code_group_id}
    \    Create Http Context    ${CAMPS-API}    http
    \    Set Request Header    x-wm-accessToken    ${access_token}
    \    Set Request Header    x-wm-refreshToken    ${refresh_token}
    \    Next Request May Not Succeed
    \    Delete    /cmp/v1/codegroups/${id}
    \    ${response}=    Get Response Body

Delete Deal by ID via API
    [Arguments]    ${dealId}
    Create Http Context    ${CAMPS-HOST}:${CAMPS-PORT}    http
    Next Request May Not Succeed
    Delete    /api/v1/deals/${dealId}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Delete Flashsale Via API By ID
    [Arguments]    ${flash_sale_id}
    Log    ${flash_sale_id}
    Login to CAMPS via API
    Next Request May Not Succeed
    Delete    /cmp/v1/flashsales/${flash_sale_id}

Delete Flashsale Via API By List
    [Arguments]    ${flash_sale_ids}
    ${flash_sale_ids}=    Convert To String    ${flash_sale_ids}
    @{flash_sale_ids}=    Split String    ${flash_sale_ids}    ,
    : FOR    ${item}    IN    @{flash_sale_ids}
    \    Log    ${item}
    \    Run Keyword If    '${item}'!='${EMPTY}'    Delete Flashsale Via API By ID    ${item}
    Set Variable    @{flash_sale_ids}    ${EMPTY}

Get Access and Refresh Token via API
    [Arguments]    ${username}=${USER-CAMPS}    ${password}=${PASSWORD-CAMPS}
    Create Http Context    ${MERCHANT-API}    http
    Set Request Header    Content-Type    application/x-www-form-urlencoded
    Set Basic Auth    ${username}    ${password}
    Next Request May Not Succeed
    Post    /authen/v1/tokens?grant_type=merchant
    ${response}=    Get Response Body
    ${access_token}=    Get Json Value and Convert to List    ${response}    /access_token
    ${refresh_token}=    Get Json Value and Convert to List    ${response}    /refresh_token
    Return From Keyword    ${access_token}    ${refresh_token}

Get All Flash Sale Wow Banner
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    Login to CAMPS via API
    Next Request May Not Succeed
    Get    /cmp/v1/flashsales?sort=updatedAt
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Get AppID via API
    Login to CAMPS via API
    Next Request May Not Succeed
    Get    /cmp/v1/flashsales/appId
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get Flash Sale Wow Banner by Flash Sale Id via API
    [Arguments]    ${promotiond_id}
    Login to CAMPS via API
    Next Request May Not Succeed
    Get    /cmp/v1/flashsales/${promotiond_id}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Get Json Value and Convert to List
    [Arguments]    ${json_string}    ${json_pointer}
    ${json_value}=    Get Json Value    ${json_string}    ${json_pointer}
    ${json_value}=    Parse Json    ${json_value}
    Return From Keyword    ${json_value}

Get Matched Bundle Promotion by Variant via API
    [Arguments]    ${variant_id}
    Create Http Context    ${CAMPS-API}    http
    Set Request Header    Content-Type    application/json
    Next Request May Not Succeed
    Get    /cmp/v1/itm/promotions/bundles/?productVariant=${variant_id}
    ${response}=    Get Response Body
    ${matched_promotion}=    Parse Json    ${response}
    Log List    ${matched_promotion}
    ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${matched_promotion}
    Return From Keyword If    ${is_empty}    None
    ${promo_ids}=    Create List
    : FOR    ${item}    IN    @{matched_promotion}
    \    ${promo_id}=    Get From Dictionary    ${item}    promotion_id
    \    Append To List    ${promo_ids}    ${promo_id}
    Return From Keyword    ${promo_ids}

Get Matched Freebie Promotion by Variant via API
    [Arguments]    ${variant_id}
    Create Http Context    ${CAMPS-API}    http
    Set Request Header    Content-Type    application/json
    Next Request May Not Succeed
    Get    /cmp/v1/itm/promotions/freebie/?productVariant=${variant_id}
    ${response}=    Get Response Body
    ${matched_promotion}=    Get Json Value and Convert to List    ${response}    /0/promotions
    Log List    ${matched_promotion}
    ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${matched_promotion}
    Return From Keyword If    ${is_empty}    None
    ${promo_ids}=    Create List
    : FOR    ${item}    IN    @{matched_promotion}
    \    ${promo_id}=    Get From Dictionary    ${item}    promotion_id
    \    Append To List    ${promo_ids}    ${promo_id}
    Return From Keyword    ${promo_ids}

Get Matched MNP Promotion by Variant via API
    [Arguments]    ${variant_id}
    Create Http Context    ${CAMPS-API}    http
    Set Request Header    Content-Type    application/json
    Next Request May Not Succeed
    Get    /cmp/v1/itm/promotions/mnp/?productVariant=${variant_id}
    ${response}=    Get Response Body
    ${matched_promotion}=    Parse Json    ${response}
    Log List    ${matched_promotion}
    ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${matched_promotion}
    Return From Keyword If    ${is_empty}    None
    ${promo_ids}=    Create List
    : FOR    ${item}    IN    @{matched_promotion}
    \    ${promo_id}=    Get From Dictionary    ${item}    promotion_id
    \    Append To List    ${promo_ids}    ${promo_id}
    Return From Keyword    ${promo_ids}

Get Matched Promotion from Simulating Cart via API
    [Arguments]    ${variant_id}    ${code}=""    ${pathJson}=${RESOURCE-PATH}/json/
    ${current_date}=    Get Current Date
    ${current_date}=    Convert Date    ${current_date}    epoch    exclude_millis=yes
    ${current_date}=    Convert To Integer    ${current_date}
    ${request_body}=    Read Template File    ${pathJson}simulateCart.json    current_date=${current_date}    variant_id=${variant_id}    code=${code}
    Create Http Context    ${CAMPS-API}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    ${request_body}
    Next Request May Not Succeed
    Post    /cmp/v1/itm/promotions/cart
    ${response}=    Get Response Body
    ${campaign_suggested}=    Get Json Value and Convert to List    ${response}    /body/campaign_suggested
    Return From Keyword If    ${campaign_suggested} == ${null}    None
    ${promo_ids}=    Create List
    : FOR    ${matched_promotion}    IN    @{campaign_suggested}
    \    ${promo_id}=    Get From Dictionary    ${matched_promotion}    id
    \    Append To List    ${promo_ids}    ${promo_id}
    Return From Keyword    ${promo_ids}

Get Wow Extra By Id via API
    [Arguments]    ${wow_extra_id}
    Login to CAMPS via API
    Next Request May Not Succeed
    Get    /cmp/v1/flashsales/${wow_extra_id}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Get Wow Extra Variant
    [Arguments]    ${sort_by}=${EMPTY}    ${order}=${EMPTY}
    Login to CAMPS via API
    Next Request May Not Succeed
    Log to console    /cmp/v1/flashsales/wowExtra?sort=${sort_by}&order=${order}
    Get    /cmp/v1/flashsales/wowExtra?sort=${sort_by}&order=${order}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

# Init Flashsale Env
#     Set Global Variable    @{promotion_ids}    Create List    ${EMPTY}

Login to CAMPS via API
    [Arguments]    ${request_body}=${EMPTY}
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    Create Http Context    ${CAMPS-API}    http
    Set Request Header    Content-Type    application/json
    Set Request Header    x-wm-accessToken    ${access_token}
    Set Request Header    x-wm-refreshToken    ${refresh_token}
    Set Request Body    ${request_body}

Status Code and Message Should Be Equal
    [Arguments]    ${response}    ${expected_status}    ${expected_message}
    Response Status Code Should Equal    ${expected_status}
    ${actual_message}=    Get Json Value and Convert to List    ${response}    /message
    Should be equal    ${actual_message}    ${expected_message}

Update Flash Sale Wow Banner via API
    [Arguments]    ${promotion_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1
    ...    ${payment_channel}=cod    ${start_date}=${EMPTY}    ${end_date}=${EMPTY}    ${status}=disable    ${apply_with}=both    ${type}=wow_banner     ${product_json}=${EMPTY}
    ...    ${pathJson}=${RESOURCE-PATH}/json/wowBannerCreate.json
    ${member}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='member'    true    false
    ${nonmember}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='nonmember'    true    false
    ${enable}=    Set Variable If    '${status}'=='enable'    true    false
    ${start_date}    ${end_date}=    Convert Date Time to Epoch    ${start_date}    ${end_date}
    ${request_body}=    Read Template File    ${pathJson}    name="${name}"    name_trans="${name_trans}"    short_desc="${short_desc}"    short_desc_trans="${short_desc_trans}"
    ...    limit=${limit}    member=${member}    nonmember=${nonmember}    enable=${enable}    start_date=${start_date}    end_date=${end_date}    flash_sale_product=${product_json}
    ...    type="${type}"
    Login to CAMPS via API
    Log    ${request_body}
    Set Request Body    ${request_body}
    Next Request May Not Succeed
    Put    /cmp/v1/flashsales/${promotion_id}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Update Flash Sale Wow Extra via API
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${payment_channel}=cod
    ...    ${start_date}=${EMPTY}    ${end_date}=${EMPTY}    ${status}=disable    ${apply_with}=both    ${type}=wow_extra    ${product_json}=${EMPTY}
    ...    ${promotion_id}=${EMPTY}    ${pathJson}=${RESOURCE-PATH}/json/wowExtraCreate.json
    ${member}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='member'    true    false
    ${nonmember}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='nonmember'    true    false
    ${enable}=    Set Variable If    '${status}'=='enable'    true    false
    ${start_date}    ${end_date}=    Convert Date Time to Epoch    ${start_date}    ${end_date}
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    ${request_body}=    Read Template File    ${pathJson}    name="${name}"    name_trans="${name_trans}"    short_desc="${short_desc}"    short_desc_trans="${short_desc_trans}"
    ...    limit=${limit}    member=${member}    nonmember=${nonmember}    enable=${enable}    start_date=${start_date}    end_date=${end_date}
    ...    type="${type}"    flash_sale_product=${product_json}
    Login to CAMPS via API
    Set Request Body    ${request_body}
    Next Request May Not Succeed
    Put    /cmp/v1/flashsales/${promotion_id}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Update status flashsale via API
    [Arguments]    ${promotiond_id}    ${promotion_status}
    Login to CAMPS via API
    Next Request May Not Succeed
    Put    /cmp/v1/flashsales/${promotiond_id}/${promotion_status}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Update status flashsale via API by Batch
    [Arguments]    ${promotiond_ids}    ${promotion_status}
    Login to CAMPS via API
    Next Request May Not Succeed
    Put    /cmp/v1/flashsales/${promotion_status}?ids=${promotiond_ids}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Verify AppID Data
    [Arguments]    ${response}
    &{app_id_itm}=    Create Dictionary    id=${1}    name=iTruemart
    &{app_id_ep}=    Create Dictionary    id=${6}    name=Exclusive Privilege
    &{app_id_wm}=    Create Dictionary    id=${9}    name=TruemoveH
    @{expected_app_id_list}=    Create List    ${app_id_itm}    ${app_id_ep}    ${app_id_wm}
    ${actual_app_id}=    Get Json Value and Convert to List    ${response}    /data
    Sort List    ${expected_app_id_list}
    Sort List    ${actual_app_id}
    Should Be Equal    ${expected_app_id_list}    ${actual_app_id}

Convert Date Time to Epoch
    [Arguments]    ${start_date}     ${end_date}
    ${start_date}=    Convert Date    ${start_date}    epoch    exclude_millis=yes
    ${start_date}=    Convert To Integer    ${start_date}
    ${start_date}=    Evaluate    ${start_date}*1000
    ${end_date}=    Convert Date    ${end_date}    epoch    exclude_millis=yes
    ${end_date}=    Convert To Integer    ${end_date}
    ${end_date}=    Evaluate    ${end_date}*1000
    Return From Keyword    ${start_date}    ${end_date}

Get Product Wow Extra
    [Arguments]    ${order_by}=ASC    ${sort_by}=latest    ${per_page}=30    ${filter}=NO    ${category}=${EMPTY}
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    Login to CAMPS via API
    Next Request May Not Succeed
    Run Keyword If    '${filter}'=='category'    Get    /cmp/v1/flashsales/wowExtra?sort=${sort_by}&order=${order_by}&per_page=${per_page}&category=${category}
    ...    ELSE IF    '${filter}'=='NO'    Get    /cmp/v1/flashsales/wowExtra?sort=${sort_by}&order=${order_by}&per_page=${per_page}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Log    ${body}
    Return From Keyword    ${status}    ${body}

Get Product Wow Banner
    [Arguments]    ${current_time}
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
    Login to CAMPS via API
    Next Request May Not Succeed
    Get    /cmp/v1/flashsales/wowBanner?current_time=${current_time}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Log    ${body}
    Return From Keyword    ${status}    ${body}

Get Epoch Time Wow Extra
    [Arguments]    ${date_time}
    ${date_time_to_epoch}=    Convert Date    ${date_time}    epoch    exclude_millis=yes
    ${date_time_to_epoch}=    Convert To Integer    ${date_time_to_epoch}
    ${date_time_to_epoch}=    Evaluate    ${date_time_to_epoch}*1000
    return From Keyword    ${date_time_to_epoch}

Get Index Product Wow Extra From List By Product Key
     [Arguments]    ${product_wow_extra_list}    ${product}
     ${flashsale_product_list}=    Create List    {}
     Log    ${product_wow_extra_list}
     :FOR    ${each}    IN    @{product_wow_extra_list}
     \    ${product_key}=    Get From Dictionary    ${each}    product_key
     \    Append To List    ${flashsale_product_list}    ${product_key}

     ${product_index}=    Get Index From List    ${flashsale_product_list}     ${product}
     Return From Keyword    ${product_index}

Get Wow Banner node by json field name
      [Arguments]    ${body}    ${field_name}
      ${content}=    Get Json Value    ${body}    /data
      Log    ${content}
      ${json}=    Get Json Value    ${content}    ${field_name}
      Return From Keyword    ${json}

Assert Product Wow Banner
      [Arguments]    ${body}    ${field_name}    ${product_key}    ${wow_banner_name}
      ${wow_dictionary}=    Get Wow Banner node by json field name    ${body}    ${field_name}
      ${product_key_json}=    Get Json Value    ${wow_dictionary}    /product/product_key
      ${name_json}=    Get Json Value    ${wow_dictionary}    /name
      Should Be Equal    ${product_key_json}    ${product_key}
      Should Be Equal    ${name_json}    ${wow_banner_name}

Get Flashsale Policy images By Number via API
    [Arguments]    ${number_policy}
    Login to CAMPS via API
    Next Request May Not Succeed
    Get    /cmp/v1/flashsales/policies/images/${number_policy}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Get Flashsale Product By Product Key via API
    [Arguments]    ${product_key}
    Login to CAMPS via API
    Next Request May Not Succeed
    Get    /cmp/v1/flashsales/products/${product_key}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}

Assert Get Product FlashSale
    [Arguments]    ${body}    ${product_key}    ${min_promotion_price}    ${min_discount_percent}
    ${product_key_from_body}=    Get Json Value    ${body}    /data/product_key
    ${min_promotion_price_from_body}=    Get Json Value    ${body}    /data/min_promotion_price
    ${min_discount_percent_from_body}=    Get Json Value    ${body}    /data/min_discount_percent
    Should Be Equal As Strings   ${product_key_from_body}    "${product_key}"
    Should Be Equal As Numbers   ${min_promotion_price_from_body}    ${min_promotion_price}
    Should Be Equal As Numbers   ${min_discount_percent_from_body}    ${min_discount_percent}
