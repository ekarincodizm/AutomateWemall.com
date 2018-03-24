*** Setting ***
Test Teardown     Run keyword If    "${coll_id}" != "${EMPTY}"    Run Keywords    Log    ${coll_id}
...               AND    Permanent Delete Collection By Collection ID    ${coll_id}
Force Tags        PDS_Collection_and_Merchant
Library           HttpLibrary.HTTP
Library           Collections
Library           DatabaseLibrary
Library           String
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_collections.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot

*** Variables ***
${json_create_collection}    ${CURDIR}/../../../Resource/Json/pds/create_collection.json
${parent_id}      1
${coll_id}        ${EMPTY}

*** Test Cases ***
TC_iTM_03953 DELETE: /collections/:id - delete collection by existing collection ID - success 200
    [Tags]    success    TC_iTM_03953    API_collection    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Get File    ${json_create_collection}
    #.. remove optional fields
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    #.. replace mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    # Test Step:
    #Delete Collection and check result
    ${response}=    Delete Collection By Collection ID    ${coll_id}
    Verify Success Response Status Code and Message
    #Call API for check existing deleted Collection
    ${response}=    Get Collection By Collection ID    ${coll_id}
    Verify Fail Response Status Code and Message    404    error    Not found collection

TC_iTM_03954 DELETE: /collections/:id - delete collection by non-existing collection ID - fail 404
    [Tags]    fail    TC_iTM_03954    API_collection    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Get File    ${json_create_collection}
    #.. remove optional fields
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    #.. replace mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    ${coll_id_evaluate}=    Evaluate    ${coll_id}+100
    # Test Step:
    #Delete Collection and check result
    ${response}=    Delete Collection By Collection ID    ${coll_id_evaluate}
    Verify Fail Response Status Code and Message    404    error    Not found collection

TC_iTM_03955 DELETE: /collections/:id - delete collection by EMPTY - fail 405
    [Tags]    fail    TC_iTM_03955    API_collection    ready    phoenix
    ${coll_id}=    Set Variable    ${EMPTY}
    # Test Step:
    #Delete Collection and check result
    ${response}=    Delete Collection By Collection ID    ${coll_id}
    Response Status Code Should Equal    405

TC_iTM_03956 DELETE: /collections/:id - delete collection by ID more than maximum of long - fail 400
    [Tags]    fail    TC_iTM_03956    API_collection    ready    phoenix
    ${coll_id}=    Set Variable    9223372036854775808
    # Test Step:
    #Delete Collection and check result
    ${response}=    Delete Collection By Collection ID    ${coll_id}
    Verify Fail Response Status Code and Message    400    error    Long number too large
    ${coll_id}=    Set Variable    ${EMPTY}

TC_iTM_03874 DELETE: /collections/:id - delete sub collection- success 200
    [Tags]    success    TC_iTM_03874    API_collection    ready    phoenix
    ${tc_number}=    Get Test Case Number
    #.. Create collection 1
    ${file_data}=    Get File    ${json_create_collection}
    #.. remove optional fields
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    #.. replace mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}_1"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_1}=    Get Collection ID After Creating
    #.. Create sub coll 1
    ${file_data}=    Replace String    ${file_data}    "${tc_number}_1"    "${tc_number}_2_1"
    ${response}=    Create Collection    ${coll_id_1}    ${file_data}
    ${coll_id_2_1}=    Get Collection ID After Creating
    #.. Create sub coll 2
    ${file_data}=    Replace String    ${file_data}    "${tc_number}_2_1"    "${tc_number}_2_2"
    ${response}=    Create Collection    ${coll_id_1}    ${file_data}
    ${coll_id_2_2}=    Get Collection ID After Creating
    # Test Step:
    #Delete sub coll 2 and check result
    ${response}=    Delete Collection By Collection ID    ${coll_id_2_2}
    Verify Success Response Status Code and Message
    #Call API for check parent Collection (coll 1)
    ${response}=    Get Collection By Collection ID    ${coll_id_1}
    ${children_order}=    Get Json Value    ${response}    /data/children_order
    Should Be Equal As Strings    "${children_order}"    "["${coll_id_2_1}"]"
    [Teardown]    Run Keywords    Run keyword If    "${coll_id_2_2}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_2_2}
    ...    AND    Run keyword If    "${coll_id_2_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_2_1}\
    ...    AND    Run keyword If    "${coll_id_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1}

TC_iTM_03957 DELETE: /collections/:id - delete collection that has sub collection - fail 400
    [Tags]    fail    TC_iTM_03957    ready    API_collection    ready    phoenix
    ${tc_number}=    Get Test Case Number
    #.. Create collection 1
    ${file_data}=    Get File    ${json_create_collection}
    #.. remove optional fields
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    #.. replace mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}_1"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_1}=    Get Collection ID After Creating
    #.. Create sub coll 1
    ${file_data}=    Replace String    ${file_data}    "${tc_number}_1"    "${tc_number}_2_1"
    ${response}=    Create Collection    ${coll_id_1}    ${file_data}
    ${coll_id_2_1}=    Get Collection ID After Creating
    #.. Create sub coll 2
    ${file_data}=    Replace String    ${file_data}    "${tc_number}_2_1"    "${tc_number}_2_2"
    ${response}=    Create Collection    ${coll_id_1}    ${file_data}
    ${coll_id_2_2}=    Get Collection ID After Creating
    # Test Step:
    # Delete parent Collection and check result
    ${response}=    Delete Collection By Collection ID    ${coll_id_1}
    Verify Fail Response Status Code and Message    400    error    Cannot delete collection id ${coll_id_1} with collection have children ${coll_id_2_1},${coll_id_2_2}
    [Teardown]    Run Keywords    Run keyword If    "${coll_id_2_2}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_2_2}
    ...    AND    Run keyword If    "${coll_id_2_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_2_1}\
    ...    AND    Run keyword If    "${coll_id_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1}
