*** Variables ***
${xpath-login-email}   name=email
${xpath-login-password}   name=password
${xpath-login-button}    //input[@class="btn btn-success mws-login-button"]
${xpath-link-logout}    //a[contains(@href, "auth/logout")]

${tmvh_textbox_search_by_order}    jquery=input[id="order_id"]
${tmvh_textbox_search_by_created_at_start}    jquery=input[id="created_at_start"]
${tmvh_textbox_search_by_created_at_end}    jquery=input[id="created_at_end"]
${tmvh_textbox_search_by_transaction_time_start}    jquery=input[id="transaction_time_start"]
${tmvh_textbox_search_by_transaction_time_end}    jquery=input[id="transaction_time_end"]
${tmvh_button_search}    jquery=button[id="btn-search"]
${tmvh_icon_truck}                               css=.icon-truck
${tmvh_confirm_ok}      //*[contains(text(), "OK")]
${tmvh_confirm_cancel}      //*[contains(text(), "Cancel")]
${tmvh_input_tcc_order}     //input[@class="tcc_order"]
${tmvh_cbo_activate_status}    //td[@id="activate-action-^^ITEM_ID^^"]/div/*[@name="activate_status"]
${tmvh_input_remark}            name=note
${tmvh_dropdown_search_by_dealer}    //select[@name="merchant_id"]
${tmvh_dropdown_search_by_payment_status}    //select[@name="payment_status"]
${tmvh_dropdown_search_by_verify_status}    //select[@name="verify_status"]
${tmvh_dropdown_search_by_item_status}    //select[@name="item_status"]
${tmvh_dropdown_search_by_activate_status}    //select[@name="activate_status"]
