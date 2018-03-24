*** Settings ***
Resource          ../../../../Resource/Config/stark/camps_libs_resources.robot
Resource          WebElement_CAMPS_Common.robot
Library           Selenium2Library

*** Variables ***

*** Keywords ***
Build Drools
    Click Button    //*[@id='buildBtn']
    Confirm At Build Modal Page    (0|[1-9][0-9]*)

Cancel At Modal Page
    [Arguments]    ${message}=No Message To Be Verified
    Wait Until Element Is Visible    //div[@class='modal-content']    ${g_loading_delay}
    Run Keyword If    '${message}' != 'No Message To Be Verified'    Element Should Contain    //div[@class='modal-body']    ${message}
    Click button    ${MODAL-CANCEL}

Confirm At Build Modal Page
    [Arguments]    ${expected_msg_regex}
    Wait Until Modal Page Is Visible    ${g_loading_delay}
    ${message}=    Get Text    //div[@class='modal-body']
    ${message}=    Remove String    ${message}    Promotion(s) Built:\ \
    Should Match Regexp    ${message}    ${expected_msg_regex}
    Click button    ${MODAL-CONFIRM}

Confirm At Modal Page
    [Arguments]    ${message}=No Message To Be Verified
    Wait Until Modal Page Is Visible
    Run Keyword If    '${message}' != 'No Message To Be Verified'    Element Should Contain    //div[@class='modal-body']    ${message}
    Wait Until Element Is Visible    ${MODAL-CONFIRM}    ${g_loading_delay_short}
    Click button    ${MODAL-CONFIRM}

Delete If Created Campaign and Close All Browsers
    [Arguments]    ${camp_ids}=${g_camp_id}
    Run Keyword If    "${camp_ids}" != "${EMPTY}"    Run Keywords    Open Camps Browser
    ...    AND    Delete Campaign By ID    ${camp_ids}
    Close All Browsers

Delete If Created Flash Sale and Close All Browsers
    [Arguments]    ${flash_sale_id}=${g_flash_sale_id}
    Run Keyword If    "${flash_sale_id}" != "${EMPTY}"    Run Keywords    Open Camps Browser
    ...    AND    Delete Flash Sale By ID    ${flash_sale_id}
    Close All Browsers

Delete If Created Promotion and Close All Browsers
    [Arguments]    ${promo_id}=${g_promo_id}
    # Log    ${promo_id}
    Run Keyword If    "${promo_id}" != "${EMPTY}"    Run Keywords    Open Camps Browser
    ...    AND    Go To Campaign for iTruemart Home Page
    ...    AND    Delete Promotion By ID    ${promo_id}
    ...    AND    Build Drools
    Close All Browsers

Get First Word From Sentence
    [Arguments]    ${sentence}
    @{words}=    Split String    ${sentence}
    ${empty_name}=    Run Keyword And Return Status    Should Be Empty    ${words}
    ${word}=    Set Variable If    ${empty_name}    ${EMPTY}    @{words}[0]
    Return From Keyword    ${word}

Get Live Status
    [Arguments]    ${table}    ${col}    ${row}=1
    ${color}=    Selenium2Library.Get Element Attribute    //table[@id='${table}']/tbody/tr[${row}]/td[${col}]/div/i@style
    ${is_green}=    Run Keyword And Return Status    Should Contain    ${color}    color: green
    ${is_orange}=    Run Keyword And Return Status    Should Contain    ${color}    color: orange
    ${is_red}=    Run Keyword And Return Status    Should Contain    ${color}    color: red
    ${is_grey}=    Run Keyword And Return Status    Should Contain    ${color}    color: grey
    ${live_status}    Set Variable If    ${is_green}    LIVE    ${is_orange}    ENABLED    ${is_red}
    ...    DISABLED    ${is_grey}    EXPIRED
    Return From Keyword    ${live_status}

Get Next Date from Today
    [Arguments]    ${day}=1
    ${today}=    Get Current Date
    ${nextday}=    Add Time To Date    ${today}    ${day} day
    ${nextday}=    Convert Date    ${nextday}    datetime
    Return From Keyword    ${nextday.month}/${nextday.day}/${nextday.year}

Get Row Count
    [Arguments]    ${table_id}
    ${row}=    Get Matching XPath Count    //table[@id='${table_id}']/tbody/tr
    Return From Keyword    ${row}

Get Test Case Number
    [Arguments]    ${test_name}=${TEST_NAME}
    @{words}=    Split String    ${test_name}
    Return From Keyword    @{words}[0]

Get Text From Table
    [Arguments]    ${table_id}    ${column}    ${row}
    ${string}=    Get Text    //table[@id='${table_id}']/tbody/tr[${row}]/td[${column}]
    Return From Keyword    ${string}

Get Today Date
    ${today}=    Get Current Date
    ${today}=    Convert Date    ${today}    datetime
    Return From Keyword    ${today.month}/${today.day}/${today.year}

Go To Campaign List Page
    Click Element    ${MENU-CAMPAIGN-LIST}
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    ${g_loading_delay}

Go To Campaign for iTruemart Home Page
    # Wait Until Element Is Visible    //*[@value="iTRUEMART"]    5s
    ${at_land}=    Run Keyword And Return Status    Page Should Contain Element    //*[@value="iTRUEMART"]
    ${at_home}=    Run Keyword And Return Status    Page Should Contain Element    ${MENU-HOME}
    Run Keyword If    ${at_home}    Log    Already at Home
    ...    ELSE IF    ${at_land}    Click Element    //*[@value="iTRUEMART"]
    ...    ELSE    Run Keywords    Click Element    link=Promotion
    ...    AND    Wait Until Element Is Visible    //*[@value="iTRUEMART"]    ${g_loading_delay}
    ...    AND    Click Element    //*[@value="iTRUEMART"]

Go To Code Group List Page
    Click Element    ${MENU-CODE-GROUP-LIST}
    Wait Until Element Is Visible    ${CODE-GROUP-LIST-TABLE}    ${g_loading_delay}

Go To Create Bundle promotion Page
    Click Element    ${CREATE-PROMOTION-BUNDLE-BUTTON}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Create Campaign Page
    Click Element    ${MENU-CREATE-CAMPAIGN}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Create Discount by Code promotion Page
    Click Element    ${CREATE-PROMOTION-DISCOUNT-BY-CODE-BUTTON}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Create Email Group Page
    Click Element    ${MENU-CREATE-EMAIL-GROUP}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Create Flash Sale Page
    Click Element    ${MENU-CREATE-FLASH-SALE}
    Wait Until Page Contains Element    ${CREATE-FLASH-SALE-TABLE}    ${g_loading_delay}

Go To Create Freebie promotion Page
    Click Element    ${CREATE-PROMOTION-FREEBIE-BUTTON}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Create MNP promotion Page
    Click Element    ${CREATE-PROMOTION-MNP-BUTTON}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Create Promotions Page
    Click Element    ${CREATE-PROMOTION-BUTTON}
    Wait Until Page Contains Element    ${CREATE-PROMO-TABLE}    ${g_loading_delay}

Go To Create Wow Banner Page
    Click Element    ${CREATE-WOW-BANNER-BUTTON}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Create Wow Extra Page
    Click Element    ${CREATE-WOW-EXTRA-BUTTON}
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}

Go To Email Group List Page
    Click Element    ${MENU-EMAIL-GROUP-LIST}
    Wait Until Page Contains Element    ${EMAIL-GROUP-LIST-TABLE}    ${g_loading_delay}

Go To Flash Sale List Page
    Click Element    ${MENU-FLASH-SALE-LIST}
    Wait Until Page Contains Element    ${FLASH-SALE-LIST-TABLE}    ${g_loading_delay}

Go To Generate Code Page
    Click Element    ${MENU-GEN-CODE}
    Wait Until Element Contains    ${TITLE-HEADER}    Generate Code    ${g_loading_delay}

Go To Promotion List under Campaign
    [Arguments]    ${camp_id}=${g_camp_id}
    Go To Campaign List Page
    Input Text    ${CAMPAIGN-SEARCH-ID-FIELD}    ${camp_id}
    Click Button    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    ${g_loading_delay}
    Click Element    //*[@id="promotionBtn1"]
    Wait Until Element Is Visible    ${PROMO-LIST-TABLE}    ${g_loading_delay}

Header Should Contain
    [Arguments]    ${header}
    Element Should Contain    ${TITLE-HEADER}    ${header}

Input Date Time for Period
    [Arguments]    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    Input Text    ${DATETIME-START-DATE}    ${start_date}
    Input Text    ${DATETIME-END-DATE}    ${end_date}
    Click Element    ${DATETIME-START-TIME-HOUR}
    Select From List    ${DATETIME-START-TIME-HOUR}    ${start_hour}
    Click Element    ${DATETIME-START-TIME-MINUTE}
    Select From List    ${DATETIME-START-TIME-MINUTE}    ${start_minute}
    Click Element    ${DATETIME-END-TIME-HOUR}
    Select From List    ${DATETIME-END-TIME-HOUR}    ${end_hour}
    Click Element    ${DATETIME-END-TIME-MINUTE}
    Select From List    ${DATETIME-END-TIME-MINUTE}    ${end_minute}

Input Date Time Information
    [Arguments]    ${start_date}    ${end_date}    ${start_hour}=0    ${start_minute}=00    ${end_hour}=0    ${end_minute}=00
    Click Element    ${PERIOD-FIELD}
    Wait Until Element Is Visible    ${DATETIME-MENU}
    Input Date Time for Period    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    Click button    ${DATETIME-APPLY}

Input Member Nonmember
    [Arguments]    ${apply_with}
    ${member_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    ${member_unselected}=    Run Keyword and return status    Checkbox Should Not Be Selected    ${MEMBER-CHKBOX}
    ${nonmember_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}
    ${nonmember_unselected}=    Run Keyword and return status    Checkbox Should Not Be Selected    ${NONMEMBER-CHKBOX}
    Run Keyword If    ${member_unselected} and '${apply_with}' == 'member'    Click Element    ${MEMBER-CHKBOX-SPAN}
    Run Keyword If    ${nonmember_selected} and '${apply_with}' == 'member'    Click Element    ${NONMEMBER-CHKBOX-SPAN}
    Run Keyword If    ${nonmember_unselected} and '${apply_with}' == 'nonmember'    Click Element    ${NONMEMBER-CHKBOX-SPAN}
    Run Keyword If    ${member_selected} and '${apply_with}' == 'nonmember'    Click Element    ${MEMBER-CHKBOX-SPAN}
    Run Keyword If    ${member_unselected} and '${apply_with}' == 'both'    Click Element    ${MEMBER-CHKBOX-SPAN}
    Run Keyword If    ${nonmember_unselected} and '${apply_with}' == 'both'    Click Element    ${NONMEMBER-CHKBOX-SPAN}

Live Status Should Be Equal
    [Arguments]    ${table}    ${expected_live}    ${col}    ${row}=1
    ${live_status}=    Get Live Status    ${table}    ${col}    ${row}
    List Should Contain Value    ${expected_live}    ${live_status}

Live Status Should Not Be Equal
    [Arguments]    ${table}    ${expected_live}    ${col}    ${row}=1
    ${live_status}=    Get Live Status    ${table}    ${col}    ${row}
    List Should Not Contain Value    ${expected_live}    ${live_status}

Live Status on Current page should be Equal
    [Arguments]    ${table_name}    ${col}    ${expected_status}
    ${row_count}=    Get Row Count    ${table_name}
    : FOR    ${index}    IN RANGE    1    ${row_count}+1
    \    Live Status Should Be Equal    ${table_name}    ${expected_status}    ${col}    ${index}

Live status on Current page should not be Equal
    [Arguments]    ${table_name}    ${col}    ${expected_status}
    ${row_count}=    Get Row Count    ${table_name}
    : FOR    ${index}    IN RANGE    1    ${row_count}+1
    \    Live Status Should Not Be Equal    ${table_name}    ${expected_status}    ${col}    ${index}

Login to CAMPS
    [Arguments]    ${user}=${USER-CAMPS}    ${password}=${PASSWORD-CAMPS}
    Wait Until Element Is Visible    //*[@id='loginform']    ${g_loading_delay}
    Input Text    //*[@id='login-username']    ${user}
    Input Text    //*[@id='login-password']    ${password}
    Click Element    //*[@id='btn-login']
    Wait Until Element Is Visible    //*[@value="iTRUEMART"]    ${g_loading_delay}

Open CAMPS Browser
    Set Selenium Speed    ${CAMPS-SELENIUM-SPEED}
    Open Browser    ${CAMPS-HOST}    ${CAMPS-BROWSER}
    Maximize Browser Window
    Login to CAMPS

Table Should Not Contain Data (No Data)
    Run Keyword And Return Status    Page Should Contain    No Data
    @{result}=    Run Keyword And Ignore Error    Page Should Contain    No Data
    Return From Keyword    @{result}[0]

Wait Until Modal Page Is Visible
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Element Is Visible    //div[@class='modal-content']    ${wait_time}

Wait Until Page Contains Campaign List Table
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    ${wait_time}

Wait Until Page Contains Flash Sale List Table
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Page Contains Element    ${FLASH-SALE-LIST-TABLE}    ${wait_time}

Wait Until Page Contains Promotion List under Campaign Table
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${wait_time}

Wait Until Page Contains Flash Sale App ID
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Page Contains Element    ${FS-APP-ID-FIELD}    ${wait_time}
