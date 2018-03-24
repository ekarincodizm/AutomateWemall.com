*** Settings ***
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Create_New_Material/keywords_create_new_material.robot
Resource          ../../Resource/init.robot

*** Test Cases ***
TC_iTM_01776 Cannot Create Product Using Sku From Different Shops
    [Tags]    QCT
    Prepare Two Shop
    Prepare Sku In Different Shop
    Login Pcms
    Click Manage New Material Button
    Search Sku List
    Click Search Button
    Click Add New Material
    Page Should Contain New Sku
    Element Should Contain Shop Detail With Different Shops
    Click Select Button With 2 Skus
    Page Should Contain Alertbox
    Only One Checkbox Should Be Checked
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop

TC_iTM_01779 Can continue to next step if the selected SKUs have the Same shop
    [Tags]    QCT
    Prepare Two Shop
    Prepare Sku In Same Shop
    Login Pcms
    Click Manage New Material Button
    Click Create New Product Tab
    Search Sku List For New Product
    Fill Product Detail
    Click Select Button With 2 Skus
    Click Next Button
    Wait Element Create New Product Step3
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop
    ...    AND    Delete Product By Product Title
