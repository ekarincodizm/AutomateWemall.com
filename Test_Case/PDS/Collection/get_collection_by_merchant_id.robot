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
TC_iTM_04003 GET: /merchants/:merchant_code/collections - get empty merchant's collection by merchant code - fail 404
    [Tags]    success    TC_iTM_04003    API_collection    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
    # Test Step:
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Verify Fail Response Status Code and Message    404    error    Not found collection

TC_iTM_04004 GET: /merchants/:merchant_code/collections - get single merchant's collection by merchant code - success 200
    [Tags]    success    TC_iTM_04004    API_collection    ready    phoenix
    # Prerequisite: There is a collection for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
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
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${test_merchant_code}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    # Test Step:
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Number of Collection From Response    ${response}    1

TC_iTM_04005 GET: /merchants/:merchant_code/collections - get multiple merchant's collections by merchant code - success 200
    [Tags]    success    TC_iTM_04005    API_collection    ready    phoenix
    # Prerequisite: There are 2 collections for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
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
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}-1"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${test_merchant_code}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_1}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1"    "${tc_number}-2"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_2}=    Get Collection ID After Creating
    # Test Step:
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Number of Collection From Response    ${response}    2
    [Teardown]    Run Keywords    Run keyword If    "${coll_id_2}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_2}
    ...    AND    Run keyword If    "${coll_id_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1}

TC_iTM_04006 GET: /merchants/:merchant_code/collections - get merchant's collection by non-existing merchant code - fail 404
    [Tags]    fail    TC_iTM_04006    API_collection    ready    phoenix
    # Prerequisite: There is no collection for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
    # Test Step:
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Verify Fail Response Status Code and Message    404    error    Not found collection

TC_iTM_04007 GET: /merchants/:merchant_code/collections - get merchant's collection that merchant was deleted by merchant code - fail 404
    [Tags]    fail    TC_iTM_04007    API_collection    ready    phoenix
    # Prerequisite: There is a collection for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
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
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${test_merchant_code}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    # Test Step:
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Verify Success Response Status Code and Message
    Verify Number of Collection From Response    ${response}    1
    #.. delete collection
    Delete Collection By Collection ID    ${coll_id}
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Verify Fail Response Status Code and Message    404    error    Not found collection

TC_iTM_04009 GET: /merchants/:merchant_code/collections - get collection by Blank - fail 404
    [Tags]    fail    TC_iTM_04009    API_collection    ready    phoenix
    # Prerequisite: There is no collection for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
    # Test Step:
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Response Status Code Should Equal    404

TC_iTM_04010 GET: /merchants/:merchant_code/collections - get collection by Whitespace - fail 404
    [Tags]    fail    TC_iTM_04010    API_collection    ready    phoenix
    # Prerequisite: There is no collection for a merchant
    ${tc_number}=    Get Test Case Number
    ${test_merchant_code}=    Set Variable    ${tc_number}
    # Test Step:
    ${response}=    Get Collection By Merchant Code    ${test_merchant_code}
    Verify Fail Response Status Code and Message    404    error    Not found collection
