*** Settings ***
Library         Collections
Library         String
Library         ${CURDIR}/../../../../Python_Library/common.py
Library         ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library         ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Library         ${CURDIR}/../../../../Python_Library/collection.py
Resource        web_element_product_set_collection.robot

*** Keywords ***
Collections - Go To Collections Management Page
    Go to       ${PCMS_URL}/${manage_collection_url_path}

Collections - Go To Product In Collection
    [Arguments]    ${product_row}=1
    Click Element   //*[@class="mws-datatable-fn mws-table"]/tbody/tr[${product_row}]/td[4]/a[text()="Products"]

Go to mass upload menu
    Wait Until Element Is Visible    ${collection_menu}    20s
    Click Element    ${collection_menu}
    Wait Until Element Is Visible    ${mass_upload_menu}    20s
    Click Element    ${mass_upload_menu}
    Wait Until Element Is Visible    ${text_menu}    20s
    Location Should Contain    ${PCMS_URL}/collections-products
    ${get_text}=    Get Text    ${text_menu}
    Should Be Equal    ${get_text}    Mass Upload

Collections - Create collection by collection collectionkey
    [Arguments]    ${CollectionPkey}    ${CollectionName}
    ${total_row_colelction}=    Create_Product.Get collection row    ${CollectionPkey}
    Log To Console    insert coll log=${total_row_colelction}
    Run Keyword If    ${total_row_colelction} == 0
    ...    Run Keywords    Log To Console     insert collection
    ...    AND    Collections - Create category and collection for product collection    ${CollectionPkey}    ${CollectionName}

Collections - Create category and collection for product collection
    [Arguments]    ${CollectionPkey}    ${CollectionName}
    ${categoryId}=    Set Variable    C${CollectionPkey}
    ${collection_id}=    Create category and collection with param     0    ${CollectionPkey}    ${CollectionName}    mass-insert-product    0    ${categoryId}    2
    [Return]    ${collection_id}

Set product key in file csv product collection
    [Arguments]    ${data}
    ${path_file}=     Set Variable     ${CURDIR}/../../../../Resource/TestData/Product/csv_file/export_product_collection_up.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]     ${path_file}

User browse file for upload product to cate
    [Arguments]    ${file_upload}
    ${canonicalPath}=    common.Get Canonical Path    ${file_upload}
    Choose File    ${browse_file}    ${canonicalPath}
    Location Should Contain    ${PCMS_URL}/collections-products/verify

Choose product link in collection has alias
    Wait Until Element Is Visible    ${text_menu}    30s
    Click Element    ${choose_product_has_alias}

Choose product link in collection has not alias
    Wait Until Element Is Visible    ${text_menu}    30s
    Click Element    ${choose_product_has_not_alias}

Create category and collection with param
    [Arguments]    ${parent_id}    ${pkey}    ${collection_name}    ${slug}    ${is_category}    ${category_id}
    ...    ${pds_collection}
    ${parent_id}=    Convert To Integer    ${parent_id}
    ${pkey}=    Convert To Integer    ${pkey}
    ${collection_id}=    collection.create_collection    ${parent_id}    ${pkey}    ${collection_name}    ${slug}    ${is_category}
    ...    ${category_id}    ${pds_collection}
    [Return]    ${collection_id}
