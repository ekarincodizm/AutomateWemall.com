*** Variables ***
${product_menu}                       //div[@id="mws-navigation"]/ul/li/a[contains(text(),'Product')]
${export_product_collection_menu}     //a[contains(text(),'Export Product Collection')]
${text_menu}                          //ul[@class="breadcrumb"]/li[2][@class="active"]
${browse_file}                        //*[@name="file_upload"]
${text_result_upload}                 //*[@id="text-message"]
${spinner_name}                       //*[@class="spinner-loader"]
${get_product_ids}                    //input[@name='product_ids']
${textbox_productname}                //*[@id="product"]
${btn_search}						  //*[@value="Search"]
${text_result}                        //*[@class="mws-panel-toolbar"]/label
${link_back}                          //a[@href="/export-products-collections"]
${link_example_file}                  //a[contains(text(),'(Example File)')]
${breadcrumb_export_product_collection}    //*[@class="breadcrumb"]/*[contains(text(),'Export Product Collection')]
${xpath_count_row_td}                 //table[@class="mws-table"]/tbody/tr
${xpath_hd_td}                        //table[@class="mws-table"]/thead/tr/th
${xptah_td}                           //table[@class="mws-table"]/tbody/tr/td
# ${loading}                            //*[@class="loading_file_upload"]