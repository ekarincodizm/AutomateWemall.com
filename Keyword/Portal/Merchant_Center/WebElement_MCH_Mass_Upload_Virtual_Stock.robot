*** Variables ***
${upload_stock_menu}    //*[@id="uploadStock"]/a
${choose_file_input}    //input[@type="file"]
${upload_button}        //*[@id="btn-upload-file"]

${download_template_link}    //a[@id="link-download-template"]

# ${ALERT-FILE-VERIFICATION-RESULT}    //div[@id="file-review-box"]/div/div/alert/div
${alert_file_verification_result}    //div/span[@class="ng-binding ng-scope"]
${file_verification_table}    xpath=//table[@id="file-review-table"]

${next_page_button}    //button[text()=" Next "]
${close_file_verification_button}    //button[@id="btn-close-file-review"]