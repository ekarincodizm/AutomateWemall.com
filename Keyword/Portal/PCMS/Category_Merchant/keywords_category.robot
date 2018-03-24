*** Variables ***
${select}    jquery=#selectMerchant
${cat_id}    82

*** Keywords ***

Merchant Category Management - Select Category
    [Arguments]             ${select_merchant_label}
    Sleep    5s
    Wait Until Element Is Visible    ${select}
    Select From List By Label        ${select}     ${select_merchant_label}

Merchant Category Management - Create Category
    [Arguments]        ${merchantId}
    Sleep    1s
    Wait Until Element Is Visible    jquery=#single-button-${merchantId}
    Click Element                    jquery=#single-button-${merchantId}
    sleep   1s
    Wait Until Element Is Visible    jquery=#btn-create-category-${merchantId}
    Click Element                    jquery=#btn-create-category-${merchantId}

Merchant Category Management - Click Save Category
    Sleep    1s
    Wait Until Element Is Visible    jquery=#CategorySave
    Click Element                    jquery=#CategorySave

Merchant Category Management - Edit Category
    [Arguments]        ${merchantId}
    Sleep    1s
    Wait Until Element Is Visible    jquery=#single-button-${merchantId}
    Click Element                    jquery=#single-button-${merchantId}
    Sleep    1s
    Wait Until Element Is Visible    jquery=#btn-edit-category-${merchantId}
    Click Element                    jquery=#btn-edit-category-${merchantId}

Merchant Category Management - Edit Category By Name
    [Arguments]        ${catName}
    Sleep    1s
    Wait Until Element Is Visible    xpath=//app-tree-view//span[contains(text(),'${catName}')]/../..//div[@class="btn-group dropdown"]
    Click Element                    xpath=//app-tree-view//span[contains(text(),'${catName}')]/../..//div[@class="btn-group dropdown"]
    Wait Until Element Is Visible     xpath=//app-tree-view//span[contains(text(),'${catName}')]/../..//li[contains(@id,'btn-edit-category')]
    Click Element                    xpath=//app-tree-view//span[contains(text(),'${catName}')]/../..//li[contains(@id,'btn-edit-category')]

Merchant Category Management - Delete Category
    Click Element                    ${dropdown}
    Click Element                    ${edit_btn}

Merchant Category Management - Verify Url Create Category
    [Arguments]         ${url}
    Location Should Contain    ${url}category/create/${cat_id}

Merchant Category Management - Verify Url Edit Category
    [Arguments]         ${url}
    Location Should Contain    ${url}category/edit/${cat_id}

Merchant Category Management - Click Plus Button
    [Arguments]        ${merchantId}
    Wait Until Element Is Visible    jquery=#btn-icon-${merchantId}
    Click Element      jquery=#btn-icon-${merchantId}

Merchant Category Management - Edit Name , Name (EN) , Slug
    [Arguments]         ${categoryName}     ${categoryNameEN}     ${slug}
    Wait Until Element Is Visible    jquery=#categoryName
    Input Text          jquery=#categoryName    ${categoryName}
    Wait Until Element Is Visible    jquery=#categoryNameTranslate
    Input Text          jquery=#categoryNameTranslate    ${categoryNameEN}
    Input Text          jquery=#categorySlug    ${slug}


Merchant Category Management - Get Trail From UI
    Wait Until Element Is Visible          jquery=#categoryTail
    ${trail_text}=      Get Text            jquery=#categoryTail
    [Return]      ${trail_text.strip()}

Merchant Category- Delete Category by Category name
    [Arguments]    ${merchant_name}    ${category_name}
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Click Element    jquery=select#selectMerchant
    Click Element    jquery=select#selectMerchant > option:contains('${merchant_name}')
    ${id}=    Selenium2Library.Get Element Attribute    jquery=span:contains('${category_name}')@id
    ${id}=     Get Substring    ${id}    13
    Log To Console    ${id}
    ${response}=    Permanent Delete Category By Category ID   ${id}
    Close Browser

Merchant Category- Delete Category level2 by Category name
    [Arguments]    ${merchant_name}    ${category_name}    ${cat_level1_id}
    Login Pcms
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Click Element    jquery=select#selectMerchant
    Click Element    jquery=select#selectMerchant > option:contains('${merchant_name}')
    Merchant Category Management - Click Plus Button    ${cat_level1_id}
    ${id}=    Selenium2Library.Get Element Attribute    jquery=span:contains('${category_name}')@id
    ${id}=     Get Substring    ${id}    14
    Log To Console    ${id}
    ${response}=    Permanent Delete Category By Category ID   ${id}
    Close Browser

Merchant Category - Get ID Category by Category name (Level1)
    [Arguments]    ${category_name}
    ${id_cat}=    Selenium2Library.Get Element Attribute    jquery=span:contains('${category_name}')@id
    ${id_cat}=     Get Substring    ${id_cat}    14
    Log To Console    ${id_cat}
    [Return]    ${id_cat}

#User do not have permission to access this page
#    [Arguments]    ${expected_cannot_access}
#    ${get_cannot_access}=    Get Text     //*[@class="mws-panel grid_8"]
#    Should Be Equal     ${get_cannot_access}     ${expected_cannot_access}

User do not have permission to access this page
    [Arguments]    ${expected_cannot_access}
    ${get_cannot_access1}=    Get Text     //*[@id="mws-container"]/div[1]/div/div[1]/span
    ${get_cannot_access2}=    Get Text     //*[@id="mws-container"]/div[1]/div/div[2]/p
    Should Contain     ${get_cannot_access1}\n${get_cannot_access2}      ${expected_cannot_access}
