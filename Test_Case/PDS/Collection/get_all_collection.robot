*** Setting ***
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

*** Test Cases ***
TC_iTM_03992 GET: /collections - get all collections - success 200
    [Tags]    success    API_collection    TC_iTM_03992    ready    phoenix
    # Prerequisite: There are some collections on system
    ${coll_id_1}=    Set Variable    ${EMPTY}
    ${coll_id_2}=    Set Variable    ${EMPTY}
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
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}-1"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_1}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1"    "${tc_number}-2"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_2}=    Get Collection ID After Creating
    ${response}=    Get All Collection
    Verify Success Response Status Code and Message
    Verify Response Data From Get All Collections
    [Teardown]    Run Keywords    Run keyword If    "${coll_id_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1}
    ...    AND    Run keyword If    "${coll_id_2}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_2}

TC_iTM_03993 GET: /collections - get empty collection - success 200
    [Tags]    success    API_collection    TC_iTM_03993    ready
    # Prerequisite: There is no any collection on system
    ${response}=    Get All Collection
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Collections
