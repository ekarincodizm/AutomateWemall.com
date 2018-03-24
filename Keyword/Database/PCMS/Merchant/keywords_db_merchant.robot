*** Settings ***
Library   ${CURDIR}/../../../../Python_Library/shop_library.py
Library   ${CURDIR}/../../../../Python_Library/product.py

*** Variables ***
${prepare_shop_code}                ROBOT_SHOPCODE
${prepare_shop_name}                ROBOT_SHOPNAME

*** Keywords ***
DB Merchant - Create Merchant And Assign To Test Variable
	DB Delete Shop   ${prepare_shop_code}   ${prepare_shop_name}
	${shop_id}=   DB Create Shop   ${prepare_shop_code}   ${prepare_shop_name}

	Wemall Common - Debug   ${shop_id}   shop_id
	Wemall Common - Assign Value To Test Variable   shop_id   ${shop_id}

	#${inv_id}=   product.Get Inventory Normal
	@{product}=   Py Get Product Without Alias

	${inv_id}=   Get Inventory Id From Product Id   @{product}[0]

	Wemall Common - Debug   @{product}[1]   product_pkey


	Wemall Common - Assign Value To Test Variable   inv_id   ${inv_id}
	Wemall Common - Debug   ${inv_id}   inv_id
	${backup_shop_id}=    get_original_shop_id_by_inventory_id    ${inv_id}
	Wemall Common - Assign Value To Test Variable   backup_shop_id   ${backup_shop_id}

	Wemall Common - Debug  ${backup_shop_id}   backup_shop_id

	Assign Shop Id To Existing Inventory_id    ${shop_id}  ${inv_id}
	#Assign Shop Id To Existing Inventory_id    322963  ${inv_id}
	Log to console   ${TEST_VAR}

DB Merchant - Rollback Shop Id For Inventory
	${rollback_shop_id}=   Wemall Common - Get Value From Test Variable   backup_shop_id
	${inv_id}=   Wemall Common - Get Value From Test Variable

	Wemall Common - Debug   ${rollback_shop_id}   rollback_shop_id

	Assign Shop Id To Existing Inventory Id   ${rollback_shop_id}   ${inv_id}

DB Merchant - Delete Shop By Shop Id
	${shop_id}=   Wemall Common - Get Value From Test Variable   shop_id
	DB Delete Shop By Id    ${shop_id}






