*** Variables ***

${btn_create_campaign}    xpath=//input[@type="submit"]
${app}                    xpath=//*[@name="app_id"]
${selected_icon_type}     xpath=//*[@id="flashsale_type"]
${textbox_code}           xpath=//*[@id="code"]
${textbox_name}           xpath=//*[@name="name"]
${textbox_description}    xpath=//*[@id="description"]
${textbox_discount}       xpath=//*[@id="discount"]
${selected_discount_type}     xpath=//*[@name="discount_type"]
${period_start_date}          xpath=//*[@id="started_at"]
${period_end_date}            xpath=//*[@id="ended_at"]

${browse_banner_web_tomorrow}    xpath=//*[@id="banner_web_tomorrow"]
${browse_banner_web_today}       xpath=//*[@id="banner_web_today"]
${browse_banner_web_incoming}    xpath=//*[@id="banner_web_incoming"]
${btn_create}                    xpath=//input[@class="btn btn-primary"]

${discount_campaign_table}      xpath=//*[@id="discountProductCampaignsTable"]
${btn_discount_products}        ${discount_campaign_table}/tbody/tr/td[2]/h4[contains(text(), "??campaign_name??")]/../../td[7]/a[@class="btn btn-warning"]
${btn_edit_campaign}            ${discount_campaign_table}/tbody/tr/td[2]/h4[contains(text(), "??campaign_name??")]/../../td[7]/a[@class="btn btn-info"]
${btn_delete_campaign}          ${discount_campaign_table}/tbody/tr/td[2]/h4[contains(text(), "??campaign_name??")]/../../td[7]/a[@class="btn btn-danger delete"]
${add_item_button}              xpath=//div[@class="btn-group btn-collection-nav"]/a
${product_field}                xpath=//*[@id='product']
${search_button}                xpath=//div/input[@type="submit"]
${table_product_1}              xpath=//table[1]
${add_to_campaign_button}       xpath=//table[1]//input[@name="added-products[]"]
${quota_field}                  xpath=//*[@id="discount-campaign-product"]/table/tbody/tr[2]/td[7]/input
${submit_button}                xpath=//div[1]/input[@type="submit" and @value="Submit"]
${save_button}                  xpath=//div[1]/input[@type="submit" and @value="Save"]

${product_variant_row}          xpath=//td[contains(text(), "??product_name??")]/..
${product_variant_discount_value}    ${product_variant_row}/td[4]/input
${product_variant_discount_type}     ${product_variant_row}/td[4]/select
${new_added_product_variant_row}          //tr[contains(@class,"new-added-variant")]
${new_added_product_variant_inv}          //*[contains(@name,"added-variants") and contains(@name,"[inventory_id]")]

${delete_campaign_success}      Discount campaign deleted

${discount_product_table}     xpath=//*[@id="discount-campaign-product"]/table
${btn_add_item}               //*[@class="btn-group btn-collection-nav"]/a
${textbox_search}             //input[@aria-controls="discountProductCampaignsTable"]