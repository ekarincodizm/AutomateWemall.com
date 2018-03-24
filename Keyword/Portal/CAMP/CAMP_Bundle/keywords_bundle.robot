*** Settings ***
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/env_config.robot    #Resource    ${CURDIR}/../../Resources/.robot
Resource          ${CURDIR}/../../../Portal/AAD/AAD_common/keywords_aad.robot

*** Keywords ***
Create Campaign On Camp
    [Arguments]    ${token-data}
    ${refresh-token}=    Get From Dictionary    ${token-data}    refresh_token
    ${access-token}=    Get From Dictionary    ${token-data}    access_token
    ${content}=    Get File    ${CURDIR}/../../../../Resource/TestData/json/create_campaign.json
    Create Http Context    ${CAMP-HOST-API}    http
    Set Request Header    Content-Type    application/json
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    Set Request Body    ${content}
    Log To Console    access-token=${access-token}
    Log To Console    refresh-token=${refresh-token}
    Log To Console    content=${content}
    Next Request May Not Succeed
    HttpLibrary.HTTP.POST    ${CAMP-CREATE-CAMPAIGN-URI}
    ${body}=    Get Response Body
    Log To Console    ================================================
    Log To Console    response-create-campaign=${body}
    Log To Console    ================================================
    ${campaign-id}=    Get Json Value    ${body}    /data/id
    Return From Keyword    ${campaign-id}

Get Campaign
    [Arguments]    ${token-data}    ${campaign-id}
    ${refresh-token}=    Get From Dictionary    ${token-data}    refresh_token
    ${access-token}=    Get From Dictionary    ${token-data}    access_token
    Create Http Context    ${AAD-HOST-API}    http
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    HttpLibrary.HTTP.GET    http://${CAMP-HOST-API}${CAMP-CREATE-CAMPAIGN-URI}/${campaign-id}
    ${body}=    Get Response Body
    Log To Console    ${body}

Delete Campaign On Camp
    [Arguments]    ${token-data}    ${campaign-id}
    Create Http Context    ${CAMP-HOST-API}    http
    ${refresh-token}=    Get From Dictionary    ${token-data}    refresh_token
    ${access-token}=    Get From Dictionary    ${token-data}    access_token
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    Next Request Should Succeed
    HttpLibrary.HTTP.DELETE    ${CAMP-DELETE-CAMPAIGN-URI}/${campaign-id}
    ${body}=    Get Response Body
    Log To console    ${body}

Create Mnp Promotion On Camp
    [Arguments]    ${campaign-id}=None    ${inv_id}=None    ${discount_type}=None    ${discount_value}=None    ${pp_code}=None    ${pp_discount_type}=None
    ...    ${pp_discount_value}=None    ${token-data}=None
    ${refresh-token}=    Get From Dictionary    ${token-data}    refresh_token
    ${access-token}=    Get From Dictionary    ${token-data}    access_token
    Run Keyword If    '${campaign-id}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${inv_id}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount_type}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount_value}' == 'None'    Return From Keyword    ${EMPTY}
    ${content}=    Get File    ${CURDIR}/../../../../Resource/TestData/json/create_mnp.json    utf-8
    ${content}=    Replace String    ${content}    ^^priceplan_code^^    ${pp_code}
    ${content}=    Replace String    ${content}    ^^campaign_id^^    ${campaign-id}
    ${content}=    Replace String    ${content}    ^^inventory_id^^    ${inv_id}
    ${content}=    Replace String    ${content}    ^^discount_type^^    ${discount_type}
    ${content}=    Replace String    ${content}    ^^discount_value^^    ${discount_value}
    ${content}=    Replace String    ${content}    ^^inventory_id2^^    ${pp_code}
    ${content}=    Replace String    ${content}    ^^discount_type2^^    ${pp_discount_type}
    ${content}=    Replace String    ${content}    ^^discount_value2^^    ${pp_discount_value}
    # Log To Console    content-after-replace=${content}
    Create Http Context    ${CAMP-HOST-API}    http
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    Set Request Body    ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST    ${CAMP-CREATE-PROMOTION-URI}
    ${body}=    Get Response Body
    # Log To Console    create-promotion-body=${body}

Build Change Camp
    [Arguments]    ${token-data}
    ${refresh-token}=    Get From Dictionary    ${token-data}    refresh_token
    ${access-token}=    Get From Dictionary    ${token-data}    access_token
    Create Http Context    ${CAMP-HOST-API}    http
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    Next Request Should Succeed
    HttpLibrary.HTTP.PUT    ${CAMP-BUILD-URI}
    ${body}=    Get Response Body
    Log to console    ${body}

Update Mnp Promotion On Camp
    [Arguments]    ${campaign-id}=None    ${inv_id}=None    ${discount_type}=None    ${discount_value}=None    ${pp_code}=None    ${pp_discount_type}=None
    ...    ${pp_discount_value}=None    ${token-data}=None    ${promotion_id}=None
    ${refresh-token}=    Get From Dictionary    ${token-data}    refresh_token
    ${access-token}=    Get From Dictionary    ${token-data}    access_token
    Run Keyword If    '${campaign-id}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${inv_id}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount_type}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount_value}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${pp_code}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${pp_discount_type}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${pp_discount_value}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword IF    '${promotion_id}' == 'None'    Return From Keyword    ${EMPTY}
    ${content}=    Get File    ${CURDIR}/../../Resources/TestData/json/create_mnp.json    utf-8
    ${content}=    Replace String    ${content}    ^^campaign_id^^    ${campaign-id}
    ${content}=    Replace String    ${content}    ^^inventory_id^^    ${inv_id}
    ${content}=    Replace String    ${content}    ^^discount_type^^    ${discount_type}
    ${content}=    Replace String    ${content}    ^^discount_value^^    ${discount_value}
    ${content}=    Replace String    ${content}    ^^inventory_id2^^    ${pp_code}
    ${content}=    Replace String    ${content}    ^^discount_type2^^    ${pp_discount_type}
    ${content}=    Replace String    ${content}    ^^discount_value2^^    ${pp_discount_value}
    # Log To Console    content-after-replace=${content}
    #log to console    token-data=${token-data}
    Create Http Context    ${CAMP-HOST-API}    http
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    Set Request Body    ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.PUT    ${CAMP-UPDATE-PROMOTION-URI}/${promotion_id}
    ${body}=    Get Response Body
    Log To Console    create-promotion-body=${body}

Create Mnp Camp Promotion by Promotion data
    [Arguments]    ${inv_id_device}    ${device_discount_type}    ${device_discount}    ${pp_code}
    # ${device_discount_type}=discount_fixed/discount_percent
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    Log to console    campaign-id=${campaign_id}
    ${resp_create_camp}=    Create Mnp Promotion On Camp    ${campaign_id}    ${inv_id_device}    ${device_discount_type}    ${device_discount}    ${pp_code}
    ...    discount_percent    0    ${token-data}
    Log to console    resp_create_camp=${resp_create_camp}
    Build Change Camp    ${token-data}
    ${promotion}=    Create Dictionary    inv_id=${inv_id_device}    discount_type=${device_discount_type}    discount=${device_discount}    pp_code=${pp_code}
    ${camp_data}=    Create Dictionary    token-data=${token-data}    campaign_id=${campaign_id}    promotion=${promotion}
    Set Test Variable    ${TV_camp_data}    ${camp_data}
    [Return]    ${camp_data}

Create Mnp Camp Promotion by Promotion data 2
    [Arguments]    ${inv_id_device}    ${pp_code_1}=ROBOTMNPDEVICE11    ${pp_code_2}=ROBOTMNPDEVICE12    ${discount_type_1}=discount_percent    ${discount_type_2}=discount_percent    ${device_discount}=30
    ...    ${pp_discount_1}=0    ${pp_discount_2}=0
    ${token-data}=    AAD Login And Get Token
    ${campaign_id}=    Create Campaign On Camp    ${token-data}
    Log to console    campaign-id=${campaign_id}
    ${resp_create_camp_1}=    Create Mnp Promotion On Camp    ${campaign_id}    ${inv_id_device}    ${discount_type_1}    ${device_discount}    ${pp_code_1}
    ...    ${discount_type_1}    ${pp_discount_1}    ${token-data}
    ${resp_create_camp_2}=    Create Mnp Promotion On Camp    ${campaign_id}    ${inv_id_device}    ${discount_type_2}    ${device_discount}    ${pp_code_2}
    ...    ${discount_type_2}    ${pp_discount_2}    ${token-data}
    Log to console    resp_create_camp=${resp_create_camp_1}
    Build Change Camp    ${token-data}
    ${promotion_1}=    Create Dictionary    inv_id=${inv_id_device}    discount_type=${discount_type_1}    discount=${device_discount}    pp_code=${pp_code_1}
    ${promotion_2}=    Create Dictionary    inv_id=${inv_id_device}    discount_type=${discount_type_2}    discount=${device_discount}    pp_code=${pp_code_2}
    ${camp_data}=    Create Dictionary    token-data=${token-data}    campaign_id=${campaign_id}    promotion_1=${promotion_1}    promotion_2=${promotion_2}
    Set Test Variable    ${TV_camp_data}    ${camp_data}
    [Return]    ${camp_data}

Create Bundle Promotion On Camp
    [Arguments]    ${inventory_id}=None    ${inventory_id2}=None    ${campaign_id}=None    ${discount_value}=None    ${discount_value2}=None    ${discount_type}=None
    ...    ${discount_type2}=None
    Run Keyword If    '${inventory_id}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${inventory_id2}' == 'None'    Return From Keyword    ${EMPTY}
    ${fix_campaign_id}=    Set Variable If    '${ENV}'=='staging40k'    1790    ${BUNDLE-CAMPAIGN-ID}
    ${campaign_id}=    Run Keyword If    '${campaign_id}' == 'None'    Convert To String    ${fix_campaign_id}
    ...    ELSE    Convert To String    ${campaign_id}
    ${discount_value}=    Run Keyword If    '${discount_value}' == 'None'    Convert To String    30
    ...    ELSE    Convert To String    ${discount_value}
    ${discount_value2}=    Run Keyword If    '${discount_value2}' == 'None'    Convert To String    100
    ...    ELSE    Convert To String    ${discount_value2}
    ${discount_type}=    Run Keyword If    '${discount_type}' == 'None'    Set Variable    discount_percent
    ...    ELSE    Set Variable    ${discount_type}
    ${discount_type2}=    Run Keyword If    '${discount_type2}' == 'None'    Set Variable    discount_percent
    ...    ELSE    Set Variable    ${discount_type2}
    ${content}=    Get File    ${CURDIR}/../../../../Resource/TestData/json/create_bundle.json    utf-8
    ${content}=    Replace String    ${content}    ^^campaign_id^^    ${campaign_id}
    ${content}=    Replace String    ${content}    ^^inventory_id^^    ${inventory_id}
    ${content}=    Replace String    ${content}    ^^inventory_id2^^    ${inventory_id2}
    ${content}=    Replace String    ${content}    ^^discount_value^^    ${discount_value}
    ${content}=    Replace String    ${content}    ^^discount_value2^^    ${discount_value2}
    ${content}=    Replace String    ${content}    ^^discount_type^^    ${discount_type}
    ${content}=    Replace String    ${content}    ^^discount_type2^^    ${discount_type2}
    ${token-data}=    AAD Login And Get Token
    ${accesstoken}=    Get From Dictionary    ${token-data}    access_token
    ${refreshtoken}=    Get From Dictionary    ${token-data}    refresh_token
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accesstoken    ${accesstoken}
    Set Request Header    x-wm-refreshtoken    ${refreshtoken}
    Set Request Body    ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST    ${CAMP-V1-CREATE-PROMOTIONS-URI}
    ${response}=    Get Response Body
    ${prodmotion_id}=    Get Json Value    ${response}    /data/id
    Set Test Variable    ${var_camp_bundle_prodmotion_id}    ${prodmotion_id}
    Log to console    promotion_bundle=${var_camp_bundle_prodmotion_id}
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accesstoken    ${Access_Token}
    Set Request Header    x-wm-refreshtoken    ${Refresh_Token}
    Next Request Should Succeed
    HttpLibrary.HTTP.PUT    ${CAMP-V1-BUILD-PROMOTIONS-URI}
    [Return]    ${response}

Check Promotion Bundle From Camp
    [Arguments]    ${inventory_id}=None
    Run Keyword If    '${inventory_id}' == 'None'    Return From Keyword    ${EMPTY}
    ${res}=    Login to Wemall(API)    /v1/tokens    authen001@test.com    password    grant_type=merchant
    Validate Login Completed    ${res}
    ${accesstoken}=    Get Access Token from Response    ${res.text}
    ${refreshtoken}=    Get Refresh Token from Response    ${res.text}
    Create Http Context    ${CAMP-TOP-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    x-wm-accesstoken    ${accesstoken}
    Set Request Header    x-wm-refreshtoken    ${refreshtoken}
    Next Request Should Succeed
    HttpLibrary.HTTP.GET    ${CAMP-V1-GET-BUNDLE-URI}/?productVariant=${inventory_id}
    ${response}=    Get Response Body
    ${promotion_id}=    Get Json Value    ${response}    /0/promotion_id
    Log To Console    ${promotion_id}
    [Return]    ${response}

Create Bundle Promotion On Camp 2
    [Arguments]    ${inventory_id}=None    ${inventory_id2}=None    ${campaign_id}=None    ${discount_value}=None    ${discount_value2}=None
    Run Keyword If    '${inventory_id}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${inventory_id2}' == 'None'    Return From Keyword    ${EMPTY}
    ${campaign_id}=    Run Keyword If    '${campaign_id}' == 'None'    Convert To String    5747
    ...    ELSE    Convert To String    ${campaign_id}
    ${discount_value}=    Run Keyword If    '${discount_value}' == 'None'    Convert To String    30
    ...    ELSE    Convert To String    ${discount_value}
    ${discount_value2}=    Run Keyword If    '${discount_value2}' == 'None'    Convert To String    100
    ...    ELSE    Convert To String    ${discount_value2}
    ${content}=    Get File    ${CURDIR}/../../../../Resource/TestData/json/create_bundle.json    utf-8
    ${content}=    Replace String    ${content}    ^^campaign_id^^    ${campaign_id}
    ${content}=    Replace String    ${content}    ^^inventory_id^^    ${inventory_id}
    ${content}=    Replace String    ${content}    ^^inventory_id2^^    ${inventory_id2}
    ${content}=    Replace String    ${content}    ^^discount_value^^    ${discount_value}
    ${content}=    Replace String    ${content}    ^^discount_value2^^    ${discount_value2}
    ${token-data}=    AAD Login And Get Token
    ${accesstoken}=    Get From Dictionary    ${token-data}    access_token
    ${refreshtoken}=    Get From Dictionary    ${token-data}    refresh_token
    # ${res}=    Login to Wemall(API)    /v1/tokens    authen001@test.com    password    grant_type=merchant
    # Validate Login Completed    ${res}
    # ${accesstoken}=    Get Access Token from Response    ${res.text}
    # ${refreshtoken}=    Get Refresh Token from Response    ${res.text}
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accesstoken    ${accesstoken}
    Set Request Header    x-wm-refreshtoken    ${refreshtoken}
    Set Request Body    ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST    ${CAMP-V1-CREATE-PROMOTIONS-URI}
    ${response}=    Get Response Body
    ${prodmotion_id}=    Get Json Value    ${response}    /data/id
    Set Test Variable    ${var_camp_bundle_prodmotion_id}    ${prodmotion_id}
    Log to console    promotion_bundle=${var_camp_bundle_prodmotion_id}
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accesstoken    ${Access_Token}
    Set Request Header    x-wm-refreshtoken    ${Refresh_Token}
    Next Request Should Succeed
    HttpLibrary.HTTP.PUT    ${CAMP-V1-BUILD-PROMOTIONS-URI}
    [Return]    ${response}

Delete Promotion Bundle On Camp
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
