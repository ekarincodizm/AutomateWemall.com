*** Settings ***
Force Tags    WLS_CAMP_Promotion
Suite Setup       Create Test Suite Campaign
Suite Teardown    Delete If Created Campaign and Close All Browsers    ${g_camp_id}
Test Setup        Open Camps Browser
Test Teardown     Delete If Created Promotion and Close All Browsers    ${g_promo_id}
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Variables ***
${percentDiscount}    75
${bahtDiscount}    599

*** Test Cases ***
TC_CAMPS_00046 Verify promotion Bundle form
    [TAGS]    TC_CAMPS_00046    Regression    Sanity
    Go To Campaign for iTruemart Home Page
	Go To Promotion List under Campaign    ${g_camp_id}
    Go To Create Promotions Page
    ${template_name}=    Get Text From Table    createPromotionTable    1    2
    Should Be Equal    ${template_name}    Bundle
    Go To Create Bundle promotion Page
    Verify Promotion Information Template    Bundle
    #Promotion Rule
	# Bundle items are including Primary item
    Bundle Form Should Be Visible    2
    Element Should Be Visible    ${ADD-VARIANT-BUTTON}
    Click Element    ${ADD-VARIANT-BUTTON}
    Bundle Form Should Be Visible    3
    Element Should Be Visible    ${CREATE-BUTTON}
    Element Should Be Visible    ${CANCEL-BUTTON}

TC_CAMPS_00047 Valid promotion, get % discount
    [TAGS]    TC_CAMPS_00047    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=25
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=100
    @{bundle_list}    Create List    ${element1}    ${element2}
    Go To Campaign for iTruemart Home Page
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00048 Valid promotion, get baht discount
    [TAGS]    TC_CAMPS_00048    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Fixed    discAmount=5000
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=200
    @{bundle_list}    Create List    ${element1}    ${element2}
    Go To Campaign for iTruemart Home Page
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00049 Valid promotion, get % and baht discount
    [TAGS]    TC_CAMPS_00049    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=70
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=250
    @{bundle_list}    Create List    ${element1}    ${element2}
    Go To Campaign for iTruemart Home Page
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00050 Valid promotion with bundle product more than 1 items
    [TAGS]    TC_CAMPS_00050    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=50
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=100
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=49
    ${element4}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[2]    discType=Fixed    discAmount=400
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}    ${element4}
    Go To Campaign for iTruemart Home Page
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00051 Empty promotion name
    [TAGS]    TC_CAMPS_00051    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${EMPTY}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00052 Empty promotion name (translation)
    [TAGS]    TC_CAMPS_00052    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${EMPTY}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00053 Empty promotion long description
    [TAGS]    TC_CAMPS_00053    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${EMPTY}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00054 Empty promotion long description (translation)
    [TAGS]    TC_CAMPS_00054    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00055 Empty promotion short description
    [TAGS]    TC_CAMPS_00055    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00056 Empty promotion short description (translation)
    [TAGS]    TC_CAMPS_00056    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00057 Default value for promotion status
    [TAGS]    TC_CAMPS_00057    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    default    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
	Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    DISABLED
    # Check on Edit page again
    Edit Latest Promotion
    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}

TC_CAMPS_00058 Default value for member privilege
    [TAGS]    TC_CAMPS_00058    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    default    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    # Check on Edit page again
    Edit Latest Promotion
    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}

TC_CAMPS_00059 Default value for promotion period
    [TAGS]    TC_CAMPS_00059    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    9    59    default    23    59
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    # Check on Edit page again
    Edit Latest Promotion
    ${today} =    Get Current Date
    ${tomorrow} =    Add Time To Date    ${today}    1 day
    ${today}=    Convert Date    ${today}    datetime
    ${tomorrow} =    Convert Date    ${tomorrow}    datetime
    Textfield Should Contain    ${PERIOD-FIELD}    @{MONTHS}[${today.month}] ${today.day}, ${today.year} 00:00 - @{MONTHS}[${tomorrow.month}] ${tomorrow.day}, ${tomorrow.year} 00:00

TC_CAMPS_00060 Empty promotion period
    [TAGS]    TC_CAMPS_00060    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    none    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00061 Empty bundle note
    [TAGS]    TC_CAMPS_00061    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${EMPTY}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00062 Empty bundle note (translation)
    [TAGS]    TC_CAMPS_00062    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${EMPTY}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00063 Empty buy primary variant
    [TAGS]    TC_CAMPS_00063    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=${EMPTY}    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00064 Empty buy bundle variant
    [TAGS]    TC_CAMPS_00064    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=${EMPTY}    discType=Percent    discAmount=${percentDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00065 Invalid value percent discount (Empty, Out of boundary number, Number with comma, String)
    [TAGS]    TC_CAMPS_00065    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${EMPTY}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Percent    50
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Percent    101
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-PERCENT-BUNDLE-BOUNDARY-MSG}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Percent    -1
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Percent    70
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-PERCENT-BUNDLE-BOUNDARY-MSG}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Percent    25
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Percent    2,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Percent    abc
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Percent    75
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Page Should Contain    ${VALIDATE-PERCENT-BUNDLE-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00066 Invalid value baht discount (Empty, Out of boundary number, Number with comma, String)
    [TAGS]    TC_CAMPS_00066    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Fixed    discAmount=${EMPTY}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Fixed    -1
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Fixed    29
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-BAHT-BUNDLE-BOUNDARY-MSG}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Fixed    2500
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Fixed    2,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Fixed    abc
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Fixed    500
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Page Should Contain    ${VALIDATE-BAHT-BUNDLE-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idAfter}    ${promo_idBefore}

TC_CAMPS_00067 Able to add and delete variant bundle field with empty or invalid value before create promotion
    [TAGS]    TC_CAMPS_00067    Bug Fix
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${row_countBefore}=    Get Row Count    promotionListTable
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Fixed    discAmount=${EMPTY}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion Bundle    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Repeat Keyword    2    Click Element    ${ADD-VARIANT-BUTTON}
    Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Fixed    100
    Input Bundle VARIANT and Discount Detail    2    @{VALID-BUNDLE-VARIANT}[0]    Fixed    ${EMPTY}
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Percent    75
    Input Bundle VARIANT and Discount Detail    4    @{VALID-BUNDLE-VARIANT}[0]    Percent    -1
    Remove Bundle Variant by index    4
    Remove Bundle Variant by index    2
    Click Button    ${CREATE-BUTTON}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE