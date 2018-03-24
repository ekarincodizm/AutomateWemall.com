*** Settings ***

Library           Selenium2Library
Resource          ${CURDIR}/../../../../Resource/init.robot
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/product.py
Library           ${CURDIR}/../../../../Python_Library/promotion.py
Library           ${CURDIR}/../../../../Python_Library/excel.py
Library           ${CURDIR}/../../../../Python_Library/promotion_code.py
Resource          ${CURDIR}/../../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/Promotion/WebElement_Promotion.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/Promotion/keywords_promotion.robot
*** Variables ***

# Navigation on Side Bar
${xpath-product-navigation}    xpath=//div[@id="mws-navigation"]/ul/li/a[contains(text(),'Product')]
${xpath-promotion-navigation}    xpath=//div[@id="mws-navigation"]/ul/li/a[contains(text(),'Promotion')]

# Sub-menu in Navigation on Side Bar
${xpath-set-shipping}    xpath=//a[contains(@href, "/products/set-shipping")]
${xpath-set-payment}    xpath=//a[contains(@href, "/products/set-payment")]
${xpath-campaigns}    xpath=//a[contains(@href, "/campaigns")]

# On PCMS Product: Set Payment
${xpath-set-payment-first-edit-button}    xpath=//a[contains(@href, "/products/set-payment/edit")][1]

# On PCMS Product: Set Shipping Data
${xpath-set-shipping-first-edit-button}    xpath=//a[contains(@href, "/products/set-shipping/edit")][1]

# On PCMS Promotion: Manage Campaigns
${xpath-create-campaign-button}     xpath=//a[contains(@href, "/campaigns/create")]
${xpath-search-field}   xpath=//label[contains(text(),'Search')]/input[@type="text"]
${xpath-first-promotion-button}     xpath=//tbody/tr[1]/td/div/a[contains(@href, "/promotions")]
${xpath-create-promotion-button}        xpath=//a[contains(@href, "/promotions/create")]

# On Create Promotion
${xpath-first-view-button}  xpath=//a[contains(@href, "/promotions/view")][1]
${xpath-first-edit-button}  xpath=//a[contains(@href, "/promotions/edit")][1]
${promo_group}                  id=promotion_group
${promotion_group_label}        id=promotion_group_label


# On Promotion View
${xpath-code-text}  xpath=//table[@class="coupon-list"]/tbody/tr[1]/td[1]

# iFrame
${iframe-brand}     xpath=//iframe[contains(@src,'/products/search/popup/brand')]
${iframe-collection}    xpath=//iframe[contains(@src,'/products/search/popup/collection')]
${iframe-exclude-product}   xpath=//iframe[contains(@src,'/products/search/popup/exclude-product')]

# On popup
${xpath-add-checkbox}   xpath=//input[@class="add-products"][1]
${xpath-add-checkbox-bundle}   xpath=//input[@class="products-all"][1]
${xpath-text-field}     xpath=//input[@type="text"]

# date picker
${xpath-datepicker-prev-button}     xpath=//a[contains(@class,"ui-datepicker-prev")]
${xpath-datepicker-next-button}     xpath=//a[contains(@class,"ui-datepicker-next")]
${xpath-datepicker-day-15}  xpath=//td[@data-handler="selectDay"]/a[contains(text(),'15')]
${xpath-start-period}       xpath=//*[@name="start_date"]
${xpath-end-period}       xpath=//*[@name="end_date"]

# User Auth
${pcms-user}    admin@domain.com
${pcms-password}    12345
${xpath-login-button}    xpath=//*[contains(@class,"mws-login-button")]

# General Button
${xpath-search-button}    xpath=//input[@value="Search"]
${xpath-save-button}    xpath=//input[@value="Save"]
${xpath-add-button}     xpath=//input[@value="Add"]
${xpath-exclude-button}     xpath=//input[@value="Exclude"][1]


# ROBOT FIX VALUE
${CAMPAIGN_ROBOT_NAME}      Robot Testing Data
${PROMOTION_NAME_BY_ALL_CART}   Robot Code by All Cart
${PROMOTION_NAME_BY_VARIANT}   Robot Code by Variant
${PROMOTION_NAME_BY_PRODUCT_EXCL_VARIANT}   Robot Code by Product Exclude Variant
${PROMOTION_NAME_BY_BRAND_EXCL_PRODUCT}     Robot Code by Brand Exclude Product
${PROMOTION_NAME_BY_COLLECTION_EXCL_PRODUCT}    Robot Code by Collection Exclude Product
${ROBOT_CODE_PREFIX}    ROBOT

${COUNT}         count
${USED_TIMES}     used_times

# Set Payment Method And Installment
${xpath-payment-method-container}     //div[contains(@class, "payment-method")]/div[@class="mws-panel-body"]


${xpath-payment-method-installment}         ${xpath-payment-method-container}/label[3]/input
${xpath-payment-method-atm}                 ${xpath-payment-method-container}/label[4]/input
${xpath-payment-method-ibanking}            ${xpath-payment-method-container}/label[5]/input
${xpath-payment-method-bank-transfer}       ${xpath-payment-method-container}/label[6]/input
${xpath-payment-method-counter-service}     ${xpath-payment-method-container}/label[7]/input

${xpath-bank-installment-container}     //div[contains(@class, "bank-installment")][1]/div[@class="mws-panel-body"]
${xpath-installment-allow-promotion-container}      //div[contains(@class, "bank-installment")][2]/div[@class="mws-panel-body"]

${xpath-allow-promotion}    name=allow_promotion

${xpath-set-payment-save-button}      //div[contains(@class, "bank-installment")][2]/div[contains(@class, "mws-panel-body")][2]/div/div/input

${xpath-set-payment-save-button-no-installment}      //div[contains(@class, "payment-method")]/div[contains(@class, "mws-panel-body")][2]/div/div/input

#Create Promotion Multiple Single Code
${xpath-radio-single-code-unlimited}          //input[@id="radio_single_code_unlimited"]
${xpath-radio-vip-code-unlimited}          //input[@id="radio_vip_code_unlimited"]
${xpath-radio-single-code-limited}          //input[@id="radio_single_code_limited"]
${xpath-radio-vip-code-limited}          //input[@id="radio_vip_code_limited"]
${xpath-radio-single-code-limited-textbox}      //input[@id="text_single_code_time_per_user"]
${xpath-radio-vip-code-limited-textbox}      //input[@id="text_vip_code_time_per_user"]
${xpath-textbox-random-number-prefix}       //input[@class="ssmall multiple_code-end_with pcms-numeric"]

#

#Edit Promotion
${edit-code-button}     //a[@id="input_code"]
${edit-avaliable-button}     //a[@id="input_avaliable"]
${edit-code-textbox}    //input[@name="code"][@class="input-small"]
${edit-avaliable-textbox}    //input[@name="avaliable"][@class="input-small"]
${edit-remark-textbox}    //textarea[@name="remark_code"]
${edit-remark-avaliable-textbox}    //textarea[@name="remark_avaliable"]
${save-edit-code}       //button[@class="btn btn-primary editable-submit"]

${radio_budget_type_pc1}        jquery=:radio[name='budget_type'][value='PC1']
${radio_budget_type_pc3}        jquery=:radio[name='budget_type'][value='PC3']
${img_budget_type_pc1}          jquery=#pc1_example_img
${img_budget_type_pc3}          jquery=#pc3_example_img


#Manage Display Promotion
${allow_display_on_web_checkbox}          //input[@id="allow_display_on_web"]
${allow_display_on_thumbnail_checkbox}    //input[@id="allow_display_on_thumbnail"]
${manage_display_button}            //a[@class="btn btn-default manage_display"]
${title_text_th}                    //input[@id="title_text_th"]
${title_text_en}                    //input[@id="title_text_en"]
${code_text_th}                     //input[@id="code_text_th"]
${code_text_en}                     //input[@id="code_text_en"]
${discount_text_th}                 //input[@id="discount_text_th"]
${discount_text_en}                 //input[@id="discount_text_en"]
${preview_zone_th_image}            //*[@id="preview_zone_th"]
${preview_zone_en_image}            //*[@id="preview_zone_en"]
${preview_zone_title_text_th}       //*[@id="preview_zone_title_text_th"]
${preview_zone_title_text_en}       //*[@id="preview_zone_title_text_en"]
${preview_zone_code_text_th}        //*[@id="preview_zone_code_text_th"]
${preview_zone_code_text_en}        //*[@id="preview_zone_code_text_en"]
${preview_zone_discount_text_th}    //*[@id="preview_zone_discount_text_th"]/*[@class="discount_value"]
${preview_zone_discount_text_en}    //*[@id="preview_zone_discount_text_en"]/*[@class="discount_value"]
${preview_zone_discount_type_text_th}    //*[@id="preview_zone_discount_text_th"]/*[@class="discount_type"]
${preview_zone_discount_type_text_en}    //*[@id="preview_zone_discount_text_en"]/*[@class="discount_type"]
${preview_zone_promotion_code_th}   //*[@id="preview_zone_promotion_code_th"]
${preview_zone_promotion_code_en}   //*[@id="preview_zone_promotion_code_en"]
${save_manage_display_button}       //*[@id="save_manage_display_btn"]
${mass_upload_exclude_product_btn}       //*[@id="mass_upload_exclude_product_btn"]
${saved_successfully_message}       //*[@class="alert alert-success"]
${below_section_of_display_on_web}  //*[@class="mws-form-row allow_on_web"]
${label_campaign_name}              //*[@id="label_campaign_name"]
${label_code}                       //*[@id="label_code"]
${label_promotion_name}             //*[@id="label_promotion_name"]
${label_discount}                   //*[@id="label_discount"]
${label_promotion_group}            //*[@id="label_promotion_group"]
${upload_button_on_mass_upload_exclude}     //*[@id="btn_upload"]
${browse_on_mass_upload_exclude}    //*[@class="fileinput-btn btn"]
${back_button_on_mass_upload_exclude}       //*[@id="btn_back"]
${sort_manage_display}              //*[@id="sort"]

*** Keywords ***

GO TO MANAGE CAMPAIGNS
    Wait Until Page Contains Element    ${xpath-promotion-navigation}    60
    Click Element    ${xpath-promotion-navigation}
    Wait Until Page Contains Element    ${xpath-campaigns}     60
    Click Element    ${xpath-campaigns}
Go To Robot Campaign
    [Arguments]     ${campaign-name}=Robot Testing Data
    Go To   ${PCMS_URL}/campaigns
    # GO TO MANAGE CAMPAIGNS
    # Wait Until Page Contains Element    ${xpath-promotion-navigation}    60
    # Click Element    ${xpath-promotion-navigation}
    # Wait Until Page Contains Element    ${xpath-campaigns}     60
    # Click Element    ${xpath-campaigns}
    Wait Until Page Contains Element    ${xpath-search-field}    60
    Input Text    ${xpath-search-field}     ${campaign-name}
    Wait Until Page Contains Element    ${xpath-first-promotion-button}     60
    Click Element    ${xpath-first-promotion-button}
SET PRODUCT ALLOW COD and Availiable Stock
    [Arguments]     ${inv_id}
    ${allow_cod}=    check_allow_cod_by_inventory_id    ${inv_id}
    Run Keyword If    '${allow_cod}' != '1'    SET ALLOW COD     ${inv_id}
    ${stock-data}=  Check Stock By Sku      ${inv_id}
    ${remain}=  Get Json Value  ${stock-data}       /remaining/${inv_id}
    Run Keyword If    '${remain}' < '1'    Adjust Out of Stock By Inventory ID     ${inv_id}   ${stock-data}
    Return From Keyword     ${inv_id}
SET PRODUCT NOT ALLOW COD and Availiable Stock
    [Arguments]     ${inv_id}
    ${allow_cod}=    check_allow_cod_by_inventory_id    ${inv_id}
    Run Keyword If    '${allow_cod}' != '0'    SET NOT ALLOW COD     ${inv_id}
    ${stock-data}=  Check Stock By Sku      ${inv_id}
    ${remain}=  Get Json Value  ${stock-data}       /remaining/${inv_id}
    Run Keyword If    '${remain}' < '1'    Adjust Out of Stock By Inventory ID     ${inv_id}   ${stock-data}
    Return From Keyword     ${inv_id}
SET ALLOW COD
    [Arguments]     ${inv_id}
    Go To Product Set Shipping
    Wait Until Page Contains Element    id=product     60
    ${product_name}=    get_product_name    ${inv_id}
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-shipping-first-edit-button}     60
    Click Element    ${xpath-set-shipping-first-edit-button}
    Wait Until Element Is Visible    name=allow_cod     60
    Select Checkbox    name=allow_cod
    Wait Until Page Contains Element    ${xpath-save-button}     60
    Click Element    ${xpath-save-button}
SET NOT ALLOW COD
    [Arguments]     ${inv_id}
    Go To Product Set Shipping
    Wait Until Page Contains Element    id=product     60
    ${product_name}=    get_product_name    ${inv_id}
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-shipping-first-edit-button}     60
    Click Element    ${xpath-set-shipping-first-edit-button}
    Wait Until Element Is Visible    name=allow_cod     60
    Unselect Checkbox    name=allow_cod
    Wait Until Page Contains Element    ${xpath-save-button}     60
    Click Element    ${xpath-save-button}
Set Up Robot Campaign
    [Arguments]      ${is-create}=Yes   ${del-promotion-in-campaign}=Yes
    Run Keyword If   '${del-promotion-in-campaign}'=='Yes'   remove_campaign    ${CAMPAIGN_ROBOT_NAME}
    Run Keyword If     '${is-create}' == 'Yes'    Set up create campaign
Set up Remove Campaign
    [Arguments]      ${campaign-name}=Robot Testing Data
    Remove Campaign    ${campaign-name}
Set up create campaign
    [Arguments]     ${campaign-name}=Robot Testing Data
    Create Campaign     ${campaign-name}
Create Expired Campaign
    [Arguments]     ${campaign_name}=Robot Expired Campaign
    LOGIN PCMS
    GO TO MANAGE CAMPAIGNS
    Wait Until Element Is Visible    ${xpath-create-campaign-button}     60
    Click Element    ${xpath-create-campaign-button}
    Wait Until Element Is Visible    id=campaign_name     60
    Input Text     id=campaign_name    ${campaign_name}
    Wait Until Element Is Visible    id=start_datepicker     60
    Sleep   3s
    Click Element    id=start_datepicker
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[contains(@class, "ui-datepicker-close")]     60
    Click Element    ${xpath-datepicker-prev-button}
    Sleep    3s
    Click Element    ${xpath-datepicker-prev-button}
    Sleep    3s
    Click Element    xpath=//*[contains(@class, "ui-datepicker-close")]
    Wait Until Element Is Visible    id=end_datepicker     60
    Click Element    id=end_datepicker
    Sleep    3s
    Wait Until Element Is Visible     ${xpath-datepicker-next-button}     60
    Click Element    ${xpath-datepicker-prev-button}
    Sleep    3s
    Wait Until Element Is Visible    ${xpath-datepicker-day-15}
    Click Element    ${xpath-datepicker-day-15}
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[contains(@class, "ui-datepicker-close")]    60
    Sleep     3s
    Click Element    xpath=//*[contains(@class, "ui-datepicker-close")]
    Sleep    3s
    Wait Until Element Is Visible    name=status    60
    Select Radio Button    status    activate
    Wait Until Element Is Visible    ${xpath-save-button}     60
    Click Element    ${xpath-save-button}
    Close Browser

Promotion - Create Campaign
    [Arguments]     ${campaign_name}   ${close_browser}=Yes
    LOGIN PCMS
    GO TO MANAGE CAMPAIGNS
    Wait Until Element Is Visible    ${xpath-create-campaign-button}     60s
    ${click_create}=  Run Keyword And Return Status   Click Element    ${xpath-create-campaign-button}
    Run Keyword If  '${click_create}' == '${False}'   Click Element    ${xpath-create-campaign-button}


    Wait Until Element Is Visible    id=campaign_name     60s
    Input Text     id=campaign_name    ${campaign_name}

    Wemall Common - Wait Until Element Is Visible And Ready   ${XPATH_PCMS_PROMOTION.btn_start_datepicker}
    Wemall Common - Do Again If First Action Is Failed  ${XPATH_PCMS_PROMOTION.btn_start_datepicker}  click

    Wemall Common - Wait Until Element Is Visible And Ready   ${XPATH_PCMS_PROMOTION.btn_close_datepicker}
    Wemall Common - Do Again If First Action Is Failed   ${XPATH_PCMS_PROMOTION.btn_close_datepicker}  click

    Wemall Common - Wait Until Element Is Visible And Ready  ${XPATH_PCMS_PROMOTION.btn_end_datepicker}
    Wemall Common - Do Again If First Action Is Failed  ${XPATH_PCMS_PROMOTION.btn_end_datepicker}  click
    #${click_end}=    Run Keyword And Return Status    Click Element    ${XPATH_PCMS_PROMOTION.btn_end_datepicker}
    #Run Keyword If   '${click_end}' == '${False}'   Click Element  ${XPATH_PCMS_PROMOTION.btn_end_datepicker}

    Wait Until Element Is Visible     ${XPATH_PCMS_PROMOTION.btn_next_datepicker}     60s
    Wait Until Page Contains Element   ${XPATH_PCMS_PROMOTION.btn_next_datepicker}   60s
    ${click_next}=   Run Keyword And Return Status   Click Element   ${XPATH_PCMS_PROMOTION.btn_next_datepicker}
    Run Keyword If  '${click_next}' == '${False}'   Click Element  ${XPATH_PCMS_PROMOTION.btn_next_datepicker}

    Wait Until Element Is Visible    ${xpath-datepicker-day-15}
    Click Element    ${xpath-datepicker-day-15}


    Wemall Common - Wait Until Element Is Visible And Ready  ${XPATH_PCMS_PROMOTION.btn_close_datepicker}

    #Wait Until Element Is Visible    ${XPATH_PCMS_PROMOTION.btn_close_datepicker}   60s
    #Wait Until Page Contains Element   ${XPATH_PCMS_PROMOTION.btn_close_datepicker}  60s
    ${click_close}=   Run Keyword And Return Status   Click Element    ${XPATH_PCMS_PROMOTION.btn_close_datepicker}
    Run Keyword If  '${click_close}' == '${False}'  Click Element  ${XPATH_PCMS_PROMOTION.btn_close_datepicker}

    Wait Until Element Is Visible    name=status    60
    Select Radio Button    status    activate
    Wait Until Element Is Visible    ${xpath-save-button}     60
    Click Element    ${xpath-save-button}
    Run Keyword If  '${close_browser}' == 'Yes'   Close Browser

Create Promotion
    [Arguments]     &{TC}
    ${coupon-price}=    Set Variable    100

    ${key_promo_group_exist}=   Run Keyword And Return Status    Dictionary Should Contain Key   ${TC}   promo_group

    Run Keyword If   '${key_promo_group_exist}' == '${False}'  Set To Dictionary  ${TC}  promo_group=General

    ${start_period}=   Evaluate          $TC.get('start_period','')
    ${end_period}=   Evaluate          $TC.get('end_period','')
    #${status}=   Evaluate          $TC.get('status','active')
    ${status}=   Evaluate          $TC.get('status','activate')
    Fill In Promotion Detail    &{TC}[name]   &{TC}[type]    &{TC}[usetime]     &{TC}[userlimit]     &{TC}[time_per_user]    &{TC}[minimum]     &{TC}[promo_group]      ${start_period}         ${end_period}       ${status}
    Promotion Create Select Discount    &{TC}[dc_type]    &{TC}[dc_value]    &{TC}[dc_maximum]

    ${key_exist}=   Run Keyword And Return Status    Dictionary Should Contain Key   ${TC}   dc_on_exclude_value

    Log To console  key_exist=${key_exist}
    Run Keyword If   '${key_exist}' == '${False}'  Set To Dictionary  ${TC}  dc_on_exclude_value=0




    Log To console  TC=&{TC}

    Promotion Create Select Cart    &{TC}[dc_cart]    &{TC}[dc_on_follow_type]    &{TC}[dc_on_follow_value]     &{TC}[dc_on_exclude_value]

    Promotion Create Put Data For Budget Type    &{TC}[budget]

    Run Keyword If    '&{TC}[card]' != '${EMPTY}'    Promotion Create Select Bank And All Period     &{TC}[card]
    Click Element   ${xpath-save-button}
    Run Keyword If     '&{TC}[type]' == 'vip_code'    Promotion - Import VIP E-Mail
    ${code}=    Get Code From Promotion     &{TC}[name]
    Return From Keyword     ${code}



Create Promotion Error
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = price / percent
    [Arguments]     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0     ${maximum}=0     ${time_per_user}=1    ${user_limit}=unlimited
    #${discount_type_text}=    Set Variable    ${discount_type}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}      ${time_per_user}        ${user_limit}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   cart

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    #Enter Minimum Value Of Order     ${minimum}
    #Enter
    Click Element   ${xpath-save-button}
Create Promotion All Cart
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = price / percent
    [Arguments]     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0     ${maximum}=0    ${time_per_user}=1    ${user_limit}=unlimited
    #${discount_type_text}=    Set Variable    ${discount_type}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}      ${user_limit}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   cart

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Enter Minimum Value Of Order     ${minimum}
    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create VIP Promotion Success
    [Arguments]    ${promotion_name}    ${use_time}=100    ${time_per_user}=2    ${user_limit}="unlimited"
    Input Text    id=name    ${promotion_name}
    Select From List    name=status     activate
    Select Radio Button     conditions[promotion_code][0][format]       vip_code
    Input Text    name=conditions[promotion_code][0][vip_code][used_times]    ${use_time}
    Select Radio Button     conditions[promotion_code][0][vip_code][time_per_user_type]       ${user_limit}
    Run Keyword If    '${user_limit}' == 'limited'    Create VIP Promotion Set Limited Time Per User    ${time_per_user}
    Input Text    id=code_prefix    XYZ
    Input Text    name=conditions[promotion_code][0][end_with]    3
    Select Radio Button    effects[discount][type]    price
    Input Text    id=discount-baht    10
    Select Radio Button    effects[discount][on]    cart
    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done
Create VIP Promotion Success Check Upload Page
    [Arguments]    ${promotion_name}    ${use_time}=100    ${time_per_user}=2    ${user_limit}="unlimited"
    Input Text    id=name    ${promotion_name}
    Select From List    name=status     activate
    Select Radio Button     conditions[promotion_code][0][format]       vip_code
    Input Text    name=conditions[promotion_code][0][vip_code][used_times]    ${use_time}
    Select Radio Button     conditions[promotion_code][0][vip_code][time_per_user_type]       ${user_limit}
    Run Keyword If    '${user_limit}' == 'limited'    Create VIP Promotion Set Limited Time Per User    ${time_per_user}
    Input Text    id=code_prefix    XYZ
    Input Text    name=conditions[promotion_code][0][end_with]    3
    Select Radio Button    effects[discount][type]    price
    Input Text    id=discount-baht    10
    Select Radio Button    effects[discount][on]    cart
    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_4_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
 #    Click Element    id=btn-upload-done
Create VIP Promotion Set Limited Time Per User
    [Arguments]    ${time_per_user}
    Click Element    id=radio_vip_code_limited
    Input Text    name=conditions[promotion_code][0][vip_code][time_per_user]    ${time_per_user}
Create Promotion Fail Do Not Have TimeUser & Do Not Fill Can Be Use Time
    [Arguments]     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0     ${maximum}=0
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Fill In Promotion Detail Single Not Fill Type TimeUser & Can Be UseTime     ${promotion_name}   ${code_type}    ${usetime}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   cart

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Click Element   ${xpath-save-button}
    Page Should Contain         You must set usable time of single code
    Page Should Contain         Please select times/user
Create Promotion Fail Do Not Have TimeUser
    [Arguments]     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0     ${maximum}=0
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Fill In Promotion Detail Single Not Select Type TimeUser    ${promotion_name}   ${code_type}    ${usetime}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   cart

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Click Element   ${xpath-save-button}
    Page Should Contain         Please select times/user
Enter Minimum Value Of Order
    [Arguments]    ${minimum}=0
    Input Text     name=conditions[price][0][minimum]     ${minimum}
Enter Maximum Percent Discount Of Order
    [Arguments]    ${maximum}=0
    Input Text     name=effects[discount][maximum]     ${maximum}
Create Promotion VIP By Variant
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
    [Arguments]     ${inv}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}


    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]  ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   variant
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/variant')]
    ${product_name}=    get_product_name    ${inv}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}
    ${v_pkey}=  get_variant_pkey    ${inv}
    Wait Until Element Is Visible   xpath=//input[@value="${v_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${v_pkey}"]
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Unselect Frame
    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion VIP By Brand
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #    [Arguments]     ${inv1}       ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usetime}=100     ${minimum}=0     ${maximum}=0
    [Arguments]     ${inv1}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="limited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   brand
    Unselect Frame

    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    ${iframe-brand}
    ${brand_name}=  get_brand_name  ${inv1}
    Wait Until Page Contains Element    ${xpath-text-field}     60
    Input Text    ${xpath-text-field}   ${brand_name}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion VIP By Product
 #    [Arguments]     ${inv1}    ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usedtime}=100    ${minimum}=0    ${maximum}=0
    [Arguments]     ${inv1}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   product
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/product')]
    ${product_name}=    get_product_name    ${inv1}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}
    Select Checkbox    ${xpath-add-checkbox}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Unselect Frame
    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion VIP By Collection
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #    [Arguments]        ${inv1}    ${promotion_name}    ${code_type}     ${discount_type}     ${discount_value}    ${usedtime}=100    ${minimum}=0     ${maximum}=0
    [Arguments]     ${inv1}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    Select Radio Button     effects[discount][type]     ${discount_type}

    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Input Text    name=effects[discount][${discount_type_text}]  ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   collection
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Wait Until Element Is Visible    ${iframe-collection}    60
    Select Frame    ${iframe-collection}
    ${collection_id}=    get_collection_id    ${inv1}
    Wait Until Element Is Visible     xpath=//input[@id="ccb${collection_id}"]    60
    Select Checkbox    xpath=//input[@id="ccb${collection_id}"]
    Wait Until Element Is Visible    ${xpath-add-button}
    Click Element    ${xpath-add-button}

    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Wait Until Element Is Visible    ${xpath-save-button}    10S
    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}


Create Promotion VIP By Brand Exclude Product
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #   [Arguments]     ${inv1}     ${inv2}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usetime}=100     ${minimum}=0     ${maximum}=0
    [Arguments]     ${inv1}     ${inv2}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   brand
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    ${iframe-brand}
    ${brand_name}=  get_brand_name  ${inv1}
    Wait Until Page Contains Element    ${xpath-text-field}     60
    Input Text    ${xpath-text-field}   ${brand_name}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Wait Until Page Contains Element    id=effects-exclude_product-following_items-popup     60
    Click Element   id=effects-exclude_product-following_items-popup

    Select Frame    ${iframe-exclude-product}


    #Select Frame     id=iframe-manage-items
    #//*[contains(@src, "/products/search/popup/exclude-product")]
    ${p_pkey}=  get_product_pkey    ${inv2}
    Wait Until Element Is Visible   xpath=//input[@value="${p_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${p_pkey}"]
    Wait Until Page Contains Element    ${xpath-exclude-button}     60
    Click Element   ${xpath-exclude-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}

Create Promotion VIP By Product Exclude Variant
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #   [Arguments]     ${inv1}     ${inv2}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usedtime}=100    ${minimum}=0    ${maximum}=0
    [Arguments]     ${inv1}    ${inv2}      ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   product
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/product')]
    ${product_name}=    get_product_name    ${inv1}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}

    Wait Until Element Is Visible    ${xpath-add-checkbox}     60
    Select Checkbox    ${xpath-add-checkbox}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Wait Until Page Contains Element    id=effects-exclude_variant-following_items-popup     60
    Click Element   id=effects-exclude_variant-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/exclude-variant')]
    ${v_pkey}=  get_variant_pkey    ${inv2}
    Wait Until Element Is Visible   xpath=//input[@value="${v_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${v_pkey}"]
    Wait Until Page Contains Element    ${xpath-exclude-button}     60
    Click Element   ${xpath-exclude-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion VIP By Collection Exclude Product
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
    [Arguments]     ${inv1}    ${inv2}      ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail     ${promotion_name}  ${code_type}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   collection
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Wait Until Element Is Visible    ${iframe-collection}    60
    Select Frame    ${iframe-collection}
    ${collection_id}=    get_collection_id    ${inv1}

    Wait Until Element Is Visible     xpath=//input[@id="ccb${collection_id}"]    60
    Select Checkbox    xpath=//input[@id="ccb${collection_id}"]
    Wait Until Element Is Visible    ${xpath-add-button}
    Click Element    ${xpath-add-button}

    Unselect Frame

    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}


    Wait Until Element Is Visible    id=effects-exclude_product-following_items-popup
    Click Element   id=effects-exclude_product-following_items-popup

    Select Frame    ${iframe-exclude-product}
    ${p_pkey}=  get_product_pkey    ${inv2}
    Wait Until Element Is Visible    xpath=//input[@value="${p_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${p_pkey}"]
    Wait Until Element Is Visible    ${xpath-exclude-button}
    Click Element   ${xpath-exclude-button}

    Unselect Frame
    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Wait Until Element Is Visible    ${xpath-save-button}    10S
    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_2_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion VIP By Bundle
    [Arguments]     ${inv}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}


    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]  ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   bundle
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/bundle')]
    ${product_name}=    get_product_name    ${inv}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}
    ${v_pkey}=  get_variant_pkey    ${inv}
    Wait Until Element Is Visible   xpath=//input[@value="${v_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${v_pkey}"]
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Unselect Frame
    Click Element   ${xpath-save-button}

    Page Should Contain    Import VIP E-Mail

    ${path_to_file}    get_canonical_path    ${CURDIR}/../../Resources/TestData/promotion_vip_email/5_rows_0_duplicate.xlsx
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By Variant
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
    [Arguments]     ${inv}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}


    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]  ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   variant
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/variant')]
    ${product_name}=    get_product_name    ${inv}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}
    ${v_pkey}=  get_variant_pkey    ${inv}
    Wait Until Element Is Visible   xpath=//input[@value="${v_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${v_pkey}"]
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Unselect Frame
    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By 2 Variant
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
    # [Arguments]     ${inv_id1}    ${inv_id2}    ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usedtime}=100    ${minimum}=0    ${maximum}=0
    [Arguments]     ${inv_id1}    ${inv_id2}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
        Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}


    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]  ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   variant
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/variant')]
    ${product_name}=    get_product_name    ${inv_id1}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}
    ${v_pkey1}=  get_variant_pkey    ${inv_id1}
    Wait Until Element Is Visible   xpath=//input[@value="${v_pkey1}"]     60
    Select Checkbox    xpath=//input[@value="${v_pkey1}"]
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/variant')]
    ${product_name2}=    get_product_name   ${inv_id2}
    Wait Until Page Contains Element   id=product      60
    Input Text   id=product    ${product_name2}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element    ${xpath-search-button}
    ${v_pkey2}=    get_variant_pkey    ${inv_id2}

    Log to console     v_pkey2=${v_pkey2}
    Wait Until Element Is Visible   xpath=//input[@value="${v_pkey2}"]     60
    Select Checkbox       xpath=//input[@value="${v_pkey2}"]
    Wait Until Page Contains Element    ${xpath-add-button}      60
    Click Element    ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By Product Exclude Variant
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #   [Arguments]     ${inv1}     ${inv2}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usedtime}=100    ${minimum}=0    ${maximum}=0
    [Arguments]     ${inv1}    ${inv2}      ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   product
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/product')]
    ${product_name}=    get_product_name    ${inv1}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}

    Wait Until Element Is Visible    ${xpath-add-checkbox}     60
    Select Checkbox    ${xpath-add-checkbox}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Wait Until Page Contains Element    id=effects-exclude_variant-following_items-popup     60
    Click Element   id=effects-exclude_variant-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/exclude-variant')]
    ${v_pkey}=  get_variant_pkey    ${inv2}
    Wait Until Element Is Visible   xpath=//input[@value="${v_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${v_pkey}"]
    Wait Until Page Contains Element    ${xpath-exclude-button}     60
    Click Element   ${xpath-exclude-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By Bundle
    [Arguments]     ${inv1}    ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usedtime}=100    ${minimum}=0    ${maximum}=0
    Fill In Promotion Detail    ${promotion_name}   ${code_type}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   bundle
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[@id="iframe-manage-items"]
    ${product_name}=    get_product_name    ${inv1}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}
    Select Checkbox    ${xpath-add-checkbox-bundle}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Unselect Frame
    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By Product
 #    [Arguments]     ${inv1}    ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usedtime}=100    ${minimum}=0    ${maximum}=0
    [Arguments]     ${inv1}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   product
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    //iframe[contains(@src,'/products/search/popup/product')]
    ${product_name}=    get_product_name    ${inv1}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Wait Until Page Contains Element    ${xpath-search-button}     60
    Click Element   ${xpath-search-button}
    Select Checkbox    ${xpath-add-checkbox}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Unselect Frame
    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By Brand Exclude Product
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #   [Arguments]     ${inv1}     ${inv2}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usetime}=100     ${minimum}=0     ${maximum}=0
    [Arguments]     ${inv1}     ${inv2}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   brand
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    ${iframe-brand}
    ${brand_name}=  get_brand_name  ${inv1}
    Wait Until Page Contains Element    ${xpath-text-field}     60
    Input Text    ${xpath-text-field}   ${brand_name}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Wait Until Page Contains Element    id=effects-exclude_product-following_items-popup     60
    Click Element   id=effects-exclude_product-following_items-popup

    Select Frame    ${iframe-exclude-product}


    #Select Frame     id=iframe-manage-items
    #//*[contains(@src, "/products/search/popup/exclude-product")]
    ${p_pkey}=  get_product_pkey    ${inv2}
    Wait Until Element Is Visible   xpath=//input[@value="${p_pkey}"]     60
    Select Checkbox    xpath=//input[@value="${p_pkey}"]
    Wait Until Page Contains Element    ${xpath-exclude-button}     60
    Click Element   ${xpath-exclude-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By Brand
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #    [Arguments]     ${inv1}       ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}     ${usetime}=100     ${minimum}=0     ${maximum}=0
    [Arguments]     ${inv1}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   brand
    Unselect Frame

    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Select Frame    ${iframe-brand}
    ${brand_name}=  get_brand_name  ${inv1}
    Wait Until Page Contains Element    ${xpath-text-field}     60
    Input Text    ${xpath-text-field}   ${brand_name}
    Wait Until Page Contains Element    ${xpath-add-button}     60
    Click Element   ${xpath-add-button}
    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
 ## END OF KEYWORD   Create Promotion By Brand
Create Promotion By Collection Exclude Product
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
    [Arguments]        ${inv1}     ${inv2}     ${promotion_name}    ${code_type}     ${discount_type}     ${discount_value}   ${usedtime}=100    ${minimum}=0    ${maximum}=0
    Fill In Promotion Detail     ${promotion_name}  ${code_type}
    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}
    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   collection
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Wait Until Element Is Visible    ${iframe-collection}    60
    Select Frame    ${iframe-collection}
    ${collection_id}=    get_collection_id    ${inv1}

    Wait Until Element Is Visible     xpath=//input[@id="ccb${collection_id}"]    60
    Select Checkbox    xpath=//input[@id="ccb${collection_id}"]
    Wait Until Element Is Visible    ${xpath-add-button}
    Click Element    ${xpath-add-button}
    Unselect Frame

    Select Radio Button     effects[discount][type]     ${discount_type}
    Input Text    name=effects[discount][${discount_type_text}]     ${discount_value}


    Wait Until Element Is Visible    id=effects-exclude_product-following_items-popup
    Click Element   id=effects-exclude_product-following_items-popup

    Select Frame    ${iframe-exclude-product}
    ${p_pkey}=  get_product_pkey    ${inv2}
    # Wait Until Element Is Visible    xpath=//input[@value="${p_pkey}"]     60
    # Select Checkbox    xpath=//input[@value="${p_pkey}"]
    ${status}  ${message} =  Run Keyword And Ignore Error  Wait Until Element Is Visible    xpath=//input[@value="${p_pkey}"]     30
    Run Keyword If  "${status}" != "FAIL"    Select Checkbox    xpath=//input[@value="${p_pkey}"]

    Wait Until Element Is Visible    ${xpath-exclude-button}
    Click Element   ${xpath-exclude-button}

    Unselect Frame
    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}
    Wait Until Element Is Visible    ${xpath-save-button}    10S
    Click Element   ${xpath-save-button}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Create Promotion By Collection
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
 #    [Arguments]        ${inv1}    ${promotion_name}    ${code_type}     ${discount_type}     ${discount_value}    ${usedtime}=100    ${minimum}=0     ${maximum}=0
    [Arguments]     ${inv1}     ${promotion_name}   ${code_type}    ${discount_type}    ${discount_value}    ${usetime}=100    ${minimum}=0    ${maximum}=0    ${time_per_user}=1    ${user_limit}="unlimited"
    Fill In Promotion Detail    ${promotion_name}   ${code_type}    ${usetime}    ${time_per_user}     ${user_limit}
    Select Radio Button     effects[discount][type]     ${discount_type}

    ${discount_type_text}=    Run Keyword If    '${discount_type}' == 'price'   Set Variable    baht    ELSE    Set Variable    ${discount_type}

    Input Text    name=effects[discount][${discount_type_text}]  ${discount_value}
    Wait Until Page Contains Element    name=effects[discount][on]     60
    Select Radio Button     effects[discount][on]   following
    Wait Until Page Contains Element    name=effects[discount][which]     60
    Select From List    name=effects[discount][which]   collection
    Wait Until Page Contains Element    id=effects-discount-following_items-popup     60
    Click Element   id=effects-discount-following_items-popup

    Wait Until Element Is Visible    ${iframe-collection}    60
    Select Frame    ${iframe-collection}
    ${collection_id}=    get_collection_id    ${inv1}
    Wait Until Element Is Visible     xpath=//input[@id="ccb${collection_id}"]    60
    Select Checkbox    xpath=//input[@id="ccb${collection_id}"]
    Wait Until Element Is Visible    ${xpath-add-button}
    Click Element    ${xpath-add-button}

    Unselect Frame

    Run Keyword If     '${minimum}' != '0'    Enter Minimum Value Of Order    ${minimum}
    Run Keyword If     '${maximum}' != '0' and '${discount_type}' == 'percent'    Enter Maximum Percent Discount Of Order    ${maximum}

    Wait Until Element Is Visible    ${xpath-save-button}    10S
    Click Element   ${xpath-save-button}

    ${code}=    Get Code From Promotion     ${promotion_name}
    Return From Keyword     ${code}
Edit Promotion Code
    [Arguments]         ${new_code}     ${new_quantity}
    Click Element     ${edit-code-button}
    Clear Element Text      ${edit-code-textbox}
    Input Text      ${edit-code-textbox}       ${new_code}
    Input Text      ${edit-remark-textbox}      Remark3
    Click Element       ${save-edit-code}
    Sleep       3s
    Click Element     ${edit-avaliable-button}
    Clear Element Text      ${edit-avaliable-textbox}
    Input Text      ${edit-avaliable-textbox}       ${new_quantity}
    Input Text      ${edit-remark-avaliable-textbox}      Remark4
    Click Element       ${save-edit-code}
    Sleep       3s
Edit Avaliable Code Only
    [Arguments]         ${new_quantity}
    Sleep       3s
    Click Element     ${edit-avaliable-button}
    Clear Element Text      ${edit-avaliable-textbox}
    Input Text      ${edit-avaliable-textbox}       ${new_quantity}
    Input Text      ${edit-remark-avaliable-textbox}      Remark4
    Click Element       ${save-edit-code}
    Sleep       3s
Edit Promotion Code Only
    [Arguments]        ${new_code}
    Click Element     ${edit-code-button}
    Clear Element Text      ${edit-code-textbox}
    Input Text      ${edit-code-textbox}       ${new_code}
    Input Text      ${edit-remark-textbox}      Remark55
    Click Element       ${save-edit-code}
    Sleep       3s
Edit Promotion Code No Remark Code
    [Arguments]         ${new_code}
    Click Element     ${edit-code-button}
    Clear Element Text      ${edit-code-textbox}
    Input Text      ${edit-code-textbox}       ${new_code}
 #    Input Text      ${edit-remark-textbox}      Remark1
    Click Element       ${save-edit-code}
Edit Promotion Code No Remark Avaliable
    [Arguments]         ${new_quantity}
    Click Element     ${edit-avaliable-button}
    Clear Element Text      ${edit-avaliable-textbox}
    Input Text      ${edit-avaliable-textbox}       ${new_quantity}
 #    Input Text      ${edit-remark-avaliable-textbox}      Remark4
    Click Element       ${save-edit-code}
    Sleep       3s
Fill In Promotion Detail
    # ${code_type} = single_code / multiple_code / vip_code
    # ${discount_type} = baht / percent
    # ${promo_group} = general / bundle /mnp
    [Arguments]     ${promotion_name}   ${code_type}    ${usetime}=10       ${user_limit}='unlimited'     ${time_per_user}=1       ${minimum}=0   ${promo_group}=General     ${start_period}=${EMPTY}      ${end_period}=${EMPTY}       ${status}=activate
    ${type}=    Run Keyword If    '${code_type}' == 'single_code' or '${code_type}' == 'vip_code'     Set Variable    ${USED_TIMES}    ELSE    Set Variable    ${COUNT}
    Wait Until Page Contains Element    ${xpath-create-promotion-button}     60
    Click Element    ${xpath-create-promotion-button}
    Wait Until Page Contains Element    id=name     60
    Input Text    id=name    ${promotion_name}
    Log To Console      ${start_period}
    Run Keyword If      '${start_period}' != '${EMPTY}'     Input Text      ${xpath-start-period}     ${start_period}
    Run Keyword If      '${end_period}' != '${EMPTY}'     Input Text      ${xpath-end-period}     ${end_period}

    Click Element   //select[@id="promotion_group"]/option[text()="${promo_group}"]

    Select From List    name=status     ${status}
    Select Radio Button     conditions[promotion_code][0][format]       ${code_type}
    #Select From List By Value    id=promotion_group    ${promo_group}
    Input Text    name=conditions[promotion_code][0][${code_type}][${type}]       ${usetime}
    Run Keyword If    '${code_type}' != 'multiple_code'
    ...    Select Radio Button      conditions[promotion_code][0][${code_type}][time_per_user_type]         ${user_limit}
    Run Keyword If    '${user_limit}' == 'limited' and '${code_type}' == 'single_code'     Input Text      ${xpath-radio-single-code-limited-textbox}     ${time_per_user}
    Run Keyword If    '${user_limit}' == 'limited' and '${code_type}' == 'vip_code'    Input Text      ${xpath-radio-vip-code-limited-textbox}        ${time_per_user}

    #CODE#Select Radio Button    ${group_name_radio_single_code}    ${radio_single_code_unlimited}
    #CODE#Select Radio Button    ${group_name_radio_single_code}    ${radio_single_code_limited}
    #CODE#Input Text    ${textbox_time_per_user}
    Input Text    id=code_prefix    ${ROBOT_CODE_PREFIX}
    Input Text    ${xpath-textbox-random-number-prefix}     3
    Input Text    name=conditions[price][0][minimum]    ${minimum}

Fill In Promotion Detail Single Not Select Type TimeUser
    [Arguments]     ${promotion_name}   ${code_type}    ${usetime}=10       ${time_per_user}=1
    ${type}=    Run Keyword If    '${code_type}' == 'single_code'     Set Variable    ${USED_TIMES}    ELSE    Run Keyword If    '${code_type}' == 'vip_code'     Set Variable    ${USED_TIMES}         ELSE    Set Variable    ${COUNT}
    Wait Until Page Contains Element    ${xpath-create-promotion-button}     60
    Click Element    ${xpath-create-promotion-button}
    Wait Until Page Contains Element    id=name     60
    Input Text    id=name    ${promotion_name}
    Sleep    2
    Select From List    name=status     Activate
    Select Radio Button     conditions[promotion_code][0][format]       ${code_type}
    Input Text    name=conditions[promotion_code][0][${code_type}][${type}]       ${usetime}
    Input Text    id=code_prefix    ${ROBOT_CODE_PREFIX}
Fill In Promotion Detail Single Not Fill Type TimeUser & Can Be UseTime
    [Arguments]     ${promotion_name}   ${code_type}    ${usetime}=10       ${time_per_user}=1
    ${type}=    Run Keyword If    '${code_type}' == 'single_code'    Set Variable    ${USED_TIMES}    ELSE    Set Variable    ${COUNT}
    Wait Until Page Contains Element    ${xpath-create-promotion-button}     60
    Click Element    ${xpath-create-promotion-button}
    Wait Until Page Contains Element    id=name     60
    Input Text    id=name    ${promotion_name}
    Select From List    name=status     activate
    Select Radio Button     conditions[promotion_code][0][format]       ${code_type}
 #    Input Text    name=conditions[promotion_code][0][${code_type}][${type}]      ${usetime}
    Input Text    id=code_prefix    ${ROBOT_CODE_PREFIX}
Fill In Promotion Detail Single Not Input Use Time
    [Arguments]     ${promotion_name}   ${code_type}    ${usetime}=10       ${time_per_user}=1
    ${type}=    Run Keyword If    '${code_type}' == 'single_code'    Set Variable    ${USED_TIMES}    ELSE    Set Variable    ${COUNT}
    Wait Until Page Contains Element    ${xpath-create-promotion-button}     60
    Click Element    ${xpath-create-promotion-button}
    Wait Until Page Contains Element    id=name     60
    Input Text    id=name    ${promotion_name}

    Wait Until Element Is Visible   //select[@name="status"]/option[@value="activate"]
    Select From List    name=status     activate
    Click Element   //select[@name="status"]/option[@value="activate"]

    Select Radio Button     conditions[promotion_code][0][format]       ${code_type}
 #    Input Text    name=conditions[promotion_code][0][${code_type}][${type}]      ${usetime}
    #Select Radio Button         conditions[promotion_code][0][single_code][time_per_user_type]         limited
    Run Keyword If    '${code_type}' == 'single_code'    Select Radio Button         conditions[promotion_code][0][single_code][time_per_user_type]         limited
    Input Text    id=code_prefix    ${ROBOT_CODE_PREFIX}
Fill In Promotion Detail Use Time
    # ${code_type} = single_code / multiple_code
    # ${discount_type} = baht / percent
    [Arguments]     ${promotion_name}   ${code_type}    ${usertime}
    Wait Until Page Contains Element    ${xpath-create-promotion-button}     60
    Click Element    ${xpath-create-promotion-button}
    Wait Until Page Contains Element    id=name     60
    Input Text    id=name    ${promotion_name}
    Select From List    name=status     activate
    Select Radio Button     conditions[promotion_code][0][format]       ${code_type}
    Input Text    name=conditions[promotion_code][0][${code_type}][used_times]   ${usetime}
    Wait Until Element Is Visible   conditions[promotion_code][0][code]
    Select Radio Button     conditions[promotion_code][0][code]   auto
    Click Element   conditions[promotion_code][0][code]
    Input Text    id=code_prefix    ${ROBOT_CODE_PREFIX}
Get Code From Promotion
    [Arguments]     ${promotion_name}
    Wait Until Page Contains Element    ${xpath-search-field}    60
    Input Text    ${xpath-search-field}     ${promotion_name}
    Wait Until Page Contains Element    ${xpath-first-view-button}    60
    ${url}=    Selenium2Library.Get Element Attribute   ${xpath-first-view-button}@href
    Click Element    ${xpath-first-view-button}
    Sleep    3s
    Select Window   url=${url}
    Wait Until Page Contains Element    ${xpath-code-text}  60
    ${code}=    Get Text    ${xpath-code-text}
    Return From Keyword     ${code}
Get Code From Promotion With Edit
    [Arguments]     ${promotion_name}

    Wait Until Page Contains Element    ${xpath-search-field}    60
    Input Text    ${xpath-search-field}     ${promotion_name}
    Wait Until Page Contains Element    ${xpath-first-edit-button}    60
    ${url}= Selenium2Library.Get Element Attribute   ${xpath-first-edit-button}@href
    Click Element    ${xpath-first-edit-button}
    Sleep    10s
    Go to   url=${url}
    Wait Until Page Contains Element    ${xpath-code-text}   60
Get Code From Promotion With Number
    [Arguments]     ${promotion_name}    ${code_no}
    Wait Until Page Contains Element    ${xpath-search-field}    60
    Input Text    ${xpath-search-field}     ${promotion_name}
    Wait Until Page Contains Element    ${xpath-first-view-button}    60
    ${url}= Selenium2Library.Get Element Attribute   ${xpath-first-view-button}@href
    Click Element    ${xpath-first-view-button}
    Select Window   url=${url}
    Wait Until Page Contains Element    ${xpath-code-text}  60
    ${code}=    Get Text    xpath=//table[@class="coupon-list"]/tbody/tr[${code_no}]/td[1]
    Return From Keyword     ${code}

Open Google
    Open Browser     http://www.google.co.th     ${BROWSER}

# Adjust stock by inventory_id
#     [Arguments]     ${inv_id}

#     ${stock-data}=     Check Stock By Sku      ${inv_id}
#     ${remain}=  Get Json Value     ${stock-data}       /remaining/${inv_id}
#     Run Keyword If    '${remain}' < '1'    Adjust Out of Stock By Inventory ID     ${inv_id}   ${stock-data}

Set Product Installment All Bank And All Months
    [Arguments]     ${inv_id}     ${allow_promotion}=1


    ${product_name}=    Get Product Name    ${inv_id}
    Go To Product Set Payment
    Wait Until Page Contains Element    id=product     60

    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}
    Choose All Bank Installment
    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion    ELSE    Not Choose Allow Promotion

    Click Set Payment Save Button
    Sleep    3s
Set Product Installment Some Bank
    [Arguments]    ${inv_id}    ${bank}=None      ${allow_promotion}=1
    ${product_name}=    Get Product name    ${inv_id}
    Go To Product Set Payment
    Wait Until page Contains Element   id=product    60
    Input Text     id=product    ${product_name}
    Click Element    ${xpath-search-button}

    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}

    Choose Some Bank Installment    ${bank}
    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion    ELSE    Not Choose Allow Promotion

    Click Set Payment Save Button
Set Product 2 Items Installment All Bank And All Months
    [Arguments]     ${inv_id1}    ${inv_id2}     ${allow_promotion}=1


    ${product_name}=    Get Product Name    ${inv_id1}
    Go To Product Set Payment
    Wait Until Page Contains Element    id=product     60

    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}
    Choose All Bank Installment
    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion

    Click Set Payment Save Button

    ### Items 2 ###
    ${product_name}=    Get Product Name    ${inv_id2}

    Redirect To Product Set Payment
    Wait Until Page Contains Element    id=product     60


    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}


    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1



    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Select Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    \    Choose All Period Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]


    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion

    Click Set Payment Save Button

 # Set Product Installment Some Bank All Months
 #     [Arguments]    ${inv_id}    @{bank}[0]=1     ${allow_promotion}=1
 #     Log to console    @{bank}
Set Product Payment Channel
    [Arguments]    ${inv_id}    ${payment_channel}

    Go To Product Set Payment
    ${product_name}=    Get Product Name     ${inv_id}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}

    ${has-installment}=    Is Key Exist     ${payment_channel}      installment
    ${has-atm}=    Is Key Exist     ${payment_channel}     atm
    ${has-ibanking}=    Is Key Exist     ${payment_channel}     ibank
    ${has-bank-transfer}=    Is Key Exist     ${payment_channel}     banktrans
    ${has-counter-service}=     Is Key Exist     ${payment_channel}     cs

    Log To Console     has-installment=${has-installment}
    Run Keyword If    '${has-installment}' == 'True'    Choose Payment Method Installment    ELSE    Unchoose Payment Method Installment

    Run Keyword If    '${has-atm}' == 'True'    Choose Payment Method ATM    ELSE   Unchoose Payment Method ATM
    Run Keyword If    '${has-ibanking}' == 'True'    Choose Payment Method Ibanking     ELSE    Unchoose Payment Method IBanking

    Run Keyword If    '${has-bank-transfer}' == 'True'    Choose Payment Method Bank Transfer    ELSE     Unchoose Payment Method Bank Transfer

    Run Keyword If   '${has-counter-service}' == 'True'    Choose Payment Method Counter Service    ELSE    Unchoose Payment Method Counter Service

    Run Keyword If    '${has-installment}' == 'True'    Click Set Payment Save Button    ELSE    Click Set Payment Save Button No Installment
Remove All Payment Channel
    [Arguments]     ${inv_id}

    Go To Product Set Payment
    ${product_name}=    Get Product Name     ${inv_id}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}
    Unchoose Payment Method Installment
    Unchoose Payment Method ATM
    Unchoose Payment Method IBanking
    Unchoose Payment Method Bank Transfer
    Unchoose Payment Method Counter Service
    Click Set Payment Save Button No Installment
Choose Some Bank Installment
    [Arguments]     ${bank}=None

    Log To Console    bank=${bank}

    ${has-kbank}=    Is Key Exist     ${bank}      kbank
    ${has-bay}=    Is Key Exist     ${bank}     bay
    ${has-central}=    Is Key Exist     ${bank}     central
    ${has-firstchoice}=    Is Key Exist     ${bank}     firstchoice
    ${has-lotus}=     Is Key Exist     ${bank}     lotus
    ${has-ktc}=    Is Key Exist      ${bank}     ktc
    ${has-bbl}=    Is Key Exist      ${bank}     bbl

    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Unselect Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]


    Run Keyword If    '${has-kbank}' == 'True'     Select Bank And All Period    1
    Run Keyword If    '${has-bay}' == 'True'     Select Bank And All Period    2
    Run Keyword If    '${has-central}' == 'True'     Select Bank And All Period    3
    Run Keyword If    '${has-firstchoice}' == 'True'     Select Bank And All Period    4
    Run Keyword If    '${has-lotus}' == 'True'     Select Bank And All Period    5
    Run Keyword If    '${has-ktc}' == 'True'     Select Bank And All Period    6
    Run Keyword If    '${has-bbl}' == 'True'     Select Bank And All Period    7
Select Bank And All Period
    [Arguments]      ${index}
    Select Checkbox    ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    Choose All Period Under Bank   ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]
Choose All Bank Installment
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Select Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    \    Choose All Period Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]
Click Set Payment Save Button
    Wait Until Element Is Visible     ${xpath-set-payment-save-button}
    Click Element     ${xpath-set-payment-save-button}
Click Set Payment Save Button No Installment
    Wait Until Element Is Visible    ${xpath-set-payment-save-button-no-installment}
    Click Element     ${xpath-set-payment-save-button-no-installment}

Choose Allow Promotion
    Select Checkbox     ${xpath-allow-promotion}

Not Choose Allow Promotion
    Unselect Checkbox    ${xpath-allow-promotion}

Choose Bank Installment KBank
    Select Checkbox    ${xpath-bank-installment-container}/div[1]/label/input[@type="checkbox"]

Unchoose Bank Installment KBank
    Unselect Checkbox    ${xpath-bank-installment-container}/div[1]/label/input[@type="checkbox"]

Choose Bank Installment Bay
    Select Checkbox    ${xpath-bank-installment-container}/div[2]/label/input[@type="checkbox"]

Unchoose Bank Installment Bay
    Unselect Checkbox    ${xpath-bank-installment-container}/div[2]/label/input[@type="checkbox"]

Choose Bank Installment Central
    Select Checkbox    ${xpath-bank-installment-container}/div[3]/label/input[@type="checkbox"]

Unchoose Bank Installment Central
    Unselect Checkbox    ${xpath-bank-installment-container}/div[3]/label/input[@type="checkbox"]

Choose Bank Installment Firstchoice
    Select Checkbox    ${xpath-bank-installment-container}/div[4]/label/input[@type="checkbox"]

Unchoose Bank Installment Firstchoice
    Unselect Checkbox    ${xpath-bank-installment-container}/div[4]/label/input[@type="checkbox"]

Choose Bank Installment Testco
    Select Checkbox    ${xpath-bank-installment-container}/div[5]/label/input[@type="checkbox"]

Unchoose Bank Installment Testco
    Unselect Checkbox    ${xpath-bank-installment-container}/div[5]/label/input[@type="checkbox"]

Choose Bank Installment KTC
    Select Checkbox    ${xpath-bank-installment-container}/div[6]/label/input[@type="checkbox"]

Unchoose Bank Installment KTC
    Unselect Checkbox    ${xpath-bank-installment-container}/div[6]/label/input[@type="checkbox"]

Choose Bank Installment BBL
    Select Checkbox    ${xpath-bank-installment-container}/div[7]/label/input[@type="checkbox"]

Unchoose Bank Installment BBL
    Unselect Checkbox    ${xpath-bank-installment-container}/div[7]/label/input[@type="checkbox"]

Choose Payment Method Installment
    Select Checkbox     ${xpath-payment-method-installment}

Unchoose Payment Method Installment
    Unselect Checkbox     ${xpath-payment-method-installment}

Choose Payment Method ATM
    Select Checkbox    ${xpath-payment-method-atm}

Unchoose Payment Method ATM
    Unselect Checkbox    ${xpath-payment-method-atm}

Choose Payment Method IBanking
    Select Checkbox    ${xpath-payment-method-ibanking}

Unchoose Payment Method IBanking
    Unselect Checkbox    ${xpath-payment-method-ibanking}

Choose Payment Method Bank Transfer
    Select Checkbox    ${xpath-payment-method-bank-transfer}

Unchoose Payment Method Bank Transfer
    Unselect Checkbox    ${xpath-payment-method-bank-transfer}

Choose Payment Method Counter Service
    Select Checkbox    ${xpath-payment-method-counter-service}

Unchoose Payment Method Counter Service
    Unselect Checkbox    ${xpath-payment-method-counter-service}

Choose All Period Under Bank
    [Arguments]     ${xpath-container}

    ${count-period}=    Get Matching Xpath Count    ${xpath-container}/li
    ${count-period}=    Evaluate    ${count-period} + 1
    Log to console   count-period=${count-period}
    :FOR  ${index}  IN RANGE  1  ${count-period}
    \    Select Checkbox    ${xpath-container}/li[${index}]/label/input[@type="checkbox"]

Choose Period 3 Month Under Bank
    Log to console      period 3 month

Choose Period 6 Month Under Bank
    Log to console      period 6 month

Choose Period 10 Month Under Bank
    Log to console      period 10 month

Split Promotion ID From View
 #    You should be in Promotion page
    ${url}=    Selenium2Library.Get Element Attribute    //a[contains(@href, "/promotions/view")][1]@href
    Click Element    //a[contains(@href, 'promotions/view')]
    Select Window    url=${url}
    ${words} =  Split String    ${url}    ?
    ${words} =  Split String    ${words[0]}    /
    ${promotion_id}=  Set Variable    ${words[5]}
    Return From Keyword      ${promotion_id}

Promotion Create Put Data For Budget Type
    [Arguments]    ${budget_type}
    Run Keyword If    '${budget_type}' == 'PC1'    Click Element    ${radio_budget_type_pc1}
    ...    ELSE IF    '${budget_type}' == 'PC3'    Click Element    ${radio_budget_type_pc3}
    Run Keyword If    '${budget_type}' == 'PC1'    Element Should Be Visible    ${img_budget_type_pc1}
    ...    ELSE IF    '${budget_type}' == 'PC3'    Element Should Be Visible    ${img_budget_type_pc3}


Promotion Create Select Discount
    [Arguments]    ${type}    ${value}    ${maximum}=0
    Select Radio Button     effects[discount][type]    ${type}
    Run Keyword If    '${type}' == 'price'    Input Text    id=discount-baht    ${value}
    Run Keyword If    '${type}' == 'percent'
    ...    Run Keywords    Input Text    id=discount-percent    ${value}
    ...    AND    Input Text    name=effects[discount][maximum]    ${maximum}

Promotion Create Select Cart
    [Arguments]    ${type}    ${Conditions}    ${Value}     ${ExcludeValue}=0

    Log To Console   Value=${Value}
    Select Radio Button     effects[discount][on]    ${type}
    Select From List    jquery=#effect-discount-which    ${Conditions}
    Run Keyword If    '${Conditions}' == 'product'  Promotion Create Select Conditions On Product List    ${Value}
    ...    ELSE IF    '${Conditions}' == 'brand'    Promotion Create Select Conditions on brands    ${Value}
    ...    ELSE IF    '${Conditions}' == 'collection'    Promotion Create Select Conditions on collecitons    ${Value}
    ...    ELSE IF    '${Conditions}' == 'bundle'      Promotion Create Select Conditions on bundle or variant    ${Conditions}    ${Value}
    ...    ELSE IF    '${Conditions}' == 'variant'     Promotion Create Select Conditions on bundle or variant list    ${Conditions}    ${Value}
    Run Keyword IF    '${ExcludeValue}' != '0'        Promotion Create Select Condition on collections with Exclude Item        ${ExcludeValue}

Promotion Create Select Conditions on bundle or variant List
    [Arguments]  ${product_string}
    @{p}=   Split String   ${product_string}   ,
    :FOR  ${index}  IN  @{p}
    \  Promotion Create Select Conditions on bundle or variant   variant  ${index}

Promotion Create Select Conditions On Product List
    [Arguments]   ${product_string}
    @{p}=   Split String   ${product_string}   ,
    :FOR  ${index}  IN  @{p}
    \  Promotion Create Select Conditions on product  ${index}


Promotion Create Select Conditions on brands
    [Arguments]    ${Value}
    Click Element    ${btn_browse_conditions}
    Select Frame    ${iframe_condition}
    Wait Until Page Contains Element    ${dd_condition_brands}    60s
    Wait Until Page Contains Element    ${btn_condition_add}
    Click Element    ${dd_condition_brands_expand}
    Click Element    jquery=li.ui-menu-item a.ui-corner-all:contains(${Value})
    Click Element    ${btn_condition_add}
    Unselect Frame

Promotion Create Select Conditions on product
    [Arguments]    ${product_name}


    Click Element    ${btn_browse_conditions}
    Select Frame    ${iframe_condition_product}
    Wait Until Page Contains Element    ${bundle_search_name}    60s
    Input Text    ${bundle_search_name}    ${product_name}
    Click Element    ${btn_condition_criteria_search}
    Wait Until Page Contains Element    xpath=//td/strong[.='${product_name}']
    Click Element    xpath=//td/strong[.='${product_name}']/../../td/label/input[@type='checkbox']
    Click Element    ${btn_condition_add}
    Unselect Frame

Promotion Create Select Conditions on collecitons
    [Arguments]    ${collections}
    Click Element    ${btn_browse_conditions}
    Select Frame    ${iframe_condition_collection}
    Wait Until Page Contains Element    ${colletion_header}    60s
    Wait Until Page Contains Element    ${btn_condition_add}
    Click Element    xpath=//label[.='${collections}']/../input[@type='checkbox']
    Click Element    ${btn_condition_add}
    Unselect Frame

Promotion Create Select Condition on collections with Exclude Item
    [Arguments]     ${exclude_item}
    Click Element   id=effects-exclude_product-following_items-popup
    Select Frame    //iframe[contains(@src,'/products/search/popup/exclude-product')]
    Wait Until Element Is Visible   xpath=//input[@value="${exclude_item}"]     60
    Select Checkbox    xpath=//input[@value="${exclude_item}"]
    Wait Until Page Contains Element    ${xpath-exclude-button}     60
    Click Element   ${xpath-exclude-button}
    Unselect Frame


Promotion Create Select Conditions on bundle or variant
    [Arguments]    ${type}    ${product_name}
    Click Element    ${btn_browse_conditions}
    Run Keyword If    '${type}' == 'bundle'     Select Frame    ${iframe_condition_bundle}
    ...    ELSE IF    '${type}' == 'variant'    Select Frame    ${iframe_condition_variant}
    Wait Until Page Contains Element    ${bundle_search_name}    60s
    Input Text    ${bundle_search_name}    ${product_name}
    Click Element    ${btn_condition_criteria_search}
    Wait Until Page Contains Element    xpath=//td/strong[.='${product_name}']
    #
    Click Element    xpath=//td/strong[.='${product_name}']/../../td/label/input[@type='checkbox'][@class='products-all']
    Click Element    ${btn_condition_add}
    Unselect Frame

Promotion Create Select Bank And All Period
    [Arguments]      ${bank}
    Select Checkbox    //input[@type='checkbox'][@id='${bank}']
    Click Element      //a[@id='checkAll${bank}']

Set Promotion Expire
    [Arguments]      ${promotion_name}
    promotion_expire    ${promotion_name}


Promotion - Prepare Promotion Code To Test Variable
    [Arguments]   &{TC}
    ${code}=   Create Promotion   &{TC}
    Wemall Common - Assign Value To Test Variable  code  ${code}

Promotion - Import VIP E-Mail
    # [Arguments]    ${email}
    Page Should Contain    Import VIP E-Mail
    ${path_to_file}    common.get_canonical_path    ${CURDIR}/../../../../Resource/TestData/promotions-vip-email.xlsx
    # ${list}=    create_excel_file_vip_email    ${path_to_file}    ${login_email}
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn-submit-upload
    Wait Until Element Is Visible    id=btn-upload-done     10
    Click Element    id=btn-upload-done

Promotion - Import Excluded Product
    [Arguments]    ${file_name}
    Page Should Contain    Mass Upload Exclude Product Pkey
    ${path_to_file}    common.get_canonical_path    ${CURDIR}/../../../../Resource/TestData/${file_name}
    Wait Until Element Is Visible    //input[@class="fileinput-preview"]    10
    Choose File    file_upload    ${path_to_file}
    Click Element    id=btn_upload

Promotion - Expect Import Excluded Product Success
    Wait Until Element Is Visible    id=success_msg     20
    Page Should Contain    The file is uploaded successfully.

Promotion - Expect Import Excluded Product Fail File type
    Wait Until Element Is Visible    id=error_msg     20
    Page Should Contain    Please upload only CSV file.

Promotion - Expect Import Excluded Product Fail Invalid Data
    Wait Until Element Is Visible    id=error_msg     20
    Page Should Contain    Row 1: Product pkey is invalid. [2442 372811637]
    Page Should Contain    Row 3: Product pkey is invalid. [2442372811]

Promotion - Expect Import Excluded Product Fail Empty Data
    Wait Until Element Is Visible    id=error_msg     20
    Page Should Contain    No product pkey in the file.

Promotion Group is displayed
    Wait Until Element Is Visible   ${promo_group}      10
    Element Should Be Visible       ${promo_group}
    Element Should Contain          ${promotion_group_label}       Promotion Group

Default value is General
    Element Should Be Visible       //*[@id="promotion_group"]/option[@value="1_general" and @selected="selected"]

Values in dropdown are General, Bundle, MNP
    Element Should Contain      ${promo_group}     General
    Element Should Contain      ${promo_group}     Bundle
    Element Should Contain      ${promo_group}     MNP

Manage Display Button Is Displayed
    Page Should Contain Element       ${manage_display_button}

Manage Display Button Is Not Displayed
    Page Should Not Contain Element       ${manage_display_button}

Tick Display on Web Checkbox
    Element Should Be Visible       ${allow_display_on_web_checkbox}
    Select Checkbox                 ${allow_display_on_web_checkbox}

Tick Display on Thumbnail Checkbox
    Element Should Be Visible       ${allow_display_on_thumbnail_checkbox}
    Select Checkbox                 ${allow_display_on_thumbnail_checkbox}

Untick Display on Web Checkbox
    Element Should Be Visible       ${allow_display_on_web_checkbox}
    Unselect Checkbox               ${allow_display_on_web_checkbox}

Untick Display on Thumbnail Checkbox
    Element Should Be Visible       ${allow_display_on_thumbnail_checkbox}
    Unselect Checkbox               ${allow_display_on_thumbnail_checkbox}

Type Title Text in TH
    [Arguments]     ${input_txt}=title textไทย!@#$%^&*()_+
    Element Should Be Visible       ${allow_display_on_web_checkbox}
    Click Element   ${title_text_th}
    Input Text      ${title_text_th}       ${input_txt}

Type Title Text in EN
    [Arguments]     ${input_txt}=title textEN!@#$%^&*()_+
    Element Should Be Visible       ${allow_display_on_web_checkbox}
    Click Element   ${title_text_en}
    Input Text      ${title_text_en}      ${input_txt}

Type Code Text in TH
    [Arguments]     ${input_txt}=codetxtไทย
    Element Should Be Visible       ${allow_display_on_web_checkbox}
    Click Element   ${code_text_th}
    Input Text      ${code_text_th}       ${input_txt}

Type Code Text in EN
    [Arguments]     ${input_txt}=cdtxtEN
     Element Should Be Visible       ${allow_display_on_web_checkbox}
     Click Element  ${code_text_en}
     Input Text     ${code_text_en}      ${input_txt}

Type Discount text in TH
    [Arguments]     ${input_txt}=DiscTไทย
     Element Should Be Visible       ${allow_display_on_web_checkbox}
     Click Element   ${discount_text_th}
     Input Text      ${discount_text_th}      ${input_txt}

Type Discount text in EN
    [Arguments]     ${input_txt}=DiscTEN
     Element Should Be Visible       ${allow_display_on_web_checkbox}
     Click Element      ${discount_text_en}
     Input Text         ${discount_text_en}      ${input_txt}

Type Value in Sort
    [Arguments]     ${input_txt}=2
     Element Should Be Visible       ${allow_display_on_web_checkbox}
     Click Element       ${sort_manage_display}
     Input Text          ${sort_manage_display}         ${input_txt}

Type Valid Number in Sort
     Element Should Be Visible       ${allow_display_on_web_checkbox}
     Click Element       ${sort_manage_display}
     Input Text          ${sort_manage_display}         2

Type Negative Number in Sort
     Element Should Be Visible       ${allow_display_on_web_checkbox}
     Click Element       ${sort_manage_display}
     Input Text          ${sort_manage_display}         -2

Type Character in Sort
     Element Should Be Visible       ${allow_display_on_web_checkbox}
     Click Element       ${sort_manage_display}
     Input Text          ${sort_manage_display}         a1

Type All Code Texts in TH and EN
    [Arguments]   ${titile_text_th_input}=title textไทย!@#$%^&*()_+
     ...    ${titile_text_en_input}=title textEN!@#$%^&*()_+
     ...    ${discount_text_th_input}=codetxtไทย
     ...    ${discount_text_en_input}=cdtxtEN
     ...    ${code_text_th_input}=DiscTไทย
     ...    ${code_text_en_input}=DiscTEN
     ...    ${sort_input}=2
    Type Title Text in TH       ${titile_text_th_input}
    Type Title Text in EN       ${titile_text_en_input}
    Type Code Text in TH        ${code_text_th_input}
    Type Code Text in EN        ${code_text_en_input}
    Type Discount text in TH    ${discount_text_th_input}
    Type Discount text in EN    ${discount_text_en_input}
    Type Value in Sort          ${sort_input}

Click Manage Display Button
    Wait Until Element Is Visible         ${manage_display_button}    20S
    Click Element                         ${manage_display_button}

Display on Web Checkbox Is Ticked
    Wait Until Element Is Visible         ${allow_display_on_web_checkbox}
    ${is_ticked}=    Get Value            ${allow_display_on_web_checkbox}
    Should Be Equal As Numbers            ${is_ticked}   1
    Checkbox Should Be Selected           ${allow_display_on_web_checkbox}

Display on Web Thumbnail Is Ticked
    Wait Until Element Is Visible         ${allow_display_on_thumbnail_checkbox}
    ${is_ticked}=    Get Value            ${allow_display_on_thumbnail_checkbox}
    Should Be Equal As Numbers            ${is_ticked}   1
    Checkbox Should Be Selected           ${allow_display_on_thumbnail_checkbox}

Display on Web Checkbox Is Not Ticked
    Wait Until Element Is Visible         ${allow_display_on_web_checkbox}
    ${is_ticked}=    Get Value            ${allow_display_on_web_checkbox}
    Should Be Equal As Numbers            ${is_ticked}   0
    Checkbox Should Not Be Selected       ${allow_display_on_web_checkbox}

Display on Web Thumbnail Is Not Ticked
    Wait Until Element Is Visible         ${allow_display_on_thumbnail_checkbox}
    ${is_ticked}=    Get Value            ${allow_display_on_thumbnail_checkbox}
    Should Be Equal As Numbers            ${is_ticked}   0
    Checkbox Should Not Be Selected       ${allow_display_on_thumbnail_checkbox}

Click Save on Manage Display Page
    Element Should Be Visible       id=save_manage_display_btn
    Click Element       id=save_manage_display_btn

Preview Code Image Displays For TH
    Page Should Contain Element     ${preview_zone_th_image}

Preview Code Image Displays For EN
    Page Should Contain Element     ${preview_zone_en_image}

Should Display .- at discount text for promo code discounted as baht
    Element Should Contain      ${preview_zone_discount_type_text_th}     .-
    Element Should Contain      ${preview_zone_discount_type_text_en}     .-

Should Display % at discount text for promo code discounted as percent
    Element Should Contain      ${preview_zone_discount_type_text_th}     %
    Element Should Contain      ${preview_zone_discount_type_text_en}     %

Price discount displayed in the preview zone is the same as the created promo code
    [Arguments]     ${baht_from_ui}
    ${expected_baht}=    Get Value    &{TC}[dc_value]
    Should Be Equal As Strings      ${baht_from_ui}      ${expected_baht}

Percent discount displayed in the preview zone is the same as the created promo code
    [Arguments]     ${percent_from_ui}
    ${expected_baht=    Get Value    &{TC}[dc_value]
    Should Be Equal As Strings      ${percent_from_ui}      ${expected_percent}

Should Display Title text TH displayed in the preview zone as expected
    [Arguments]   ${expected_title_text_th}   #expected
    Wait Until Element Is Visible             ${preview_zone_title_text_th}
    ${titile_text_th_preview}=     Get Text   ${preview_zone_title_text_th}
    Should Be Equal As Strings     ${titile_text_th_preview}      ${expected_title_text_th}

Should Display Title text EN displayed in the preview zone as expected
    [Arguments]   ${expected_title_text_en}   #expected
    Wait Until Element Is Visible             ${preview_zone_title_text_en}
    ${titile_text_en_preview}=     Get Text   ${preview_zone_title_text_en}
    Should Be Equal As Strings     ${titile_text_en_preview}      ${expected_title_text_en}

Should Display Discount text TH displayed in the preview zone as expected
    [Arguments]   ${expected_discount_text_th}   #expected
    Wait Until Element Is Visible             ${preview_zone_discount_text_th}
    ${discount_text_th_preview}=   Get Text   ${preview_zone_discount_text_th}
    Should Be Equal As Strings     ${discount_text_th_preview}    ${expected_discount_text_th}

Should Display Discount text EN displayed in the preview zone as expected
    [Arguments]   ${expected_discount_text_en}   #expected
    Wait Until Element Is Visible             ${preview_zone_discount_text_en}
    ${discount_text_en_preview}=   Get Text   ${preview_zone_discount_text_en}
    Should Be Equal As Strings     ${discount_text_en_preview}    ${expected_discount_text_en}

Should Display Code text TH displayed in the preview zone as expected
    [Arguments]   ${expected_code_text_th}   #expected
    Wait Until Element Is Visible             ${preview_zone_code_text_th}
    ${code_text_th_preview}=       Get Text   ${preview_zone_code_text_th}
    Should Be Equal As Strings     ${code_text_th_preview}        ${expected_code_text_th}

Should Display Code text EN displayed in the preview zone as expected
    [Arguments]   ${expected_code_text_en}   #expected
    Wait Until Element Is Visible             ${preview_zone_code_text_en}
    ${code_text_en_preview}=       Get Text   ${preview_zone_code_text_en}
    Should Be Equal As Strings     ${code_text_en_preview}        ${expected_code_text_en}

Entered Number in Sort is saved in DB
    [Arguments]    ${promotion_id}   ${expected_sort}   #expected
    ${sort_ui}=   Get Sort From Promotions Table   ${promotion_id}
    Should Be Equal As Strings     ${sort_ui}      ${expected_sort}

All Text for TH and EN Displays Baht Same As The Previously Input
    [Arguments]   ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}
    Should Display .- at discount text for promo code discounted as baht
    Should Display Title text TH displayed in the textbox as expected      ${titile_text_th_input}
    Should Display Title text EN displayed in the textbox as expected      ${titile_text_en_input}
    Should Display Discount text TH displayed in the textbox as expected   ${discount_text_th_input}
    Should Display Discount text EN displayed in the textbox as expected   ${discount_text_en_input}
    Should Display Code text TH displayed in the textbox as expected       ${code_text_th_input}
    Should Display Code text EN displayed in the textbox as expected       ${code_text_en_input}

All Text for TH and EN Displays Percent Same As The Previously Input
    [Arguments]   ${titile_text_th_input}
     ...    ${titile_text_en_input}
     ...    ${discount_text_th_input}
     ...    ${discount_text_en_input}
     ...    ${code_text_th_input}
     ...    ${code_text_en_input}
    Should Display % at discount text for promo code discounted as percent
    Should Display Title text TH displayed in the textbox as expected      ${titile_text_th_input}
    Should Display Title text EN displayed in the textbox as expected      ${titile_text_en_input}
    Should Display Discount text TH displayed in the textbox as expected   ${discount_text_th_input}
    Should Display Discount text EN displayed in the textbox as expected   ${discount_text_en_input}
    Should Display Code text TH displayed in the textbox as expected       ${code_text_th_input}
    Should Display Code text EN displayed in the textbox as expected       ${code_text_en_input}

Code Image for TH and EN Displays Baht Same As The Created Promotion Previously
    [Arguments]   ${promotion_id}
    Should Display .- at discount text for promo code discounted as baht
    Preview Code Image Displays For TH
    Preview Code Image Displays For EN
    ${promotion_display_translate}=   py_get_promotion_display_on_web_text   ${promotion_id}
    Should Display Title text TH displayed in the preview zone as expected      ${promotion_display_translate['th_TH']['title_text']}
    Should Display Title text EN displayed in the preview zone as expected      ${promotion_display_translate['en_US']['title_text']}
    Should Display Discount text TH displayed in the preview zone as expected   ${promotion_display_translate['th_TH']['discount_text']}
    Should Display Discount text EN displayed in the preview zone as expected   ${promotion_display_translate['en_US']['discount_text']}
    Should Display Code text TH displayed in the preview zone as expected       ${promotion_display_translate['th_TH']['code_text']}
    Should Display Code text EN displayed in the preview zone as expected       ${promotion_display_translate['en_US']['code_text']}

Code Image for TH and EN Displays Percent Same As The Created Promotion Previously
    [Arguments]   ${promotion_id}
    Should Display % at discount text for promo code discounted as percent
    Preview Code Image Displays For TH
    Preview Code Image Displays For EN
    ${promotion_display_translate}=   py_get_promotion_display_on_web_text   ${promotion_id}
    Should Display Title text TH displayed in the preview zone as expected      ${promotion_display_translate['th_TH']['title_text']}
    Should Display Title text EN displayed in the preview zone as expected      ${promotion_display_translate['en_US']['title_text']}
    Should Display Discount text TH displayed in the preview zone as expected   ${promotion_display_translate['th_TH']['discount_text']}
    Should Display Discount text EN displayed in the preview zone as expected   ${promotion_display_translate['en_US']['discount_text']}
    Should Display Code text TH displayed in the preview zone as expected       ${promotion_display_translate['th_TH']['code_text']}
    Should Display Code text EN displayed in the preview zone as expected       ${promotion_display_translate['en_US']['code_text']}

Get Title text TH displayed in the textbox
    Wait Until Element Is Visible              ${title_text_th}
    ${titile_text_th_textbox}=     Get Value   ${title_text_th}
    [Return]     ${titile_text_th_textbox}

Get Title text EN displayed in the textbox
    Wait Until Element Is Visible              ${title_text_en}
    ${titile_text_en_textbox}=     Get Value   ${title_text_en}
    [Return]     ${titile_text_en_textbox}

Get Discount text TH displayed in the textbox
    Wait Until Element Is Visible              ${discount_text_th}
    ${discount_text_th_textbox}=   Get Value   ${discount_text_th}
    [Return]     ${discount_text_th_textbox}

Get Discount text EN displayed in the textbox
    Wait Until Element Is Visible              ${discount_text_en}
    ${discount_text_en_textbox}=   Get Value   ${discount_text_en}
    [Return]     ${discount_text_en_textbox}

Get Code text TH displayed in the textbox
    Wait Until Element Is Visible              ${code_text_th}
    ${code_text_th_textbox}=       Get Value   ${code_text_th}
    [Return]     ${code_text_th_textbox}

Get Code text EN displayed in the textbox
    Wait Until Element Is Visible              ${code_text_en}
    ${code_text_en_textbox}=       Get Value   ${code_text_en}
    [Return]     ${code_text_en_textbox}

Get Sort text displayed in the textbox
    Wait Until Element Is Visible              ${sort_manage_display}
    ${sort_textbox}=               Get Value   ${sort_manage_display}
    [Return]     ${sort_textbox}

Should Display Title text TH displayed in the textbox as expected
    [Arguments]    ${expected_title_text_th}   #expected
    Wait Until Element Is Visible              ${title_text_th}
    ${titile_text_th_textbox}=     Get Value   ${title_text_th}
    Should Be Equal As Strings     ${titile_text_th_textbox}      ${expected_title_text_th}

Should Display Title text EN displayed in the textbox as expected
    [Arguments]    ${expected_title_text_en}   #expected
    Wait Until Element Is Visible              ${title_text_en}
    ${titile_text_en_textbox}=     Get Value   ${title_text_en}
    Should Be Equal As Strings     ${titile_text_en_textbox}      ${expected_title_text_en}

Should Display Discount text TH displayed in the textbox as expected
    [Arguments]    ${expected_discount_text_th}   #expected
    Wait Until Element Is Visible              ${discount_text_th}
    ${discount_text_th_textbox}=   Get Value   ${discount_text_th}
    Should Be Equal As Strings     ${discount_text_th_textbox}      ${expected_discount_text_th}

Should Display Discount text EN displayed in the textbox as expected
    [Arguments]    ${expected_discount_text_en}   #expected
    Wait Until Element Is Visible              ${discount_text_en}
    ${discount_text_en_textbox}=   Get Value   ${discount_text_en}
    Should Be Equal As Strings     ${discount_text_en_textbox}      ${expected_discount_text_en}

Should Display Code text TH displayed in the textbox as expected
    [Arguments]    ${expected_code_text_th}   #expected
    Wait Until Element Is Visible              ${code_text_th}
    ${code_text_th_textbox}=       Get Value   ${code_text_th}
    Should Be Equal As Strings     ${code_text_th_textbox}      ${expected_code_text_th}

Should Display Code text EN displayed in the textbox as expected
    [Arguments]    ${expected_code_text_en}   #expected
    Wait Until Element Is Visible              ${code_text_en}
    ${ocde_text_en_textbox}=       Get Value   ${code_text_en}
    Should Be Equal As Strings     ${ocde_text_en_textbox}      ${expected_code_text_en}

Entered Number in Sort is the same as a user enters previuosly
    [Arguments]    ${promotion_id}   ${expected_sort}   #expected
    ${sort_ui}=   Get Sort From Promotions Table   ${promotion_id}
    Should Be Equal As Strings     ${sort_ui}      ${expected_sort}

Display on the below section - Under Display on Web
    Element Should Be Visible     ${below_section_of_display_on_web}

Not Display on the below section - Under Display on Web
    Element Should Not Be Visible     ${below_section_of_display_on_web}

Compare Promotion Display On Web In DB
    [Arguments]    ${promotion_id}   ${expected_display}   #expected_display = 0, 1
    ${allow_display_on}=   Get Promotion Display on Web From Promotions Table         ${promotion_id}
    Should Be Equal As Integers      ${allow_display_on[0]}      ${expected_display}

Compare Promotion Display On Thumbnail In DB
    [Arguments]    ${promotion_id}   ${expected_display}   #expected_display = 0, 1
    ${allow_display_on}=   Get Promotion Display on Thumbnail From Promotions Table   ${promotion_id}
    Should Be Equal As Integers      ${allow_display_on[0]}      ${expected_display}

Get Promotion Display on Web From Promotions Table
     [Arguments]         ${promotion_id}
     Connect DB ITM
     ${result}=     Query     SELECT `allow_display_on_web` FROM `promotions` WHERE `id` = '${promotion_id}'
     [Return]       ${result[0]}

Get Promotion Display on Thumbnail From Promotions Table
     [Arguments]         ${promotion_id}
     Connect DB ITM
     ${result}=     Query     SELECT `allow_display_on_thumbnail` FROM `promotions` WHERE `id` = '${promotion_id}'
     [Return]       ${result[0]}

Click Mass Upload Exclude Product Button
    Click Element    ${mass_upload_exclude_product_btn}

Saved Successfully message displays on Manage Display page
    Wait Until Page Contains Element   ${saved_successfully_message}
    Page Should Contain Element        ${saved_successfully_message}
    Element Should Contain             ${saved_successfully_message}       Saved successfully.

Saved Successfully message not displays on Manage Display page
    Page Should Not Contain            ${saved_successfully_message}

Manage Display Page Opens
    Location Should Contain     promotions/manage-display

Click Back And Go To Manage Display Page
    Wait Until Element Is Visible      ${Back_Button_On_View_Promotion_Detail}      10s
    Click Element       ${Back_Button_On_View_Promotion_Detail}
    Click Element       ${manage_display_button}

#Set Product Pkeys In CSV for Mass Upload Display Exclude Success (pkey active, inactive, space at first/last)
    #[Arguments]    ${data_for_success}
    #${path_file}=    Set Variable    ${CURDIR}/../../../../Resource/TestData/Promotion/Mass Upload Display Excldue/mass_upload_display_exclude_success.csv
    #csvlibrary.create_file    ${path_file}    ${data_for_success}
    #[Return]    ${path_file}
    #1122 [correct pkey (1varaint) - active]
    #2233 [correct pkey (1varaint) - inactive]
    #3344 [correct pkey - active -> has some disabled variants]
    #[blank row]
    #" 11112222 " -> correct pkey with space at first and last

Import Excluded Product - Imported Successfully
    ${file_path}=    Set Variable    import_exclude_products_success.csv
    Promotion - Import Excluded Product    ${file_path}

Import Excluded Product - Imported Successfully And Change Column Header
    ${file_path}=    Set Variable    import_exclude_products_success_change_header.csv
    Promotion - Import Excluded Product    ${file_path}

Import Excluded Product - Imported Fail - Excel File
    ${file_path}=    Set Variable    import_exclude_products.xlsx
    Promotion - Import Excluded Product    ${file_path}

Import Excluded Product - Imported Fail - Invalid Data
    ${file_path}=    Set Variable    import_exclude_products_invalid_data.csv
    Promotion - Import Excluded Product    ${file_path}

Import Excluded Product - Imported Fail - Empty Data
    ${file_path}=    Set Variable    import_exclude_products_empty_data.csv
    Promotion - Import Excluded Product    ${file_path}

Import Excluded Product - Imported Successfully With Active All Product
    ${file_path}=    Set Variable    import_exclude_products_success_active.csv
    Promotion - Import Excluded Product    ${file_path}

Get Promotion Id From Promotion Manage Display
    ${url}=    Get Location
    ${words} =  Split String    ${url}    ?
    ${words} =  Split String    ${words[0]}    /
    ${promotion_id}=  Set Variable    ${words[4]}

    [Return]    ${promotion_id}

Validate Excluded Products Data In Database
    [Arguments]    ${product_pkey_list}
    ${promotion_id}=    Get Promotion Id From Promotion Manage Display
    ${exclide_on_db}=    py_validate_product_pkey_in_excluded_product_table    ${promotion_id}    ${product_pkey_list}
    ${count_product_pkey_list}=    Get Length    ${product_pkey_list}

    Log To Console    ...........Count from list = '${count_product_pkey_list}' ......................
    Log To Console    ...........Count from DB = '${exclide_on_db}' ......................

    Should Be Equal      '${exclide_on_db}'      '${count_product_pkey_list}'


#51th character cannot be entered at title text TH and EN


#51th character cannot be entered at code text TH and EN


#51th character cannot be entered at discount text and EN


#Value of all textboxes and sort are still kept
