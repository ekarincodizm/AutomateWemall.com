*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Library           String
Library           HttpLibrary.HTTP
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_CAMP_Bundle.robot

*** Keywords ***
Bundle - Create Bundle
    [Arguments]    ${Text_BundleName}    ${Text_BundleShortDesc}    ${Text_BundleDesc}    ${Text_BundleStart}    ${Text_BundleEnd}    ${Text_BundleNote}
    ...    ${Text_PrimaryVariant}    ${Text_VariantDiscountPercent}    ${Text_BundleVariant}    ${Text_BundleDiscountPercent}
    Wait Until Element Is Visible    //*[@id="createPromotionBtn"]/span    60s
    Click Element    //*[@id="createPromotionBtn"]/span
    Click Element    //*[@id="createBtn1"]
    Wait Until Element Is Visible    //*[@id="nameLocal"]    60s
    Input Text    //*[@id="nameLocal"]    ${Text_BundleName}
    Input Text    //*[@id="shortDescriptionLocal"]    ${Text_BundleShortDesc}
    Keywords_CAMP_Bundle.Input Description    ${Text_BundleDesc}
    Click Element    //*[@id="period"]
    Input Text    //*[@name="daterangepicker_start"]    ${Text_BundleStart}
    Input Text    //*[@name="daterangepicker_end"]    ${Text_BundleEnd}
    Click Element    //*[@type="button"][contains(text(),'Apply')]
    Wait Until Element Is Visible    //*[@id="enabledSpan"]    60s
    Click Element    //input[@name="enabled"]
    Keywords_CAMP_Bundle.Input Bundle Note    ${Text_BundleNote}
    Input Text    //*[@id="bundledVariant1"]    ${Text_PrimaryVariant}
    Input Text    //*[@id="discountPercent1"]    ${Text_VariantDiscountPercent}
    Input Text    //*[@id="bundledVariant2"]    ${Text_BundleVariant}
    Input Text    //*[@id="discountPercent2"]    ${Text_BundleDiscountPercent}
    Click Element    //*[@id="submitBtn"]
    ${element_Table_PromotionName}=    Replace String    //*[contains(@id,'promotionListTable')]//tbody//tr/td[5][contains(text(),'REPLACE_ME')]/../td[11]/button[1]    REPLACE_ME    ${Text_BundleName}
    Wait Until Element Is Visible    ${element_Table_PromotionName}    60s

Input Description
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["descriptionLocal"].setData("${text}")

Input Bundle Note
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["noteLocal"].setData("${text}")

Click build button
    Wait Until Element is ready and click    //*[@id="buildBtn"]    30
    Wait Until Element is ready and click    //*[@id="modalConfirmBtn"]    120

Set Promotion Discount On Camp
    [Arguments]    ${sku-device1}=None    ${sku-device2}=None    ${discount-type1}=None    ${discount-type2}=None    ${discount-value1}=None    ${discount-value2}=None
    Run Keyword If    '${sku-device1}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${sku-device2}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount-type1}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount-type2}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount-value1}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${discount-value2}' == 'None'    Return From Keyword    ${EMPTY}
    Log TO console    device-inv=${sku-device1}
    Log to console    inv-sim=${sku-device2}
    ${content}=    Get File    ${CURDIR}/../Resources/TestData/Promotion_camp_template.json    utf-8
    Log to console    content=${content}
    ${content}=    Replace String    ${content}    ^^bundle_variant1^^    ${sku-device1}
    ${content}=    Replace String    ${content}    ^^bundle_variant2^^    ${sku-device2}
    ${content}=    Replace String    ${content}    ^^discount_type1^^    ${discount-type1}
    ${content}=    Replace String    ${content}    ^^discount_type2^^    ${discount-type2}
    ${content}=    Replace String    ${content}    ^^discount_value1^^    ${discount-value1}
    ${content}=    Replace String    ${content}    ^^discount_value2^^    ${discount-value2}
    Log To Console    content-after-replace=${content}
    #Log To console    content=${content}
    Create Http Context    ${CAMP-TOP-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Body    ${content}
    Next Request Should Succeed
    POST    ${CAMP-API-PROMOTION-URI}
    ${response}=    Get Response Body
    Log To Console    Response Body=${response}

Set Mnp Promotion On Camp
    [Arguments]    ${inv_id}    ${discount_type}    ${discount_value}

Go To Manage Group Proposition
    Wait Until Element Is Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    Element Should Be Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    Click Element    //div[@id="mws-navigation"]/ul/li[25]/a
    Sleep    1s
    Click Element    //div[@id="mws-navigation"]/ul/li[25]/ul/li[11]/a

Click Button Create Group Proposition
    #Log to console    xxx
    Click Element    //a[contains(@href, "truemoveh/proposition-group/create")]

User Create Group Proposition
    Remove Group Proposition Bundle
    Input Text    id=txtName    Test Group Proposition
    Input Text    id=txtDescription    Test Group Proposition Description
    Click Element    //input[@value="Create"]
    Wait Until Element Is Visible    //div[@class="alert alert-success"]
    Element Should Contain    //div[@class="alert alert-success"]    The group proposition is created successfully.

User Click To Mapped Group Proposition With Proposition
    ${table}=    Set Variable    //table[@id="tb-order"]/tbody
    ${total-rows}=    Get Matching Xpath Count    ${table}/tr
    ${total-rows}=    Evaluate    ${total-rows} + 1
    : FOR    ${index}    IN RANGE    1    ${total-rows}
    \    ${group-proposition-name}=    Get Text    ${table}/tr[${index}]/td[2]
    \    Run Keyword if    '${group-proposition-name}' == 'Test Group Proposition'    Click Mapped Group Proposition    ${index}

Click Mapped Group Proposition
    [Arguments]    ${row}
    ${table}=    Set Variable    //table[@id="tb-order"]/tbody
    Click Element    ${table}/tr[${row}]/td[3]/a
    Exit For Loop

User Mapped Device With Group Proposition
    Wait Until Element Is Visible    //select[@id="m-selectable"]/option[1]
    Click Element    //select[@id="m-selectable"]/option[1]
    ${proposition}=    Get Text    //select[@id="m-selectable"]/option[1]
    Log To Console    propposition=${proposition}
    Click Element    //button[@class="multis-right"]
    Click Element    //input[@value="Save"]
    Wait Until Element Is Visible    //div[@class="alert alert-success"]
    Element Should Contain    //div[@class="alert alert-success"]    Save successfully.
    Return From Keyword    ${proposition}
    # User Click Manage Price Plan
    #    Wait Until Element Is Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    #    Element Should Be Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    #    Sleep    1s
    #    ${is-closed}=    Get Matching Xpath Count    //div[@id="mws-navigation"]/ul/li[25]/ul[@class="closed"]
    #    Run Keyword If    '${is-closed}' > '0'    Click Element    //div[@id="mws-navigation"]/ul/li[25]/a
    #    #Log to console    ${ul}
    #    Click Element    //div[@id="mws-navigation"]/ul/li[25]/ul/li[13]/a

User Mapped Proposition With Price Plan
    [Arguments]    ${proposition}
    Wait Until Element Is Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    Element Should Be Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    Sleep    1s
    ${is-closed}=    Get Matching Xpath Count    //div[@id="mws-navigation"]/ul/li[25]/ul[@class="closed"]
    Run Keyword If    '${is-closed}' > '0'    Click Element    //div[@id="mws-navigation"]/ul/li[25]/a
    Click Element    //div[@id="mws-navigation"]/ul/li[25]/ul/li[12]/a
    Wait Until Element Is Visible    id=proposition_name
    Input Text    id=proposition_name    ${proposition}
    Click Element    //input[@value="Search"]
    Wait Until Element Is Visible    id=tb-order
    ${table}=    Set Variable    //table[@id="tb-order"]/tbody
    ${total-rows}=    Get Matching Xpath Count    ${table}/tr
    ${total-rows}=    Evaluate    ${total-rows} + 1
    : FOR    ${index}    IN RANGE    1    ${total-rows}
    \    ${row-proposition}=    Get Text    ${table}/tr[${index}]/td[2]
    \    Run Keyword If    '${proposition}' in '${row-proposition}'    Click For Manage Price Plan On Proposition    ${index}
    Wait Until Element Is Visible    //select[@id="m-selectable"]/option[1]
    Click Element    //select[@id="m-selectable"]/option[1]
    Click Element    //button[@class="multis-right"]
    Click Element    //input[@value="Save"]
    Wait Until Element Is Visible    //div[@class="alert alert-success"]
    Element Should Contain    //div[@class="alert alert-success"]    Save successfully.

Click For Manage Price Plan On Proposition
    [Arguments]    ${row}
    ${table}=    Set Variable    //table[@id="tb-order"]/tbody
    Click Element    ${table}/tr[${row}]/td[4]/a
    Exit For Loop

User Click Mapped Device With Group Proposition
    [Arguments]    ${product_name}=None    ${proposition}=None
    Wait Until Element Is Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    Element Should Be Visible    //div[@id="mws-navigation"]/ul/li[25]/a
    Sleep    1s
    ${is-closed}=    Get Matching Xpath Count    //div[@id="mws-navigation"]/ul/li[25]/ul[@class="closed"]
    Run Keyword If    '${is-closed}' > '0'    Click Element    //div[@id="mws-navigation"]/ul/li[25]/a
    Click Element    //div[@id="mws-navigation"]/ul/li[25]/ul/li[14]/a
    Wait Until Element Is Visible    //a[contains(@href, "truemoveh/device/add")]
    Click Element    //a[contains(@href, "truemoveh/device/add")]
    Wait Until Element Is Visible    name=product_name
    Input Text    name=product_name    ${product_name}
    Click Element    //input[@value="Search"]

Create Campaign On Camp
    [Arguments]    ${start_period}=None    ${end_period}=None    ${enable}=None    ${json}=None    ${campaign_name}=None
    ${time}=    Get Time
    ${campaign_name}=    Run Keyword If    '${campaign_name}' == 'None'    Convert To String    (Robot) Campaign Name Test ${time}
    ...    ELSE    Convert To String    ${campaign_name}
    Run Keyword If    '${start_period}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${end_period}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${enable}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${json}' == 'None'    Return From Keyword    ${EMPTY}
    ${content}=    Get File    ${CURDIR}/../Resources/TestData/Freebie/${json}    utf-8
    ${content}=    Replace String    ${content}    ^^campaign_name^^    ${campaign_name}
    ${content}=    Replace String    ${content}    ^^start_period^^    ${start_period}
    ${content}=    Replace String    ${content}    ^^end_period^^    ${end_period}
    ${content}=    Replace String    ${content}    ^^enable^^    ${enable}
    # Log to console    content-after-replace=${content}
    ${res}=    Login to Wemall(API) ${create_token_uri}    authen001@test.com    password    grant_type=merchant
    Validate Login Completed    ${res}
    ${accesstoken}=    Get Access Token from Response    ${res.text}
    ${refreshtoken}=    Get Refresh Token from Response    ${res.text}
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accesstoken    ${accesstoken}
    Set Request Header    x-wm-refreshtoken    ${refreshtoken}
    Set Request Body    ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST    ${CAMP-V1-CREATE-CAMPAIGNS-URI}?check_name=true
    ${response}=    Get Response Body
    # Log to console    ${response}
    [Return]    ${response}

Delete Campaign On Camp
    [Arguments]    ${campaign_id}
    ${res}=    Login to Wemall(API) ${create_token_uri}    authen001@test.com    password    grant_type=merchant
    Validate Login Completed    ${res}
    ${accesstoken}=    Get Access Token from Response    ${res.text}
    ${refreshtoken}=    Get Refresh Token from Response    ${res.text}
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accesstoken    ${accesstoken}
    Set Request Header    x-wm-refreshtoken    ${refreshtoken}
    Next Request Should Succeed
    HttpLibrary.HTTP.DELETE    ${CAMP-V1-CREATE-CAMPAIGNS-URI}/${campaign_id}
    ${response}=    Get Response Body
    # Log to console    ${response}
    [Return]    ${response}

Update Campaign On Camp
    [Arguments]    ${campaign_id}=None    ${start_period}=None    ${end_period}=None    ${enable}=None    ${json}=None    ${campaign_name}=None
    Run Keyword If    '${campaign_id}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${campaign_name}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${start_period}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${end_period}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${enable}' == 'None'    Return From Keyword    ${EMPTY}
    Run Keyword If    '${json}' == 'None'    Return From Keyword    ${EMPTY}
    ${content}=    Get File    ${CURDIR}/../Resources/TestData/Freebie/${json}    utf-8
    ${content}=    Replace String    ${content}    ^^campaign_name^^    ${campaign_name}
    ${content}=    Replace String    ${content}    ^^start_period^^    ${start_period}
    ${content}=    Replace String    ${content}    ^^end_period^^    ${end_period}
    ${content}=    Replace String    ${content}    ^^enable^^    ${enable}
    ${res}=    Login to Wemall(API) ${create_token_uri}    authen001@test.com    password    grant_type=merchant
    Validate Login Completed    ${res}
    ${accesstoken}=    Get Access Token from Response    ${res.text}
    ${refreshtoken}=    Get Refresh Token from Response    ${res.text}
    # Log to console    ${accesstoken}
    # Log to console    ${refreshtoken}
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-type    application/json
    Set Request Header    x-wm-accesstoken    ${accesstoken}
    Set Request Header    x-wm-refreshtoken    ${refreshtoken}
    Set Request Body    ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.PUT    ${CAMP-V1-CREATE-CAMPAIGNS-URI}/${campaign_id}?check_name=true
    ${response}=    Get Response Body
    # Log to console    ${response}
    [Return]    ${response}

Delete Promotion On Camp
    [Arguments]    ${promotion_id}
    ${token-data}=    AAD Login And Get Token
    ${refresh-token}=    Get From Dictionary    ${token-data}    refresh_token
    ${access-token}=    Get From Dictionary    ${token-data}    access_token
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-Type    application/json
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    Next Request Should Succeed
    HttpLibrary.HTTP.DELETE    ${CAMP-V1-CREATE-PROMOTIONS-URI}/${promotion_id}
    Create Http Context    ${CAMP-V1-LEVEL-DOMAIN}    ${CAMP-PROTOCOL}
    Set Request Header    Content-Type    application/json
    Set Request Header    x-wm-accessToken    ${access-token}
    Set Request Header    x-wm-refreshToken    ${refresh-token}
    Next Request Should Succeed
    HttpLibrary.HTTP.PUT    ${CAMP-V1-BUILD-PROMOTIONS-URI}
    Log To Console    delete_promotion_success=${promotion_id}
