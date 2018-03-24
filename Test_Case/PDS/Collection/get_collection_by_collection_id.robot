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
TC_iTM_03994 GET: /collections/:id - get collection that has no product by collection ID - success 200
    [Tags]    success    TC_iTM_03994    API_collection    ready    phoenix
    # Prerequisite: There is collection that has no product on system
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
    ${response}=    Get Collection By Collection ID    ${coll_id}
    Verify Success Response Status Code and Message
    Verify Products From Response is Empty    ${response}
    ${data}=    Get Json Value and Convert to List    ${response}    /data/children
    Verify Collections Between Data From Response and DB    ${data}

TC_iTM_03997 GET: /collections/:id - get collection that has no sub collection by collection ID - success 200
    [Tags]    success    TC_iTM_03997    API_collection    ready    phoenix
    # Prerequisite: There is collection that has no sub collection on system
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
    ${response}=    Get Collection By Collection ID    ${coll_id}
    Verify Success Response Status Code and Message
    Verify Sub Collection From Response is Empty    ${response}
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Verify Collections Between Data From Response and DB    ${data}

TC_iTM_03998 GET: /collections/:id - get collection that has 1-5 sub collection level by collection ID - success 200
    [Tags]    success    TC_iTM_03998    API_collection    ready    phoenix
    # Prerequisite: There is collection that has 1-5 sub collection level on system
    ${tc_number}=    Get Test Case Number
    #..COLLECTION 1
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
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}-COLL1"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response_1}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_1}=    Get Collection ID After Creating
    # Test Step:
    #..COLLECTION 1
    ${level}=    Set Variable    2
    ${response_1}=    Get Collection By Collection ID    ${coll_id_1}
    Verify Success Response Status Code and Message
    Verify Number of Sub Collection And Level from Response    ${response_1}    0    ${level}
    ${data_1}=    Get Json Value and Convert to List    ${response_1}    /data
    Verify Collections Between Data From Response and DB    ${data_1}
    #..COLLECTION 1-1 sub level 1
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-COLL1"    "${tc_number}-COLL1-1"
    ${response_1-1}=    Create Collection    ${coll_id_1}    ${file_data}
    ${coll_id_1-1}=    Get Collection ID After Creating
    # Test Step:
    #..COLLECTION 1-1 sub level 1
    ${level}=    Set Variable    2
    : FOR    ${coll_id}    ${number_of_sub_coll}    IN    ${coll_id_1}    1    ${coll_id_1-1}
    ...    0
    \    ${response_item}=    Get Collection By Collection ID    ${coll_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Collection And Level from Response    ${response_item}    ${number_of_sub_coll}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Collections Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1
    #..COLLECTION 1-2 sub level 2
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-COLL1-1"    "${tc_number}-COLL1-1-2"
    ${response_1-2}=    Create Collection    ${coll_id_1-1}    ${file_data}
    ${coll_id_1-2}=    Get Collection ID After Creating
    # Test Step:
    #..COLLECTION 1-2 sub level 2
    ${level}=    Set Variable    2
    : FOR    ${coll_id}    ${number_of_sub_coll}    IN    ${coll_id_1}    1    ${coll_id_1-1}
    ...    1    ${coll_id_1-2}    0
    \    ${response_item}=    Get Collection By Collection ID    ${coll_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Collection And Level from Response    ${response_item}    ${number_of_sub_coll}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Collections Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1
    #..COLLECTION 1-3 sub level 3
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-COLL1-1-2"    "${tc_number}-COLL1-1-3"
    ${response_1-3}=    Create Collection    ${coll_id_1-2}    ${file_data}
    ${coll_id_1-3}=    Get Collection ID After Creating
    # Test Step:
    #..COLLECTION 1-3 sub level 3
    ${level}=    Set Variable    2
    : FOR    ${coll_id}    ${number_of_sub_coll}    IN    ${coll_id_1}    1    ${coll_id_1-1}
    ...    1    ${coll_id_1-2}    1    ${coll_id_1-3}    0
    \    ${response_item}=    Get Collection By Collection ID    ${coll_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Collection And Level from Response    ${response_item}    ${number_of_sub_coll}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Collections Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1
    #..COLLECTION 1-4 sub level 4
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-COLL1-1-3"    "${tc_number}-COLL1-1-4"
    ${response_1-4}=    Create Collection    ${coll_id_1-3}    ${file_data}
    ${coll_id_1-4}=    Get Collection ID After Creating
    # Test Step:
    #..COLLECTION 1-4 sub level 4
    ${level}=    Set Variable    2
    : FOR    ${coll_id}    ${number_of_sub_coll}    IN    ${coll_id_1}    1    ${coll_id_1-1}
    ...    1    ${coll_id_1-2}    1    ${coll_id_1-3}    1    ${coll_id_1-4}
    ...    0
    \    ${response_item}=    Get Collection By Collection ID    ${coll_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Collection And Level from Response    ${response_item}    ${number_of_sub_coll}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Collections Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1
    #..COLLECTION 1-5 sub level 5
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-COLL1-1-4"    "${tc_number}-COLL1-1-5"
    ${response_1-5}=    Create Collection    ${coll_id_1-4}    ${file_data}
    ${coll_id_1-5}=    Get Collection ID After Creating
    # Test Step:
    #..COLLECTION 1-5 sub level 5
    ${level}=    Set Variable    2
    : FOR    ${coll_id}    ${number_of_sub_coll}    IN    ${coll_id_1}    1    ${coll_id_1-1}
    ...    1    ${coll_id_1-2}    1    ${coll_id_1-3}    1    ${coll_id_1-4}
    ...    1    ${coll_id_1-5}    0
    \    ${response_item}=    Get Collection By Collection ID    ${coll_id}
    \    Verify Success Response Status Code and Message
    \    Verify Number of Sub Collection And Level from Response    ${response_item}    ${number_of_sub_coll}    ${level}
    \    ${data_item}=    Get Json Value and Convert to List    ${response_item}    /data
    \    Verify Collections Between Data From Response and DB    ${data_item}
    \    ${level}=    Evaluate    ${level}+1
    [Teardown]    Run Keywords    Run keyword If    "${coll_id_1-5}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1-5}
    ...    AND    Run keyword If    "${coll_id_1-4}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1-4}\
    ...    AND    Run keyword If    "${coll_id_1-3}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1-3}\
    ...    AND    Run keyword If    "${coll_id_1-2}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1-2}\
    ...    AND    Run keyword If    "${coll_id_1-1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1-1}\
    ...    AND    Run keyword If    "${coll_id_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1}

TC_iTM_04000 GET: /collections/:id - get collection by non-existing collection ID - fail 404
    [Tags]    fail    TC_iTM_04000    API_collection    ready    phoenix
    # Prerequisite: There is a collection
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
    ${non_coll_id}=    Evaluate    ${coll_id}+100
    # Test Step:
    ${response}=    Get Collection By Collection ID    ${non_coll_id}
    Verify Fail Response Status Code and Message    404    error    Not found collection

TC_iTM_04001 GET: /collections/:id - get collection that was deleted by collection ID - fail 404
    [Tags]    fail    TC_iTM_04001    API_collection    ready    phoenix
    # Prerequisite: There is a collection
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
    ${response}=    Get Collection By Collection ID    ${coll_id}
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    #.. delete collection
    Delete Collection By Collection ID    ${coll_id}
    ${response}=    Get Collection By Collection ID    ${coll_id}
    Verify Fail Response Status Code and Message    404    error    Not found collection

TC_iTM_04002 GET: /collections/:id - get collection by String - fail 400
    [Tags]    fail    TC_iTM_04002    API_collection    ready    phoenix
    # Prerequisite: There is a collection
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
    ${response}=    Get Collection By Collection ID    ${coll_id}
    Verify Success Response Status Code and Message
    ${response}=    Get Collection By Collection ID    ()_&
    Verify Fail Response Status Code and Message    400    error    Id should be number
    ${response}=    Get Collection By Collection ID    %20${coll_id}
    Verify Fail Response Status Code and Message    400    error    Id should be number
    ${response}=    Get Collection By Collection ID    ${SPACE}${coll_id}
    Verify Fail Response Status Code and Message    400    error    Id should be number
