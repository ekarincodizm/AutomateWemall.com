*** Settings ***
Force Tags    WLS_CAMP_Template
Library           DateTime
Library           String
Library           OperatingSystem
Library           ../../Python_Library/GetWebdriverInstance.py
Library           ../../Python_Library/common.py
Resource          ../../Resource/Config/stark/env_config.robot
Resource          ../../Resource/TestData/camps_id_library.txt
Resource          ../../Keyword/API/CAMPS/camps_keywords_library.robot
Resource          ../../Keyword/API/CAMPS/camps_api_keywords.robot
Resource          ../../Resource/TestData/test_data_variables.txt
Resource          ../../Resource/TestData/message_library.txt
Test Setup        Open Camps Browser
Test Teardown     Delete If Created Campaign and Close All Browsers    ${g_camp_id}

*** Test Cases ***
TC_CAMPS_00572 Verify Create campaign form
    [Tags]    TC_CAMPS_00572    Verify Create campaign form
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Verify Campaign Information Template

TC_CAMPS_00573 Able to Create valid campaign
    [Tags]    TC_CAMPS_00573    Able to Create valid campaign
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${TEST_NAME}    ${TEST_NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
    ${campaignName}=    Get Campaign Name
    ${campaignEnable}=    Get Latest Campaign Enable Status
    ${campaignRunning}=    Get Latest Campaign Running Status
    Should Be Equal    ${campaignName}    ${TEST_NAME}
    Should Be True    ${campaignEnable}
    Should Be True    ${campaignRunning}

TC_CAMPS_00574 Able to Create campaign When Campaign Duplicate name
    [Tags]    TC_CAMPS_00574    Able to Create campaign When Campaign Duplicate name
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${TEST_NAME}    ${TEST_NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
    ${campaignName}=    Get Campaign Name
    ${campaignEnable}=    Get Latest Campaign Enable Status
    ${campaignRunning}=    Get Latest Campaign Running Status
    Should Be Equal    ${campaignName}    ${TEST_NAME}
    Should Be True    ${campaignEnable}
    Should Be True    ${campaignRunning}
    Go To Create Campaign Page
    Create Campaign    ${TEST_NAME}    ${TEST_NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
	Confirm to create campaign with duplicated name
    Wait Until Page Contains Campaign List Table
    ${campaignName}=    Get Campaign Name
    ${campaignEnable}=    Get Latest Campaign Enable Status
    ${campaignRunning}=    Get Latest Campaign Running Status
    Should Be Equal    ${campaignName}    ${TEST_NAME}
    Should Be True    ${campaignEnable}
    Should Be True    ${campaignRunning}
    Delete Latest Campaign

TC_CAMPS_00671 Able to edit campaign when campaign name is duplicated
    [Tags]    TC_CAMPS_00671
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${TEST_NAME}    ${TEST_NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
    ${campaignName}=    Get Campaign Name
    Should Be Equal    ${campaignName}    ${TEST_NAME}
	Duplicate Latest Campaign
	Click Button    ${CREATE-BUTTON}
	Confirm to duplicate all promotions under campaign
	Sleep    1
	Confirm to create campaign with duplicated name
    Wait Until Page Contains Campaign List Table
    ${campaignName}=    Get Campaign Name
	Should Be Equal    ${campaignName}    ${TEST_NAME}
	Edit Latest Campaign
	Input Text    ${CAMPAIGN-DETAIL-FIELD}    Edited
	Click Button    ${CREATE-BUTTON}
	Cancel to update campaign with duplicated name
	Click Button    ${CREATE-BUTTON}
	Confirm to update campaign with duplicated name
    Wait Until Page Contains Campaign List Table
    ${campaignName}=    Get Campaign Name
    Should Be Equal    ${campaignName}    ${TEST_NAME}
    Delete Latest Campaign

TC_CAMPS_00672 Able to edit campaign name to campaign name that is duplicated
    [Tags]    TC_CAMPS_00672
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
    ${campaignName}=    Get Campaign Name
    Should Be Equal    ${campaignName}    ${TEST_NAME}-1
	Go To Create Campaign Page
	Create Campaign    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
    ${campaignName}=    Get Campaign Name
    Should Be Equal    ${campaignName}    ${TEST_NAME}-2
	Edit Latest Campaign
	Input Text    ${CAMPAIGN-NAME-FIELD}    ${TEST_NAME}-1
	Click Button    ${CREATE-BUTTON}
	Cancel to update campaign with duplicated name
	Click Button    ${CREATE-BUTTON}
	Confirm to update campaign with duplicated name
    Wait Until Page Contains Campaign List Table
    ${campaignName}=    Get Campaign Name
    Should Be Equal    ${campaignName}    ${TEST_NAME}-1
    Delete Latest Campaign

TC_CAMPS_00673 Able to duplicate campaign with the duplicated campaign name
    [Tags]    TC_CAMPS_00673
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${TEST_NAME}    ${TEST_NAME}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
    ${campaignName}=    Get Campaign Name
    Should Be Equal    ${campaignName}    ${TEST_NAME}
	Duplicate Latest Campaign
	Click Button    ${CREATE-BUTTON}
	Confirm to duplicate all promotions under campaign
	Sleep    1
	Cancel to create campaign with duplicated name
	Click Button    ${CREATE-BUTTON}
	Confirm to duplicate all promotions under campaign
	Sleep    1
	Confirm to create campaign with duplicated name
    Wait Until Page Contains Campaign List Table
    ${campaignName}=    Get Campaign Name
    Should Be Equal    ${campaignName}    ${TEST_NAME}
    Delete Latest Campaign

TC_CAMPS_00849 Warning message will be displayed when duplicating campaign with the duplicate criteria variant for freebie promotion with existing freebie promotion in the same period (current, past, future)
    [TAGS]    TC_CAMPS_00849
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	${tc_number}=     Get Test Case Number    ${TEST_NAME}
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}-camp1    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
    ${g_camp_id}=    Get Campaign ID
    Create Promotion Freebie    ${tc_number}-pro1    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[8]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
	${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[8]=${g_promo_id}
	Create Promotion Freebie    ${tc_number}-pro2    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    disable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
	Set To Dictionary    ${expected_dup_var_promo}    @{VALID-VARIANT}[10]=${g_promo_id}
    Go To Campaign List Page
    Duplicate Latest Campaign
    Input Text    ${CAMPAIGN-NAME-FIELD}    ${tc_number}-camp2
    Click Button    ${CREATE-BUTTON}
    Confirm To Duplicate All Promotions Under Campaign

    Verify Confirmation Page for Campaign With existing freebie promotion in the same period    duplicate    ${expected_dup_var_promo}
    Cancel To Create or Update Campaign With Duplicated Freebie Criteria Variant

TC_CAMPS_00850 Cancel to create campaign that has duplicate criteria variant for freebie promotion with existing freebie promotion in the same period
    [TAGS]    TC_CAMPS_00850    Regression
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	${tc_number}=     Get Test Case Number    ${TEST_NAME}
    # .. Create Base Campaign with base freebie promotions
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}-camp1    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
    ${g_camp_id}=    Get Campaign ID
    Create Promotion Freebie    ${tc_number}-pro1    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[8]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
	${promo_id1}=    Get Promotion ID under Campaign    ${g_camp_id}
	Create Promotion Freebie    ${tc_number}-pro2    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    disable    both    Variant    @{VALID-VARIANT}[8],@{VALID-VARIANT}[10]    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${promo_id2}=    Get Promotion ID under Campaign    ${g_camp_id}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[8]=${promo_id1}, ${promo_id2}
	Set To Dictionary    ${expected_dup_var_promo}    @{VALID-VARIANT}[10]=${promo_id2}
	# .. Create New Campaign by duplicating the previous one
    Go To Campaign List Page
    Duplicate Latest Campaign
    Input Text    ${CAMPAIGN-NAME-FIELD}    ${tc_number}-camp2
    Click Button    ${CREATE-BUTTON}
    Confirm To Duplicate All Promotions Under Campaign
	# .. Cancel to Create campaign with promotion that has duplicate freebie criteria variant
    Verify Confirmation Page for Campaign With existing freebie promotion in the same period    duplicate    ${expected_dup_var_promo}
    Cancel To Create or Update Campaign With Duplicated Freebie Criteria Variant
	Go To Campaign List Page
	Campaign ID Should Be Equal    ${g_camp_id}

TC_CAMPS_00851 Confirm to create campaign that has duplicate criteria variant for freebie promotion with existing freebie promotion in the same period
    [TAGS]    TC_CAMPS_00851    Regression
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	${tc_number}=     Get Test Case Number    ${TEST_NAME}
	# .. Create Base Campaign with base freebie promotions
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}-camp1    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
    ${g_camp_id}=    Get Campaign ID
    Create Promotion Freebie    ${tc_number}-pro1    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[8],@{VALID-VARIANT}[10]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
	${promo_id1}=    Get Promotion ID under Campaign    ${g_camp_id}
	Create Promotion Freebie    ${tc_number}-pro2    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    disable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${promo_id2}=    Get Promotion ID under Campaign    ${g_camp_id}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[8]=${promo_id1}
	Set To Dictionary    ${expected_dup_var_promo}    @{VALID-VARIANT}[10]=${promo_id1}, ${promo_id2}
	# .. Create New Campaign by duplicating the previous one
    Go To Campaign List Page
    Duplicate Latest Campaign
    Input Text    ${CAMPAIGN-NAME-FIELD}    ${tc_number}-camp2
    Click Button    ${CREATE-BUTTON}
    Confirm To Duplicate All Promotions Under Campaign
	# .. Confirm to Create campaign with promotion that has duplicate freebie criteria variant
    Verify Confirmation Page for Campaign With existing freebie promotion in the same period    duplicate    ${expected_dup_var_promo}
    Confirm To Create or Update Campaign With Duplicated Freebie Criteria Variant
	Wait Until Page Contains Campaign List Table
	Campaign ID Should Not Be Equal    ${g_camp_id}
	${camp_id_2}=    Get Campaign ID
	${g_camp_id}=    Set Variable    ${g_camp_id},${camp_id_2}

TC_CAMPS_00852 Warning message will be not displayed when updating campaign with the duplicate criteria variant for freebie promotion with existing freebie promotion in the same period
    [TAGS]    TC_CAMPS_00852
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	${tc_number}=     Get Test Case Number    ${TEST_NAME}
	# .. Create Base Campaign with base freebie promotions
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}-camp1    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
    ${g_camp_id}=    Get Campaign ID
    Create Promotion Freebie    ${tc_number}-pro1    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[8],@{VALID-VARIANT}[10]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
	${promo_id1}=    Get Promotion ID under Campaign    ${g_camp_id}
	Create Promotion Freebie    ${tc_number}-pro2    ${tc_number}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    disable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
  	Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${promo_id2}=    Get Promotion ID under Campaign    ${g_camp_id}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[8]=${promo_id1}
	Set To Dictionary    ${expected_dup_var_promo}    @{VALID-VARIANT}[10]=${promo_id1}, ${promo_id2}
	# .. Update the previous campaign
    Go To Campaign List Page
    Edit Latest Campaign
    Input Text    ${CAMPAIGN-NAME-FIELD}    edited-${tc_number}-camp1
    Click Button    ${CREATE-BUTTON}
	# .. No Warning message for Updating campaign with promotion that has duplicate freebie criteria variant
    Verify Confirmation Page for Campaign With existing freebie promotion in the same period    update    ${expected_dup_var_promo}
    # Confirm To Create or Update Campaign With Duplicated Freebie Criteria Variant
	# Wait Until Page Contains Campaign List Table
	Go To Campaign List Page
	Campaign ID Should Be Equal    ${g_camp_id}
	Campaign Name Should Be Equal    edited-${tc_number}-camp1

TC_CAMPS_00882 Promotion under campaign will be not matched if campaign is disabled
    [TAGS]    TC_CAMPS_00882    Regression    Bug Fix
	${tc_number}=    Get Test Case Number
# 1. Create campaign
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
# 2. Create Freebie promotion under campaign
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To iTruemart Home Page
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[5]    item    1    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
	Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
	${promo_id_freebie}=    Get Promotion ID
# 3. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=100
    @{bundle_list}    Create List    ${element1}    ${element2}
    Go To iTruemart Home Page
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
# 4. Create MNP promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[5]    discType=Percent    discAmount=25
	@{bundle_list}    Create List    ${element1}
    Go To iTruemart Home Page
    Create Promotion MNP    MNP    MNP    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_mnp}=    Get Promotion ID
# 5. Generate Single Fix Code
    Go To iTruemart Home Page
    Create Single Code Fixed    ${tc_number}    100    882CODE
    Wait Until Page Contains Element    ${CODE-GROUP-LIST-TABLE}    ${g_loading_delay}
    ${g_code_group_id}=    Get Code Group ID
# 6. Create Discount by Code promotion with single fix code from step 5 under campaign
    Go To iTruemart Home Page
    Create Promotion Discount by Code    DBC    DBC    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    @{criteria_typesPromotion}[2]    @{VALID-VARIANT}[5]    ${EMPTY}    ${g_code_group_id}
    ...    1000    percent    70    5000    ${true}    PC1
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_dbc}=    Get Promotion ID
# .. Build Drool File
    Build Drools
	Sleep    2s
# 7. Simulate cart with variant that is matched to all promotion
    ${matched_promotion}=    Get Matched Promotion from Simulating Cart via API    "@{VALID-VARIANT}[5]"    "882CODE"
	: FOR    ${promo_id}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}    ${promo_id_dbc}
	\    List Should Contain Value    ${matched_promotion}    ${promo_id}
# 8. Get matched Freebie promotion by variant that is matched to Freebie promotion
    ${matched_freebie_promotion_id}=    Get Matched Freebie Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Contain Value    ${matched_freebie_promotion_id}    ${promo_id_freebie}
# 9. Get matched Bundle promotion by variant that is matched to Bundle promotion
    ${matched_bundle_promotion_id}=    Get Matched Bundle Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Contain Value    ${matched_bundle_promotion_id}    ${promo_id_bundle}
# 10. Get matched MNP promotion by variant that is matched to MNP promotion
    ${matched_mnp_promotion_id}=    Get Matched MNP Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Contain Value    ${matched_mnp_promotion_id}    ${promo_id_mnp}
# 11. Change campaign status to disable
    Disable Campaign by ID    ${g_camp_id}
# 12. Simulate cart with variant that is matched to all promotion
    ${matched_promotion}=    Get Matched Promotion from Simulating Cart via API    "@{VALID-VARIANT}[5]"    "882CODE"
	: FOR    ${promo_id}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}    ${promo_id_dbc}
	\    List Should Not Contain Value    ${matched_promotion}    ${promo_id}
# 13. Get matched Freebie promotion by variant that is matched to Freebie promotion
    ${matched_freebie_promotion_id}=    Get Matched Freebie Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Not Contain Value    ${matched_freebie_promotion_id}    ${promo_id_freebie}
# 14. Get matched Bundle promotion by variant that is matched to Bundle promotion
    ${matched_bundle_promotion_id}=    Get Matched Bundle Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Not Contain Value    ${matched_bundle_promotion_id}    ${promo_id_bundle}
# 15. Get matched MNP promotion by variant that is matched to MNP promotion
    ${matched_mnp_promotion_id}=    Get Matched MNP Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Not Contain Value    ${matched_mnp_promotion_id}    ${promo_id_mnp}
# 16. Change campaign status to enable
    Enable Campaign by ID    ${g_camp_id}
# 17. Simulate cart with variant that is matched to all promotion
    ${matched_promotion}=    Get Matched Promotion from Simulating Cart via API    "@{VALID-VARIANT}[5]"    "882CODE"
	: FOR    ${promo_id}    IN    ${promo_id_freebie}    ${promo_id_bundle}    ${promo_id_mnp}    ${promo_id_dbc}
	\    List Should Not Contain Value    ${matched_promotion}    ${promo_id}
# 18. Get matched Freebie promotion by variant that is matched to Freebie promotion
    ${matched_freebie_promotion_id}=    Get Matched Freebie Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Not Contain Value    ${matched_freebie_promotion_id}    ${promo_id_freebie}
# 19. Get matched Bundle promotion by variant that is matched to Bundle promotion
    ${matched_bundle_promotion_id}=    Get Matched Bundle Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Not Contain Value    ${matched_bundle_promotion_id}    ${promo_id_bundle}
# 20. Get matched MNP promotion by variant that is matched to MNP promotion
    ${matched_mnp_promotion_id}=    Get Matched MNP Promotion by Variant via API    @{VALID-VARIANT}[5]
	List Should Not Contain Value    ${matched_mnp_promotion_id}    ${promo_id_mnp}

    [Teardown]     Run keywords    Delete Code Group By ID via API    ${g_code_group_id}    AND    Delete If Created Campaign and Close All Browsers    ${g_camp_id}

TC_CAMPS_00883 Promotion under campaign will be forced to disable when set campaign status to disable
    [TAGS]    TC_CAMPS_00883    Regression
	${tc_number}=    Get Test Case Number
# 1. Create campaign
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    enable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
# 2. Create Freebie promotion under campaign
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To iTruemart Home Page
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
	Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
	${promo_id_freebie}=    Get Promotion ID
# 3. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[0]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=100
    @{bundle_list}    Create List    ${element1}    ${element2}
    Go To iTruemart Home Page
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
# 4. Disable Campaign
    Disable Campaign by ID    ${g_camp_id}
# 5. Check Promotion status
    Go To Promotion List under Campaign    ${g_camp_id}
	Promotion Live Status on Current page should be in List    DISABLED

TC_CAMPS_00884 Promotion under campaign will be not forced to enable when set campaign status to enable
    [TAGS]    TC_CAMPS_00884    Regression
	${tc_number}=    Get Test Case Number
# 1. Create campaign
    Go To iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
    ...    00    default    0    00    disable
    Wait Until Page Contains Campaign List Table
	${g_camp_id}=    Get Campaign ID
# 2. Create Freebie promotion under campaign
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To iTruemart Home Page
    Create Promotion Freebie    Freebie    Freebie    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    disable    both    Variant    @{VALID-VARIANT}[0]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
	Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
	${promo_id_freebie}=    Get Promotion ID
# 3. Create Bundle promotion under campaign
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[0]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-VARIANT}[1]    discType=Percent    discAmount=100
    @{bundle_list}    Create List    ${element1}    ${element2}
    Go To iTruemart Home Page
    Create Promotion Bundle    Bundle    Bundle    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    disable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id_bundle}=    Get Promotion ID
# 4. Enable Campaign
    Enable Campaign by ID    ${g_camp_id}
# 5. Check Promotion status
    Go To Promotion List under Campaign    ${g_camp_id}
	Promotion Live Status on Current page should be in List    DISABLED

TEST
    [Tags]    TEST
    ${current_date}=    Get Current Date
    ${tomorrow_date}=    Get Current Date    increment=1 day
    ${status}    ${body}=    Create Flash Sale Wow Banner via API   ${TEST_NAME}    ${TEST_NAME}
    ...    eiei    a    1    cod    ${current_date}
    ...    ${tomorrow_date}    enable    member
    Response Status Code Should Equal    201
    log    ${body}

TEST2
    [TAGS]   TEST2
    @{all_files}=    List Files In Directory    ../../Resource    *.json    absolute
    Log To Console    ${all_files}
    # ${res}=    get relative path of file    'wowBannerCreate.json'
    # Log To Console    ${res}
