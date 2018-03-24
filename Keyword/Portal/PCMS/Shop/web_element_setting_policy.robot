*** Variables ***
&{setting_policy}   txt_shop_code=//*[@id="shop_code"]
 ...   txt_shop_name=//*[@id="shop_name"]
 ...   txt_delivery_min_day=//*[@id="delivery_min_day"]
 ...   txt_delivery_max_day=//*[@id="delivery_max_day"]
 ...   txt_us_delivery_title=//*[@id="translate[en_US][delivery][title]"]
 ...   txt_us_return_title=//*[@id="translate[en_US][return][title]"]
 ...   txt_us_refund_title=//*[@id="translate[en_US][refund][title]"]
 ...   txt_th_delivery_title=//*[@id="translate[th_TH][delivery][title]"]
 ...   txt_th_return_title=//*[@id="translate[th_TH][return][title]"]
 ...   txt_th_refund_title=//*[@id="translate[th_TH][refund][title]"]
 ...   txt_us_delivery_detail=//*[@id="cke_translate[en_US][delivery][detail]"]
 ...   txt_us_return_detail=//*[@id="cke_translate[en_US][return][detail]"]
 ...   txt_us_refund_detail=//*[@id="cke_translate[en_US][refund][detail]"]
 ...   txt_th_delivery_detail=//*[@id="cke_translate[th_TH][delivery][detail]"]
 ...   txt_th_return_detail=//*[@id="cke_translate[th_TH][return][detail]"]
 ...   txt_th_refund_detail=//*[@id="cke_translate[th_TH][refund][detail]"]
 ...   btn_save=//input[@value="Save"]
 ...   btn_cancel=//a[text()="Cancel"]
 ...   dialog_err=//div[contains(@class, "alert-error")]
 ...   dialog_success=//div[contains(@class, "alert-success")]

&{setting_policy_msg}   err_max_lt_min=Maximum delivery day must be greater than minimum delivery day
 ...   err_delivery_min_zero=Minimum delivery day must be greater than 0.
 ...   err_delivery_max_zero=Maximum delivery day must be greater than 0.
 ...   err_delivery_policy_req=Delivery Policy Detail (TH) is required.
 ...   err_return_policy_req=Return Policy Detail (TH) is required.
 ...   err_refund_policy_req=Refund Policy Detail (TH) is required.
 ...   success_create=Save Policies Success
