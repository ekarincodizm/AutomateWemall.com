*** Variables ***
${xpath-login-email}   name=email
${xpath-login-password}   name=password
${xpath-login-button}    //input[@class="btn btn-success mws-login-button"]
${xpath-link-logout}    //a[contains(@href, "auth/logout")]

${tmvh_cbo_type}         //*[@id="bundle_type"]
${tmvh_cbo_activated}    //*[@id="filter_id"]
${tmvh_cbo_downloaded}   //*[@id="download_id"]
${tmvh_txt_start_date}    jquery=input[id="activate_date_start"]
${tmvh_txt_end_date}    jquery=input[id="activate_date_end"]
#${tmvh_txt_order_id}    jquery=input[id="order_id"]
${tmvh_txt_order_id}    //*[@id="order_id"]
${tmvh_commission_button_search}    jquery=button[id="commision-search-btn"]
${tmvh_button_reset}    jquery=input[id="reset-btn"]
${tmvh_label_download_count}   //*[@data-id="txt_download_count"]
${tmvh_commission_merchant_type}    id=merchant_id

${EQUAL_OR_MORE_THAN}          >=
${EQUAL_OR_LESS_THAN}          <=
${MORE_THAN}                    >
${LESS_THAN}                    <
${EQUAL}                        =

&{BUNDLE_TYPE}   sim_only=1
 ...  bundle=2
 ...  mnp=3
 ...  mnp_device=4

&{ACTIVATED}   all=0
 ...  more_than_15days=1
 ...  less_than_15days=2

&{DOWNLOADED}   all=0
 ...  undownloaded=1
 ...  downloaded=2