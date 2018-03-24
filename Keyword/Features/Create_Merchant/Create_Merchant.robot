*** Settings ***
Library           Selenium2Library
Resource          ../../../Resource/WebElement/PDS/Merchant/Create_Merchant.robot
Resource          ../../../Resource/Env_config.robot

*** Keywords ***
Fill Merchant Info
    [Arguments]    ${Text-MerchantCompanyName}    ${Text-MerchantSlug}    ${Text-MerchantShopName}    ${Text-MerchantShopNameEN}    ${Text-MerchantShopURL}    ${Text-MerchantShopCate}
    Wait Until Element Is Visible    ${MerchantCompanyName}    60s
    Input Text    ${MerchantCompanyName}    ${Text-MerchantCompanyName}
    Input Text    ${MerchantSlug}    ${Text-MerchantSlug}
    Input Text    ${MerchantShopName}    ${Text-MerchantShopName}
    Retry MerchantShopName    ${Text-MerchantShopName}
    Input Text    ${MerchantShopNameEN}    ${Text-MerchantShopNameEN}
    Click Element    ${MerchantShopName}
    Retry MerchantShopNameEN    ${Text-MerchantShopNameEN}
    Retry MerchantCompanyName    ${Text-MerchantCompanyName}
    [Teardown]

Fill Contacts
    [Arguments]    ${Text-MerchantContactPerson}    ${Text-MerchantContactPhone}    ${Text-MerchantContactEmail}
    Click Add Contacts
    Wait Until Element Is Visible    ${MerchantContactPerson}    60s
    Input Text    ${MerchantContactPerson}    ${Text-MerchantContactPerson}
    Input Text    ${MerchantContactPhone}    ${Text-MerchantContactPhone}
    Input Text    ${MerchantContactEmail}    ${Text-MerchantContactEmail}
    Retry MerchantContactPerson    ${Text-MerchantContactPerson}
    Retry MerchantContactPhone    ${Text-MerchantContactPhone}
    Retry MerchantContactEmail    ${Text-MerchantContactEmail}
    Click Create Contact

Upload Img Logo
    [Arguments]    ${Img_M_Logo}    ${Img_D_Logo}
    Comment    Wait Until Element Is Visible    ${MerchantMobileLogoUpload}    20s
    Choose File    ${MerchantMobileLogoUpload}    ${Path-ImgFile}\\${Img_M_Logo}
    Comment    Wait Until Element Is Not Visible    //div/i[contains(@class,\"fa-refresh\")]    20s
    Choose File    ${MerchantDesktopLogoUpload}    ${Path-ImgFile}\\${Img_D_Logo}
    Wait Until Element Is Not Visible    //div/i[contains(@class,\"fa-refresh\")]    60s

Click Add Contacts
    Wait Until Element Is Not Visible    //div[@name='loader']    60s
    Wait Until Element Is Visible    ${MerchantAddContact}    60s
    Wait Until Element Is Enabled    ${MerchantAddContact}    60s
    Focus    ${MerchantAddContact}
    Click Element    ${MerchantAddContact}

Click Create Merchant
    Wait Until Element Is Visible    ${MerchantCreateBtn}    60s
    Wait Until Element Is Enabled    ${MerchantCreateBtn}    60s
    Click Element    ${MerchantCreateBtn}
    Wait Until Element Is Visible    //button[@class=\"btn btn-success alertDialogConfirmButton\"]    60s
    Click Element    //button[@class=\"btn btn-success alertDialogConfirmButton\"]

Click Create Contact
    Wait Until Element Is Visible    ${MerchantCreateContact}    60s
    Wait Until Element Is Enabled    ${MerchantCreateContact}    60s
    Click Element    ${MerchantCreateContact}

Select Shop Category
    [Arguments]    ${Text-MerchantShopCate}
    Wait Until Element Is Visible    ${MerchantShopCate}    60s
    Wait Until Element Is Enabled    ${MerchantShopCate}    60s
    Click Element    ${MerchantShopCate}
    ${present}=    Run Keyword And Return Status    Element Should Be Visible    ${MerchantShopCate_No_Result}
    Run keyword if    ${present}    Reattempt to select Shop Cate
    Wait Until Element Is Enabled    ${Input_MerchantShopCate}    60s
    Input Text    ${Input_MerchantShopCate}    ${Text-MerchantShopCate}
    Click Element    ${First_MerchantShopCate}

Reattempt to Input Shop Name
    [Arguments]    ${Text-MerchantShopName}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantShopName}    ${Text-MerchantShopName}
    \    Click Element    ${MerchantShopNameEN}
    \    ${validate_MerchantShopName}    Get Text    ${MerchantShopName}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantShopName}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Shop Name EN
    [Arguments]    ${Text-MerchantShopNameEN}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantShopNameEN}    ${Text-MerchantShopNameEN}
    \    Click Element    ${MerchantShopName}
    \    ${validate_MerchantShopName}    Get Text    ${MerchantShopNameEN}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantShopName}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Shop URL
    [Arguments]    ${Text-MerchantShopURL}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantShopURL}    ${Text-MerchantShopURL}
    \    Click Element    ${MerchantShopName}
    \    ${validate_MerchantShopURL}    Get Text    ${MerchantShopURL}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantShopURL}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Slug
    [Arguments]    ${Text-MerchantSlug}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantSlug}    ${Text-MerchantSlug}
    \    Click Element    ${MerchantShopName}
    \    ${validate_MerchantSlug}    Get Text    ${MerchantSlug}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantSlug}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Company Name
    [Arguments]    ${Text-MerchantCompanyName}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantCompanyName}    ${Text-MerchantCompanyName}
    \    Click Element    ${MerchantShopName}
    \    ${validate_MerchantCompanyName}    Get Text    ${MerchantCompanyName}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantCompanyName}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Contract Person
    [Arguments]    ${Text-MerchantContactPerson}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantContactPerson}    ${Text-MerchantContactPerson}
    \    Click Element    ${MerchantContactPhone}
    \    ${validate_MerchantContactPerson}    Get Text    ${MerchantContactPerson}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantContactPerson}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Contract Phone
    [Arguments]    ${Text-MerchantContactPhone}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantContactPhone}    ${Text-MerchantContactPhone}
    \    Click Element    ${MerchantContactPerson}
    \    ${validate_MerchantContactPhone}    Get Text    ${MerchantContactPhone}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantContactPhone}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Contract Email
    [Arguments]    ${Text-MerchantContactEmail}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantContactEmail}    ${Text-MerchantContactEmail}
    \    Click Element    ${MerchantContactPerson}
    \    ${validate_MerchantContactEmail}    Get Text    ${MerchantContactEmail}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantContactEmail}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to select Shop Cate
    [Arguments]    ${Text-ShopCate}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    ${is_noresult}=    Run Keyword And Return Status    Element Should Be Visible    ${MerchantShopCate_No_Result}
    \    Return From Keyword If    ${is_noresult}==${False}
    \    ${is_block_present}=    Run Keyword And Return Status    Element Should not Be Visible    ${MerchantShopCate}
    \    Run Keyword If    ${is_block_present}==${True}    Click Element    ${MerchantShopCate}
    \    Click Element    ${Input_MerchantShopCate}
    \    ${noresult_present}=    Run Keyword And Return Status    Element Should Be Visible    ${MerchantShopCate_No_Result}
    \    Run Keyword If    ${noresult_present}==${False}    Exit For Loop

Retry MerchantContactPerson
    [Arguments]    ${Text-MerchantContactPerson}
    ${validate_MerchantContactPerson}    Get Value    ${MerchantContactPerson}
    ${present_MerchantContactPerson}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantContactPerson}
    Run Keyword If    ${present_MerchantContactPerson}    Reattempt to Input Contract Person    ${Text-MerchantContactPerson}

Retry MerchantContactPhone
    [Arguments]    ${Text-MerchantContactPhone}
    ${validate_MerchantContactPhone}    Get Value    ${MerchantContactPhone}
    ${present_MerchantContactPhone}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantContactPhone}
    Run Keyword If    ${present_MerchantContactPhone}    Reattempt to Input Contract Phone    ${Text-MerchantContactPhone}

Retry MerchantContactEmail
    [Arguments]    ${Text-MerchantContactEmail}
    ${validate_MerchantContactEmail}    Get Value    ${MerchantContactEmail}
    ${present_MerchantContactEmail}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantContactEmail}
    Run Keyword If    ${present_MerchantContactEmail}    Reattempt to Input Contract Email    ${Text-MerchantContactEmail}

Retry MerchantShopName
    [Arguments]    ${Text-MerchantShopName}
    ${validate_MerchantShopName}    Get Value    ${MerchantShopName}
    ${present_MerchantShopName}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantShopName}
    Run Keyword If    ${present_MerchantShopName}    Reattempt to Input Shop Name    ${Text-MerchantShopName}

Retry MerchantShopName EN
    [Arguments]    ${Text-MerchantShopNameEN}
    ${validate_MerchantShopName}    Get Value    ${MerchantShopNameEN}
    ${present_MerchantShopName}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantShopName}
    Run Keyword If    ${present_MerchantShopName}    Reattempt to Input Shop Name    ${Text-MerchantShopNameEN}

Retry MerchantShopURL
    [Arguments]    ${Text-MerchantShopURL}
    ${validate_MerchantShopURL}    Get Value    ${MerchantShopURL}
    ${present_MerchantShopURL}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantShopURL}
    Run Keyword If    ${present_MerchantShopURL}    Reattempt to Input Shop URL    ${Text-MerchantShopURL}

Retry MerchantSlug
    [Arguments]    ${Text-MerchantSlug}
    ${validate_MerchantSlug}    Get Value    ${MerchantSlug}
    ${present_MerchantSlug}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantSlug}
    Run Keyword If    ${present_MerchantSlug}    Reattempt to Input Slug    ${Text-MerchantSlug}

Retry MerchantCompanyName
    [Arguments]    ${Text-MerchantCompanyName}
    ${validate_MerchantCompanyName}    Get Value    ${MerchantCompanyName}
    ${present_MerchantCompanyName}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantCompanyName}
    Run Keyword If    ${present_MerchantCompanyName}    Reattempt to Input Company Name    ${Text-MerchantCompanyName}
