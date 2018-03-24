*** Settings ***
Force Tags    WLS_CAMP_Template
Test Setup        Open Camps Browser
Test Teardown     Delete If Created Flash Sale and Close All Browsers    ${g_flash_sale_id}
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_01077 Alert message will be displayed when creating Wow Banner with a same product and a variant that is duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01077    ready    Regression
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    ${pkey}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01078 Alert message will be displayed when creating Wow Banner with a same product but a different variant that is duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01078
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-2
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_2}    100

    ${pkey}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01079 Alert message will be displayed when creating Wow Banner with a same product and variants that are duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01079
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra A-1,2 & create banner A-1,2
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_2}    100

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01080 Alert message will be displayed when creating Wow Banner with a same product but different variants that are duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01080
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    3    4
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra A-1,2 & create banner A-3,4
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_2}    100

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01081 Alert message will be displayed when creating Wow Banner with a same product and a variant that is duplicated with the existing products Wow Extra
    [TAGS]    TC_CAMPS_01081
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{variants_2}=    Create List    1    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_1}=    Create List    ${product_1}    ${product_2}
    @{variants_3}=    Create List    1
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_3}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra A-1,2 & create banner A-3,4
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_2}    100

    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-2}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01082 Alert message will be displayed when creating Wow Banner with a same product but a different variant that is duplicated with the existing products Wow Extra
    [TAGS]    TC_CAMPS_01082
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{variants_2}=    Create List    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_1}=    Create List    ${product_1}    ${product_2}
    @{variants_3}=    Create List    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_3}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra A-1,2 & create banner A-3,4
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_2}    100

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01083 Alert message will be displayed when creating Wow Extra with a same product and a variant that is duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01083
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra 1 & create extra 1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01084 Alert message will be displayed when creating Wow Extra with a same product but a different variant that is duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01084
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table

    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra 1 & create extra 1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01085 Alert message will be displayed when creating Wow Extra with a same product and variants that are duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01085
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table

    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra 1 & create extra 1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01086 Alert message will be displayed when creating Wow Extra with a same product but different variants that are duplicated with the existing product Wow Extra
    [TAGS]    TC_CAMPS_01086
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    3    4
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table

    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra 1 & create extra 1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01087 Alert message will be displayed when creating Wow Extra with same products and some variants that are duplicated with the existing products Wow Extra
    [TAGS]    TC_CAMPS_01087
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{variants_2}=    Create List    1    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_1}=    Create List    ${product_1}    ${product_2}
    @{variants_3}=    Create List    1
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_3}
    @{variants_4}=    Create List    2
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_4}
    @{product_variant_2}=    Create List    ${product_3}    ${product_4}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table

    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra 1 & create extra 1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}    ${pkey-2}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01088 Alert message will be displayed when creating Wow Extra with same products but different variants that are duplicated with the existing products Wow Extra
    [TAGS]    TC_CAMPS_01088
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{variants_2}=    Create List    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_1}=    Create List    ${product_1}    ${product_2}
    @{variants_3}=    Create List    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_3}
    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_4}
    @{product_variant_2}=    Create List    ${product_3}    ${product_4}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table

    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra 1 & create extra 1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}    ${pkey-2}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01089 Alert message will be displayed when creating Wow Extra with same products and all variants that are duplicated with the existing products Wow Extra
    [TAGS]    TC_CAMPS_01089
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{variants_2}=    Create List    1    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_1}=    Create List    ${product_1}    ${product_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_3}
    @{variants_4}=    Create List    1    2
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_4}
    @{product_variant_2}=    Create List    ${product_3}    ${product_4}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table

    ${g_flash_sale_id}=    Get Flash Sale ID
    Go To Campaign for iTruemart Home Page
    #existing extra 1 & create extra 1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}    ${pkey-2}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01090 Alert message will be displayed when creating Wow Extra with a same product and a variant that is duplicated with the existing product Wow Banner
    [TAGS]    TC_CAMPS_01090
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01091 Alert message will be displayed when creating Wow Extra with a same product but a different variant that is duplicated with the existing product Wow Banner
    [TAGS]    TC_CAMPS_01091
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01092 Alert message will be displayed when creating Wow Extra with a same product and variants that are duplicated with the existing product Wow Banner
    [TAGS]    TC_CAMPS_01092
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01093 Alert message will be displayed when creating Wow Extra with a same product but different variants that are duplicated with the existing product Wow Banner
    [TAGS]    TC_CAMPS_01093
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    3    4
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_2}=    Create List    ${product_2}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01094 Alert message will be displayed when creating Wow Extra with some same products and a variant that is duplicated with the existing product Wow Banner
    [TAGS]    TC_CAMPS_01094
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01095 Alert message will be displayed when creating Wow Extra with some same products and a variant that is duplicated with the existing product Wow Banner
    [TAGS]    TC_CAMPS_01095
    @{variants_1}=    Create List    1    2
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    2
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    Should Not Be Equal    ${first_flash_sale_id}    ${second_flash_sale_id}

TC_CAMPS_01096 Alert message will be not displayed when creating Wow Extra without any variant of same product with the existing Flashsale (deselect product that is duplicated)
    [TAGS]    TC_CAMPS_01096
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
    @{variants_3}=    Create List    1
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_3}
    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-3}    variant    ${variants_4}
    @{product_variant_3}=    Create List    ${product_3}    ${product_4}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${first_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    ${delete_products}=    Create List    1
    Delete Product From Product Variant Table    ${delete_products}
    Submit To Create or Update Flash Sale
    Wait Until Page Contains Flash Sale List Table
    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

TC_CAMPS_01097 Alert message will be not displayed when creating Wow Banner without any variant of same product with the existing Flashsale
    [TAGS]    TC_CAMPS_01097
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
    @{variants_3}=    Create List    1
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_3}
    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-3}    variant    ${variants_4}
    @{product_variant_3}=    Create List    ${product_3}    ${product_4}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${first_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
    Cancel To Create or Update Flash Sale With Duplicated Product
    ${delete_products}=    Create List    1
    Delete Product From Product Variant Table    ${delete_products}
    Submit To Create or Update Flash Sale
    Wait Until Page Contains Flash Sale List Table
    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

TC_CAMPS_01098 Alert message will be not displayed when creating Wow Extra without any variant of same product with the existing Flashsale
    [TAGS]    TC_CAMPS_01098
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
    @{variants_3}=    Create List    1
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-3}    variant    ${variants_3}
    @{product_variant_3}=    Create List    ${product_3}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}
    Wait Until Page Contains Flash Sale List Table

    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

TC_CAMPS_01099 Alert message will be displayed when creating Wow Extra with one more products and variants with the existing Flashsales
    [TAGS]    TC_CAMPS_01099
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}

    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}

    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_4}
    @{variants_5}=    Create List    1    2
    ${product_5}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_5}
    @{product_variant_3}=    Create List    ${product_4}    ${product_5}

	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}

  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}    ${pkey-2}=${second_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table

    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

TC_CAMPS_01100 Alert message will be displayed when creating Wow Banner with one more products and variants with the existing Flashsales
    [TAGS]    TC_CAMPS_01100
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}

    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}

    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_4}
    @{product_variant_3}=    Create List    ${product_4}

	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_3}    100

  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table

    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

TC_CAMPS_01101 Alert message will be not displayed when updating Wow Extra without any variant of same product with the existing Flashsale
    [TAGS]    TC_CAMPS_01101
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${next_3_day}=    Get Next Date from Today    3
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}
    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_2}
    @{product_variant_2}=    Create List    ${product_2}
    @{variants_3}=    Create List    1
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-3}    variant    ${variants_3}
    @{product_variant_3}=    Create List    ${product_3}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${next_2_day}    0    00    ${next_3_day}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}
    Wait Until Page Contains Flash Sale List Table

    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

    Edit Latest Flash Sale
    Input Date Time Information    ${today}    ${tomorrow}
    Submit To Create or Update Flash Sale
    ${third_edit_flash_sale_id}=    Get Flash Sale ID
    Should Be Equal    ${third_flash_sale_id}    ${third_edit_flash_sale_id}

TC_CAMPS_01102 Alert message will be displayed when updating Wow Extra with one more products and variants with the existing Flashsales
    [TAGS]    TC_CAMPS_01102
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${next_3_day}=    Get Next Date from Today    3
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}

    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}

    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_4}
    @{variants_5}=    Create List    1    2
    ${product_5}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_5}
    @{product_variant_3}=    Create List    ${product_4}    ${product_5}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_1}    100
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    ${two_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}

    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${next_2_day}    0    00    ${next_3_day}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}
    Wait Until Page Contains Flash Sale List Table

    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

    Edit Latest Flash Sale
    Input Date Time Information    ${today}    ${tomorrow}
    Submit To Create or Update Flash Sale
    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${two_flash_sale_id}    ${pkey-2}=${second_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    update    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${third_edit_flash_sale_id}=    Get Flash Sale ID
    Should Be Equal    ${third_flash_sale_id}    ${third_edit_flash_sale_id}

TC_CAMPS_01103 Alert message will be displayed when updating Wow Banner with one more products and variants with the existing Flashsales
    [TAGS]    TC_CAMPS_01103
    ${today}=    Get Today Date
    ${tomorrow}=    Get Next Date from Today
    ${next_2_day}=    Get Next Date from Today    2
    ${next_3_day}=    Get Next Date from Today    3
    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}

    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}

    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_4}
    @{product_variant_3}=    Create List    ${product_4}
	  ${tc_number}=     Get Test Case Number

    Go To Campaign for iTruemart Home Page
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra A-1 & create banner A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    ${two_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}


    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${next_2_day}    0    00    ${next_3_day}    0    00
    ...    enable    both    ${true}    ${product_variant_3}    100

    ${third_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id},${third_flash_sale_id}
    Should Not Be Equal    ${second_flash_sale_id}    ${third_flash_sale_id}

    Edit Latest Flash Sale
    Input Date Time Information    ${today}    ${tomorrow}
    Submit To Create or Update Flash Sale
    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    ${pkey-2}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    pkey
  	&{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${two_flash_sale_id}
  	Verify Confirmation Page for Flash Sale With Duplicated Product    update    ${expected_dup_var_promo}
  	Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${third_edit_flash_sale_id}=    Get Flash Sale ID
    Should Be Equal    ${third_flash_sale_id}    ${third_edit_flash_sale_id}

TC_CAMPS_01104 Alert message will be displayed when creating Wow Banner with duplicate product with existing Flashsales (LIVE, ENABLED, DISABLED, EXPIRED)
    [TAGS]    TC_CAMPS_01104
    ${today}=    Get Today Date
    ${yesterday}=    Get Next Date from Today    -1
    ${tomorrow}=    Get Next Date from Today    1
    ${next_two_day}=    Get Next Date from Today    2

    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}

    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}

    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_4}
    @{product_variant_3}=    Create List    ${product_4}

    ${tc_number}=     Get Test Case Number
    ## LIVE
    Go To Campaign for iTruemart Home Page
    #existing extra A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra B-1, B-2
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    #create banner A-1
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_3}    100

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page
    ## ENABLED
    #edit existing flash sale period to be future
    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${first_flash_sale_id}
    Input Date Time Information    ${tomorrow}    ${next_two_day}
    Submit To Create or Update Flash Sale
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${second_flash_sale_id}
    Input Date Time Information    ${tomorrow}    ${next_two_day}
    Submit To Create or Update Flash Sale
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    #create banner A-1
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${tomorrow}    0    00    ${next_two_day}    0    00
    ...    enable    both    ${true}    ${product_variant_3}    100

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page

    ## DISABLED
    #edit existing flash sale period to be future
    # Wait Until Page Contains Flash Sale List Table
    # Edit Flash Sale By ID    ${first_flash_sale_id}
    # Input Date Time Information    ${tomorrow}    ${next_two_day}
    # Submit To Create or Update Flash Sale then Go To Flash Sale List Page

    # Wait Until Page Contains Flash Sale List Table
    # Edit Flash Sale By ID    ${second_flash_sale_id}
    # Input Date Time Information    ${tomorrow}    ${next_two_day}
    # Submit To Create or Update Flash Sale then Go To Flash Sale List Page

    #create banner A-1
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${tomorrow}    0    00    ${next_two_day}    0    00
    ...    disable    both    ${true}    ${product_variant_3}    100

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page

    ## EXPIRED
    #edit existing flash sale period to be future
    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${first_flash_sale_id}
    Input Date Time Information    ${yesterday}    ${today}
    Submit To Create or Update Flash Sale
    # Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${second_flash_sale_id}
    Input Date Time Information    ${yesterday}    ${today}
    Submit To Create or Update Flash Sale
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    #create banner A-1
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${yesterday}    0    00    ${today}    0    00
    ...    disable    both    ${true}    ${product_variant_3}    100

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page

TC_CAMPS_01105 Alert message will be displayed when creating Wow Extra with duplicate product with existing Falshsales (LIVE, ENABLED, DISABLED, EXPIRED)
    [TAGS]    TC_CAMPS_01105
    ${today}=    Get Today Date
    ${yesterday}=    Get Next Date from Today    -1
    ${tomorrow}=    Get Next Date from Today    1
    ${next_two_day}=    Get Next Date from Today    2

    @{variants_1}=    Create List    1
    ${product_1}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_1}
    @{product_variant_1}=    Create List    ${product_1}

    @{variants_2}=    Create List    1
    ${product_2}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_2}
    @{variants_3}=    Create List    1    2
    ${product_3}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-2}    variant    ${variants_3}
    @{product_variant_2}=    Create List    ${product_2}    ${product_3}

    @{variants_4}=    Create List    1
    ${product_4}=    Set To Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    variant    ${variants_4}
    @{product_variant_3}=    Create List    ${product_4}

    ${tc_number}=     Get Test Case Number
    ## LIVE
    Go To Campaign for iTruemart Home Page
    #existing extra A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_1}
    Wait Until Page Contains Flash Sale List Table
    ${g_flash_sale_id}=    Get Flash Sale ID

    Go To Campaign for iTruemart Home Page
    #existing extra B-1, B-2
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_2}

    ${pkey-1}=    Get From Dictionary    ${VALID-FLASH-SALE-PRODUCT-1}    pkey
    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table
    ${first_flash_sale_id}=    Set Variable    ${g_flash_sale_id}
    ${second_flash_sale_id}=    Get Flash Sale ID
    ${g_flash_sale_id}=    Set Variable    ${first_flash_sale_id},${second_flash_sale_id}
    #create new extra A-1
    Create Flash Sale Wow Banner with Variant Selector    &{VALID-APP-ID}[1]    ${tc_number}    ${EMPTY}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    both    ${true}    ${product_variant_3}    100

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page
    ## ENABLED
    #edit existing flash sale period to be future
    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${first_flash_sale_id}
    Input Date Time Information    ${tomorrow}    ${next_two_day}
    Submit To Create or Update Flash Sale
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${second_flash_sale_id}
    Input Date Time Information    ${tomorrow}    ${next_two_day}
    Submit To Create or Update Flash Sale
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    #create new extra A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    default    0    00    ${EMPTY}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page

    ## DISABLED
    #edit existing flash sale period to be future
    # Wait Until Page Contains Flash Sale List Table
    # Edit Flash Sale By ID    ${first_flash_sale_id}
    # Input Date Time Information    ${tomorrow}    ${next_two_day}
    # Submit To Create or Update Flash Sale then Go To Flash Sale List Page

    # Wait Until Page Contains Flash Sale List Table
    # Edit Flash Sale By ID    ${second_flash_sale_id}
    # Input Date Time Information    ${tomorrow}    ${next_two_day}
    # Submit To Create or Update Flash Sale then Go To Flash Sale List Page

    #create new extra A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${tomorrow}    0    00    ${next_two_day}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page

    ## EXPIRED
    #edit existing flash sale period to be future
    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${first_flash_sale_id}
    Input Date Time Information    ${yesterday}    ${today}
    Submit To Create or Update Flash Sale
    # Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    Wait Until Page Contains Flash Sale List Table
    Edit Flash Sale By ID    ${second_flash_sale_id}
    Input Date Time Information    ${yesterday}    ${today}
    Submit To Create or Update Flash Sale
    Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product

    #create new extra A-1
    Create Flash Sale Wow Extra with Variant Selector    &{VALID-APP-ID}[6]    ${tc_number}    ${tc_number}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    2    PREDEFINED    @{VALID-FLASH-SALE-PAYMENT}[0]    ${yesterday}    0    00    ${today}    0    00
    ...    enable    nonmember    @{VALID-FLASH-SALE-PARTNER}[2]    ${true}    ${product_variant_3}

    &{expected_dup_var_promo}=    Create Dictionary    ${pkey-1}=${g_flash_sale_id}
    Verify Confirmation Page for Flash Sale With Duplicated Product    create    ${expected_dup_var_promo}

    Cancel To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contain Product Variant Table is Visible
    Cancel to Create and Return to Flash Sale List Page
