*** Settings ***
Force Tags        WLS_Cart
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Email/keywords_email_sms.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Features/Portal_Main_Page_Mobile/keyword_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Features/Portal_Main_Page_Mobile/resource_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_1/keywords_checkout1_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_2/keywords_checkout2_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Full_cart/keywords_full_cart_mobile.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Mini_cart/keywords_mini_cart.robot

*** Test Cases ***
TC_iTM_02542 Merchant Name Does Not Display On full cart, mini cart, /cart (web version - 1 item)
    [Tags]    TC_iTM_02542    Ready  full_cart  merchant_name  mini_cart   cart     regression    WLS_High
    Given Database Product - Get Sku Normal

    When Level D - Open Browser Level D
    And Level D - User Select Style Options
    And Level D - User Click Add To Cart Button
    And Display Full Cart
    And Wait For Cart Loading
    Then Metchant Name Should Not Appear

    When Go To Cart Page
    Then Metchant Name Should Not Appear

    When User Click Next Process On Cart Page
    Then Metchant Name Should Not Appear

    When User Enter Valid Data As Member On Checkout1
    Then Metchant Name Should Not Appear

    When User Enter Valid Data As Member On Checkout2
    Then Metchant Name Should Not Appear

    #When User Enter Valid Data As Member On Checkout3
    #Then Metchant Name Should Not Appear
    [Teardown]    Close All Browsers


TC_iTM_02543 Merchant Name Does Not Display On full cart, mini cart, /cart (web version - 2 item)
    [Tags]    TC_iTM_02543    Ready  full_cart  merchant_name  mini_cart  cart      regression    WLS_Medium
    Given Prepare Two Shops
    And Prepare Two Variants
    And Stock - Increase Stock 100 Qtys

    When Level D - Go To Level Of First Shop and Select Item
    And Level D - User Select Style Options
    And Level D - User Click Add To Cart Button
    And Display Full Cart
    and Wait For Cart Loading
    Then Metchant Name Should Not Appear

    When Level D - Go To Level Of Second Shop and Select Item
    And Level D - User Select Style Options
    And Level D - User Click Add To Cart Button
    And Display Full Cart
    Then Metchant Name Should Not Appear

    When Go To Cart Page
    Then Metchant Name Should Not Appear

    When User Click Next Process On Cart Page
    Then Metchant Name Should Not Appear

    When User Enter Valid Data As Member On Checkout1
    Then Metchant Name Should Not Appear

    When User Enter Valid Data As Member On Checkout2
    Then Metchant Name Should Not Appear

    #When User Enter Valid Data As Member On Checkout3
    #Then Metchant Name Should Not Appear

    [Teardown]    Clear Shops And Policies

TC_iTM_02544 Merchant Name Does Not Display On mobile full cart, mini cart, /cart (mobile version - 1 item)
    [Tags]    TC_iTM_02544    Ready  full_cart   merchant_name  mini_cart  mobile   regression    WLS_High
    Given Database Product - Get Sku Normal

    When Level D Mobile - Open Browser Level D
    And Level D Mobile - User Select Style Options
    And Level D Mobile - User Click Add To Cart Button
    Then Full Cart Mobile - Merchant Name Should Not Appear

    When Full Cart Mobile - User Click Next Process On Cart Page
    Then Full Cart Mobile - Merchant Name Should Not Appear

    When Checkout 1 Mobile - User Enter Valid Data As Member On Checkout1
    Then Mini Cart Mobile - Merchant Name Should Not Appear

    When Checkout 2 Mobile - User Enter Valid Data As Member On Checkout2
    Then Mini Cart Mobile - Merchant Name Should Not Appear
    [Teardown]    Close All Browsers

TC_iTM_02545 Do not displayed merchant name at full cart, mini cart (Mobile version, 2 items different merchant)
#got this error often -> keyword from mobile -> Element locator '//div[@class='col-xs-12 title-cart'][contains(.,'สินค้าในตะกร้า')]' did not match any elements after 10 seconds
    [Tags]   TC_iTM_02545  full_cart  merchant_name  mini_cart  mobile NotReady
    Given Prepare Two Shops
    And Prepare Two Variants
    And Stock - Increase Stock 100 Qtys

    When Level D Mobile - Go To Level Of First Shop and Select Item
    And Level D Mobile - User Select Style Options
    And Click Buy Product
#   And Level D Mobile - User Click Add To Cart Button
    Then Full Cart Mobile - Merchant Name Should Not Appear

    When Level D Mobile - Go To Level Of Second Shop and Select Item
    And Level D Mobile - User Select Style Options
    And Click Buy Product
    Then Full Cart Mobile - Merchant Name Should Not Appear

    When Full Cart Mobile - User Click Next Process On Cart Page
    Then Mini Cart Mobile - Merchant Name Should Not Appear

    When Checkout Step1 By Guest
    Then Mini Cart Mobile - Merchant Name Should Not Appear

    When Checkout Step2 By Guest
    Then Mini Cart Mobile - Merchant Name Should Not Appear

     [Teardown]    Clear Shops And Policies

