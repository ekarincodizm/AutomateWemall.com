*** Settings ***
Library             HttpLibrary.HTTP
Resource            ${CURDIR}/../../../Database/PDS/keyword_merchant.robot
Resource            ${CURDIR}/../../../API/PDS/pds_api_keywords.robot
Resource            ${CURDIR}/../../../../Resource/TestData/${env}/test_data.robot

*** Variable ***
${sub}                               -1-
${category_type_locator}             jquery=div > label > input[value='category']
${collection_type_locator}           jquery=div > label > input[value='collection']
${category_name_locator}             jquery=#categoryName
${slug_name_locator}                 jquery=div > input[id='categorySlug']
${active_status_locator}             jquery=div.checkbox > label > input[value='active']
${translation_btn_locator}           jquery=div > button[id='categoryAddTranslation']
${category_name_tran_locator}        jquery=#categoryNameTranslate
${save_btn_locator}                  jquery=button#CategorySave
${active_locator}                    jquery=input#categoryActive
${live_on_web_locator}               jquery=input#categoryLiveOnWeb

${parent_id}                      1
${50_chars}                       12345678901234567890123456789012345678901234567890
${100_chars}                      ${50_chars}${50_chars}
${255_chars}                      ${100_chars}${100_chars}${50_chars}12345
${256_chars}                      ${255_chars}1
${img_url}                        //cdn-p2.itruemart.com/pcms/uploads/14-11-13/6fc3fcc11d6f6f176261ad8d7646d765_xl.jpg
${cat_id}                         ${EMPTY}
${index}                          1
${description_tab_locator}        jquery=li.nav-item a span:contains("Description")
${descriptionTabLocator}          jquery=li.nav-item.active span:contains("Description")
*** Keywords ***

Merchant Category Management - Click On Description Tab
    Click Element    ${description_tab_locator}
    Wait Until Element Is Visible    ${descriptionTabLocator}

Merchant Category Management - Click Create New Category
    Sleep    2s
    Wait Until Element Is Visible    jquery=#createButton
    Click Element    jquery=#createButton

Merchant Category Description - Select Category Type
    Sleep    2s
    Wait Until Element Is Visible    {category_type}
    Click Element    ${category_type}

Merchant Category Description - Select Collection Type
    Sleep    2s
    Wait Until Element Is Visible    ${category_type}
    Click Element    ${category_type}

Merchant Category Description - Input Category Name
    [Arguments]    ${text}
    Sleep    2s
    Wait Until Element Is Visible    ${category_name_locator}
    Input Text    ${category_name_locator}    ${text}

Merchant Category Description - Input Category Name Translate
    [Arguments]    ${text}
    Sleep    2s
    Wait Until Element Is Visible    ${category_name_tran_locator}
    Input Text    ${category_name_tran_locator}    ${text}

Merchant Category Description - Input Slug Name
    [Arguments]    ${text}
    Sleep    2s
    Wait Until Element Is Visible    ${slug_name_locator}
    Input Text    ${slug_name_locator}    ${text}

Merchant Category Description - Select Status Active
    [Arguments]    ${check}=check
    Sleep    2s
    Wait Until Element Is Visible    ${active_locator}
    Run Keyword If    '${check}'=='CHECK'    Click Element    ${active_locator}

Merchant Category Description - Select Status Live on Web
    [Arguments]    ${check}=check
    Sleep    2s
    Wait Until Element Is Visible    ${live_on_web_locator}
    Run Keyword If    '${check}'=='CHECK'    Click Element    ${live_on_web_locator}

Merchant Category Description - Click Save Button
    Sleep    2s
    Wait Until Element Is Visible    ${save_btn_locator}
    Click Element    ${save_btn_locator}

Merchant Category - Prepare Data Create Merchant In DB
    [Arguments]    ${merchant_name}    ${merchant_code}    ${merchant_type}
    ${merchant_id}=    Create Merchant in DB    ${merchant_name}    ${merchant_code}    ${merchant_type}
    [Return]    ${merchant_id}

Merchant Category - Prepare Data Create Merchant Alias In DB
    [Arguments]    ${merchant_name}    ${merchant_code}    ${merchant_type}
    ${merchant_id}=    Create Merchant Alias in DB    ${merchant_name}    ${merchant_code}    ${merchant_type}
    [Return]    ${merchant_id}

Merchant Category - Delete Merchant From DB
    [Arguments]    ${merchant_id}
    ${res}=    Delete Merchant From DB    ${merchant_id}
    [Return]    ${res}

Merchant Category - Delete Merchant Alias From DB
    [Arguments]    ${merchant_id}
    ${res}=    Delete Merchant Alias From DB    ${merchant_id}
    [Return]    ${res}

Merchant Category - Create Category
    [Arguments]    ${MERCHANT_CODE}    ${MERCHANT_TYPE}    ${tc_number}
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Merchant Category Description - Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}    ${tc_number}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status                      "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner                       "${MERCHANT_CODE}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type                  "${MERCHANT_TYPE}"
    :FOR    ${index}    IN RANGE    1     7
     \    Log To Console    ${index}
     \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}${sub}${index}"
     \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}-EN${sub}${index}"
     \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    slug    "wmhulk-slug${sub}${index}"
     \    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
     \    ${response}=    Run Keyword If    ${index} == 1  Create Category    1    ${file_data}
     \    ${response}=    Run Keyword If    ${index} > 1  Create Category    ${cat_id}    ${file_data}
     \    ${cat_id}=     Get Category ID After Creating
     \    Log To Console    ${sub}

Merchant Category - Edit Category Parent
    Sleep    2s
    Wait Until Element Is Visible    jquery=#editCategoryParent
    Click Element       jquery=#editCategoryParent

Merchant Category - Select Parent
    [Arguments]         ${level}        ${parent_id}
    Sleep    2s
    Wait Until Element Is Visible    jquery=#level-${level} #${parent_id}
    Click Element       jquery=#level-${level} #${parent_id}
    Wait Until Element Is Visible       jquery=#level-${level} #${parent_id}.active

Merchant Category - Get Category Trail By Merchant Code
    [Arguments]     ${merchant_code}
    ${response}=     Get Category By Merchant Code    ${merchant_code}
    ${children}=    Merchant Category - Get Json Value and Convert to List    ${response}    /data
    ${length}=    Get Length    ${children}
    ${LIST}=      Create List
    :For     ${index}    IN RANGE        0          ${length}
    \        ${child}=          Get From List      ${children}         ${index}
    \        ${trail}=            Get From Dictionary     ${child}           name_trail
    \        ${id}=            Get From Dictionary     ${child}           id
    \        ${LIST_TAIL}=     Create Dictionary          trail=${trail}       id=${id}
    \        Append To List         ${LIST}        ${LIST_TAIL}
    Return From Keyword    ${LIST}


Merchant Category - Verify New Category
    [Arguments]     ${merchant_code}      ${category_name}      ${category_name_translate}     ${parent_id}    ${level}    ${cat_display}   ${cat_status}
    ${response}=     Get Category By Merchant Code    ${merchant_code}
    ${children}=    Merchant Category - Get Json Value and Convert to List    ${response}    /data
    ${length}=    Get Length    ${children}
    ${parent_id}=       Convert To Integer      ${parent_id}
    ${level}=       Convert To Integer      ${level}
    ${EXPECT_LIST}=         Create List	       ${category_name}    ${parent_id}    ${level}     ${category_name_translate}      ${cat_display}   ${cat_status}
    ${status}=      Set Variable        FAIL
    :For     ${index}    IN RANGE        0          ${length}
    \        ${child}=          Get From List      ${children}         ${index}
    \        ${_cat_name}=      Get From Dictionary     ${child}       category_name
    \        ${_category_name_translate}    Get From Dictionary     ${child}        category_name_translate
    \        ${_level}=         Get From Dictionary     ${child}       level
    \        ${_slug}=          Get From Dictionary     ${child}           slug
    \        ${_parent_id}=     Get From Dictionary     ${child}           parent_id
    \        ${_display}=       Get From Dictionary     ${child}           display
    \        ${_status_api}=        Get From Dictionary     ${child}           status
    \        ${LIST}=           Create List	       ${_cat_name}    ${_parent_id}    ${_level}   ${_category_name_translate}     ${_display}     ${_status_api}
    \        ${status}=         Set Variable If	 '${status}'=='PASS' or ${EXPECT_LIST}==${LIST}         PASS
    Should Be True      '${status}'=='PASS'

Merchant Category Description - Delete All Categories
    [Arguments]         ${parent_id}
    ${ID_LIST}=         Get All CATEGORIES ID FOR DELETE             http://${PDS_URL_API}/categories/    ${parent_id}
    ${length}=    Get Length    ${ID_LIST}
    :For     ${index}    IN RANGE        0          ${length}
    \        ${index}=           Convert To Integer             ${index}
    \        ${child}=          Get From List      ${ID_LIST}         ${index}
    \        ${child}=          Convert To Integer    ${child}
    \        ${response}=    Permanent Delete Category By Category ID   ${child}

Merchant Category Description - Verify Category Management Page Info
    [Arguments]     ${expected_merchant}
    ${merchantname}=    Get Text    jquery=select#merchantName option:selected
    Should Be Equal As Strings    ${merchantname}    ${expected_merchant}
    Page Should Contain Element    jquery=a.nav-link.active > span:contains('Description')
    Page Should Contain Element    jquery=a.nav-link.disabled > span:contains('Display')
    Page Should Contain Element    jquery=a.nav-link.disabled > span:contains('SEO')
    Page Should Contain Element    jquery=a.nav-link.disabled > span:contains('Product List')

Merchant Category Description - Create New Category Merchant
    [Arguments]    ${merchant_name}    ${catname_th}    ${catname_en}
    Click Element    jquery=select#selectMerchant
    sleep   2s
    Click Element    jquery=select#selectMerchant > option:contains('${merchant_name}')
    sleep   2s
    Merchant Category Management - Click Create New Category
    sleep   2s
    Merchant Category Description - Input Category Name    ${catname_th}
    Merchant Category Description - Input Category Name Translate    ${catname_en}
    Merchant Category Description - Click Save Button
    Sleep    2s
    Page Should Contain Element    jquery=div > span:contains('${catname_th}')

Merchant Category - Get Json Value and Convert to List
    [Arguments]    ${json_string}    ${json_pointer}
    ${json_value}=    Get Json Value    ${json_string}    ${json_pointer}
    ${json_value}=  Parse Json  ${json_value}
    # Log List    ${json_value}
    Return From Keyword    ${json_value}

Merchant Category Description - Verify Slug On Description Tab
    [Arguments]    ${expected_slug}
    Sleep    2s
    ${slug}=    Get Value    jquery=input#categorySlug
    Should Be Equal As Strings     ${expected_slug}    ${slug}


Merchant Category Description - Create Dictionary for Common Creation JSON Category
    [Arguments]    ${json_dict}    ${tc_number}
    Set To Dictionary    ${json_dict}    category_name               "${tc_number}"
    Set To Dictionary    ${json_dict}    status                      "active"
    Set To Dictionary    ${json_dict}    owner                       "${MERCHANT_CODE}"
    Set To Dictionary    ${json_dict}    owner_type                  "${MERCHANT_TYPE}"
    Set To Dictionary    ${json_dict}    category_name_translate     "${tc_number}-EN"
    Set To Dictionary    ${json_dict}    slug                        "${tc_number}-slug"
    Set To Dictionary    ${json_dict}    image_url_desktop           "image_url_desktop-${tc_number}"
    Set To Dictionary    ${json_dict}    image_url_mobile            "image_url_mobile-${tc_number}"
    Return From Keyword     ${json_dict}