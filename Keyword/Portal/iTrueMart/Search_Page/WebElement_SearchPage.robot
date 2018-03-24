*** Variables ***
${OutOfStock_Img_None}    //div[contains(@class,'mi-product-card-absolute last not-last')]/a[contains(@ng-href,'REPLACE_ME')]//div[contains(@class,'out-of-stock')][@style="display:none"]
${Search_OutOfStock_Img}    //div[contains(@class,'out-of-stock')][contains(@id,'REPLACE_ME')]
${Search_Image_Path}    //img[@src='REPLACE_ME']
${result_search_label}          jquery=#mi-searchCount
${result_search_words_label}    jquery=#mi-searchCount b
${lb_search_result}     //div[@id="mi-searchCount"]