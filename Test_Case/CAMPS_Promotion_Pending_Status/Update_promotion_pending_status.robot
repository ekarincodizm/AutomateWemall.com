*** Settings ***
Force Tags    WLS_CAMP_Promotion
Library           Selenium2Library
Library           Collections
Resource          ${CURDIR}/../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../Resource/Config/stark/camps_libs_resources.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Test Template     Create Live Campaign, Promotion Freebie, Update Promotion and check pending status

*** Test Cases ***        Create Promotion              Update Promotion       Build         Expect Pending Status
TC_CAMPS_01055                  LIVE                      EXPIRED-EN            T               Update Pending
    [TAGS]    TC_CAMPS_01055    ready    Full Regression
TC_CAMPS_01056                  ENABLED                   EXPIRED-EN            T               Update Pending
    [TAGS]    TC_CAMPS_01056    ready    Full Regression
TC_CAMPS_01057                  DISABLED                  EXPIRED-EN            T                     -
    [TAGS]    TC_CAMPS_01057    ready    Full Regression
TC_CAMPS_01058                  EXPIRED-EN                EXPIRED-EN            T                     -
    [TAGS]    TC_CAMPS_01058    ready    Full Regression
TC_CAMPS_01059                  EXPIRED-DIS               EXPIRED-EN            T                     -
    [TAGS]    TC_CAMPS_01059    ready    Full Regression
TC_CAMPS_01060                  EXPIRED-EN                LIVE                  T               Update Pending
    [TAGS]    TC_CAMPS_01060    ready    Regression
TC_CAMPS_01061                  EXPIRED-EN                ENABLED               T               Update Pending
    [TAGS]    TC_CAMPS_01061    ready    Regression
TC_CAMPS_01062                  EXPIRED-EN                DISABLED              T                     -
    [TAGS]    TC_CAMPS_01062    ready    Regression
TC_CAMPS_01063                  LIVE                      CD,EXPIRED-EN         F               Update Pending,Update Pending
    [TAGS]    TC_CAMPS_01063    ready    Full Regression
TC_CAMPS_01064                  ENABLED                   CD,EXPIRED-EN         F               Update Pending,Update Pending
    [TAGS]    TC_CAMPS_01064    ready    Full Regression
TC_CAMPS_01065                  DISABLED                  ENABLED,EXPIRED-EN    F               Update Pending,Update Pending
    [TAGS]    TC_CAMPS_01065    ready    Full Regression
TC_CAMPS_01066                  LIVE                      CD,EXPIRED-EN         T               Update Pending,Update Pending
    [TAGS]    TC_CAMPS_01066    ready    Full Regression
TC_CAMPS_01067                  ENABLED                   CD,EXPIRED-EN         T               Update Pending,Update Pending
    [TAGS]    TC_CAMPS_01067    ready    Full Regression
TC_CAMPS_01068                  DISABLED                  ENABLED,EXPIRED-EN    T               Update Pending,Update Pending
    [TAGS]    TC_CAMPS_01068    ready    Full Regression

*** Keywords ***
Create Live Campaign, Promotion Freebie, Update Promotion and check pending status
    [Arguments]    ${create}    ${update}    ${build}    ${pending_status}
    ${camp_start_date}=    Get Next Date from Today    -10
    ${camp_end_date}=      Get Next Date from Today    10
    ${start_date}    ${end_date}    ${status}=    Get Date Period by Live Status    ${create}
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
    Run Keyword If    '${build}' == 'T'    Build Drools

    @{pending_status_list}=    Split String    ${pending_status}    ,

    @{update}=    Split String    ${update}    ,
    ${len}=    Get Length    ${update}
    : FOR    ${index}    IN RANGE    0    ${len}
    \    ${status}=    Set Variable    @{update}[${index}]
    \    ${pending_status}=    Set Variable    @{pending_status_list}[${index}]
    \    Edit Latest Promotion
    \    Run Keyword If    '${status}' == 'CD'    Input Text    ${PROMO-REPEAT-FIELD}    1    ELSE    Update Promotion Period and Status    ${status}
    \    Submit To Create or Update Promotion
    \    Wait Until Page Contains Promotion List under Campaign Table
    \    Promotion Pending Status Should Be Equal    ${pending_status}


    [Teardown]    Delete If Created Campaign and Close All Browsers    ${g_camp_id}

Get Date Period by Live Status
    [Arguments]    ${status}
    ${-2days}=    Get Next Date from Today    -2
    ${-1day}=    Get Next Date from Today    -1
    ${0day}=    Get Next Date from Today    0
    ${1day}=    Get Next Date from Today    1
    ${2days}=    Get Next Date from Today    2

    ${start_date}    Set Variable If    '${status}' == 'LIVE' or '${status}' == 'DISABLED'    ${0day}
    ...    '${status}' == 'ENABLED'    ${1day}
    ...    ${-2days}

    ${end_date}    Set Variable If    '${status}' == 'LIVE' or '${status}' == 'DISABLED'    ${1day}
    ...    '${status}' == 'ENABLED'    ${2days}
    ...    ${-1day}

    ${enable}    Set Variable If    '${status}' == 'LIVE' or '${status}' == 'ENABLED' or '${status}' == 'EXPIRED-EN'    enable
    ...    disable
    Return From Keyword    ${start_date}    ${end_date}    ${enable}

Update Promotion Period and Status
    [Arguments]    ${status}
    ${update_start_date}    ${update_end_date}    ${update_status}=    Get Date Period by Live Status    ${status}
    Input Date Time Information    ${update_start_date}    ${update_end_date}
    Input Promotion Status    ${update_status}
