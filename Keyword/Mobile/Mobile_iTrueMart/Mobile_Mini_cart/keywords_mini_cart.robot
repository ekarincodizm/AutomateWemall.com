*** Settings ***
Resource      web_element_mini_cart.robot


*** Keywords ***
Mini Cart Mobile - Do Something
	Log to console   do some thing

Mini Cart Mobile - Merchant Name Should Not Appear
    Page Should Not Contain     ${XPATH_MINI_CART_MOBILE.lbl_merchant_name}
    Page Should Not Contain Element     ${XPATH_MINI_CART_MOBILE.div_merchant_name}
