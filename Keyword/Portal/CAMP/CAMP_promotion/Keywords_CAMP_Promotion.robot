*** Settings ***
Library           Collections
Library           RequestsLibrary
Library           DateTime
Resource          ../../../../Resource/Env_config.robot
Library           DatabaseLibrary
Resource          ../../../Common/Keywords_Common.robot
Resource          ../../../../Resource/WebElement/CAMP/Camp_Freebie.robot
Resource          ../../../../Resource/WebElement/CAMP/Promotion_List.robot
Resource          WebElement_CAMP_Promotion.robot

*** Variables ***

*** Keywords ***
Create Freebie Promotion
    [Arguments]    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Wait Until Element Is Visible    ${CREATE_PROMOTION_BUTTON}    60s
    Click Element    ${CREATE_PROMOTION_BUTTON}
    Click Element    ${CREATE_PROMOTION_FREEBIE_BUTTON}
    Wait Until Element Is Visible    //*[@id="nameLocal"]    60s
    Input Text    //*[@id="nameLocal"]    ${Text_FreebieName}
    Input Text    //*[@id="shortDescriptionLocal"]    ${Text_FreebieShortDesc}
    Keywords_CAMP_Promotion.Input Description    ${Text_FreebieDesc}
    Click Element    //*[@id="period"]
    Input Text    //*[@id="promotionTemplate"]/div[34]/div[1]/div[1]/input    ${Text_FreebieStart}
    Input Text    //*[@id="promotionTemplate"]/div[34]/div[2]/div[1]/input    ${Text_FreebieEnd}
    Click Element    //*[@id="promotionTemplate"]/div[34]/div[3]/div/button[1]
    Click Element    //*[@id="enabled"]
    Click Element    //*[@id="criteriaTypeSelect"]
    ${element_freebie_CriteriaType}    Replace String    ${freebie_CriteriaType}    REPLACE_ME    ${Text_Freebie_CategoryType}
    Click Element    ${element_freebie_CriteriaType}
    Input Text    //*[@id="criteriaValuesDiv"]/div/input    ${Text_Freebie_Identifyer}
    Input Text    //*[@id="minTotalQuantity"]    ${Text_PeriTem}
    Input Text    //*[@id="freeVariant1"]    ${Text_FreeVariantID}
    Input Text    //*[@id="freeVariantQuantity1"]    ${Text_FreeVariantQuantity}
    Input Text    //*[@id="repeat"]    ${Text_RepeatTime}
    Input Text    //*[@id="freebieNote"]    ${Text_Note}
    Choose File    //*[@id="lvCDropzoneDiv"]/div/input    ${Path-ImgFile}${img_160x80}
    Choose File    //*[@id="lvCMobileDropzoneDiv"]/div/input    ${Path-ImgFile}${img_220x110}
    Choose File    //*[@id="lvDDropzoneDiv"]/div/input    ${Path-ImgFile}${img_320x160}
    Choose File    //*[@id="lvDMobileDropzoneDiv"]/div/input    ${Path-ImgFile}${img_320x160}
    Click Element    //*[@id="submitBtn"]
    sleep    2s
    ${Confirm_popup}    Run Keyword And Return Status    Element Should Be Visible    //*[@id="modalConfirmBtn"][contains(text(),"Confirm")]
    Run Keyword If    ${Confirm_popup}    Confirm to use existed variant
    ${element_Table_PromotionName}=    Replace String    //*[contains(@id,'promotionListTable')]//tbody//tr/td[5][contains(text(),'REPLACE_ME')]/../td[11]/button[1]    REPLACE_ME    ${Text_FreebieName}
    Wait Until Element Is Visible    ${element_Table_PromotionName}    60s

Input Description
    [Arguments]    ${input}
    Wait Until Element Is Visible    ${promotion_Description}    15
    : FOR    ${INDEX}    IN RANGE    0    5
    \    ${text}    Get Text    ${promotion_Description}
    \    ${result}    Run Keyword And Return Status    Should Contain    ${input}    ${text}
    \    Run Keyword If    ${result}==False    Execute JavaScript    CKEDITOR.instances["descriptionLocal"].setData("${input}")
    \    Exit For Loop If    ${result}==True

Create Bundle promotion
    [Arguments]    ${campaign_id}
    @{words}=    Split String    ${name}
    @{words_tran}=    Split String    ${name_trans}
    ${empty_name}=    Run Keyword And Return Status    Should Be Empty    ${words}
    ${empty_name_trans}=    Run Keyword And Return Status    Should Be Empty    ${words_tran}
    ${name}=    Set Variable If    ${empty_name}    ${EMPTY}    @{words}[0]
    ${name_trans}=    Set Variable If    ${empty_name_trans}    ${EMPTY}    @{words_tran}[0]
    Go To Promotion List under Campaign    ${campaign_id}
    Go To Create Promotions Page
    Go To Create Bundle promotion Page
    Wait Until Element Is Visible    ${CREATE-BUTTON}    5
    Input Promotion Information    ${name}    ${name_trans}    ${desc}    ${desc_trans}    ${short_desc}    ${short_desc_trans}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Input Bundle Note    ${note}
    Input Bundle Note Translation    ${note_trans}
    ${bundle_list_length}=    Get Length    ${bundle_list}
    : FOR    ${element}    IN RANGE    ${bundle_list_length}
    \    ${values}=    Get Dictionary Values    @{bundle_list}[${element}]
    \    ${bundleIndex}=    Evaluate    ${element} +1
    \    Run Keyword If    ${bundleIndex}>2    Click Element    ${ADD-VARIANT-BUTTON}
    \    Input Bundle VARIANT and Discount Detail    ${bundleIndex}    @{values}[0]    @{values}[2]    @{values}[1]
    Click Button    ${CREATE-BUTTON}

Input Promotion Information
    [Arguments]    ${name}    ${name_trans}    ${desc}    ${desc_trans}    ${short_desc}    ${short_desc_trans}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Input Text    ${NAME-FIELD}    ${name}
    Input Text    ${NAME-TRANS1-FIELD}    ${name_trans}
    Input Long Description    ${desc}
    Input Long Description Translation    ${desc_trans}
    Input Text    ${SHORT-DESC-FIELD}    ${short_desc}
    Input Text    ${SHORT-DESC-TRANS1-FIELD}    ${short_desc_trans}
    Run Keyword If    '${start_date}' != 'none'    Click Element    ${PERIOD-FIELD}
    Run Keyword If    '${start_date}' != 'none'    Wait Until Element Is Visible    ${DATETIME-MENU}
    Run Keyword If    '${start_date}' != 'default' and '${start_date}' != 'none'    Input Date Time for Period    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}
    ...    ${end_hour}    ${end_minute}
    # Use default date-time (Start:Today 00:00, End:Tomorrow 00:00)
    Run Keyword If    '${start_date}' != 'none'    Click button    ${DATETIME-APPLY}
    Run Keyword If    '${status}' == 'enable'    Select Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE IF    '${status}' == 'disable'    Unselect Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE    Log    ${status}
    Run Keyword If    '${apply_with}' == 'member' or '${apply_with}' == 'both'    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    ...    ELSE IF    '${apply_with}' != 'default'    Click Element    ${MEMBER-CHKBOX-SPAN}
    Run Keyword If    '${apply_with}' == 'nonmember' or '${apply_with}' == 'both'    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}
    ...    ELSE IF    '${apply_with}' != 'default'    Click Element    ${NONMEMBER-CHKBOX-SPAN}

Go To Create Bundle promotion Page
    Click Element    ${CREATE-PROMOTION-BUNDLE-BUTTON}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    30

Go To Create Promotions Page
    Click Element    ${CREATE-PROMOTION-BUTTON}
    Wait Until Page Contains Element    ${PROMO-TEMPLATE-TABLE}    15

Go To Promotion List under Campaign
    [Arguments]    ${camp_id}
    Go To Campaign List Page
    Input Text    ${CAMPAIGN-SEARCH-ID-FIELD}    ${camp_id}
    Click Button    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    15
    Click Element    //*[@id="promotionBtn1"]
    Wait Until Element Is Visible    ${PROMO-LIST-TABLE}    15

Input Bundle Note
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["noteLocal"].setData("${text}")

Input Bundle Note Translation
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["noteEN"].setData("${text}")

Input Bundle Variant and Discount Detail
    [Arguments]    ${index}    ${variant}    ${discount_type}    ${discount_value}
    [Documentation]    discount_type must be 'Percent' or 'Fixed'
    Input Text    //*[@id='bundledVariant${index}']    ${variant}
    Click Element    //*[@id='discount${discount_type}Span${index}']
    Input Text    //*[@id='discount${discount_type}${index}']    ${discount_value}

Go To Campaign List Page
    Click Element    ${MENU-CAMPAIGN-LIST}
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    15

Input Long Description
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["descriptionLocal"].setData("${text}")

Input Long Description Translation
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["descriptionEN"].setData("${text}")

Confirm to use existed variant
    Wait Until Element is ready and click    //*[@id="modalConfirmBtn"][contains(text(),"Confirm")]    60s
