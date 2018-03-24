*** Settings ***
Force Tags    WLS_CAMP_Template
Test Setup        Open Camps Browser
Test Teardown     Delete If Created Flash Sale and Close All Browsers    ${g_flash_sale_id}
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_00890 Verify promotion Wow Extra form
    [TAGS]    TC_CAMPS_00890    ready    Regression    Sanity
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    ${template_name}=    Get Text From Table    createFlashSaleTable    1    2
    Should Be Equal    ${template_name}    WOW Extra
    Go To Create Wow Extra Page
    Wait Until Element Is Visible    ${FS-APP-ID-SELECT}    ${g_loading_delay_short}
    : FOR    ${index}    IN    iTruemart    Exclusive Privilege    TruemoveH
    \    Select From List    ${FS-APP-ID-SELECT}    ${index}
    Wait Until Element Is Visible    ${FS-NAME-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-NAME-TRANS1-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-Short-DESC-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-Short-DESC-TRANS1-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${ENABLE-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${MEMBER-CHKBOX-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${NONMEMBER-CHKBOX-SPAN}    ${g_loading_delay_short}
	Wait Until Element Is Visible    ${FS-WE-PARTNER-SELECT}    ${g_loading_delay_short}
	: FOR    ${index}    IN    None (itruemart)    Line    Truemove H    True You
    \    Select From List    ${FS-WE-PARTNER-SELECT}    ${index}
    # Wait Until Element Is Visible    ${FS-WB-LIMIT-TO-BUY}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-LIMIT-TO-BUY-UNLIMITED-RADIO-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-LIMIT-TO-BUY-PREDEFINED-RADIO-SPAN}    ${g_loading_delay_short}
    Click Element    ${FS-LIMIT-TO-BUY-PREDEFINED-RADIO-SPAN}
    Wait Until Element Is Visible    ${FS-LIMIT-TO-BUY-PREDEFINED-SELECT}    ${g_loading_delay_short}
    : FOR    ${index}    IN RANGE    1    11
    \    ${index}=    Convert To String    ${index}
    \    Select From List    ${FS-LIMIT-TO-BUY-PREDEFINED-SELECT}    ${index}
    Wait Until Element Is Visible    ${FS-LIMIT-TO-BUY-CUSTOM-RADIO-SPAN}    ${g_loading_delay_short}
    Click Element    ${FS-LIMIT-TO-BUY-CUSTOM-RADIO-SPAN}
    Wait Until Element Is Visible    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-WB-WALLET-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-WB-ONLINE_BANKING-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-WB-INSTALLMENT-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-WB-CCW-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-WB-COUNTER_SERVICE-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-WB-COD-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${PERIOD-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${FS-WB-VARIANT-ADD-BUTTON}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${VARIANT-SELECTOR-OPEN-BUTTON}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CREATE-BUTTON}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CANCEL-BUTTON}    ${g_loading_delay_short}
    Wait Until Element Contains    ${TEMPLATE-NAME-CAPTION}    ${template_name}    ${g_loading_delay_short}

TC_CAMPS_00953 Valid promotion, single variant of single product
    [TAGS]    TC_CAMPS_00953    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00955 Empty promotion name
    [TAGS]    TC_CAMPS_00955    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Extra Data and Submit    &{VALID-APP-ID}[1]    ${EMPTY}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    @{VALID-FLASH-SALE-PARTNER}[0]
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00956 Empty promotion name (translation)
    [TAGS]    TC_CAMPS_00956    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00957 Empty promotion short description
    [TAGS]    TC_CAMPS_00957    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Extra Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    @{VALID-FLASH-SALE-PARTNER}[0]
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00958 Empty promotion short description (translation)
    [TAGS]    TC_CAMPS_00958    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00959 Default value for promotion status
    [TAGS]    TC_CAMPS_00959    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    default    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}
    Flash Sale Live Status Should Be Equal    DISABLED
    # Check on Edit page again
    Edit Latest Flash Sale
    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}

TC_CAMPS_00960 Default value for member privilege
    [TAGS]    TC_CAMPS_00960    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    default
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}
    Flash Sale Live Status Should Be Equal    LIVE
    # Check on Edit page again
    Edit Latest Flash Sale
    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}

TC_CAMPS_00961 Default value for promotion period
    [TAGS]    TC_CAMPS_00961    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}
    Flash Sale Live Status Should Be Equal    LIVE
    # Check on Edit page again
    Edit Latest Flash Sale
    ${today} =    Get Current Date
    ${tomorrow} =    Add Time To Date    ${today}    1 day
    ${today}=    Convert Date    ${today}    datetime
    ${tomorrow} =    Convert Date    ${tomorrow}    datetime
    Textfield Should Contain    ${PERIOD-FIELD}    @{MONTHS}[${today.month}] ${today.day}, ${today.year} 00:00 - @{MONTHS}[${tomorrow.month}] ${tomorrow.day}, ${tomorrow.year} 00:00

TC_CAMPS_00962 Empty promotion period
    [TAGS]    TC_CAMPS_00962    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Extra Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    none    0    00    ${EMPTY}    0    00
    ...    enable    both    @{VALID-FLASH-SALE-PARTNER}[0]
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00963 Empty varaint
    [TAGS]    TC_CAMPS_00963    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Extra Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    @{VALID-FLASH-SALE-PARTNER}[0]    ${true}    ${EMPTY}
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-SELECTED-VARIANT-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00964 Default Limit to Buy
    [TAGS]    TC_CAMPS_00964    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Extra Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    none    none    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    @{VALID-FLASH-SALE-PARTNER}[0]
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00966 Invalid value Limit to Buy number (Empty, Out of boundary number, Number with comma, String)
    [TAGS]    TC_CAMPS_00966    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Extra Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${EMPTY}    CUSTOM    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    @{VALID-FLASH-SALE-PARTNER}[0]
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Input Text    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    -1
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-LIMIT-TO-BUY-BOUNDARY-MSG}
    Input Text    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    0
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-LIMIT-TO-BUY-BOUNDARY-MSG}
    Input Text    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    1
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-LIMIT-TO-BUY-BOUNDARY-MSG}
    Input Text    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    10
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-LIMIT-TO-BUY-BOUNDARY-MSG}
    Input Text    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    abc
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-NUMBER-TYPE-MSG}
    Page Should Contain    ${VALIDATE-LIMIT-TO-BUY-BOUNDARY-MSG}

    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00918 Valid promotion, single payment channel
    [TAGS]    TC_CAMPS_00918    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00919 Valid promotion, multiple payment channel
    [TAGS]    TC_CAMPS_00919    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00922 Valid promotion, promotion price is equal to discounted price
    [TAGS]    TC_CAMPS_00922    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1645
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00923 Valid promotion, promotion price is less than discounted price
    [TAGS]    TC_CAMPS_00923    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1000
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00974 Wow Extra promotion will be created and error message will not be displayed when creating Wow Extra promotion within the same period with existing Wow Extra promotions
    [TAGS]    TC_CAMPS_00974    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1000    ${true}
    ${extra_id_1}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${extra_id_1}
    Flash Sale Name Should Be Equal    ${tc_number}
    # Create Wow Extra again with same period
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1000    ${true}
    ${extra_id_2}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${g_flash_sale_id},${extra_id_2}
    Should Not Be Equal    ${extra_id_1}    ${extra_id_2}
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00975 Wow Extra promotion will be created and error message will not be displayed when creating Wow Extra promotion within the same period with existing Wow Banner promotionsons
    [TAGS]    TC_CAMPS_00975    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1500    1    ${true}
    ${banner_id}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${banner_id}
    Flash Sale Name Should Be Equal    ${tc_number}
    # Create Wow Extra again with same period
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1000    ${true}
    ${extra_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${g_flash_sale_id},${extra_id}
    Should Not Be Equal    ${banner_id}    ${extra_id}
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00976 Wow Extra promotion will be updated and error message will not be displayed when creating Wow Extra promotion within the same period with existing Wow Extra promotions
    [TAGS]    TC_CAMPS_00976    ready    Regression
	${tc_number}=     Get Test Case Number
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_two_day}=    Get Next Date from Today    2
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${today}    0    00    ${tomorrow}    0    00
    ...    enable    nonmember
    ${extra_id_1}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${extra_id_1}
    Flash Sale Name Should Be Equal    ${tc_number}
    # Create Wow Extra again with same period
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${tomorrow}    0    00    ${next_two_day}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1000    ${true}
    ${extra_id_2}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${g_flash_sale_id},${extra_id_2}
    Should Not Be Equal    ${extra_id_1}    ${extra_id_2}
    Flash Sale Name Should Be Equal    ${tc_number}

    Edit Latest Flash Sale
    Input Date Time Information    ${today}    ${tomorrow}
    Submit To Create or Update Flash Sale
    Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table

    # Submit To Create or Update Flash Sale then Go To Flash Sale List Page

TC_CAMPS_00977 Wow Extra promotion will be updated and error message will not be displayed when creating Wow Extra promotion within the same period with existing Wow Banner promotions
    [TAGS]    TC_CAMPS_00977    ready    Regression
	${tc_number}=     Get Test Case Number
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_two_day}=    Get Next Date from Today    2
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${today}    0    00    ${tomorrow}    0    00
    ...    enable    nonmember
    ${extra_id_1}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${extra_id_1}
    Flash Sale Name Should Be Equal    ${tc_number}
    # Create Wow Extra again with same period
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    @{VALID-FLASH-SALE-VARIANT}[3]    1000    ${true}
    ${extra_id_2}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${g_flash_sale_id},${extra_id_2}
    Should Not Be Equal    ${extra_id_1}    ${extra_id_2}
    Flash Sale Name Should Be Equal    ${tc_number}

    Edit Latest Flash Sale
    Input Date Time Information    ${today}    ${tomorrow}
    Submit To Create or Update Flash Sale
    Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table

    # Submit To Create or Update Flash Sale then Go To Flash Sale List Page

TC_CAMPS_00985 When Creating Wow Extra, Payment channel Credit Card will be auto-selected if APP ID is selected to iTruemart and unable to unselect
    [TAGS]    TC_CAMPS_00985    ready    Regression
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    Go To Create Wow Extra Page
    Verify Default Payment Channel    iTruemart

TC_CAMPS_00986 When Creating Wow Extra Any payment channel will be not auto-selected if APP ID is selected to other except iTruemart
    [TAGS]    TC_CAMPS_00986    ready    Regression
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    Go To Create Wow Extra Page
    Select Flash Sale App ID    Exclusive Privilege
    Verify Default Payment Channel    Exclusive Privilege

TC_CAMPS_00987 When Creating Wow Extra, Payment channel Credit Card will be auto-cleared if APP ID is changed from iTruemart to other payment
    [TAGS]    TC_CAMPS_00987    ready    Regression
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    Go To Create Wow Extra Page
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]
    Select Flash Sale App ID    &{VALID-APP-ID}[6]
    Verify Default Payment Channel    &{VALID-APP-ID}[6]
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]
    Select Flash Sale App ID    &{VALID-APP-ID}[9]
    Verify Default Payment Channel    &{VALID-APP-ID}[9]

TC_CAMPS_00988 When Updating Wow Extra, Payment channel Credit Card will be auto-selected if APP ID is selected to iTruemart and unable to unselect
    [TAGS]    TC_CAMPS_00988    ready
  	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
  	# .. Create Wow Extra for current time
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
      ${g_flash_sale_id}=    Get Flash Sale ID
  	# .. Edit Wow Extra
  	Edit Latest Flash Sale
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]

TC_CAMPS_00989 When Updating Wow Extra Any payment channel will be not auto-selected if APP ID is selected to other except iTruemart
    [TAGS]    TC_CAMPS_00989    ready
    ${tc_number}=     Get Test Case Number
      Go To Campaign for iTruemart Home Page
  	# .. Create Wow Extra for current time
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
  	# .. Edit Wow Extra
  	Edit Latest Flash Sale
    Select Flash Sale App ID    &{VALID-APP-ID}[6]
    Verify Default Payment Channel    &{VALID-APP-ID}[6]
    Select Flash Sale App ID    &{VALID-APP-ID}[9]
    Verify Default Payment Channel    &{VALID-APP-ID}[9]

TC_CAMPS_00990 When Updating Wow Extra, Payment channel Credit Card will be auto-cleared if APP ID is changed from iTruemart to other payment
    [TAGS]    TC_CAMPS_00990    ready
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
  	# .. Create Wow Extra for current time
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
  	# .. Edit Wow Extra
  	Edit Latest Flash Sale
    Select Flash Sale App ID    &{VALID-APP-ID}[6]
    Verify Default Payment Channel    &{VALID-APP-ID}[6]
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]
    Select Flash Sale App ID    &{VALID-APP-ID}[9]
    Verify Default Payment Channel    &{VALID-APP-ID}[9]

TC_CAMPS_00917 Checkbox for variants of other products should be enabled, when selecting a variant in a product for Wow Banner
    [TAGS]    TC_CAMPS_00917    ready    Regression
    Open Variant Selector Modal for Flash Sale    Wow Extra
    Input Text    ${VARIANT-SELECTOR-PRODUCT-NAME}    เคส ipad
    Click Button    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Variant Selector Table
    Click Element    //*[@id='variantCheckboxSpan1-1']
    ${variant_id_1}=    Get Text    //*[@id='variantId1-1']
    Element Should Be Enabled   //*[@id='variantCheckbox1-2']
    ${variant_id_2}=    Get Text    //*[@id='variantId2-1']
    Element Should Be Enabled   //*[@id='variantCheckbox2-1']
    Click Element    //*[@id='variantCheckboxSpan2-1']
    Click Button    ${OK-BUTTON}
    ${id_actual_1}=    Get Text    //*[@id='variantId1-1']
    Should Be Equal    ${variant_id_1}    ${id_actual_1}
    ${id_actual_2}=    Get Text    //*[@id='variantId2-1']
    Should Be Equal    ${variant_id_2}    ${id_actual_2}

TC_CAMPS_01041 Valid promotion, limit to buy is unlimited
    [TAGS]    TC_CAMPS_01041    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    0    UNLIMITED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_01042 Valid promotion, limit to buy is predefined (1-10)
    [TAGS]    TC_CAMPS_01042    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    1    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}
    :FOR    ${limit}    In Range    2    11
    \    ${limit}=    Convert To String    ${limit}
    \    Edit Latest Flash Sale
    \    Select Flash Sale Predefined Limit to Buy    ${limit}
    \    Submit To Create or Update Flash Sale
    \    Wait Until Page Contains Flash Sale List Table
    \    Flash Sale Name Should Be Equal    ${tc_number}
    \    Edit Latest Flash Sale
    \    List Selection Should Be    ${FS-LIMIT-TO-BUY-PREDEFINED-SELECT}    ${limit}
    \    Cancel to Create and Return to Flash Sale List Page

TC_CAMPS_01043 Valid promotion, limit to buy is custom
    [TAGS]    TC_CAMPS_01043    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    12    CUSTOM    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_01044 No upload image for Limit to Buy when select to Custom
    [TAGS]    TC_CAMPS_01044    ready    Regression
	  ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
	  Input All Wow Extra Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    12    CUSTOM-NO-IMAGE    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-IMAGE-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_01046 Variant management section cannot be edited when Wow Extra is LIVE
    [TAGS]    TC_CAMPS_01046    ready    Regression
	  ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
	# .. Create Wow Extra for current time
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Edit Wow Extra
    Edit Latest Flash Sale
    Variant Management Section Should Be Disabled

TC_CAMPS_01047 Variant management section can be edited when Wow Extra is not LIVE
    [TAGS]    TC_CAMPS_01047    ready    Regression
	  ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
	# .. Create Wow Extra for current time
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Edit Wow Extra
    Edit Latest Flash Sale
    Wow Extra Variant Management Section Should Be Enabled

TC_CAMPS_01049 Variant management section for Wow Extra should be enabled if duplicate a flash sale promotion during LIVE, ENABLED but not LIVE, DISABLED, EXPIRED
    [TAGS]    TC_CAMPS_01049    Bug fix
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    # .. Create Wow Extra for current time
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    1    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Duplicate above Wow Extra
    Duplicate Latest Flash Sale
    Wow Extra Variant Management Section Should Be Enabled
