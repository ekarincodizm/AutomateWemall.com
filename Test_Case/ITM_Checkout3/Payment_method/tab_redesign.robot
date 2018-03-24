*** Settings ***
Library         Selenium2Library
Resource        ${CURDIR}/../../../Resource/init.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Payment_method/keywords_payment_method.robot

Resource          ${CURDIR}/../../../Keyword/Portal/iTruemart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mini cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot

Library        ${CURDIR}/../../../Python_Library/product.py


*** Test Cases ***
TC1 - Can change payment method
	[Tags]   TC1
	Login Pcms
	Go To Set Payment Page
	Payment Method - User Enter Any Product On Search Box
	User Click Edit Button First Product On Set Payment Channel Page
	User Unchoose All Payment Channel
	User Is Ticked Checkbox Installment
	User Select All Bank For Installment
	User Is Ticked Checkbox E-Wallet
	User IS Ticked Checkbox Counter Service
	User Click Save Button On Set Payment Channel Page
	Log TO Console   ${TEST_VAR}
	Level D - Redirect To Level D With Inventory Id From Test Variable
	# Level D - User Click Add To Cart Button
	# Display Full Cart
 	# User Click Next Process On Full Cart
 	# User Enter Valid Data As Member On Checkout1
 	# User Enter Valid Data As Member On Checkout2
    # Checkout 3 - User Enter Valid Data Master Card As Member
	# Payment Method - User Unselect All Bank


