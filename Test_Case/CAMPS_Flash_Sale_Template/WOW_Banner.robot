*** Settings ***
Force Tags    WLS_CAMP_Template
Test Setup        Open Camps Browser
Test Teardown     Delete If Created Flash Sale and Close All Browsers    ${g_flash_sale_id}
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_00890 Verify promotion Wow Banner form
    [TAGS]    TC_CAMPS_00890    ready    Regression    Sanity
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    ${template_name}=    Get Text From Table    createFlashSaleTable    1    1
    Should Be Equal    ${template_name}    WOW Banner
    Go To Create Wow Banner Page
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

TC_CAMPS_00891 Valid promotion, single variant
    [TAGS]    TC_CAMPS_00891    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00892 Empty promotion name
    [TAGS]    TC_CAMPS_00892    ready    Full Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
	Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${EMPTY}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00893 Empty promotion name (translation)
    [TAGS]    TC_CAMPS_00893    ready    Full Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00896 Empty promotion short description
    [TAGS]    TC_CAMPS_00896    ready    Full Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
	Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00897 Empty promotion short description (translation)
    [TAGS]    TC_CAMPS_00897    ready    Full Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00898 Default value for promotion status
    [TAGS]    TC_CAMPS_00898    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    default    both
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}
    Flash Sale Live Status Should Be Equal    DISABLED
    # Check on Edit page again
    Edit Latest Flash Sale
    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}

TC_CAMPS_00899 Default value for member privilege
    [TAGS]    TC_CAMPS_00899    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    default
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}
    Flash Sale Live Status Should Be Equal    LIVE
    # Check on Edit page again
    Edit Latest Flash Sale
    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}

TC_CAMPS_00900 Default value for promotion period
    [TAGS]    TC_CAMPS_00900    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${EMPTY}
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

TC_CAMPS_00901 Empty promotion period
    [TAGS]    TC_CAMPS_00901    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    none    0    00    ${EMPTY}    0    00
    ...    enable    both
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00902 Empty Tomorrow Banner Web
    [TAGS]    TC_CAMPS_00902    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    # Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00903 Empty Tomorrow Banner Translation
    [TAGS]    TC_CAMPS_00903    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    # Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale then Go To Flash Sale List Page
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00904 Empty Tomorrow Banner Mobile
    [TAGS]    TC_CAMPS_00904    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    # Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00905 Empty Tomorrow Banner Mobile Translation
    [TAGS]    TC_CAMPS_00905    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    # Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale then Go To Flash Sale List Page
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00906 Empty Today Banner Web
    [TAGS]    TC_CAMPS_00906    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    # Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}
TC_CAMPS_00907 Empty Today Banner Translation
    [TAGS]    TC_CAMPS_00907    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    # Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale then Go To Flash Sale List Page
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00908 Empty Today Banner Mobile
    [TAGS]    TC_CAMPS_00908    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    # Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}
TC_CAMPS_00909 Empty Today Banner Mobile Translation
    [TAGS]    TC_CAMPS_00903    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    # Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale then Go To Flash Sale List Page
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00910 Empty Incoming Banner Web
    [TAGS]    TC_CAMPS_00904    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    # Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}
TC_CAMPS_00911 Empty Incoming Banner Translation
    [TAGS]    TC_CAMPS_00903    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    # Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale then Go To Flash Sale List Page
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00912 Empty Incoming Banner Mobile
    [TAGS]    TC_CAMPS_00904    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    # Upload Image to Wow Banner Image Incoming Mobile
    Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}
TC_CAMPS_00913 Empty Incoming Banner Mobile Translation
    [TAGS]    TC_CAMPS_00903    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${false}
    Upload Image to Wow Banner Image Today Desktop
    Upload Image to Wow Banner Image Today Desktop Translation
    Upload Image to Wow Banner Image Today Mobile
    Upload Image to Wow Banner Image Today Mobile Translation
    Upload Image to Wow Banner Image Tomorrow Desktop
    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    Upload Image to Wow Banner Image Tomorrow Mobile
    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    Upload Image to Wow Banner Image Incoming Desktop
    Upload Image to Wow Banner Image Incoming Desktop Translation
    Upload Image to Wow Banner Image Incoming Mobile
    # Upload Image to Wow Banner Image Incoming Mobile Translation
    Submit To Create or Update Flash Sale then Go To Flash Sale List Page
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00914 Empty varaint
    [TAGS]    TC_CAMPS_00914    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    ${true}    ${EMPTY}
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-SELECTED-VARIANT-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00915 Default Limit to Buy
    [TAGS]    TC_CAMPS_00915    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    none    none    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_00916 Invalid value Limit to Buy number (Empty, Out of boundary number, Number with comma, String)
    [TAGS]    TC_CAMPS_00916    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    ${EMPTY}    CUSTOM    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    ${true}    ${EMPTY}
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

# TC_CAMPS_00917 Invalid value Limit to Buy number (Empty, Out of boundary number, Number with comma, String) -- Inactive

TC_CAMPS_00918 Valid promotion, single payment channel
    [TAGS]    TC_CAMPS_00918    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00919 Valid promotion, multiple payment channel
    [TAGS]    TC_CAMPS_00919    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00922 Valid promotion, promotion price is equal to discounted price
    [TAGS]    TC_CAMPS_00922    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    ${true}    @{VALID-FLASH-SALE-VARIANT}[0]    1645
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00923 Valid promotion, promotion price is less than discounted price
    [TAGS]    TC_CAMPS_00923    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    ${true}    @{VALID-FLASH-SALE-VARIANT}[0]    1000
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00924 Promotion price cannot be equal to discounted price that is equal to normal price
    [TAGS]    TC_CAMPS_00924    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    ${true}    ${EQUAL-PRICE-FLASH-SALE-VARIANT}    1490
	Found Error At Promotion Price Text Field

TC_CAMPS_00926 Valid promotion, quota is equal to available stock
    [TAGS]    TC_CAMPS_00926    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    ${true}    @{VALID-FLASH-SALE-VARIANT}[2]    1000    2
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00927 Valid promotion, quota is less than available stock
    [TAGS]    TC_CAMPS_00927    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[2],@{VALID-FLASH-SALE-PAYMENT}[4]    default    0    00    ${EMPTY}    0    00
    ...    disable    member    ${true}    @{VALID-FLASH-SALE-VARIANT}[2]    1000    1
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_00931 Wow Banner promotion will be created and error message will not be displayed when creating Wow Banner promotion within the same period with existing Wow Extra promotions
    [TAGS]    TC_CAMPS_00931    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
	# .. Create Wow Extra for current time
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}-EXTRA    ${tc_number}-EXTRA    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${extra_id}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${extra_id}
    Flash Sale Name Should Be Equal    ${tc_number}-EXTRA
	# .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}-BANNER    ${tc_number}-BANNER    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member    ${true}    @{VALID-FLASH-SALE-VARIANT}[0]    1500    1    ${true}
    ${banner_id}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${g_flash_sale_id},${banner_id}
	Flash Sale Name Should Be Equal    ${tc_number}-BANNER

TC_CAMPS_00932 Wow Banner promotion will be not created and warning message will be displayed when duplicating Wow Banner promotion within the same period with existing Wow Banner promotion
    [TAGS]    TC_CAMPS_00932    ready    Regression
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
	# .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
	# .. Duplicate above Wow Banner
	Duplicate Latest Flash Sale
	Submit To Create or Update Flash Sale
    Confirm To Create or Update Flash Sale With Duplicated Product
    # .. Expect Error Alert
    Accept Error To Create Wow Banner With Duplicated Period

TC_CAMPS_00935 Wow Banner promotion will be created and error message will not be displayed when updating Wow Banner promotion within the same period with existing Wow Extra promotions
    [TAGS]    TC_CAMPS_00935    ready    Regression
	${start_date}=    Get Today Date
    ${end_date}=    Get Next Date from Today
	${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
	# .. Create Wow Extra
    Create Flash Sale Wow Extra    &{VALID-APP-ID}[6]    ${tc_number}-EXTRA    ${tc_number}-EXTRA    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${start_date}    10    00    ${end_date}    11    00
    ...    enable    member
    ${extra_id}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${extra_id}
    Flash Sale Name Should Be Equal    ${tc_number}-EXTRA
	# .. Create Wow Banner
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}-BANNER    ${tc_number}-BANNER    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    ${start_date}    12    00    ${end_date}    13    00
    ...    enable    member    ${true}    @{VALID-FLASH-SALE-VARIANT}[0]    1500    1    ${true}
    ${banner_id}=    Get Flash Sale ID
	${g_flash_sale_id}=    Set Variable    ${g_flash_sale_id},${banner_id}
	Flash Sale Name Should Be Equal    ${tc_number}-BANNER
	# .. Edit Wow Banner
	Edit Latest Flash Sale
    Edit Flash Sale Wow Banner    &{VALID-APP-ID}[9]    EDIT:${tc_number}-BANNER    EDIT:${tc_number}-BANNER    EDIT:${VALID-SHORT-PROMO-DESC}    EDIT:${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0],@{VALID-FLASH-SALE-PAYMENT}[2]    ${start_date}    8    00    ${end_date}    16    00
    ...    enable    member
    Submit To Create or Update Flash Sale then Go To Flash Sale List Page

TC_CAMPS_00936 Variant management section cannot be edited when Wow Banner is LIVE
    [TAGS]    TC_CAMPS_00936    ready    Regression
	  ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
	# .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Edit Wow Banner
    Edit Latest Flash Sale
    Variant Management Section Should Be Disabled

TC_CAMPS_00979 When Creating Wow Banner, Payment channel Credit Card will be auto-selected if APP ID is selected to iTruemart and unable to unselect
    [TAGS]    TC_CAMPS_00979    ready    Regression
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    Go To Create Wow Banner Page
    Verify Default Payment Channel    iTruemart

TC_CAMPS_00980 When Creating Wow Banner, Any payment channel will be not auto-selected if APP ID is selected to other except iTruemart
    [TAGS]    TC_CAMPS_00980    ready    Regression
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    Go To Create Wow Banner Page
    Select Flash Sale App ID    Exclusive Privilege
    Verify Default Payment Channel    Exclusive Privilege

TC_CAMPS_00981 When Creating Wow Banner, Payment channel Credit Card will be auto-cleared if APP ID is changed from iTruemart to other payment
    [TAGS]    TC_CAMPS_00981    ready    Full Regression
    Go To Campaign for iTruemart Home Page
    Go To Create Flash Sale Page
    Go To Create Wow Banner Page
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]
    Select Flash Sale App ID    &{VALID-APP-ID}[6]
    Verify Default Payment Channel    &{VALID-APP-ID}[6]
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]
    Select Flash Sale App ID    &{VALID-APP-ID}[9]
    Verify Default Payment Channel    &{VALID-APP-ID}[9]

TC_CAMPS_00982 When Updating Wow Banner, Payment channel Credit Card will be auto-selected if APP ID is selected to iTruemart and unable to unselect
    [TAGS]    TC_CAMPS_00982    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    # .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Edit Wow Banner
    Edit Latest Flash Sale
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]

TC_CAMPS_00983 When Updating Wow Banner, Any payment channel will be not auto-selected if APP ID is selected to other except iTruemart
    [TAGS]    TC_CAMPS_00983    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    # .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Edit Wow Banner
    Edit Latest Flash Sale
    Select Flash Sale App ID    &{VALID-APP-ID}[6]
    Verify Default Payment Channel    &{VALID-APP-ID}[6]
    Select Flash Sale App ID    &{VALID-APP-ID}[9]
    Verify Default Payment Channel    &{VALID-APP-ID}[9]

TC_CAMPS_00984 When Updating Wow Banner, Payment channel Credit Card will be auto-cleared if APP ID is changed from iTruemart to other payment
    [TAGS]    TC_CAMPS_00984    ready    Full Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
  	# .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    enable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
  	# .. Edit Wow Banner
    Edit Latest Flash Sale
    Select Flash Sale App ID    &{VALID-APP-ID}[6]
    Verify Default Payment Channel    &{VALID-APP-ID}[6]
    Select Flash Sale App ID    &{VALID-APP-ID}[1]
    Verify Default Payment Channel    &{VALID-APP-ID}[1]
    Select Flash Sale App ID    &{VALID-APP-ID}[9]
    Verify Default Payment Channel    &{VALID-APP-ID}[9]

TC_CAMPS_00917 Checkbox for variants of other products should be disabled, when selecting a variant in a product for Wow Banner
    [TAGS]    TC_CAMPS_00917    ready    Regression
    Open Variant Selector Modal for Flash Sale    Wow Banner
    Input Text    ${VARIANT-SELECTOR-PRODUCT-NAME}    เคส ipad
    Click Button    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Variant Selector Table
    Click Element    //*[@id='variantCheckboxSpan1-1']
    ${variant_id}=    Get Text    //*[@id='variantId1-1']
    Element Should Be Enabled   //*[@id='variantCheckbox1-2']
    Element Should Be Disabled   //*[@id='variantCheckbox2-1']
    Click Button    ${OK-BUTTON}
    ${id_actual}=    Get Text    //*[@id='variantId1-1']
    Should Be Equal    ${variant_id}    ${id_actual}

TC_CAMPS_01037 Valid promotion, limit to buy is unlimited
    [TAGS]    TC_CAMPS_01037    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    UNLIMITED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_01038 Valid promotion, limit to buy is predefined (1-10)
    [TAGS]    TC_CAMPS_01038    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
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

TC_CAMPS_01039 Valid promotion, limit to buy is custom
    [TAGS]    TC_CAMPS_01039    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    12    CUSTOM    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember
    ${g_flash_sale_id}=    Get Flash Sale ID
    Flash Sale Name Should Be Equal    ${tc_number}

TC_CAMPS_01040 No upload image for Limit to Buy when select to Custom
    [TAGS]    TC_CAMPS_01040    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    ${flash_sale_id_before}=    Get Flash Sale ID
    Input All Wow Banner Data and Submit    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    12    CUSTOM-NO-IMAGE    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both
    # Promotion will not be created and found error
    Element Should Contain    ${TITLE-HEADER}    Flash Sale Template
    Page Should Contain    ${VALIDATE-EMPTY-IMAGE-MSG}
    Go To Flash Sale List Page
    ${flash_sale_id_after}=    Get Flash Sale ID
    Should Be Equal    ${flash_sale_id_after}    ${flash_sale_id_before}

TC_CAMPS_01045 Variant management section can be edited when Wow Banner is not LIVE
    [TAGS]    TC_CAMPS_01045    ready    Regression
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
	# .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Edit Wow Banner
    Edit Latest Flash Sale
    Wow Banner Variant Management Section Should Be Enabled

TC_CAMPS_01048 Variant management section for Wow Banner should be enabled if duplicate a flash sale promotion during LIVE, ENABLED but not LIVE, DISABLED, EXPIRED
    [TAGS]    TC_CAMPS_01048    Bug fix
    ${tc_number}=     Get Test Case Number
    Go To Campaign for iTruemart Home Page
    # .. Create Wow Banner for current time
    Create Flash Sale Wow Banner    &{VALID-APP-ID}[1]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    1    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[1]    default    0    00    ${EMPTY}    0    00
    ...    disable    member
    ${g_flash_sale_id}=    Get Flash Sale ID
    # .. Duplicate above Wow Banner
    Duplicate Latest Flash Sale
    Wow Banner Variant Management Section Should Be Enabled
