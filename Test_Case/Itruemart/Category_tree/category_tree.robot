*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Category_page/Keywords_CategoryPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Category_page/WebElement_CategoryPage.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Collection/keywords_collection.robot
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String

*** Variables ***
${prefix_collection}    Hulk -

*** Test Cases ***
TC_iTM_01516 - Portal category page can landing page by category slug.
    [Tags]    TC_iTM_01516   ready
    Category - Go to category page
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Location Should Contain    hulk-category-1-
    Category - Check highlight category menu    ${prefix_collection} แคททะกอรี 1

TC_iTM_01517 - Other category must be disappear.
    [Tags]    TC_iTM_01517   ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - category Should Not Be Visible    ${prefix_collection} แคททะกอรี 2
    Category - category Should Not Be Visible    ${prefix_collection} แคททะกอรี 3
    Category - collection Should Not Be Visible    ${prefix_collection} โปรโมชั่น 1
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1    category    2

TC_iTM_01518 - Select category, category tree will expand all sub category under parent category, hi-light on selected category and shown.
    [Tags]    TC_iTM_01518   ready
    Category - Go to category page
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1.1
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1.1.3
    Category - Check highlight category menu    ${prefix_collection} แคททะกอรี 1.1.1.3
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1    category    2
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1.1    category    3
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1.1.1    category    4
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1.1.1.1    category    5
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1.1.1.2    category    6
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1.1.1.3    category    7
    Category - Verify Menu Item position by name    ${prefix_collection} แคททะกอรี 1.1.1.4    category    8

TC_iTM_01519 other categories button
    [Tags]    TC_iTM_01519  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 11
    Category - Click back category menu
    Category - Check highlight category menu    ${prefix_collection} แคททะกอรี 11
    Category - Verify hidden Category list

TC_iTM_02201 Select category more than line 15
    [Tags]    TC_iTM_02201  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Click back category menu
    Category - Click See More Category
    Category - Click category menu    ${prefix_collection} แคททะกอรี 9
    Category - Click back category menu
    Category - Check highlight category menu    ${prefix_collection} แคททะกอรี 9
    Category - Verify all category list

TC_iTM_01520 - Select category, category slug and bread crumb work correctly.
    [Tags]    TC_iTM_01520   ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Check bread crumb    ${prefix_collection} แคททะกอรี 1    0
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.2
    Category - Check bread crumb    ${prefix_collection} แคททะกอรี 1.2    1
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.2.1
    Category - Check bread crumb    ${prefix_collection} แคททะกอรี 1.2.1    2
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.2.1.1
    Category - Check bread crumb    ${prefix_collection} แคททะกอรี 1.2.1    3

TC_iTM_01521 Select category, the page must be shown product of category correctly.
    [Tags]    TC_iTM_01521    ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Scroll Element Into View     id=2782548680360
    Element Should Be Visible    id=2782548680360
    Scroll Element Into View      id=2624639764719
    Element Should Be Visible    id=2624639764719
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1
    Scroll Element Into View     id=2782548680360
    Element Should Be Visible    id=2782548680360
    Scroll Element Into View     id=2624639764719
    Element Should Be Visible    id=2624639764719
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1.1
    Scroll Element Into View     id=2782548680360
    Element Should Be Visible    id=2782548680360
    Scroll Element Into View     id=2624639764719
    Element Should Be Visible    id=2624639764719

TC_iTM_01522 - Category tree to support 4 levels work correctly.
    [Tags]    TC_iTM_01533  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1.1
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1.1.1.4

TC_iTM_01523 - Category tree of level1 show 15 lines, if category more than 15 lines will shown "+See more" button.
    [Tags]    TC_iTM_01523  ready
    Category - Go to category page
    Category - Check show see more button

TC_iTM_01524 - Click '+see more' button, category will expand list all category level1 correctly.
    [Tags]    TC_iTM_01524  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Click back category menu
    Category - Click See More Category
    Category - Verify all category list

TC_iTM_01525 - Click '+see less' button, category will hidden category correctly(15 lines).
    [Tags]    TC_iTM_01525  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Click back category menu
    Category - Click See More Category
    Category - Verify all category list
    Category - Click See Less Category
    Category - Verify hidden Category list

TC_iTM_01526 - Select promotion, promotion will moved up promotion position and expand sub level.
    [Tags]    TC_iTM_01526  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Check highlight category menu    ${prefix_collection} แคททะกอรี 1
    Category - Verify collection position by name    หมวดหมู่สินค้า    1

TC_iTM_01527 - Category tree on category page support EN-TH language.
    [Tags]    TC_iTM_01527  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Check bread crumb    ${prefix_collection} แคททะกอรี 1    0
    Location Should Contain    hulk-category-1-
    Category - Check highlight category menu    ${prefix_collection} แคททะกอรี 1
    Category - Change Language    en
    Category - Click category menu    ${prefix_collection} Category 1
    Category - Check bread crumb    ${prefix_collection} Category 1    0
    Location Should Contain    hulk-category-1-
    Category - Check highlight category menu    ${prefix_collection} Category 1

TC_iTM_01528 - User click on one collection, other collection must be disappear and show other collections on top line.
    [Tags]    TC_iTM_01528  ready
    Category - Go to category page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Collection Should Not Be Visible    ${prefix_collection} โปรโมชั่น 2
    Category - Collection Should Not Be Visible    ${prefix_collection} โปรโมชั่น 3
    Category - Category Should Not Be Visible    ${prefix_collection} แคททะกอรี 1
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 10    collection    2

TC_iTM_01529 - Select collection, collection tree will expand all sub category under parent collection, hi-light on selected collection and shown.
    [Tags]    TC_iTM_01529  ready
    Category - Go to collection page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1.1
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1.1.2
    Category - Check highlight collection menu    ${prefix_collection} โปรโมชั่น 1.1.1.2
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 1    collection    2
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 1.1    collection    3
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 1.1.1    collection    4
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 1.1.1.1    collection    5
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 1.1.1.2    collection    6
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 1.1.1.3    collection    7
    Category - Verify Menu Item position by name    ${prefix_collection} โปรโมชั่น 1.1.1.4    collection    8

TC_iTM_01530 - Click 'other collections' button, collection tree will shown before parent collection correctly.
    [Tags]    TC_iTM_01530  ready
    Category - Go to category page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Click back collection menu
    Category - Check highlight collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Verify hidden Promotion list

TC_iTM_02202 Select collection more than line 15
    [Tags]    TC_iTM_02202  ready
    Category - Go to category page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Click back collection menu
    Category - Click See More Promotion
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 9
    Category - Click back collection menu
    Category - Check highlight collection menu    ${prefix_collection} โปรโมชั่น 9
    Category - Verify all Promotion list

TC_iTM_01531 - Select collection, collection slug and bread crumb work correctly.
    [Tags]    TC_iTM_01531  ready
    Category - Go to collection page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1
    Category - Check bread crumb    ${prefix_collection} โปรโมชั่น 1    0
    Location Should Contain    hulk-promotion-1-
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.3
    Category - Check bread crumb    ${prefix_collection} โปรโมชั่น 1.3    1
    Location Should Contain    hulk-promotion-13-

TC_iTM_01532 - Select collection, the page must be shown product of collection correctly.
    [Tags]    TC_iTM_01532  ready
    Category - Go to collection page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1
    Scroll Element Into View     id=2782548680360
    Element Should Be Visible    id=2782548680360
    Scroll Element Into View     id=2624639764719
    Element Should Be Visible    id=2624639764719
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1
    Scroll Element Into View     id=2782548680360
    Element Should Be Visible    id=2782548680360
    Scroll Element Into View     id=2624639764719
    Element Should Be Visible    id=2624639764719
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1.1
    Scroll Element Into View     id=2782548680360
    Element Should Be Visible    id=2782548680360
    Scroll Element Into View     id=2624639764719
    Element Should Be Visible    id=2624639764719

TC_iTM_01533 - Collection tree to support 4 levels
    [Tags]    TC_iTM_01533  ready
    Category - Go to collection page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1.1
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 1.1.1.1

TC_iTM_01534 - Collection tree of level1 show 15 lines, if collection more than 15 lines will shown '+see more' button.
    [Tags]    TC_iTM_01534  ready
    Category - Go to category page expain all
    Category - Click category menu    ${prefix_collection} แคททะกอรี 1
    Category - Click back category menu
    Category - Verify Category See More Button
    Category - Verify Promotion See More Button

TC_iTM_01535 - Click '+see more' button, collection will expand list all collection level1 correctly.
    [Tags]    TC_iTM_01535   ready
    Category - Go to category page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Click back collection menu
    Category - Click See More Promotion
    Category - Verify all Promotion list

TC_iTM_01536 - Click '+see less' button, collection will hidden collection correctly(15 lines).
    [Tags]    TC_iTM_01536   ready
    Category - Go to category page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Click back collection menu
    Category - Click See More Promotion
    Category - Verify all Promotion list
    Category - Click See Less Promotion
    Category - Verify hidden Promotion list

TC_iTM_01537 - Promotion will moved up promotion position and expand sub level.
    [Tags]    TC_iTM_01537   ready
    Category - Go to category page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Check highlight collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Verify collection position by name    โปรโมชั่น    1

TC_iTM_01538 - Collection tree on category page support EN-TH language.
    [Tags]    TC_iTM_01538   ready
    Category - Go to category page expain all
    Category - Click collection menu    ${prefix_collection} โปรโมชั่น 10
    Category - Check bread crumb    ${prefix_collection} โปรโมชั่น 10    0
    Location Should Contain    hulk-promotion-10-
    Category - Check highlight collection menu    ${prefix_collection} โปรโมชั่น 1
    Category - Change Language    en
    Category - Click collection menu    ${prefix_collection} Promotion 10
    Category - Check bread crumb    ${prefix_collection} Promotion 10    0
    Location Should Contain    hulk-promotion-10-
    Category - Check highlight collection menu    ${prefix_collection} Promotion 10

TC_iTM_01539 - Css on category page o assign the correct.
    [Tags]    TC_iTM_01539   ready
    Category - Go to category page
    Category - Verify css on category tree

*** Keywords ***
Suite Setup
    #save_current_collection_display    ${prefix_collection}
    Open Browser    ${ITM_URL}/category/${CategoryPage}    ${BROWSER}
    sleep    3s
    # Click Element    id=area-2

Suite Teardown
    Close All Browsers
    #restore_collection_display    ${prefix_collection}

    Collections - PrepareDataForCategoryOrCollectionTree    Category    Hulk -    Hulk -
