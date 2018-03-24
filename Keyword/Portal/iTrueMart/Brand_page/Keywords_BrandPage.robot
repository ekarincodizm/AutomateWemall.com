*** Settings ***
Library           Selenium2Library
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_BrandPage.robot

*** Variables ***

*** Keywords ***
Brand - Open ITM Brand With Brand Slug-Pkey
    [Arguments]    ${slug-pkey}   ${lang}=th   ${query_str}=${EMPTY}
    Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_URL}/brand/${slug-pkey}.html${query_str}   ${BROWSER}
     ...      ELSE   Open Browser   ${ITM_URL}/${lang}/brand/${slug-pkey}.html${query_str}   ${BROWSER}

Go to Brand Page with No Cache
    [Arguments]    ${Brand_Name}    ${Brand_Key}
    Open Browser    http://www.itruemart-dev.com/brand/${Brand_Name}-${Brand_Key}    chrome

Brand - Verify Out Of Stock is not displayed
    [Arguments]    ${Product_Name}
    ${OutOfStock_element}    Replace String    ${Brand_OutOfStock_Img}    REPLACE_ME    ${Product_Name}
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    Run keyword if    ${present}    Reattempt to reload Brand page when Out of Stock Still Displayed    ${Product_Name}
    Element Should Not Be Visible    ${OutOfStock_element}

Brand - Verify Out Of Stock is displayed
    [Arguments]    ${Product_Name}
    ${OutOfStock_element}    Replace String    ${Brand_OutOfStock_Img}    REPLACE_ME    ${Product_Name}
    ${present}=    Run Keyword And Return Status    Element Should Not Be Visible    ${OutOfStock_element}
    Run keyword if    ${present}    Reattempt to reload Brand page when Out of Stock Not Displayed    ${Product_Name}
    Element Should Be Visible    ${OutOfStock_element}

Reattempt to reload Brand page when Out of Stock Not Displayed
    [Arguments]    ${Product_Name}
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${OutOfStock_element}    Replace String    ${Brand_OutOfStock_Img}    REPLACE_ME    ${Product_Name}
    \    ${is_noresult}=    Run Keyword And Return Status    Element Should Not Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_noresult}==${True}    Reload Page
    \    sleep    5

Reattempt to reload Brand page when Out of Stock Still Displayed
    [Arguments]    ${Product_Name}
    : FOR    ${INDEX}    IN RANGE    0    3
    \    ${OutOfStock_element}    Replace String    ${Brand_OutOfStock_Img}    REPLACE_ME    ${Product_Name}
    \    ${is_noresult}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_noresult}==${True}    Reload Page

Brand - Verify Out of stock is displayed by Product key
    [Arguments]    ${Product_key}
    ${OutOfStock_element}    Replace String    ${Brand_OutOfStock_Img_Multi_Variance}    REPLACE_ME    ${Product_key}
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${is_oos_display}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_oos_display}==${False}    Reload Page
    \    Exit For Loop If    ${is_oos_display}==${True}
    sleep    5
    Element Should Be Visible    ${OutOfStock_element}

Brand - Verify Out of stock is NOT displayed by Product key
    [Arguments]    ${Product_key}
    ${OutOfStock_element}    Replace String    ${Brand_OutOfStock_Img_Multi_Variance}    REPLACE_ME    ${Product_key}
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${is_oos_display}=    Run Keyword And Return Status    Element Should Be Visible    ${OutOfStock_element}
    \    Run Keyword If    ${is_oos_display}==${True}    Reload Page
    \    Exit For Loop If    ${is_oos_display}==${False}
    sleep    5
    Element Should Not Be Visible    ${OutOfStock_element}
