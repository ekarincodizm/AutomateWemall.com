*** Settings ***
Library    ${CURDIR}/../../../Python_Library/ui_floating_ads.py
Library    ${CURDIR}/../../../Python_Library/product.py

Resource    webelement_ui_floating_ads.robot
Resource    ${CURDIR}/../iTrueMart/Level_d_page/keywords_leveld.robot
Resource    ${CURDIR}/../../Mobile/iTrueMart/Level_d_page/keywords_leveld_mobile.robot
Resource    ${CURDIR}/../iTrueMart/Home/keywords_home.robot
Resource    ${CURDIR}/../../API/PCMS/Product/update_stock.robot

*** Keywords ***

##################
### Go To Page ###
##################

Ui Floating Ads - Go To Lv D Page Using P-key Which Set Shipping Info
    Level D Go to en level D with Product    ${suite.p_key_shipping_info}

Ui Floating Ads - Go To Level D Mobile with Product Which Set Shipping Info
    Open Browser ITM-levelD Th Mobile    ${suite.p_key_shipping_info}
    Click Info Tab

Ui Floating Ads - Open Level D with Product Which Set Lv C Truemoveh
    Open Browser ITM-levelD    ${suite.p_key_lv_c_tmvh}

Ui Floating Ads - Open Level D with Product Which Can Buy With Package
    Open Browser ITM-levelD    ${suite.p_key_buy_with_package}

Ui Floating Ads - Go To Lv D Page Using P-key Which Can Buy With Package
    Level D Go to en level D with Product    ${suite.p_key_buy_with_package}


##############
### Action ###
##############

Click Info Tab
    Click Element    ${XPATH.info_tab}

Search Product Which Set Lv C Truemoveh
    Home - Open Browser Itruemart
    Input Product Name

Search Product Which Set Lv C Truemoveh On EN Home
    Home - Go To Itruemart En
    Input Product Name

Input Product Name
    ${product_name}=    get_product_name_by_pkey    ${suite.p_key_lv_c_tmvh}
    Input Text    ${XPATH.search_box}    ${product_name}
    Click Element   ${XPATH.search_button}

##################
### Validation ###
##################

Page Should Contain Shipping Fee Info
    Wait Until Page Contains    ${MSG.shipping_info_heading}
    Page Should Contain    ${MSG.shipping_info_heading}
    Page Should Contain    ${MSG.shipping_info_content}

Page Should Contain Lv C Truemoveh Text
    Page Should Contain    ${MSG.discount_tmvh}
    Page Should Contain    ${MSG.new_tmvh_number}

Page Should Contain Buy With Package Button
    Page Should Contain Element    ${XPATH.buy_with_package_button}
    Page Should Contain    ${MSG.buy_with_package}

Page Should Contain En Buy With Package Button
    Page Should Contain Element    ${XPATH.buy_with_package_button}
    Page Should Contain    ${MSG.buy_with_package_en}

Page Should Contain Coupon Code Div
    Page Should Contain Element    ${XPATH.coupon_code_div}
    Page Should Contain    ${MSG.coupon_code}

Page Should Contain En Coupon Code Div
    Page Should Contain Element    ${XPATH.coupon_code_div}
    Page Should Contain    ${MSG.coupon_code_en}

###########
### Get ###
###########

Click Category Xpath
    ${cat_xpath}=    get_category_xpath    ${suite.p_key_lv_c_tmvh}
    Click Element    ${cat_xpath}

Check Version - Ui Floating Ads Souce Code
    ${ui_floating_ads_url}=    get_ui_floating_ads_url
    Log To Console    \n
    Log To Console    Ui Floating Ads Version: ${ui_floating_ads_url}
    Log To Console    \n

COD Info doesn't display no.4-ชำระเงินกับพนักงานส่งสินค้า
    Page Should Not Contain    ชำระเงินกับพนักงานส่งสินค้า

###########
### Log ###
###########

Log Notice
    Log To Console    \n
    Log To Console    ========================================================== \n
    Log To Console    | Should only apply ui floating on p-key = 2634908634297 | \n
    Log To Console    ========================================================== \n
    #Log To Console    *** Press enter to use default p-key *** \n
    Log To Console    \n

