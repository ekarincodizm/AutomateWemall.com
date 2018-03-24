*** Settings ***
Force Tags    WLS_MNP
Library    Selenium2Library
Library    SSHLibrary
Library    OperatingSystem
Library    HttpLibrary.HTTP
Library    DateTime
Library    Collections

Resource   ${CURDIR}/../../../Resource/init.robot
Resource   ${CURDIR}/../../../Resource/Config/tcc_config.robot
Resource   ${CURDIR}/../../../Keyword/Common/keywords_date.robot
Resource   ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mnp_verify/keywords_verify.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mnp_handset/keywords_handset.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource   ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/keyword_order.robot
Library    ${CURDIR}/../../../Python_Library/truemoveh_order_verify.py
Library    ${CURDIR}/../../../Python_Library/message_library.py
Library    ${CURDIR}/../../../Python_Library/mnp_util.py
Library    ${CURDIR}/../../../Python_Library/order.py
Library    ${CURDIR}/../../../Python_Library/mnp_download_tcc_transaction.py
Library    ${CURDIR}/../../../Python_Library/product.py


#Library    ${CURDIR}/../../../Keyword/Portal/PCMS/Ftp_pool/keywords_ftp_pool.robot

*** Variables ***
${customer_ref_id}    27145880
${customer_email}     robotautomate@gmail.com

*** Test Cases ***
TC_iTM_01334 Can access to handset step 1 page when FTP pool work
	[Tags]  TC_iTM_01334   ftp_pool  handset   QCT    regression
	delete_truemoveH_order_verify_by_mobile     0961415653
	Delete Order By Customer Email     robotautomate@gmail.com

	Prepare Order    ${customer_ref_id}    ${customer_email}
	${order_id}=    Set Variable    ${var.order_id}
	Log To console   order_id=${order_id}

	${dict}=   Create Dictionary   idcard=3101200151538   mobile=0961415653   mnp1_status=waiting   activate_status=success   status=Y   pcms_order_id=${order_id}

	${r}=  create_truemoveh_order_verify   ${dict}
	Log to console  ${r}

	${truemoveh_order_id}=   Get From Dictionary    ${r}    lastid
	Log to console   truemoveh_order_id=${truemoveh_order_id}

	${content}=   Set Variable   H|MNPSUCCESS${\n}0961415653|POS|RMV000000000377|AWN|RMV|10023233|896600341560013421|I|RPI|1784527|20160202154622CATCDMA9522|NPSMAP31|3461300046318|aaa|bbb|03112015|05112015${\n}T|1

	${date}=   Get Current Date
	${date}=   Get Current Date
	${date}=   Convert Date    ${date}   datetime
	Log to console  date=${date}

	${day}=   Set Variable    ${date.day}
	${month}=   Set Variable  ${date.month}
	${year}=   Set Variable   ${date.year}

	${month}=  keywords_itruemart_common.Convert Month Add Zero Prefix   ${month}
	${day}=  keywords_itruemart_common.Convert Month Add Zero Prefix   ${day}

	Log to console  day=${day}, month=${month}, year=${year}
	${file_name}=   Set Variable   MNPSUCCESS_${day}${month}${year}.txt
	${file_name_ctrl}=   Set Variable   MNPSUCCESS_${day}${month}${year}.txt.ctrl

	Delete Tcc Transaction   ${file_name}

	Create File  ${file_name}   ${content}   utf-8
	Create File  ${file_name_ctrl}   ${EMPTY}   utf-8
	${connection}=  Open Connection  ${tcc_ip}
	${l}=   Login   ${tcc_username}  ${tcc_password}
	SSHLibrary.Directory Should Exist   inbound/MNP/DEV

	Put File   ${file_name}   inbound/MNP/DEV/     0755
	Put File   ${file_name_ctrl}   inbound/MNP/DEV/     0755

	Close Connection

	Create Http Context    ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET    /mnp-cron
	Sleep   3s
	${order}=   Get Truemoveh Order Verify   ${truemoveh_order_id}
	Should Be Equal As Strings    ${order}   success

	Create Http Context   ${PCMS_URL_API}   http
	HttpLibrary.HTTP.GET   /mnp-cron-sendmail
	${body}=   Get Response Body

	Log To console   cron_body=${body}

	Log To Console  order_id=${order_id}
	${count_message}=   Get Message   ${order_id}   mnp-success
	${total_message}=   Get From List   ${count_message}   0
	Log To Console    total_message+line 100 =${count_message}
	Should Be Equal As Integers   ${total_message}   1
	Log to console   total_message=${total_message}

	#####################################################################

	# ${inv_id}=   get_inventory_mnp_device
	# Log To Console  ======= inv_id = ${inv_id} ======

	# ${product_pkey}=   Get Product Pkey   ${inv_id}
	# Log TO console   ========  product_pkey = ${product_pkey} =====
	# Open Browser   ${ITM_URL}   ${BROWSER}

	# Log TO console   product-pkey=${product_pkey}
	# Level D Go To Product Level D   ${product_pkey}

	# Wait Until Element Is Visible   //ul[@class="prd_price_list"]
	# ${variants}=   get_option_pkey_by_variant   ${inv_id}
	# log to console  ${variants}

	# ${color_pkey}=   Get From List   ${variants}    0
	# Log To Console   color_pkey=${color_pkey}


	# Wait Until Element Is Visible     //a[@class="style-option style-color"][@data-pkey="${color_pkey}"]
 	# Click Element     //a[contains(@class, "style-option style-color")][@data-pkey="${color_pkey}"]

	# Wait Until Ajax Loading Is Not Visible
	# Wait Until Element Is Visible   id=mnp-device-tab
	# Click Element    id=mnp-device-tab
	# ${chatbar}=   Get Matching Xpath Count   //*[@id="chatbar"]
	# Run Keyword If  '${chatbar}' > '0'  Execute Javascript   document.getElementById('chatbar').style.display = 'none';

	# Click Element    id=mnp-device-btn-order
	# ${status}=  Run Keyword And Return Status   Wait Until Element Is Visible   //input[@name="msisdn"]
	# Run Keyword If   '${status}' == '${True}'   Wait Until Element Is Visible   //input[@name="msisdn"]

	# Input Text    //input[@name="msisdn"]    0961415653
	# Input Text    //input[@name="idcard"]    3101200151538
	# User Select Valid Birthdate
	# User Click Verify Button
	# Wait Until Ajax Loading Is Not Visible
	# User Click Link Next Operate
	# Wait Until Ajax Loading Is Not Visible
	# Display Handset Step1 Page


	[Teardown]   Run Keywords   Delete TruemoveH Order Verify By Mobile  0961415653
	 ...  AND    Delete Order By Order Id   ${order_id}
	 ...  AND    Delete Tcc Transaction   ${file_name}
	...  AND    Delete Message By Order    ${order_id}
	...  AND    Remove File    ${file_name}
	...  AND    Remove File    ${file_name_ctrl}

