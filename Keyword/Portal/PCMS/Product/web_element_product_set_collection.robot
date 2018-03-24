*** Variables ***
${manage_collection_url_path}      collections
${mass_upload_menu}                //a[text() = ' Collection']/..//a[text() = 'Mass Upload']
${collection_menu}                 //a[text() = ' Collection']
${PRODUCT-IN-COLLECTION-TABLE}     xpath=//*[@id="productsInCollectionTable"]
${browse_file}                     //*[@name="file_upload"]
${text_menu}                       //ul[@class="breadcrumb"]/li[2][@class="active"]
${choose_product_has_alias}        //td[.='9922654321123']/../td/a[.='Products']
${choose_product_has_not_alias}    //td[.='9966654321246']/../td/a[.='Products']