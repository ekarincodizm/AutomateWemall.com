*** Variables ***
${UPLOAD-ACTION-SELECTOR}    //select[@id="select-upload-action"]
${CHOOSE-FILE-INPUT}    //input[@id="btn-choose-file-csv"]
${UPLOAD-BUTTON}    //button[@id="btn-upload-file"]

${ALERT-UPLOAD-ACTION-AND-FILE-RESULT}    //app-upload-action/div/div/div/div/div[1]/div[1]/alert/div
${ALERT-FILE-VERIFICATION-RESULT}    //div[@id="file-review-box"]/div/div/alert/div

${FILE-VERIFICATION-TABLE}    xpath=//table[@id="file-review-table"]
${NEXT-PAGE-LINK}    //a[text()="Next"]