*** Settings ***
Library           Selenium2Library
Library           String
Resource          ${CURDIR}/../../../../Keyword/Common/Keywords_Common.robot
Resource          WebElement_CategoryPage.robot

*** Variables ***

*** Keywords ***
Category - Open ITM Catagory With Category Slug-Pkey
    [Arguments]  ${slug-pkey}  ${lang}=th  ${query_str}=${EMPTY}
    Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_URL}/category/${slug-pkey}.html${query_str}   ${BROWSER}
     ...  ELSE   Open Browser   ${ITM_URL}/${lang}/category/${slug-pkey}.html${query_str}   ${BROWSER}

Category - Change Language
    [Arguments]    ${lang}
    ${url}=    Get location
    ${url}=    Replace String    ${url}    /category    /en/category
    Go to    ${url}
    sleep    1s

Go to Category Page with No Cache
    [Arguments]    ${category}
    Open Browser    ${ITM_URL}/category/${category}    ${BROWSER}

Category - Verify Out Of Stock is not displayed
    [Arguments]    ${Product_Name}
    ${OutOfStock_element}    Replace String    ${Category_OutOfStock_Img_Multi_Valiance}    REPLACE_ME    ${Product_Name}
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    Run keyword if    ${present}    Reattempt to reload Category page when Out of Stock Still Displayed    ${Product_Name}
    Element Should Not Be Visible    ${OutOfStock_element}

Category - Verify Out Of Stock is displayed
    [Arguments]    ${Product_Name}
    ${OutOfStock_element}    Replace String    ${Category_OutOfStock_Img}    REPLACE_ME    ${Product_Name}
    ${present}=    Run Keyword And Return Status    Element Should Not Be Visible    ${OutOfStock_element}
    Run keyword if    ${present}    Reattempt to reload Category page when Out of Stock Not Displayed    ${Product_Name}
    Element Should Be Visible    ${OutOfStock_element}

Reattempt to reload Category page when Out of Stock Not Displayed
    [Arguments]    ${Product_Name}
    : FOR    ${INDEX}    IN RANGE    0    3
    \    ${OutOfStock_element}    Replace String    ${Category_OutOfStock_Img}    REPLACE_ME    ${Product_Name}
    \    ${is_noresult}=    Run Keyword And Return Status    Element Should Not Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_noresult}==${True}    Reload Page

Reattempt to reload Category page when Out of Stock Still Displayed
    [Arguments]    ${Product_Name}
    : FOR    ${INDEX}    IN RANGE    0    3
    \    ${OutOfStock_element}    Replace String    ${Category_OutOfStock_Img}    REPLACE_ME    ${Product_Name}
    \    ${is_noresult}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_noresult}==${True}    Reload Page

Category - Verify Out of Stock is displayed by Product key
    [Arguments]    ${Product_key}
    ${OutOfStock_element}    Replace String    ${Category_OutOfStock_Img_Multi_Valiance}    REPLACE_ME    ${Product_key}
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${is_oos_display}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_oos_display}==${False}    Reload Page
    \    Exit For Loop If    ${is_oos_display}==${True}
    Element Should Be Visible    ${OutOfStock_element}

Category - Verify Outof Stock is NOT displayed by Product key
    [Arguments]    ${Product_key}
    ${OutOfStock_element}    Replace String    ${Category_OutOfStock_Img_Multi_Valiance}    REPLACE_ME    ${Product_key}
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${is_oos_display}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_oos_display}==${True}    Reload Page
    \    Exit For Loop If    ${is_oos_display}==${False}
    sleep    5
    Element Should Not Be Visible    ${OutOfStock_element}

Category - Click category menu
    [Arguments]    ${category_name}
    Scroll Element Into View    jquery=div#menu-category
    Wait Until Element Is Visible    jquery=div#menu-category
    Click Element    //div[@id="menu-category"]//a[normalize-space(text()) = "${category_name}"]
    sleep    1s

Category - Click collection menu
    [Arguments]    ${collection_name}
    Scroll Element Into View         jquery=div#menu-collection
    Wait Until Element Is Visible    jquery=div#menu-collection
    Click Element    //div[@id="menu-collection"]//a[normalize-space(text()) = "${collection_name}"]
    sleep    1s

Category - Check highlight category menu
    [Arguments]    ${category_name}
    Wait Until Element Is Visible    jquery=div#menu-category
    Locator Should Match X Times    jquery=div#menu-category a.list-item.active:contains("${category_name}")    1

Category - Check highlight collection menu
    [Arguments]    ${category_name}
    Wait Until Element Is Visible    jquery=div#menu-collection
    Locator Should Match X Times    jquery=div#menu-collection a.list-item.active:contains("${category_name}")    1

Category - Click first category menu
    Wait Until Element Is Visible    jquery=div#menu-category
    Click Element    jquery=div#menu-category a.list-item:eq(1)
    sleep    1s

Category - Click back category menu
    Wait Until Element Is Visible    ${link_category_menu_item}
    Click Element    ${link_category_menu_item}:eq(0)
    sleep    1s

Category - Click back collection menu
    Wait Until Element Is Visible    ${link_collection_menu_item}
    Click Element    ${link_collection_menu_item}:eq(0)
    sleep    1s

Category - Check other category must be disappear
    Wait Until Element Is Visible    jquery=div#menu-category
    Locator Should Match X Times    jquery=div#menu-category a.list-item:not(.sub-item)    2

Category - Go to category page
    Go to    ${ITM_URL}/category/${CategoryPage}
    sleep    1s

Category - Go to category page expain all
    Go to    ${ITM_URL}/category/${category_page_expain_all}
    sleep    1s

Category - Go to collection page expain all
    Go to    ${ITM_URL}/category/${collection_page_expain_all}
    sleep    1s

Category - Check show other categories on top line
    Element Should Contain    jquery=div#menu-category a.list-item:eq(0)    กลับไปหมวดหมู่ทั้งหมด

Category - Check expand all sub
    [Arguments]    ${category_name}    ${expected_count}
    Locator Should Match X Times    jquery=div#menu-category a.list-item.active:contains(${category_name}) ~ .sub-item    ${expected_count}

Category - Check bread crumb
    [Arguments]    ${category_name}    ${order}
    Element Should Contain    jquery=div.breadcrumbs li:eq(${order})    ${category_name}

Category - Check show see more button
    Page Should Contain Element    jquery=#see-more-category.collapse

Category - Verify css on category tree
    Page Should Contain Element    ${category_tree_box}

Category - Verify collection position by name
    [Arguments]    ${collection_name}    ${position}
    ${position}=    Evaluate    ${position}-1
    Selenium2Library.Element Text Should Be    ${category_tree_box} > div[id*="menu-"]:eq(${position}) h3    ${collection_name}

Category - Verify Menu Item position by name
    [Arguments]    ${name}    ${type}    ${position}
    ${position}=    Evaluate    ${position}-1
    Element Should Be Visible    ${category_tree_box} #filter-list-${type} a:eq(${position}):contains("${name}")

Category - Click See More Category
    Click Element    ${button_see_more_category}
    sleep    1s

Category - Click See Less Category
    Click Element    ${button_see_more_category}
    sleep    1s

Category - Click See More Promotion
    Click Element    ${button_see_more_collection}
    sleep    1s

Category - Click See Less Promotion
    Click Element    ${button_see_more_collection}
    sleep    1s

Category - Verify all category list
    : FOR    ${index}    IN RANGE    0    17
    \    Element Should Be Visible    ${link_category_menu_item} :eq(${index})

Category - Verify all Promotion list
    : FOR    ${index}    IN RANGE    0    17
    \    Element Should Be Visible    ${link_collection_menu_item} :eq(${index})

Category - Verify hidden Category list
    : FOR    ${index}    IN RANGE    0    17
    \    Run keyword if    ${index}<15    Element Should Be Visible    ${link_category_menu_item} :eq(${index})
    \    Run keyword if    ${index}>=15    Element Should Not Be Visible    ${link_category_menu_item} :eq(${index})

Category - Verify hidden Promotion list
    : FOR    ${index}    IN RANGE    0    17
    \    Run keyword if    ${index}<15    Element Should Be Visible    ${link_collection_menu_item} :eq(${index})
    \    Run keyword if    ${index}>=15    Element Should Not Be Visible    ${link_collection_menu_item} :eq(${index})

Category - Verify Category See More Button
    ${text}=    Get Text    ${button_see_more_category}
    log to console    ${text}

Category - Verify Promotion See More Button
    ${text}=    Get Text    ${button_see_more_category}
    log to console    ${text}

Category - Category Should Not Be Visible
    [Arguments]    ${name}
    Element Should Not Be Visible    ${link_category_menu_item} :contains(${name})

Category - Collection Should Not Be Visible
    [Arguments]    ${name}
    Element Should Not Be Visible    ${link_collection_menu_item} :contains(${name})
