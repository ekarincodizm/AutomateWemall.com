*** Settings ***
Force Tags    WLS_MNP
Library    Selenium2Library
Library    OperatingSystem
Library    HttpLibrary.HTTP
Library    DateTime
Library    Collections

Resource   ${CURDIR}/../../../../Resource/init.robot
Resource   ${CURDIR}/../../../../Keyword/Portal/iTrueMart/Mnp_verify/keywords_verify.robot
Resource   ${CURDIR}/../../../../Keyword/Portal/iTrueMart/Mnp_handset/keywords_handset.robot
Resource   ${CURDIR}/../../../../Keyword/Common/keywords_itruemart_common.robot
Library    ${CURDIR}/../../../../Python_Library/truemoveh_order_verify.py

Resource    ${CURDIR}/../../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource    ${CURDIR}/../../../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource    ${CURDIR}/../../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot

Library    ${CURDIR}/../../../../Python_Library/mnp_util.py
Library    ${CURDIR}/../../../../Python_Library/order.py
Library    ${CURDIR}/../../../../Python_Library/product.py

*** Test Cases ***
TC_iTM_Dummy_Check_Price_Plans_Mnp_device_have_One_Priceplan
	[Tags]  TC_iTM_01334  handset   ready

	Delete TruemoveH Order Verify By Mobile  0961415653
	Delete Order By Customer Email     robotautomate@gmail.com

	${order_return}=   Create Order
	${order_id}=   Get From Dictionary   ${order_return}  lastid

	Create MNP Truemoveh Order verify    ${order_id}

 	Prepare TruemoveH Product MNP Device On PCMS One Priceplan
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}   ${device_discount_type}   ${device_discount}   ${var_tmh_price_plan_code}

    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=   Get From List   ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}

    LvD - Click Mnp Tab
    Close Chat Bar

	Click Element    id=mnp-device-btn-order
	${status}=  Run Keyword And Return Status   Wait Until Element Is Visible   //input[@name="msisdn"]
	Run Keyword If   '${status}' == '${True}'   Wait Until Element Is Visible   //input[@name="msisdn"]

	Sleep    2s
	Input MNP2 Verify Form
	Wait Until Ajax Loading Is Not Visible
	User Click Link Next Operate
	Wait Until Ajax Loading Is Not Visible
	Display Handset Step1 Page

	${total_price_plan_from_ui}=    Count Price Plans From Register MNP Page

	${expect}=    Set Variable    1
	Should Be Equal    '${expect}'    '${total_price_plan_from_ui}'

	[Teardown]   Run Keywords   Delete TruemoveH Order Verify By Mobile  0961415653
	 ...  AND    Delete Order By Order Id   ${order_id}
	 ...  AND    Delete Campaign On Camp    ${token_data}    ${campaign_id}
	 ...  AND    Delete TruemoveH Product On PCMS
	 ...  AND    Close Browser

TC_iTM_Dummy Check Price Plans Mnp_device have Priceplan1 N Priceplan2 Y
	[Tags]  TC_iTM_01334   ftp_pool  handset

	Delete TruemoveH Order Verify By Mobile  0961415653
	Delete Order By Customer Email     robotautomate@gmail.com

	${order_return}=   Create Order
	${order_id}=   Get From Dictionary   ${order_return}  lastid

	Create MNP Truemoveh Order verify    ${order_id}

 	${priceplan_1_status}=    Set Variable    N
    ${priceplan_2_status}=    Set Variable    Y
    ${run_data}=    Prepare TruemoveH Product MNP Device On PCMS Two Priceplan    ${priceplan_1_status}    ${priceplan_2_status}

    ${priceplan_1}=          Get From Dictionary    ${run_data}    priceplan_1
    ${priceplan_2}=          Get From Dictionary    ${run_data}    priceplan_2
    ${proposition_map_1}=    Get From Dictionary    ${run_data}    proposition_map_1
    ${proposition_map_2}=    Get From Dictionary    ${run_data}    proposition_map_2

    ${camp_data}=    Create Mnp Camp Promotion by Promotion data 2    ${var_tmh_product_device_inventory_id}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=   Get From List   ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}

    LvD - Click Mnp Tab
    Close Chat Bar

	Click Element    id=mnp-device-btn-order
	${status}=  Run Keyword And Return Status   Wait Until Element Is Visible   //input[@name="msisdn"]
	Run Keyword If   '${status}' == '${True}'   Wait Until Element Is Visible   //input[@name="msisdn"]

	Sleep    2s
	Input MNP2 Verify Form
	Wait Until Ajax Loading Is Not Visible
	User Click Link Next Operate
	Wait Until Ajax Loading Is Not Visible
	Display Handset Step1 Page

	${total_price_plan_from_ui}=    Count Price Plans From Register MNP Page

	${expect}=    Set Variable    1
	Should Be Equal    '${expect}'    '${total_price_plan_from_ui}'

	[Teardown]   Run Keywords   Delete TruemoveH Order Verify By Mobile  0961415653
	 ...  AND    Delete Order By Order Id   ${order_id}
	 ...  AND    Delete Campaign On Camp    ${token_data}    ${campaign_id}
	 ...  AND    Delete TruemoveH Product On PCMS Two Priceplans     ${priceplan_1}    ${priceplan_2}    ${proposition_map_1}    ${proposition_map_2}
	 ...  AND    Close Browser

TC_iTM_Dummy Check Price Plans Mnp_device have Priceplan1 Y Priceplan2 Y
	[Tags]  TC_iTM_01334   ftp_pool  handset

	Delete TruemoveH Order Verify By Mobile  0961415653
	Delete Order By Customer Email     robotautomate@gmail.com

	${order_return}=   Create Order
	${order_id}=   Get From Dictionary   ${order_return}  lastid

	Create MNP Truemoveh Order verify    ${order_id}

 	${priceplan_1_status}=    Set Variable    Y
    ${priceplan_2_status}=    Set Variable    Y
    ${run_data}=    Prepare TruemoveH Product MNP Device On PCMS Two Priceplan    ${priceplan_1_status}    ${priceplan_2_status}

    ${priceplan_1}=          Get From Dictionary    ${run_data}    priceplan_1
    ${priceplan_2}=          Get From Dictionary    ${run_data}    priceplan_2
    ${proposition_map_1}=    Get From Dictionary    ${run_data}    proposition_map_1
    ${proposition_map_2}=    Get From Dictionary    ${run_data}    proposition_map_2

    ${camp_data}=    Create Mnp Camp Promotion by Promotion data 2    ${var_tmh_product_device_inventory_id}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=   Get From List   ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}

    LvD - Click Mnp Tab
    Close Chat Bar

	Click Element    id=mnp-device-btn-order
	${status}=  Run Keyword And Return Status   Wait Until Element Is Visible   //input[@name="msisdn"]
	Run Keyword If   '${status}' == '${True}'   Wait Until Element Is Visible   //input[@name="msisdn"]

	Sleep    2s
	Input MNP2 Verify Form
	Wait Until Ajax Loading Is Not Visible
	User Click Link Next Operate
	Wait Until Ajax Loading Is Not Visible
	Display Handset Step1 Page

	${total_price_plan_from_ui}=    Count Price Plans From Register MNP Page

	${expect}=    Set Variable    2
	Should Be Equal    '${expect}'    '${total_price_plan_from_ui}'

	[Teardown]   Run Keywords   Delete TruemoveH Order Verify By Mobile  0961415653
	 ...  AND    Delete Order By Order Id   ${order_id}
	 ...  AND    Delete Campaign On Camp    ${token_data}    ${campaign_id}
	 ...  AND    Delete TruemoveH Product On PCMS Two Priceplans     ${priceplan_1}    ${priceplan_2}    ${proposition_map_1}    ${proposition_map_2}
	 ...  AND    Close Browser

TC_iTM_Dummy Check Price Plans Bundle have Priceplan1 Y
	[Tags]    TC_iTM_01334   Bundle
	Delete TruemoveH Order Verify By Mobile  0961415653
	Delete Order By Customer Email     robotautomate@gmail.com

	${expect_priceplan_shown}     Set Variable    1
	${priceplan_1_status}         Set Variable    Y
	${priceplan_1_short_desc}     Set Variable    Priceplan 1 Short Description

	${token-data}=    AAD Login And Get Token

	${campaign_id}=    Create Campaign On Camp    ${token-data}

	Prepare TruemoveH Product Bundle On PCMS
	...    ${priceplan_1_status}

	${camp_response}=    Create Bundle Promotion On Camp 2
	...    ${var_tmh_product_device_inventory_id}
	...    ${var_tmh_device_sub_inventory_id}
	...    ${campaign_id}
	...    30
	...    50

    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=   Get From List   ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}
    Update Priceplan Status    ${var_tmh_price_plan_id}

    LvD - Click Buy All
    Close Chat Bar
    Should Be Without PricePlan

    [Teardown]    Run keywords    Delete Campaign On Camp    ${token-data}    ${campaign_id}
	...    AND    Delete TruemoveH Product Bundle On PCMS

TC_iTM_Dummy_Check_Price_Plans_Mnp_device_have_One_Priceplan Disble While Running
	[Tags]  TC_iTM_01334   MNP_Device
	Delete TruemoveH Order Verify By Mobile  0961415653
	Delete Order By Customer Email     robotautomate@gmail.com

	${order_return}=   Create Order
	${order_id}=   Get From Dictionary   ${order_return}  lastid

	Create MNP Truemoveh Order verify    ${order_id}

 	Prepare TruemoveH Product MNP Device On PCMS One Priceplan
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}   ${device_discount_type}   ${device_discount}   ${var_tmh_price_plan_code}

    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=   Get From List   ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}

    LvD - Click Mnp Tab
    Close Chat Bar

    Click Element    id=mnp-device-btn-order
	${status}=  Run Keyword And Return Status   Wait Until Element Is Visible   //input[@name="msisdn"]
	Run Keyword If   '${status}' == '${True}'   Wait Until Element Is Visible   //input[@name="msisdn"]

	Sleep    2s
	Input MNP2 Verify Form
	Wait Until Ajax Loading Is Not Visible
	User Click Link Next Operate
	Wait Until Ajax Loading Is Not Visible
	Display Handset Step1 Page
	Countinue To Next Page1
	Input MNP2 Register Form
	Countinue To Next Page2
	Accept Checkbox
	Update Priceplan Status    ${var_tmh_price_plan_id}
	Page Show Dialog Without Priceplan

	# [Teardown]   Run Keywords   Delete TruemoveH Order Verify By Mobile  0961415653
	#  ...  AND    Delete Order By Order Id   ${order_id}
	#  ...  AND    Delete Campaign On Camp    ${token_data}    ${campaign_id}
	#  ...  AND    Delete TruemoveH Product On PCMS
	#  ...  AND    Close Browser