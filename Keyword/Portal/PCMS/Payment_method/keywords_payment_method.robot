*** Settings ***
Resource   ${CURDIR}/web_elements_payment_method.robot
#Library   ${CURDIR}/../../../pcms-robot-ux/Python_Library/DatabaseData.py
#Library   ${CURDIR}/../../../pcms-robot-ux/Python_Library/PaymentLib.py
Library   ${CURDIR}/../../../../Python_Library/product.py

*** Variables ***
${xpath-payment-method-container}     //div[contains(@class, "payment-method")]/div[@class="mws-panel-body"]


${xpath-payment-method-installment}         ${xpath-payment-method-container}/label[3]/input
${xpath-payment-method-atm}                 ${xpath-payment-method-container}/label[4]/input
${xpath-payment-method-ibanking}            ${xpath-payment-method-container}/label[5]/input
${xpath-payment-method-bank-transfer}       ${xpath-payment-method-container}/label[6]/input
${xpath-payment-method-counter-service}     ${xpath-payment-method-container}/label[7]/input

${xpath-bank-installment-container}     //div[contains(@class, "bank-installment")][1]/div[@class="mws-panel-body"]
${xpath-installment-allow-promotion-container}      //div[contains(@class, "bank-installment")][2]/div[@class="mws-panel-body"]

${xpath-allow-promotion}    name=allow_promotion

${xpath-set-payment-save-button}      //div[contains(@class, "bank-installment")][2]/div[contains(@class, "mws-panel-body")][2]/div/div/input

${xpath-set-payment-save-button-no-installment}      //div[contains(@class, "payment-method")]/div[contains(@class, "mws-panel-body")][2]/div/div/input

*** Keywords ***
Set All Payment Channel By Inventory
    [Arguments]  ${inv_id}
    # Not finish only cs / installment / wallet
    Go To Set Payment Page
    User Enter Product Name On Set Payment Channel Page By Inventory Id   ${inv_id}
    User Click Search Button On Set Payment Channel Page
    User Click Edit Button First Product On Set Payment Channel Page
    User Is Ticked Checkbox Installment
    User Is Ticked Allow Promotion Code For Installment
    User Is Ticked Checkbox Counter Service
  #     bank ATM (ATM)
  #     IBANK (IBANK)
  #     BANKTRANS (BANKTRANS)
    User Is Ticked Checkbox E-Wallet
    User Select All Bank For Installment
    User Click Save Button On Set Payment Channel Page

Set Payment Channel Ccw All Step For Mnp Product
    ${is_exist}=  Is Has Only Payment Method Ccw For Mnp Product
    Log to console  is-exist=${is_exist}
    Run Keyword If  '${is_exist}' == 'True'  Return From Keyword  ${EMPTY}
    Login Pcms
    Go To Set Payment Page
    User Enter Product Name On Set Payment Channel Page
    User Click Search Button On Set Payment Channel Page
    User Click Edit Button First Product On Set Payment Channel Page
    User Unchoose All Payment Channel And Click Save
    Close Browser

Set Payment Channel Ccw All Step For Normal Product
    ${is_exist}=  Is Has Only Payment Method Ccw For Normal Product
    Run Keyword If  '${is_exist}' == 'True'  Return From Keyword  ${EMPTY}
    Login Pcms
    Go To Set Payment Page
    User Enter Product Name On Set Payment Channel Page
    User Click Search Button On Set Payment Channel Page
    User Click Edit Button First Product On Set Payment Channel Page
    User Unchoose All Payment Channel And Click Save
    Close Browser

Set Payment Channel Ccw And Installment All Step For Mnp Product
    ${is_exist}=  Is Has Only Payment Method Counter Service For Mnp Product
    Run Keyword If  '${is_exist}' == 'True'  Return From Keyword  ${EMPTY}
    Login Pcms
    Go To Set Payment Page
    User Enter Product Name On Set Payment Channel Page
    User Click Search Button On Set Payment Channel Page
    User Click Edit Button First Product On Set Payment Channel Page
    User Unchoose All Payment Channel
    Choose All Bank Installment
    Close Browser

Set Payment Channel Ccw And Installment All Step For Normal Product
    ${is_exist}=  Is Has Only Payment Method Counter Service For Normal Product
    Run Keyword If  '${is_exist}' == 'True'  Return From Keyword  ${EMPTY}
    Login Pcms
    Go To Set Payment Page
    User Enter Product Name On Set Payment Channel Page
    User Click Search Button On Set Payment Channel Page
    User Click Edit Button First Product On Set Payment Channel Page
    User Unchoose All Payment Channel
    Choose All Bank Installment
    Close Browser

Set Payment Channel Ccw And Counter Service All Step For Mnp Product
    ${is_exist}=  Is Has Only Payment Method Counter Service For Mnp Product
    Run Keyword If  '${is_exist}' == 'True'  Return From Keyword  ${EMPTY}
    Login Pcms
    Go To Set Payment Page
    User Enter Product Name On Set Payment Channel Page
    User Click Search Button On Set Payment Channel Page
    User Click Edit Button First Product On Set Payment Channel Page
    User Unchoose All Payment Channel
    Choose Payment Method Counter Service
    Close Browser

Set Payment Channel Ccw And Counter Service All Step For Normal Product
    ${is_exist}=  Is Has Only Payment Method Counter Service For Normal Product
    Run Keyword If  '${is_exist}' == 'True'  Return From Keyword  ${EMPTY}
    Login Pcms
    Go To Set Payment Page
    User Enter Product Name On Set Payment Channel Page
    User Click Search Button On Set Payment Channel Page
    User Click Edit Button First Product On Set Payment Channel Page
    User Unchoose All Payment Channel
    Choose Payment Method Counter Service
    Close Browser

Is Has Only Payment Method Ccw For Mnp Product
    ${inv_id}=  Get From Dictionary  ${TEST_VAR}  sku_sim
    ${product_id}=   Get Product Id   ${inv_id}
    ${is_exist}=  Py Is Has Only Payment Method  ${product_id}  1
    [Return]  ${is_exist}

Is Has Only Payment Method Installment For Mnp Product
    ${inv_id}=  Get From Dictionary  ${TEST_VAR}   sku_sim
    ${product_id}=   Get Product Id   ${inv_id}
    ${is_exist}=  Py Is Has Only Payment Method  ${product_id}  3
    [Return]  ${is_exist}

Is Has Only Payment Method Counter Service For Mnp Product
    ${inv_id}=   Get From Dictionary  ${TEST_VAR}  sku_sim
    ${product_id}=   Get Product Id   ${inv_id}
    ${is_exist}=  Py Is Has Only Payment Method  ${product_id}  8
    [Return]  ${is_exist}

Is Has Only Payment Method Ccw For Normal Product
    ${inv_id}=  Get From Dictionary  ${TEST_VAR}  inv_id_normal
    ${product_id}=   Get Product Id   ${inv_id}
    ${is_exist}=  Py Is Has Only Payment Method  ${product_id}  1
    [Return]  ${is_exist}

Is Has Only Payment Method Installment For Normal Product
    ${inv_id}=  Get From Dictionary  ${TEST_VAR}   inv_id_normal
    ${product_id}=   Get Product Id   ${inv_id}
    ${is_exist}=  Py Is Has Only Payment Method  ${product_id}  3
    [Return]  ${is_exist}

Is Has Only Payment Method Counter Service For Normal Product
    ${inv_id}=   Get From Dictionary  ${TEST_VAR}  inv_id_normal
    ${product_id}=   Get Product Id   ${inv_id}
    ${is_exist}=  Py Is Has Only Payment Method  ${product_id}  8
    [Return]  ${is_exist}

Go To Set Payment Page
    Go To    ${URL_PCMS.set_payment}

Payment Method - User Enter Any Product On Search Box

    ${inv_id}=   product.get_1inventory_id   6629

    Log to console   ====== inv_id=${inv_id} ======

    ${product}=  Get Product Detail  ${inv_id}
    ${product_id}=   Get From List   ${product}   0
    ${product_pkey}=   Get From List   ${product}   1
    ${product_name}=   Get From List   ${product}   2
    ${product_slug}=   Get From List   ${product}   3


    Log to console   ==== product_id FROM get_product_detail=${product_id} ====
    Log to console   ==== product_pkey FROM get_product_detail=${product_pkey} ====
    Log to console   ==== product_name FROM get_product_detail=${product_name} ====
    Log to console   ==== product_slug FROM get_product_detail=${product_slug} ====


    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${TIMEOUT}
    Input Text  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${product_name}


    Wemall Common - Assign Value To Test Variable   inv_id   ${inv_id}
    Wemall Common - Assign Value To Test Variable   product_id   ${product_id}
    Wemall Common - Assign Value To Test Variable   product_pkey   ${product_pkey}
    Wemall Common - Assign Value To Test Variable   product_name   ${product_name}
    Wemall Common - Assign Value To Test Variable   product_slug   ${product_slug}

    # ${dict}=   Set Variable  ${TEST_VAR}
    # Set To Dictionary  ${dict}   inv_id=${inv_id}
    # Set To Dictionary  ${dict}   product_id=${product_id}
    # Set To Dictionary  ${dict}   product_pkey=${product_pkey}
    # Set To Dictionary  ${dict}   product_name=${product_name}
    # Set To Dictionary  ${dict}   product_slug=${product_slug}

    # Set Test Variable   ${TEST_VAR}  ${dict}

User Enter Product Name On Set Payment Channel Page By Inventory Id
    [Arguments]  ${inv_id}
    ${product_name}=  Get Product Name  ${inv_id}
    Log To Console  product_name=${product_name}
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${TIMEOUT}
    Input Text  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${product_name}

User Enter Product Name On Set Payment Channel Page
    ${inv_id}=  Get From Dictionary   ${TEST_VAR}  sku_sim
    ${product_name}=  Get Product Name  ${inv_id}
    Log To Console  product_name=${product_name}
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${TIMEOUT}
    Input Text  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${product_name}

User Enter Mnp Device Name On Set Payment Channel Page
    ${inv_id}=  Get From Dictionary   ${TEST_VAR}  sku_device
    ${product_name}=  Get Product Name  ${inv_id}
    Log To Console  product_name=${product_name}
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${TIMEOUT}
    Input Text  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${product_name}

User Enter Bundle Device Name On Set Payment Channel Page
    #${inv_id}=  Get From Dictionary   ${TEST_VAR}  sku_device

    ${product_name}=  Get Product Name   ${var_tmh_product_device_inventory_id}
    Log To Console  product_name=${product_name}
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${TIMEOUT}
    Input Text  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${product_name}

User Enter Bundle Sim Name On Set Payment Channel Page
    #${inv_id}=  Get From Dictionary   ${TEST_VAR}  sku_device

    ${product_name}=  Get Product Name   ${var_tmh_device_sub_inventory_id}
    Log To Console  product_name=${product_name}
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${TIMEOUT}
    Input Text  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${product_name}

User Enter Normal Product Name On Set Payment Channel Page
    ${inv_id}=  Get From Dictionary   ${TEST_VAR}  inv_id_normal
    ${product_name}=  Get Product Name  ${inv_id}
    Log To Console  product_name=${product_name}
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${TIMEOUT}
    Input Text  ${XPATH_PAYMENT_CHANNEL.txt_product_name}   ${product_name}

User Click Search Button On Set Payment Channel Page
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.btn_search}
    Click Element  ${XPATH_PAYMENT_CHANNEL.btn_search}

Payment Method - User Click Search Button
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.btn_search}
    Click Element  ${XPATH_PAYMENT_CHANNEL.btn_search}

User Click Edit Button First Product On Set Payment Channel Page
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.btn_edit_first}  30s
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.btn_edit_first}   30s
    Click Element  ${XPATH_PAYMENT_CHANNEL.btn_edit_first}

Set Payment Channel Ccw
	User Is Ticked Checkbox Ccw
	User Click Save Button On Set Payment Channel Page

Set Payment Channel Cs
	User Is Ticked Checkbox Counter Service
	User Click Save Button On Set Payment Channel Page

Set Payment Channel Installment
	User Is Ticked Checkbox Installment
	User Click Save Button On Set Payment Channel Page

Set Payment Channel Cod
	User Is Ticked Checkebox Cod
	User Click Save Button On Set Payment Channel Page

User Is Ticked Allow Promotion Code For Installment
	Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.chk_allow_promotion_code}  ${TIMEOUT}
	Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_allow_promotion_code}

User Is Ticked Checkbox Ccw
	Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.chk_ccw}  ${TIMEOUT}
	Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_ccw}

User Is Ticked Checkbox Counter Service
	Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.chk_counter_service}  ${TIMEOUT}
    Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_counter_service}

User Is Ticked Checkbox Installment
    Log to console   checkbox installment
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_installment}  ${TIMEOUT}
	Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.chk_installment}  ${TIMEOUT}
	Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_installment}

User Is Ticked Checkbox E-Wallet
    Log to console   checkbox ewallet
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.chk_ewallet}  ${TIMEOUT}
    Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_ewallet}

User Is Ticked Checkbox Cod
	Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.chk_cod}  ${TIMEOUT}
	Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_cod}

Unchoose Payment Method E-Wallet
    Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.chk_ewallet}  ${TIMEOUT}
    Unselect Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_ewallet}

User Click Save Button On Set Payment Channel Page
	Wait Until Element Is Visible  ${XPATH_PAYMENT_CHANNEL.btn_save}  ${TIMEOUT}
	Click Element  ${XPATH_PAYMENT_CHANNEL.btn_save}

User Select All Bank For Installment
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Select Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    \    User Select All Period Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]


User Select All Period Under Bank
    [Arguments]  ${container}
    ${rows}=   Get Matching Xpath Count  ${container}/li
    ${rows}=   Set Variable  ${rows} + 1
    :FOR  ${index}  IN RANGE  1  ${rows}
    \  Select Checkbox  ${container}/li[${index}]/label/input

#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=
Set Product Installment All Bank And All Months
    [Arguments]     ${inv_id}     ${allow_promotion}=1


    ${product_name}=    Get Product Name    ${inv_id}
    Go To Product Set Payment
    Wait Until Page Contains Element    id=product     60

    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}
    Choose All Bank Installment
    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion    ELSE    Not Choose Allow Promotion

    Click Set Payment Save Button
    Sleep    3s


Set Product Installment Some Bank
    [Arguments]    ${inv_id}    ${bank}=None      ${allow_promotion}=1
    ${product_name}=    Get Product name    ${inv_id}
    Go To Product Set Payment
    Wait Until page Contains Element   id=product    60
    Input Text     id=product    ${product_name}
    Click Element    ${xpath-search-button}

    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}

    Choose Some Bank Installment    ${bank}
    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion    ELSE    Not Choose Allow Promotion

    Click Set Payment Save Button



Set Product 2 Items Installment All Bank And All Months
    [Arguments]     ${inv_id1}    ${inv_id2}     ${allow_promotion}=1


    ${product_name}=    Get Product Name    ${inv_id1}
    Go To Product Set Payment
    Wait Until Page Contains Element    id=product     60

    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}
    Choose All Bank Installment
    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion

    Click Set Payment Save Button

    ### Items 2 ###
    ${product_name}=    Get Product Name    ${inv_id2}

    Redirect To Product Set Payment
    Wait Until Page Contains Element    id=product     60


    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}


    # Click Payment method install
    Wait Until Element Is Visible      ${xpath-payment-method-installment}
    Select Checkbox    ${xpath-payment-method-installment}


    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1



    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Select Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    \    Choose All Period Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]


    Run Keyword If    '${allow_promotion}' == '1'     Choose Allow Promotion

    Click Set Payment Save Button

# Set Product Installment Some Bank All Months
#     [Arguments]    ${inv_id}    @{bank}[0]=1     ${allow_promotion}=1
#     Log to console    @{bank}



Set Product Payment Channel
    [Arguments]    ${inv_id}    ${payment_channel}

    Go To Product Set Payment
    ${product_name}=    Get Product Name     ${inv_id}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}     60

    # Click Edit Button on first product
    Click Element     ${xpath-set-payment-first-edit-button}

    ${has-installment}=    Is Key Exist     ${payment_channel}      installment
    ${has-atm}=    Is Key Exist     ${payment_channel}     atm
    ${has-ibanking}=    Is Key Exist     ${payment_channel}     ibank
    ${has-bank-transfer}=    Is Key Exist     ${payment_channel}     banktrans
    ${has-counter-service}=     Is Key Exist     ${payment_channel}     cs

    Log To Console     has-installment=${has-installment}
    Run Keyword If    '${has-installment}' == 'True'    Choose Payment Method Installment    ELSE    Unchoose Payment Method Installment

    Run Keyword If    '${has-atm}' == 'True'    Choose Payment Method ATM    ELSE   Unchoose Payment Method ATM
    Run Keyword If    '${has-ibanking}' == 'True'    Choose Payment Method Ibanking     ELSE    Unchoose Payment Method IBanking

    Run Keyword If    '${has-bank-transfer}' == 'True'    Choose Payment Method Bank Transfer    ELSE     Unchoose Payment Method Bank Transfer

    Run Keyword If   '${has-counter-service}' == 'True'    Choose Payment Method Counter Service    ELSE    Unchoose Payment Method Counter Service

    Run Keyword If    '${has-installment}' == 'True'    Click Set Payment Save Button    ELSE    Click Set Payment Save Button No Installment


Remove All Payment Channel
    [Arguments]     ${inv_id}

    Go To Product Set Payment
    ${product_name}=    Get Product Name     ${inv_id}
    Wait Until Page Contains Element    id=product     60
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${XPATH_PAYMENT_CHANNEL.btn_edit_first}     60

    # Click Edit Button on first product
    Click Element     ${XPATH_PAYMENT_CHANNEL.btn_edit_first}
    Unchoose Payment Method Installment
    Unchoose Payment Method ATM
    Unchoose Payment Method IBanking
    Unchoose Payment Method Bank Transfer
    Unchoose Payment Method Counter Service
    Unchoose Payment Method E-Wallet
    Click Set Payment Save Button No Installment

User Unchoose All Payment Channel
    Unchoose Payment Method Installment
    Unchoose Payment Method ATM
    Unchoose Payment Method IBanking
    Unchoose Payment Method Bank Transfer
    Unchoose Payment Method Counter Service
    Unchoose Payment Method E-Wallet



User Unchoose All Payment Channel And Click Save
    Unchoose Payment Method Installment
    Unchoose Payment Method ATM
    Unchoose Payment Method IBanking
    Unchoose Payment Method Bank Transfer
    Unchoose Payment Method Counter Service
    Unchoose Payment Method E-Wallet
    Click Set Payment Save Button No Installment

Choose Some Bank Installment
    [Arguments]     ${bank}=None

    Log To Console    bank=${bank}

    ${has-kbank}=    Is Key Exist     ${bank}      kbank
    ${has-bay}=    Is Key Exist     ${bank}     bay
    ${has-central}=    Is Key Exist     ${bank}     central
    ${has-firstchoice}=    Is Key Exist     ${bank}     firstchoice
    ${has-lotus}=     Is Key Exist     ${bank}     lotus
    ${has-ktc}=    Is Key Exist      ${bank}     ktc
    ${has-bbl}=    Is Key Exist      ${bank}     bbl

    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Unselect Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]


    Run Keyword If    '${has-kbank}' == 'True'     Select Bank And All Period    1
    Run Keyword If    '${has-bay}' == 'True'     Select Bank And All Period    2
    Run Keyword If    '${has-central}' == 'True'     Select Bank And All Period    3
    Run Keyword If    '${has-firstchoice}' == 'True'     Select Bank And All Period    4
    Run Keyword If    '${has-lotus}' == 'True'     Select Bank And All Period    5
    Run Keyword If    '${has-ktc}' == 'True'     Select Bank And All Period    6
    Run Keyword If    '${has-bbl}' == 'True'     Select Bank And All Period    7


Select Bank And All Period
    [Arguments]      ${index}
    Select Checkbox    ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    Choose All Period Under Bank   ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]


Choose All Bank Installment
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Select Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    \    Choose All Period Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]

Unchoose All Bank Installment
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Unselect Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]

Payment Method - User Unselect All Bank
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \    Unselect Checkbox     ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]

Payment Method - User Select Installment All Bank And 10 Month Period
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}
    \  Select Checkbox  ${xpath-bank-installment-container}/div[${index}]/label/input[@type="checkbox"]
    \  Payment Method - User Select Period 10 Months Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]

Payment Method - User Select Installment All Bank And 6 Month Period
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}

    \  Payment Method - User Select Period 6 Months Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]


Payment Method - User Select Installment All Bank And 3 Month Period
    ${count-bank-can-installment}=    Get Matching XPath Count    ${xpath-bank-installment-container}/div
    ${count-bank-can-installment}=    Evaluate    ${count-bank-can-installment} + 1
    :FOR  ${index}  IN RANGE  1  ${count-bank-can-installment}

    \  Payment Method - User Select Period 3 Months Under Bank    ${xpath-bank-installment-container}/div[${index}]/ul[@class="installment"]

Click Set Payment Save Button
    Wait Until Element Is Visible     ${xpath-set-payment-save-button}
    Click Element     ${xpath-set-payment-save-button}

Payment Method - User Click Save Button With Installment
    Wait Until Element Is Visible     ${xpath-set-payment-save-button}
    Click Element     ${xpath-set-payment-save-button}

Click Set Payment Save Button No Installment
    Wait Until Element Is Visible    ${xpath-set-payment-save-button-no-installment}
    Click Element     ${xpath-set-payment-save-button-no-installment}

Payment Method - User Click Save button Without Installment

    Wait Until Page Contains Element  ${xpath-set-payment-save-button-no-installment}  30s
    Wait Until Element Is Visible    ${xpath-set-payment-save-button-no-installment}   30s
    Click Element     ${xpath-set-payment-save-button-no-installment}

Choose Allow Promotion
    Select Checkbox     ${xpath-allow-promotion}

Not Choose Allow Promotion
    Unselect Checkbox    ${xpath-allow-promotion}

Choose Bank Installment KBank
    Select Checkbox    ${xpath-bank-installment-container}/div[1]/label/input[@type="checkbox"]

Unchoose Bank Installment KBank
    Unselect Checkbox    ${xpath-bank-installment-container}/div[1]/label/input[@type="checkbox"]

Choose Bank Installment Bay
    Select Checkbox    ${xpath-bank-installment-container}/div[2]/label/input[@type="checkbox"]

Unchoose Bank Installment Bay
    Unselect Checkbox    ${xpath-bank-installment-container}/div[2]/label/input[@type="checkbox"]

Choose Bank Installment Central
    Select Checkbox    ${xpath-bank-installment-container}/div[3]/label/input[@type="checkbox"]

Unchoose Bank Installment Central
    Unselect Checkbox    ${xpath-bank-installment-container}/div[3]/label/input[@type="checkbox"]

Choose Bank Installment Firstchoice
    Select Checkbox    ${xpath-bank-installment-container}/div[4]/label/input[@type="checkbox"]

Unchoose Bank Installment Firstchoice
    Unselect Checkbox    ${xpath-bank-installment-container}/div[4]/label/input[@type="checkbox"]

Choose Bank Installment Testco
    Select Checkbox    ${xpath-bank-installment-container}/div[5]/label/input[@type="checkbox"]

Unchoose Bank Installment Testco
    Unselect Checkbox    ${xpath-bank-installment-container}/div[5]/label/input[@type="checkbox"]

Choose Bank Installment KTC
    Select Checkbox    ${xpath-bank-installment-container}/div[6]/label/input[@type="checkbox"]

Unchoose Bank Installment KTC
    Unselect Checkbox    ${xpath-bank-installment-container}/div[6]/label/input[@type="checkbox"]

Choose Bank Installment BBL
    Select Checkbox    ${xpath-bank-installment-container}/div[7]/label/input[@type="checkbox"]

Unchoose Bank Installment BBL
    Unselect Checkbox    ${xpath-bank-installment-container}/div[7]/label/input[@type="checkbox"]

Choose Payment Method Installment
    Select Checkbox     ${xpath-payment-method-installment}

Unchoose Payment Method Installment
    Unselect Checkbox     ${xpath-payment-method-installment}

Choose Payment Method ATM
    Select Checkbox    ${xpath-payment-method-atm}

Unchoose Payment Method ATM
    Unselect Checkbox    ${xpath-payment-method-atm}

Choose Payment Method IBanking
    Select Checkbox    ${xpath-payment-method-ibanking}

Unchoose Payment Method IBanking
    Unselect Checkbox    ${xpath-payment-method-ibanking}

Choose Payment Method Bank Transfer
    Select Checkbox    ${xpath-payment-method-bank-transfer}

Unchoose Payment Method Bank Transfer
    Unselect Checkbox    ${xpath-payment-method-bank-transfer}

Choose Payment Method Counter Service
    Select Checkbox    ${xpath-payment-method-counter-service}

Unchoose Payment Method Counter Service
    Unselect Checkbox    ${xpath-payment-method-counter-service}


#Payment Method - User Unchoose All Bank Installment

Payment Method - User Select Bank KBank
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_kbank}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_kbank}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_kbank}

Payment Method - User Unselect Bank KBank

    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_kbank}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_kbank}  ${TIMEOUT}
    Unselect Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_kbank}

Payment Method - User Select Bank Kbank 10 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_kbank_period_container}/li[3]  ${TIMEOUT}
    Select Checkbox   ${XPATH_PAYMENT_CHANNEL.chk_kbank_period_container}/li[3]/label/input[@type="checkbox"]

Payment Method - User Select Bank Kbank 6 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_kbank_period_container}/li[3]  ${TIMEOUT}
    Select Checkbox   ${XPATH_PAYMENT_CHANNEL.chk_kbank_period_container}/li[2]/label/input[@type="checkbox"]

Payment Method - User Select Bank Kbank 3 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_kbank_period_container}/li[3]  ${TIMEOUT}
    Select Checkbox   ${XPATH_PAYMENT_CHANNEL.chk_kbank_period_container}/li[1]/label/input[@type="checkbox"]


Payment Method - User Select Bank Bay
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_bay}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_bay}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_bay}

Payment Method - User Select Bank Bay 10 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_bay_period_container}   ${TIMEOUT}/li[3]
    Select Checkbox   ${XPATH_PAYMENT_CHANNEL.chk_bay_period_container}/li[3]



Payment Method - User Unselect Bank Bay
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_bay}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_bay}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_bay}

Payment Method - User Select Central Card
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_central}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_central}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_central}

Payment Method - User Select Central Card 10 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_central_period_container}  ${TIMEOUT}
    Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_central_period_container}/li[3]

Payment Method - User Unselect Central Card
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_central}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_central}  ${TIMEOUT}
    Unselect Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_central}


Payment Method - User Select First Choice
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_first_choice}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_first_choice}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_first_choice}

Payment Method - User Select First Choice 10 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_first_choice}  ${TIMEOUT}
    Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_first_choice}/li[3]

Payment Method - User Unselect First Choice
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_first_choice}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_first_choice}  ${TIMEOUT}
    Unselect Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_first_choice}

Payment Method - User Select Tesco Lotus
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_tesco}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_tesco}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_tesco}

Payment Method - User Select Tesco Lotus 10 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_tesco}  ${TIMEOUT}
    Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_tesco}

Payment Method - User Unselect Tesco Lotus
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_tesco}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_tesco}  ${TIMEOUT}
    Unselect Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_tesco}

Payment Method - User Select KTC
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_ktc}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_ktc}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_ktc}

Payment Method - User Select KTC 10 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_ktc}  ${TIMEOUT}
    Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_ktc}

Payment Method - User Unselect KTC
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_ktc}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_ktc}  ${TIMEOUT}
    Unselect Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_ktc}


Payment Method - User Select BBL
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_bbl}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_bbl}  ${TIMEOUT}
    Select Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_bbl}

Payment Method - User Select BBL 10 Months Period
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_bbl}  ${TIMEOUT}
    Select Checkbox  ${XPATH_PAYMENT_CHANNEL.chk_bbl}

Payment Method - User Unselect BBL
    Wait Until Element Is Visible   ${XPATH_PAYMENT_CHANNEL.chk_bbl}  ${TIMEOUT}
    Wait Until Page Contains Element  ${XPATH_PAYMENT_CHANNEL.chk_bbl}  ${TIMEOUT}
    Unselect Checkbox    ${XPATH_PAYMENT_CHANNEL.chk_bbl}

Choose All Period Under Bank
    [Arguments]     ${xpath-container}

    ${count-period}=    Get Matching Xpath Count    ${xpath-container}/li
    ${count-period}=    Evaluate    ${count-period} + 1
    Log to console   count-period=${count-period}
    :FOR  ${index}  IN RANGE  1  ${count-period}
    \    Select Checkbox    ${xpath-container}/li[${index}]/label/input[@type="checkbox"]



Payment Method - User Select Period 3 Months Under Bank
    [Arguments]     ${xpath-container}

    ${count-period}=    Get Matching Xpath Count    ${xpath-container}/li
    ${count-period}=    Evaluate    ${count-period} + 1
    Log to console   count-period=${count-period}
    :FOR  ${index}  IN RANGE  1  ${count-period}
    \    ${count}=   Get Matching Xpath Count    ${xpath-container}/li[${index}]/label/input[@type="checkbox" and @value="3"]
    \    Run Keyword If  '${count}' == '1'   Select Checkbox  ${xpath-container}/li[${index}]/label/input[@type="checkbox" and @value="3"]

Payment Method - User Select Period 6 Months Under Bank
    [Arguments]     ${xpath-container}

    ${count-period}=    Get Matching Xpath Count    ${xpath-container}/li
    ${count-period}=    Evaluate    ${count-period} + 1
    Log to console   count-period=${count-period}
    :FOR  ${index}  IN RANGE  1  ${count-period}
    \    ${count}=   Get Matching Xpath Count    ${xpath-container}/li[${index}]/label/input[@type="checkbox" and @value="6"]
    \    Run Keyword If  '${count}' == '1'   Select Checkbox  ${xpath-container}/li[${index}]/label/input[@type="checkbox" and @value="6"]


Payment Method - User Select Period 10 Months Under Bank
    [Arguments]     ${xpath-container}

    ${count-period}=    Get Matching Xpath Count    ${xpath-container}/li
    ${count-period}=    Evaluate    ${count-period} + 1
    Log to console   count-period=${count-period}
    :FOR  ${index}  IN RANGE  1  ${count-period}
    \    Wait Until Page Contains Element  ${xpath-container}/li[${index}]/label/input[@type="checkbox"]
    \    ${count}=   Get Matching Xpath Count    ${xpath-container}/li[${index}]/label/input[@type="checkbox" and @value="10"]

    \    Log To Console  count=${count}
    \    Run Keyword If  '${count}' == '1'   Select Checkbox  ${xpath-container}/li[${index}]/label/input[@type="checkbox" and @value="10"]
