*** Settings ***
Resource          ../../../../Resource/Config/stark/camps_libs_resources.robot
Resource          WebElement_CAMPS_Promotion.robot

*** Keywords ***
Bundle Form Should Be Visible
    [Arguments]    ${number_of_bundle}
    ${loop_range}=    Evaluate    ${number_of_bundle}+1
    : FOR    ${index}    IN RANGE    1    ${loop_range}
    \    Element Should Be Visible    //*[@id='bundledVariant${index}']
    \    Element Should Be Visible    //*[@id='discountPercentSpan${index}']
    \    Element Should Be Visible    //*[@id='discountPercent${index}']
    \    Element Should Be Visible    //*[@id='discountFixedSpan${index}']
    \    Element Should Be Visible    //*[@id='discountFixed${index}']
    \    Run Keyword If    ${index} > 1 and ${number_of_bundle} > 2    Element Should Be Visible    //*[@id='deleteBtn${index}']

Bundle MNP Form Should Be Visible
    [Arguments]    ${number_of_bundle}
    ${loop_range}=    Evaluate    ${number_of_bundle}+2
    : FOR    ${index}    IN RANGE    2    ${loop_range}
    \    Element Should Be Visible    //*[@id='bundledVariant${index}']
    \    Element Should Be Visible    //*[@id='discountPercentSpan${index}']
    \    Element Should Be Visible    //*[@id='discountPercent${index}']
    \    Element Should Be Visible    //*[@id='discountFixedSpan${index}']
    \    Element Should Be Visible    //*[@id='discountFixed${index}']
    \    Run Keyword If    ${index} > 2 and ${number_of_bundle} > 1    Element Should Be Visible    //*[@id='deleteBtn${index}']

Buy Variant Value Should Contain
    [Arguments]    ${expected_value}
    @{expected_list}=    Split String    ${expected_value}    ,
    ${length}=    Get Length    ${expected_list}
    Run Keyword And Return If    ${length}==1    Element Should Contain    ${PROMO-BUY-VARIANT-SPAN}    ${expected_value}
    : FOR    ${index}    IN RANGE    ${length}
    \    ${i}=    Evaluate    ${index}+1
    \    Element Should Contain    ${PROMO-BUY-VARIANT-SPAN}[${i}]    @{expected_list}[${index}]
    
Cancel To Create or Update Promotion
    Click Button    ${CANCEL-BUTTON}

Cancel To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Cancel At Modal Page

Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Confirm At Modal Page

Confirm To Duplicate All Promotions Under Campaign
    Confirm At Modal Page    ${WARN-DUPLICATE-CAMP-MSG}

Create Promotion Bundle
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${desc}=${VALID-PROMO-DESC}    ${desc_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}
    ...    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0    ${end_minute}=00
    ...    ${status}=disable    ${apply_with}=both    ${note}=${EMPTY}    ${note_trans}=${EMPTY}    @{bundle_list}
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Go To Promotion List under Campaign    ${g_camp_id}
    Go To Create Promotions Page
    Go To Create Bundle promotion Page
    Wait Until Element Is Visible    ${CREATE-BUTTON}    ${g_loading_delay_short}
    Input Promotion Information    ${name}    ${name_trans}    ${desc}    ${desc_trans}    ${short_desc}    ${short_desc_trans}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Input Bundle Note    ${note}
    Input Bundle Note Translation    ${note_trans}
    ${bundle_list_length}=    Get Length    ${bundle_list}
    : FOR    ${element}    IN RANGE    ${bundle_list_length}
    \    ${values}=    Get Dictionary Values    @{bundle_list}[${element}]
    \    ${bundleIndex}=    Evaluate    ${element} +1
    \    Run Keyword If    ${bundleIndex}>2    Click Element    ${ADD-VARIANT-BUTTON}
    \    Input Bundle VARIANT and Discount Detail    ${bundleIndex}    @{values}[0]    @{values}[2]    @{values}[1]
    Submit To Create or Update Promotion

Create Promotion Freebie
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${desc}=${VALID-PROMO-DESC}    ${desc_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}
    ...    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0    ${end_minute}=00
    ...    ${status}=disable    ${apply_with}=both    ${criteria_type}=Variant    ${criteria_value}=@{VALID-VARIANT}[0],@{VALID-VARIANT}[1]    ${buycriteria_type}=item    ${buycriteria_value}=1
    ...    ${repeat}=2    ${upload_img_boolean}=${true}    ${freebie_note}=${VALID-FREEBIE-NOTE}    ${freebie_note_trans}=${EMPTY}    ${free_type}=OR    @{free_variants_list}
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Go To Promotion List under Campaign    ${g_camp_id}
    Go To Create Promotions Page
    Go To Create Freebie promotion Page
    Input Promotion Information    ${name}    ${name_trans}    ${desc}    ${desc_trans}    ${short_desc}    ${short_desc_trans}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Select From List    ${PROMO-CRITERIA-TYPE-SELECT}    ${criteria_type}
    Run Keyword If    '${criteria_type}' != '${EMPTY}'    Input Text    ${PROMO-CRITERIA-VALUE-FIELD}    ${criteria_value}
    Run Keyword If    '${buycriteria_type}' == 'item'    Run Keywords    Click Element    ${PROMO-MIN-QUANTITY-RADIO-SPAN}
    ...    AND    Sleep    1
    ...    AND    Wait Until Element Is Enabled    ${PROMO-MIN-QUANTITY-FIELD}
    ...    AND    Input Text    ${PROMO-MIN-QUANTITY-FIELD}    ${buycriteria_value}
    Run Keyword If    '${buycriteria_type}' == 'baht'    Run Keywords    Click Element    ${PROMO-MIN-VALUE-RADIO-SPAN}
    ...    AND    Sleep    1
    ...    AND    Wait Until Element Is Enabled    ${PROMO-MIN-VALUE-FIELD}
    ...    AND    Input Text    ${PROMO-MIN-VALUE-FIELD}    ${buycriteria_value}    #    .. [Temporary] Remove Adding Free Variants Feature >> [Start Comment]
    ...    # Run Keyword If    '${free_type}' == 'OR'    Click Element    ${PROMO-FREE-TYPE-OR-RADIO-SPAN}    # ...    # ELSE IF
    ...    # '${free_type}' == 'AND'    Click Element    ${PROMO-FREE-TYPE-AND-RADIO-SPAN}
    # ${free_variants_listLength}=    Get Length    ${free_variants_list}
    # : FOR    ${element}    IN RANGE    ${free_variants_listLength}
    # \    ${values}=    Get Dictionary Values    @{free_variants_list}[${element}]
    # \    ${freeVariantsIndex}=    Evaluate    ${element} +1
    # \    Run Keyword If    ${freeVariantsIndex}>1    Click Element    ${ADD-VARIANT-BUTTON}
    # \    Input Free Variant and Quantity Detail    ${freeVariantsIndex}    @{values}[0]    @{values}[1]
    #    .. [Temporary] Remove Adding Free Variants Feature << [End Comment]
    ${values}=    Get Dictionary Values    @{free_variants_list}[0]
    Input Free Variant and Quantity Detail    1    @{values}[0]    @{values}[1]
    Input Text    ${PROMO-REPEAT-FIELD}    ${repeat}
    Input Text    ${PROMO-FREEBIE-NOTE-FIELD}    ${freebie_note}
    Input Text    ${PROMO-FREEBIE-NOTE-TRANS1-FIELD}    ${freebie_note_trans}
    Run Keyword If    ${upload_img_boolean}    Run Keywords    Upload Image to Freebie Image LVC Desktop
    ...    AND    Upload Image to Freebie Image LVC Desktop Translation
    ...    AND    Upload Image to Freebie Image LVC Mobile
    ...    AND    Upload Image to Freebie Image LVC Mobile Translation
    ...    AND    Upload Image to Freebie Image LVD Desktop
    ...    AND    Upload Image to Freebie Image LVD Desktop Translation
    ...    AND    Upload Image to Freebie Image LVD Mobile
    ...    AND    Upload Image to Freebie Image LVD Mobile Translation
    Submit To Create or Update Promotion

Create Promotion MNP
    [Arguments]    ${name}    ${name_trans}=${EMPTY}    ${desc}=${VALID-PROMO-DESC}    ${desc_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}
    ...    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0    ${end_minute}=00
    ...    ${status}=disable    ${apply_with}=both    ${note}=${EMPTY}    ${note_trans}=${EMPTY}    @{bundle_list}
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Go To Promotion List under Campaign    ${g_camp_id}
    Go To Create Promotions Page
    Go To Create MNP promotion Page
    Wait Until Element Is Visible    ${CREATE-BUTTON}    ${g_loading_delay_short}
    Input Promotion Information    ${name}    ${name_trans}    ${desc}    ${desc_trans}    ${short_desc}    ${short_desc_trans}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Input Bundle Note    ${note}
    Input Bundle Note Translation    ${note_trans}
    Input Primary MNP    ${bundle_list}
    ${bundle_list_length}=    Get Length    ${bundle_list}
    : FOR    ${element}    IN RANGE    ${bundle_list_length} -1
    \    Run Keyword If    '${bundle_list_length}' == '0'    Exit For Loop
    \    ${index}=    Evaluate    ${element} +1
    \    ${index2}=    Evaluate    ${element} +2
    \    ${values}=    Get Dictionary Values    @{bundle_list}[${index}]
    \    Click Element    ${ADD-VARIANT-BUTTON}
    \    Input Bundle VARIANT and Discount Detail    ${index2}    @{values}[0]    @{values}[2]    @{values}[1]
    Submit To Create or Update Promotion

Delete Latest Promotion
    Wait Until Page Contains Element    //*[@id="deleteBtn1"]    ${g_loading_delay}
    Click Element    //*[@id="deleteBtn1"]
    Click button    ${MODAL-CONFIRM}
    Wait Until Page Contains Promotion List under Campaign Table

Delete Promotion
    [Arguments]    ${index}
    Click Element    //*[@id="deleteBtn${index}"]
    Click button    ${MODAL-CONFIRM}
    Wait Until Page Contains Promotion List under Campaign Table

Delete Promotion By ID
    [Arguments]    ${promo_ids}
    Go To Promotion List under Campaign    ${g_camp_id}
    Wait Until Page Contains Element    ${PROMO-LIST-TABLE}    ${g_loading_delay}
    @{promo_ids}=    Split String    ${promo_ids}    ,
    : FOR    ${item}    IN    @{promo_ids}
    \    Input Text    ${PROMO-SEARCH-ID-FIELD}    ${item}
    \    Click Button    ${SEARCH-FILTER-BUTTON}
    \    Wait Until Page Contains Promotion List under Campaign Table
    \    Delete Latest Promotion

Disable Promotion by ID
    [Arguments]    ${promotion_id_list}    ${camp_id}=${g_camp_id}
    Go To Promotion List under Campaign    ${camp_id}
    Wait Until Page Contains Promotion List under Campaign Table
    Select Promotion by ID    ${promotion_id_list}
    Click Element    ${ACTION-DISABLE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table

Duplicate Latest Promotion
    Click Element    //*[@id="duplicateBtn1"]
    Wait Until Element Is Visible    ${NAME-FIELD}    ${g_loading_delay}

Edit Latest Promotion
    Click Element    //*[@id="editBtn1"]
    Wait Until Element Is Visible    ${NAME-FIELD}    ${g_loading_delay}

Edit Promotion By ID
    [Arguments]    ${promo_id}
    Go To Promotion List under Campaign    ${g_camp_id}
    Wait Until Page Contains Promotion List under Campaign Table
    Input Text    ${PROMO-SEARCH-ID-FIELD}    ${promo_id}
    Click Button    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table
    Edit Latest Promotion

Edit Promotion By Row
    [Arguments]    ${row}=1
    ${id_name}=    Set Variable    editBtn${row}
    Click Element    //*[@id="${id_name}"]
    Wait Until Element Is Visible    ${NAME-FIELD}    ${g_loading_delay}

Enable Promotion by ID
    [Arguments]    ${promotion_id_list}    ${camp_id}=${g_camp_id}
    Go To Promotion List under Campaign    ${camp_id}
    Wait Until Page Contains Promotion List under Campaign Table
    Select Promotion by ID    ${promotion_id_list}
    Click Element    ${ACTION-ENABLE-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table

Filter Promotion List by Promotion ID
    [Arguments]    ${id}
    Input Text    ${PROMO-SEARCH-ID-FIELD}    ${id}
    Click Element    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table

Filter Promotion List by Promotion Name
    [Arguments]    ${name}
    Input Text    ${PROMO-SEARCH-NAME-FIELD}    ${name}
    Click Element    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Promotion List under Campaign Table

Free Variant And Quantity Should Be Visible
    [Arguments]    ${number_of_free_variant}
    ${loop_range}=    Evaluate    ${number_of_free_variant}+1
    : FOR    ${index}    IN RANGE    1    ${loop_range}
    \    Element Should Be Visible    //*[@id='freeVariant${index}']
    \    Element Should Be Visible    //*[@id='freeVariantQuantity${index}']
    \    Run Keyword If    ${number_of_free_variant} > 2    Element Should Be Visible    //*[@id='deleteBtn${index}']

Free Variant Value Should Contain
    [Arguments]    ${expected_value}
    @{expected_list}=    Split String    ${expected_value}    ,
    ${length}=    Get Length    ${expected_list}
    ${value}=    Get Value    ${PROMO-FREE-VARIANT-FIELD}
    Run Keyword And Return If    ${length}==1    Should Be Equal    ${value}    ${expected_value}
    : FOR    ${index}    IN RANGE    ${length}
    \    ${i}=    Evaluate    ${index}+1
    \    ${value}=    Get Value    ${PROMO-FREE-VARIANT-FIELD}[${i}]
    \    Should Be Equal    ${value}    @{expected_list}[${index}]

Get Promotion ID
    [Arguments]    ${row}=1
    ${id}=    Get Text From Table    promotionListTable    4    ${row}
    Return From Keyword    ${id}

Get Promotion ID List from current page
    ${promotion_ids}    Create List
    ${row_count}=    Get Row Count    promotionListTable
    : FOR    ${row}    IN RANGE    1    ${row_count}+1
    \    ${id}=    Get Promotion ID    ${row}
    \    Append To List    ${promotion_ids}    ${id}
    Return From Keyword    ${promotion_ids}

Get Promotion ID under Campaign
    [Arguments]    ${g_camp_id}    ${row}=1
    Go To Campaign for iTruemart Home Page
    Go To Promotion List under Campaign    ${g_camp_id}
    ${is_no_data}=    Table Should Not Contain Data (No Data)
    Return From Keyword If    '${is_no_data}'=='PASS'    No Data
    ${g_promo_id}=    Get Promotion ID    ${row}
    Return From Keyword    ${g_promo_id}

Get Promotion Live Status
    [Arguments]    ${row}=1
    ${live_status}=    Get Live Status    promotionListTable    3    ${row}
    Return From Keyword    ${live_status}

Get Promotion Name
    [Arguments]    ${row}=1
    ${name}=    Get Text From Table    promotionListTable    5    ${row}
    Return From Keyword    ${name}

Get Promotion Status
    [Arguments]    ${row}=1
    ${status}=    Get Text From Table    promotionListTable    2    ${row}
    Return From Keyword    ${status}

Get Promotion Type
    [Arguments]    ${row}=1
    ${promo_type}=    Get Text From Table    promotionListTable    6    ${row}
    Return From Keyword    ${promo_type}

Input Bundle Note
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["noteLocal"].setData("${text}")

Input Bundle Note Translation
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["noteEN"].setData("${text}")

Input Bundle Variant and Discount Detail
    [Arguments]    ${index}    ${variant}    ${discount_type}    ${discount_value}
    [Documentation]    discount_type must be 'Percent' or 'Fixed'
    Input Text    //*[@id='bundledVariant${index}']    ${variant}
    Click Element    //*[@id='discount${discount_type}Span${index}']
    Input Text    //*[@id='discount${discount_type}${index}']    ${discount_value}

Input Free Variant and Quantity Detail
    [Arguments]    ${index}    ${variant}    ${quantity}
    Input Text    //*[@id='freeVariant${index}']    ${variant}
    Input Text    //*[@id='freeVariantQuantity${index}']    ${quantity}

Input Long Description
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["descriptionLocal"].setData("${text}")

Input Long Description Translation
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["descriptionEN"].setData("${text}")

Input Primary MNP
    [Arguments]    ${bundle_list}
    ${values}=    Get Dictionary Values    @{bundle_list}[0]
    Input Text    //*[@id="primaryVariantsDiv"]/div/input    @{values}[0]
    Repeat Keyword    2    Click Element    //*[@id='discount@{values}[2]Span1']
    Input Text    //*[@id='discount@{values}[2]1']    @{values}[1]

Input Promotion Information
    [Arguments]    ${name}    ${name_trans}    ${desc}    ${desc_trans}    ${short_desc}    ${short_desc_trans}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Input Text    ${NAME-FIELD}    ${name}
    Input Text    ${NAME-TRANS1-FIELD}    ${name_trans}
    Input Long Description    ${desc}
    Input Long Description Translation    ${desc_trans}
    Input Text    ${SHORT-DESC-FIELD}    ${short_desc}
    Input Text    ${SHORT-DESC-TRANS1-FIELD}    ${short_desc_trans}
    Run Keyword If    '${start_date}' != 'none'    Click Element    ${PERIOD-FIELD}
    Run Keyword If    '${start_date}' != 'none'    Wait Until Element Is Visible    ${DATETIME-MENU}
    Run Keyword If    '${start_date}' != 'default' and '${start_date}' != 'none'    Input Date Time for Period    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}
    ...    ${end_hour}    ${end_minute}
    # Use default date-time (Start:Today 00:00, End:Tomorrow 00:00)
    Run Keyword If    '${start_date}' != 'none'    Click button    ${DATETIME-APPLY}
    Input Promotion Status    ${status}
    Input Member Nonmember    ${apply_with}

Input Promotion Status
    [Arguments]    ${status}
    Run Keyword If    '${status}' == 'enable'    Select Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE IF    '${status}' == 'disable'    Unselect Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE    Log    ${status}

Promotion Live Status Should Be Equal
    [Arguments]    ${expected_live}    ${row}=1
    Live Status Should Be Equal    promotionListTable    ${expected_live}    3    ${row}

Promotion Live Status on Current page should be in List
    [Arguments]    @{expected_live}
    Live Status on Current page should be Equal    promotionListTable    3    ${expected_live}

Promotion Live Status on Current page should not be in List
    [Arguments]    @{expected_live}
    Live status on Current page should not be Equal    promotionListTable    3    ${expected_live}

Promotion Name Should Be As Test Case Number
    [Arguments]    ${row}=1
    @{words}=    Split String    ${TEST_NAME}
    ${promo_name}=    Get Promotion Name    ${row}
    Should Be Equal    ${promo_name}    @{words}[0]

Promotion Pending Status Should Be Equal
    [Arguments]    ${expected_status}    ${row}=1
    ${actual_status}=    Get Promotion Status    ${row}
    Should Be Equal    ${expected_status}    ${actual_status}

Promotion Pending Status Should Not Be Equal
    [Arguments]    ${expected_status}    ${row}=1
    ${actual_status}=    Get Promotion Status    ${row}
    Should Not Be Equal    ${expected_status}    ${actual_status}

Promotion Status on Create/Edit Page Should Be Disable
    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}

Promotion Status on Create/Edit Page Should Be Enable
    Checkbox Should Be Selected    ${ENABLE-TOGGLE}

Promotion Type Should Be Equal
    [Arguments]    ${expected_type}    ${row}=1
    ${promo_type}=    Get Promotion Type    ${row}
    List Should Contain Value    ${expected_type}    ${promo_type}

Promotion Type Should Not Be Equal
    [Arguments]    ${expected_type}    ${row}=1
    ${promo_type}=    Get Promotion Type    ${row}
    List Should Not Contain Value    ${expected_type}    ${promo_type}

Promotion Type on Current page should be Equal
    [Arguments]    ${expected_type}
    ${row_count}=    Get Row Count    promotionListTable
    : FOR    ${index}    IN RANGE    1    ${row_count}+1
    \    Promotion Type Should Be Equal    ${expected_type}    ${index}

Promotion Type on Current page should not be Equal
    [Arguments]    ${expected_type}
    ${row_count}=    Get Row Count    promotionListTable
    : FOR    ${index}    IN RANGE    1    ${row_count}+1
    \    Promotion Type Should Not Be Equal    ${expected_type}    ${index}

Remove Bundle Variant by index
    [Arguments]    ${index}
    Click Element    //*[@id='deleteBtn${index}']

Select Checkbox by Promotion ID at Promotion List Page
    [Arguments]    ${promo_id}
    : FOR    ${index}    IN RANGE    1    21
    \    ${findID}=    Get Text    //table[@id='promotionListTable']/tbody/tr[${index}]/td[4]
    \    Run Keyword If    ${promo_id}==${findID}    Run Keywords    Click Element    //*[@id='checkboxSpan${index}']
    \    ...    AND    Exit For Loop

Select Code Group
    [Arguments]    ${code_id}
    Run Keyword If    '${code_id}' != '${EMPTY}'    Run Keywords    Click Button    ${PROMO-SELECT-CODE-GROUP-BUTTON}
    ...    AND    Wait Until Page Contains Element    ${CODE-GROUP-LIST-TABLE}    ${g_loading_delay}
    ...    AND    Input Text    ${CODE-GROUP-ID-FILTER-FIELD}    ${code_id}
    ...    AND    Click Button    ${SEARCH-FILTER-BUTTON}
    ...    AND    Wait Until Page Contains Element    ${CODE-GROUP-LIST-TABLE}    ${g_loading_delay}
    ...    AND    Click Button    //*[@id="selectBtn0"]

Select PC Option
    [Arguments]    ${pc_option}
    Run Keyword If    '${pc_option}' == 'PC1'    Click Element    ${PROMO-PC1-RADIO-SPAN}
    ...    ELSE IF    '${pc_option}' == 'PC3'    Click Element    ${PROMO-PC3-RADIO-SPAN}
    ...    ELSE IF    '${pc_option}' == '${EMPTY}'    Log    ${pc_option} is empty
    ...    ELSE    Fail    ${pc_option} is invalid value

Select Promotion by ID
    [Arguments]    ${promotion_id_list}
    @{promotion_id_list}=    Split String    ${promotion_id_list}    ,
    : FOR    ${promo_id}    IN    @{promotion_id_list}
    \    Select Checkbox by Promotion ID at Promotion List Page    ${promo_id}

Selected Code ID Should Be Equal
    [Arguments]    ${expected_id}    ${row}=1
    ${actual_text}=    Get Value    ${PROMO-CODE-GROUP-ID-FIELD}
    ${actual_id}=    Fetch From Left    ${actual_text}    \ \
    Should Be Equal    ${expected_id}    ${actual_id}

Selected Code ID Should Not Be Equal
    [Arguments]    ${expected_id}    ${row}=1
    ${actual_text}=    Get Value    ${PROMO-CODE-GROUP-ID-FIELD}
    ${actual_id}=    Fetch From Left    ${actual_text}    \ \
    Should Not Be Equal    ${expected_id}    ${actual_id}

Submit To Create or Update Promotion
    Click Button    ${CREATE-BUTTON}

Upload Image to Freebie Image LVC Desktop
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/80x160_green.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVC-DESKTOP-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Freebie Image LVC Desktop Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/80x160_orange.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVC-DESKTOP-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Freebie Image LVC Mobile
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/110x220_pink.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVC-MOBILE-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Freebie Image LVD Desktop
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/160x320_brown.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVD-DESKTOP-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Freebie Image LVD Desktop Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/160x320_deepblue.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVD-DESKTOP-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Freebie Image LVD Mobile
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/160x320_skyblue.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVD-MOBILE-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Freebie Image LVD Mobile Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/160x320_yellow.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVD-MOBILE-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload image to Freebie Image LVC Mobile Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/110x220_violet.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${PROMO-FREEBIE-IMG-LVC-MOBILE-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Verify Bundle Note
    [Arguments]    ${expect}
    ${result}=    Execute JavaScript    return CKEDITOR.instances["noteLocal"].getData()
    ${expect}=    Replace String    ${expect}    <br />    <br />\n
    Should Contain    ${result}    ${expect}

Verify Bundle Note Translation
    [Arguments]    ${expect}
    ${result}=    Execute JavaScript    return CKEDITOR.instances["noteEN"].getData()
    ${expect}=    Replace String    ${expect}    <br />    <br />\n
    Should Contain    ${result}    ${expect}

Verify Bundle Promotion Rule
    [Arguments]    ${note}    ${note_trans}    @{bundle_list}
    Verify Bundle Note    ${note}
    Verify Bundle Note Translation    ${note_trans}
    ${bundle_list_length}=    Get Length    ${bundle_list}
    : FOR    ${element}    IN RANGE    ${bundle_list_length}
    \    ${values}=    Get Dictionary Values    @{bundle_list}[${element}]
    \    ${bundleIndex}=    Evaluate    ${element} +1
    \    Verify Bundle Variant and Discount Detail    ${bundleIndex}    @{values}[0]    @{values}[2]    @{values}[1]

Verify Bundle Variant and Discount Detail
    [Arguments]    ${index}    ${variant}    ${discount_type}    ${discount_value}
    Textfield Should Contain    //*[@id='bundledVariant${index}']    ${variant}
    Radio Button Should Be Set To    discountRadio${index}    discount${discount_type}
    Textfield Should Contain    //*[@id='discount${discount_type}${index}']    ${discount_value}

Verify Confirmation Page for Campaign With existing freebie promotion in the same period
    [Arguments]    ${action}    ${expected_duplicate_variant_promotion}
    Return From Keyword If    '${action}'=='update'    No Warning message for duplicate freebie criteria variant
    ${duplicate_variants}=    Get Dictionary Keys    ${expected_duplicate_variant_promotion}
    # .. A, B, C
    ${variant_list}=    Convert To List    ${duplicate_variants}
    Wait Until Element Is Visible    //div[@class='modal-content']    ${g_loading_delay}
    Page Should Contain Element    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}
    Page Should Contain    Some promotions under this campaign contain the same variants under freebie criteria.
    Page Should Contain    Are you sure you want to ${action} this campaign anyway ?
    Table Cell Should Contain    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    1    1    Variant
    Table Cell Should Contain    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    1    2    Promotion(s)
    ${record_row}=    Set Variable    2
    : FOR    ${expected_variant_item}    IN    @{variant_list}
    \    ${expected_duplicate_promotion_for_each_variant}=    Get From Dictionary    ${expected_duplicate_variant_promotion}    ${expected_variant_item}
    \    ${actual_variant_item}=    Get Table Cell    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    ${record_row}    1
    \    ${actual_duplicate_promotion_for_each_variant}=    Get Table Cell    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    ${record_row}    2
    \    Should Be Equal    ${expected_variant_item}    ${actual_variant_item}
    \    Should Be Equal    ${expected_duplicate_promotion_for_each_variant}    ${actual_duplicate_promotion_for_each_variant}
    \    ${record_row}=    Evaluate    ${record_row}+1

Verify Confirmation Page for Promotion With Duplicated Freebie Criteria Variant
    [Arguments]    ${action}    ${expected_duplicate_variant_promotion}
    ${duplicate_variants}=    Get Dictionary Keys    ${expected_duplicate_variant_promotion}
    # .. A, B, C
    ${variant_list}=    Convert To List    ${duplicate_variants}
    Wait Until Element Is Visible    //div[@class='modal-content']    ${g_loading_delay}
    Page Should Contain Element    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}
    Page Should Contain    The following variant(s) in criteria are already existed in other promotion(s) in the same period
    Page Should Contain    Are you sure you want to ${action} this promotion anyway ?
    Table Cell Should Contain    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    1    1    Variant
    Table Cell Should Contain    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    1    2    Promotion ID(s)
    ${record_row}=    Set Variable    2
    : FOR    ${expected_variant_item}    IN    @{variant_list}
    \    ${expected_duplicate_promotion_for_each_variant}=    Get From Dictionary    ${expected_duplicate_variant_promotion}    ${expected_variant_item}
    \    ${actual_variant_item}=    Get Table Cell    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    ${record_row}    1
    \    ${actual_duplicate_promotion_for_each_variant}=    Get Table Cell    ${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    ${record_row}    2
    \    Should Be Equal    ${expected_variant_item}    ${actual_variant_item}
    \    Should Be Equal    ${expected_duplicate_promotion_for_each_variant}    ${actual_duplicate_promotion_for_each_variant}
    \    ${record_row}=    Evaluate    ${record_row}+1

Verify Freebie Promotion Rule
    [Arguments]    ${criteria_type}    ${criteria_value}    ${buycriteria_type}    ${buycriteria_value}    ${free_variants}    ${free_number}
    ...    ${repeat}
    # ${result_criteria_type}=    Get Selected List Label    ${PROMO-CRITERIA-TYPE-SELECT}
    # Should Be Equal    ${result_criteria_type}    ${criteria_type}
    @{expected_list}=    Split String    ${criteria_value}    ,
    ${tags}=    Get Matching XPath Count    ${PROMO-CRITERIA-VALUE-SPAN}
    : FOR    ${index}    IN RANGE    ${tags}
    \    ${row}=    Evaluate    ${index} +1
    \    ${expect}=    Set Variable    @{expected_list}[${index}]
    \    ${actual}=    Get Text    ${PROMO-CRITERIA-VALUE-SPAN}[${row}]
    \    Should Be Equal    ${actual}    ${expect}
    #Textfield Should Contain    ${PROMO-NUMBER-BUY-FIELD}    ${buyNumber}
    Run Keyword If    '${buycriteria_type}' == 'item'    Run Keywords    Radio Button Should Be Set To    minTotalRadio    minTotalQuantity
    ...    AND    Textfield Should Contain    ${PROMO-MIN-QUANTITY-FIELD}    ${buycriteria_value}
    Run Keyword If    '${buycriteria_type}' == 'baht'    Run Keywords    Radio Button Should Be Set To    minTotalRadio    minTotalValue
    ...    AND    Textfield Should Contain    ${PROMO-MIN-VALUE-FIELD}    ${buycriteria_value}
    Free Variant Value Should Contain    ${free_variants}
    Textfield Should Contain    ${PROMO-FREE-QUANTITY-FIELD}    ${free_number}
    Textfield Should Contain    ${PROMO-REPEAT-FIELD}    ${repeat}

Verify Long Description
    [Arguments]    ${expect}
    ${result}=    Execute JavaScript    return CKEDITOR.instances["descriptionLocal"].getData()
    ${expect}=    Replace String    ${expect}    <br />    <br />\n
    Should Contain    ${result}    ${expect}

Verify Long Description Translation
    [Arguments]    ${expect}
    ${result}=    Execute JavaScript    return CKEDITOR.instances["descriptionEN"].getData()
    ${expect}=    Replace String    ${expect}    <br />    <br />\n
    Should Contain    ${result}    ${expect}

Verify MNP Promotion Rule
    [Arguments]    ${note}    ${note_trans}    @{bundle_list}
    Verify Bundle Note    ${note}
    Verify Bundle Note Translation    ${note_trans}
    ${primary}=    Get Dictionary Values    @{bundle_list}[0]
    #Verify Primary MNP Variant and Discount Detail    0    @{primary}[0]    @{primary}[2]    @{primary}[1]
    ${bundle_list_length}=    Get Length    ${bundle_list}
    : FOR    ${element}    IN RANGE    ${bundle_list_length} -1
    \    ${index}=    Evaluate    ${element} +1
    \    ${values}=    Get Dictionary Values    @{bundle_list}[${index}]
    \    ${bundleIndex}=    Evaluate    ${index} +1
    \    Verify Bundle Variant and Discount Detail    ${bundleIndex}    @{values}[0]    @{values}[2]    @{values}[1]

Verify PC Option Should Be Set To
    [Arguments]    ${pc_option}
    ${pc_option}=    Convert To Lowercase    ${pc_option}
    Radio Button Should Be Set To    pc_optionType    ${pc_option}

Verify Primary MNP Variant and Discount Detail
    [Arguments]    ${index}    ${variant}    ${discount_type}    ${discount_value}
    ${value_index}=    Evaluate    ${index} +1
    Element Should Contain    //*[@id="primaryVariantsDiv"]/div/span[1]    ${variant}
    Radio Button Should Be Set To    discountRadio${value_index}    discount${discount_type}
    Textfield Should Contain    //*[@id='discount${discount_type}${value_index}']    ${discount_value}

Verify Promotion Information Data
    [Arguments]    ${name}    ${name_trans}    ${desc}    ${desc_trans}    ${short_desc}    ${short_desc_trans}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Textfield Should Contain    ${NAME-FIELD}    ${name}
    Textfield Should Contain    ${NAME-TRANS1-FIELD}    ${name_trans}
    Verify Long Description    ${desc}
    Verify Long Description Translation    ${desc_trans}
    Textarea Should Contain    ${SHORT-DESC-FIELD}    ${short_desc}
    Textarea Should Contain    ${SHORT-DESC-TRANS1-FIELD}    ${short_desc_trans}
    ${start_date}=    Convert Date    ${start_date}    date_format=%m/%d/%Y
    ${start_date}=    Convert Date    ${start_date}    datetime
    ${end_date}=    Convert Date    ${end_date}    date_format=%m/%d/%Y
    ${end_date}=    Convert Date    ${end_date}    datetime
    Log    @{MONTHS}[${start_date.month}] ${start_date.day}, ${start_date.year} ${start_hour}:${start_minute} - @{MONTHS}[${end_date.month}] ${end_date.day}, ${end_date.year} ${end_hour}:${end_minute}
    #Textfield Should Contain    ${PERIOD-FIELD}    @{MONTHS}[${start_date.month}] ${start_date.day}, ${start_date.year} ${start_hour}:${start_minute} - @{MONTHS}[${end_date.month}] ${end_date.day}, ${end_date.year} ${end_hour}:${end_minute}
    Run Keyword If    '${status}' == 'enable'    Checkbox Should Be Selected    ${ENABLE-TOGGLE}
    ...    ELSE    Checkbox Should Not Be Selected    ${ENABLE-TOGGLE}
    Run Keyword If    '${apply_with}' == 'member' or '${apply_with}' == 'both'    Checkbox Should Be Selected    ${MEMBER-CHKBOX}
    ...    ELSE    Checkbox Should Not Be Selected    ${MEMBER-CHKBOX}
    Run Keyword If    '${apply_with}' == 'nonmember' or '${apply_with}' == 'both'    Checkbox Should Be Selected    ${NONMEMBER-CHKBOX}
    ...    ELSE    Checkbox Should Not Be Selected    ${NONMEMBER-CHKBOX}

Verify Promotion Information Template
    [Arguments]    ${template_name}
    Wait Until Element Is Visible    ${TEMPLATE-NAME-CAPTION}    ${g_loading_delay_short}
    Wait Until Element Contains    ${TEMPLATE-NAME-CAPTION}    ${template_name}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${NAME-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${NAME-TRANS1-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${SHORT-DESC-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${SHORT-DESC-TRANS1-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${DESC-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${DESC-TRANS1-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${PERIOD-FIELD}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${ENABLE-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${MEMBER-CHKBOX-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${NONMEMBER-CHKBOX-SPAN}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${IMG-WEB-ELEMENT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${IMG-WEB-TRANS1-ELEMENT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${IMG-MOBILE-ELEMENT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${IMG-MOBILE-TRANS1-ELEMENT}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CREATE-BUTTON}    ${g_loading_delay_short}
    Wait Until Element Is Visible    ${CANCEL-BUTTON}    ${g_loading_delay_short}