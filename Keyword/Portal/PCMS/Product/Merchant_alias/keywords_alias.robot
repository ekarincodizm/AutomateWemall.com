*** Settings ***
Library    Collections
Library    ${CURDIR}/../../../../../Python_Library/csv_library.py
Library    ${CURDIR}/../../../../../Python_Library/DatabaseData.py
Library    ${CURDIR}/../../../../../Python_Library/alias_merchant.py
Resource   ${CURDIR}/../../../../../Resource/Config/pcms_uri_endpoint.robot
Resource   ${CURDIR}/web_elements_alias.robot
Library    ${CURDIR}/../../../../../Python_Library/merchant_alias_library.py
Library    ${CURDIR}/../../../../../Python_Library/product.py

*** Keywords ***

Merchant Alias - Prepare Alias Name
	[Arguments]  ${alias_name}
	Wemall Common - Assign Value To Test Variable   alias_name   ${alias_name}

Merchant Alias - Prepare Merchant Code
	[Arguments]  ${merchant_code}
	Wemall Common - Assign Value To Test Variable   merchant_code   ${merchant_code}

Merchant Alias - Go To Set Merchant Alias Page
	Go To   ${PCMS_URI.alias_list}

Merchant Alias - Go To Create Merchant Alias Page
	Go To   ${PCMS_URI.new_alias}

Merchant Alias - Go To Edit Alias Page
	[Arguments]   ${alias_id}=${TEST_VAR.alias_id}
	Go To    ${PCMS_URI.edit_alias}/${alias_id}

Merchant Alias - Get Max Alias Id
	py_get_max_alias_id

Merchant Alias - User Enter Alias Name
    [Arguments]    ${alias_name}=Robot Automated Alias Antman

    Wait Until Element Is Visible   ${XPATH_ALIAS.txt_alias_name}   30s

    Wemall Common - Assign Value To Test Variable   alias_name   ${alias_name}
    Input Text   ${XPATH_ALIAS.txt_alias_name}  ${alias_name}


Merchant Alias - User Click Save Button
    Wait Until Element Is Visible   ${XPATH_ALIAS.btn_save}    30s
    Click Element   ${XPATH_ALIAS.btn_save}

Merchant Alias - Required Alias Name Message Is Displayed
    Wait Until Element Is Visible   ${XPATH_ALIAS.dialog_error_content}   60s
    Element Should Be Visible   ${XPATH_ALIAS.dialog_error_content}
    Element Should Contain   ${XPATH_ALIAS.dialog_error_content}  ${MSG_ALIAS.required_alias_name}

Merchant Alias - Edit Alias Page Is Opened
    Location Should Contain   ${PCMS_URI.edit_alias}
    Log To Console    Edit Alias Page=${PCMS_URI.edit_alias}

    Merchant Alias - Get ID From Edit Alias Page URL

Merchant Alias - Get ID From Edit Alias Page URL
    ${url}=   Get Location
    @{url_split}=  Split String   ${url}   /
    Wemall Common - Assign Value To Test Variable    alias_id    @{url_split}[6]
    Log To Console    alias_id=@{url_split}[6]
    [Return]  @{url_split}[6]

Merchant Alias - Create Alias Is Success
	Wait Until Element Is Visible   ${XPATH_ALIAS.dialog_success_content}   30s
	Element Should Be Visible   ${XPATH_ALIAS.dialog_success_content}
	Element Should Contain   ${XPATH_ALIAS.dialog_success_content}   ${MSG_ALIAS.create_alias_success}


Merchant Alias - Data Are Saved To Database
	${aliast_name}=   Wemall Common - Get Value From Test Variable    alias_name
	${count}=   Get Merchant Alias By Alias Name   ${alias_name}

Merchant Alias - Delete Merchant Alias By Alias Name
	${alias_name}=   Wemall Common - Get Value From Test Variable   alias_name
	Py Delete Merchant Alias   ${alias_name}

Merchant Alias - Delete Merchant Alias And Product By Alias ID
    [Arguments]   ${merchant_alias_id}=${TEST_VAR.alias_id}
    py_delete_merchant_alias_and_product    ${merchant_alias_id}

Merchant Alias - Create Alias
	create_alias

Merchant Alias - Create Alias Data
	[Arguments]  ${alias_name}=None   ${merchant_code}=None
	${r}=   Py Create Alias Data   ${alias_name}   ${merchant_code}
	Wemall Common - Assign Value To Test Variable  alias_id   ${r}
	[Return]  ${r}


Merchant Alias - Assign Product To Alias
	assign_product_to_alias

Merchant Alias - Assign Mass Product To Alias
	[Arguments]   ${alias_id}=${TEST_VAR.alias_id}   ${total_product}=1

	Wemall Common - Debug   ${TEST_VAR.alias_id}   alias_id_From_test_Var
	${products}=   Py Get Product Normal Without Alias   ${total_product}
	#Log To Console    product_id=${products[0]["product_id"]}

	${count}=   Set Variable   0
	:FOR  ${index}  IN  ${products}
	#\   Log to console  index=${index}
	\   Log to console    product_id=${products[${count}]["product_id"]}
	\   ${count}=   Evaluate   ${count} + 1
	# \  py_insert_product_merchant_alias   ${product.product_id}   ${alias_id}
	# Log to console   @{products}
	#Assign Mass Product To Alias

Merchant Alias - Delete Alias
    delete_alias

Merchant Alias - Delete Alias From Alias Name
    [Arguments]  ${alias_name}=Robot Automated Alias Antman
    py_delete_merchant_alias   ${alias_name}

Merchant Alias - Serach For Automated Test Alias
    [Arguments]    ${alias_name}=Automated Test
    Input Text    ${XPATH_ALIAS.search_input}    ${alias_name}

Merchant Alias - Search alias merchant
    [Arguments]    ${alias_name}
    Input Text    ${XPATH_ALIAS.search_input}    ${alias_name}

Merchant Alias - Click Edit Merchant Alias
    Click Element    ${XPATH_ALIAS.edit_button}

Merchant Alias - Delete Product From Alias
    Wait Until Element Is Visible    ${XPATH_ALIAS.delete_button}    30s
    Click Element    ${XPATH_ALIAS.delete_button}
    Confirm Action

Merchant Alias - Delete Action Should Succeed
    Page Should Contain    ${MSG_ALIAS.delete_success}
    Page Should Contain    ${MSG_ALIAS.empty_data}

Merchant Alias - Page Should Contain Upddate Success Message
    Page Should Contain    ${MSG_ALIAS.update_success}

Merchant Alias - Input Blank Text In Alias Merchant Name Input
    Input Text    ${XPATH_ALIAS.alias_name_input}    \

Merchant Alias - Page Should Contain Alias Merchant Name Is Required
    Page Should Contain    ${MSG_ALIAS.require_alias_merchant_name}

Merchant Alias - Should Create Merchant Success
    Page Should Contain    ${MSG_ALIAS.create_merchant_success}

Merchant Alias - Click Delete Alias
    Click Element    ${XPATH_ALIAS.delete_alias_button}
		Sleep    1
    Confirm Action

Merchant Alias - Should Delete Alias Success
    Page Should Contain    ${MSG_ALIAS.delete_alias_success}

Merchant Alias - Should Be Found Merchant Automated Test Alias
    [Arguments]    ${alias_name}=Automated Test
    Page Should Contain    ${alias_name}

Merchant Alias - Create 31 Automated Alias
    create_30_alias

Merchant Alias - Display 100 Elements In One Page
    Click Element    ${XPATH_ALIAS.display_100_elements_button}

Merchant Alias - Page Should 31 Automated Test Elements
    Page Should Contain    ${MSG_ALIAS.display_100_elements}


Merchant Alias - Delete Alias By Alias And Code
	[Arguments]   ${alias_name}   ${merchant_code}
	Py Delete By Alias And Code  ${alias_name}  ${merchant_code}

Merchant Alias - Id Is Displayed Arrow Descending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_id_desc}  30s
	Element Should Be Visible   ${XPATH_ALIAS.th_col_id_desc}

Merchant Alias - Id Is Displayed Arrow Ascending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_id_asc}   30s
	Element Should Be Visible  ${XPATH_ALIAS.th_col_id_asc}

Merchant Alias - Alias Name Is Displayed Arrow Descending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_alias_name_desc}  60s
	Element Should Be Visible  ${XPATH_ALIAS.th_col_alias_name_desc}

Merchant Alias - Alias Name Is Displayed Arrow Ascending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_alias_name_asc}   60s
	Element Should Be Visible   ${XPATH_ALIAS.th_col_alias_name_asc}

Merchant Alias - Merchant Code Is Displayed Arrow Descending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_merchant_code_desc}  60s
	Element Should Be Visible  ${XPATH_ALIAS.th_col_merchant_code_desc}

Merchant Alias - Merchant Code Is Displayed Arrow Ascending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_merchant_code_asc}  60s
	Element Should Be Visible  ${XPATH_ALIAS.th_col_merchant_code_asc}

Merchant Alias - Updated At Is Displayed Arrow Descending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_updated_at_desc}  60s
	Element Should Be Visible  ${XPATH_ALIAS.th_col_updated_at_desc}

Merchant Alias - Updated At Is Displayed Arrow Ascending
	Wait Until Page Contains Element  ${XPATH_ALIAS.th_col_updated_at_asc}   60s
	Element Should Be Visible  ${XPATH_ALIAS.th_col_updated_at_asc}

Merchant Alias - User Click Sort By Id
	Wait Until Element Is Visible   ${XPATH_ALIAS.th_col_id}  30s
	Click Element   ${XPATH_ALIAS.th_col_id}

Merchant Alias - User Click Back Button
	Wait Until Element Is Visible   ${XPATH_ALIAS.btn_back}   30s
	Click Element   ${XPATH_ALIAS.btn_back}

Merchant Alias - User Click Sort By Alias Name
	Wait Until Element Is Visible   ${XPATH_ALIAS.th_col_alias_name}   30s
	Click Element  ${XPATH_ALIAS.th_col_alias_name}

Merchant Alias - User Click Sort By Merchant Code
	Wait Until Element Is Visible   ${XPATH_ALIAS.th_col_merchant_code}   30s
	Click Element  ${XPATH_ALIAS.th_col_merchant_code}

Merchant Alias - User Click Sort By Updated At
	Wait Until Element Is Visible   ${XPATH_ALIAS.th_col_updated_at}  30s
	Click Element  ${XPATH_ALIAS.th_col_updated_at}

Merchant Alias - Alias Name Is At First Row
	[Arguments]   ${alias_name}

	Wait Until Page Contains Element  ${XPATH_ALIAS.row1_td_col_alias_name}   30s
	${text_alias_name}=   Get Text   ${XPATH_ALIAS.row1_td_col_alias_name}
	Should Be Equal AS Strings   ${alias_name}  ${text_alias_name}


Merchant Alias - Alias Name Is At Second Row
	[Arguments]   ${alias_name}
	Wait Until Page Contains Element  ${XPATH_ALIAS.row2_td_col_alias_name}   30s
	${text_alias_name}=   Get Text   ${XPATH_ALIAS.row2_td_col_alias_name}
	Should Be Equal AS Strings   ${alias_name}  ${text_alias_name}

Merchant Alias - Alias Name Is At Third Row
	[Arguments]   ${alias_name}
	Wait Until Page Contains Element  ${XPATH_ALIAS.row3_td_col_alias_name}   30s
	${text_alias_name}=   Get Text   ${XPATH_ALIAS.row3_td_col_alias_name}
	Should Be Equal AS Strings   ${alias_name}  ${text_alias_name}

Merchant Alias - Alias Name Is At Fourth Row
	[Arguments]   ${alias_name}
	Wait Until Page Contains Element  ${XPATH_ALIAS.row4_td_col_alias_name}   30s
	${text_alias_name}=   Get Text   ${XPATH_ALIAS.row4_td_col_alias_name}
	Should Be Equal AS Strings   ${alias_name}  ${text_alias_name}

Merchant Alias - Alias Name Is At Fifth Row
	[Arguments]   ${alias_name}
	Wait Until Page Contains Element  ${XPATH_ALIAS.row5_td_col_alias_name}   30s
	${text_alias_name}=   Get Text   ${XPATH_ALIAS.row5_td_col_alias_name}
	Should Be Equal AS Strings   ${alias_name}  ${text_alias_name}

Merchant Alias - Alias Name Is At Sixth Row
	[Arguments]   ${alias_name}
	Wait Until Page Contains Element  ${XPATH_ALIAS.row6_td_col_alias_name}   30s
	${text_alias_name}=   Get Text   ${XPATH_ALIAS.row6_td_col_alias_name}
	Should Be Equal AS Strings   ${alias_name}  ${text_alias_name}

Merchant Alias - Should Be No matching records found
    Page Should Contain    No matching records found

Merchant Alias - Go to alias merchant page
    Wait Until Element Is Visible    ${product_menu}     20s
    Click Element    ${product_menu}
    Wait Until Element Is Visible    ${set_alias_merchant_menu}    20s
    Click Element    ${set_alias_merchant_menu}
    Location Should Contain     ${PCMS_URL}/products/alias-merchant

Merchant Alias - User Click Mass Upload
	Wait Until Element Is Visible   ${XPATH_ALIAS.btn_mass_upload}   60s
	Click Element   ${XPATH_ALIAS.btn_mass_upload}

Merchant Alias - User Click Mass Delete
	Wait Until Element Is Visible   ${XPATH_ALIAS.btn_mass_delete}  60s
	Click Element  ${XPATH_ALIAS.btn_mass_delete}


Merchant Alias - Alias List Page Is Opened
	Location Should Contain   ${PCMS_URI.alias_list}

Merchant Alias - Mass Upload Page Is Opened
	Location Should Contain   ${PCMS_URL}/products/alias-merchant/mass-upload

Merchant Alias - Mass Delete Page Is Opened
	Location Should Contain  ${PCMS_URL}/products/alias-merchant/mass-delete

Merchant Alias - User Choose File Upload
	#Wait Until Element Is Visible  ${XPATH_ALIAS.txt_mass_upload_file}  30s
	${path}=   helper.get_canonical_path  ${CURDIR}/../../../../../Resource/TestData/Alias/template_mass_alias_upload.csv
	#${path}=   helper.Get Canonical Path   ../../../Resource/TestData/Alias/template_mass_alias_upload.csv

	Log To Console  Debug Path=${path}
	#Choose File   template_mass_alias_upload.csv


	Wemall Common - Debug   ${path}   path_mass_uplaod_alias
	Choose File   ${XPATH_ALIAS.txt_mass_upload_file}   ${path}
	Wait Until Element Is Visible   //div[contains(@class, "alert-success")]   30s

Merchant Alias - Read Excel Product Pkey To Test Variable
	${path}=   helper.Get Canonical Path    ${CURDIR}/../../../../../Resource/TestData/Alias/template_mass_alias_upload.csv
	#${path}=   helper.Get Canonical Path   ../../../Resource/TestData/Alias/template_mass_alias_upload.csv
	Log TO Console   path=${path}

	@{data}=   Read Csv File   ${path}

	${length}=   Get Length   ${data}
	#Wemall Common - Assign Value To Test Variable   csv_data   ${data}
	# Log To Console    ${data}

	:FOR  ${index}  IN RANGE  0  ${length}
	\  ${product_pkey}=    Get From List   @{data}[${index}]   0
	\  ${var_exist}=   Run Keyword And Return Status   Variable Should Exist   ${csv_data}
	\  Log To Console   var_exist=${var_exist}

	\  Run Keyword If  '${var_exist}' == '${True}' and '${index}' > '0'   Append To List  ${csv_data}  @{data}[${index}]
	\  ${csv_data}=   Run Keyword If  '${var_exist}' == '${False}'  Create List  @{data}[${index}]
	\  Log TO Console   csv_data_in_loop=${csv_data}
	Log To Console   csv_data=${csv_data}

Merchant Alias - Prepare Product Create Merchant Pcms And Storefront
	${csv_data}=   Wemall Common - Get Value From Test Variable
	csv_data
	Log To Console   csv_data=@{csv_data}

Merchant Alias - Get Product Pkey From Product List In Alias
	Wait Until Page Contains Element   //form[@id="form-product-list"]/div/table/tbody   60s
	Wait Until Element Is Visible   //form[@id="form-product-list"]/div/table/tbody   60s
	${total_rows}=    Get Matching Xpath count   //form[@id="form-product-list"]/div/table/tbody/tr
	Log to console  total_rows=${total_rows}
	:FOR  ${index}  IN RANGE  1  ${total_rows}+1
	\  ${product_pkey}=   Get Text   //form[@id="form-product-list"]/div/table/tbody/tr[${index}]/td[2]
	\  ${list_exist}=   Run Keyword And Return Status  Variable Should Exist  ${list_product_pkey}
	\  Log to console   list_exist=${list_exist}
	\  Run Keyword If  '${list_exist}' == '${True}'  Append To List  ${list_product_pkey}   ${product_pkey}
	\  ${list_product_pkey}=   Run Keyword If  '${list_exist}' == '${False}'   Create List   ${product_pkey}   ELSE   Continue For Loop
	\  Log to console  list_proudct_pkey_in_loop=${list_product_pkey}

	Wemall Common - Assign Value To Test Variable   list_product_pkey   ${list_product_pkey}

Merchant Alias - Get Merchant Alias Code
	Wait Until Page Contains Element  ${XPATH_ALIAS.txt_alias_code}   60s
	Execute JavaScript    document.getElementById('alias_code').disabled = false;
	Execute JavaScript    document.getElementById('alias_code').removeAttribute('readonly');
	${alias_code}=   Get Value   ${XPATH_ALIAS.txt_alias_code}
	Wemall Common - Assign Value To Test Variable   alias_code  ${alias_code}

Merchant Alias - Get Alias Merchant ID From Alias Merchant Edit Page
    ${url}=   Get Location
    @{url_split}=  Split String   ${url}   /
		Return From Keyword    @{url_split}[6]

Merchant Alias - Get Alias Merchant Code From Alias Merchant Edit Page
	Wait Until Page Contains Element  ${XPATH_ALIAS.txt_alias_code}   60s
	${alias_code}=    Get Value   ${XPATH_ALIAS.txt_alias_code}
	Return From Keyword    ${alias_code}

Merchant Alias - Delete Alias Merchant By ID
	[Arguments]    ${id}
	Merchant Alias - Search alias merchant    ${id}
	Merchant Alias - Click Delete Alias
	Sleep    1
	Merchant Alias - Should Delete Alias Success

Merchant Alias - Get products in alias merchant from DB
#product_pkey,product_id,product_name,alias_id,alias_code,alias_name
    ${records}=    Get products in alias merchant
    [Return]    ${records}

Merchant Alias - Get detail products and alias merchant
    ${detail_products_alias}=    Merchant Alias - Get products in alias merchant from DB
    Log To Console    detail products alias=${detail_products_alias}
    ${length}=      Get Length     ${detail_products_alias}
    Run Keyword If    ${length} != 0
    ...    Return From Keyword    ${detail_products_alias}
    Run Keyword If    ${length} == 0
    ...    Merchant Alias - Add product to alias merchant
    ${detail_products_alias_new}=    Merchant Alias - Get products in alias merchant from DB
    [Return]    ${detail_products_alias_new}

Merchant Alias - Add product to alias merchant
    ${alias_id}=     Get alias merchant
    ${product}=      Get products from DB
    ${product_id}=     Set Variable     ${product[0][1]}
    Log To Console     product_id=${product_id}
    Log To Console     alias_id=${alias_id}
    Add product to alias merchant     ${product_id}     ${alias_id}

Get products from DB
#pkey,id
    ${records}=    Get one product detail
    [Return]    ${records}
