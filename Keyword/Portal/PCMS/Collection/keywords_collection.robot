*** Settings ***
Library         Collections
Library         String
Library         ${CURDIR}/keywords_collection.py
Resource        ${CURDIR}/web_element_collection.robot

*** Keywords ***
Collections - Go To Collections Management Page
    Go to       ${PCMS_URL}/${manage_collection_url_path}

Collections - Go To Product In Collection
    [Arguments]    ${product_row}=1
    Click Element   //*[@class="mws-datatable-fn mws-table"]/tbody/tr[${product_row}]/td[4]/a[text()="Products"]

Collections - Check Collection By Name
    [Arguments]     ${colection_name}
    ${collections_data}=    Collections - Get Collections Data From Table
    ${found_data}=      Set Variable    0
    ${total}=           Get Length    ${collections_data}
    :FOR    ${index}     IN Range    0       ${total}
    \       ${data}=        Get From List    ${collections_data}    ${index}
    \       ${name}=        Get From Dictionary     ${data}     name
    \       ${name}=                Replace String      ${name}                 '       Empty
    \       ${colection_name}=      Replace String      ${colection_name}       '       Empty
    \       ${found_data}=      Set Variable If
    \       ...                 '${name}'=='${colection_name}'      1
    \       Run Keyword If      '${name}'=='${colection_name}'      Exit For Loop
    [Return]    ${found_data}

Choose product link in collection has alias
    Wait Until Element Is Visible    ${text_menu}    30s
    Click Element    ${choose_product_has_alias}

Choose product link in collection has not alias
    Wait Until Element Is Visible    ${text_menu}    30s
    Click Element    ${choose_product_has_not_alias}

Collections - Get Collection Data By Name
    [Arguments]     ${colection_name}
    ${collections_data}=    Collections - Get Collections Data From Table
    ${collection_data}=      Set Variable    Empty
    ${total}=           Get Length    ${collections_data}
    :FOR    ${index}     IN Range    0       ${total}
    \       ${data}=        Get From List    ${collections_data}    ${index}
    \       ${name}=        Get From Dictionary     ${data}     name
    \       ${name}=                Replace String      ${name}                 '       Empty
    \       ${colection_name}=      Replace String      ${colection_name}       '       Empty
    \       ${collection_data}=      Set Variable If
    \       ...                 '${name}'=='${colection_name}'      ${data}
    \       Run Keyword If      '${name}'=='${colection_name}'      Exit For Loop
    [Return]    ${collection_data}

Collections - Get Collections Data From Table
    sleep    1s
    ${status}=     Run Keyword And Return Status       Page Should Contain Element     ${table_collections} tbody>tr
    Run Keyword And Return If       '${status}' == 'True'    Collections - Get Collections Raw Data From Table
    Run Keyword And Return If       '${status}' != 'True'    Create List

Collections - Get Collections Raw Data From Table
    ${collections_list}=    Create List
    ${list}=    Get Webelements     ${table_collections} tbody>tr
    ${rows}=    Get Length    ${list}

    : FOR    ${index}    IN RANGE    0    ${rows}
    \    ${name}=    Get Text    ${table_collections} tbody>tr:eq(${index}) td:eq(0)
    \    ${collection_key}=    Get Text    ${table_collections} tbody>tr:eq(${index}) td:eq(2)
    \    ${collection_edit_link}=    Selenium2Library.Get Element Attribute    ${table_collections} tbody>tr:eq(${index}) td:eq(3) a:contains('Edit')@href
    \    ${collection_product_link}=    Selenium2Library.Get Element Attribute    ${table_collections} tbody>tr:eq(${index}) td:eq(3) a:contains('Products')@href
    \    ${sub_collection_link}=    Selenium2Library.Get Element Attribute    ${table_collections} tbody>tr:eq(${index}) td:eq(4) a@href
    \    ${data}=    Create Dictionary      name=${name}
    \    ...                                key=${collection_key}
    \    ...                                edit_link=${collection_edit_link}
    \    ...                                sub_link=${sub_collection_link}
    \    ...                                product_link=${collection_product_link}
    \    Append To List    ${collections_list}    ${data}

    [Return]    ${collections_list}

Collections - Collections Table Should Display
    Element Should Be Visible    ${table_collections}

Collections - Create Collection
    [Arguments]     ${type}     ${name}    ${name_tran}    ${lang}    ${app_id}

    ${colection_existing}=       Collections - Check Collection By Name      ${name}
    ${colection_data}=           Collections - Get Collection Data By Name    ${name}

    Run Keyword If      ${colection_existing} != 1
    ...     Collections - Click Create Collection

    Run Keyword If      ${colection_existing} == 1
    ...     Collections - Click Edit Collection     ${colection_data}

    Input Text    ${name_field}    ${name}
    Click Element  ${translation_button}

    Run Keyword If      ${colection_existing} != 1
    ...     Select From List By Value    ${combo_box_translation}    ${lang}

    Input Text          ${lang_field}    ${name_tran}
    Select Checkbox     ${input_is_category}
    Run Keyword If      '${type}'=='collection'     Select Radio Button    ${radio_box_pds_collection}    1
    Run Keyword If      '${type}'=='category'       Select Radio Button    ${radio_box_pds_collection}    2
    Select Checkbox     ${radio_box_app_collection}[${app_id}]
    Sleep       1
    Click Element       ${save_button}

Collections - Create Sub Collection
    [Arguments]     ${type}     ${name}    ${name_tran}    ${lang}      ${app_id}    ${parent_data}
    ${sub_link}=        Get From Dictionary     ${parent_data}     sub_link
    Go to       ${sub_link}
    Collections - Create Collection     ${type}     ${name}    ${name_tran}    ${lang}      ${app_id}


Collections - Click Create Collection
    Click Element       ${button_add_collection}

Collections - Click Edit Collection
    [Arguments]     ${colection_data}
    ${edit_link}=        Get From Dictionary     ${colection_data}     edit_link
    Go to       ${edit_link}

Collections - Click Product Collection
    [Arguments]     ${colection_data}
    ${product_link}=        Get From Dictionary     ${colection_data}     product_link
    Go to       ${product_link}

Collections - PrepareDataForCategoryOrCollectionTree
    [Arguments]    ${type}      ${prefix}       ${prefix_tran}      ${lang}     ${app_id}    ${start}    ${total_items}
    ${total}=     Evaluate    ${total_items}+1
    : FOR    ${index}       IN RANGE     ${start}      ${total}
    \       Collections - Go To Collections Management Page
    \       ${name}=            Set Variable    ${prefix} ${index}
    \       ${name_tran}=       Set Variable    ${prefix_tran} ${index}
    \       Collections - Create Collection     ${type}     ${name}    ${name_tran}    ${lang}    ${app_id}
    \       ${lv1_data}=    Collections - Get Collection Data By Name     ${name}
    \       Collections - PrepareDataForCategoryOrCollectionTree LV 2     1      20    ${type}     ${name}    ${name_tran}     ${lang}     ${app_id}     ${lv1_data}


Collections - PrepareDataForCategoryOrCollectionTree LV 2
    [Arguments]     ${start}    ${total_items}    ${type}     ${prefix}       ${prefix_tran}     ${lang}     ${app_id}     ${lv1_data}
    ${total}=     Evaluate    ${total_items}+1
    : FOR    ${index}       IN RANGE     ${start}      ${total}
    \       ${name}=            Set Variable    ${prefix}.${index}
    \       ${name_tran}=       Set Variable    ${prefix_tran}.${index}
    \       Collections - Create Sub Collection        ${type}     ${name}    ${name_tran}    ${lang}      ${app_id}    ${lv1_data}
    \       ${lv2_data}=    Collections - Get Collection Data By Name       ${name}
    \       Collections - PrepareDataForCategoryOrCollectionTree LV 3       1       5    ${type}     ${name}    ${name_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}

Collections - PrepareDataForCategoryOrCollectionTree LV 3
    [Arguments]     ${start}    ${total_items}    ${type}     ${prefix}       ${prefix_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}
    ${total}=     Evaluate    ${total_items}+1
    : FOR    ${index}       IN RANGE     ${start}      ${total}
    \       ${name}=            Set Variable    ${prefix}.${index}
    \       ${name_tran}=       Set Variable    ${prefix_tran}.${index}
    \       Collections - Create Sub Collection        ${type}     ${name}    ${name_tran}    ${lang}      ${app_id}    ${lv2_data}
    \       ${lv3_data}=    Collections - Get Collection Data By Name       ${name}
    \       Collections - PrepareDataForCategoryOrCollectionTree LV 4       1       5    ${type}     ${name}    ${name_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}     ${lv3_data}

Collections - PrepareDataForCategoryOrCollectionTree LV 4
    [Arguments]     ${start}    ${total_items}    ${type}     ${prefix}       ${prefix_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}     ${lv3_data}
    ${total}=     Evaluate    ${total_items}+1
    : FOR    ${index}       IN RANGE     ${start}      ${total}
    \       ${name}=            Set Variable    ${prefix}.${index}
    \       ${name_tran}=       Set Variable    ${prefix_tran}.${index}
    \       Collections - Create Sub Collection        ${type}     ${name}    ${name_tran}    ${lang}      ${app_id}    ${lv3_data}
    \       ${lv4_data}=    Collections - Get Collection Data By Name       ${name}
    \       Collections - PrepareDataForCategoryOrCollectionTree LV 5       1       1    ${type}     ${name}    ${name_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}     ${lv3_data}     ${lv4_data}

Collections - PrepareDataForCategoryOrCollectionTree LV 5
    [Arguments]     ${start}     ${total_items}    ${type}     ${prefix}       ${prefix_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}     ${lv3_data}     ${lv4_data}
    ${total_items}=     Evaluate    ${total_items}+1
    : For    ${index}    IN RANGE     ${start}      ${total_items}
    \       ${name}=            Set Variable    ${prefix}.${index}
    \       ${name_tran}=       Set Variable    ${prefix_tran}.${index}
    \       Collections - Create Sub Collection        ${type}     ${name}    ${name_tran}    ${lang}      ${app_id}    ${lv4_data}
    \       ${lv5_data}=    Collections - Get Collection Data By Name       ${name}
    \       Collections - PrepareDataForCategoryOrCollectionTree LV 6       1       1    ${type}     ${name}    ${name_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}     ${lv3_data}     ${lv4_data}     ${lv5_data}

Collections - PrepareDataForCategoryOrCollectionTree LV 6
    [Arguments]     ${start}     ${total_items}    ${type}     ${prefix}       ${prefix_tran}     ${lang}     ${app_id}     ${lv1_data}     ${lv2_data}     ${lv3_data}     ${lv4_data}     ${lv5_data}
    ${total_items}=     Evaluate    ${total_items}+1
    : For    ${index}    IN RANGE     ${start}      ${total_items}
    \       ${name}=            Set Variable    ${prefix}.${index}
    \       ${name_tran}=       Set Variable    ${prefix_tran}.${index}
    \       Collections - Create Sub Collection        ${type}     ${name}    ${name_tran}    ${lang}      ${app_id}    ${lv5_data}

Collections - Create collection by collection collectionkey
    [Arguments]    ${CollectionPkey}
    ${total_row_colelction}=    Create_Product.Get collection row    ${CollectionPkey}
    Log To Console    insert coll log=${total_row_colelction}
    Run Keyword If    ${total_row_colelction} == 0
    ...    Run Keywords    Log To Console     insert collection
    ...    AND    Create category and collection for product collection    ${CollectionPkey}

Collections - Create category and collection for product collection
    [Arguments]    ${CollectionPkey}
    ${categoryId}=    Set Variable    C${CollectionPkey}
    ${collection_id}=    Create category and collection with param     0    ${CollectionPkey}    mass insert product    mass-insert-product    0    ${categoryId}    2
    [Return]    ${collection_id}
