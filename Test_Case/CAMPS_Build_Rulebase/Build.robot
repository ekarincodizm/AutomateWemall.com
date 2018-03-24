*** Settings ***
Suite Setup       Init Suite Campaign
Suite Teardown    Delete If Created Campaign and Close All Browsers    ${g_camp_id}
Test Setup        Open Camps Browser
Test Teardown     Delete If Created Promotion and Close All Browsers    ${g_promo_id}
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Variables ***
${percentDiscount}    75
${bahtDiscount}    599

*** Test Cases ***
TC_CAMPS_00749 Verify Button and Modal Message
    [Tags]    TC_CAMPS_00749    ready    Regression    passed
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    Element Should Be Visible    //*[@id='buildBtn']
    Build Drools

TC_CAMPS_00703 New created promotion with some update that is condition will be needed to build drool file
    [Tags]    TC_CAMPS_00703    ready    Regression
    Go To Campaign for iTruemart Home Page
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${tc_number}=    Get Test Case Number
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=500
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Pending Status Should Be Equal    Create Pending
    Edit Promotion By ID    ${g_promo_id}
    Click Element    ${MEMBER-CHKBOX-SPAN}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    Update Pending
    Edit Latest Promotion
    Click Element    ${MEMBER-CHKBOX-SPAN}
    Click Element    ${NONMEMBER-CHKBOX-SPAN}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    Update Pending
    Edit Latest Promotion
    Wait Until Element Is Enabled    //*[@id='bundledVariant1']    ${g_loading_delay}
    Input Primary MNP    ${bundle_list}
    ${bundle_list_length}=    Get Length    ${bundle_list}
    : FOR    ${element}    IN RANGE    ${bundle_list_length} -1
    \    ${index}=    Evaluate    ${element} +1
    \    ${index2}=    Evaluate    ${element} +2
    \    ${values}=    Get Dictionary Values    @{bundle_list}[${index}]
    \    Run Keyword If    ${index2}>2    Click Element    ${ITM-ADD-BUNDLE-BUTTON}
    \    Input Bundle VARIANT and Discount Detail    ${index2}    @{values}[0]    @{values}[2]    @{values}[1]
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Edit Promotion By ID    ${g_promo_id}
    Verify Promotion Information Data    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    00    00    ${end_date}    00    00
    ...    enable    member
    Verify MNP Promotion Rule    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}

TC_CAMPS_00704 New created promotion with some update that is not condition will be not needed to build drool file
    [Tags]    TC_CAMPS_00704    ready    Regression
    Go To Campaign for iTruemart Home Page
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${tc_number}=    Get Test Case Number
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=500
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Pending Status Should Be Equal    Create Pending
    Build Drools
    Edit Promotion By ID    ${g_promo_id}
    Input Text    ${NAME-FIELD}    Edit:${tc_number}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Text    ${NAME-TRANS1-FIELD}    Edit:${tc_number}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Long Description    Edit:${VALID-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Long Description Translation    Edit:${VALID-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Text    ${SHORT-DESC-FIELD}    Edit:${VALID-SHORT-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Text    ${SHORT-DESC-TRANS1-FIELD}    Edit:${VALID-SHORT-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Verify Promotion Information Data    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    00    00    ${end_date}    00    00
    ...    enable    both
    Verify MNP Promotion Rule    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}

TC_CAMPS_00705 Updated promotion with some update that is condition will be needed to build drool file
    [Tags]    TC_CAMPS_00705    ready    Regression    passed
    Go To Campaign for iTruemart Home Page
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${tc_number}=    Get Test Case Number
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=500
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Build Drools
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=400
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[2]    discType=Percent    discAmount=35
    @{bundle_list}    Create List    ${element1}    ${element2}
    Edit Promotion By ID    ${g_promo_id}
    Click Element    ${MEMBER-CHKBOX-SPAN}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    Update Pending
    Edit Latest Promotion
    Click Element    ${MEMBER-CHKBOX-SPAN}
    Click Element    ${NONMEMBER-CHKBOX-SPAN}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    Update Pending
    Edit Latest Promotion
    Wait Until Element Is Enabled    //*[@id='bundledVariant1']    ${g_loading_delay}
    Input Primary MNP    ${bundle_list}
    ${bundle_list_length}=    Get Length    ${bundle_list}
    : FOR    ${element}    IN RANGE    ${bundle_list_length} -1
    \    ${index}=    Evaluate    ${element} +1
    \    ${index2}=    Evaluate    ${element} +2
    \    ${values}=    Get Dictionary Values    @{bundle_list}[${index}]
    \    Run Keyword If    ${index2}>2    Click Element    ${ITM-ADD-BUNDLE-BUTTON}
    \    Input Bundle VARIANT and Discount Detail    ${index2}    @{values}[0]    @{values}[2]    @{values}[1]
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Edit Promotion By ID    ${g_promo_id}
    Verify Promotion Information Data    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    00    00    ${end_date}    00    00
    ...    enable    member
    Verify MNP Promotion Rule    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}

TC_CAMPS_00706 Updated promotion with some update that is not condition will be not needed to build drool file
    [Tags]    TC_CAMPS_00706    ready    Regression
    Go To Campaign for iTruemart Home Page
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${tc_number}=    Get Test Case Number
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=500
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Pending Status Should Be Equal    Create Pending
    Build Drools
    Edit Promotion By ID    ${g_promo_id}
    Input Text    ${NAME-FIELD}    Edit:${tc_number}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Text    ${NAME-TRANS1-FIELD}    Edit:${tc_number}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Long Description    Edit:${VALID-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Long Description Translation    Edit:${VALID-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Text    ${SHORT-DESC-FIELD}    Edit:${VALID-SHORT-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Edit Latest Promotion
    Input Text    ${SHORT-DESC-TRANS1-FIELD}    Edit:${VALID-SHORT-PROMO-DESC}
    Submit To Create or Update Promotion
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    #Click Element    ${PERIOD-FIELD}
    #Wait Until Element Is Visible    ${DATETIME-MENU}
    #Input Date Time for Period    ${start_date}    10    30    ${end_date}    23    59
    #Edit Latest Promotion
    #Click Element    ${MEMBER-CHKBOX-SPAN}
    #Submit To Create or Update Promotion
    #Wait Until Page Contains Promotion List under Campaign Table
    #Promotion Pending Status Should Be Equal    -
    #Edit Latest Promotion
    #Click Element    ${MEMBER-CHKBOX-SPAN}
    #Click Element    ${NONMEMBER-CHKBOX-SPAN}
    # .. Promotion Rule Section
    #Input Bundle Note    Edit:${VALID-BUNDLE-NOTE}
    #Input Bundle Note Translation    Edit:${VALID-BUNDLE-NOTE}
    #Submit To Create or Update Promotion
    #Wait Until Page Contains Promotion List under Campaign Table
    #Promotion Pending Status Should Be Equal    -
    Build Drools
    Edit Promotion By ID    ${g_promo_id}
    Verify Promotion Information Data    Edit:${tc_number}    Edit:${tc_number}    Edit:${VALID-PROMO-DESC}    Edit:${VALID-PROMO-DESC}    Edit:${VALID-SHORT-PROMO-DESC}    Edit:${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    00    00    ${end_date}    00    00
    ...    enable    both
    Verify MNP Promotion Rule    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}

TC_CAMPS_00717 Deleted promotion will be deleted after click Build button
    [Tags]    TC_CAMPS_00717    ready    Regression
    ${tc_number}=    Get Test Case Number
    Go To Campaign for iTruemart Home Page
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=500
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id}
    Build Drools
    Delete Promotion By ID    ${g_promo_id}
    ${g_promo_id}=    Set Variable    ${EMPTY}
    Promotion Pending Status Should Be Equal    Delete Pending
    Build Drools
    Filter Promotion List by Promotion ID    ${promo_id}
    Table Should Not Contain Data (No Data)

TC_CAMPS_00991 Update promotion(s) status to disable by Disable button at promotion list page, promotions will be needed to build drool file
    [Tags]    TC_CAMPS_00991    ready    Regression
    ${tc_number}=    Get Test Case Number
    Go To Campaign for iTruemart Home Page
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=500
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Pending Status Should Be Equal    Create Pending
    Build Drools
    #.. Disable Promotion
    Disable Promotion by ID    ${g_promo_id}    ${g_camp_id}
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    ${matched_promotion}=    Get Matched MNP Promotion by Variant via API    @{VALID-PRIMARY-VARIANT}[1]
    List Should Not Contain Value    ${matched_promotion}    ${g_promo_id}
    #.. Enable Promotion
    Enable Promotion by ID    ${g_promo_id}    ${g_camp_id}
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    ${matched_promotion}=    Get Matched MNP Promotion by Variant via API    @{VALID-PRIMARY-VARIANT}[1]
    List Should Contain Value    ${matched_promotion}    ${g_promo_id}

TC_CAMPS_00992 Update promotion(s) status to enable by Enable button at promotion list page, promotions will be needed to build drool file
    [Tags]    TC_CAMPS_00992    ready    Regression
    ${tc_number}=    Get Test Case Number
    Go To Campaign for iTruemart Home Page
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[1]    discType=Fixed    discAmount=500
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${tc_number}    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    disable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Pending Status Should Be Equal    -
    #.. Enable Promotion
    Enable Promotion by ID    ${g_promo_id}    ${g_camp_id}
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    ${matched_promotion}=    Get Matched MNP Promotion by Variant via API    @{VALID-PRIMARY-VARIANT}[1]
    List Should Contain Value    ${matched_promotion}    ${g_promo_id}
    #.. Disable Promotion
    Disable Promotion by ID    ${g_promo_id}    ${g_camp_id}
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    ${matched_promotion}=    Get Matched MNP Promotion by Variant via API    @{VALID-PRIMARY-VARIANT}[1]
    List Should Not Contain Value    ${matched_promotion}    ${g_promo_id}
