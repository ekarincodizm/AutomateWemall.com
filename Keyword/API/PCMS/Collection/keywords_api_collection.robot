*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           Collections
Library           String
Library           BuiltIn
Resource          ${CURDIR}/../../../../Resource/init.robot
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/collection.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/Collection/keywords_collection.robot
Resource          ${CURDIR}/../../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../../Keyword/Common/Keywords_wemall_common.robot
Resource          ${CURDIR}/../../../..//Resource/Config/pcms_api_endpoint.robot

*** Keyword ***
Call API Get Body
    [Arguments]    ${URL}    ${Get}
    Create Http Context    ${URL}    http
    Set Request Header    Content-Type    application/json
    HttpLibrary.HTTP.GET    ${Get}
    ${response}=    Get Response Body
    [Return]    ${response}

Count collection
    Connect DB ITM
    ${total_row_colelction}=    Query    SELECT COUNT(*), NULL FROM ( SELECT * FROM `collections` WHERE `parent_id` = 0 and `deleted_at` is NULL ) as c left join `apps_collections` on `apps_collections`.collection_id = c.`id` where `apps_collections`.`app_id` = 1
    # Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row_colelction[0][0]}

Count collection List brand
    [Arguments]     ${pkey}
    Connect DB ITM
    ${total_row_colelction}=    Query    SELECT COUNT(*) FROM `brands` WHERE `id` in ( SELECT p.`brand_id` FROM ( SELECT * FROM `product_collections` WHERE `collection_id` in ( SELECT `id` FROM `collections` WHERE `pkey` = ${pkey} ) ) AS c LEFT JOIN `products` AS p ON c.`product_id`= p.`id` WHERE p.`deleted_at` IS NULL and p.`status` = 'publish' group by p.`brand_id`) and `deleted_at` is NULL
     # Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row_colelction[0][0]}


Verify status in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /status
    Should Be Equal As Strings    ${expected_mssage}    ${message}    status Not Matched

Verify Coed in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /code
    Should Be Equal As Integers    ${expected_mssage}    ${message}    Coed Not Matched

Verify message in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /message
    Should Be Equal As Strings    ${expected_mssage}    ${message}    message Not Matched

Verify pkey in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /data/pkey
    Should Be Equal As Integers    ${expected_mssage}    ${message}    pkey Not Matched

Verify Name in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /data/name
    Should Be Equal As Strings    ${message}    "${expected_mssage}"    Name Not Matched

Verify Slug in Response
    [Arguments]    ${response_body}    ${expected_mssage}
    ${message}=    Get Json Value    ${response_body}    /data/slug
    Should Be Equal As Strings    ${message}    "${expected_mssage}"    Slug Not Matched

Count Data Json
    [Arguments]    ${Json_Body}    ${tags}    ${Expected}
    ${data}=    Get Json Value    ${Json_Body}    ${tags}
    ${res}=    Parse Json    ${data}
    Length Should Be    ${res}    ${Expected}

Create collection level1
    [Arguments]    ${parent_id}    ${pkey}    ${name}    ${slug}
    ${parent_id}=    Convert To Integer    ${parent_id}
    ${pkey}=    Convert To Integer    ${pkey}
    ${collection_id}=    create_collection    ${parent_id}    ${pkey}    ${name}    ${slug}    0    TESTAPI001    1

    [Return]    ${collection_id}

Delete collection
    [Arguments]    ${collection_id}
    ${collection_id}=    delete_collection_by_collection_id    ${collection_id}

Login PCMS
    [Arguments]    ${user}    ${pwd}
    Input text    name=email    ${user}
    Input text    name=password    ${pwd}
    Press Key    name=password    \\13

Update Collection
    [Arguments]    ${name}    ${slug}
    Input text    name=name    ${name}
    Input text    name=slug    ${slug}

Count collection from apiCollection-GetIndex
    ${BodyResponse}=    Call API Get Body    ${PCMS_API_URL}    ${PCMS_API_ENDPOINT.collection}
    ${DataNode}=    Get Json Value    ${BodyResponse}    /data
    ${JsonBody}=    Parse Json    ${DataNode}
    ${TotalCollection}=    Get Length    ${JsonBody}
    Log to Console    ${TotalCollection}
    ${BodyResponse}=  Call API Get Body   ${PCMS_API_URL}     ${PCMS_API_ENDPOINT.collection}
    Log to console   PCMS_API_ENDPOINT=${PCMS_API_ENDPOINT.collection}
    ${DataNode}=  Get Json Value  ${BodyResponse}  /data
    ${JsonBody}=     Parse Json   ${DataNode}
#    Log to Console  @{JsonBody}[1]
    ${TotalCollection}=  Get Length      ${JsonBody}
    Log to Console   ${TotalCollection}
    [return]  ${TotalCollection}

Get collection from apiCollection-GetIndex
    ${BodyResponse}=  Call API Get Body   ${PCMS_API_URL}     ${PCMS_API_ENDPOINT.collection}
    ${DataNode}=  Get Json Value  ${BodyResponse}  /data
    ${JsonBody}=     Parse Json   ${DataNode}
#    Log to Console  ${JsonBody}
    Wemall Common - Assign Value To Test Variable    promotion_api   ${JsonBody}
    [return]  ${JsonBody}

Get brand list from apiCollection-brandincollection
    ${BodyResponse}=  Call API Get Body   ${PCMS_API_URL}    ${PCMS_API_ENDPOINT.brandincollection}
    ${DataNode}=  Get Json Value  ${BodyResponse}  /data
    ${JsonBody}=     Parse Json   ${DataNode}
    #    Log to Console  ${JsonBody}
    Log to Console      ${BodyResponse}
    Wemall Common - Assign Value To Test Variable    brandincollection_api   ${JsonBody}
    [return]  ${JsonBody}