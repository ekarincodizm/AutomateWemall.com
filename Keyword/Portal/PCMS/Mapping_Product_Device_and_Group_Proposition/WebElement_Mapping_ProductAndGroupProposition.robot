*** Variables ***
${Btn_AddNewMapping}    //*[contains(@class,"btn-group btn-collection-nav")]
${Input_ProductName}    //*[contains(@name,"product_name")]
${Btn_Search}     //*[@value="Search"]
${CheckBox_Device}    //*[@id='tb-order']/tbody/tr[2]/td[2][contains(text(),"REPLACE_ME")]/../td[5]//span[contains(text(),"Active")]/../../../td[7]/input[1]
${List_GroupProposition}    //*[@id='tb-order']/tbody/tr[2]/td[2][contains(text(),"REPLACE_ME")]/../td[8]/select
${Btn_Map}        //*[@name="btn-map"]
${Assert_DeviceMap}    //*[@id='tb-order']/tbody/tr[2]/td[2][contains(text(),"REPLACE_ME")]/../td[6]//span[contains(text(),"Active")]
