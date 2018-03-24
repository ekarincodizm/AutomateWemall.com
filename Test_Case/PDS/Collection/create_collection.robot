*** Setting ***
Test Teardown     Run keyword If    "${coll_id}" != "${EMPTY}"    Run Keywords    Log    ${coll_id}
...               AND    Permanent Delete Collection By Collection ID    ${coll_id}
Force Tags        PDS_Collection_and_Merchant
Library           HttpLibrary.HTTP
Library           BuiltIn
Library           String
Library           OperatingSystem
Library           Collections
Library           DateTime
Library           DatabaseLibrary
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot

*** Variables ***
${json_create_collection}    ${CURDIR}/../../../Resource/Json/pds/create_collection.json
${parent_id}      1
${50_chars}       12345678901234567890123456789012345678901234567890
${100_chars}      ${50_chars}${50_chars}
${255_chars}      ${100_chars}${100_chars}${50_chars}12345
${img_url}        //cdn-p2.itruemart.com/pcms/uploads/14-11-13/6fc3fcc11d6f6f176261ad8d7646d765_xl.jpg
${coll_id}        ${EMPTY}

*** Test Cases ***
TC_iTM_03858 - Create Collection: all valid data - success
    [Documentation]    To verify collection will be created successfully when sending request with all data excluding related children fields
    [Tags]    success    API_collection    TC_iTM_03858    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields with value
    ${file_data}=    Replace String    ${file_data}    ^^collection_name_translate^^    "trans${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^slug^^    "slug${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^display^^    "0"
    ${file_data}=    Replace String    ${file_data}    ^^data_image_url^^    "${img_url}"
    ${file_data}=    Replace String    ${file_data}    ^^seo_id^^,    1
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Log To Console    ${coll_id}
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${collection_name_translate}=    Get From Dictionary    ${data}    collection_name_translate
    ${slug}=    Get From Dictionary    ${data}    slug
    ${status}=    Get From Dictionary    ${data}    status
    ${display}=    Get From Dictionary    ${data}    display
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${image_url}=    Get From Dictionary    ${data}    image_url
    ${seo_id}=    Get From Dictionary    ${data}    seo_id
    ${seo_id_int}=    Convert To Integer    1
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${collection_name_translate}    trans${tc_number}
    Should Be Equal    ${slug}    slug${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${display}    0
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${image_url}    ${img_url}
    Should Be Equal    ${seo_id}    ${seo_id_int}

TC_iTM_03860 Create Collection: mandatory valid data - success
    [Documentation]    To verify collection will be created successfully when sending request with mandatory data
    [Tags]    success    TC_iTM_03860    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ## optional fields with value
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    active
    Should Be Equal    ${owner}    ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${MERCHANT_TYPE}

TC_iTM_03861 Create Collection: defualt display is 0 - success
    [Documentation]    To verify collection will be created successfully when sending request with display field is 0
    [Tags]    success    TC_iTM_03861    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ## optional fields with value
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${display}=    Get From Dictionary    ${data}    display
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    active
    Should Be Equal    ${display}    0
    Should Be Equal    ${owner}    ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${MERCHANT_TYPE}

TC_iTM_03862 Create Collection: display is 1 - success
    [Documentation]    To verify collection will be created successfully when sending request with display field is 1
    [Tags]    success    TC_iTM_03862    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ## optional fields with value
    ${file_data}=    Replace String    ${file_data}    ^^display^^    "1"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${display}=    Get From Dictionary    ${data}    display
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    active
    Should Be Equal    ${display}    1
    Should Be Equal    ${owner}    ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${MERCHANT_TYPE}

TC_iTM_03863 Create Collection: status is active - success
    [Documentation]    To verify collection will be created successfully when sending request with status field is active
    [Tags]    success    TC_iTM_03863    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ## optional fields with value
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    active
    Should Be Equal    ${owner}    ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${MERCHANT_TYPE}

TC_iTM_03864 Create Collection: status is inactive - success
    [Documentation]    To verify collection will be created successfully when sending request with status field is inactive
    [Tags]    success    TC_iTM_03864    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    log to console    data_json=${file_data}
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    Log To Console    data=${data}
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${MERCHANT_TYPE}

TC_iTM_03865 Create Collection: owner_type is merchant - success
    [Documentation]    To verify collection will be created successfully when sending request with owner_type field is merchant
    [Tags]    success    TC_iTM_03865    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${collection_code}=    Get From Dictionary    ${data}    collection_code
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${MERCHANT_TYPE}
    Verify format code    ${MERCHANT_TYPE}    collection    ${collection_code}

TC_iTM_03866 Create Collection: owner_type is alias - success
    [Documentation]    To verify collection will be created successfully when sending request with owner_type field is alias
    [Tags]    success    TC_iTM_03866    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    ${collection_code}=    Get From Dictionary    ${data}    collection_code
    Verify format code    ${ALIAS_MERCHANT_TYPE}    collection    ${collection_code}

TC_iTM_03867 Create Collection: collection_name_translate is empty - Success
    [Documentation]    To verify collection will be created successfully when sending request with collection_name_translate field is empty
    [Tags]    success    TC_iTM_03867    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^collection_name_translate^^    ""
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${collection_name_translate}=    Get From Dictionary    ${data}    collection_name_translate
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${collection_name_translate}    ${EMPTY}

TC_iTM_03868 Create Collection: collection_name_translate is whitespace - Success
    [Documentation]    To verify collection will be created successfully when sending request with collection_name_translate field is whitespace
    [Tags]    success    TC_iTM_03868    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^collection_name_translate^^    " "
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${collection_name_translate}=    Get From Dictionary    ${data}    collection_name_translate
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${collection_name_translate}    ${SPACE}

TC_iTM_03869 Create Collection: collection_name_translate is null - Success
    [Documentation]    To verify collection will be created successfully when sending request with collection_name_translate field is null
    [Tags]    success    TC_iTM_03869    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^collection_name_translate^^    null
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Dictionary Should Not Contain Key    ${data}    collection_name_translate

TC_iTM_03871 Create Collection: slug is empty - Success
    [Documentation]    To verify collection will be created successfully when sending request with slug field is empty
    [Tags]    success    TC_iTM_03871    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^slug^^    "${EMPTY}"
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${slug}=    Get From Dictionary    ${data}    slug
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${slug}    ${EMPTY}

TC_iTM_03872 Create Collection: slug is whitespace - Success
    [Documentation]    To verify collection will be created successfully when sending request with slug field is whitespace
    [Tags]    success    TC_iTM_03872    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^slug^^    " "
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${slug}=    Get From Dictionary    ${data}    slug
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${slug}    ${SPACE}

TC_iTM_03873 Create Collection: slug is null - Success
    [Documentation]    To verify collection will be created successfully when sending request with slug field is null
    [Tags]    success    TC_iTM_03873    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^slug^^    null
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Dictionary Should Not Contain Key    ${data}    slug

TC_iTM_03883 Create Collection: image_url is empty - Success
    [Documentation]    To verify collection will be created successfully when sending request with image_url field is empty
    [Tags]    success    TC_iTM_03883    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^data_image_url^^,    "${EMPTY}"
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${image_url}=    Get From Dictionary    ${data}    image_url
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${image_url}    ${EMPTY}

TC_iTM_03884 Create Collection: image_url is whitespace - Success
    [Documentation]    To verify collection will be created successfully when sending request with image_url field is whitespace
    [Tags]    success    TC_iTM_03884    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^data_image_url^^,    " "
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    ${image_url}=    Get From Dictionary    ${data}    image_url
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${image_url}    ${SPACE}

TC_iTM_03885 Create Collection: image_url is null - Success
    [Documentation]    To verify collection will be created successfully when sending request with image_url field is null
    [Tags]    success    TC_iTM_03885    API_collection    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "inactive"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${ALIAS_MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^    "${ALIAS_MERCHANT_TYPE}"
    ## optional fields
    ${file_data}=    Replace String    ${file_data}    ^^data_image_url^^,    null
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${data}=    Get Json Value and Convert to List    ${response}    /data
    ${collection_name}=    Get From Dictionary    ${data}    collection_name
    ${status}=    Get From Dictionary    ${data}    status
    ${owner}=    Get From Dictionary    ${data}    owner
    ${owner_type}=    Get From Dictionary    ${data}    owner_type
    Should Be Equal    ${collection_name}    ${tc_number}
    Should Be Equal    ${status}    inactive
    Should Be Equal    ${owner}    ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}    ${ALIAS_MERCHANT_TYPE}
    Dictionary Should Not Contain Key    ${data}    image_url

TC_iTM_03898 - Create Collection: collection_name is empty - Fail
    [Tags]    Fail    API_collection    TC_iTM_03898    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    ""
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Collection name should not be empty

TC_iTM_03899 - Create Collection: collection_name is whitespace - Fail
    [Tags]    Fail    API_collection    TC_iTM_03899    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${SPACE}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Collection name should not be empty

TC_iTM_03900 - Create Collection: collection_name is null - Fail
    [Tags]    Fail    API_collection    TC_iTM_03900    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    null
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Collection name field should not be null

TC_iTM_03901 - Create Collection: collection_name more 255 characters - Fail
    [Tags]    Fail    API_collection    TC_iTM_03901    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${255_chars}1"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Collection name length should be less than or equal 255

TC_iTM_03902 - Create Collection: not found collection_name - Fail
    [Tags]    Fail    API_collection    TC_iTM_03902    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${file_data}=    Remove String    ${file_data}    "collection_name":^^collection_name^^,
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Collection name field is missing

TC_iTM_03903 - Create Collection: collection_name_translate more 255 characters - Fail
    [Tags]    Fail    API_collection    TC_iTM_03903    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^collection_name_translate^^    "${255_chars}1"
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Collection name translation length should be less than or equal 255

TC_iTM_03904 - Create Collection: slug more 255 characters - Fail
    [Tags]    Fail    API_collection    TC_iTM_03904    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Replace String    ${file_data}    ^^slug^^    "${255_chars}1"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Slug length should be less than or equal 255

TC_iTM_03905 - Create Collection: parent_id non-exist on system - Fail
    [Tags]    Fail    API_collection    TC_iTM_03905    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    100000000001    ${file_data}
    Verify Fail Response Status Code and Message    404    error    Not found parent collection !

TC_iTM_03906 - Create Collection: parent_id is whitespace - Fail
    [Tags]    Fail    API_collection    TC_iTM_03906    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${SPACE}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Id should be number

TC_iTM_03908 - Create Collection: parent_id is empty - Fail
    [Tags]    Fail    API_collection    TC_iTM_03908    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${EMPTY}    ${file_data}
    Response Status Code Should Equal    404

TC_iTM_03909 - Create Collection: parent_id is out of boundary - Fail
    [Tags]    Fail    API_collection    TC_iTM_03909    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    0    ${file_data}
    Verify Fail Response Status Code and Message    404    error    Not found parent collection !
    ${response}=    Create Collection    -1    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Id should be number

TC_iTM_03910 - Create Collection: parent_id is string - Fail
    [Tags]    Fail    API_collection    TC_iTM_03910    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    A    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Id should be number

TC_iTM_03911 - Create Collection: owner is empty - Fail
    [Tags]    Fail    API_collection    TC_iTM_03911    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    ""
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner should not be empty

TC_iTM_03912 - Create Collection: owner is whitespace - Fail
    [Tags]    Fail    API_collection    TC_iTM_03912    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${SPACE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner should not be empty

TC_iTM_03913 - Create Collection: owner is null - Fail
    [Tags]    Fail    API_collection    TC_iTM_03913    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    null
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner field should not be null

TC_iTM_03915 - Create Collection: not found owner - Fail
    [Tags]    Fail    API_collection    TC_iTM_03915    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "owner":^^owner^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner field is missing

TC_iTM_03916 - Create Collection: display is not 0 or 1 - Fail
    [Tags]    Fail    API_collection    TC_iTM_03916    ready    phoenix
    ## display : -1
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^display^^    "-1"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1
    ## display : 2
    ${file_data}=    Replace String    ${file_data}    display:"-1"    display:"2"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1
    ## display : true
    ${file_data}=    Replace String    ${file_data}    display:"2"    display:"true"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1
    ## display : 100
    ${file_data}=    Replace String    ${file_data}    display:"true"    display:"100"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1

TC_iTM_03917 - Create Collection: status is not 'active' or 'inactive' - Fail
    [Tags]    Fail    API_collection    TC_iTM_03917    ready    phoenix
    ## status : 1
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "1"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive
    ## status : true
    ${file_data}=    Replace String    ${file_data}    status:"1"    status:"true"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive
    ## status : actively
    ${file_data}=    Replace String    ${file_data}    status:"true"    status:"actively"
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_iTM_03918 - Create Collection: owner_type is empty - Fail
    [Tags]    Fail    API_collection    TC_iTM_03918    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${EMPTY}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type must be one of merchant, alias

TC_iTM_03919 - Create Collection: owner_type is whitespace - Fail
    [Tags]    Fail    API_collection    TC_iTM_03919    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${SPACE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type must be one of merchant, alias

TC_iTM_03921 - Create Collection: owner_type is null - Fail
    [Tags]    Fail    API_collection    TC_iTM_03921    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    null
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type field should not be null

TC_iTM_03922 - Create Collection: owner_type is not 'merchant' or 'alias' - Fail
    [Tags]    Fail    API_collection    TC_iTM_03922    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "AAA"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type must be one of merchant, alias

TC_iTM_03923 - Create Collection: seo_id is out of boundary
    [Tags]    Fail    API_collection    TC_iTM_03923    ready    phoenix
    ## seo_id : 0
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Replace String    ${file_data}    ^^seo_id^^,    0
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Seo id should more than 0
    ## seo_id : -1
    ${file_data}=    Replace String    ${file_data}    seo_id:0    seo_id:-1
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Seo id should more than 0

TC_iTM_03924 - Create Collection: seo_id is string - Fail
    [Tags]    Fail    API_collection    TC_iTM_03924    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Replace String    ${file_data}    ^^seo_id^^,    "AAA"
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Seo id should be a number

TC_iTM_03879 - Create Collection: status is empty - Fail
    [Tags]    Fail    API_collection    TC_iTM_03879    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "${EMPTY}"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_iTM_03880 - Create Collection: status is whitespace - Fail
    [Tags]    Fail    API_collection    TC_iTM_03880    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "${SPACE}"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_iTM_03881 - Create Collection: status is null - Fail
    [Tags]    Fail    API_collection    TC_iTM_03881    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    null
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status field should not be null

TC_iTM_03882 - Create Collection: not found status - Fail
    [Tags]    Fail    API_collection    TC_iTM_03882    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "status":^^status^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status field is missing

TC_iTM_03945 - Create Collection: more than 6 level(lv 7) - Fail
    [Tags]    Fail    API_collection    TC_iTM_03945    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Get File    ${json_create_collection}
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}-1"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id_1}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1"    "${tc_number}-1-2"
    ${response}=    Create Collection    ${coll_id_1}    ${file_data}
    ${coll_id_1_2}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2"    "${tc_number}-1-2-3"
    ${response}=    Create Collection    ${coll_id_1_2}    ${file_data}
    ${coll_id_1_2_3}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2-3"    "${tc_number}-1-2-3-4"
    ${response}=    Create Collection    ${coll_id_1_2_3}    ${file_data}
    ${coll_id_1_2_3_4}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2-3-4"    "${tc_number}-1-2-3-4-5"
    ${response}=    Create Collection    ${coll_id_1_2_3_4}    ${file_data}
    ${coll_id_1_2_3_4_5}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2-3-4-5"    "${tc_number}-1-2-3-4-5-6"
    ${response}=    Create Collection    ${coll_id_1_2_3_4_5}    ${file_data}
    ${coll_id_1_2_3_4_5_6}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2-3-4-5-6"    "${tc_number}-1-2-3-4-5-6-7"
    ${response}=    Create Collection    ${coll_id_1_2_3_4_5_6}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Cannot create collection under collection level 6
    [Teardown]    Run Keywords    Run keyword If    "${coll_id_1_2_3_4_5_6}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3_4_5_6}
    ...    AND    Run keyword If    "${coll_id_1_2_3_4_5}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3_4_5}\
    ...    AND    Run keyword If    "${coll_id_1_2_3_4}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3_4}\
    ...    AND    Run keyword If    "${coll_id_1_2_3}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3}\
    ...    AND    Run keyword If    "${coll_id_1_2}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2}\
    ...    AND    Run keyword If    "${coll_id_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1}

TC_iTM_03859 - Create Collection: Lv1 to Lv.6 - success
    [Tags]    Fail    API_collection    TC_iTM_03859    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Get File    ${json_create_collection}
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}-1"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${coll_id_1}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1"    "${tc_number}-1-2"
    ${response}=    Create Collection    ${coll_id_1}    ${file_data}
    Verify Success Response Status Code and Message
    ${coll_id_1_2}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2"    "${tc_number}-1-2-3"
    ${response}=    Create Collection    ${coll_id_1_2}    ${file_data}
    Verify Success Response Status Code and Message
    ${coll_id_1_2_3}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2-3"    "${tc_number}-1-2-3-4"
    ${response}=    Create Collection    ${coll_id_1_2_3}    ${file_data}
    Verify Success Response Status Code and Message
    ${coll_id_1_2_3_4}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2-3-4"    "${tc_number}-1-2-3-4-5"
    ${response}=    Create Collection    ${coll_id_1_2_3_4}    ${file_data}
    Verify Success Response Status Code and Message
    ${coll_id_1_2_3_4_5}=    Get Collection ID After Creating
    ${file_data}=    Replace String    ${file_data}    "${tc_number}-1-2-3-4-5"    "${tc_number}-1-2-3-4-5-6"
    ${response}=    Create Collection    ${coll_id_1_2_3_4_5}    ${file_data}
    Verify Success Response Status Code and Message
    ${coll_id_1_2_3_4_5_6}=    Get Collection ID After Creating
    [Teardown]    Run Keywords    Run keyword If    "${coll_id_1_2_3_4_5_6}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3_4_5_6}
    ...    AND    Run keyword If    "${coll_id_1_2_3_4_5}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3_4_5}\
    ...    AND    Run keyword If    "${coll_id_1_2_3_4}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3_4}\
    ...    AND    Run keyword If    "${coll_id_1_2_3}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2_3}\
    ...    AND    Run keyword If    "${coll_id_1_2}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1_2}\
    ...    AND    Run keyword If    "${coll_id_1}" != "${EMPTY}"    Permanent Delete Collection By Collection ID    ${coll_id_1}

TC_iTM_03875 - Create Collection: display is empty - Fail
    [Tags]    Fail    API_collection    TC_iTM_03875    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^display^^    "${EMPTY}"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1

TC_iTM_03876 - Create Collection: display is whitespace - Fail
    [Tags]    Fail    API_collection    TC_iTM_03876    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^display^^    "${SPACE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1

TC_iTM_03877 - Create Collection: display is null - Success
    [Tags]    success    API_collection    TC_iTM_03877    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^display^^    null
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${display}=    Get Json Value    ${response}    /data/display
    Should Be Equal    ${display}    "0"

TC_iTM_03878 - Create Collection: not found display - Success
    [Tags]    success    API_collection    TC_iTM_03878    ready    phoenix
    ${file_data}=    Get File    ${json_create_collection}
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${file_data}=    Replace String    ${file_data}    ^^collection_name^^    "${tc_number}"
    ${file_data}=    Replace String    ${file_data}    ^^status^^    "active"
    ${file_data}=    Replace String    ${file_data}    ^^owner^^    "${MERCHANT_CODE}"
    ${file_data}=    Replace String    ${file_data}    ^^owner_type^^,    "${MERCHANT_TYPE}"
    ## optional fields with value
    ${file_data}=    Remove String    ${file_data}    "collection_name_translate":^^collection_name_translate^^,
    ${file_data}=    Remove String    ${file_data}    "pkey": ^^pkey^^,
    ${file_data}=    Remove String    ${file_data}    "collection_code":^^collection_code^^,
    ${file_data}=    Remove String    ${file_data}    "slug":^^slug^^,
    ${file_data}=    Remove String    ${file_data}    "display":^^display^^,
    ${file_data}=    Remove String    ${file_data}    "image_url":^^data_image_url^^,
    ${file_data}=    Remove String    ${file_data}    "seo_id":^^seo_id^^,
    ${file_data}=    Remove String    ${file_data}    "children_order":[^^children_order_list^^]
    ${response}=    Create Collection    ${parent_id}    ${file_data}
    ${coll_id}=    Get Collection ID After Creating
    Verify Success Response Status Code and Message
    ${display}=    Get Json Value    ${response}    /data/display
    Should Be Equal    ${display}    "0"
