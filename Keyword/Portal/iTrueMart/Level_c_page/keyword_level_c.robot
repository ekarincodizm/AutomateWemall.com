*** Settings ***
Library           Selenium2Library
Library           ${CURDIR}/../../../../Python_Library/common/web_element_library.py
Resource          web_element_level_c.robot

*** Keywords ***
Open Browser ITM
    Open Browser    ${ITM_URL}    ${BROWSER}
    Wait Until Element Is Visible    ${header_category}    15s
    Click Element    ${header_category}
    Wait Until Element Is Visible    ${side_bar_collection}    15s

Open Merchant Category With Merchant Slug And Category Slug-Pkey
    [Arguments]  ${merchant_slug}  ${slug-pkey}  ${lang}=th  ${query_str}=${EMPTY}
    Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_URL}/m-${merchant_slug}-category-${slug-pkey}.html${query_str}   ${BROWSER}
    ...  ELSE   Open Browser   ${ITM_URL}/${lang}/m-${merchant_slug}-category-${slug-pkey}.html${query_str}   ${BROWSER}

Open ITM level C Web With URI
    [Arguments]    ${uri}    ${lang}=th
    # ex. uri=/category/clearance-3776607921569.html
    Run Keyword If    '${lang}'=='th'    Open Browser    ${ITM_URL}${uri}    ${BROWSER}
    ...    ELSE    Open Browser    ${ITM_URL}/${lang}${uri}    ${BROWSER}

Display Level C Page
    Wait Until Element Is Visible   ${productlist_wrapper}
    Element Should Be Visible       ${productlist_wrapper}

Go to all category
    Click Element    ${side_bar_collection}
    Wait Until Element Is Visible    ${link_to_all_category}    15s
    Click Element    ${link_to_all_category}
    Wait Until Element Is Visible    ${flash_cate_elements}    15s

Back to all category
    Wait Until Element Is Visible    ${back_to_all_category_link}   15s
    Click Element   ${back_to_all_category_link}
    Wait Until Element Is Visible    ${flash_cate_elements}    15s

Go to all collection
    Click Element    ${side_bar_collection}
    Wait Until Element Is Visible    ${link_to_all_collection}    15s
    Log to console    ${link_to_all_collection}
    ${link_to_all_collection_element}=    Get Webelement    ${link_to_all_collection}
    Scroll to element    ${link_to_all_collection_element}    0    100
    Click Element    ${link_to_all_collection}
    Wait Until Element Is Visible    ${flash_coll_elements}    15s

level C page - Go to level C
    [Arguments]    ${category_name1}
    ${get_flash_cate_elements}=    Get Webelements    ${flash_cate_elements}
    : FOR    ${element}    IN    @{get_flash_cate_elements}
    \    Log to console    text::${element.text}
    \    ${flash_cate_element}=    Set Variable If    '${element.text}' == '${category_name1}'    ${element}    ${EMPTY}
    \    ${is_contain_expected}=    Set Variable If    '${element.text}' == '${category_name1}'    ${TRUE}    ${FALSE}
    \    Run Keyword If    '${element.text}' == '${category_name1}'    Exit For Loop
    Should Be Equal    ${is_contain_expected}    ${TRUE}
    Click Element    ${flash_cate_element}
    ${log_location}=    Log Location
    Go To    ${log_location}?no-cache=1

level C page - Go to collection
    [Arguments]    ${collection_name1}
    ${get_flash_coll_elements}=    Get Webelements    ${flash_coll_elements}
    : FOR    ${element}    IN    @{get_flash_coll_elements}
    \    Log to console    text::${element.text}
    \    ${flash_coll_element}=    Set Variable If    '${element.text}' == '${collection_name1}'    ${element}    ${EMPTY}
    \    ${is_contain_expected}=    Set Variable If    '${element.text}' == '${collection_name1}'    ${TRUE}    ${FALSE}
    \    Run Keyword If    '${element.text}' == '${collection_name1}'    Exit For Loop
    Should Be Equal    ${is_contain_expected}    ${TRUE}
    Log to console    ${flash_coll_element}
    Scroll to element    ${flash_coll_element}    0    100
    Click Element    ${flash_coll_element}
    ${log_location}=    Log Location
    Go To    ${log_location}?no-cache=1

level C page - Display products under category
    [Arguments]    ${product_name2}    ${product_name1}
    ${get_level_c_thumbnail_count}=    Get Matching Xpath Count    ${level_c_thumbnail}
    ${get_total_items}=    Get Text    ${total_items}
    Should Contain    ${get_total_items}    ${get_level_c_thumbnail_count}
    ${get_level_c_thumbnail_element}=    Get Webelements    ${level_c_thumbnail}
    ${expected_products}=    Create List
    Append To List    ${expected_products}    ${product_name2}    ${product_name1}
    ${result_products}=    Create List
    : FOR    ${element}    IN    @{get_level_c_thumbnail_element}
    \    ${text_split}=    Get Substring    ${element.text}    0    -3
    \    Append To List    ${result_products}    ${text_split}
    ${sorted_expected_products}=    Sort List    ${expected_products}
    ${sorted_result_products}=    Sort List    ${result_products}
    Log to console    expected_products::${expected_products}
    Log to console    result_products::${result_products}
    ${expected_products_length}=    Get Length    ${expected_products}
    Log to console    expected_products_length::${expected_products_length}
    : FOR    ${INDEX}    IN RANGE    0    ${expected_products_length}
    \    Log to console    forIndex:${INDEX}
    \    ${expected_product}=    Get From List    ${expected_products}    ${INDEX}
    \    ${result_product}=    Get From List    ${result_products}    ${INDEX}
    \    Should Contain    ${expected_product}    ${result_product}

Data in Promotion tree are the same as collection returned from API
    # Click to Show All Collection
    Wait Until Element Is Visible   //a[@rel="nofollow"]
    Click Element   //a[@rel="nofollow"]

    Wait Until Element Is Visible   //a[@href="#see-more-collection"]
    Wait Until Element Is Visible   //a[@href="#see-more-category"]
#    Click Element   //a[@href="#see-more-collection"]
#    Click Element   //a[@href="#see-more-category"]

    # Define Items Path
    ${PromotionTreePath}=         Set Variable   //div[@id="filter-list-collection"]/div[@class="filter-list filter-list-type-link"]//a[contains(@class,"list-item")]
    ${CategoryTreePath}=          Set Variable   //div[@id="filter-list-category"]/div[@class="filter-list filter-list-type-link"]//a[contains(@class,"list-item")]
    Wait Until Element Is Visible  ${PromotionTreePath}
    Wait Until Element Is Visible  ${CategoryTreePath}

    # Compare Number of Items from API and Number of Items On Page
    ${countPromotionTreeOnPage}=  Get Matching Xpath Count   ${PromotionTreePath}
    ${countCategoryTreeOnPage}=   Get Matching Xpath Count   ${CategoryTreePath}
    ${totalTreeOnPage}=           Evaluate   ${countPromotionTreeOnPage}+${countCategoryTreeOnPage}

    Log to Console   countPromotionTreeOnPage=${countPromotionTreeOnPage}
    Log to Console   countCategoryTreeOnPage=${countCategoryTreeOnPage}
    Log to Console   totalTreeOnPage=${totalTreeOnPage}

    ${promotion_api}=    Wemall Common - Get Value From Test Variable   promotion_api
    ${TotalCollection}=  Get Length      ${promotion_api}
    Should Be Equal As Integers     ${totalTreeOnPage}    ${TotalCollection}

    # Loop To Checking Item Pkey Is Exist On Page Link
    :FOR     ${promotion}   IN       @{promotion_api}
    \   ${promotion_pkey}=   Get From Dictionary   ${promotion}   pkey
    \   ${promotion_pds_collection}=   Get From Dictionary   ${promotion}   pds_collection
    \   Log to console   ${promotion_pkey} pds=${promotion_pds_collection}
    \   ${detect_path}=   Run Keyword If  '${promotion_pds_collection}'=='1' or '${promotion_pds_collection}'=='0'  Set Variable   ${PromotionTreePath}
     ...                  ELSE  Set Variable   ${CategoryTreePath}
    \   Wait Until Page Contains Element   ${detect_path}[contains(@href,"${promotion_pkey}")]
    \   Page Should Contain Element        ${detect_path}[contains(@href,"${promotion_pkey}")]
    \   Log to console   --------> Path=${detect_path}[contains(@href,"${promotion_pkey}")]

    \   ${title}=  Get Text  ${detect_path}[contains(@href,"${promotion_pkey}")]
    \   Log to console   --------> Title=${title}

Data in brand list under the collection are the same as brand returned from API
    Wait Until Element Is Visible   //div[@class='box-title'][contains(text(), 'Brand')]
    Wait Until Element Is Visible   //div[@class='brandlist_options']

    # Define Items Path
    ${BrandList}=         Set Variable   //ul[@class='list']/li
    # Compare Number of Items from API and Number of Items On Page
    ${BrandOnPage}=  Get Matching Xpath Count   ${BrandList}

    Log to Console   countBrandOnPage=${BrandOnPage}

    ${brandincollection_api}=    Wemall Common - Get Value From Test Variable   brandincollection_api
    ${totalbrandapi}=  Get Length      ${brandincollection_api}
    Should Be Equal As Integers     ${BrandOnPage}    ${totalbrandapi}
    Log to Console      ${totalbrandapi}

    ${brandPath}=  Set Variable   //ul[@class="list"]/li/a

    # Loop To Checking Item Pkey Is Exist On Page Link
    :FOR     ${brand}   IN       @{brandincollection_api}
    \   ${brand_pkey}=   Get From Dictionary   ${brand}   pkey
    \   Log to console   ${brand_pkey}
    \   Wait Until Page Contains Element   ${brandPath}[contains(@href,"${brand_pkey}")]
    \   Page Should Contain Element        ${brandPath}[contains(@href,"${brand_pkey}")]
    \   Log to console   --------> Path=${brandPath}[contains(@href,"${brand_pkey}")]

    \   ${title}=  Get Text  ${brandPath}[contains(@href,"${brand_pkey}")]
    \   Log to console   --------> Name=${title}

