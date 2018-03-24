*** Settings ***
Resource          ../../../../Resource/Config/stark/camps_libs_resources.robot
Resource          WebElement_CAMPS_Flash_Sale.robot

*** Variables ***

*** Keywords ***
Accept Error To Create Wow Banner With Duplicated Period
    Confirm At Modal Page    ${ERROR-DUPLICATE-PERIOD-WB-MSG}

Add Flash Sale Variant ID
    [Arguments]    ${variant_id}    ${product_index}=1    ${variant_index}=1
    ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${variant_id_list}
    Return From Keyword If    ${is_empty}    Variant is Empty
    Input Text    ${FS-WB-VARIANT-INPUT}    ${variant_id}
    Click Button    ${FS-WB-VARIANT-ADD-BUTTON}
    Sleep    2s
    ${xpath}=    Set Variable    variantId${product_index}-${variant_index}
    ${id_actual}=    Get Text    //*[@id='${xpath}']
    Should Be Equal    ${variant_id}    ${id_actual}

Cancel to Create and Return to Flash Sale List Page
    Click Button    ${CANCEL-BUTTON}
    Wait Until Page Contains Element    ${FLASH-SALE-LIST-TABLE}    ${g_loading_delay}

Clear Flash Sale Payment Channel
    ${wallet_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${FS-WB-WALLET-CHKBOX}
    ${online_banking_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${FS-WB-ONLINE_BANKING-CHKBOX}
    ${installment_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${FS-WB-INSTALLMENT-CHKBOX}
    ${ccw_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${FS-WB-CCW-CHKBOX}
    ${counter_service_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${FS-WB-COUNTER_SERVICE-CHKBOX}
    ${cod_selected}=    Run Keyword and return status    Checkbox Should Be Selected    ${FS-WB-COD-CHKBOX}
    Run Keyword If    ${wallet_selected}    Click Element    ${FS-WB-WALLET-SPAN}
    Run Keyword If    ${online_banking_selected}    Click Element    ${FS-WB-ONLINE_BANKING-SPAN}
    Run Keyword If    ${installment_selected}    Click Element    ${FS-WB-INSTALLMENT-SPAN}
    Run Keyword If    ${ccw_selected}    Click Element    ${FS-WB-CCW-SPAN}
    Run Keyword If    ${counter_service_selected}    Click Element    ${FS-WB-COUNTER_SERVICE-SPAN}
    Run Keyword If    ${cod_selected}    Click Element    ${FS-WB-COD-SPAN}

Click Delete First Row Flash Sale and Cancel
    Wait Until Page Contains Element    //*[@id="deleteBtn1"]    ${g_loading_delay}
    Click Element    //*[@id="deleteBtn1"]
    Click button    ${MODAL-CANCEL}
    Wait Until Page Contains Element    ${FLASH-SALE-LIST-TABLE}    ${g_loading_delay}

Create Flash Sale Wow Banner
    [Arguments]    ${app_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${limit_to_buy_type}=PREDEFINED
    ...    ${payment_channel}=all    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0
    ...    ${end_minute}=00    ${status}=disable    ${apply_with}=both    ${upload_img_boolean}=${true}    ${variant_id}=@{VALID-FLASH-SALE-VARIANT}[0]    ${promotion_price}=1500
    ...    ${quota}=1    ${confirm_to_create}=${false}
    Input All Wow Banner Data and Submit    ${app_id}    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}
    ...    ${payment_channel}    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}
    ...    ${end_minute}    ${status}    ${apply_with}    ${upload_img_boolean}    ${variant_id}    ${promotion_price}
    ...    ${quota}
    Log    confirm: ${confirm_to_create}    console=yes
    Run Keyword If    ${confirm_to_create}    Confirm To Create or Update Flash Sale With Duplicated Product
    # Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table

Create Flash Sale Wow Extra
    [Arguments]    ${app_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${limit_to_buy_type}=PREDEFINED
    ...    ${payment_channel}=all    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0
    ...    ${end_minute}=00    ${status}=disable    ${apply_with}=both    ${partner}=@{VALID-FLASH-SALE-PARTNER}[2]    ${upload_img_boolean}=${true}    ${variant_id}=@{VALID-FLASH-SALE-VARIANT}[3]
    ...    ${promotion_price}=1500    ${confirm_to_create}=${false}
    Input All Wow Extra Data and Submit    ${app_id}    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}
    ...    ${payment_channel}    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}
    ...    ${end_minute}    ${status}    ${apply_with}    ${partner}    ${upload_img_boolean}    ${variant_id}
    ...    ${promotion_price}
    Log    confirm: ${confirm_to_create}    console=yes
    Run Keyword If    ${confirm_to_create}    Confirm To Create or Update Flash Sale With Duplicated Product
    # Run Keyword And Continue On Failure    Confirm To Create or Update Flash Sale With Duplicated Product
    Wait Until Page Contains Flash Sale List Table

Delete First Row Flash Sale
    Wait Until Page Contains Element    //*[@id="deleteBtn1"]    ${g_loading_delay}
    Click Element    //*[@id="deleteBtn1"]
    Click button    ${MODAL-CONFIRM}
    Wait Until Page Contains Element    ${FLASH-SALE-LIST-TABLE}    ${g_loading_delay}

Delete Flash Sale By ID
    [Arguments]    ${fs_ids}
    Go To Campaign for iTruemart Home Page
    Go To Flash Sale List Page
    @{fs_ids}=    Split String    ${fs_ids}    ,
    : FOR    ${item}    IN    @{fs_ids}
    \    Input Text    ${FS-SEARCH-ID-FIELD}    ${item}
    \    Click Button    ${SEARCH-FILTER-BUTTON}
    \    Wait Until Page Contains Element    ${FLASH-SALE-LIST-TABLE}    ${g_loading_delay}
    \    Delete First Row Flash Sale

Duplicate Latest Flash Sale
    Click Element    //*[@id="duplicateBtn1"]
    Wait Until Element Is Visible    ${FS-NAME-FIELD}    ${g_loading_delay}

Edit Flash Sale Wow Banner
    [Arguments]    ${app_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${limit_to_buy_type}=PREDEFINED    ${payment_channel}=all
    ...    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0    ${end_minute}=00
    ...    ${status}=disable    ${apply_with}=both
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Select Flash Sale App ID    ${app_id}
    Input Flash Sale Information    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}    ${payment_channel}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}

Edit Latest Flash Sale
    Click Element    //*[@id="editBtn1"]
    Wait Until Element Is Visible    ${FS-NAME-FIELD}    ${g_loading_delay}

Edit Flash Sale By ID
    [Arguments]    ${flash_sale_id}
    Input Text    ${FS-SEARCH-ID-FIELD}    ${flash_sale_id}
    Click Button    ${SEARCH-FILTER-BUTTON}
    Wait Until Page Contains Flash Sale List Table
    Edit Latest Flash Sale

Edit Promotion Price and Quota for Wow Banner Variant ID
    [Arguments]    ${variant_id}    ${promotion_price}    ${quota}    ${product_index}=1    ${variant_index}=1
    Click Button    //*[@id='variantDeleteBtn${product_index}-${promotion_price}']
    Add Flash Sale Variant ID    ${variant_id}    ${product_index}    ${variant_index}
    Input Text    //*[@id='promotionPrice${product_index}-${promotion_price}']    ${promotion_price}
    Input Text    //*[@id='quota${product_index}-${promotion_price}']    ${quota}

Flash Sale ID Should Be Equal
    [Arguments]    ${expected_id}    ${row}=1
    ${actual_id}=    Get Flash Sale ID    ${row}
    Should Be Equal    ${expected_id}    ${actual_id}

Flash Sale ID Should Not Be Equal
    [Arguments]    ${expected_id}    ${row}=1
    ${actual_id}=    Get Flash Sale ID    ${row}
    Should Not Be Equal    ${expected_id}    ${actual_id}

Flash Sale Live Status Should Be Equal
    [Arguments]    ${expected_live}    ${row}=1
    Live Status Should Be Equal    flashSaleListTable    ${expected_live}    2    ${row}

Flash Sale Live Status on Current page should be in List
    [Arguments]    @{expected_live}
    Live Status on Current page should be Equal    flashSaleListTable    2    ${expected_live}

Flash Sale Live Status on Current page should not be in List
    [Arguments]    @{expected_live}
    Live status on Current page should not be Equal    flashSaleListTable    2    ${expected_live}

Flash Sale Name Should Be Equal
    [Arguments]    ${expected_name}    ${row}=1
    ${actual_name}=    Get Flash Sale Name    ${row}
    Should Be Equal    ${expected_name}    ${actual_name}

Flash Sale Should Not Contain Promotion
    Run Keyword And Return Status    Page Should Contain    No Data
    @{result}=    Run Keyword And Ignore Error    Page Should Contain    No Data
    Return From Keyword    @{result}[0]

Found Error At Promotion Price Text Field
    [Arguments]    ${product_index}=1    ${variant_index}=1
    ${xpath}=    Set Variable    promotionPriceDiv${product_index}-${variant_index}
    ${class_value}=    Selenium2Library.Get Element Attribute    ${xpath}@class
    Should Contain    ${class_value}    has-error

Get Flash Sale ID
    [Arguments]    ${row}=1
    ${is_no_data}=    Table Should Not Contain Data (No Data)
    Return From Keyword If    '${is_no_data}'=='PASS'    No Data
    ${id}=    Get Text From Table    flashSaleListTable    3    ${row}
    Return From Keyword    ${id}

Get Flash Sale ID List from current page
    ${flash_sale_ids}    Create List
    ${row_count}=    Get Row Count    flashSaleListTable
    : FOR    ${row}    IN RANGE    1    ${row_count}+1
    \    ${id}=    Get Flash Sale ID    ${row}
    \    Append To List    ${flash_sale_ids}    ${id}
    Return From Keyword    ${flash_sale_ids}

Get Flash Sale Live Status
    [Arguments]    ${row}=1
    ${live_status}=    Get Live Status    flashSaleListTable    2    ${row}
    Return From Keyword    ${live_status}

Get Flash Sale Name
    [Arguments]    ${row}=1
    ${name}=    Get Text From Table    flashSaleListTable    4    ${row}
    Return From Keyword    ${name}

Get Flash Sale Type
    [Arguments]    ${row}=1
    ${flash_sale_type}=    Get Text From Table    flashSaleListTable    5    ${row}
    Return From Keyword    ${flash_sale_type}

Get Latest Flash Sale Enable Status
    ${color}=    Selenium2Library.Get Element Attribute    //*[@id='flashSaleListTable']/tbody/tr[1]/td[2]/div/i@style
    ${is_green}=    Run Keyword And Return Status    Should Contain    ${color}    color: green
    ${is_orange}=    Run Keyword And Return Status    Should Contain    ${color}    color: orange
    ${enable_status}    Set Variable If    ${is_green} or ${is_orange}    ${TRUE}    ${FALSE}
    Return From Keyword    ${enable_status}

Get Latest Flash Sale Running Status
    ${color}=    Selenium2Library.Get Element Attribute    //*[@id='flashSaleListTable']/tbody/tr[1]/td[2]/div/i@style
    ${is_green}=    Run Keyword And Return Status    Should Contain    ${color}    color: green
    ${running_status}    Set Variable If    ${is_green}    ${TRUE}    ${FALSE}
    Return From Keyword    ${running_status}

Input All Wow Banner Data and Submit
    [Arguments]    ${app_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${limit_to_buy_type}=PREDEFINED
    ...    ${payment_channel}=all    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0
    ...    ${end_minute}=00    ${status}=disable    ${apply_with}=both    ${upload_img_boolean}=${true}    ${variant_id}=@{VALID-FLASH-SALE-VARIANT}[0]    ${promotion_price}=1500
    ...    ${quota}=1
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Go To Create Flash Sale Page
    Go To Create Wow Banner Page
    Sleep    1s
    Select Flash Sale App ID    ${app_id}
    Input Flash Sale Information    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}    ${payment_channel}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Run Keyword If    ${upload_img_boolean}    Run Keywords    Upload Image to Wow Banner Image Today Desktop
    ...    AND    Upload Image to Wow Banner Image Today Desktop Translation
    ...    AND    Upload Image to Wow Banner Image Today Mobile
    ...    AND    Upload Image to Wow Banner Image Today Mobile Translation
    ...    AND    Upload Image to Wow Banner Image Tomorrow Desktop
    ...    AND    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    ...    AND    Upload Image to Wow Banner Image Tomorrow Mobile
    ...    AND    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    ...    AND    Upload Image to Wow Banner Image Incoming Desktop
    ...    AND    Upload Image to Wow Banner Image Incoming Desktop Translation
    ...    AND    Upload Image to Wow Banner Image Incoming Mobile
    ...    AND    Upload Image to Wow Banner Image Incoming Mobile Translation
    Input Promotion Price and Quota for Wow Banner Variant ID    ${variant_id}    ${promotion_price}    ${quota}
    Submit To Create or Update Flash Sale

Input All Wow Extra Data and Submit
    [Arguments]    ${app_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${limit_to_buy_type}=PREDEFINED
    ...    ${payment_channel}=all    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0
    ...    ${end_minute}=00    ${status}=disable    ${apply_with}=both    ${partner}=@{VALID-FLASH-SALE-PARTNER}[2]    ${upload_img_boolean}=${true}    ${variant_id}=@{VALID-FLASH-SALE-VARIANT}[3]
    ...    ${promotion_price}=1500
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Go To Create Flash Sale Page
    Go To Create Wow Extra Page
    Select Flash Sale App ID    ${app_id}
    Input Flash Sale Information    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}    ${payment_channel}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Select Flash Sale App ID    ${app_id}
    Select From List    ${FS-WE-PARTNER-SELECT}    ${partner}
    Input Promotion Price for Wow Extra Variant ID    ${variant_id}    ${promotion_price}
    Submit To Create or Update Flash Sale

Input Flash Sale Information
    [Arguments]    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}    ${payment_channel}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Input Text    ${FS-NAME-FIELD}    ${name}
    Input Text    ${FS-NAME-TRANS1-FIELD}    ${name_trans}
    Input Text    ${FS-SHORT-DESC-FIELD}    ${short_desc}
    Input Text    ${FS-SHORT-DESC-TRANS1-FIELD}    ${short_desc_trans}
    Run Keyword If    '${start_date}' != 'none'    Click Element    ${PERIOD-FIELD}
    Run Keyword If    '${start_date}' != 'none'    Wait Until Element Is Visible    ${DATETIME-MENU}
    Run Keyword If    '${start_date}' != 'default' and '${start_date}' != 'none'    Input Date Time for Period    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}
    ...    ${end_hour}    ${end_minute}
    # Use default date-time (Start:Today 00:00, End:Tomorrow 00:00)
    Run Keyword If    '${start_date}' != 'none'    Click button    ${DATETIME-APPLY}
    Run Keyword If    '${status}' == 'enable'    Select Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE IF    '${status}' == 'disable'    Unselect Checkbox    ${ENABLE-TOGGLE}
    ...    ELSE    Log    ${status}
    Input Member Nonmember    ${apply_with}
    Run Keyword If    '${limit_to_buy_type}' == 'UNLIMITED'    Click Element    ${FS-LIMIT-TO-BUY-UNLIMITED-RADIO-SPAN}
    ...    ELSE IF    '${limit_to_buy_type}' == 'PREDEFINED'    Run Keywords    Click Element    ${FS-LIMIT-TO-BUY-PREDEFINED-RADIO-SPAN}
    ...    AND    Select From List    ${FS-LIMIT-TO-BUY-PREDEFINED-SELECT}    ${limit}
    ...    ELSE IF    '${limit_to_buy_type}' == 'CUSTOM'    Run Keywords    Click Element    ${FS-LIMIT-TO-BUY-CUSTOM-RADIO-SPAN}
    ...    AND    Input Text    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    ${limit}
    ...    AND    Upload Image to Flash Sale Custom Limit to Buy
    ...    ELSE IF    '${limit_to_buy_type}' == 'CUSTOM-NO-IMAGE'    Run Keywords    Click Element    ${FS-LIMIT-TO-BUY-CUSTOM-RADIO-SPAN}
    ...    AND    Input Text    ${FS-LIMIT-TO-BUY-CUSTOM-FIELD}    ${limit}
    ...    ELSE    Log    ${limit_to_buy_type}
    # Run Keyword If    '${limit}' != 'none'    Input Text    ${FS-WB-LIMIT-TO-BUY}    ${limit}
    ${payments}=    Split String    ${payment_channel}    ,
    Clear Flash Sale Payment Channel
    ${all}=    Run Keyword And Return Status    List Should Contain Value    ${payments}    all
    ${WALLET}=    Run Keyword And Return Status    List Should Contain Value    ${payments}    @{VALID-FLASH-SALE-PAYMENT}[0]
    ${ONLINE_BANKING}=    Run Keyword And Return Status    List Should Contain Value    ${payments}    @{VALID-FLASH-SALE-PAYMENT}[1]
    ${INSTALLMENT}=    Run Keyword And Return Status    List Should Contain Value    ${payments}    @{VALID-FLASH-SALE-PAYMENT}[2]
    ${CCW}=    Run Keyword And Return Status    List Should Contain Value    ${payments}    @{VALID-FLASH-SALE-PAYMENT}[3]
    ${COUNTER_SERVICE}=    Run Keyword And Return Status    List Should Contain Value    ${payments}    @{VALID-FLASH-SALE-PAYMENT}[4]
    ${COD}=    Run Keyword And Return Status    List Should Contain Value    ${payments}    @{VALID-FLASH-SALE-PAYMENT}[5]
    Run Keyword If    ${all} or ${WALLET}    Click Element    ${FS-WB-WALLET-SPAN}
    Run Keyword If    ${all} or ${ONLINE_BANKING}    Click Element    ${FS-WB-ONLINE_BANKING-SPAN}
    Run Keyword If    ${all} or ${INSTALLMENT}    Click Element    ${FS-WB-INSTALLMENT-SPAN}
    Run Keyword If    ${all} or ${CCW}    Click Element    ${FS-WB-CCW-SPAN}
    Run Keyword If    ${all} or ${COUNTER_SERVICE}    Click Element    ${FS-WB-COUNTER_SERVICE-SPAN}
    Run Keyword If    ${all} or ${COD}    Click Element    ${FS-WB-COD-SPAN}

Input Promotion Price and Quota for Wow Banner Variant ID
    [Arguments]    ${variant_id}    ${promotion_price}    ${quota}    ${product_index}=1    ${variant_index}=1
    ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${variant_id}
    Return From Keyword If    ${is_empty}    Variant is Empty
    Add Flash Sale Variant ID    ${variant_id}     ${product_index}    ${variant_index}
    Input Text    //*[@id='promotionPrice${product_index}-${variant_index}']    ${promotion_price}
    Input Text    //*[@id='quota${product_index}-${variant_index}']    ${quota}

Input Promotion Price for Wow Extra Variant ID
    [Arguments]    ${variant_id}    ${promotion_price}    ${product_index}=1    ${variant_index}=1
    ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${variant_id}
    Return From Keyword If    ${is_empty}    Variant is Empty
    Add Flash Sale Variant ID    ${variant_id}     ${product_index}    ${variant_index}
    Input Text    //*[@id='promotionPrice${product_index}-${variant_index}']    ${promotion_price}

Quota Text Field Should Not Be Allowed To Edit
    Element Should Not Be Visible    //*[@id='quota0']

Select Flash Sale Predefined Limit to Buy
    [Arguments]    ${limit}
    Select From List    ${FS-LIMIT-TO-BUY-PREDEFINED-SELECT}    ${limit}

Select Flash Sale App ID
    [Arguments]    ${app_id}
    Wait Until Page Contains Flash Sale App ID
    Select From List    ${FS-APP-ID-FIELD}    ${app_id}

Submit To Create or Update Flash Sale
    Click Button    ${CREATE-BUTTON}

Submit To Create or Update Flash Sale then Go To Flash Sale List Page
    Click Button    ${CREATE-BUTTON}
    Wait Until Page Contains Element    ${FLASH-SALE-LIST-TABLE}    ${g_loading_delay}

Upload Image to Wow Banner Image Incoming Desktop
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-INCOMING-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Incoming Desktop Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-INCOMING-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Incoming Mobile
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-INCOMING-MOBILE-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Incoming Mobile Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-INCOMING-MOBILE-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Today Desktop
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TODAY-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Today Desktop Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TODAY-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Today Mobile
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TODAY-MOBILE-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Today Mobile Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TODAY-MOBILE-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Tomorrow Desktop
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TOMORROW-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Tomorrow Desktop Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TOMORROW-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Tomorrow Mobile
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TOMORROW-MOBILE-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Wow Banner Image Tomorrow Mobile Translation
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-WB-IMG-TOMORROW-MOBILE-TRANS1-INPUT}    ${canonical_path}
    Sleep    1s

Upload Image to Flash Sale Custom Limit to Buy
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/327x73.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${FS-IMG-LIMIT-TO-BUY-CUSTOM-INPUT}     ${canonical_path}
    Sleep    1s

Verify Default Payment Channel
    [Arguments]    ${app_id}
    Wait Until Element Is Visible    ${FS-APP-ID-SELECT}    ${g_loading_delay_short}
    ${select_list}=    Create List
    Run Keyword If    '${app_id}'=='iTruemart'    Verify Default Payment Channel when App ID is iTruemart
    ...    ELSE    Verify Default Payment Channel when App ID is not iTruemart

Verify Default Payment Channel when App ID is iTruemart
    Checkbox Should Not Be Selected    ${FS-WB-WALLET-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-ONLINE_BANKING-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-INSTALLMENT-CHKBOX}
    Checkbox Should Be Selected    ${FS-WB-CCW-CHKBOX}
    Element Should Be Disabled    ${FS-WB-CCW-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-COUNTER_SERVICE-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-COD-CHKBOX}

Verify Default Payment Channel when App ID is not iTruemart
    Checkbox Should Not Be Selected    ${FS-WB-WALLET-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-ONLINE_BANKING-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-INSTALLMENT-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-CCW-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-COUNTER_SERVICE-CHKBOX}
    Checkbox Should Not Be Selected    ${FS-WB-COD-CHKBOX}

Verify Flash Sale Table Column
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    Live
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    ID
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    Name
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    Type
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    Start
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    End
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    Created Date
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    Last Edit
    Table Row Should Contain    ${FLASH-SALE-LIST-TABLE}    1    Actions

Verify Wow Banner Variant ID
    [Arguments]    ${variant_id}    ${promotion_price}    ${quota}
    ${id_actual}=    Get Text    //*[@id='variantId1-1']
    Should Be Equal    ${variant_id}    ${id_actual}
    Textfield Should Contain    //*[@id='promotionPrice1-1']    ${promotion_price}
    ${is_editable_quota}=    Run Keyword And Return Status    Element Should Be Visible    //*[@id='quota1-1']
    Run Keyword If    ${is_editable_quota}    Textfield Should Contain    //*[@id='quota1-1']    ${quota}
    ...    ELSE    Element Should Contain    //*[@id='quota1-1']    ${quota}

Variant Management Section Should Be Disabled
    Element Should Be Disabled    ${FS-WB-VARIANT-ADD-BUTTON}
    Element Should Be Disabled    ${VARIANT-SELECTOR-OPEN-BUTTON}
    Element Should Be Disabled    //*[@id='productDeleteBtn1']
    Element Should Be Disabled    //*[@id='variantDeleteBtn1-1']
    Element Should Not Be Visible    //input[@id='promotionPrice1-1']
    Element Should Not Be Visible    //input[@id='quota1-1']

Wow Banner Variant Management Section Should Be Enabled
    Element Should Be Enabled    ${VARIANT-SELECTOR-OPEN-BUTTON}
    Element Should Be Enabled    //*[@id='productDeleteBtn1']
    Element Should Be Enabled    //*[@id='variantDeleteBtn1-1']
    Element Should Be Visible    //input[@id='promotionPrice1-1']
    Element Should Be Visible    //input[@id='quota1-1']

Wow Extra Variant Management Section Should Be Enabled
    Element Should Be Enabled    ${VARIANT-SELECTOR-OPEN-BUTTON}
    Element Should Be Enabled    //*[@id='productDeleteBtn1']
    Element Should Be Enabled    //*[@id='variantDeleteBtn1-1']
    Element Should Be Visible    //input[@id='promotionPrice1-1']

Create Flash Sale Wow Banner with Variant Selector
    [Arguments]    ${app_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${limit_to_buy_type}=PREDEFINED
    ...    ${payment_channel}=all    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0
    ...    ${end_minute}=00    ${status}=disable    ${apply_with}=both    ${upload_img_boolean}=${true}    ${product_variant}=@{VALID-FLASH-SALE-VARIANT}[7]    ${promotion_price}=1500
    ...    ${quota}=1
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Go To Create Flash Sale Page
    Go To Create Wow Banner Page
    Sleep    1s
    Select Flash Sale App ID    ${app_id}
    Input Flash Sale Information    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}    ${payment_channel}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Run Keyword If    ${upload_img_boolean}    Run Keywords    Upload Image to Wow Banner Image Today Desktop
    ...    AND    Upload Image to Wow Banner Image Today Desktop Translation
    ...    AND    Upload Image to Wow Banner Image Today Mobile
    ...    AND    Upload Image to Wow Banner Image Today Mobile Translation
    ...    AND    Upload Image to Wow Banner Image Tomorrow Desktop
    ...    AND    Upload Image to Wow Banner Image Tomorrow Desktop Translation
    ...    AND    Upload Image to Wow Banner Image Tomorrow Mobile
    ...    AND    Upload Image to Wow Banner Image Tomorrow Mobile Translation
    ...    AND    Upload Image to Wow Banner Image Incoming Desktop
    ...    AND    Upload Image to Wow Banner Image Incoming Desktop Translation
    ...    AND    Upload Image to Wow Banner Image Incoming Mobile
    ...    AND    Upload Image to Wow Banner Image Incoming Mobile Translation
    Select Variants By Variant Selector    ${product_variant}    1
    Submit To Create or Update Flash Sale


Create Flash Sale Wow Extra with Variant Selector
    [Arguments]    ${app_id}    ${name}    ${name_trans}=${EMPTY}    ${short_desc}=${VALID-SHORT-PROMO-DESC}    ${short_desc_trans}=${EMPTY}    ${limit}=1    ${limit_to_buy_type}=PREDEFINED
    ...    ${payment_channel}=all    ${start_date}=${EMPTY}    ${start_hour}=0    ${start_minute}=00    ${end_date}=${EMPTY}    ${end_hour}=0
    ...    ${end_minute}=00    ${status}=disable    ${apply_with}=both    ${partner}=@{VALID-FLASH-SALE-PARTNER}[2]    ${upload_img_boolean}=${true}    ${product_variant}=@{VALID-FLASH-SALE-VARIANT}[8]
    ...    ${promotion_price}=1500
    ${name}=    Get First Word From Sentence    ${name}
    ${name_trans}=    Get First Word From Sentence    ${name_trans}
    Go To Create Flash Sale Page
    Go To Create Wow Extra Page
    Select Flash Sale App ID    ${app_id}
    Input Flash Sale Information    ${name}    ${name_trans}    ${short_desc}    ${short_desc_trans}    ${limit}    ${limit_to_buy_type}    ${payment_channel}
    ...    ${start_date}    ${start_hour}    ${start_minute}    ${end_date}    ${end_hour}    ${end_minute}
    ...    ${status}    ${apply_with}
    Select From List    ${FS-WE-PARTNER-SELECT}    ${partner}
    Select Variants By Variant Selector    ${product_variant}
    Submit To Create or Update Flash Sale

Select Variants By Variant Selector
    [Arguments]    ${product_variant}    ${quota}=0
    Click Element    ${VARIANT-SELECTOR-OPEN-BUTTON}
    Wait Until Page Contains Variant Selector Table
    : For    ${item}    IN    @{product_variant}
    \    Select Variant in Variant Selector   ${item}
    Submit Selected Variant
    Wait Until Page Contains Element    ${CREATE-BUTTON}    ${g_loading_delay}
    ${length}=    Get Length    ${product_variant}
    ${length}=    Evaluate    ${length} +1
    ${product}=    Set Variable    1
    : For    ${item}    IN    @{product_variant}
    \    ${variants}=    Get From Dictionary    ${item}    variant
    \    Input promotions price and quota for flash sale    ${product}    ${variants}    ${quota}
    \    ${product}=    Evaluate    ${product} +1

Input promotions price and quota for flash sale
    [Arguments]    ${product_index}    ${variants}    ${quota}=0
    ${len}=    Get Length    ${variants}
    ${len}=    Evaluate    ${len} +1
    : For    ${index}    IN Range    1    ${len}
    \    Input Text    //*[@id='promotionPrice${product_index}-${index}']    1
    \    Run Keyword IF    '${quota}' != '0'    Input Text    //*[@id='quota${product_index}-${index}']    ${quota}

Select Variant in Variant Selector
    [Arguments]    ${variant_index}
    ${name}=    Get From Dictionary    ${variant_index}    name
    ${variants}=    Get From Dictionary    ${variant_index}    variant
    Search Products by Product Name    ${name}
    : For    ${item}    IN    @{variants}
    \    Select Variant for Flash Sale    1    ${item}

Verify Confirmation Page for Flash Sale With Duplicated Product
    [Arguments]    ${action}    ${expected_duplicate_variant_promotion}
    ${duplicate_variants}=    Get Dictionary Keys    ${expected_duplicate_variant_promotion}
    # .. A, B, C
    ${variant_list}=    Convert To List    ${duplicate_variants}
    Wait Until Element Is Visible    //div[@class='modal-content']    ${g_loading_delay}
    Page Should Contain Element    ${DUPLICATE-FLASHSALE-PRODUCT-TABLE}
    Page Should Contain    The following Product(s) are already existed in other FlashSale(s) in the same period
    Page Should Contain    Are you sure you want to ${action} this flashsale anyway ?
    Table Cell Should Contain    ${DUPLICATE-FLASHSALE-PRODUCT-TABLE}    1    1    Product Key
    Table Cell Should Contain    ${DUPLICATE-FLASHSALE-PRODUCT-TABLE}    1    2    FlashSale ID(s)
    ${record_row}=    Set Variable    2
    ${actual_duplicate_product_and_id}=    Create Dictionary
    : FOR    ${expected_variant_item}    IN    @{variant_list}
    \    ${actual_variant_item}=    Get Table Cell    ${DUPLICATE-FLASHSALE-PRODUCT-TABLE}    ${record_row}    1
    \    ${actual_duplicate_promotion_for_each_variant}=    Get Table Cell    ${DUPLICATE-FLASHSALE-PRODUCT-TABLE}    ${record_row}    2
    \    Set to Dictionary    ${actual_duplicate_product_and_id}    ${actual_variant_item}=${actual_duplicate_promotion_for_each_variant}
    \    ${record_row}=    Evaluate    ${record_row}+1
    Dictionaries Should Be Equal    ${expected_duplicate_variant_promotion}    ${actual_duplicate_product_and_id}

Cancel To Create or Update Flash Sale With Duplicated Product
    Cancel At Modal Page

Confirm To Create or Update Flash Sale With Duplicated Product
    Confirm At Modal Page

Delete Product From Product Variant Table
    [Arguments]    ${product_index}
    ${len}=    Get Length    ${product_index}
    : For    ${index}    IN RANGE    ${len}    0    -1
    \    Click Element   //*[@id='productDeleteBtn${index}']

Wait Until Page Contain Product Variant Table is Visible
    Wait Until Page Contains Element    ${FLASH-SALE-SELECTED-VARIANT-LIST-TABLE}    ${g_loading_delay}
