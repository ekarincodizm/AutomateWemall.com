*** Settings ***
Force Tags    WLS_Promotion
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           Collections
Library           String
Library           BuiltIn
Resource          ${CURDIR}/../../../Resource/Init.robot
# Library           ${CURDIR}/../../../Python_Library/promotion_code.py
Library           ${CURDIR}/../../../Python_Library/promotion.py
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_export_campaign_price_and_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/Keywords_Promotion.robot

Suite Setup      Promotion - Create Campaign  ${campaign_name}   No
Suite Teardown   promotion.Remove Campaign   ${campaign_name}   1
Test Teardown    Close All Browsers

*** Variables ***
${allow_display_on_web_checkbox}        //*[@id="allow_display_on_web"]
${allow_display_on_thumbnail_checkbox}      //*[@id="allow_display_on_thumbnail"]

&{TC1}     name=Single-Unlimit-All_Cart-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=cart    #  cart / following
    ...    dc_on_follow_type=${EMPTY}    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=${EMPTY}
    ...    dc_on_exclude_value=0
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC2}     name=Single-Unlimit-Brand-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=brand     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=Apple
    ...    dc_on_exclude_value=2627037351371
    ...    budget=PC1
    ...    card=${EMPTY}

 &{TC6}     name=Unique-Collection-Percent-Privilege-card-max-price-limit
     ...    type=multiple_code    #  single_code / vip_code / multiple_code
     ...    usetime=10
     ...    userlimit=limited    #  limited / unlimited
     ...    time_per_user=1
     ...    minimum=0
     ...    dc_type=percent    #  price / percent
     ...    dc_value=10
     ...    dc_maximum=20
     ...    dc_cart=following    #  cart / following
     ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
     #...    dc_on_follow_value=AntmanCategory_ManageDisplay1
     ...    dc_on_follow_value=AntmanCategory_ManageDisplay
     ...    dc_on_exclude_value=0
     ...    budget=${EMPTY}
     ...    card=CreditCardTest

&{TC17}     name=VIP-limited-collection-percent
    ...    type=vip_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=30
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
    #...    dc_on_follow_value=AntmanCategory_ManageDisplay1
    ...    dc_on_follow_value=AntmanCategory_ManageDisplay
    ...    dc_on_exclude_value=0
    ...    budget=PC1
    ...    card=${EMPTY}

&{SingBrandBundle1}     name=Single-Unlimit-Brand-Price
        ...    type=single_code    #  single_code / vip_code / multiple_code
        ...    usetime=10
        ...    userlimit=limited    #  limited / unlimited
        ...    time_per_user=1
        ...    minimum=0
        ...    dc_type=price    #  price / percent
        ...    dc_value=10
        ...    dc_maximum=${EMPTY}
        ...    dc_cart=cart    #  cart / following
        ...    dc_on_follow_type=brand    # variant / product / brand / collection / bundle
        ...    dc_on_follow_value=Apple
        ...    dc_on_exclude_value=0
        ...    budget=PC1
        ...    card=${EMPTY}
        ...    promo_group=Bundle      # General / Bundle / MNP

&{SingPercBrandMNP}     name=Single-Unlimit-Brand-Price
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=brand     # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=Apple
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC05300}     name=TC05300
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=price    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=มือถือ และ แท็บเล็ต
    ...    dc_on_exclude_value=2261535516166
    ...    budget=PC1
    ...    card=${EMPTY}
    ...    promo_group=General      # General / Bundle / MNP

&{TC05303}     name=TC05303-2
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=มือถือ และ แท็บเล็ต
    ...    dc_on_exclude_value=2261535516166
    ...    budget=PC1
    ...    card=${EMPTY}
    ...    promo_group=General      # General / Bundle / MNP

&{TC05450}  name=TC05450
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=มือถือ และ แท็บเล็ต
    ...    dc_on_exclude_value=2261535516166
    ...    budget=PC1
    ...    card=${EMPTY}
    ...    promo_group=MNP

${campaign_name}    Antman Robot Manage Display Promotion Code

*** Keywords ***
Count promotions.allow_display
     [Arguments]         ${promotion_id}
     Connect DB ITM
     ${result}=     Query     SELECT `allow_display_on_web` , `allow_display_on_thubmnail` FROM `promotions` WHERE `promotion_id` = '${promotion_id}'
     [Return]       ${result[0]}

*** Test Cases ***
TC_iTM_05216 - Display Promo Group Dropdown
    [Tags]   TC_ITMWM_05216  iTM-A-Sprint 2016S16    ready   regression   ITMA-3279    WLS_Medium

    When Wait Until Page Contains Element    ${xpath-first-promotion-button}     60
    And Click Element    ${xpath-first-promotion-button}
    And Wait Until Element is ready and click    ${Create_Promotion}    10s
    Then Promotion Group is displayed
    And Default value is General
    And Values in dropdown are General, Bundle, MNP


TC_ITMWM_05299 Promotion containing single code & cart w/ condition will display 'manage display' button at Action column.
    [Tags]   TC_ITMWM_05299     iTM-A-Sprint 2016S16   ITMA-3284    ready    regression    WLS_High

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC2}
    Wait Until Element Is Visible      ${Back_Button_On_View_Promotion_Detail}      10s
    When Click Element       ${Back_Button_On_View_Promotion_Detail}
    Then Manage Display Button Is Displayed

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC2.name}
    ...           AND             Close All Browsers

TC_ITMWM_05378 Promotion containing single code&all cart will not display 'manage display' button at Action column.
    [Tags]   TC_ITMWM_05378     iTM-A-Sprint 2016S16   ITMA-3284    ready    regression    WLS_High

     Given Login Pcms
     And Go To Robot Campaign    ${campaign_name}
     #${promotion_code}=    Create Promotion    &{TC1}
     Promotion - Prepare Promotion Code To Test Variable    &{TC1}
     Wait Until Element Is Visible      ${Back_Button_On_View_Promotion_Detail}      10s
     When Click Element       ${Back_Button_On_View_Promotion_Detail}
     Then Manage Display Button Is Not Displayed

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC1.name}
    ...           AND             Close All Browsers

TC_ITMWM_05376 Promotion containing unique code will not display 'manage display' button at Action column.
    [Tags]   TC_ITMWM_05376   iTM-A-Sprint 2016S16   ITMA-3284      ready    regression    WLS_High

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC6}
    Wait Until Element Is Visible      ${Back_Button_On_View_Promotion_Detail}      10s
    When Click Element       ${Back_Button_On_View_Promotion_Detail}
    Then Manage Display Button Is Not Displayed

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC6.name}
    ...           AND             Close All Browsers

TC_ITMWM_05377 Promotion containing vip code will not display 'manage display' button at Action column.
    [Tags]   TC_ITMWM_05377  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_High

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC17}
    Wait Until Element Is Visible      ${Back_Button_On_View_Promotion_Detail}      10s
    When Click Element       ${Back_Button_On_View_Promotion_Detail}
    Then Manage Display Button Is Not Displayed

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC17.name}
    ...           AND             Close All Browsers

TC_ITMWM_05300 Code Image Discount as baht TH and EN
    [Tags]   TC_ITMWM_05300  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_High

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05300}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05300.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Tick Display on Thumbnail Checkbox
    And Type All Code Texts in TH and EN
    And Click Save on Manage Display Page
    Then Code Image for TH and EN Displays Baht Same As The Created Promotion Previously    ${promotion_id}

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05300.name}
    ...           AND             Close All Browsers

TC_ITMWM_05301 Code Image Discount as percent TH and EN
    [Tags]   TC_ITMWM_05301  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression     WLS_High

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Tick Display on Thumbnail Checkbox
    And Type All Code Texts in TH and EN
    And Click Save on Manage Display Page
    Then Code Image for TH and EN Displays Percent Same As The Created Promotion Previously   ${promotion_id}

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

TC_ITMWM_05302 check value of display on web and thumbnail in case of not ticking display on web and display thumbnail
    [Tags]   TC_ITMWM_05302  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_High
    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Click Save on Manage Display Page

    Then Compare Promotion Display On Web In DB          ${promotion_id}   0
    And Compare Promotion Display On Thumbnail In DB     ${promotion_id}   0
    And Display on Web Checkbox Is Not Ticked
    And Not Display on the below section - Under Display on Web


    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

TC_ITMWM_05303 check value of display on web and thumbnail in case of ticking display on web and display thumbnail
    [Tags]   TC_ITMWM_05303  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_High
    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Tick Display on Thumbnail Checkbox
    And Type All Code Texts in TH and EN
    And Click Save on Manage Display Page

    Then Compare Promotion Display On Web In DB          ${promotion_id}   1
    And Compare Promotion Display On Thumbnail In DB     ${promotion_id}   1
    And Display on Web Checkbox Is Ticked
    And Display on Web Thumbnail Is Ticked

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

TC_ITMWM_05304 check value of display on web and thumbnail in case of ticking display on web
    [Tags]   TC_ITMWM_05304  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_Medium
    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Type All Code Texts in TH and EN
    And Click Save on Manage Display Page

    Then Compare Promotion Display On Web In DB          ${promotion_id}   1
    And Compare Promotion Display On Thumbnail In DB     ${promotion_id}   0
    And Display on Web Checkbox Is Ticked
    And Display on Web Thumbnail Is Not Ticked

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

TC_ITMWM_05306 To verify that titile text TH and EN is limited length 50 character
    [Tags]   TC_ITMWM_05306  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_Low

    ${titile_text_th_input}=      Set Variable   1234567890123456789012345678901234567890123456789012345
    ${titile_text_en_input}=      Set Variable   1234567890123456789012345678901234567890123456789012345
    ${discount_text_th_input}=    Set Variable   1234567890123456789012345678901234567890123456789012345
    ${discount_text_en_input}=    Set Variable   1234567890123456789012345678901234567890123456789012345
    ${code_text_th_input}=        Set Variable   1234567890123456789012345678901234567890123456789012345
    ${code_text_en_input}=        Set Variable   1234567890123456789012345678901234567890123456789012345

    ${expect_length}=             Set Variable   50

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Type All Code Texts in TH and EN
     ...    ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}

    ${title_th}=      Get Title text TH displayed in the textbox
    ${txt_length}=    Get Length   ${title_th}
    Should Be Equal As Numbers     ${txt_length}   ${expect_length}

    ${title_en}=      Get Title text EN displayed in the textbox
    ${txt_length}=    Get Length   ${title_en}
    Should Be Equal As Numbers     ${txt_length}   ${expect_length}

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

TC_ITMWM_05307 To verify that Code text TH and EN is limited length 50 character
    [Tags]   TC_ITMWM_05306  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_Low

    ${titile_text_th_input}=      Set Variable   1234567890123456789012345678901234567890123456789012345
    ${titile_text_en_input}=      Set Variable   1234567890123456789012345678901234567890123456789012345
    ${discount_text_th_input}=    Set Variable   1234567890123456789012345678901234567890123456789012345
    ${discount_text_en_input}=    Set Variable   1234567890123456789012345678901234567890123456789012345
    ${code_text_th_input}=        Set Variable   1234567890123456789012345678901234567890123456789012345
    ${code_text_en_input}=        Set Variable   1234567890123456789012345678901234567890123456789012345

    ${expect_length}=             Set Variable   50

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Type All Code Texts in TH and EN
     ...    ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}

    ${code_th}=       Get Code text TH displayed in the textbox
    ${txt_length}=    Get Length   ${code_th}
    Should Be Equal As Numbers     ${txt_length}   ${expect_length}

    ${code_en}=       Get Code text EN displayed in the textbox
    ${txt_length}=    Get Length   ${code_en}
    Should Be Equal As Numbers     ${txt_length}   ${expect_length}

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

TC_ITMWM_05308 To verify that discount text TH and EN is limited length 50 character
    [Tags]   TC_ITMWM_05308  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_Low

    ${titile_text_th_input}=      Set Variable   1234567890123456789012345678901234567890123456789012345
    ${titile_text_en_input}=      Set Variable   1234567890123456789012345678901234567890123456789012345
    ${discount_text_th_input}=    Set Variable   1234567890123456789012345678901234567890123456789012345
    ${discount_text_en_input}=    Set Variable   1234567890123456789012345678901234567890123456789012345
    ${code_text_th_input}=        Set Variable   1234567890123456789012345678901234567890123456789012345
    ${code_text_en_input}=        Set Variable   1234567890123456789012345678901234567890123456789012345

    ${expect_length}=             Set Variable   50

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Type All Code Texts in TH and EN
     ...    ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}

    ${discount_th}=   Get Discount text TH displayed in the textbox
    ${txt_length}=    Get Length   ${discount_th}
    Should Be Equal As Numbers     ${txt_length}   ${expect_length}

    ${discount_en}=   Get Discount text EN displayed in the textbox
    ${txt_length}=    Get Length   ${discount_en}
    Should Be Equal As Numbers     ${txt_length}   ${expect_length}

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

# TC_ITMWM_05311 To verify that error message is displayed after saving when a user enters zero at 'Sort'

TC_ITMWM_05312 To verify that error message is displayed after saving when a user enters letters at 'Sort'
    [Tags]   TC_ITMWM_05311  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_Low
    ${sort_input}=   Set Variable    a1
    ${expect}=       Set Variable    1

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05303}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05303.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Type Title Text in TH
    And Type Title Text in EN
    And Type Code Text in TH
    And Type Code Text in EN
    And Type Discount text in TH
    And Type Discount text in EN
    And Type Value in Sort   ${sort_input}
    And Click Save on Manage Display Page

    Then Saved Successfully message not displays on Manage Display page
    ${sort_txt}=   Get Sort text displayed in the textbox
    Should Be Equal As Strings    '${sort_txt}'   '${expect}'

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05303.name}
    ...           AND             Close All Browsers

TC_ITMWM_05450 To verify that Entered data in Display section are still kept after a user unticks the 'Display on Thumbnail' checkbox
    [Tags]   TC_ITMWM_05450    iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_Medium

    ${titile_text_th_input}=      Set Variable   title textไทย!@#$%^&*()_+
    ${titile_text_en_input}=      Set Variable   title textEN!@#$%^&*()_+
    ${discount_text_th_input}=    Set Variable   codetxtไทย
    ${discount_text_en_input}=    Set Variable   cdtxtEN
    ${code_text_th_input}=        Set Variable   DiscTไทย
    ${code_text_en_input}=        Set Variable   DiscTEN

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05300}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05300.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Tick Display on Thumbnail Checkbox
    And Type All Code Texts in TH and EN   ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}
    And Click Save on Manage Display Page

    And Untick Display on Thumbnail Checkbox
    And Click Save on Manage Display Page

    Then All Text for TH and EN Displays Baht Same As The Previously Input   ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}
    And Display on Web Checkbox Is Ticked
    And Display on Web Thumbnail Is Not Ticked

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05300.name}
    ...           AND             Close All Browsers

TC_ITMWM_05451 To verify that the entered data in Display section are still kept after a user unticks the 'Display on Web' checkbox
    [Tags]   TC_ITMWM_05451  iTM-A-Sprint 2016S16   ITMA-3284   ready    regression    WLS_Medium

    ${titile_text_th_input}=      Set Variable   title textไทย!@#$%^&*()_+
    ${titile_text_en_input}=      Set Variable   title textEN!@#$%^&*()_+
    ${discount_text_th_input}=    Set Variable   codetxtไทย
    ${discount_text_en_input}=    Set Variable   cdtxtEN
    ${code_text_th_input}=        Set Variable   DiscTไทย
    ${code_text_en_input}=        Set Variable   DiscTEN

    Given Login Pcms
    And Go To Robot Campaign    ${campaign_name}
    ${promotion_code}=    Create Promotion    &{TC05300}
    ${promotion_id}=      py_get_promotion_id   ${campaign_name}    ${TC05300.name}

    When Go To Robot Campaign    ${campaign_name}
    And Click Manage Display Button

    Then Location Should Contain        /promotions/manage-display/

    When Tick Display on Web Checkbox
    And Tick Display on Thumbnail Checkbox
    And Type All Code Texts in TH and EN   ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}
    And Click Save on Manage Display Page
    And Untick Display on Web Checkbox
    And Click Save on Manage Display Page

    Then Display on Web Checkbox Is Not Ticked

    When Tick Display on Web Checkbox

    Then All Text for TH and EN Displays Baht Same As The Previously Input   ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}
    And Display on Web Checkbox Is Ticked
    And Display on Web Thumbnail Is Ticked

    [Teardown]    Run Keywords    Promotion - Remove Promotion By Campaign Name And Promotion Name      ${campaign_name}   ${TC05300.name}
    ...           AND             Close All Browsers

