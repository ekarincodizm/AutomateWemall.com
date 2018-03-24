*** Settings ***
Force Tags    WLS_PCMS_Product
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/init.robot
#Resource          web_element_mass_active_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Product_Set_Payment/web_elements_set_payment.robot
Resource          ${CURDIR}/../../../Python_Library/product.py
Test Setup        Login Pcms
Test Teardown     Close All Browsers

*** Test Cases ***
TC_iTM_03173 Can open Set Payment page without memory limit error
    [Tags]    TC_iTM_03173  regression  ready   product     PCMS    ITMA-3094   ITMA-S112016
    Go To Product Set Payment
    Location Should Contain             /products/set-payment
    Element Should Be Visible           id=product
    Element Should Be Visible           ${formsetpayment-filter-brand}
    Element Should Be Visible           ${formsetpayment-filter-shop}
    ${count}=   Get matching xpath count    ${formsetpayment-result-table}
    Should Be Equal As Integers         ${count}            6
    Element Should Contain              ${formsetpayment-result-table-th1}    Brand
    Element Should Contain              ${formsetpayment-result-table-th2}    Product Name
    Element Should Contain              ${formsetpayment-result-table-th3}    pkey / inventory_id
    Element Should Contain              ${formsetpayment-result-table-th4}    Net. Price
    Element Should Contain              ${formsetpayment-result-table-th5}    Special Price

TC_iTM_03174 Search by product name on Set Payment page
    [Tags]    TC_iTM_03174  regression  ready   product     PCMS    ITMA-3094   ITMA-S112016
    Go To Product Set Payment
    Input Text    id=product    iPhone
    Click Element               ${formsetpayment-filter-submit}
    Element Should Contain              ${formsetpayment-result-table-td2}    iPhone

TC_iTM_03175 Search by brand on Set Payment page
    [Tags]    TC_iTM_03175  regression  ready   product     PCMS    ITMA-3094   ITMA-S112016
    Go To Product Set Payment
    Input Text    ${formsetpayment-filter-brand}    Apple
    Click Element               ${formsetpayment-filter-submit}
    Element Should Contain              ${formsetpayment-result-table-td1}    Apple

TC_iTM_03176 Search by shop on Set Payment page
    [Tags]    TC_iTM_03176  regression  ready   product     PCMS    ITMA-3094   ITMA-S112016
    Go To Product Set Payment
    Input Text    ${formsetpayment-filter-shop}    ITRUEMART | 322963
    Click Element               ${formsetpayment-filter-submit}
    ${count}=   Get matching xpath count    ${formsetpayment-result-table-edit}
    Should Be Equal As Integers         ${count}            10

TC_iTM_03177 Search by product Name,brand,shop on Set Payment page
    [Tags]    TC_iTM_03177  regression  ready   product     PCMS    ITMA-3094   ITMA-S112016
    Go To Product Set Payment
    Input Text    id=product    iphone
    Input Text    ${formsetpayment-filter-brand}    Apple
    Input Text    ${formsetpayment-filter-shop}    ITRUEMART | 322963
    Click Element               ${formsetpayment-filter-submit}
    Element Should Contain              ${formsetpayment-result-table-td2}    iPhone
    Element Should Contain              ${formsetpayment-result-table-td1}    Apple

TC_iTM_03178 To verify that a user click page number on Set Payment page
    [Tags]    TC_iTM_03178  regression  ready   product     PCMS    ITMA-3094   ITMA-S112016
    Go To Product Set Payment
    Click Element                       ${formsetpayment-filter-submit}
    Wait Until Element Is Visible       ${formsetpayment-page-2}
    Click Element                       ${formsetpayment-page-2}
    ${count}=   Get matching xpath count    ${formsetpayment-result-table-edit}
    Should Be Equal As Integers         ${count}            10

TC_iTM_03200 next/previous list page open with 10 records displayed
    [Tags]    TC_iTM_03200  regression  ready   product     PCMS    ITMA-3094   ITMA-S112016
    Go To Product Set Payment
    Click Element                       ${formsetpayment-filter-submit}
    Wait Until Element Is Visible       ${formsetpayment-page-next}
    Click Element                       ${formsetpayment-page-next}
    ${count}=   Get matching xpath count    ${formsetpayment-result-table-edit}
    Should Be Equal As Integers         ${count}            10
    Wait Until Element Is Visible       ${formsetpayment-page-previous}
    Click Element                       ${formsetpayment-page-previous}
    ${count2}=   Get matching xpath count    ${formsetpayment-result-table-edit}
    Should Be Equal As Integers         ${count2}            10

TC_iTM_03125 Display product thumbnail on Set Payment
    [Tags]    TC_iTM_03125  regression  ready

    ${productrecord}=   py_get_product_has_image
    Log to Console   ${productrecord[0]["product_title"]}
    GO TO PRODUCT SET PAYMENT
    Input Text    id=product    ${productrecord[0]["product_title"]}
    Click Element               ${formsetpayment-filter-submit}
    Page Should Contain Element        //td[@class="table-center"]/img
