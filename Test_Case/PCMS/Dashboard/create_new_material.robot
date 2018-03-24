*** Settings ***
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Create_New_Material/keywords_create_new_material.robot

*** Test Cases ***
TC_iTM_01776 Cannot Create Product Using Sku From Different Shops
    [Tags]    TC_iTM_01776    Ready    itma-s082016     regression
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

TC_iTM_01777 Can Create Product Using Sku From Same Shops
    [Tags]    TC_iTM_01777    Ready   itma-s082016   regression
    Prepare Two Shop
    Prepare Sku In Same Shop
    Login Pcms
    Click Manage New Material Button
    Search Sku List
    Search Incomplete Product Which Has Color
    Click Add New Material
    Page Should Contain New Sku
    Element Should Contain Shop Detail With Same Shops
    Click Select Button With 2 Skus
    Click Next Button
    Click Next Button
    Select Color
    Click Next Button
    Page Should New Variant
    [Teardown]    Run Keywords    Delete Imported Two Sku
    ...    AND    Delete Two Shop
    ...    AND    Delete Two Variants
    ...    AND    Delete Product By Product Title
    ...    AND    Close All Browsers

TC_iTM_01778 Display warning message if the selected SKUs have the different shop
    [Tags]    TC_iTM_01778    Ready   itma-s082016   regression
    Prepare Two Shop
    Prepare Sku In Different Shop
    Login Pcms
    Click Manage New Material Button
    Click Create New Product Tab
    Search Sku List For New Product
    Fill Product Detail
    Page Should Contain New Sku
    Element Should Contain Shop Detail With Different Shops
    Click Select Button With 2 Skus
    Page Should Contain Alertbox
    Only One Checkbox Should Be Checked
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop
    ...    AND    Delete Two Variants
    ...    AND    Delete Product By Product Title

TC_iTM_01779 Can continue to next step if the selected SKUs have the Same shop
    [Tags]    TC_iTM_01779    Ready   itma-s082016   regression
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
    [Teardown]    Run Keywords   close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop
    ...    AND    Delete Product By Product Title

TC_iTM_01796 Disable checkbox for SKUs that has no shop
    [Tags]    TC_iTM_01796    Ready  itma-s082016   regression
    Prepare Sku With No Shop Related To It
    Login Pcms
    Click Manage New Material Button
    Search Sku List
    Click Search Button
    Click Add New Material
    Search Prepared Robot Sku
    Click Select Button On Variant Which Has No Shop
    Sku With No Shop Name Should Not Be Unselectable
    Not Found Record In Table Variant
    [Teardown]    Run Keywords    Delete Imported Sku
    ...    AND    Close Browser

TC_iTM_02059 Display alert warning message If the all selected SKUs have the different shop code
    [Tags]    TC_iTM_02059    Ready   itma-s082016   regression
    Prepare Two Shop
    Prepare Sku In Different Shop
    Login Pcms
    Click Manage New Material Button
    Search Sku List
    Click Search Button
    Click Add New Material
    Click Select All
    Check Alert Message
    Not Found Record In Table Variant
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop

TC_iTM_02060 Can continue to next step if the all selected SKUs have the same shop code
    [Tags]    TC_iTM_02060    Ready   itma-s082016   regression
    Prepare Two Shop
    Prepare Sku In Different Shop
    Login Pcms
    Click Manage New Material Button
    Search Sku List
    Click Search Button
    Click Add New Material
    Search Shop
    Click Select All
    Inserted Skus Which Have Different Shops Should Not Be Selected
    Check If Skus Are Sill In Waiting List On Dashboard
    Not Found Record In Table Variant
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop

TC_iTM_02061 Display alert warning message If the selected All SKUs have the different shop code
    [Tags]    TC_iTM_02061    Ready   itma-s082016   regression
    Prepare Two Shop
    Prepare Sku In Different Shop
    Login Pcms
    Click Manage New Material Button
    Click Create New Product Tab
    Search Sku List For New Product
    Fill Product Detail
    Click Select All
    Check Alert Message
    Check If Skus Are Sill In Waiting List On Dashboard
    Not Found Record In Table Variant
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop
    ...    AND    Delete Product By Product Title

TC_iTM_02062 Can continue to next step if the all selected SKUs have the same shop code
    [Tags]    TC_iTM_02062    Ready  itma-s082016   regression
    Prepare Two Shop
    Prepare Sku In Different Shop
    Login Pcms
    Click Manage New Material Button
    Click Create New Product Tab
    Search Sku List For New Product
    Fill Product Detail
    Search Shop
    Click Select All
    Inserted Skus Which Have Different Shops Should Not Be Selected
    Check If Skus Are Sill In Waiting List On Dashboard
    Not Found Record In Table Variant
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Imported Two Sku
    ...    AND    Delete Two Shop
    ...    AND    Delete Product By Product Title

