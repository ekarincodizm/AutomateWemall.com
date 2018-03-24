*** Setting ***
Library           HttpLibrary.HTTP
Library           Collections
Library           ../../../Python_Library/FileKeyword.py

*** Keywords ***

Delete Code Group By ID via API
    [Arguments]    ${code_group_id}
	@{code_group_id}=    Split String    ${code_group_id}    ,
	${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
	: FOR    ${id}    IN    @{code_group_id}
	\    Create Http Context    ${CAMPS-API}   http
	\    Set Request Header    x-wm-accessToken    ${access_token}
	\    Set Request Header    x-wm-refreshToken    ${refresh_token}
	\    Next Request May Not Succeed
	\    Delete    /cmp/v1/codegroups/${id}
	\    ${response}=    Get Response Body

Get Json Value and Convert to List
    [Arguments]    ${json_string}    ${json_pointer}
	${json_value}=    Get Json Value    ${json_string}    ${json_pointer}
	${json_value}=	Parse Json	${json_value}
	Log List    ${json_value}
	Return From Keyword    ${json_value}

Get Access and Refresh Token via API
    [Arguments]    ${username}=${USER-CAMPS}    ${password}=${PASSWORD-CAMPS}
    Create Http Context    ${MERCHANT-API}   http
	Set Request Header    Content-Type    application/x-www-form-urlencoded
	Set Basic Auth    ${username}    ${password}
	Next Request May Not Succeed
	Post    /authen/v1/tokens?grant_type=merchant
	${response}=     Get Response Body
    ${access_token}=    Get Json Value and Convert to List    ${response}    /access_token
	${refresh_token}=    Get Json Value and Convert to List    ${response}    /refresh_token
	Return From Keyword    ${access_token}    ${refresh_token}

Get Matched Promotion from Simulating Cart via API
    [Arguments]    ${variant_id}    ${code}=""    ${pathJson}=${RESOURCE-PATH}/json
	${current_date}=    Get Current Date
	${current_date}=    Convert Date    ${current_date}    epoch    exclude_millis=yes
	${current_date}=    Convert To Integer    ${current_date}
    ${request_body}=    Read Template File    ${pathJson}/simulateCart.json    current_date=${current_date}    variant_id=${variant_id}    code=${code}
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

Get Matched Freebie Promotion by Variant via API
    [Arguments]    ${variant_id}
	Create Http Context    ${CAMPS-API}    http
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

Get Matched Bundle Promotion by Variant via API
    [Arguments]    ${variant_id}
	Create Http Context    ${CAMPS-API}    http
	Next Request May Not Succeed
    Get    /cmp/v1/itm/promotions/bundles/?productVariant=${variant_id}
    ${response}=    Get Response Body
	${matched_promotion}=	Parse Json	${response}
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
	Next Request May Not Succeed
    Get    /cmp/v1/itm/promotions/mnp/?productVariant=${variant_id}
    ${response}=    Get Response Body
	${matched_promotion}=	Parse Json	${response}
	Log List    ${matched_promotion}
    ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${matched_promotion}
    Return From Keyword If    ${is_empty}    None
	${promo_ids}=    Create List
	: FOR    ${item}    IN    @{matched_promotion}
	\    ${promo_id}=    Get From Dictionary    ${item}    promotion_id
    \    Append To List    ${promo_ids}    ${promo_id}
    Return From Keyword    ${promo_ids}

Create Promotion Freebie via API
    [Arguments]    ${name}    ${camp_id}     ${criteria_values}     ${free_variant}    ${pathJson}=${RESOURCE-PATH}/json
	${access_token}    ${refresh_token}=    Get Access and Refresh Token via API
	# ${current_date}=    Get Current Date
	# ${current_date}=    Convert Date    ${current_date}    epoch    exclude_millis=yes
	# ${current_date}=    Convert To Integer    ${current_date}
	Log Many    ${name}    ${camp_id}     ${criteria_values}     ${free_variant}
    ${request_body}=    Read Template File    ${pathJson}/createFreebie.json    name=${name}     camp_id=${camp_id}    criteria_values=${criteria_values}    free_variant=${free_variant}
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

Create Flash Sale Wow Banner via API
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}
    ...    ${limit}=1    ${payment_channel}=cod    ${start_date}=${EMPTY}    ${end_date}=${EMPTY}
    ...    ${status}=disable    ${apply_with}=both    ${type}=wow_banner    ${pathJson}=${RESOURCE-PATH}/json

    ${member}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='member'    true    false
    ${nonmember}=    Set Variable If    '${apply_with}'=='both' or '${apply_with}'=='nonmember'    true    false
    ${enable}=    Set Variable If    '${status}'=='enable'    true    false
    ${start_date}=    Convert Date    ${start_date}    epoch    exclude_millis=yes
    ${start_date}=    Convert To Integer    ${start_date}
    ${end_date}=    Convert Date    ${end_date}    epoch    exclude_millis=yes
    ${end_date}=    Convert To Integer    ${end_date}
    ${access_token}    ${refresh_token}=    Get Access and Refresh Token via API

    ${request_body}=    Read Template File    ${pathJson}/wowBannerCreate.json    name="${name}"    name_trans="${name_trans}"
    ...    short_desc="${short_desc}"    short_desc_trans="${short_desc_trans}"    limit="${limit}"    member=${member}
    ...    nonmember=${nonmember}    enable=${enable}    start_date=${start_date}    end_date=${end_date}    type="${type}"

  	Create Http Context    ${CAMPS-API}    http
    Set Request Header    Content-Type    application/json
    Set Request Header    x-wm-accessToken    ${access_token}
    Set Request Header    x-wm-refreshToken    ${refresh_token}
    Set Request Body    ${request_body}
  	Next Request May Not Succeed
    Post    /cmp/v1/flashsales
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Return From Keyword    ${status}    ${body}
