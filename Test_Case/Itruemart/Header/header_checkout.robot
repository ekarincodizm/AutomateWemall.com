*** Settings ***
Resource   ${CURDIR}/../../../Resource/init.robot
Library    Selenium2Library
Library    ${CURDIR}/../../../Python_Library/mnp_util.py
Resource   ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource   ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource   ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Footer/keywords_footer.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot

Test Tear Down   Close All Browsers
Test Setup   Initialize Test Variable

*** Keywords ***
Initialize Test Variable
	${dict}=   Create Dictionary   page=leveld
	Set Test Variable  ${TEST_VAR}  ${dict}

*** Test Cases ***
TC_iTM_02356 Display new wemall header at checkout 1, 2, 3 as member if configuration of puppet is site = wemall (TH)
	[Tags]  TC_iTM_02356    QCT    checkout1  checkout2  checkout3  thankyou  wemall_header  wemall_footer   ready  regression

    Given Header - Product on Level D
    When Header - User Add to Cart and Go To Checkout 1
    Then Header - Should Display WeMall Header
    And Header - Should Display WeMall Footer
    And Header - Should Display WeMall Logo
    And Header - Should Display User as Guest
    And Header - Should Display Checkout Step 1

    When Header - User Login and Go To Checkout 2
    Then Header - Should Display WeMall Header
    And Header - Should Display WeMall Footer
    And Header - Should Display WeMall Logo
    And Header - Should Display User as Member
    And Header - Should Display Checkout Step 2

    When Header - User Select Address and Go To Checkout 3
    Then Header - Should Display WeMall Header
    And Header - Should Display WeMall Footer
    And Header - Should Display WeMall Logo
    And Header - Should Display User as Member
    And Header - Should Display Checkout Step 3

    When Header - User Submit Checkout Button and Go To Thankyou Page
    Then Header - Should Display WeMall Header
    And Header - Should Display WeMall Footer
    And Header - Should Display WeMall Logo
    And Header - Should Display User as Member

TC_iTM_02357 Display new wemall header at checkout 1, 2, 3 as guest if configuration of puppet is site = wemall (EN)
	[Tags]  TC_iTM_02357  checkout1  checkout2  checkout3  thankyou  wemall_header  wemall_footer  ready    regression

    Given Header - Product on Level D EN
    When User Click Next Process On Full Cart
    Then Header - Wemall Logo Is Displayed
    And Header - Wemall Header Is Displayed
    And Header - Wemall Should Display User as Guest
    And Header - Wemall Navigator Checkout 1 Is Active

    When User Enter Valid Data As Guest On Checkout1
    Then Display Checkout Step2 Page
    And Header - Wemall Logo Is Displayed
    And Header - Wemall Header Is Displayed
    And Header - Wemall Should Display User as Guest
    And Header - Wemall Navigator Checkout 2 Is Active

    Then User Enter Valid Data As Guest On Checkout2 EN
    And Header - Wemall Logo Is Displayed
    And Header - Wemall Header Is Displayed
    And Header - Wemall Should Display User as Guest
    And Header - Wemall Navigator Checkout 3 Is Active

    Then Checkout 3 - User Enter Valid Data Master Card As Member
    And Header - Wemall Logo Is Displayed
    And Header - Wemall Header Is Displayed
    And Header - Wemall Should Display User as Guest
    And Header - Wemall Navigator Thankyou Is Active
