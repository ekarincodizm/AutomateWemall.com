*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem

Resource    ${CURDIR}/../../Resource/init.robot
Resource    ${CURDIR}/../../Keyword/Portal/ui_floating_ads/keywords_ui_floatind_ads.robot
Resource    ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource    ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot

*** Test Cases ***
Init P-Key
    Log Notice
    # ${p_key_shipping_info}=    shipping_prompt
    # ${p_key_lv_c_tmvh}=    lv_c_tmvh_prompt
    # ${p_key_buy_with_package}=    buy_with_package

    ${p_key_shipping_info}=    Set Variable    2634908634297
    ${p_key_lv_c_tmvh}=        Set Variable    2634908634297
    ${p_key_buy_with_package}=        Set Variable    2634908634297

    Set Suite Variable    ${suite.p_key_shipping_info}    ${p_key_shipping_info}
    Set Suite Variable    ${suite.p_key_lv_c_tmvh}    ${p_key_lv_c_tmvh}
    Set Suite Variable    ${suite.p_key_buy_with_package}    ${p_key_buy_with_package}

Check Ui Floating Version
    [Tags]    check_version
    Check Version - Ui Floating Ads Souce Code

TC_iTM_02479 Display 'shipping info' on level D mobile
    [Tags]    TC_iTM_02479    Ready
    Given Ui Floating Ads - Go To Level D Mobile with Product Which Set Shipping Info

    Given Ui Floating Ads - Go To Lv D Page Using P-key Which Set Shipping Info
    Then Page Should Contain Shipping Fee Info
   [Teardown]    Close Browser

TC_iTM_03148 Display truemove h tag on level C - Search both TH and EN web
    [Tags]    TC_iTM_02479    Ready
    Given Search Product Which Set Lv C Truemoveh
    Then Page Should Contain Lv C Truemoveh Text

    Given Search Product Which Set Lv C Truemoveh On EN Home
    Then Page Should Contain Lv C Truemoveh Text
   [Teardown]    Close Browser

TC_iTM_03149 Display truemove h tag on level C - Category both TH and EN web
    [Tags]    TC_iTM_02479    Ready
    Given Ui Floating Ads - Open Level D with Product Which Set Lv C Truemoveh
    When Click Category Xpath
    Then Page Should Contain Lv C Truemoveh Text
   [Teardown]    Close Browser

TC_iTM_03150 Display 'buy package' both TH and EN web
    [Tags]    TC_iTM_03150    Ready
    Given Ui Floating Ads - Open Level D with Product Which Can Buy With Package
    Then Page Should Contain Buy With Package Button

    Given Ui Floating Ads - Go To Lv D Page Using P-key Which Can Buy With Package
    Then Page Should Contain En Buy With Package Button
    [Teardown]    Close Browser

TC_iTM_03161 Display coupon code on Level D at Coupon Code line
    [Tags]    TC_iTM_03161    Ready
    Given Ui Floating Ads - Open Level D with Product Which Can Buy With Package
    Then Page Should Contain Buy With Package Button

    Given Ui Floating Ads - Go To Lv D Page Using P-key Which Can Buy With Package
    Then Page Should Contain En Coupon Code Div

    [Teardown]    Close Browser


TC_iTM_03151 Not display COD info no.4 on checkout3 both TH and EN
    [Tags]    TC_iTM_03151    Ready    COD
    Given Guest Selects COD channel at checkout3 without making a payment    ${email}    ${default_inventoryID_cod}
    Then COD Info doesn't display no.4-ชำระเงินกับพนักงานส่งสินค้า




