*** Settings ***
Force Tags    WLS_CAMP_Promotion
Suite Setup       Create Test Suite Campaign
Suite Teardown    Delete If Created Campaign and Close All Browsers    ${g_camp_id}
Test Setup        Open Camps Browser
Test Teardown     Delete If Created Promotion and Close All Browsers    ${g_promo_id}
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_00021 Verify promotion Freebie form
    [TAGS]    TC_CAMPS_00021    Regression    Sanity
    Go To Campaign for iTruemart Home Page
	Go To Promotion List under Campaign    ${g_camp_id}
    Go To Create Promotions Page
    ${template_name}=    Get Text From Table    createPromotionTable    1    1
    Should Be Equal    ${template_name}    Freebie
    Go To Create Freebie promotion Page
    Verify Promotion Information Template    Freebie
    #Promotion Rule
    Element Should Be Visible    ${PROMO-CRITERIA-TYPE-SELECT}
    : FOR    ${index}    IN    Category    Brand    Variant
    \    Select From List    ${PROMO-CRITERIA-TYPE-SELECT}    ${index}
    Element Should Be Visible    ${PROMO-CRITERIA-VALUE-FIELD}
    Element Should Be Visible    ${PROMO-MIN-QUANTITY-RADIO-SPAN}
    Element Should Be Visible    ${PROMO-MIN-QUANTITY-FIELD}
    Element Should Be Visible    ${PROMO-MIN-VALUE-RADIO-SPAN}
    Element Should Be Visible    ${PROMO-MIN-VALUE-FIELD}
    #  .. [Temporary] Disable AND/OR option
    # Element Should Be Visible    ${PROMO-FREE-TYPE-OR-RADIO-SPAN}
    # Element Should Be Visible    ${PROMO-FREE-TYPE-AND-RADIO-SPAN}
	#  .. [Temporary] Remove Adding Free Variants Feature
    # Element Should Be Visible    ${ADD-VARIANT-BUTTON}
	Free Variant And Quantity Should Be Visible    1
    # Click Element    ${ADD-VARIANT-BUTTON}
    # Free Variant And Quantity Should Be Visible    2
	# Click Element    ${ADD-VARIANT-BUTTON}
    # Free Variant And Quantity Should Be Visible    3
    Element Should Be Visible    ${PROMO-REPEAT-FIELD}
    Element Should Be Visible    ${PROMO-FREEBIE-NOTE-FIELD}
    Element Should Be Visible    ${PROMO-FREEBIE-NOTE-TRANS1-FIELD}

	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVC-DESKTOP-DIV}
	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVC-DESKTOP-TRANS1-DIV}
	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVC-MOBILE-DIV}
	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVC-MOBILE-TRANS1-DIV}
	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVD-DESKTOP-DIV}
	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVD-DESKTOP-TRANS1-DIV}
	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVD-MOBILE-DIV}
	Element Should Be Visible    ${PROMO-FREEBIE-IMG-LVD-MOBILE-TRANS1-DIV}

TC_CAMPS_00022 Valid promotion, buy criteria is number of item, free 1 item
    [TAGS]    TC_CAMPS_00022    Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00023 Valid promotion, buy criteria is number of item, free multiple items
    [TAGS]    TC_CAMPS_00023    Regression
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    ${element2}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}    ${element2}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0],@{VALID-VARIANT}[1]    item    3    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00024 Valid promotion, buy criteria is minimum buy value, free 1 item
    [TAGS]    TC_CAMPS_00024    Regression
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    baht    2000    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00025 Valid promotion, buy criteria is minimum buy value, free multiple items
    [TAGS]    TC_CAMPS_00025    Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
	${element2}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[3]    quantity=3
    @{free_variants_list}=    Create List    ${element1}    ${element2}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0],@{VALID-VARIANT}[1]    baht    500    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00026 Valid promotion, criteria type is category
    [TAGS]    TC_CAMPS_00026    Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Category    @{VALID-CAT}[0]    item     2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00027 Valid promotion, criteria type is brand
    [TAGS]    TC_CAMPS_00027    Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Brand    @{VALID-BRAND}[0]    baht    1000    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00028 Valid promotion, criteria type is variant
    [TAGS]    TC_CAMPS_00028    Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00029 Empty promotion name
    [TAGS]    TC_CAMPS_00029    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${EMPTY}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00030 Empty promotion name (translation)
    [TAGS]    TC_CAMPS_00030    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${EMPTY}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00031 Empty promotion long description
    [TAGS]    TC_CAMPS_00031    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${EMPTY}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    baht    2000    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00032 Empty promotion long description (translation)
    [TAGS]    TC_CAMPS_00032    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
	Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00033 Empty promotion short description
    [TAGS]    TC_CAMPS_00033    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00034 Empty promotion short description (translation)
    [TAGS]    TC_CAMPS_00034    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00035 Default value for promotion status
    [TAGS]    TC_CAMPS_00035    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    default    both    Variant    @{VALID-VARIANT}[0]    baht    2000    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    DISABLED
    # Check on Edit page again
    Edit Latest Promotion
    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}

TC_CAMPS_00036 Default value for member privilege
    [TAGS]    TC_CAMPS_00036    Full Regression
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    default    Variant    @{VALID-VARIANT}[0]    baht    2000    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
	Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE
    # Check on Edit page again
    Edit Latest Promotion
    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}

TC_CAMPS_00037 Default value for promotion period
    [TAGS]    TC_CAMPS_00037    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    9    59    default    23    59
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    baht    2000    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE
    # Check on Edit page again
    Edit Latest Promotion
    ${today} =    Get Current Date
    ${tomorrow} =    Add Time To Date    ${today}    1 day
    ${today}=    Convert Date    ${today}    datetime
    ${tomorrow} =    Convert Date    ${tomorrow}    datetime
    Textfield Should Contain    ${PERIOD-FIELD}    @{MONTHS}[${today.month}] ${today.day}, ${today.year} 00:00 - @{MONTHS}[${tomorrow.month}] ${tomorrow.day}, ${tomorrow.year} 00:00

TC_CAMPS_00038 Empty promotion period
    [TAGS]    TC_CAMPS_00038    Full Regression
	Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    none    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00039 Empty criteria type
    [TAGS]    TC_CAMPS_00039    Full Regression
	Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${EMPTY}    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-CRITERIA-TYPE-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00040 Empty criteria item
    [TAGS]    TC_CAMPS_00040    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    ${EMPTY}    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Select From List    ${PROMO-CRITERIA-TYPE-SELECT}    @{criteria_typesPromotion}[1]
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    ${EMPTY}
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Select From List    ${PROMO-CRITERIA-TYPE-SELECT}    @{criteria_typesPromotion}[2]
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    ${EMPTY}
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00041 Invalid value buy item number
    [TAGS]    TC_CAMPS_00041    Full Regression
	Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    ${EMPTY}    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Text    ${PROMO-MIN-QUANTITY-FIELD}    0
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-MIN-TOTAL-BOUNDARY-MSG}
    Input Text    ${PROMO-MIN-QUANTITY-FIELD}    -1
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-MIN-TOTAL-BOUNDARY-MSG}
    Input Text    ${PROMO-MIN-QUANTITY-FIELD}    1,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-NUMBER-TYPE-MSG}
    Input Text    ${PROMO-MIN-QUANTITY-FIELD}    abc
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-NUMBER-TYPE-MSG}
    Page Should Contain    ${VALIDATE-MIN-TOTAL-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00042 Invalid value buy value
    [TAGS]    TC_CAMPS_00042    Full Regression
	Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    baht    ${EMPTY}    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Text    ${PROMO-MIN-VALUE-FIELD}    0
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-BAHT-BOUNDARY-MSG}
    Input Text    ${PROMO-MIN-VALUE-FIELD}    1,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Input Text    ${PROMO-MIN-VALUE-FIELD}    abc
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Page Should Contain    ${VALIDATE-BAHT-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00043 Empty free item varaint
    [TAGS]    TC_CAMPS_00043    Full Regression
	Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=${EMPTY}    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    baht    2000    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00044 Invalid value free item number
    [TAGS]    TC_CAMPS_00044    Full Regression
	Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=${EMPTY}
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    baht    2000    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Free Variant and Quantity Detail    1    @{VALID-VARIANT}[2]    0
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-MIN-TOTAL-BOUNDARY-MSG}
    Input Free Variant and Quantity Detail    1    @{VALID-VARIANT}[2]    -1
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-MIN-TOTAL-BOUNDARY-MSG}
    Input Free Variant and Quantity Detail    1    @{VALID-VARIANT}[2]    1,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-NUMBER-TYPE-MSG}
    Input Free Variant and Quantity Detail    1    @{VALID-VARIANT}[2]    abc
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-NUMBER-TYPE-MSG}
    Page Should Contain    ${VALIDATE-MIN-TOTAL-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00045 Invalid value repeat/cart number
    [TAGS]    TC_CAMPS_00045    Full egression
	Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    baht    2000    ${EMPTY}
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Text    ${PROMO-REPEAT-FIELD}    -1
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-REPEAT-BOUNDARY-MSG}
    Input Text    ${PROMO-REPEAT-FIELD}    1,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-NUMBER-TYPE-MSG}
    Input Text    ${PROMO-REPEAT-FIELD}    abc
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-NUMBER-TYPE-MSG}
    Page Should Contain    ${VALIDATE-REPEAT-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00750 Empty Note
    [TAGS]    TC_CAMPS_00750    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${EMPTY}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00751 Empty Note (Translation)
    [TAGS]    TC_CAMPS_00751    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${EMPTY}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00752 Empty Freebie Image Level C (Desktop)
    [TAGS]    TC_CAMPS_00752    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	# Upload Image to Freebie Image LVC Desktop
	Upload Image to Freebie Image LVC Desktop Translation
	Upload Image to Freebie Image LVC Mobile
	Upload Image to Freebie Image LVC Mobile Translation
	Upload Image to Freebie Image LVD Desktop
	Upload Image to Freebie Image LVD Desktop Translation
	Upload Image to Freebie Image LVD Mobile
	Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00753 Empty Freebie Image Level C (Desktop) Translation
    [TAGS]    TC_CAMPS_00753    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	Upload Image to Freebie Image LVC Desktop
	# Upload Image to Freebie Image LVC Desktop Translation
	Upload Image to Freebie Image LVC Mobile
	Upload Image to Freebie Image LVC Mobile Translation
	Upload Image to Freebie Image LVD Desktop
	Upload Image to Freebie Image LVD Desktop Translation
	Upload Image to Freebie Image LVD Mobile
	Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00754 Empty Freebie Image Level C (Mobile)
    [TAGS]    TC_CAMPS_00754    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	Upload Image to Freebie Image LVC Desktop
	Upload Image to Freebie Image LVC Desktop Translation
	# Upload Image to Freebie Image LVC Mobile
	Upload Image to Freebie Image LVC Mobile Translation
	Upload Image to Freebie Image LVD Desktop
	Upload Image to Freebie Image LVD Desktop Translation
	Upload Image to Freebie Image LVD Mobile
	Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00755 Empty Freebie Image Level C (Mobile) Translation
    [TAGS]    TC_CAMPS_00755    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	Upload Image to Freebie Image LVC Desktop
	Upload Image to Freebie Image LVC Desktop Translation
	Upload Image to Freebie Image LVC Mobile
	# Upload Image to Freebie Image LVC Mobile Translation
	Upload Image to Freebie Image LVD Desktop
	Upload Image to Freebie Image LVD Desktop Translation
	Upload Image to Freebie Image LVD Mobile
	Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00786 Valid promotion, free type is OR
    [TAGS]    TC_CAMPS_00786    Regression
	Log    CANCEL FOR NOW
	# ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    # @{free_variants_list}=    Create List    ${element1}
    # Go To Campaign for iTruemart Home Page
    # Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    # ...    default    0    00    ${EMPTY}    0    00
    # ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    4
    # ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    # Wait Until Page Contains Promotion List under Campaign Table
    # ${g_promo_id}=    Get Promotion ID
    # Promotion Name Should Be As Test Case Number
    # Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00787 Valid promotion, free type is AND
    [TAGS]    TC_CAMPS_00787    Regression
	Log    CANCEL FOR NOW
    # ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    # @{free_variants_list}=    Create List    ${element1}
    # Go To Campaign for iTruemart Home Page
    # Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    # ...    default    0    00    ${EMPTY}    0    00
    # ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    3    1
    # ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    # Wait Until Page Contains Promotion List under Campaign Table
    # ${g_promo_id}=    Get Promotion ID
    # Promotion Name Should Be As Test Case Number
    # Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00788 Empty Free Type
    [TAGS]    TC_CAMPS_00788    Full Regression
	Log    CANCEL FOR NOW
    # Go To Campaign for iTruemart Home Page
    # Go To Promotion List under Campaign    ${g_camp_id}
    # ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	# ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    # @{free_variants_list}=    Create List    ${element1}
    # Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    # ...    default    0    00    ${EMPTY}    0    00
    # ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    # ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    none    @{free_variants_list}
    ## Promotion will not be created and found error
    # Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    # Page Should Contain    ${VALIDATE-EMPTY-FREE-TYPE-MSG}
    # Go To Promotion List under Campaign    ${g_camp_id}
    # ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    # Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00818 Empty Freebie Image Level D (Desktop)
    [TAGS]    TC_CAMPS_00818    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	Upload Image to Freebie Image LVC Desktop
	Upload Image to Freebie Image LVC Desktop Translation
	Upload Image to Freebie Image LVC Mobile
	Upload Image to Freebie Image LVC Mobile Translation
	# Upload Image to Freebie Image LVD Desktop
	Upload Image to Freebie Image LVD Desktop Translation
	Upload Image to Freebie Image LVD Mobile
	Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00819 Empty Freebie Image Level D (Desktop) Translation
    [TAGS]    TC_CAMPS_00819    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	Upload Image to Freebie Image LVC Desktop
	Upload Image to Freebie Image LVC Desktop Translation
	Upload Image to Freebie Image LVC Mobile
	Upload Image to Freebie Image LVC Mobile Translation
	Upload Image to Freebie Image LVD Desktop
	# Upload Image to Freebie Image LVD Desktop Translation
	Upload Image to Freebie Image LVD Mobile
	Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00820 Empty Freebie Image Level D (Mobile)
    [TAGS]    TC_CAMPS_00820    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=2
    @{free_variants_list}=    Create List    ${element1}
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	Upload Image to Freebie Image LVC Desktop
	Upload Image to Freebie Image LVC Desktop Translation
	Upload Image to Freebie Image LVC Mobile
	Upload Image to Freebie Image LVC Mobile Translation
	Upload Image to Freebie Image LVD Desktop
	Upload Image to Freebie Image LVD Desktop Translation
	# Upload Image to Freebie Image LVD Mobile
	Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00821 Empty Freebie Image Level D (Mobile) Translation
    [TAGS]    TC_CAMPS_00821    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[2]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[0]    item    2    1
    ...    ${false}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	Upload Image to Freebie Image LVC Desktop
	Upload Image to Freebie Image LVC Desktop Translation
	Upload Image to Freebie Image LVC Mobile
	Upload Image to Freebie Image LVC Mobile Translation
	Upload Image to Freebie Image LVD Desktop
	Upload Image to Freebie Image LVD Desktop Translation
	Upload Image to Freebie Image LVD Mobile
	# Upload Image to Freebie Image LVD Mobile Translation
	Click Button    ${CREATE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00834 Warning message will be displayed when creating promotion with the criteria variant is duplicate with existing promotion in the same period (current, past, future)
    [TAGS]    TC_CAMPS_00834
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${next_5_day}=    Get Next Date from Today    5
    ${yesterday}=    Get Next Date from Today    -1
    ${last_2_day}=    Get Next Date from Today    -2
	${last_5_day}=    Get Next Date from Today    -5
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Campaign List Page
    Edit Latest Campaign
    Input Date Time Information    ${last_5_day}    ${next_2_day}
    Click Button    ${UPDATE-BUTTON}
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    ${last_5_day}    0    00    ${next_2_day}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
    Go To Campaign for iTruemart Home Page
    #existing current & create current
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
  	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${g_promo_id}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    #existing current & create past
    Input Date Time Information    ${last_5_day}    ${yesterday}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    #existing current & create future
    Input Date Time Information    ${tomorrow}    ${next_2_day}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

    Edit Promotion By ID    ${g_promo_id}
    #existing past & create current
    Input Date Time Information    ${last_5_day}    ${yesterday}
    Click Button    ${UPDATE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table
    Build Drools
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    #existing past & create past
    Input Date Time Information    ${last_2_day}    ${yesterday}
    Click Button    ${CREATE-BUTTON}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

    Edit Promotion By ID    ${g_promo_id}
    #existing future & create current
    Input Date Time Information    ${tomorrow}    ${next_5_day}
    Click Button    ${UPDATE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table
	Build Drools
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${next_2_day}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    #existing future & create future
    Input Date Time Information    ${tomorrow}    ${next_2_day}
    Click Button    ${CREATE-BUTTON}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

TC_CAMPS_00835 Warning message will be displayed when creating promotion with the criteria variant is duplicate with existing promotion in the same period for all status (live, enabled, disabled, expired)
    [TAGS]    TC_CAMPS_00835
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${yesterday}=    Get Next Date from Today    -1
	  ${last_5_day}=    Get Next Date from Today    -5
	  ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Campaign List Page
    Edit Latest Campaign
    Input Date Time Information    ${last_5_day}    ${next_2_day}
    Click Button    ${UPDATE-BUTTON}
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    ${last_5_day}    0    00    ${next_2_day}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
      ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
      Go To Campaign for iTruemart Home Page
    #existing live & create live
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
  	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${g_promo_id}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    #existing live & create expired
    Input Date Time Information    ${last_5_day}    ${yesterday}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    #existing live & create enabled
    Input Date Time Information    ${tomorrow}    ${next_2_day}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    #existing live & create disabled
    Unselect Checkbox    ${ENABLE-TOGGLE}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

TC_CAMPS_00836 Warning message will be displayed when creating promotion with some criteria variants are duplicate with existing promotion in the same period
    [TAGS]    TC_CAMPS_00836
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
	Go To Promotion List under Campaign    ${g_camp_id}
	Build Drools
	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[10],@{VALID-VARIANT}[9]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[10],@{VALID-VARIANT}[8]    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${g_promo_id}
	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

TC_CAMPS_00837 Warning message will be displayed when creating promotion with some criteria variants are duplicate with more than 1 existing promotions in the same period
    [TAGS]    TC_CAMPS_00837
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
	Go To Promotion List under Campaign    ${g_camp_id}
	Build Drools
	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[8],@{VALID-VARIANT}[9],@{VALID-VARIANT}[10]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[8],@{VALID-VARIANT}[9],@{VALID-VARIANT}[1]     item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[8]=${g_promo_id}    @{VALID-VARIANT}[9]=${g_promo_id}
	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

TC_CAMPS_00838 Warning message will be displayed when creating promotion with the criteria variant is duplicate with existing promotion under another campaign in the same period
    [TAGS]    TC_CAMPS_00838    Full Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	${tc_number}=     Get Test Case Number    ${TEST_NAME}
  	Go To Campaign for iTruemart Home Page
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-pro1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
    Go To Campaign for iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}-camp2    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
      ...    00    default    0    00    enable
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    ${g_loading_delay}
    ${camp_id1}=    Set Variable    ${g_camp_id}
    ${camp_id2}=    Get Campaign ID
	Set Suite Variable    ${g_camp_id}    ${camp_id2}
    Create Promotion Freebie    ${TEST_NAME}-pro2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${g_promo_id}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
	[Teardown]     Run Keywords    Set Suite Variable    ${g_camp_id}    ${camp_id1}    AND    Delete Promotion By ID    ${g_promo_id}    AND    Delete Campaign By ID    ${camp_id2}    AND    Close All Browsers

TC_CAMPS_00839 Warning message will be displayed when duplicating promotion with the criteria variant is duplicate with existing promotion in the same period (current, past, future)
    [TAGS]    TC_CAMPS_00839
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${yesterday}=    Get Next Date from Today    -1
    ${last_5_day}=    Get Next Date from Today    -5
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Campaign List Page
    Edit Latest Campaign
    Input Date Time Information    ${last_5_day}    ${next_2_day}
    Click Button    ${UPDATE-BUTTON}
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    ${last_5_day}    0    00    ${next_2_day}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}

    Duplicate Latest Promotion
    Input Date Time Information    ${EMPTY}    ${EMPTY}
    Click Button    ${CREATE-BUTTON}
    &{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${g_promo_id}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Input Date Time Information    ${last_5_day}    ${yesterday}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Input Date Time Information    ${tomorrow}    ${next_2_day}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Unselect Checkbox    ${ENABLE-TOGGLE}
    Click Button    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

TC_CAMPS_00840 Cancel to create promotion that has duplicate criteria variant with existing promotion in the same period
    [TAGS]    TC_CAMPS_00840    Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
	Go To Promotion List under Campaign    ${g_camp_id}
	Build Drools
	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID under Campaign    ${g_camp_id}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${g_promo_id}
	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${g_promo_id}

TC_CAMPS_00841 Confirm to create promotion that has duplicate criteria variant with existing promotion in the same period
    [TAGS]    TC_CAMPS_00841    Regression
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
	Go To Promotion List under Campaign    ${g_camp_id}
	Build Drools
	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${promo_idBefore}
	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    create    ${expected_dup_var_promo}
	Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore},${promo_idAfter}
    Should Not Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00842 Warning message will be displayed when updating promotion with the criteria variant is duplicate with existing promotion in the same period (current, past, future)
    [TAGS]    TC_CAMPS_00842
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${yesterday}=    Get Next Date from Today    -1
	${last_5_day}=    Get Next Date from Today    -5
	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	Go To Campaign for iTruemart Home Page
	Go To Promotion List under Campaign    ${g_camp_id}
	Build Drools
	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    UNIQUEVARIANT    item    1    2
    ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore},${promo_idAfter}
    Should Not Be Equal    ${promo_idAfter}    ${promo_idBefore}
    Edit Latest Promotion
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    @{VALID-VARIANT}[10]
    Input Date Time Information    ${EMPTY}    ${EMPTY}
    Click Button    ${UPDATE-BUTTON}
    &{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${promo_idBefore}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Input Date Time Information    ${last_5_day}    ${yesterday}
    Click Button    ${UPDATE-BUTTON}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Input Date Time Information    ${tomorrow}    ${next_2_day}
    Click Button    ${UPDATE-BUTTON}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

TC_CAMPS_00843 Warning message will be displayed when updating promotion with the criteria variant is duplicate with existing promotion in the same period for all status (live, enabled, disabled, expired)
    [TAGS]    TC_CAMPS_00843
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${yesterday}=    Get Next Date from Today    -1
	${last_5_day}=    Get Next Date from Today    -5
  	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    UNIQUEVARIANT    item    1    2
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore},${promo_idAfter}
    Should Not Be Equal    ${promo_idAfter}    ${promo_idBefore}
    Edit Latest Promotion
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    @{VALID-VARIANT}[10]
    Input Date Time Information    ${EMPTY}    ${EMPTY}
    Click Element    ${UPDATE-BUTTON}
    &{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${promo_idBefore}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Input Date Time Information    ${last_5_day}    ${yesterday}
    Click Element    ${UPDATE-BUTTON}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Input Date Time Information    ${tomorrow}    ${next_2_day}
    Click Element    ${UPDATE-BUTTON}
    Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
    Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

    Unselect Checkbox    ${ENABLE-TOGGLE}
    Click Element    ${CREATE-BUTTON}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

TC_CAMPS_00844 Warning message will be displayed when updating promotion with some criteria variants are duplicate with existing promotion in the same period
    [TAGS]    TC_CAMPS_00844
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${yesterday}=    Get Next Date from Today    -1
	${last_5_day}=    Get Next Date from Today    -5
  	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[9],@{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    UNIQUEVARIANT    item    1    2
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore},${promo_idAfter}
    Should Not Be Equal    ${promo_idAfter}    ${promo_idBefore}
    Edit Latest Promotion
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    @{VALID-VARIANT}[10]
    Input Date Time Information    ${EMPTY}    ${EMPTY}
    Click Element    ${UPDATE-BUTTON}
    &{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${promo_idBefore}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

TC_CAMPS_00845 Warning message will be displayed when updating promotion with some criteria variants are duplicate with more than 1 existing promotions in the same period
    [TAGS]    TC_CAMPS_00845    Full Regression
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${yesterday}=    Get Next Date from Today    -1
	${last_5_day}=    Get Next Date from Today    -5
  	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[8],@{VALID-VARIANT}[9],@{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    UNIQUEVARIANT    item    1    2
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore},${promo_idAfter}
    Should Not Be Equal    ${promo_idAfter}    ${promo_idBefore}
    Edit Latest Promotion
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    @{VALID-VARIANT}[9],@{VALID-VARIANT}[10]
    Click Element    ${UPDATE-BUTTON}
    &{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[9]=${promo_idBefore}    @{VALID-VARIANT}[10]=${promo_idBefore}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant

TC_CAMPS_00846 Warning message will be displayed when updating promotion with the criteria variant is duplicate with existing promotion under another campaign in the same period
    [TAGS]    TC_CAMPS_00846    Full Regression
  	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
	${tc_number}=     Get Test Case Number    ${TEST_NAME}
  	Go To Campaign for iTruemart Home Page
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-pro1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id1}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable    ${promo_id1}
    Go To Campaign for iTruemart Home Page
    Go To Create Campaign Page
    Create Campaign    ${tc_number}-camp2    ${tc_number}    ${VALID-CAMPAIGN-DETAIL}    ${VALID-CAMPAIGN-DETAIL}    default    0
      ...    00    default    0    00    enable
    Wait Until Page Contains Element    ${CAMPAIGN-LIST-TABLE}    ${g_loading_delay}
	${camp_id1}=    Set Variable    ${g_camp_id}
    ${camp_id2}=    Get Campaign ID
	Set Suite Variable    ${g_camp_id}    ${camp_id2}
    Create Promotion Freebie    ${TEST_NAME}-pro2    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    UNIQUEVARIANT    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
	Set Suite Variable    ${g_camp_id}    ${camp_id1}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_id2}=    Get Promotion ID under Campaign    ${camp_id2}
	# ${g_promo_id}=    Set Variable    ${promo_id1},${promo_id2}
    Should Not Be Equal    ${promo_id2}    ${promo_id1}
    Edit Latest Promotion
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    @{VALID-VARIANT}[10]
    Click Element    ${UPDATE-BUTTON}
  	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${promo_id1}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
  	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
	[Teardown]     Run Keywords    Set Suite Variable    ${g_camp_id}    ${camp_id1}    AND    Delete Promotion By ID    ${g_promo_id}    AND    Delete Campaign By ID    ${camp_id2}    AND    Close All Browsers

TC_CAMPS_00847 Cancel to update promotion that has duplicate criteria variant with existing promotion in the same period
    [TAGS]    TC_CAMPS_00847    Regression
  	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    UNIQUEVARIANT    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore},${promo_idAfter}
    Should Not Be Equal    ${promo_idAfter}    ${promo_idBefore}
    Edit Latest Promotion
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    @{VALID-VARIANT}[10]
    Input Date Time Information    ${EMPTY}    ${EMPTY}
    Click Element    ${UPDATE-BUTTON}
  	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${promo_idBefore}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
	Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Click Button    ${CANCEL-BUTTON}
  	Wait Until Page Contains Promotion List under Campaign Table
    Edit Latest Promotion
    Verify Freebie Promotion Rule    @{criteria_typesPromotion}[2]    UNIQUEVARIANT    item    2    @{VALID-VARIANT}[1]    1    4

TC_CAMPS_00848 Confirm to update promotion that has duplicate criteria variant with existing promotion in the same period
    [TAGS]    TC_CAMPS_00848    Regression
  	${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
  	Go To Campaign for iTruemart Home Page
  	Go To Promotion List under Campaign    ${g_camp_id}
  	Build Drools
  	Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    @{VALID-VARIANT}[10]    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
  	Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore}
    Go To Campaign for iTruemart Home Page
    Create Promotion Freebie    ${TEST_NAME}-1    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
      ...    default    0    00    ${EMPTY}    0    00
      ...    enable    both    Variant    UNIQUEVARIANT    item    2    4
      ...    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    AND    @{free_variants_list}
    Wait Until Page Contains Promotion List under Campaign Table
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
	${g_promo_id}=    Set Variable   ${promo_idBefore},${promo_idAfter}
    Should Not Be Equal    ${promo_idAfter}    ${promo_idBefore}
    Edit Latest Promotion
    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    @{VALID-VARIANT}[10]
    Input Date Time Information    ${EMPTY}    ${EMPTY}
    Click Element    ${UPDATE-BUTTON}
  	&{expected_dup_var_promo}=    Create Dictionary    @{VALID-VARIANT}[10]=${promo_idBefore}
  	Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant    update    ${expected_dup_var_promo}
  	Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
  	Wait Until Page Contains Promotion List under Campaign Table
    Edit Latest Promotion
    Verify Freebie Promotion Rule    @{criteria_typesPromotion}[2]    UNIQUEVARIANT,@{VALID-VARIANT}[10]    item    2    @{VALID-VARIANT}[1]    1    4
