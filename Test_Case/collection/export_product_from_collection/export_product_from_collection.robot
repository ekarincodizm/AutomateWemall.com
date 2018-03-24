*** Setting ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/collection/keyword_collection.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Test Setup        Run Keywords    insert collection for product upload    AND    Login Pcms
Test Teardown     Run Keywords    delete collection for product upload    AND    Close Browser

*** Variables ***
${product2cate_csv}    ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2cate.csv
${result_upload}       Mass upload completed. 6 row(s) processed.

#..prepare data for add product to collection
#...flash team(don't touch)    -> 2663821461509 -> (Coffee Italy : แคปซูลกาแฟ Promotion 3 Intense Set) status=active
#...flash team(don't touch)2 -> 2752364291283 -> หมาน้อย status=active
#...flash team(don't touch)3 -> 2703393943241 -> หูฟัง Urbanz รุ่น Artz status=inactive
#...Add to 3393674422128
#..collection
#...id= CZZ01 -> 9991234567890
#...id= CZZ02 -> 9991234567891
#...id= CZZ0201 -> 9991234567892
#...id= CZZ03 -> 9991234567893
#...id= CZZ0301 -> 9991234567894
#...id= CZZ030101 -> 9991234567895
#..category
#...id= CZZ04 -> 9991234567896
#...id= CZZ05 -> 9991234567897
#...id= CZZ0501 -> 9991234567898
#...id= CZZ050101 -> 9991234567899

*** Test Cases ***
TC_iTM_01356 Export Products button is disable
    [Documentation]    To verify that export product button is disable when product is not selected or collection have not product.
    [Tags]    Manage_Category    Export_product_collection    TC_iTM_01356    ready    flash    regression
    Go to mass upload menu
    User browse file for upload product to cate    ${product2cate_csv}
    Upload result is displayed    ${result_upload}
    Go to manage collection menu
    Choose product link in category
    Export product button is disable

TC_iTM_01357 Select all product under category - Success
    [Documentation]    To verify that user export all product under category.
    [Tags]    Manage_Category    Export_product_collection    TC_iTM_01357    regression    ready    flash
    Go to mass upload menu
    User browse file for upload product to cate    ${product2cate_csv}
    Upload result is displayed    ${result_upload}
    Go to manage collection menu
    Choose product link in category
    Export products choose select all

TC_iTM_01358 Select some product under category - Success
    [Documentation]    To verify that user export some product under category.
    [Tags]    Manage_Category    Export_product_collection    TC_iTM_01358    ready    flash    regression
    Go to mass upload menu
    User browse file for upload product to cate    ${product2cate_csv}
    Upload result is displayed    ${result_upload}
    Go to manage collection menu
    Choose product link in category
    Export products choose select one

TC_iTM_01360 Select all product under collection - Success
    [Documentation]    To verify that user export all product under category.
    ...    Field in csv file -> Product id, Product Key, Product name, Active/inactive, Stock by item, Type(Collection or Category), Collection Key, Collection Name
    [Tags]    Manage_Category    Export_product_collection    TC_iTM_01360    ready    flash    regression
    Go to mass upload menu
    User browse file for upload product to cate    ${product2cate_csv}
    Upload result is displayed    ${result_upload}
    Go to manage collection menu
    Choose product link in collection
    Export products choose select all

TC_iTM_01361 Select some product under collection - Success
    [Documentation]    To verify that user export some product under collection.
    [Tags]    Manage_Category    Export_product_collection    TC_iTM_01361    regression    ready    flash
    Go to mass upload menu
    User browse file for upload product to cate    ${product2cate_csv}
    Upload result is displayed    ${result_upload}
    Go to manage collection menu
    Choose product link in collection
    Export products choose select one
