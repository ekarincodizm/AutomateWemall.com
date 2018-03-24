*** Setting ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/collection/keyword_collection.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_c_page/keyword_level_c.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Test Setup        Run Keywords    Create category and collection    AND    Login Pcms
Test Teardown     Run Keywords    delete collection for product upload    AND    Close All Browsers

*** Variables ***
${result_upload_6rows}    Mass upload completed. 6 row(s) processed.
${result_upload_4rows}    Mass upload completed. 4 row(s) processed.
${result_upload_1rows}    Mass upload completed. 1 row(s) processed.
${category_name1}         Collection for Product Upload 4 (category)
${result_header_fail}     Error(s) found. Please re-check your file and try to upload again.
${category_pkey}          9991234567896
${collection_name1}       Collection for Product Upload 1
${collection_pkey}        9991234567890
${product_name1}          flash team(don't touch)
${product_name2}          flash team(don't touch)2

#..prepare data for add product to collection
#...flash team(don't touch) -> 2663821461509 -> (Coffee Italy : แคปซูลกาแฟ Promotion 3 Intense Set)status=active
#...flash team(don't touch)2 -> 2752364291283 -> หมาน้อย status=active
#...flash team(don't touch)3 -> 2703393943241 -> หูฟัง Urbanz รุ่น Artz status=inactive
#...Add to 3393674422128
#..collection
#...id= CZZ01 -> 9991234567890
#...id= CZZ02 -> 9991234567891
#...id= CZZ0201 -> 9991234567892 -> Collection for Product Upload 2 Sub 1
#...id= CZZ03 -> 9991234567893
#...id= CZZ0301 -> 9991234567894
#...id= CZZ030101 -> 9991234567895
#..category
#...id= CZZ04 -> 9991234567896
#...id= CZZ05 -> 9991234567897
#...id= CZZ0501 -> 9991234567898
#...id= CZZ050101 -> 9991234567899

*** Test Cases ***
TC_iTM_01338 Upload product to category via mass upload - Success
    [Tags]    regression    WMFLASH-579    Category    Mass_Upload    Success    Upload_Product_To_Category
    ...    TC_iTM_01338    ready    flash
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2cate.csv
    ${product}=        Set Variable    coffee-italy-promotion-3-intense-set-2663821461509
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Upload result is displayed    ${result_upload_6rows}

    Count product LvC    ${WEMALL_URL}/category/${category_pkey}.html    3
    ${All_Product}=      Get Product Name From List     ${WEMALL_URL}/category/${category_pkey}.html
    ${list_product_name}=    Create List    flash 12X iPhone 4/4S    ${product_name2}    ${product_name1}
    Should Be Equal    ${list_product_name}    ${All_Product}

    Open Browser ITM-levelD    ${product}
    Check category trail of level D under menu bar is correctly

TC_iTM_01339 Upload product to category and collection via mass upload - Success
    [Tags]    regression    WMFLASH-579    Category    Mass_Upload    Success    Upload_Product_To_Category
    ...    TC_iTM_01339    ready    flash
    ${product}=    Set Variable    coffee-italy-promotion-3-intense-set-2663821461509
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2cate_collection.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Upload result is displayed    ${result_upload_6rows}

    Count product LvC    ${WEMALL_URL}/category/${category_pkey}.html    3
    ${All_Product}=      Get Product Name From List     ${WEMALL_URL}/category/${category_pkey}.html
    ${list_product_name}=    Create List     flash 12X iPhone 4/4S    flash team(don't touch)2    flash team(don't touch)
    Should Be Equal    ${list_product_name}    ${All_Product}

    Open Browser ITM-levelD    ${product}
    Check category trail of level D under menu bar is correctly

TC_iTM_01354 Upload product to collection via mass upload - Success
    [Tags]    regression    Collection    Mass_Upload    Success    Upload_Product_To_Collection    TC_iTM_01354
    ...    ready    flash
    ${product}=    Set Variable    coffee-italy-promotion-3-intense-set-2663821461509
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Upload result is displayed    ${result_upload_4rows}

    Count product LvC    ${WEMALL_URL}/category/${collection_pkey}.html    3
    ${All_Product}=      Get Product Name From List     ${WEMALL_URL}/category/col-prod-1-${collection_pkey}.html?no-cache=1
    ${list_product_name}=    Create List     flash 12X iPhone 4/4S    flash team(don't touch)2    flash team(don't touch)
    Should Be Equal    ${list_product_name}    ${All_Product}

    Open Browser ITM-levelD    ${product}
    Check category trail of level D under menu bar is correctly

TC_iTM_01341 Space in the field - Success
    [Tags]    Category    Mass_Upload    Success    Upload_Product_To_Category    TC_iTM_01341    ready
    ...    flash    regression
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2cate_space_in_row.csv
    ${product_pkey}=    Set Variable    2663821461509
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Upload result is displayed    ${result_upload_1rows}
    Go to manage collection menu
    Choose product link in category
    Check product under category    ${product_pkey}

TC_iTM_01350 History is displayed 20 row(s) per page - Success
    [Tags]    Category    Mass_Upload    Upload_Product_To_Category    TC_iTM_01350    ready    flash
    ...    regression
    Go to mass upload menu
    ${num_all_history}=    All history of mass upload
    Check all row in history    ${num_all_history}

TC_iTM_01382 Download templete mass upload - Success
    [Tags]    Category    Mass_Upload    Success    Upload_Product_To_Category    TC_iTM_01382    ready
    ...    flash    regression
    Go to mass upload menu
    ${filename}=    User download templete
    Templete is correctly    ${filename}

TC_iTM_01343 User does not input product id - Fail
    [Documentation]    Application must be stoped to read input data if a user does not input product id.
    [Tags]    regression    WMFLASH-579    Category    Mass_Upload    Fail    Upload_Product_To_Category
    ...    ready    TC_iTM_01343    flash
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_no_product_pkey.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Result when user does not input product id
    User can back to upload file again

TC_iTM_01344 User does not input category id - Fail
    [Documentation]    Application must be stoped to read input data if a user does not input category id.
    [Tags]    regression    WMFLASH-579    Category    Mass_Upload    Fail    Upload_Product_To_Category
    ...    TC_iTM_01344    ready    flash
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_no_collection_pkey.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Result when user does not input collection pkey
    User can back to upload file again

TC_iTM_01346 Product id not exist in system - Fail
    [Documentation]    To verify that application must be stoped to read input data if product id not exist in system.
    [Tags]    regression    WMFLASH-579    Category    Mass_Upload    Fail    Upload_Product_To_Category
    ...    TC_iTM_01346    ready    flash
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_product_not_exist.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Result when product doest not exist in system

TC_iTM_01347 Category id not exist in system - Fail
    [Tags]    regression    WMFLASH-579    Category    Mass_Upload    Fail    Upload_Product_To_Category
    ...    TC_iTM_01347    ready    flash
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_collection_not_exist.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Result when collection doest not exist in system

TC_iTM_01352 Log upload history is displayed - Success
    [Tags]    WMFLASH-579    Category    Mass_Upload    Fail    Upload_Product_To_Category    regression
    ...    TC_iTM_01352    ready    flash
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2cate.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Upload result is displayed    ${result_upload_6rows}
    User click back to history page
    ${get_username_history}=    Get username of user should upload product to cate
    Check user in history same the user in top menu    ${get_username_history}
    History for mass upload product to category is displayed
    Delete user after upload success    product2cate.csv

TC_iTM_01345 Blank row in the input csv - Fail
    [Tags]    Category    Mass_Upload    Fail    Upload_Product_To_Category    TC_iTM_01345    ready
    ...    regression    flash
    ${file_upload}=    Set Variable    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/blank_rows.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Error message empty row is displayed

TC_iTM_01342 Upload product to category deleted in system - Fail
    [Tags]    TC_iTM_01342    ready    regression    flash    Upload_Product_To_Category    Mass_Upload
    ${message_invalid_product_key}=    Set Variable    Invalid Collection Key
    ${row}=    Set Variable    1
    ${product_key}=    Insert product with retail type
    ${collection_key}=    Get collection key delete at
    @{data_name}=    Create List    Collection Key    Product Key
    @{data_value1}=    Create List    ${collection_key}    ${product_key}
    @{data}=    Create List    ${data_name}    ${data_value1}
    Log To Console    data list in csv=${data}
    ${path_file}=    Set product key and collection key in file csv product to collection    ${data}
    Go to mass upload menu
    User browse file for upload product to cate    ${path_file}
    Collection - Error message is displayed when upload failed    1 ${result_header_fail}
    ${message}=    Collection - Get result in file verification table
    Collection - Verify result when upload product to collection is failed    ${collection_key}    ${product_key}    ${row}    ${message_invalid_product_key}    ${message}
