*** Settings ***
Library           Selenium2Library
Resource          ../../../Resource/WebElement/PDS/Merchant/Merchant_List.robot
Resource          ../../../Resource/Env_config.robot
Library           String

*** Keywords ***
Search Merchant
    [Arguments]    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${MerchantName}    60s
    Reattemp to clear Merchant name
    Input Text    ${MerchantName}    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${FilterButton}    60s
    sleep    5s
    Click Element    ${FilterButton}
    ${validate_MerchantName}    Get Value    ${MerchantName}
    ${present}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantName}
    Run Keyword If    ${present}    Reattempt to Input Merchant Name    ${Text-MerchantShopName}
    ${element_Table_MerchantIDByMerchantName}=    Replace String    ${Table_MerchantIDByMerchantName}    REPLACE_ME    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${element_Table_MerchantIDByMerchantName}    60s

Select Merchant
    [Arguments]    ${Text-MerchantShopName}
    ${element_Table_MerchantIDByMerchantName}=    Replace String    ${Table_MerchantIDByMerchantName}    REPLACE_ME    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${element_Table_MerchantIDByMerchantName}
    ${UrlMerchantID}=    Get Text    ${element_Table_MerchantIDByMerchantName}
    Click Element    ${element_Table_MerchantIDByMerchantName}
    Wait Until Element Is Not Visible    ${loader}    30
    [Return]    ${UrlMerchantID}

Reattempt to Input Merchant Name
    [Arguments]    ${Text-MerchantShopName}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${MerchantName}    ${Text-MerchantShopName}
    \    Click Element    ${FilterButton}
    \    ${validate_MerchantName}    Get Text    ${MerchantName}
    \    ${is_MerchantName_display}=    Run Keyword And Return Status    Should Be Empty    ${validate_MerchantName}
    \    Run Keyword If    ${is_MerchantName_display}    Exit For Loop

Click waiting Status
    [Arguments]    ${Text-MerchantShopName}
    ${element_Table_Merchant_Status_Waiting}=    Replace String    ${Table_Merchant_Status_Waiting}    REPLACE_ME    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${element_Table_Merchant_Status_Waiting}
    Click Element    ${element_Table_Merchant_Status_Waiting}
    Wait Until Element Is Visible    //div[@class="jconfirm-box"]/div[4]/button[1]
    Click Element    //div[@class="jconfirm-box"]/div[4]/button[1]
    sleep    2s

Change status to Active
    [Arguments]    ${Text-MerchantShopName}
    ${element_Merchant_Status_Dropdown}=    Replace String    ${Table_Merchant_Status_Dropdown}    REPLACE_ME    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${element_Merchant_Status_Dropdown}
    Click Element    ${element_Merchant_Status_Dropdown}
    ${element_Merchant_Status_Active}=    Replace String    ${Table_Merchant_Status_Active}    REPLACE_ME    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${element_Merchant_Status_Active}
    Click Element    ${element_Merchant_Status_Active}

Change status to InActive
    [Arguments]    ${Text-MerchantShopName}
    ${element_Merchant_Status_Dropdown}=    Replace String    ${Table_Merchant_Status_Dropdown}    REPLACE_ME    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${element_Merchant_Status_Dropdown}
    Click Element    ${element_Merchant_Status_Dropdown}
    ${element_Table_Merchant_Status_InActive}=    Replace String    ${Table_Merchant_Status_InActive}    REPLACE_ME    ${Text-MerchantShopName}
    Wait Until Element Is Visible    ${element_Table_Merchant_Status_InActive}
    Click Element    ${element_Table_Merchant_Status_InActive}
    Wait Until Element Is Not Visible    //div[@name='loader']    60s
    Wait Until Element Is Visible    //div[@class="jconfirm-box"]/div[4]/button[1]    60s
    Click Element    //div[@class="jconfirm-box"]/div[4]/button[1]
    sleep    2s

Click Update Merchant
    Wait Until Element Is Visible    ${Update_btn}
    Click Element    ${Update_btn}
    Wait Until Element Is Visible    //button[@class=\"btn btn-success alertDialogConfirmButton\"]    60s
    Click Element    //button[@class=\"btn btn-success alertDialogConfirmButton\"]

Reattemp to clear Merchant name
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Clear Element Text    ${MerchantName}
    \    ${inputbox}    Get Text    ${MerchantName}
    \    ${is_inutbox_empty}    Run Keyword And Return Status    Should Be Empty    ${inputbox}
    \    Run Keyword If    ${is_inutbox_empty}==${True}    Exit For Loop
    \    sleep    2
