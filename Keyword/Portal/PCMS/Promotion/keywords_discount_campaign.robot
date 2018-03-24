*** Settings ***
Library           Selenium2Library
# Library           ${CURDIR}/../../../../Python_Library/common.py
# Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
# Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Library           String
Library           Collections
Resource          ${CURDIR}/web_element_discount_campaign.robot

*** Variables ***
@{discount_type_variable}    discount    wow

*** Keywords ***
Discount campaign - Go to Discount campaigns menu
    Go To     ${PCMS_URL}/discount-campaigns

Discount campaign - Go to Create campaign page
    Go To     ${PCMS_URL}/discount-campaigns/create

Discount campaign - User select app
    [Arguments]    ${app_name}
    Click Element    ${app}/option[text()="${app_name}"]

Discount campaign - User select discount type
    Select Radio Button    type    flash_sale

Discount campaign - User select everyday wow type
    Select Radio Button    type    itruemart_tv

Discount campaign - User select icon type
    [Arguments]    ${icon_type_name}
    Click Element    ${selected_icon_type}/option[text()="${icon_type_name}"]

Discount campaign - User input text code
    [Arguments]    ${text_code}
    Input Text    ${textbox_code}     ${text_code}

Discount campaign - User input campaign name
    [Arguments]    ${text_name}
    Input Text    ${textbox_name}     ${text_name}

Discount campaign - User input discription
    [Arguments]     ${text_description}
    Input Text    ${textbox_description}     ${text_description}

Discount campaign - User input discount
    [Arguments]    ${text_discount}
    Input Text     ${textbox_discount}    ${text_discount}

Discount campaign - User select discount value type
    [Arguments]    ${text_discount_type}
    Click Element    ${selected_discount_type}/option[@value="${text_discount_type}"]

Discount campaign - User select period campaign
    [Arguments]    ${date_start}    ${date_end}
    Click Element    ${period_start_date}
    Sleep    2s
    input Text     ${period_start_date}    ${date_start}
    Click Element    //*[@id="ui-datepicker-div"]/div[3]/button[text()="Done"]
    Click Element     ${period_end_date}
    Sleep    2s
    input Text     ${period_end_date}    ${date_end}
    Click Element    //*[@id="ui-datepicker-div"]/div[3]/button[text()="Done"]

Discount campaign - User click submit to create campaign
    Click Element    ${btn_create_campaign}

Discount campaign - User click discount product button
    [Arguments]    ${campaign_name}
    ${button}=    Replace String Using Regexp    ${btn_discount_products}    \\?\\?.+\\?\\?    ${campaign_name}
    Click Element    ${button}

Discount campaign - User click Edit Campaign button
    [Arguments]    ${campaign_name}
    ${button}=    Replace String Using Regexp    ${btn_edit_campaign}    \\?\\?.+\\?\\?    ${campaign_name}
    Click Element    ${button}

Discount campaign - User click Delete Campaign button
    [Arguments]    ${campaign_name}
    ${button}=    Replace String Using Regexp    ${btn_delete_campaign}    \\?\\?.+\\?\\?    ${campaign_name}
    Click Element    ${button}

Discount campaign - Should Delete Campaign Success
    Page Should Contain    ${delete_campaign_success}

Discount campaign - User click add items
    Click Element    ${btn_add_item}

Discount campaign - User search product name
    [Arguments]    ${product_name}
    Input Text    ${product_field}    ${product_name}
    Click Element    ${search_button}
    Wait Until Page Contains Element    ${table_product_1}

Discount campaign - User search product name in campaign
    [Arguments]    ${product_name}
    Input Text    ${product_field}    ${product_name}
    Click Element    ${search_product_button}
    Wait Until Page Contains Element    ${table_product_1}

Discount campaign - Save Product Detail
    Click Element    ${save_button}
    Wait Until Page Contains    Updated successful

Discount campaign - Select Products to Campaign
    [Arguments]    ${products}
    : For    ${product}    IN    @{products}
    \    Click Element    ${add_item_button}
    \    Discount campaign - User search product name    ${product}
    \    Click Element    ${add_to_campaign_button}
    \    Capture Page Screenshot
    \    Click Element    ${submit_button}
    \    Wait Until Page Contains    ${product}
    \    Discount campaign - Save Product Detail

Discount campaign - Select Products to Wow Campaign
    [Arguments]    ${products}    ${quota}=1
    : For    ${product}    IN    @{products}
    \    Click Element    ${add_item_button}
    \    Discount campaign - User search product name    ${product}
    \    Click Element    ${add_to_campaign_button}
    \    Capture Page Screenshot
    \    Click Element    ${submit_button}
    \    Wait Until Page Contains    ${product}
    \    Wait Until Element Is Visible   ${quota_field}   20s
    \    Wait Until Element Is Visible   //span[contains(@class,'pre_discount')]   20s
    \    Sleep  2
    \    Input Text    ${quota_field}    ${quota}
    \    Input Text    ${quota_field}    ${quota}
    \    Discount campaign - Save Product Detail

Discount campaign - Select Variant to Wow Campaign by Inventory ID
    [Arguments]    ${inv_id}   ${quota}=1

    ${product_name}=   get_product_name   ${inv_id}
    Click Element    ${add_item_button}
    Discount campaign - User search product name    ${product_name}
    Click Element    ${add_to_campaign_button}
    Capture Page Screenshot
    Click Element    ${submit_button}
    Wait Until Page Contains    ${product_name}
    Wait Until Element Is Visible   ${quota_field}   20s
    Wait Until Element Is Visible   //span[contains(@class,'pre_discount')]   20s

    ${new_added_variants}=   Get Matching Xpath Count   ${new_added_product_variant_inv}
    : For   ${x}   IN RANGE   ${new_added_variants}
    \    ${count_new_added_variants}=   Get Matching Xpath Count   ${new_added_product_variant_inv}
    \    ${row}=   Evaluate   ${new_added_variants}-${x}
    \    ${variant_inv_id}=   Get Value   ${new_added_product_variant_row}[${row}]${new_added_product_variant_inv}
    \    Continue For Loop If   '${variant_inv_id}' == '${inv_id}'
    \    Wait Until Element Is Visible   //span[contains(@class,'pre_discount')]   20s
    \    Wait Until Element Is Visible   ${new_added_product_variant_row}[${row}]${new_added_product_variant_inv}/parent::*/a[contains(@class,"remove")]   20s
    \    Click Element                   ${new_added_product_variant_row}[${row}]${new_added_product_variant_inv}/parent::*/a[contains(@class,"remove")]
    \    Wait Until Element Is Not Visible   ${new_added_product_variant_row}[${count_new_added_variants}]${new_added_product_variant_inv}/parent::*/a[contains(@class,"remove")]   20s
    Wait Until Element Is Not Visible   //*[contains(@name,"added-variants") and contains(@name,"[inventory_id]") and not(@value="${inv_id}")]/parent::*/a[contains(@class,"remove")]   20s
    Sleep  4
    Input Text    ${quota_field}    ${quota}
    Input Text    ${quota_field}    ${quota}
    Discount campaign - Save Product Detail

Discount campaign - Edit Products Discount by SKU(s) detail
    [Arguments]    ${skus_detail}
    : For    ${sku}    IN    @{skus_detail}
    \    ${s_name}=    Get From Dictionary    ${sku}    name
    \    ${s_value}=    Get From Dictionary    ${sku}    discount_value
    \    ${s_type}=    Get From Dictionary    ${sku}    discount_type
    \    ${value_input_field}=    Replace String Using Regexp    ${sku_variant_discount_value}    \\?\\?.+\\?\\?    ${s_name}
    \    ${value_input_type}=    Replace String Using Regexp    ${sku_variant_discount_type}    \\?\\?.+\\?\\?    ${s_name}
    \    Wait Until Element is Visible    ${value_input_field}
    \    Wait Until Element is Visible    ${value_input_type}
    \    Input Text    ${value_input_field}    ${s_value}
    \    Click Element    ${value_input_type}/option[@value="${s_type}"]
    Discount campaign - Save Product Detail

Discount campaign - Input Campaign Detail
    [Arguments]    ${app}    ${discount_type}    ${icon}    ${code}    ${name}    ${description}
    ...    ${discount}    ${discount_value_type}    ${start}    ${end}

    Discount campaign - User select app    ${app}
    Run Keyword If    '@{discount_type_variable}[0]' == '${discount_type}'    Discount campaign - User select discount type
    ...    ELSE    Discount campaign - User select everyday wow type
    Run Keyword If    '@{discount_type_variable}[1]' == '${discount_type}'    Discount campaign - Upload Banner
    Discount campaign - User select icon type    ${icon}
    Discount campaign - User input text code    ${code}
    Discount campaign - User input campaign name    ${name}
    Discount campaign - User input discription    ${description}
    Discount campaign - User input discount    ${discount}
    Discount campaign - User select discount value type    ${discount_value_type}
    Discount campaign - User select period campaign    ${start}    ${end}
    Discount campaign - User Click Submit to create campaign

Discount campaign - Upload Banner
    Discount campaign - Tomorrow Banner Web
    Discount campaign - Today Banner Web
    Discount campaign - Incoming Banner Web

Discount campaign - Tomorrow Banner Web
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${browse_banner_web_tomorrow}    ${canonical_path}
    Sleep    1s

Discount campaign - Today Banner Web
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${browse_banner_web_today}    ${canonical_path}
    Sleep    1s
Discount campaign - Incoming Banner Web
    [Arguments]    ${image}=${RESOURCE-IMAGE-PATH}/610x290.png
    ${canonical_path}=    common.Get Canonical Path    ${image}
    Choose File    ${browse_banner_web_incoming}    ${canonical_path}
    Sleep    1s

Discount campaign - Wait Until Page Contains Discount Product Campaigns Table
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Page Contains Element    ${discount_campaign_table}    ${wait_time}

Discount campaign - Get Campaign ID from Campaign Name
    [Arguments]    ${camp_name}
    Discount campaign - User click discount product button    ${camp_name}
    ${location}=    Get Location
    ${camp_id}=     Get Regexp Matches    ${location}    list\/(.+)    1
    Return From Keyword    @{camp_id}[0]

Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail
    [Arguments]    ${skus_detail}
    ${table_row}=    Set Variable    0
    : For    ${sku}    IN    @{skus_detail}
    \    ${table_row}=    Evaluate    ${table_row}+2
    \    ${s_name}=    Get From Dictionary    ${sku}    name
    \    ${s_net_price}=    Get From Dictionary    ${sku}    net_price
    \    ${s_special_price}=    Get From Dictionary    ${sku}    special_price
    \    ${s_value}=    Get From Dictionary    ${sku}    discount_value
    \    ${s_type}=    Get From Dictionary    ${sku}    discount_type
    \    ${s_price}=    Get From Dictionary    ${sku}    price
    \    ${actual_name}=    Get Text    ${discount_product_table}/tbody/tr[${table_row}]/td[1]
    \    ${actual_net_price}=    Get Text    ${discount_product_table}/tbody/tr[${table_row}]/td[2]
    \    ${actual_special_price}=    Get Text    ${discount_product_table}/tbody/tr[${table_row}]/td[3]
    \    ${actual_discount_value}=    Get Value    ${discount_product_table}/tbody/tr[${table_row}]/td[4]/input
    \    ${actual_discount_type}=    Get Value    ${discount_product_table}/tbody/tr[${table_row}]/td[4]/select
    \    ${actual_price}=    Get Text    ${discount_product_table}/tbody/tr[${table_row}]/td[5]
    \    Should Be Equal    ${s_name}    ${actual_name}
    \    Should Be Equal As Numbers    ${s_net_price}    ${actual_net_price}
#    \    Run Keyword If    "${s_special_price}" == "${EMPTY}"    Should Be Equal    -    ${actual_special_price}
    \    Run Keyword If    "${s_special_price}" == "${EMPTY}"    Should Be Equal    ${EMPTY}    ${actual_special_price}
    \    ...    ELSE    Should Be Equal As Numbers    ${s_special_price}    ${actual_special_price}
    \    Should Be Equal As Numbers    ${s_value}    ${actual_discount_value}
    \    Should Be Equal    ${s_type}    ${actual_discount_type}
    \    Should Be Equal As Numbers    ${s_price}    ${actual_price}

Discount campaign - Wait Until Page Contains Discount Product Table
    [Arguments]    ${wait_time}=${g_loading_delay}
    Wait Until Page Contains Element    ${discount_product_table}    ${wait_time}

Discount campaign - User search campaign name
    [Arguments]    ${campaign_name}
    Input Text    ${textbox_search}    ${campaign_name}
    ${button}=    Replace String Using Regexp    ${btn_delete_campaign}    \\?\\?.+\\?\\?    ${campaign_name}
    Wait Until Element Is Visible    ${button}