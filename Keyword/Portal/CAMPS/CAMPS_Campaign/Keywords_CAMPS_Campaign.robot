*** Settings ***
Resource          ../../../../Resource/Config/stark/camps_libs_resources.robot
Resource          WebElement_CAMPS_Campaign.robot

*** Keywords ***
Create Campaign
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${detail}=${VALID-CAMPAIGN-DETAIL}    ${detail_trans}=${EMPTY}    ${start_date}=${EMPTY}    ${start_hour}=0
    ...    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0    ${end_minute}=00    ${status}=disable
    Wait Until Element Is Visible    ${CREATE-BUTTON}    ${g_loading_delay_short}
    Input Campaign Information    ${name}    ${name_trans}    ${detail}    ${detail_trans}    ${start_date}    ${start_hour}
    ...    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}    ${status}
    Click Button    ${CREATE-BUTTON}
    Wait Until Page Contains Campaign List Table

Create Test Suite Campaign
    Open Camps Browser
    Go To Campaign for iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${SUITE NAME}    ${SUITE NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    00
    ...    00    default    00    00    enable
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    ${g_loading_delay}
    ${g_camp_id}=    Get Campaign ID
    ${g_camp_name}=    Get Campaign Name
    Set Suite Variable    ${g_camp_id}
    Set Suite Variable    ${g_camp_name}
    Close All Browsers

Delete Campaign By ID
    [Arguments]    ${camp_ids}
    Go To Campaign for iTruemart Home Page
    Go To Campaign List Page
    @{camp_ids}=    Split String    ${camp_ids}    ,
    : FOR    ${item}    IN    @{camp_ids}
    \    Input Text    ${CAMPAIGN-SEARCH-ID-FIELD}    ${item}
    \    Click Button    ${SEARCH-FILTER-BUTTON}
    \    Wait Until Page Contains Campaign List Table
    \    Delete Latest Campaign

Delete Latest Campaign
    Wait Until Page Contains Element    //*[@id="deleteBtn1"]    ${g_loading_delay}
    Click Element    //*[@id="deleteBtn1"]
    Click button    ${MODAL-CONFIRM}
    Wait Until Page Contains Campaign List Table
    
Edit Latest Campaign
    Click Element    //*[@id="editBtn1"]
    Wait Until Element Is Visible    ${CAMPAIGN-NAME-FIELD}    ${g_loading_delay}

Get Campaign ID
    [Arguments]    ${row}=1
    ${id}=    Get Text From Table    campaignListTable    3    ${row}
    Return From Keyword    ${id}

Get Campaign Name
    [Arguments]    ${row}=1
    ${name}=    Get Text From Table    campaignListTable    4    ${row}
    Return From Keyword    ${name}

Init Suite Campaign
    Open Camps Browser
    Go To Campaign for iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${SUITE NAME}    ${SUITE NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
    ${g_camp_id}=    Get Campaign ID
    ${g_camp_name}=    Get Campaign Name
    Set Suite Variable    ${g_camp_id}
    Set Suite Variable    ${g_camp_name}
    Close All Browsers

Input Campaign Information
    [Arguments]    ${name}    ${name_trans}    ${detail}    ${detail_trans}    ${start_date}    ${start_hour}
    ...    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}    ${status}
    Input Text    ${CAMPAIGN-NAME-FIELD}    ${name}
    Input Text    ${CAMPAIGN-TRANS1-NAME-FIELD}    ${name_trans}
    Input Text    ${CAMPAIGN-DETAIL-FIELD}    ${detail}
    Input Text    ${CAMPAIGN-TRANS1-DETAIL-FIELD}    ${detail_trans}
    Run Keyword If    '${start_date}' != 'none'    Click Element    ${CAMPAIGN-PERIOD-FIELD}
    Run Keyword If    '${start_date}' != 'none'    Wait Until Element Is Visible    ${DATETIME-MENU}
    Run Keyword If    '${start_date}' != 'default' and '${start_date}' != 'none'    Input Date Time for Period    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}
    ...    ${end_hour}    ${end_minute}
    # Use default date-time (Start:Today 00:00, End:Tomorrow 00:00)
    Run Keyword If    '${start_date}' != 'none'    Click button    ${DATETIME-APPLY}
    Run Keyword If    '${status}' == 'enable'    Select Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE IF    '${status}' == 'disable'    Unselect Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE    Log    ${status}

Verify Campaign Information Data
    [Arguments]    ${name}    ${name_trans}    ${detail}    ${detail_trans}    ${start_date}    ${start_hour}
    ...    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}    ${status}
    Textfield Should Contain    ${CAMPAIGN-NAME-FIELD}    ${name}
    Textfield Should Contain    ${CAMPAIGN-TRANS1-NAME-FIELD}    ${name_trans}
    Textarea Should Contain    ${CAMPAIGN-DETAIL-FIELD}    ${detail}
    Textarea Should Contain    ${CAMPAIGN-TRANS1-DETAIL-FIELD}    ${detail_trans}
    ${start_date}=    Convert Date    ${start_date}    date_format=%m/%d/%Y
    ${start_date}=    Convert Date    ${start_date}    datetime
    ${end_date}=    Convert Date    ${end_date}    date_format=%m/%d/%Y
    ${end_date}=    Convert Date    ${end_date}    datetime
    Log    @{MONTHS}[${start_date.month}] ${start_date.day}, ${start_date.year} ${start_hour}:${start_minute} - @{MONTHS}[${end_date.month}] ${end_date.day}, ${end_date.year} ${end_hour}:${end_minute}
    Textfield Should Contain    ${PERIOD-FIELD}    @{MONTHS}[${start_date.month}] ${start_date.day}, ${start_date.year} ${start_hour}:${start_minute} - @{MONTHS}[${end_date.month}] ${end_date.day}, ${end_date.year} ${end_hour}:${end_minute}
    Run Keyword If    '${status}' == 'enable'    Checkbox Should Be Selected    ${ENABLE-TOGGLE}
    ...    ELSE    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}

Verify Campaign Information Template
    Wait Until Element Is Visible    ${CAMPAIGN-NAME-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CAMPAIGN-TRANS1-NAME-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CAMPAIGN-DETAIL-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CAMPAIGN-TRANS1-DETAIL-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CREATE-BUTTON}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CANCEL-BUTTON}    ${g_loading_delay_short}

Create Campaign for Test Case
    [Arguments]    ${tc_number}    ${start_date}    ${end_date}
    Open Camps Browser
    Go To Campaign for iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    ${start_date}    0
    ...    00    ${end_date}    0    00    enable
    Wait Until Page Contains Campaign List Table
    ${g_camp_id}=    Get Campaign ID
    ${g_camp_name}=    Get Campaign Name
    Set Test Variable    ${g_camp_id}
    Set Test Variable    ${g_camp_name}
