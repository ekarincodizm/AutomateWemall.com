*** Settings ***
Force Tags    CAMP_Promotion
Library           Selenium2Library
Library           Collections
Resource          ${CURDIR}/../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../Resource/Config/stark/camps_libs_resources.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Test Template     Create Live Campaign, Promotion Freebie and check pending status

*** Test Cases ***    Start Date      End Date       Promotion Status       Pending Status
TC_CAMPS_01050           -2             -1                enable                 -
    [TAGS]    TC_CAMPS_01050    full regression    ready

TC_CAMPS_01051           -2             -1                disable                -
    [TAGS]    TC_CAMPS_01051    full regression    ready

TC_CAMPS_01052            0              1                enable            Create Pending
    [TAGS]    TC_CAMPS_01052    regression    ready

TC_CAMPS_01053            0              1                disable                -
    [TAGS]    TC_CAMPS_01053    regression    ready

TC_CAMPS_01054            1              2                enable            Create Pending
    [TAGS]    TC_CAMPS_01054    regression    ready

*** Keywords ***
Create Live Campaign, Promotion Freebie and check pending status
    [Arguments]    ${start_date}    ${end_date}    ${status}    ${pending_status}
    ${camp_start_date}=    Get Today Date
    ${camp_end_date}=    Get Next Date from Today
    ${start_date}=    Get Next Date from Today    ${start_date}
    ${end_date}=      Get Next Date from Today    ${end_date}
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${camp_start_date}    ${camp_end_date}
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    Variant    @{VALID-VARIANT}[0]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    ${pending_status}

    [Teardown]    Delete If Created Campaign and Close All Browsers    ${g_camp_id}
