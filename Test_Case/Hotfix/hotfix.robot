*** Settings ***
Library    Selenium2Library
Library    DateTime
Resource   ${CURDIR}/../../Resource/init.robot
Resource   ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource   ${CURDIR}/../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource   ${CURDIR}/../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot

Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_1/WebElement_Checkout1.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/WebElement_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/WebElement_Checkout3.robot

*** Variables ***
#${product_pkey}   2438379742814
#${sku}   NEAAA1111911

${product_pkey}   21202329441437L
${sku}   XIAAA1112211

${qty}   200
#${email}  robotautomate@gmail.com
#${password}   true1234
${email_qa}  metinee.yao@ascendcorp.com
${password_qa}   12345
${ITM_URL}    http://www.wemall-dev.com/
${Tel_qa}   0835629882
${Stock_Incress}    10000

*** Test Cases ***
Thankyou
	[Tags]  thankyou

#    : FOR    ${Loop_index}    IN RANGE    0    5

	Open Browser  ${ITM_URL}  ${BROWSER}
	Get User Id

	Stock - Increase Stock By Inventory Id  ${sku}    ${Stock_Incress}

	API Add Cart  ${PCMS_API_URL}   /api/v2/45311375168544/cart/add-item   ${TV_user_id}  ${TV_user_type}   ${sku}  ${qty}
	Go To    ${ITM_URL}/checkout/step1
	#User Enter Valid Data As Guest On Checkout1  ${email_qa}
	#User Enter Valid Data As Member On Checkout1  ${email}   ${password}
    #User Enter Valid Data As Guest On Checkout2    ${email_qa}

    #
    User Select Buy As Guest
    User Enter Valid Email On Checkout1  ${email_qa}
    User Click Next Button On Checkout1
    #

    #
    Wait Until All Element Is Visible On Checkout2
    User Enter Valid Name

    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${Tel_qa}

    User Enter Valid Email    ${email_qa}
    User Select Province As Bangkok
    User Select City As Suanluang
    User Select District As Suanluang
    User Select Zipcode As 10250
    User Enter Valid Address
    User Click Next Button
    #

    #Checkout 3 - User Enter Valid Data Master Card As Member
    #
    Display All CCW Information
    User Enter Valid Card Holder Name
    Checkout 3 - User Enter Valid Credit Card Number As Master Card
    User Enter Valid CVC
    User Select Valid Card Expired
    Wait Until Ajax Loading Is Not Visible
    User Click Submit Button On Checkout3
    Display Confirm Payment Popup

    ${Start_Time}    Get Time
    Log to Console    ${Start_Time}
    User Click Confirm Payment Button On Checkout3
    #

    ${Var_Obj_Order_ID}    Set Variable    //*[@id="thank_order_id"]
    ${Var_Order_ID}    Get Text    ${Var_Obj_Order_ID}

    Wait Until Element Is Visible    ${Var_Obj_Order_ID}    300
    ${End_Time}    Get Time

    Log To Console    **********************************************************
    Log To Console    ITM_URL : ${ITM_URL}
    Log To Console    TV_user_id : ${TV_user_id}
    Log To Console    TV_user_type :${TV_user_type}
    Log To Console    Email : ${email_qa}
    Log To Console    Tel : ${Tel_qa}
    Log To Console    qty : ${qty}
    Log To Console    Stock_Incress : ${Stock_Incress}
    Log To Console    Var_Order_ID : ${Var_Order_ID}
    Log To Console    StartTime : ${Start_Time}
    Log To Console    End_Time : ${End_Time}
    Log To Console    **********************************************************
    Log To Console    Order ID : ${Var_Order_ID} | QTY : ${qty} | StartTime : ${Start_Time} | EndTime : ${End_Time} | ProductKey : ${product_pkey} | SKU : ${sku}
    Log To Console    **********************************************************


    #[Teardown]   Close All Browsers
	#[Arguments]   ${customer_ref_id}    ${customer_type}    ${inventory_id}    ${qty}=1

Order Tracking
	[Tags]  order_tracking


Add_To_Cart
	[Tags]  Add_To_Cart
    ${inventory_id}    product.Get Inventory Normal
    Level D - Open Level D Using Invtory Id    ${inventory_id}
    Stock - Increase Stock By Inventory Id    ${inventory_id}    20000
    User Select Style Options Using Inventory Id    ${inventory_id}
    Level D - User Click Add To Cart Button
