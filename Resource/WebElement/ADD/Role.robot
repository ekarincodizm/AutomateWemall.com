*** Variables ***
${Role_Tab}       //div[@class='tabbable']/ul//a[contains(text(),\"Role\")]
# ${Role_ShopName}    //input[@id='shopName']
${Role_ShopName}   //input[@type='search']
${Role_Search}    //button[@id='searchRoleId']
${Role_Checkbox_By_RoleName}    //*[@id='tableRoles']//tr/td[2]//*[.='REPLACE_ME']/../../../../../td[1]
${Role_Save_bttn}    //button[@id='assignButton1']
${Role_Cancel_bttn}    //button[@id='cancelButton1']
${Save_Success}    //*[contains(text(),\"Successfully\")][@id='messageBox']
