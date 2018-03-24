*** Settings ***
Resource    ${CURDIR}/web_element_register_form.robot

*** Keywords ***
Mystery Register - [Web] Open Register Form
    Open Browser                ${ITM_URL}/mystery-begins/register-form           ${BROWSER}
    Set Window Size             ${1500}          ${800}

Mystery Register - [Web] Open Register Form Bypass Recaptcha
    Open Browser                ${ITM_URL}/mystery-begins/register-form?bypass-recaptcha=mycat!           ${BROWSER}
    Set Window Size             ${1500}          ${800}

Mystery Register - [Web] Go To Register Form
    Go To                ${ITM_URL}/mystery-begins/register-form                  ${BROWSER}

Mystery Register - Validate First Name Fail
    [Arguments]     ${firstname}
    Wait Until Element Is Visible       ${MysteryForm_txt_firstname}          30s
    Input Text                          ${MysteryForm_txt_firstname}          ${firstname}
    Click Element                       ${MysteryForm_btn_submit}
    Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_firstname}          15s
    Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_firstname}

Mystery Register - Validate Last Name Fail
    [Arguments]     ${lastname}
    Wait Until Element Is Visible       ${MysteryForm_txt_lastname}          30s
    Input Text                          ${MysteryForm_txt_lastname}          ${lastname}
    Click Element                       ${MysteryForm_btn_submit}
    Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_lastname}          15s
    Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_lastname}

Mystery Register - Validate Tel Fail
    [Arguments]     ${tel}
    Wait Until Element Is Visible       ${MysteryForm_txt_tel}          30s
    Input Text                          ${MysteryForm_txt_tel}          ${tel}
    Click Element                       ${MysteryForm_btn_submit}
    Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_tel}          15s
    Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_tel}

Mystery Register - Validate Tel Length
    [Arguments]     ${tel}=1234567890123456          ${expect_length}=10
    Wait Until Element Is Visible       ${MysteryForm_txt_tel}          30s
    Input Text                          ${MysteryForm_txt_tel}          ${tel}
    ${value_tel}                        Get Value        ${MysteryForm_txt_tel}
    ${tel_length}                       Get Length       ${value_tel}
    Should Be Equal As Integers         ${tel_length}    ${expect_length}

Mystery Register - Validate Email Fail
    [Arguments]     ${email}
    Wait Until Element Is Visible       ${MysteryForm_txt_email}        30s
    Input Text                          ${MysteryForm_txt_email}        ${email}
    Click Element                       ${MysteryForm_btn_submit}
    Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_email}          15s
    Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_email}

Mystery Register - Input First Name
    [Arguments]         ${firstname}=FisrtName
    Wait Until Element Is Visible       ${MysteryForm_txt_firstname}          30s
    Input Text                          ${MysteryForm_txt_firstname}          ${firstname}

Mystery Register - Input Last Name
    [Arguments]     ${lastname}=LastName
    Wait Until Element Is Visible       ${MysteryForm_txt_lastname}          30s
    Input Text                          ${MysteryForm_txt_lastname}          ${lastname}

Mystery Register - Input Tel
    [Arguments]     ${tel}=0812345678
    Wait Until Element Is Visible       ${MysteryForm_txt_tel}          30s
    Input Text                          ${MysteryForm_txt_tel}          ${tel}

Mystery Register - Select Gender
    [Arguments]     ${gender}=male
    Wait Until Element Is Visible       ${MysteryForm_cbo_gender}          30s
    Select From List            ${MysteryForm_cbo_gender}        ${gender}

Mystery Register - Select Birth Date
    [Arguments]     ${year}=1992        ${month}=0          ${day}=1
    Wait Until Element Is Visible       ${MysteryForm_txt_birthdate}          30s
    Click Element                       ${MysteryForm_txt_birthdate}
    Wait Until Element Is Visible       ${MysteryForm_table_pika}          30s
    Select From List                    ${MysteryForm_cbo_pika_year}        ${year}
    Select From List                    ${MysteryForm_cbo_pika_month}       ${month}
    ${pika_day}=        Replace String          ${MysteryForm_btn_pika_day}         REPLACE_YEAR            ${year}
    ${pika_day}=        Replace String          ${pika_day}         REPLACE_MONTH           ${month}
    ${pika_day}=        Replace String          ${pika_day}         REPLACE_DAY             ${day}
    Wait Until Element Is Visible       ${pika_day}          15s
    Click Element                       ${pika_day}

Mystery Register - Input Email
    [Arguments]     ${email}=blackpantherautomate@gmail.com
    Wait Until Element Is Visible       ${MysteryForm_txt_email}        30s
    Input Text                          ${MysteryForm_txt_email}        ${email}

Mystery Register - Input Prediction
    [Arguments]     ${prediction_id}=1
    Wait Until Element Is Visible       ${MysteryForm_radio_prediction}        30s
    Select Radio Button             prediction            ${prediction_id}

Mystery Register - Display Input First Name
    Wait Until Element Is Visible       ${MysteryForm_txt_firstname}        5s
    Element Should Be Visible           ${MysteryForm_txt_firstname}

Mystery Register - Display Input Last Name
   Wait Until Element Is Visible       ${MysteryForm_txt_lastname}        5s
   Element Should Be Visible           ${MysteryForm_txt_lastname}

Mystery Register - Display Input Tel
   Wait Until Element Is Visible       ${MysteryForm_txt_tel}        5s
   Element Should Be Visible           ${MysteryForm_txt_tel}

Mystery Register - Display Input Gender
   Wait Until Element Is Visible       ${MysteryForm_cbo_gender}        5s
   Element Should Be Visible           ${MysteryForm_cbo_gender}

Mystery Register - Display Input Birth Date
   Wait Until Element Is Visible       ${MysteryForm_txt_birthdate}        5s
   Element Should Be Visible           ${MysteryForm_txt_birthdate}

Mystery Register - Display Input Email
   Wait Until Element Is Visible       ${MysteryForm_txt_email}        5s
   Element Should Be Visible           ${MysteryForm_txt_email}

Mystery Register - Display Button Submit
   Wait Until Element Is Visible       ${MysteryForm_btn_submit}        5s
   Element Should Be Visible           ${MysteryForm_btn_submit}
   Wait Until Element Is Visible       ${MysteryForm_btn_submit_img}        5s
   Element Should Be Visible           ${MysteryForm_btn_submit_img}

Mystery Register - Display Error First Name
    Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_firstname}        5s
    Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_firstname}

Mystery Register - Display Error Last Name
   Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_lastname}        5s
   Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_lastname}

Mystery Register - Display Error Tel
   Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_tel}        5s
   Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_tel}

Mystery Register - Display Error Gender
   Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_gender}        5s
   Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_gender}

Mystery Register - Display Error Birth Date
   Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_birthdate}        5s
   Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_birthdate}

Mystery Register - Display Error Email
   Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_email}        5s
   Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_email}

Mystery Register - Display Error Prediciton
   Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_prediction}        5s
   Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_prediction}

Mystery Register - Display Error Recaptcha
   Wait Until Element Is Visible       ${XPATH_MYSTERY_REGISTER.lbl_error_recaptcha}        5s
   Element Should Be Visible           ${XPATH_MYSTERY_REGISTER.lbl_error_recaptcha}

Mystery Register - Click Submit
   Wait Until Element Is Visible       ${MysteryForm_btn_submit}        30s
   Click Element                       ${MysteryForm_btn_submit}

Mystery Register - Display Title Prediction
   Wait Until Element Is Visible       ${MysteryForm_title}        20s
   Element Should Be Visible           ${MysteryForm_title}

Mystery Register - Display Term And Condition Link
   Wait Until Element Is Visible       ${MysteryForm_term_and_con}        20s
   Element Should Be Visible           ${MysteryForm_term_and_con}

Mystery Register - Click Term And Condition
   Wait Until Element Is Visible       ${MysteryForm_term_and_con}        20s
   Click Element           ${MysteryForm_term_and_con}

Mystery Register - Total Prediciton Item Active
    ${expect_predictions}=          Get Length              ${var_mystery_prediction_list}
    ${count_predictions}=           Get Matching Xpath Count             ${MysteryForm_prediction_total_item}
    ${expect_predictions}=          Convert To Integer      ${expect_predictions}
    ${count_predictions}=           Convert To Integer      ${count_predictions}
    Should Be Equal                 ${count_predictions}          ${expect_predictions}

Mystery Register - Display Prediction Item Radio
   [Arguments]          ${prediction_id}
   ${prediction_id}=        Convert To String    ${prediction_id}
   ${element}=              Replace String      ${MysteryForm_prediction_item_radio}        REPLACE_ID      ${prediction_id}
   Wait Until Element Is Visible       ${element}        15s
   Element Should Be Visible           ${element}

Mystery Register - Display Prediction Item Name
   [Arguments]          ${prediction_id}            ${expect_name}
   ${prediction_id}=        Convert To String       ${prediction_id}
   ${element}=              Replace String          ${MysteryForm_prediction_item_name}        REPLACE_ID      ${prediction_id}
   Wait Until Element Is Visible       ${element}        15s
   Element Should Be Visible           ${element}
   ${fact_name}=            Get Text                ${element}
   Should Be Equal          ${fact_name}            ${expect_name}

Mystery Register - Display Prediction Item Image Thumb
   [Arguments]          ${prediction_id}            ${img_path}
   ${prediction_id}=        Convert To String       ${prediction_id}
   ${img_path}=             Convert To String       ${img_path}
   ${element}=              Replace String          ${MysteryForm_prediction_item_img}        REPLACE_ID      ${prediction_id}
   ${element}=              Replace String          ${element}        REPLACE_SRC      ${img_path}
   Wait Until Element Is Visible       ${element}        15s
   Element Should Be Visible           ${element}

Mystery Register - Mouse Over Prediction Item
   [Arguments]          ${prediction_id}
   ${prediction_id}=        Convert To String       ${prediction_id}
   ${radio_prediction}=     Replace String          ${MysteryForm_prediction_item_radio}        REPLACE_ID      ${prediction_id}
   ${tooltip}=              Replace String          ${XPATH_MYSTERY_PREDICTION.tooltip}        REPLACE_ID      ${prediction_id}
   Mouse Over                           ${radio_prediction}
   Wait Until Element Is Visible        ${tooltip}        10s

Mystery Register - Display Prediction Image Thumbnail on Tooltip
   [Arguments]          ${prediction_id}            ${img_path}
   ${prediction_id}=        Convert To String       ${prediction_id}
   ${img_path}=             Convert To String       ${img_path}
   ${element}=              Replace String          ${XPATH_MYSTERY_PREDICTION.tooltip_img_thumb}        REPLACE_ID      ${prediction_id}
   ${element}=              Replace String          ${element}        REPLACE_SRC      ${img_path}
   Wait Until Element Is Visible        ${element}        10s
   Element Should Be Visible            ${element}

Mystery Register - Display Prediction Name on Tooltip
   [Arguments]          ${prediction_id}            ${expect_name}
   ${prediction_id}=        Convert To String       ${prediction_id}
   ${element}=              Replace String          ${XPATH_MYSTERY_PREDICTION.tooltip_img_name}        REPLACE_ID      ${prediction_id}
   Wait Until Element Is Visible        ${element}        10s
   Element Should Be Visible            ${element}
   ${fact_name}=            Get Text                ${element}
   Should Contain          ${fact_name}            ${expect_name}

Mystery Register - Display Prediction Title on Tooltip
   [Arguments]          ${prediction_id}            ${expect_title}
   ${prediction_id}=        Convert To String       ${prediction_id}
   ${element}=              Replace String          ${XPATH_MYSTERY_PREDICTION.tooltip_img_title}        REPLACE_ID      ${prediction_id}
   Wait Until Element Is Visible        ${element}        10s
   Element Should Be Visible            ${element}
   ${fact_title}=           Get Text                            ${element}
   ${fact_title}=           Convert To String                   ${fact_title.strip()}
   ${fact_title}=           Replace String Using Regexp         ${fact_title}               ${SPACE}        ${EMPTY}
   ${fact_title}=           Replace String Using Regexp         ${fact_title}               " "        ${EMPTY}
   ${expect_title}=         Convert To String                   ${expect_title.strip()}
   ${expect_title}=         Replace String Using Regexp         ${expect_title}             ${SPACE}        ${EMPTY}
   ${expect_title}=         Replace String Using Regexp         ${expect_title}             " "        ${EMPTY}
   Should Contain           ${fact_title}               ${expect_title}

Mystery Register - Display All Prediction Item
    : FOR       ${prediction}    IN    @{var_mystery_prediction_list}
    \           ${id}=               Get From Dictionary         ${prediction}          id
    \           ${name_th}=          Get From Dictionary         ${prediction}          name_th
    \           ${img_thumb}=        Get From Dictionary         ${prediction}          img_thumb
    \           Mystery Register - Display Prediction Item Radio                 ${id}
    \           Mystery Register - Display Prediction Item Name                  ${id}       ${name_th}
    \           Mystery Register - Display Prediction Item Image Thumb           ${id}       ${img_thumb}

Mystery Register - Display Tootip on Mouse Over Prediction Item
    : FOR       ${prediction}    IN    @{var_mystery_prediction_list}
    \           ${id}=                      Get From Dictionary         ${prediction}           id
    \           ${name_th}=                 Get From Dictionary         ${prediction}           name_th
    \           ${img_thumb_hover}=         Get From Dictionary         ${prediction}           img_thumb_hover
    \           ${short_desc_th}=           Get From Dictionary         ${prediction}           short_desc_th
    \           Mystery Register - Mouse Over Prediction Item                                   ${id}
    \           Mystery Register - Display Prediction Image Thumbnail on Tooltip                ${id}       ${img_thumb_hover}
    \           Mystery Register - Display Prediction Name on Tooltip                           ${id}       ${name_th}
    \           Mystery Register - Display Prediction Title on Tooltip                          ${id}       ${short_desc_th}
