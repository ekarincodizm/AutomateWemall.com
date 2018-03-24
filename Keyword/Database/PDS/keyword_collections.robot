*** Variables ***
${shop_name_empty}         -
${shop_code_empty}         -

*** Keywords ***
Get All Collection Data from DB by Collection pkey
    [Arguments]    ${coll_pkey}
	${id}=      Get Collection ID from DB by Collection pkey    ${coll_pkey}
	${code}=    Get Collection Code from DB by Collection pkey    ${coll_pkey}
	${name}=    Get Collection Name from DB by Collection pkey    ${coll_pkey}
	${name_trans}=        Get Collection Name Translation from DB by Collection pkey    ${coll_pkey}
	${slug}=              Get Collection Slug from DB by Collection pkey    ${coll_pkey}
    ${parent_id}=         Get Collection Parent ID from DB by Collection pkey    ${coll_pkey}
    # ${children_order}=    Get Collection Children Order from DB by Collection pkey    ${coll_pkey}
    ${owner}=             Get Collection Owner from DB by Collection pkey    ${coll_pkey}
    ${level}=                  Get Collection Level from DB by Collection pkey    ${coll_pkey}
    ${display}=                Get Collection Display from DB by Collection pkey    ${coll_pkey}
    ${status}=                 Get Collection Status from DB by Collection pkey    ${coll_pkey}
    ${image_url}=              Get Collection Image URL from DB by Collection pkey    ${coll_pkey}
    ${owner_type}=             Get Collection Owner Type from DB by Collection pkey    ${coll_pkey}
    ${seo_id}=                 Get Collection SEO ID from DB by Collection pkey    ${coll_pkey}
    ${created_at}=             Get Collection Created At from DB by Collection pkey    ${coll_pkey}
    ${updated_at}=             Get Collection Updated At from DB by Collection pkey    ${coll_pkey}
    ${deleted_at}=             Get Collection Deleted At from DB by Collection pkey    ${coll_pkey}
    ${coll_db}=    Create Dictionary    id=${id}    collection_code=${code}    collection_name=${name}    collection_name_translate=${name_trans}    slug=${slug}\
    ...    parent_id=${parent_id}        owner=${owner}    level=${level}    display=${display}    status=${status}    image_url=${image_url}\
    ...    owner_type=${owner_type}    seo_id=${seo_id}    created_at=${created_at}    updated_at=${updated_at}    deleted_at=${deleted_at}
    # Remove key that its value is null
    ${coll_db_items}=    Get Dictionary Items    ${coll_db}
    : FOR    ${key}    ${value}    IN    @{coll_db_items}   
    \    Run Keyword If    "${value}"=="${null}"    Remove From Dictionary    ${coll_db}    ${key}
    # Remove nodes that are ignored to verified 
    Remove From Dictionary    ${coll_db}    pkey    products    children
	Return From Keyword     ${coll_db}

Get Collection ID from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_id}=    Query    SELECT id FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_id[0][0]}

Get Collection Code from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_code}=    Query    SELECT collection_code FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_code[0][0]}

Get Collection Name from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_name}=    Query    SELECT collection_name FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_name[0][0]}

Get Collection Name Translation from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_name_trans}=    Query    SELECT collection_name_translate FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_name_trans[0][0]}

Get Collection Slug from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_slug}=    Query    SELECT slug FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_slug[0][0]}

Get Collection Parent ID from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_parent_id}=    Query    SELECT parent_id FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_parent_id[0][0]}

Get Collection Children Order from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_children_order}=    Query    SELECT children_order FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_children_order[0][0]}

Get Collection Owner from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_owner}=    Query    SELECT owner FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_owner[0][0]}

Get Collection Level from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_level}=    Query    SELECT level FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_level[0][0]}

Get Collection Display from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_display}=    Query    SELECT display FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_display[0][0]}

Get Collection Status from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_status}=    Query    SELECT status FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_status[0][0]}

Get Collection Image URL from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_image_url}=    Query    SELECT image_url FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_image_url[0][0]}

Get Collection Owner Type from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_owner_type}=    Query    SELECT owner_type FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_owner_type[0][0]}

Get Collection SEO ID from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_seo_id}=    Query    SELECT seo_id FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_seo_id[0][0]}

Get Collection Created At from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_created_at}=    Query    SELECT created_at FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_created_at[0][0]}

Get Collection Updated At from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_updated_at}=    Query    SELECT updated_at FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_updated_at[0][0]}

Get Collection Deleted At from DB by Collection pkey
    [Arguments]    ${coll_pkey}
    Connect DB ITM
	${coll_deleted_at}=    Query    SELECT deleted_at FROM `pds_collections` where `pkey` = '${coll_pkey}'
	Disconnect From Database
    Return From Keyword     ${coll_deleted_at[0][0]}

Get Number of Collections in DB
    Connect DB ITM
    ${number_of_coll}=    Query    SELECT COUNT(*) AS NumberOfColl FROM `pds_collections` where `deleted_at` IS NULL
	Disconnect From Database
	${number_of_coll_no_root}=    Evaluate    ${number_of_coll[0][0]}-1
    Return From Keyword     ${number_of_coll_no_root}
