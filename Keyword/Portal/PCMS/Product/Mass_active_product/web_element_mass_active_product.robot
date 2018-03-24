*** Variables ***
${product_menu}                       //div[@id="mws-navigation"]/ul/li/a[contains(text(),'Product')]
${mass_active_product_menu}           //a[contains(text(),'Mass Active Product')]
${text_menu}                          //ul[@class="breadcrumb"]/li[2][@class="active"]
${browse_file}                        //*[@name="file_upload"]
${text_result_upload}                 //*[@id="text-message"]
${spinner_name}                       //*[@class="spinner-loader"]
${textbox_productname}                //*[@id="product"]
${btn_search}						  //*[@value="Search"]
${text_result}                        //*[@class="mws-panel-toolbar"]/label
${link_back_mass_active}              //a[@href="/products/mass-active-products"]
${link_example_file}                  //a[contains(text(),'(Example File)')]
${breadcrumb_export_product_collection}    //*[@class="breadcrumb"]/*[contains(text(),'Export Product Collection')]
${xpath_count_row_td}                 //table[@class="mws-table"]/tbody/tr
${xpath_hd_td}                        //table[@class="mws-table"]/thead/tr/th
${xpath_td}                           //table[@class="mws-table"]/tbody/tr/td
${xpath_product_name_level_D}         //h1[@class="leveld_full_width"]
${xpath_search_product_name}          //input[@id="product"]
${xpath_search_button}                //input[@value="Search"]
${xpath_edit_button}                  /input[@value="Edit"]
${xpath_select_status_product}        //select[@id="product-status"]