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
TC_CAMPS_00543 Verify promotion MNP form
    [Tags]    TC_CAMPS_00543    Regression    Sanity
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    Go To Create Promotions Page
    ${template_name}=    Get Text From Table    createPromotionTable    1    3
    Should Be Equal    ${template_name}    MNP
    Go To Create MNP promotion Page
    Verify Promotion Information Template    MNP
    #Promotion Rule
    # Bundle items are not including Primary item
    Element Should Be Visible    ${PROMO-MNP-PRIMARY-VARIANT-FIELD}
    Element Should Be Visible    ${ADD-VARIANT-BUTTON}
    Click Element    ${ADD-VARIANT-BUTTON}
    Bundle MNP Form Should Be Visible    1
    Click Element    ${ADD-VARIANT-BUTTON}
    Bundle MNP Form Should Be Visible    2
    Element Should Be Visible    ${CREATE-BUTTON}
    Element Should Be Visible    ${CANCEL-BUTTON}

TC_CAMPS_00544 Valid promotion, get % discount
    [Tags]    TC_CAMPS_00544    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=25
    #${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=100
    # @{bundle_list}    Create List    ${element1}    ${element2}
	@{bundle_list}    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00545 Valid promotion, get baht discount
    [Tags]    TC_CAMPS_00545    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Fixed    discAmount=5000
    # ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=200
    # @{bundle_list}    Create List    ${element1}    ${element2}
	@{bundle_list}    Create List    ${element1}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00546 Valid promotion, get % and baht discount
    [Tags]    TC_CAMPS_00546    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=70
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=250
    @{bundle_list}    Create List    ${element1}    ${element2}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00547 Valid promotion with bundle product more than 1 items
    [Tags]    TC_CAMPS_00547    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=50
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=100
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=49
    ${element4}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[2]    discType=Fixed    discAmount=400
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}    ${element4}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00548 Valid promotion with bundle product more than 1 items
    [Tags]    TC_CAMPS_00548    Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANTS}[0]    discType=Percent    discAmount=50
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=100
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=49
    ${element4}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[2]    discType=Fixed    discAmount=400
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}    ${element4}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00549 Empty promotion name
    [Tags]    TC_CAMPS_00549    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${EMPTY}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00550 Empty promotion name (translation)
    [Tags]    TC_CAMPS_00550    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${EMPTY}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00551 Empty promotion long description
    [Tags]    TC_CAMPS_00551    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${EMPTY}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00552 Empty promotion long description (translation)
    [Tags]    TC_CAMPS_00552    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00553 Empty promotion short description
    [Tags]    TC_CAMPS_00553    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00554 Empty promotion short description (translation)
    [Tags]    TC_CAMPS_00554    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00555 Default value for promotion status
    [Tags]    TC_CAMPS_00555    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    default    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    DISABLED
    # Check on Edit page again
    Edit Latest Promotion
    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}

TC_CAMPS_00556 Default value for member privilege
    [Tags]    TC_CAMPS_00556    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    default    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    # Check on Edit page again
    Edit Latest Promotion
    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}

TC_CAMPS_00557 Default value for promotion period
    [Tags]    TC_CAMPS_00557    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
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

TC_CAMPS_00558 Empty promotion period
    [Tags]    TC_CAMPS_00558    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    none    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00559 Empty bundle note
    [Tags]    TC_CAMPS_00559    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${EMPTY}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00560 Empty bundle note (translation)
    [Tags]    TC_CAMPS_00560    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    Go To Campaign for iTruemart Home Page
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${EMPTY}    @{bundle_list}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE

TC_CAMPS_00561 Empty buy primary variant
    [Tags]    TC_CAMPS_00561    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=${EMPTY}    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[1]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00562 Empty buy bundle variant
    [Tags]    TC_CAMPS_00562    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=${EMPTY}    discType=Percent    discAmount=${percentDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00563 Invalid value percent discount (Empty, Out of boundary number, Number with comma, String)
    [Tags]    TC_CAMPS_00563    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${EMPTY}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Percent    discAmount=${percentDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Bundle VARIANT and Discount Detail    2    @{VALID-PRIMARY-VARIANT}[0]    Percent    50
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Percent    101
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-PERCENT-BUNDLE-BOUNDARY-MSG}
    Input Bundle VARIANT and Discount Detail    2    @{VALID-PRIMARY-VARIANT}[0]    Percent    -1
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Percent    70
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-PERCENT-BUNDLE-BOUNDARY-MSG}
    Input Bundle VARIANT and Discount Detail    2    @{VALID-PRIMARY-VARIANT}[0]    Percent    25
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Percent    2,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Input Bundle VARIANT and Discount Detail    2    @{VALID-PRIMARY-VARIANT}[0]    Percent    abc
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Percent    75
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Page Should Contain    ${VALIDATE-PERCENT-BUNDLE-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00564 Invalid value baht discount (Empty, Out of boundary number, Number with comma, String)
    [Tags]    TC_CAMPS_00564    Full Regression
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Fixed    discAmount=${bahtDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=${EMPTY}
    ${element3}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=${bahtDiscount}
    @{bundle_list}    Create List    ${element1}    ${element2}    ${element3}
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Bundle VARIANT and Discount Detail    2    @{VALID-PRIMARY-VARIANT}[0]    Fixed    -1
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Fixed    29
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-BAHT-BUNDLE-BOUNDARY-MSG}
    Input Bundle VARIANT and Discount Detail    2    @{VALID-PRIMARY-VARIANT}[0]    Fixed    2500
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Fixed    2,000
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Input Bundle VARIANT and Discount Detail    2    @{VALID-PRIMARY-VARIANT}[0]    Fixed    abc
    Input Bundle VARIANT and Discount Detail    3    @{VALID-BUNDLE-VARIANT}[0]    Fixed    500
    Click Button    ${CREATE-BUTTON}
    # Promotion will not be created and found error
    #Header Should Contain    Campaign ${SUITE NAME} (ID: ${g_camp_id})
    Page Should Contain    ${VALIDATE-FLOAT-TYPE-MSG}
    Page Should Contain    ${VALIDATE-BAHT-BUNDLE-BOUNDARY-MSG}
    Go To Promotion List under Campaign    ${g_camp_id}
    ${promo_idAfter}=    Get Promotion ID under Campaign    ${g_camp_id}
    Should Be Equal    ${promo_idBefore}    ${promo_idAfter}

TC_CAMPS_00565 Able to add and delete variant bundle with invalid value before create promotion
    [Tags]    TC_CAMPS_00565    Bug Fix
    ${promo_idBefore}=    Get Promotion ID under Campaign    ${g_camp_id}
    ${element1}=    Create Dictionary    bundleVARIANT=@{VALID-PRIMARY-VARIANT}[0]    discType=Fixed    discAmount=${bahtDiscount}
    ${element2}=    Create Dictionary    bundleVARIANT=@{VALID-BUNDLE-VARIANT}[0]    discType=Fixed    discAmount=${EMPTY}
    @{bundle_list}    Create List    ${element1}    ${element2}
    Create Promotion MNP    ${TEST_NAME}    ${TEST_NAME}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${VALID-BUNDLE-NOTE}    ${VALID-BUNDLE-NOTE}    @{bundle_list}
    Repeat Keyword    2    Click Element    ${ADD-VARIANT-BUTTON}
    #Input Bundle VARIANT and Discount Detail    1    @{VALID-PRIMARY-VARIANT}[0]    Fixed    100
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
