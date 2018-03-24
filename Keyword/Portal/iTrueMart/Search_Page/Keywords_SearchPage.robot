*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../Common/Keywords_Common.robot
Resource          WebElement_SearchPage.robot

*** Variables ***

*** Keywords ***
Open ITM Search With Search String
    [Arguments]  ${key}=iphone  ${lang}=th
    Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_URL}/search2?q=${key}&per_page=60&page=1%3Fno-cache%3D1%3Fno-cache%3D1      ${BROWSER}
     ...      ELSE   Open Browser   ${ITM_URL}/${lang}/search2?q=${key}&per_page=60&page=1%3Fno-cache%3D1%3Fno-cache%3D1           ${BROWSER}

Go to Search Page with No Cache
    [Arguments]    ${Search_Name}
    Open Browser    http://www.itruemart-dev.com/search2?q=${Search_Name}&per_page=60&page=1%3Fno-cache%3D1%3Fno-cache%3D1    chrome

Display Search Page
    Wait Until Element Is Visible   ${lb_search_result}
    Element Should Be Visible       ${lb_search_result}

Search - Verify Out Of Stock is not displayed
    [Arguments]    ${SKU_ID}
    ${OutOfStock_element}    Replace String    ${Search_OutOfStock_Img}    REPLACE_ME    ${SKU_ID}
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    Run keyword if    ${present}    Reattempt to reload Search page when Out of Stock Still Displayed    ${SKU_ID}
    sleep    10
    Element Should Not Be Visible    ${OutOfStock_element}

Search - Verify Out Of Stock is displayed
    [Arguments]    ${SKU_ID}
    ${OutOfStock_element}    Replace String    ${Search_OutOfStock_Img}    REPLACE_ME    ${SKU_ID}
    ${present}=    Run Keyword And Return Status    Element Should Not Be Visible    ${OutOfStock_element}
    Run keyword if    ${present}    Reattempt to reload Search page when Out of Stock Not Displayed    ${SKU_ID}
    Element Should Be Visible    ${OutOfStock_element}

Reattempt to reload Search page when Out of Stock Not Displayed
    [Arguments]    ${SKU_ID}
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${OutOfStock_element}    Replace String    ${Search_OutOfStock_Img}    REPLACE_ME    ${SKU_ID}
    \    ${is_noresult}=    Run Keyword And Return Status    Element Should Not Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_noresult}==${True}    Reload Page
    \    sleep    5

Reattempt to reload Search page when Out of Stock Still Displayed
    [Arguments]    ${SKU_ID}
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${OutOfStock_element}    Replace String    ${Search_OutOfStock_Img}    REPLACE_ME    ${SKU_ID}
    \    ${is_noresult}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_noresult}==${True}    Reload Page
    \    sleep    5

Search - Wait until product image is visible
    [Arguments]    ${cdn_image_path}
    ${Search_Image_Path_Element}    Replace String    ${Search_Image_Path}    REPLACE_ME    ${cdn_image_path}
    Wait Until Element Is Visible    ${Search_Image_Path_Element}    60

Verify Search Result Label
    [Arguments]    ${expected_search_words}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${result_search_label}    5s
    Run Keyword If    ${result} == False    Sleep    1s
    Wait Until Element Is Visible    ${result_search_label}    30
    ${actual_search_words}=    Get Text    ${result_search_words_label}
    Should Be Equal As Strings    '${expected_search_words}'    ${actual_search_words}





