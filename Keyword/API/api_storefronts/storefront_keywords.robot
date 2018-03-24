*** Settings ***
Library             HttpLibrary.HTTP
Resource            ${CURDIR}/../common/api_keywords.robot
Resource            ${CURDIR}/../../../Resource/TestData/storefronts/storefront_data.robot
Resource            ${CURDIR}/api_shops_keywords.robot
Resource            ${CURDIR}/api_pages_keywords.robot
Library             Collections
Library             OperatingSystem

*** Variables ***
${web_view}                 web
${mobile_view}              mobile
${body_post_template}       ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json

*** Keywords ***
####### Prepare Data #######
Storefront - Create Merchant Alias
    ${alias_name}=   Wemall Common - Get Value From test Variable   alias_name
    ${alias_code}=   Wemall Common - Get Value From Test Variable  alias_code
    # Wemall Common - Debug   ${alias_code}   alias_code_sent_to-create_storefront
    Prepare Data For Storefront API   ${alias_code}   ${alias_name}  ${storefront_slug_alias}  active

Prepare Data for Storefront API
    [Arguments]    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}   ${shop_json_template}=${body_post_template}
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}   ${shop_json_template}
    Prepare Storefront Content by Storefront API    ${suite_shop_id}

Prepare Pages and Content Storefront
    [Arguments]   ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Prepare Pages Data For Suite    ${shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Create Pages Content Data From Input File    ${shop_id}    ${suite_pages_id}    ${web_view}    ${prepare_content}
    Publish Pages Content Success    ${shop_id}    ${suite_pages_id}    content    ${web_view}
    Create Pages Content Data From Input File    ${shop_id}    ${suite_pages_id}    ${mobile_view}    ${prepare_content}
    Publish Pages Content Success    ${shop_id}    ${suite_pages_id}    content    ${mobile_view}

Prepare Incomplete Pages Content Storefront
    [Arguments]   ${shop_id}    ${pages_id}
    Update Pages Data From Input File   ${shop_id}    ${pages_id}    ${web_view}   ${incomplete_content}
    Publish Pages Content Success    ${shop_id}    ${suite_pages_id}    content    ${web_view}
    Update Pages Data From Input File   ${shop_id}    ${pages_id}    ${mobile_view}   ${incomplete_content}
    Publish Pages Content Success    ${shop_id}    ${suite_pages_id}    content    ${mobile_view}

Prepare Storefront Content by Storefront API
    [Arguments]    ${shop_id}
    Update Storefront Data From Input File    ${shop_id}    ${web_view}    ${prepare_header}
    Update Storefront Data From Input File    ${shop_id}    ${web_view}    ${prepare_menu}
    Update Storefront Data From Input File    ${shop_id}    ${web_view}    ${prepare_banner}
    Update Storefront Data From Input File    ${shop_id}    ${web_view}    ${prepare_content}
    Update Storefront Data From Input File    ${shop_id}    ${web_view}    ${prepare_footer}
    Sleep    1s
    Update Storefront Data From Input File    ${shop_id}    ${web_view}    ${put_published}
    Update Storefront Data From Input File    ${shop_id}    ${mobile_view}    ${prepare_header}
    Update Storefront Data From Input File    ${shop_id}    ${mobile_view}    ${prepare_menu}
    Update Storefront Data From Input File    ${shop_id}    ${mobile_view}    ${prepare_banner}
    Update Storefront Data From Input File    ${shop_id}    ${mobile_view}    ${prepare_content}
    Update Storefront Data From Input File    ${shop_id}    ${mobile_view}    ${prepare_footer}
    Sleep    1s
    Update Storefront Data From Input File    ${shop_id}    ${mobile_view}    ${put_published}

Prepare Incomplete Storefront Data
    [Arguments]    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_header}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_menu}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_banner}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_content}
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${incomplete_footer}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${put_published}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_header}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_menu}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_banner}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_content}
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${incomplete_footer}
    Sleep    1s
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${put_published}

Storefront - Prepare Storefront Content Data Both Version
    [Arguments]    ${shop_id}    ${view}
    Prepare Storefront Data Both Version    ${shop_id}    ${view}    content    ${prepare_content}

Storefront - Prepare Storefront Header Data Both Version
    [Arguments]    ${shop_id}    ${view}
    Prepare Storefront Data Both Version    ${shop_id}    ${view}    header    ${prepare_header}

Prepare Storefront Data Both Version
    [Arguments]    ${shop_id}    ${view}    ${type}    ${input_file}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${input_file}
    Sleep    1s
    Publish Storefront Data    ${shop_id}    ${type}    ${view}

Prepare Storefront With Content for Storefront API
    [Arguments]    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    content    ${prepare_content}
    Prepare Storefront Data Both Version    ${suite_shop_id}    ${mobile_view}    content    ${prepare_content}

Prepare Storefront Web Data With Content for Storefront API
    [Arguments]    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    Prepare Storefront Data Both Version    ${suite_shop_id}    ${web_view}    content    ${prepare_content}

Prepare Storefront Content Draft by Storefront API
    [Arguments]    ${shop_id}    ${view}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${prepare_header}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${prepare_menu}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${prepare_banner}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${prepare_content}
    Update Storefront Data From Input File    ${shop_id}    ${view}    ${prepare_footer}

Prepare Shop For Suite And If Shop Exist will Delete and Create New
    [Arguments]    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}   ${shop_json_template}=${body_post_template}
    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${shop_slug}
    # Get Shop by Shop Slug    ${shop_slug}
    # ${keywords_status}=    Run Keyword And Return Status    Verify Response Success but Data Empty    null
    # Run Keyword If    '${keywords_status}' == 'False'    Get Shop Id And Delete ALL THINGS
    Prepare Shop Data For Suite    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}   ${shop_json_template}

Prepare Shop And If Shop Exist will Delete and Create New
    [Arguments]    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}   ${shop_json_template}=${body_post_template}
    Check is Shop Exist by Slug Then Delete Shop by Shop ID    ${shop_slug}
    ${shop_id}=         Prepare Shop Data       ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}    ${shop_json_template}
    Set Suite Variable    ${suite_shop_id_2}    ${shop_id}

Check is Shop Exist by Slug Then Delete Shop by Shop ID
    [Arguments]    ${shop_slug}
    Get Shop by Shop Slug    ${shop_slug}
    ${keywords_status}=    Run Keyword And Return Status    Verify Response Success but Data Empty    null
    Run Keyword If    '${keywords_status}' == 'False'    Get Shop Id And Delete ALL THINGS

Get Shop Id And Delete ALL THINGS
    ${get_shop_id}=    Get Shop ID from Response Body Data
    Delete Storefront Web and Mobile All Type and All Version    ${get_shop_id}

####### Get #######
Get Storefront Failed
    [Arguments]    ${content_id}    ${view}    ${Anonymousid}=${EMPTY}    ${AccessTokens}=${EMPTY}
    HTTP Get Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${Anonymousid}    ${AccessTokens}

####### POST #######
Create Storefront Data From Input File
    [Arguments]    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    HTTP Post Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}
    Response Status Code Should Equal    200 OK

Create Pages Content Data From Input File
    [Arguments]    ${parent_id}    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Node to Json Body    ${request_body}    parent_id    ${parent_id}
    HTTP Post Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}
    Response Status Code Should Equal    200 OK

Create Pages Content Data Failed From Input File
    [Arguments]    ${parent_id}    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Node to Json Body    ${request_body}    parent_id    ${parent_id}
    HTTP Post Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}


Create Storefront Data Failed From Input File
    [Arguments]    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    HTTP Post Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}

Create Storefront WO Type
    [Arguments]    ${content_id}    ${version}    ${view}    ${data}
    ${request_body}=    Generate JSON WO Type    ${version}    ${data}
    Send Post Fail    ${content_id}    ${view}    ${request_body}

Create Storefront WO Version
    [Arguments]    ${content_id}    ${type}    ${view}    ${data}
    ${request_body}=    Generate JSON WO Version    ${type}    ${data}
    Send Post Fail    ${content_id}    ${view}    ${request_body}

Create Storefront WO Data
    [Arguments]    ${content_id}    ${type}    ${version}    ${view}
    ${request_body}=    Generate JSON WO Data    ${type}    ${version}
    Send Post Fail    ${content_id}    ${view}    ${request_body}

Send Post Success
    [Arguments]    ${content_id}    ${view}    ${request_body}
    HTTP Post Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}

Send Post Fail
    [Arguments]    ${content_id}    ${view}    ${request_body}
    HTTP Post Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}

####### PUT Storefronts#######
Update Storefront Data From Input File
    [Arguments]    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    HTTP Put Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}
    Response Status Code Should Equal    200 OK

Update Storefront and Published Storefront Data
   [Arguments]    ${content_id}    ${json_data_file}    ${contentType}
   Update Storefront Data From Input File    ${content_id}    web    ${json_data_file}
   Update Storefront Data From Input File    ${content_id}    mobile    ${json_data_file}
   Publish Storefront Success    ${content_id}    ${contentType.lower()}    published    web
   Publish Storefront Success    ${content_id}    ${contentType.lower()}    published    mobile

Update Storefront Data From Input File With Data-ID
    [Arguments]    ${content_id}    ${view}    ${json_data_file}   ${data_target}
    ${request_body}=    Get File    ${json_data_file}
    ${request_body}=    Replace String    ${request_body}    <div     <div data-id=\\\"${data_target}\\\"
    Log to console   STOREFRONT=${STOREFRONT-API-httpLib}${CSS_STOREFRONT}${content_id}/${view}
    Log to console   request_body=${request_body}
    HTTP Put Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}
    Response Status Code Should Equal    200 OK

Update Storefront Data From Input File But Failed
    [Arguments]    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    HTTP Put Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}

Update Pages Content Data From Input File
    [Arguments]    ${parent_id}    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Node to Json Body    ${request_body}    parent_id    ${parent_id}
    HTTP Put Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}
    Response Status Code Should Equal    200 OK

Update Pages Content Data Failed From Input File
    [Arguments]    ${parent_id}    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Node to Json Body    ${request_body}    parent_id    ${parent_id}
    HTTP Post Request Failed     ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}


Update Storefront WO Type
    [Arguments]    ${content_id}    ${version}    ${view}    ${data}
    ${request_body}=    Generate JSON WO Type    ${version}    ${data}
    Send Put Fail    ${content_id}    ${view}    ${request_body}

Update Storefront WO Version
    [Arguments]    ${content_id}    ${type}    ${view}    ${data}
    ${request_body}=    Generate JSON WO Version    ${type}    ${data}
    Send Put Fail    ${content_id}    ${view}    ${request_body}

Update Storefront WO Data
    [Arguments]    ${content_id}    ${type}    ${view}    ${version}
    ${request_body}=    Generate JSON WO Data    ${type}    ${version}
    Send Put Fail    ${content_id}    ${view}    ${request_body}

Publish Storefront Success
    [Arguments]    ${content_id}    ${type}    ${version}    ${view}    ${data}=data
    ${request_body}=    Generate JSON    ${type}    ${version}    ${data}
    Send Put Success    ${content_id}    ${view}    ${request_body}

Publish Storefront Fail
    [Arguments]    ${content}    ${version}    ${view}    ${en_US}    ${th_TH}
    ${request_body}=    Generate JSON    ${version}    ${en_US}    ${th_TH}
    Send Put Fail    ${content}    ${view}    ${request_body}

Send Put Success
    [Arguments]    ${content_id}    ${view}    ${request_body}
    HTTP Put Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}

Send Put Fail
    [Arguments]    ${content_id}    ${view}    ${request_body}
    HTTP Put Request Failed    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}

Publish Storefront Data
    [Arguments]    ${content_id}    ${type}    ${view}
    Publish Storefront Success    ${content_id}    ${type}    published    ${view}
    Response Status Code Should Equal    200 OK

####### PUT Pages #######
Update Pages Data From Input File
    [Arguments]    ${parent_id}    ${content_id}    ${view}    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    ${request_body}=    Add Node to Json Body    ${request_body}    parent_id    ${parent_id}
    HTTP Put Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}    ${request_body}
    Response Status Code Should Equal    200 OK

Publish Pages Content Success
    [Arguments]    ${parent_id}    ${content_id}    ${type}    ${view}    ${data}=data
    ${request_body}=    Generate JSON for Published Pages    ${parent_id}    ${type}    published    ${data}
    Send Put Success    ${content_id}    ${view}    ${request_body}

####### Delete #######
Delete Storefront Draft and Published Success Specific type
    [Arguments]    ${content_id}    ${view}    ${type}
    HTTP Delete Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}?type=${type}&version=draft
    Verify Delete Success
    HTTP Delete Request    ${STOREFRONT-API-httpLib}    http    ${CSS_STOREFRONT}${content_id}/${view}?type=${type}&version=published
    Verify Delete Success

Delete Storefront Draft and Published Success All Type
    [Arguments]    ${content_id}    ${view}
    Delete Storefront Draft and Published Success Specific type    ${content_id}    ${view}    header
    Delete Storefront Draft and Published Success Specific type    ${content_id}    ${view}    menu
    Delete Storefront Draft and Published Success Specific type    ${content_id}    ${view}    banner
    Delete Storefront Draft and Published Success Specific type    ${content_id}    ${view}    content
    Delete Storefront Draft and Published Success Specific type    ${content_id}    ${view}    footer

Delete Storefront Web and Mobile All Type and All Version
    [Arguments]    ${content_id}
    Delete Storefront Draft and Published Success All Type    ${content_id}    ${web_view}
    Delete Storefront Draft and Published Success All Type    ${content_id}    ${mobile_view}
    Delete Shop by Shop ID Success    ${content_id}

Delete Shop and All Storefront Data
    [Arguments]    ${content_id}
    Delete Storefront Draft and Published Success All Type    ${content_id}    ${web_view}
    Delete Storefront Draft and Published Success All Type    ${content_id}    ${mobile_view}
    Delete Storefront Page Draft and Published Success All Type     ${content_id}    ${web_view}
    Delete Storefront Page Draft and Published Success All Type     ${content_id}    ${mobile_view}
    Delete Shop by Shop ID Success    ${content_id}

Delete Storefront Page Draft and Published Success All Type
    [Arguments]    ${content_id}     ${view}
    Get Shop by Shop ID         ${content_id}
    ${response_body}=    Get Response Body
    #${pages}=            Get Json Value    ${response_body}    /data/pages
    ${shop}=             Convert json to Dict        ${response_body}
    ${shop}=             Get From Dictionary        ${shop}     data
    ${status}=           Run Keyword and return status        Dictionary Should Contain Key       ${shop}     data
    Run Keyword and return If    '${status}'!='PASS'          Return From Keyword           True
    ${pages}=            Get From Dictionary        ${shop}     pages
    ${items}=            Get Dictionary Items       ${pages}
    :FOR     ${page_id}     ${page}     IN    @{items}
    \       Delete Storefront Draft and Published Success All Type      ${page_id}      ${view}

####### Verify #######
Verify PUT/POST Success
    [Arguments]    ${expexted_suite_shop_id}    ${expType}
    ${response_body}=    Get Response Body
    ${content_id}=    Get Json Value    ${response_body}    /data/id
    ${type}=    Get Json Value    ${response_body}    /data/type
    Response Status Code Should Equal    200 OK
    Should Not Be Empty    ${content_id}
    Should Not Be Empty    ${type}

Verify PUT/POST Invalid Type
    ${response_body}=    Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Response Status Code Should Equal    400 Bad Request
    Should Be Equal    ${message}    "Missing or invalid type"

Verify PUT/POST Invalid Data
    ${response_body}=    Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Response Status Code Should Equal    400
    Should Be Equal    ${message}    "Missing or invalid data"

Verify PUT/POST Invalid Data Site
    ${response_body}=    Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Response Status Code Should Equal    400
    # Should Be Equal    ${message}    "Wrong site"
    Should Be Equal    ${message}    "Missing or invalid data"

Verify PUT/POST Invalid Version
    ${response_body}=    Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Response Status Code Should Equal    400
    Should Be Equal    ${message}    "Invalid version"

Verify Publish Success
    [Arguments]    ${expId}
    ${response_body}=    Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data/id
    Response Status Code Should Equal    200 OK
    Should Be Equal    ${data}    "${expId}"

Verify PUT/POST Failed because Shop Not Exists
    ${response_body}=    Get Response Body
    ${message}=    Get Json Value    ${response_body}    /errorDescription
    Response Status Code Should Equal    400
    Should Be Equal    "Shop id doesn't exists"    ${message}

Verify Update Type Success
    [Arguments]    ${expexted_suite_shop_id}    ${expType}
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    ${suite_shop_id}=     Get Json Value    ${response_body}    /data/id
    ${type}=    Get Json Value    ${response_body}    /data/type

Verify Create Header Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Header

Verify Create Menu Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Menu

Verify Create Banner Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Banner

Verify Create Content Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Content

Verify Create Footer Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Footer

Verify Update Header Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Header

Verify Update Menu Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Menu

Verify Update Banner Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Banner

Verify Update Content Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Content

Verify Update Footer Success
    [Arguments]    ${content_id}
    Verify Update Type Success    ${content_id}    Footer

Verify Update Banner Failed Because Time Collapsing
    [Arguments]    ${sequence}
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=    Get Response Body
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal As Strings    "Time is overlapping on cell order [${sequence}]"    ${message}    Message not matched

Verify Delete Success
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    ${data}=    Get Json Value    ${response_body}    /data
    Should Be Equal    ${data}    true

####### GEN JSON #######
Generate JSON
    [Arguments]    ${type}    ${version}    ${data}
    ${json}=    Create Dictionary    type=${type}    version=${version}    data=${data}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Generate JSON for Published Pages
    [Arguments]    ${parent_id}    ${type}    ${version}    ${data}
    ${json}=    Create Dictionary    type=${type}    version=${version}    data=${data}    parent_id=${parent_id}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Generate JSON WO Type
    [Arguments]    ${version}    ${data}
    ${json}=    Create Dictionary    version=${version}    data=${data}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Generate JSON WO Version
    [Arguments]    ${type}    ${data}
    ${json}=    Create Dictionary    type=${type}    data=${data}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

Generate JSON WO Data
    [Arguments]    ${type}    ${version}
    ${json}=    Create Dictionary    type=${type}    version=${version}
    ${json_string}=    Evaluate    json.dumps(${json})    json
    Return From Keyword    ${json_string}

API Storefront - Get Storefront Detail
    [Arguments]   ${merchant_code}=None

    HttpLibrary.HTTP.Create Http Context   ${WEMALL_API}   http
    ${endpoint}=   Set Variable   ${STOREFRONT_API_URI.wrapper_merchant}

    ${endpoint}=   Replace String  ${endpoint}  ^^MERCHANT_CODE^^  ${merchant_code}
    Log TO COnsole   endpoint=${endpoint}
    HttpLibrary.HTTP.GET   ${endpoint}
    ${storefront_body}=   Get Response Body
    [Return]  ${storefront_body}


