*** Variables ***
${MysteryForm_txt_firstname}                    name=firstname
${MysteryForm_txt_tel}                          name=tel
${MysteryForm_cbo_gender}                       name=gender
${MysteryForm_txt_lastname}                     name=lastname
${MysteryForm_txt_birthdate}                    name=birthdate
${MysteryForm_txt_email}                        name=email
${MysteryForm_radio_prediction}                 name=prediction
${MysteryForm_prediction_total_item}            //input[@name="prediction"]
${MysteryForm_prediction_item_radio}            id=prediction_REPLACE_ID
${MysteryForm_prediction_item_name}             id=prediction_name_REPLACE_ID
${MysteryForm_prediction_item_img}              //*[@id="prediction_img_thumb_REPLACE_ID" and @src="REPLACE_SRC"]
${MysteryForm_prediction_item_tooltip}          id=prediction_tooltip_REPLACE_ID
${MysteryForm_prediction_item_tooltip_img}      id=prediction_tooltip_img_thumb_REPLACE_ID
${MysteryForm_prediction_item_tooltip_name}     id=prediction_tooltip_name_REPLACE_ID
${MysteryForm_prediction_item_tooltip_title}    id=prediction_tooltip_title_REPLACE_ID
${MysteryForm_btn_submit}                       //*[@id="mt_click_div"]
${MysteryForm_btn_submit_img}                   //*[@id="mt_register_div"]

${MysteryForm_title}                            id=mt_title_div
${MysteryForm_term_and_con}                     id=term_and_con

${MysteryForm_table_pika}                       //*[contains(@class, 'pika-table')]
${MysteryForm_cbo_pika_month}                   //*[contains(@class, 'pika-select-month')]
${MysteryForm_cbo_pika_year}                    //*[contains(@class, 'pika-select-year')]
${MysteryForm_btn_pika_day}                     //*[@data-pika-year="REPLACE_YEAR" and @data-pika-month="REPLACE_MONTH" and @data-pika-day="REPLACE_DAY"]

&{XPATH_MYSTERY_REGISTER}       lbl_error_email=//*[@for="email"]
 ...    lbl_error_tel=//*[@for="tel"]
 ...    lbl_error_firstname=//*[@for="firstname"]
 ...    lbl_error_lastname=//*[@for="lastname"]
 ...    lbl_error_gender=//*[@for="gender"]
 ...    lbl_error_birthdate=//*[@for="birthdate"]
 ...    lbl_error_prediction=//*[@for="prediction"]
 ...    lbl_error_recaptcha=//*[@for="recaptcha"]
 ...    lbl_title=//*[@id="mt_title_div"]

 &{XPATH_MYSTERY_PREDICTION}        tooltip=//*[@id="prediction_tooltip_REPLACE_ID"]
 ...    tooltip_img_thumb=//*[@id="prediction_tooltip_img_thumb_REPLACE_ID"]/img[@src="REPLACE_SRC"]
 ...    tooltip_img_name=//*[@id="prediction_tooltip_name_REPLACE_ID"]
 ...    tooltip_img_title=//*[@id="prediction_tooltip_title_REPLACE_ID"]


