*** Settings ***
Resource   ${CURDIR}/../../../Common/keywords_wemall_common.robot
Library    ${CURDIR}/../../../../Python_Library/product_merchant_alias.py

*** Keywords ***
DB Alias - Delete Product Merchant Alias From Test Variable
	${alias_id}=   Wemall Common - Get Value From Test Variable   alias_id
	Py Delete Product Merchant Alias By Alias Id   ${alias_id}


