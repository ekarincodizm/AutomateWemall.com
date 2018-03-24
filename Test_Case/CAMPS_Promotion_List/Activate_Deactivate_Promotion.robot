*** Settings ***
Force Tags    WLS_CAMP_Promotion
Test Teardown     Delete If Created Campaign and Close All Browsers    ${g_camp_id}
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_00118 Single promotion that its period is in current time is able to be enabled at promotion list page
    [tags]    TC_CAMPS_00118    ready    Regression
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${status}=    Set Variable    disable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
	#.. Create single promotion that its period is in current time with disable status
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[0]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle}
    #.. Verify promotion status after creating
    Promotion Pending Status Should Be Equal    -
	Promotion Live Status Should Be Equal    DISABLED
	#.. Enable promotion
    Enable Promotion by ID    ${promo_id_bundle}
	Promotion Pending Status Should Be Equal    Update Pending
	Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
	Promotion Live Status Should Be Equal    LIVE
	#.. Check status at Edit page
	Edit Promotion By ID    ${promo_id_bundle}
	Promotion Status on Create/Edit Page Should Be Enable

TC_CAMPS_00119 Multiple promotions that their period are in current time are able to be enabled at promotion list page
    [tags]    TC_CAMPS_00119    ready    Regression
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${status}=    Set Variable    disable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create Freebie promotion under campaign
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    Variant    @{VALID-VARIANT}[0]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_freebie}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_freebie}
    #.. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[2]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle},${g_promo_id}
    #.. Create MNP promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}
    Create Promotion MNP    MNP    MNP    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_mnp}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_mnp},${g_promo_id}
    #.. Verify promotion status after creating
	${count}=    Get Count    ${g_promo_id}    ,
	${count}=    Evaluate    ${count}+2
	: FOR    ${promo_index}    IN RANGE    1    ${count}
	\    Promotion Pending Status Should Be Equal    -
	Promotion Live Status on Current page should be in List    DISABLED
	#.. Enable promotion
    Enable Promotion by ID    ${g_promo_id}
	: FOR    ${promo_index}    IN RANGE    1    ${count}
	\    Promotion Pending Status Should Be Equal    Update Pending
	Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
	Promotion Live Status on Current page should be in List    LIVE
	#.. Check status at Edit page
	: FOR    ${promo_id_index}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}
	\    Edit Promotion By ID    ${promo_id_index}
	\    Promotion Status on Create/Edit Page Should Be Enable
	\    Cancel To Create or Update Promotion

TC_CAMPS_00120 Single promotion that its period is in future time is able to be enabled at promotion list page
    [tags]    TC_CAMPS_00120    ready    Regression
    ${start_date}=    Get Next Date from Today
    ${end_date}=    Get Next Date from Today    2
    ${status}=    Set Variable    disable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create single promotion that its period is in current time with disable status
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[0]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle}
    #.. Verify promotion status after creating
    Promotion Pending Status Should Be Equal    -
    Promotion Live Status Should Be Equal    DISABLED
    #.. Enable promotion
    Enable Promotion by ID    ${promo_id_bundle}
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status Should Be Equal    ENABLED
    #.. Check status at Edit page
    Edit Promotion By ID    ${promo_id_bundle}
    Promotion Status on Create/Edit Page Should Be Enable

TC_CAMPS_00121 Multiple promotions that their period are in future time are able to be enabled at promotion list page
    [tags]    TC_CAMPS_00121    ready    Regression
    ${start_date}=    Get Next Date from Today
    ${end_date}=    Get Next Date from Today    2
    ${status}=    Set Variable    disable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create Freebie promotion under campaign
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    Variant    @{VALID-VARIANT}[0]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_freebie}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_freebie}
    #.. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[2]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle},${g_promo_id}
    #.. Create MNP promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}
    Create Promotion MNP    MNP    MNP    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_mnp}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_mnp},${g_promo_id}
    #.. Verify promotion status after creating
    ${count}=    Get Count    ${g_promo_id}    ,
    ${count}=    Evaluate    ${count}+2
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    -
    Promotion Live Status on Current page should be in List    DISABLED
    #.. Enable promotion
    Enable Promotion by ID    ${g_promo_id}
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status on Current page should be in List    ENABLED
    #.. Check status at Edit page
    : FOR    ${promo_id_index}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}
    \    Edit Promotion By ID    ${promo_id_index}
    \    Promotion Status on Create/Edit Page Should Be Enable
    \    Cancel To Create or Update Promotion

TC_CAMPS_00122 Single promotion that its period is in current time is able to be disabled at promotion list page
    [tags]    TC_CAMPS_00122    ready    Regression
    ${start_date}=    Get Next Date from Today    -1
    ${end_date}=    Get Next Date from Today
    ${status}=    Set Variable    enable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create single promotion that its period is in current time with disable status
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[0]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle}
    #.. Verify promotion status before and after build drools
    Promotion Pending Status Should Be Equal    Create Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Promotion Live Status Should Be Equal    LIVE
    #.. Disable promotion
    Disable Promotion by ID    ${promo_id_bundle}
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status Should Be Equal    DISABLED
    #.. Check status at Edit page
    Edit Promotion By ID    ${promo_id_bundle}
    Promotion Status on Create/Edit Page Should Be Disable

TC_CAMPS_00123 Multiple promotions that their period are in current time are able to be disabled at promotion list page
    [tags]    TC_CAMPS_00123    ready    Regression
    ${start_date}=    Get Next Date from Today    -1
    ${end_date}=    Get Next Date from Today
    ${status}=    Set Variable    enable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create Freebie promotion under campaign
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    Variant    @{VALID-VARIANT}[0]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_freebie}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_freebie}
    #.. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[2]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle},${g_promo_id}
    #.. Create MNP promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}
    Create Promotion MNP    MNP    MNP    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_mnp}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_mnp},${g_promo_id}
    #.. Verify promotion status before and after build drools
    ${count}=    Get Count    ${g_promo_id}    ,
    ${count}=    Evaluate    ${count}+2
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Create Pending
    #.. Build Drool File
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    -
    Promotion Live Status on Current page should be in List    LIVE
    #.. Disable promotion
    Disable Promotion by ID    ${g_promo_id}
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status on Current page should be in List    DISABLED
    #.. Check status at Edit page
    : FOR    ${promo_id_index}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}
    \    Edit Promotion By ID    ${promo_id_index}
    \    Promotion Status on Create/Edit Page Should Be Disable
    \    Cancel To Create or Update Promotion

TC_CAMPS_00124 Single promotion that its period is in future time is able to be disabled at promotion list page
    [tags]    TC_CAMPS_00124    ready   Regression
    ${start_date}=    Get Next Date from Today
    ${end_date}=    Get Next Date from Today    2
    ${status}=    Set Variable    enable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create single promotion that its period is in current time with disable status
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[0]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle}
    #.. Verify promotion status before and after build drools
    Promotion Pending Status Should Be Equal    Create Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Pending Status Should Be Equal    -
    Promotion Live Status Should Be Equal    ENABLED
    #.. Disable promotion
    Disable Promotion by ID    ${promo_id_bundle}
    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status Should Be Equal    DISABLED
    #.. Check status at Edit page
    Edit Promotion By ID    ${promo_id_bundle}
    Promotion Status on Create/Edit Page Should Be Disable

TC_CAMPS_00125 Multiple promotions that their period are in future time are able to be disabled at promotion list page
    [tags]    TC_CAMPS_00125    ready    Regression
    ${start_date}=    Get Next Date from Today
    ${end_date}=    Get Next Date from Today    2
    ${status}=    Set Variable    enable
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create Freebie promotion under campaign
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    Variant    @{VALID-VARIANT}[0]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_freebie}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_freebie}
    #.. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[2]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle},${g_promo_id}
    #.. Create MNP promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}
    Create Promotion MNP    MNP    MNP    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    ${status}    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_mnp}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_mnp},${g_promo_id}
    #.. Verify promotion status before and after build drools
    ${count}=    Get Count    ${g_promo_id}    ,
    ${count}=    Evaluate    ${count}+2
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Create Pending
    #.. Build Drool File
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    -
    Promotion Live Status on Current page should be in List    ENABLED
    #.. Disable promotion
    Disable Promotion by ID    ${g_promo_id}
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status on Current page should be in List    DISABLED
    #.. Check status at Edit page
    : FOR    ${promo_id_index}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}
    \    Edit Promotion By ID    ${promo_id_index}
    \    Promotion Status on Create/Edit Page Should Be Disable
    \    Cancel To Create or Update Promotion

TC_CAMPS_00126 Multiple promotions that their period are in current time with enable and disable status are able to be disabled at promotion list page
    [tags]    TC_CAMPS_00126    ready    Regression
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create Freebie promotion under campaign
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_freebie}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_freebie}
    #.. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[2]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    disable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle},${g_promo_id}
    #.. Create MNP promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}
    Create Promotion MNP    MNP    MNP    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_mnp}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_mnp},${g_promo_id}
    #.. Verify promotion status before and after build drools
    ${count}=    Get Count    ${g_promo_id}    ,
    ${count}=    Evaluate    ${count}+2
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Create Pending
    #.. Build Drool File
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    -
    Promotion Live Status on Current page should be in List    LIVE    DISABLED
    #.. Disable promotion
    Disable Promotion by ID    ${g_promo_id}
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status on Current page should be in List    DISABLED
    #.. Check status at Edit page
    : FOR    ${promo_id_index}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}
    \    Edit Promotion By ID    ${promo_id_index}
    \    Promotion Status on Create/Edit Page Should Be Disable
    \    Cancel To Create or Update Promotion

TC_CAMPS_00127 Multiple promotions that their period are in current time with enable and disable status are able to be enabled at promotion list page
    [tags]    TC_CAMPS_00127    ready    Regression
    ${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
    ${tc_number}=    Get Test Case Number
    Create Campaign for Test Case    ${tc_number}    ${start_date}    ${end_date}
    #.. Create Freebie promotion under campaign
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    disable    both    Variant    @{VALID-VARIANT}[0]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_freebie}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_freebie}
    #.. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[2]    discType=Percent    discAmount=70
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    disable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_bundle},${g_promo_id}
    #.. Create MNP promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
    @{bundle_list}    Create List    ${element1}
    Create Promotion MNP    MNP    MNP    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${start_date}    0    00    ${end_date}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_mnp}=    Get Promotion ID
    ${g_promo_id}=    Set Variable    ${promo_id_mnp},${g_promo_id}
    #.. Verify promotion status before and after build drools
    ${count}=    Get Count    ${g_promo_id}    ,
    ${count}=    Evaluate    ${count}+2
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Create Pending
    #.. Build Drool File
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    -
    Promotion Live Status on Current page should be in List    LIVE    DISABLED
    #.. Enable promotion
    Enable Promotion by ID    ${g_promo_id}
    : FOR    ${promo_index}    IN RANGE    1    ${count}
    \    Promotion Pending Status Should Be Equal    Update Pending
    Build Drools
    Wait Until Page Contains Promotion List under Campaign Table
    Promotion Live Status on Current page should be in List    LIVE
    #.. Check status at Edit page
    : FOR    ${promo_id_index}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}
    \    Edit Promotion By ID    ${promo_id_index}
    \    Promotion Status on Create/Edit Page Should Be Enable
    \    Cancel To Create or Update Promotion
