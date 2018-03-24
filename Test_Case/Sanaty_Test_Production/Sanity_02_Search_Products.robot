*** Settings ***
Resource          ../../Keyword/Features/Sanity_Test/Keywords_Sanity_Production.robot

*** Variables ***
${Browser}        chrome
${Search_Keyword}    iphone
${Brand_Product_Pkey}    6931849325692
${Category_Product_Pkey}    3259084765891
${Product_Product_Pkey}    2254676854358
${expected_search_text}    iphone

*** Test Cases ***
Level C brand page header - Search Product
    [Tags]    Sanity
    Open Browser    http://www.wemall.com/brand/${Brand_Product_Pkey}.html    ${Browser}    None
    Maximize Browser Window
    Location Should Be    http://www.wemall.com/brand/samsung-6931849325692.html
    Keywords_Sanity_Production.Verify Search Box Exist
    Keywords_Sanity_Production.Verify Autosuggestion    ${Search_Keyword}    ${expected_search_text}
    Keywords_Sanity_Production.Search Product in WeMall    ${Search_Keyword}
    Keywords_Sanity_Production.Verify Search Text Box and Page Will Redirect to Search Page    ${Search_Keyword}
    [Teardown]    Run Keywords    Close All Browsers

Level C category page header - Search Product
    [Tags]    Sanity
    Open Browser    http://www.wemall.com/category/${Category_Product_Pkey}.html    ${Browser}    None
    Maximize Browser Window
    Location Should Be    http://www.wemall.com/category/watches-3259084765891.html
    Keywords_Sanity_Production.Verify Search Box Exist
    Keywords_Sanity_Production.Verify Autosuggestion    ${Search_Keyword}    ${expected_search_text}
    Keywords_Sanity_Production.Search Product in WeMall    ${Search_Keyword}
    Keywords_Sanity_Production.Verify Search Text Box and Page Will Redirect to Search Page    ${Search_Keyword}
    [Teardown]    Run Keywords    Close All Browsers

Everyday Wow page header - Search Product
    [Tags]    Sanity
    Open Browser    http://www.wemall.com/everyday-wow    ${Browser}    None
    Maximize Browser Window
    Location Should Be    http://www.wemall.com/everyday-wow
    Keywords_Sanity_Production.Verify Search Box Exist
    Keywords_Sanity_Production.Verify Autosuggestion    ${Search_Keyword}    ${expected_search_text}
    Keywords_Sanity_Production.Search Product in WeMall    ${Search_Keyword}
    Keywords_Sanity_Production.Verify Search Text Box and Page Will Redirect to Search Page    ${Search_Keyword}
    [Teardown]    Run Keywords    Close All Browsers

Level D header - Search Product
    [Tags]    Sanity
    Open Browser    http://www.wemall.com/products/${Product_Product_Pkey}.html    ${Browser}    None
    Maximize Browser Window
    Location Should Be    http://www.wemall.com/products/iphone-se-2254676854358.html
    Keywords_Sanity_Production.Verify Search Box Exist
    Keywords_Sanity_Production.Verify Autosuggestion    ${Search_Keyword}    ${expected_search_text}
    Keywords_Sanity_Production.Search Product in WeMall    ${Search_Keyword}
    Keywords_Sanity_Production.Verify Search Text Box and Page Will Redirect to Search Page    ${Search_Keyword}
    [Teardown]    Run Keywords    Close All Browsers

*** Keywords ***
