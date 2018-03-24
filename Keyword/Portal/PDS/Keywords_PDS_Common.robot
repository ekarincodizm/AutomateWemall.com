*** Keywords ***
Get Test Case Number
    [Arguments]    ${test_name}=${TEST_NAME}
    @{words}=    Split String    ${test_name}
    Return From Keyword    @{words}[0]

Go To Category Management Page
    Go to     ${PCMS_URL}/categories/merchant-categories
    Wait Until Element Is Enabled    ${MERCHANT-SELECTOR}    30
    Capture Page Screenshot

# Go To Mass Upload Product To Category Page
#     # Go To    ${PCMS_URL}/categories/bulk-upload
#     Click Element    ${MASS-UPLOAD-PRODUCTS-BUTTON}
#     Wait Until Element Is Enabled    ${UPLOAD-ACTION-SELECTOR}    30
#     Capture Page Screenshot

Get List of Merchant / Alias Name From Selector -- not work
    ${return_list}=    Create List
    ${list}=    Get List Items    ${MERCHANT-SELECTOR}
    :FOR    ${item}    IN    @{list}
    \    ${index}=    Evaluate    ${item}+1
    \    ${name}=     Get Text   ${MERCHANT-SELECTOR}/option[${index}]
    \    Append To List    ${return_list}    ${name}
    Return From Keyword    ${return_list}

Get List of Merchant / Alias Name From Selector
    ${return_list}=    Create List
    ${number_of_items}=    Get Matching Xpath Count    ${MERCHANT-SELECTOR}/option
    ${max_loop_of_items}=    Evaluate    ${number_of_items}+1
    :FOR    ${index}    IN RANGE    1    ${max_loop_of_items}
    \    ${name}=     Get Text   ${MERCHANT-SELECTOR}/option[${index}]
    \    Append To List    ${return_list}    ${name}
    Return From Keyword    ${return_list}

Select Merchant / Alias By Name
    [Arguments]    ${name}
    ${value}=    Get Value    ${MERCHANT-SELECTOR}/option[contains(., '${name}')]
    Select From List By Value    ${MERCHANT-SELECTOR}    ${value}
    Sleep    1

Go To Category Management Tab
    Click Element    ${CATEGORY-MANAGEMENT-LINK}

Go To Mass Upload Product To Category Page
    Go to     ${PCMS_URL}/categories/mass-upload
    Wait Until Element Is Enabled    ${UPLOAD-ACTION-SELECTOR}    30
    Capture Page Screenshot

Verify Category Management Table Header at Category Management Page
    Selenium2Library.Element Text Should Be    ${CATEGORY-MANAGEMENT-TABLE-HEADER}/div[1]/h5    Actions
    Selenium2Library.Element Text Should Be    ${CATEGORY-MANAGEMENT-TABLE-HEADER}/div[2]/h5    Display
    Selenium2Library.Element Text Should Be    ${CATEGORY-MANAGEMENT-TABLE-HEADER}/div[3]/h5    Status
    Selenium2Library.Element Text Should Be    ${CATEGORY-MANAGEMENT-TABLE-HEADER}/div[4]/h5    Product(s)
    Selenium2Library.Element Text Should Be    ${CATEGORY-MANAGEMENT-TABLE-HEADER}/div[5]/h5    Merchant
    Selenium2Library.Element Text Should Be    ${CATEGORY-MANAGEMENT-TABLE-HEADER}/div[6]/h5    Name
    Selenium2Library.Element Text Should Be    ${CATEGORY-MANAGEMENT-TABLE-HEADER}/div[7]/h5    Pkey

Verify Category Data in Table at Category Management Page
    [Arguments]    ${level}    ${number_of_sub_cat_order}    ${expected_pkey}    ${expected_name}    ${expected_merchant}    ${expected_number_of_products}    ${expected_status}    ${expected_display}
    # level (category level) Ex. CATEGORY 1, level is 1
    # number of level Ex. CATEGORY 1-2.1 (1st sub-category of CATEGORY 1, number of sub cat order is 1)
    ${row_xpath}=    Get Row XPATH for Category Tree    ${level}    ${number_of_sub_cat_order}
    #.. Get Actual Data
    ${pkey}=        Get Text    ${row_xpath}//span[contains(@id,"category-pkey")]
    ${name}=        Get Text    ${row_xpath}//span[contains(@id,"category-name")]
    ${merchant}=    Get Text    ${row_xpath}//span[contains(@id,"category-merchant")]
    ${number_of_products}=    Get Text    ${row_xpath}//span[contains(@id,"category-product")]
    ${status}=      Get Text    ${row_xpath}//span[contains(@id,"category-status")]
    ${display}=     Selenium2Library.Get Element Attribute    ${row_xpath}//span[contains(@id,"category-display")]@class
    #.. Verify Data
    Should Be Equal As Integers    ${expected_pkey}    ${pkey}
    Should Be Equal    ${expected_name}    ${name}
    Should Be Equal    ${expected_merchant}    ${merchant}
    # Should Be Equal As Integers    ${expected_number_of_products}    ${number_of_products}
    Should Be Equal    ${expected_status}    ${status}
    Run Keyword If    ${expected_display}    Should Be Equal    ${display}    glyphicon glyphicon-eye-open
    ...    ELSE    Should Be Equal    ${display}    glyphicon glyphicon-eye-close

Expand or Collapse Sub-Categories under Category
    [Arguments]    ${level}    ${number_of_sub_cat_order}=${EMPTY}
    ${row_xpath}=    Get Row XPATH for Category Tree    ${level}    ${number_of_sub_cat_order}
    ${row_xpath} =    Get Substring   ${row_xpath}    ${EMPTY}    -3
    # div[1] --> div[8]/span[@id="btn-icon"]
    Wait Until Element Is Enabled    ${row_xpath}/div[8]/span[contains(@id,"btn-icon")]    45
    Click Element    ${row_xpath}/div[8]/span[contains(@id,"btn-icon")]
    Sleep    1s

Category Should Be Found at Category Tree
    [Arguments]    ${level}    ${number_of_sub_cat_order}=${EMPTY}
    ${row_xpath}=    Get Row XPATH for Category Tree    ${level}    ${number_of_sub_cat_order}
    Page Should Contain Element    ${row_xpath}

Category Should Not Be Found at Category Tree
    [Arguments]    ${level}    ${number_of_sub_cat_order}=${EMPTY}
    ${row_xpath}=    Get Row XPATH for Category Tree    ${level}    ${number_of_sub_cat_order}
    Page Should Not Contain Element    ${row_xpath}

Get Row XPATH for Category Tree
    [Arguments]    ${level}    ${number_of_sub_cat_order}=${EMPTY}
    # level (category level) Ex. CATEGORY 1, level is 1
    # number of level Ex. CATEGORY 1-2.1 (1st sub-category of CATEGORY 1, number of sub cat order is 1)
    ${prefix_row_xpath}=    Set Variable    //*[@id="tabCategory"]/app-category-tree/div/div/ul
    ${row_xpath}=           Set Variable    ${prefix_row_xpath}
    ${row_xpath_no_sub_cat}=    Set Variable If    '${number_of_sub_cat_order}'=='${EMPTY}'    ${prefix_row_xpath}/app-tree-view/ul/li[${level}]/div[1]
    Log    ROW XPATH is \n${row_xpath_no_sub_cat}\n    console=yes
    Return From Keyword If    '${number_of_sub_cat_order}'=='${EMPTY}'    ${row_xpath_no_sub_cat}

    #.. There are some sub categories
    ${sub_cat_level}=    Fetch From Left     ${number_of_sub_cat_order}    .
    ${sub_cat_order}=    Fetch From Right    ${number_of_sub_cat_order}    .

    ${row_xpath}=    Set Variable    ${prefix_row_xpath}/app-tree-view/ul/li[${level}]
    :FOR    ${i}    IN RANGE    1    ${sub_cat_level}
    \    Exit For Loop If    '${sub_cat_level}'=='1'
    \    ${row_xpath}=    Set Variable    ${row_xpath}/div[2]/app-tree-view/ul/li[1]

    ${row_xpath}=    Set Variable    ${row_xpath}/div[2]/app-tree-view/ul/li[${sub_cat_order}]/div[1]
    Log    ROW XPATH is \n${row_xpath}\n    console=yes
    Return From Keyword    ${row_xpath}

Set Category Key and Product Key in file csv
    [Arguments]    ${data}
    ${path_file}=     Set Variable     ${CURDIR}/../../../Resource/TestData/Product/csv_file/mass_upload_product_to_category.csv
    csvlibrary.create_file    ${path_file}    ${data}
    [Return]     ${path_file}

Sum stock remaining for product
    [Arguments]    ${product_pkey}
    ${product_id}=    Get Product ID from DB by Product pkey    ${product_pkey}
    ${list_inventory_id}=    Get Inventory ID from DB by Product ID    ${product_id}
    ${length_inventory_id}=    Get Length    ${list_inventory_id}
    ${total_stock_remaing}=    Set Variable    0
    :FOR    ${index}    IN RANGE    ${length_inventory_id}
    \    ${inventory_id}=    Convert To String    @{list_inventory_id}[${index}]
    \    ${inventory_id}=    Remove String    ${inventory_id}     '
    \    log     inventory_id${inventory_id}
    \    ${response}=    Get Remaining Stock By Inventory ID    ${inventory_id}
    \    ${remaining}=    Get Json Value    ${response}    /data/remaining/${inventory_id}
    \    log    remaining=${remaining}
    \    ${total_stock_remaing}=    Evaluate    ${total_stock_remaing} + ${remaining}
    Return From Keyword    ${total_stock_remaing}