*** Setting ***
Suite Setup       Create category and collection
Suite Teardown    delete collection for product upload    #[Documentation] prepare data for add product to collection    #... flash team(don't touch)    -> 2663821461509 -> (Coffee Italy : แคปซูลกาแฟ Promotion 3 Intense Set) status=active    #... flash team(don't touch)2 -> 2752364291283 -> หมาน้อย status=active    #... flash team(don't touch)3 -> 2703393943241 -> หูฟัง Urbanz รุ่น Artz    status=inactive
...               #... Add to 3393674422128    #[Documentation] collection    # id= CZZ01 -> 9991234567890    # id= CZZ02 -> 9991234567891    # id= CZZ0201 -> 9991234567892 -> Collection for Product Upload 2 Sub 1    # id= CZZ03 -> 9991234567893    # id= CZZ0301 -> 9991234567894
...               # id= CZZ030101 -> 9991234567895    #[Documentation] category    # id= CZZ04 -> 9991234567896    # id= CZZ05 -> 9991234567897    # id= CZZ0501 -> 9991234567898    # id= CZZ050101 -> 9991234567899
Test Setup        Login Pcms
Test Teardown     Close Browser
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/collection/keyword_collection.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_c_page/keyword_level_c.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ../../Resource/init.robot

*** Variables ***
${result_upload_6rows}    Mass upload completed. 6 row(s) processed.
${result_upload_3rows}    Mass upload completed. 3 row(s) processed.
${result_upload_1rows}    Mass upload completed. 1 row(s) processed.
${category_pkey}          9991234567896

*** Test Cases ***
TC_iTM_01339 - Upload product to category and collection via mass upload - Success
    [Documentation]    To verify that the upload product to category and collection via mass upload successfully.
    [Tags]    QCT
    ${product}=    Set Variable    coffee-italy-promotion-3-intense-set-2663821461509
    ${file_upload}=    Set Variable    ${CURDIR}/../../Resource/TestData/Collection/csv_file/product2cate_collection.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Upload result is displayed    ${result_upload_6rows}

    Count product LvC    ${WEMALL_URL}/category/${category_pkey}.html    3
    ${All_Product}=      Get Product Name From List     ${WEMALL_URL}/category/${category_pkey}.html
    ${list_product_name}=    Create List     flash 12X iPhone 4/4S    flash team(don't touch)2    flash team(don't touch)
    Should Be Equal    ${list_product_name}    ${All_Product}

    Open Browser ITM-levelD    ${product}
    Check category trail of level D under menu bar is correctly

TC_iTM_01352 - Log upload history is displayed - Success
    [Tags]    QCT
    ${file_upload}=    Set Variable    ${CURDIR}/../../Resource/TestData/Collection/csv_file/product2cate.csv
    Go to mass upload menu
    User browse file for upload product to cate    ${file_upload}
    Upload result is displayed    ${result_upload_6rows}
    User click back to history page
    ${get_username_history}=    Get username of user should upload product to cate
    Check user in history same the user in top menu    ${get_username_history}
    History for mass upload product to category is displayed
    Delete user after upload success    product2cate.csv
