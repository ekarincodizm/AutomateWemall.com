*** Settings ***
Library    Selenium2Library
Resource   ${CURDIR}/../../../Resource/init.robot
#Resource   ${CURDIR}/../../../
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot

Resource   ${CURDIR}/../../../Keyword/Portal/iTruemart/


*** Keywords ***
Prepare Product
	${product}=   DB Product - Get Product

	#Wemall Common - Assign Value To Test Variable    product_id   ${productproduct_id}
	Log To Console  ${product[0]["product_id"]}

*** Test Cases ***
TC1
	[Tags]  TC1
	Given Prepare Product


