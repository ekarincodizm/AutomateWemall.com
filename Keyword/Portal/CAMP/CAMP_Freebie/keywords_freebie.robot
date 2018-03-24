*** Keywords ***
Create Campaign Freebie On Camp
	[Arguments]   ${start_period}=None    ${end_period}=None    ${enable}=None    ${campaign_name}=None    ${path_json}=None
    ${token-data}=   AAD Login And Get Token
	${refresh-token}=  Get From Dictionary   ${token-data}   refresh_token
	${access-token}=  Get From Dictionary   ${token-data}   access_token

	${start}=    Convert Date To Time Stamp    -1
	${end}=    Convert Date To Time Stamp    30

    ${time}=       Get Time
    ${start_period}=   Run Keyword If   '${start_period}' == 'None'   Convert To String   ${start}   ELSE   Convert To String   ${start_period}
    ${end_period}=   Run Keyword If   '${end_period}' == 'None'   Convert To String   ${end}   ELSE   Convert To String   ${end_period}
    ${enable}=   Run Keyword If   '${enable}' == 'None'   Convert To String   true   ELSE   Convert To String   ${enable}
	${campaign_name}=     Run Keyword If    '${campaign_name}' == 'None'    Convert To String      (Robot) Campaign Name Test ${time}   ELSE   Convert To String   ${campaign_name}

	${content}=    Get File          ${path_json}   utf-8
	${content}=    Replace String    ${content}    ^^campaign_name^^   ${campaign_name}
	${content}=    Replace String    ${content}    ^^start_period^^    ${start_period}
	${content}=    Replace String    ${content}    ^^end_period^^    ${end_period}
	${content}=    Replace String    ${content}    ^^enable^^    ${enable}

	Create Http Context     ${CAMP-V1-LEVEL-DOMAIN}      ${CAMP-PROTOCOL}
	Set Request Header   Content-Type   application/json
	Set Request Header   x-wm-accessToken   ${access-token}
	Set Request Header   x-wm-refreshToken  ${refresh-token}
	Set Request Body   ${content}
	Next Request Should Succeed
	HttpLibrary.HTTP.POST   ${CAMP-V1-CREATE-CAMPAIGNS-URI}
	${body}=   Get Response Body
#	Log To Console   response-create-campaign=${body}
	Return From Keyword  ${body}

Create Promotion Freebie On Camp
	[Arguments]    ${criteria_values1}=None    ${quantity_main}=None    ${variant_id1}=None    ${quantity_free1}=None    ${criteria_values2}=None    ${criteria_values3}=None    ${variant_id2}=None    ${quantity_free2}=None    ${variant_id3}=None    ${quantity_free3}=None    ${note}=None      ${path_json}=None    ${campaign_id}=None    ${start_period}=None   ${end_period}=None   ${enable}=true    ${repeat}=None
    ${token-data}=   AAD Login And Get Token
	${refresh-token}=  Get From Dictionary   ${token-data}   refresh_token
	${access-token}=  Get From Dictionary   ${token-data}   access_token

	Run Keyword If    '${criteria_values1}' == 'None'   Return From Keyword    ${EMPTY}
	Run Keyword If    '${variant_id1}' == 'None'    Return From Keyword    ${EMPTY}
	Run Keyword If    '${quantity_free1}' == 'None'    Return From Keyword    ${EMPTY}
	Run Keyword If    '${quantity_main}' == 'None'    Return From Keyword   ${EMPTY}

	${start}=    Convert Date To Time Stamp    -1
	${end}=    Convert Date To Time Stamp    30

	${campaign_id}=   Run Keyword If   '${campaign_id}' == 'None'   Convert To String   ${FREEBIE-CAMPAIGN-ID}   ELSE   Convert To String   ${campaign_id}
	${start_period}=   Run Keyword If   '${start_period}' == 'None'   Convert To String   ${start}   ELSE   Convert To String   ${start_period}
	${end_period}=   Run Keyword If   '${end_period}' == 'None'   Convert To String   ${end}   ELSE   Convert To String   ${end_period}
	${repeat}=   Run Keyword If   '${repeat}' == 'None'   Convert To String   5   ELSE   Convert To String   ${repeat}

	${content}=    Get File          ${path_json}   utf-8
	${content}=    Replace String    ${content}    ^^criteria_values1^^    ${criteria_values1}
	${content}=    Replace String    ${content}    ^^criteria_values2^^    ${criteria_values2}
	${content}=    Replace String    ${content}    ^^criteria_values3^^    ${criteria_values3}
	${content}=    Replace String    ${content}    ^^quantity_main^^    ${quantity_main}
	${content}=    Replace String    ${content}    ^^variant_id1^^    ${variant_id1}
	${content}=    Replace String    ${content}    ^^variant_id2^^    ${variant_id2}
	${content}=    Replace String    ${content}    ^^variant_id3^^    ${variant_id3}
	${content}=    Replace String    ${content}    ^^quantity_free1^^    ${quantity_free1}
	${content}=    Replace String    ${content}    ^^quantity_free2^^    ${quantity_free2}
	${content}=    Replace String    ${content}    ^^quantity_free3^^    ${quantity_free3}
	${content}=    Replace String    ${content}    ^^note^^    ${note}
	${content}=    Replace String    ${content}    ^^campaign_id^^     ${campaign_id}
	${content}=    Replace String    ${content}    ^^start_period^^    ${start_period}
	${content}=    Replace String    ${content}    ^^end_period^^      ${end_period}
	${content}=    Replace String    ${content}    ^^enable^^          ${enable}
	${content}=    Replace String    ${content}    ^^repeat^^          ${repeat}
#    Log To Console      ${content}
	Create Http Context     ${CAMP-V1-LEVEL-DOMAIN}      ${CAMP-PROTOCOL}
	Set Request Header     Content-type     application/json
	Set Request Header     x-wm-accesstoken     ${access-token}
	Set Request Header     x-wm-refreshtoken    ${refresh-token}
	Set Request Body      ${content}
	Next Request Should Succeed
	HttpLibrary.HTTP.POST     ${CAMP-V1-CREATE-FREEBIE-URI}
	${response}=     Get Response Body

	Create Http Context     ${CAMP-V1-LEVEL-DOMAIN}      ${CAMP-PROTOCOL}
	Set Request Header     Content-type     application/json
	Set Request Header     x-wm-accesstoken     ${access-token}
	Set Request Header     x-wm-refreshtoken    ${refresh-token}
	Next Request Should Succeed
	HttpLibrary.HTTP.PUT     ${CAMP-V1-BUILD-FREEBIE-URI}
    Return From Keyword  ${response}

Delete Promotion Freebie On Camp
	[Arguments]     ${promotion_id}
    ${token-data}=   AAD Login And Get Token
	${refresh-token}=  Get From Dictionary   ${token-data}   refresh_token
	${access-token}=  Get From Dictionary   ${token-data}   access_token

	Create Http Context     ${CAMP-V1-LEVEL-DOMAIN}      ${CAMP-PROTOCOL}
	Set Request Header   Content-Type   application/json
	Set Request Header   x-wm-accessToken   ${access-token}
	Set Request Header   x-wm-refreshToken  ${refresh-token}
    Next Request Should Succeed
    HttpLibrary.HTTP.DELETE     ${CAMP-V1-CREATE-FREEBIE-URI}/${promotion_id}

	Create Http Context     ${CAMP-V1-LEVEL-DOMAIN}      ${CAMP-PROTOCOL}
	Set Request Header   Content-Type   application/json
	Set Request Header   x-wm-accessToken   ${access-token}
	Set Request Header   x-wm-refreshToken  ${refresh-token}
	Next Request Should Succeed
	HttpLibrary.HTTP.PUT     ${CAMP-V1-BUILD-FREEBIE-URI}
    Log To Console    delete_promotion_success=${promotion_id}

Check Promotions Freebie On Camp By Inventory Id
    [Arguments]     ${inventory_id}
    Create Http Context    ${CAMP-TOP-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Next Request Should Succeed
    HttpLibrary.HTTP.GET    ${CAMP-V1-GET-FREEBIE-URI}/?productVariant=${inventory_id}
    ${response}=                Get Response Body
    [Return]    ${response}

Delete Promotions Freebie On Camp
    [Arguments]     @{promotions}
    ${count}=           Get Length       ${promotions[0]["promotions"]}
    : FOR    ${INDEX}    IN RANGE    0    ${count}
    \    ${promotion_id}=      Convert To Integer      ${promotions[0]["promotions"][${INDEX}]["promotion_id"]}
    \    Delete Promotion Freebie On Camp           ${promotion_id}

Check Promotions Freebie On Camp And Delete All By Inventory Id
    [Arguments]     ${inventory_id}
    ${response}=                   Check Promotions Freebie On Camp By Inventory Id              ${inventory_id}
    @{arr_response}=               convert_json_to_array          ${response}
    ${count_promotions}=           Get Length       ${arr_response[0]["promotions"]}
    Log To Console          ${count_promotions}
    Run Keyword If          ${count_promotions}>0       Delete Promotions Freebie On Camp         @{arr_response}

Convert Date To Time Stamp
	[Arguments]    ${add_date}=0
	${now}=             Get Time
	${new-date}=        Add Time To Date        ${now}         ${add_date} days
	${epoch}=           Convert Date            ${new-date}    epoch
	${int-epoch}=       Convert To Integer      ${epoch}
	${int-timestamp}=   Evaluate                ${int-epoch}*1000
	${timestamp}=       Convert To String       ${int-timestamp}
	Return From Keyword   ${timestamp}

