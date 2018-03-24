*** Variables ***
${shop_name_empty}         -
${shop_code_empty}         -

*** Keywords ***
Get All Category Data from DB by Category pkey
    [Arguments]    ${cat_pkey}
	${id}=      Get Category ID from DB by Category pkey    ${cat_pkey}
	${code}=    Get Category Code from DB by Category pkey    ${cat_pkey}
	${name}=    Get Category Name from DB by Category pkey    ${cat_pkey}
	${name_trans}=        Get Category Name Translation from DB by Category pkey    ${cat_pkey}
	${slug}=              Get Category Slug from DB by Category pkey    ${cat_pkey}
    ${parent_id}=         Get Category Parent ID from DB by Category pkey    ${cat_pkey}
    # ${children_order}=    Get Category Children Order from DB by Category pkey    ${cat_pkey}
    ${owner}=             Get Category Owner from DB by Category pkey        ${cat_pkey}
    ${level}=                  Get Category Level from DB by Category pkey    ${cat_pkey}
    ${display}=                Get Category Display from DB by Category pkey    ${cat_pkey}
    ${status}=                 Get Category Status from DB by Category pkey    ${cat_pkey}
    ${image_url_desktop}=      Get Category Image URL Desktop from DB by Category pkey     ${cat_pkey}
    ${image_url_desktop_link}=      Get Category Image URL Desktop Link from DB by Category pkey     ${cat_pkey}
    ${alt_text_desktop}=       Get Category Alt Text Desktop from DB by Category pkey     ${cat_pkey}
    ${image_url_mobile}=       Get Category Image URL Mobile from DB by Category pkey     ${cat_pkey}
    ${image_url_mobile_link}=       Get Category Image URL Mobile Link from DB by Category pkey     ${cat_pkey}
    ${alt_text_mobile}=        Get Category Alt Text Mobile from DB by Category pkey     ${cat_pkey}
    ${owner_type}=             Get Category Owner Type from DB by Category pkey    ${cat_pkey}
    ${seo_id}=                 Get Category SEO ID from DB by Category pkey    ${cat_pkey}
    ${last_child_sequence}=    Get Category Last Child Sequence from DB by Category pkey    ${cat_pkey}
    ${sort_by}=                Get Category Sort By from DB by Category pkey    ${cat_pkey}
    ${created_at}=             Get Category Created At from DB by Category pkey    ${cat_pkey}
    ${updated_at}=             Get Category Updated At from DB by Category pkey    ${cat_pkey}
    ${deleted_at}=             Get Category Deleted At from DB by Category pkey    ${cat_pkey}
    ${display_option}=         Get Display Option from DB by Category pkey         ${cat_pkey}
    ${image_new_tab_option_desktop}=    Get Image New Tab Option Desktop from DB by Category pkey    ${cat_pkey}
    ${image_new_tab_option_mobile}=     Get Image New Tab Option Mobile from DB by Category pkey     ${cat_pkey}

    ${cat_db}=    Create Dictionary    id=${id}    category_code=${code}    category_name=${name}    category_name_translate=${name_trans}    slug=${slug}\
    ...    parent_id=${parent_id}    owner=${owner}    level=${level}    display=${display}    status=${status}    image_url_desktop=${image_url_desktop}\
    ...    image_url_desktop_link=${image_url_desktop_link}    alt_text_desktop=${alt_text_desktop}    image_url_mobile=${image_url_mobile}\
    ...    image_url_mobile_link=${image_url_mobile_link}    alt_text_mobile=${alt_text_mobile}    owner_type=${owner_type}    seo_id=${seo_id}\
    ...    last_child_sequence=${last_child_sequence}    sort_by=${sort_by}    created_at=${created_at}    updated_at=${updated_at}    deleted_at=${deleted_at}    display_option=${display_option}    image_new_tab_option_desktop=${image_new_tab_option_desktop}    image_new_tab_option_mobile=${image_new_tab_option_mobile}
    # Remove key that its value is null
    ${cat_db_items}=    Get Dictionary Items    ${cat_db}
    : FOR    ${key}    ${value}    IN    @{cat_db_items}
    \    Run Keyword If    "${value}"=="${null}"    Remove From Dictionary    ${cat_db}    ${key}
    # Remove nodes that are ignored to verified
    Remove From Dictionary    ${cat_db}    pkey    products    children    children_order
	Return From Keyword     ${cat_db}

Get Category ID from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_id}=    Query    SELECT id FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_id[0][0]}

Get Category Code from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_code}=    Query    SELECT category_code FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_code[0][0]}

Get Category Name from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_name}=    Query    SELECT category_name FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_name[0][0]}

Get Category Name Translation from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_name_trans}=    Query    SELECT category_name_translate FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_name_trans[0][0]}

Get Category Slug from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_slug}=    Query    SELECT slug FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_slug[0][0]}

Get Category Parent ID from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_parent_id}=    Query    SELECT parent_id FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_parent_id[0][0]}

Get Category Children Order from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_children_order}=    Query    SELECT children_order FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_children_order[0][0]}

Get Category Owner from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_owner}=    Query    SELECT owner FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_owner[0][0]}

Get Category Level from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_level}=    Query    SELECT level FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_level[0][0]}

Get Category Display from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_display}=    Query    SELECT display FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_display[0][0]}

Get Category Status from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_status}=    Query    SELECT status FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_status[0][0]}

Get Category Image URL Desktop from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_image_url_desktop}=    Query    SELECT image_url_desktop FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_image_url_desktop[0][0]}

Get Category Image URL Desktop Link from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_image_url_desktop_link}=    Query    SELECT image_url_desktop_link FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_image_url_desktop_link[0][0]}

Get Category Alt Text Desktop from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_alt_text_desktop}=    Query    SELECT alt_text_desktop FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_alt_text_desktop[0][0]}

Get Category Image URL Mobile from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_image_url_mobile}=    Query    SELECT image_url_mobile FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_image_url_mobile[0][0]}

Get Category Image URL Mobile Link from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_image_url_mobile_link}=    Query    SELECT image_url_mobile_link FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_image_url_mobile_link[0][0]}

Get Category Alt Text Mobile from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_alt_text_mobile}=    Query    SELECT alt_text_mobile FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_alt_text_mobile[0][0]}

Get Category Owner Type from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_owner_type}=    Query    SELECT owner_type FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_owner_type[0][0]}

Get Category SEO ID from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_seo_id}=    Query    SELECT seo_id FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_seo_id[0][0]}

Get Category Last Child Sequence from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_last_child_sequence}=    Query    SELECT last_child_sequence FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_last_child_sequence[0][0]}

Get Category Sort By from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_sort_by}=    Query    SELECT sort_by FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_sort_by[0][0]}

Get Category Created At from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_created_at}=    Query    SELECT created_at FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_created_at[0][0]}

Get Category Updated At from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_updated_at}=    Query    SELECT updated_at FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_updated_at[0][0]}

Get Category Deleted At from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
	${cat_deleted_at}=    Query    SELECT deleted_at FROM `pds_categories` where `pkey` = '${cat_pkey}'
	Disconnect From Database
    Return From Keyword     ${cat_deleted_at[0][0]}

Get Number of Categories in DB
    Connect DB ITM
    ${number_of_cat}=    Query    SELECT COUNT(*) AS NumberOfCat FROM `pds_categories` where `deleted_at` IS NULL
	Disconnect From Database
	${number_of_cat_no_root}=    Evaluate    ${number_of_cat[0][0]}-1
    Return From Keyword     ${number_of_cat_no_root}

Get Category Children of Root from DB
    Connect DB ITM
	${root_cat_children}=    Query    SELECT children_order FROM `pds_categories` where `id` = '1'
	Disconnect From Database
    Return From Keyword     ${root_cat_children[0][0]}

Get Category Children Order of Root from DB
    Connect DB ITM
    ${root_cat_children_order}=    Query    SELECT children_order FROM `pds_categories` where `id` = '1'
    Disconnect From Database
    ${result}=    Split String     ${root_cat_children_order[0][0]}    ,
    Return From Keyword     ${result}

Get Display Option from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_display_option}=    Query    SELECT display_option FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_display_option[0][0]}

Get Image New Tab Option Desktop from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_image_new_tab_option_desktop}=    Query    SELECT image_new_tab_option_desktop FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_image_new_tab_option_desktop[0][0]}

Get Image New Tab Option Mobile from DB by Category pkey
    [Arguments]    ${cat_pkey}
    Connect DB ITM
    ${cat_image_new_tab_option_mobile}=    Query    SELECT image_new_tab_option_mobile FROM `pds_categories` where `pkey` = '${cat_pkey}'
    Disconnect From Database
    Return From Keyword     ${cat_image_new_tab_option_mobile[0][0]}

Get Category and Product Relation from DB by Category ID and Product ID
    [Arguments]    ${cat_id}    ${product_id}
    Connect DB ITM
    ${relation_id}=    Query    SELECT left_id, right_id FROM `pds_categories_products` where `left_id` = '${cat_id}' AND `right_id` = '${product_id}'
    Disconnect From Database
    ${cat_id_valid}=        Run Keyword and return status    Set Variable    ${relation_id[0][0]}
    ${product_id_valid}=    Run Keyword and return status    Set Variable    ${relation_id[0][1]}
    ${return_cat_id}=        Set Variable If    ${cat_id_valid}        ${relation_id[0][0]}    ${EMPTY}
    ${return_product_id}=    Set Variable If    ${product_id_valid}    ${relation_id[0][1]}    ${EMPTY}
    Return From Keyword    ${return_cat_id}    ${return_product_id}
