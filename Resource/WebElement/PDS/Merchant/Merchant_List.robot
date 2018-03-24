*** Variables ***
${MerchantName}    //input[@class='form-control']
${FilterButton}    //*[@name=\"filterBtn\"]
${Table_MerchantID}    //*[@name=\"textInput\"]
${Table_MerchantIDByMerchantName}    //*[@class=\"col-xs-12\"]//tbody//tr/td[2][contains(text(),'REPLACE_ME')]/../td[1]
${Img_MLogo}      //*[@data-reactid=".0.1.0.1.1.0.0.0.0.0.0.0.0.0.6.0.0.1.0.1"]/div/img
${Img_DLogo}      //*[@data-reactid=".0.1.0.1.1.0.0.0.0.0.0.0.0.0.7.0.0.1.0.1"]/div/img
${Table_Merchant_Status_Dropdown}    //*[@class=\"col-xs-12\"]//tbody//tr/td[2][contains(text(),'REPLACE_ME')]/../td[3]/select[@name="statusSelect"]
${Table_Merchant_Status_Waiting}    //*[@class=\"col-xs-12\"]//tbody//tr/td[2][contains(text(),'REPLACE_ME')]/../td[3]/a[contains(text(),'Waiting')]
${Table_Merchant_Status_Active}    //*[@class=\"col-xs-12\"]//tbody//tr/td[2][contains(text(),'REPLACE_ME')]/../td[3]//option[@name="activeOption"]
${Table_Merchant_Status_InActive}    //*[@class=\"col-xs-12\"]//tbody//tr/td[2][contains(text(),'REPLACE_ME')]/../td[3]//option[@name="inactiveOption"]
${Update_btn}     //button[@name='updateBtn']
${loader}         //div[@id="loader"]
