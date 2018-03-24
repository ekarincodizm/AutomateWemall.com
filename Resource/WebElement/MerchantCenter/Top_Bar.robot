*** Variables ***
${lvl1_menu}      //ul[@id='MERCHANT_CENTER_MENUS']/li/a[contains(text(),\"REPLACE_ME\")]
${lvl2_menu}      //ul[@id='MERCHANT_CENTER_MENUS']/li/a//a[contains(text(),\"REPLACE_ME\")]
${topbarMerchantUserName}    //*[@id='MERCHANT_CENTER_SETTING']/a
${topbarMerchantShopName}    //*[@id='MERCHANT_CENTER_SHOPS']/following-sibling::div
${topbarMerchantLogo}    //*[@class='logo-wemall']
${Shopname_Dropdown}    //div/select[@id='MERCHANT_CENTER_SHOPS']/../div/div[contains(text(),'REPLACE_ME')]
${logout_button}    //*[@id='MERCHANT_CENTER_SIGNOUT']/a
