*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Library           HttpLibrary.HTTP
Library           DateTime
Library           Collections
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTruemart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Common/keywords_date.robot
Library           ${CURDIR}/../../Python_Library/product.py
Library           ${CURDIR}/../../Python_Library/mnp_util.py

Suite Setup     Prepare SKU
# Suite Teardown    Delete Product Bundle

*** Keywords ***

Get product pkey From SKU
	${inven_ID}=    get_inventory_normal
	${product_pkey}=   product.get_product_pkey    ${inven_ID}
	[return]    ${product_pkey}

Prepare SKU
	${product_pkey}=    Get product pkey From SKU
	Open Browser ITM-levelD    xxxx-${product_pkey}

*** Test Cases ***

TC_iTM_02253_Newly added address for member without saved address can be used (log in with e-mail)
	[Tags]   TC_iTM_02253    AA   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
    Level D Choose Product Color
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Add New Address Button
    The E-mail Using Logging From Step1 Is Displayed
    User Enter Valid Name Edit
    User Select Province As Bangkok
    User Select City As Suanluang
    User Select District As Suanluang
    User Select Zipcode As 10250
    User Enter Valid Address
    User Click Next Button
    New Address Should Be Selected And Show New Address
    ${name}=    User Click Send The Address
    The New Address Should Be Show At Checkout3
    User Click Payment Channel Counter Service Tab
    Checkout3 - Click Submit
    E-mail Shows Shipping Address Same As Input In Checkout2

TC_iTM_02254_Newly added address for member with saved address can be used (log in with e-mail)
	[Tags]   TC_iTM_02254    bb    ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Add New Address Button
    User Enter Valid Data As Guest On Checkout2
    Should Be Go To Step2
    New Address Should Be Selected

TC_iTM_02255_Newly added address for member without saved address can be used (log in with mobile no)
	[Tags]    TC_iTM_02255    cc   ***
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1 With Tel no
    User Click Add New Address Button
    The E-mail Using Logging From Step1 Is Displayed
    User Enter Valid Name Edit
    User Select Province As Bangkok
    User Select City As Suanluang
    User Select District As Suanluang
    User Select Zipcode As 10250
    User Enter Valid Address
    User Click Next Button
    New Address Should Be Selected And Show New Address
    ${name}=    User Click Send The Address
    The New Address Should Be Show At Checkout3
    User Click Payment Channel Counter Service Tab
    Checkout3 - Click Submit
    E-mail Shows Shipping Address Same As Input In Checkout2

TC_iTM_02256_Auto fill mibile no. when log in with mobile no
	[Tags]   TC_iTM_02256    dd
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1 With Tel no

TC_iTM_02257_Display error message if required fields have no input
	[Tags]   TC_iTM_02257    ee   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Add New Address Button
    User Click Next Button
    Should Be Go To Step2
    Page Should Be Show Alert

TC_iTM_02258_Edit address for member
	[Tags]   TC_iTM_02258   gg   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Enter Valid Data As Guest On Checkout2 Edit Address
    Should Be Go To Step2
    New Address Should Be Selected And Show New Address

TC_iTM_02259_Delete address for member
	[Tags]    TC_iTM_02259   hh    ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    ${data_id}=    Get Data_id Second Box
    User Click Delete Address
    Should Be Go To Step2
    Address Should Be Deleted and Old Address Is Selected    ${data_id}

TC_iTM_02260_Save home telephone number
	[Tags]    TC_iTM_02260   ii   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Click Edit Address Change Tel no Only
    Should Be Go To Step2
    Shoule Be Success For Change Tel no

TC_iTM_02261_Cannot input > 10 digits for telephone no
	[Tags]   TC_iTM_02261   jj   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Click Edit Address Change Tel no Which Has More Than 10 Digits
    Should Be Show Just 10 Digits

TC_iTM_02262_Not allow to input hyphen at telephone no
	[Tags]   TC_iTM_02262   kk   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Click Edit Address Change Tel no Which Contain Special Charactor
    Should Be Show Just 10 Digits

TC_iTM_02263_Allow 4 special characters at Name
	[Tags]   TC_iTM_02263   ll   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Click Edit Address Change Name Which Contain Special Charactor
    Should Be Allow In Text Name

TC_iTM_02264_Not allow other special characters at Name
	[Tags]   TC_iTM_02264   mm   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Click Edit Address Change Name Which Contain Invalid Special Charactor
    Should Be Can Not Allow And Show Alert Text

TC_iTM_02265_Allow other special characters at Name
	[Tags]   TC_iTM_02265   nn   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Click Edit Address Which Contain valid Special Charactor
    Should Be Allow And Edit Success

TC_iTM_02266_Select the chosen address from the previous order
	[Tags]   TC_iTM_02266   oo   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    ${name}=    User Click Send The Address
    User Pay By Wallet Payment
    Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    The Address Should Be Selected    ${name}

TC_iTM_02267_Skip checkout2 when a cusmter is back from cart page
	[Tags]   TC_iTM_02267   pp
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    ${name}=    User Click Send The Address
    User Click Open Full Cart On Checkout3
    Display Full Cart
    User Edit List Item

TC_iTM_02268_Change province
	[Tags]   TC_iTM_02268   qq   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Select Province As Bangkok
    The District And Sub-District Is Change

TC_iTM_02269_Edit address many times for member
	[Tags]   TC_iTM_02269   rr   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Edit Address
    User Enter Valid Data As Guest On Checkout2
    User Click Edit Address
    User Enter Valid Data As Guest On Checkout2 Edit Address
    New Address Should Be Selected And Show New Address

TC_iTM_02270_Add address after delete address
	[Tags]   TC_iTM_02270   ss   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Member On Checkout1
    User Click Add New Address Button
    User Enter Valid Data As Guest On Checkout2 Edit Address
    ${name}=    Get Name Which Active Box
    User Click Delete Address
    User Click Add New Address Button
    User Enter Valid Data As Guest On Checkout2
    Address 1 Should Be Deleted And New Address Should Be Active    ${name}

TC_iTM_02271_Can use the entered address for guest
	[Tags]   TC_iTM_02271   uu   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	${product_levelD_name}=    Get Product Name Level D
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    User Enter Valid Data As Guest On Checkout2
    User Click Payment Channel Counter Service Tab
    Checkout3 - Click Submit
    The Shipping Data Same As Address From Checkout2    ${product_levelD_name}
    E-mail Shows Shipping Address Same As Input In Checkout2

TC_iTM_02272_Delete / edit address button for guest
	[Tags]   TC_iTM_02272   vv   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    User Enter Valid Data As Guest On Checkout2
    User Click Edit Address At Checkout3 Page
    User Enter Valid Data As Guest On Checkout2 Edit Address
    The New Address Should Be Show At Checkout3

TC_iTM_02273_Allow home no. for guest
	[Tags]   TC_iTM_02273   xx   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    User Enter Valid Data As Guest On Checkout2 Edit Address
    Should Be Go To Step3

TC_iTM_02274_Cannot input > 10 digits for telephone no. for guest
	[Tags]   TC_iTM_02274   yy   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    Wait Until All Element Is Visible On Checkout2
    User Enter Valid Name
    User Enter Valid Mobile Edit More Than 10 Digits
    User Enter Valid Email
    User Select Province As Bangkok
    User Select City As Suanluang
    User Select District As Suanluang
    User Select Zipcode As 10250
    User Enter Valid Address
    Should Be Show Just 10 Digits
    User Click Next Button
    Should Be Go To Step3

TC_iTM_02275_Not allow to input hyphen at telephone no. for guest
	[Tags]   TC_iTM_02275   zz   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    Wait Until All Element Is Visible On Checkout2
    User Enter Valid Name
    User Click Edit Address Change Tel no Which Contain Special Charactor
    User Enter Valid Email
    User Select Province As Bangkok
    User Select City As Suanluang
    User Select District As Suanluang
    User Select Zipcode As 10250
    User Enter Valid Address
    Should Be Show Just 10 Digits
    User Click Next Button
    Should Be Go To Step3

TC_iTM_02276_Allow 4 special characters at Name for guest
	[Tags]   TC_iTM_02276   AAA    ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    Wait Until All Element Is Visible On Checkout2
    User Input Name Which Contain Special Charactor
    User Enter Valid Mobile Edit
    User Enter Valid Email Edit
    User Select Province As Chiangmai
    User Select City As Maetang
    User Select District As Cholae
    User Select Zipcode As 50150
    User Enter Valid Address Edit
    Should Be Allow In Text Name
    User Click Next Button
    Should Be Go To Step3

TC_iTM_02277_Not allow other special characters at Name for guest
	[Tags]   TC_iTM_02277   BBB   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    Wait Until All Element Is Visible On Checkout2
    User Input Name Which Contain Invalid Special Charactor
    User Enter Valid Mobile Edit
    User Enter Valid Email Edit
    User Select Province As Chiangmai
    User Select City As Maetang
    User Select District As Cholae
    User Select Zipcode As 50150
    User Enter Valid Address Edit
    User Click Next Button
    Should Be Can Not Allow And Show Alert Text

TC_iTM_02278_Allow other special characters at Name for guest
	[Tags]   TC_iTM_02278   CCC   ready
	${product_pkey}=    Get product pkey From SKU
	Level D Go to level D with Product    xxxx-${product_pkey}
	Level D Choose Product Color
	Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Enter Valid Data As Guest On Checkout1
    Should Be Go To Step2
    The E-mail Using Logging From Step1 Is Displayed
    Wait Until All Element Is Visible On Checkout2
    User Enter Valid Name
    User Enter Valid Mobile Edit
    User Enter Valid Email Edit
    User Select Province As Chiangmai
    User Select City As Maetang
    User Select District As Cholae
    User Select Zipcode As 50150
    User Input Which Contain valid Special Charactor
    User Click Next Button
    Should Be Go To Step3