*** Settings ***
Force Tags        WLS_API_PCMS
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Order/keywords_order.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot
Resource    ${CURDIR}/../../../Keyword/Database/PCMS/keyword_order.robot
Resource    ${CURDIR}/../../../Keyword/Database/PCMS/keyword_holiday.robot
Resource    ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Library     ${CURDIR}/../../../Python_Library/order_history_library.py
Library     ${CURDIR}/../../../Python_Library/holidays_library.py

Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String

Test Teardown     End Test Case

*** Keywords ***
Prepare Order For Test Case
	${order_id}=     keyword_order.Prepare Order
	Set Test Variable   ${TV_order_id}   ${order_id}

Prepare Order With Correct Image path
	${order_id}=     Prepare Order
	Set Test Variable   ${TV_order_id}   ${order_id}

Prepare Order With Wrong Image path
	${order_id}=     Prepare Order Wrong Image path
	Set Test Variable   ${TV_order_id}   ${order_id}

End Test Case
	Remove Order     ${TV_order_id}
	Close All Browsers

*** Test Cases ***
TC_iTM_01762 Correct format input
	[Tags]  TC_iTM_01762  TC1  ITMA-2858  ITMA-2876  ITMA-2880  api_get_orders  ready    QCT    regression    WLS_High
	Prepare Order With Correct Image path
	${order_data}=   Api Get Order   ${customer_ref_id}
	${img}=          Get Image Path URL Of Api Get Order   ${order_data}
	${count}=        Get Count    ${img}   //
	Should Be Equal As Numbers    ${count}   1
	Open Browser    http:${img}   chrome
	Wait Until Element Is Visible   //img[@src="http:${img}"]   10
	Element Should Be Visible       //img[@src="http:${img}"]

TC_iTM_01761 Incorrect format input
	[Tags]  TC_iTM_01761  TC2  ITMA-2858  ITMA-2876  ITMA-2880  api_get_orders   ready    QCT   regression    WLS_High
	Prepare Order With Wrong Image path
	${order_data}=   Api Get Order   ${customer_ref_id}
	${img}=          Get Image Path URL Of Api Get Order   ${order_data}
	${count}=        Get Count    ${img}   //
	Should Be Equal As Numbers    ${count}   1
	Open Browser    http:${img}   chrome
	Wait Until Element Is Visible   //img[@src="http:${img}"]   10
	Element Should Be Visible       //img[@src="http:${img}"]

TC_iTM_02208 Delivery Time Min < Max (2-7)
	[Tags]   ITMA-2871  TC_iTM_02208   api_get_orders  order_tracking  ready   regression    WLS_Medium
	${delivery_min}=                Set Variable   2
	${delivery_max}=                Set Variable   7
	${expected_delivery_min}=       Set Variable   10 มิ.ย. 69
	${expected_delivery_max}=       Set Variable   17 มิ.ย. 69
	${expected_delivery_text_th}=   Set Variable   หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย

	Given Prepare Order For Test Case
	  And Prepare Product Delivery Day   ${delivery_min}   ${delivery_max}
	  And Create Holiday   2026-06-08
	 When Call Api Get Order By Custormer Ref ID   ${customer_ref_id}  th
	 Then Delivery Text From Api Get Order Should Be Equal   ${expected_delivery_text_th}
	  And Delivery Date Min Should Be Equal   ${expected_delivery_min}
	  And Delivery Date Max Should Be Equal   ${expected_delivery_max}
	[Teardown]   Run keywords   Delete prepared order
	 ...   AND   Restore shop delivery day
	 ...   AND   Remove Holiday

TC_iTM_02209 Delivery Time Min = Max (3-3)
	[Tags]   ITMA-2871  TC_iTM_02209  api_get_orders  order_tracking  ready   regression    WLS_Medium
	${delivery_min}=                Set Variable   3
	${delivery_max}=                Set Variable   3
	${expected_delivery_min}=       Set Variable   11 Jun 26
	${expected_delivery_max}=       Set Variable   11 Jun 26
	${expected_delivery_text_en}=   Set Variable   If you order more than 1 item, estimate delivery time will up to the item which has the longest delivery time or it will ship separately by supplier or Thai post.

	Given Prepare Order For Test Case
	  And Prepare Product Delivery Day   ${delivery_min}   ${delivery_max}
	  And Create Holiday   2026-06-08
	 When Call Api Get Order By Custormer Ref ID   ${customer_ref_id}  en
	 Then Delivery Text From Api Get Order Should Be Equal   ${expected_delivery_text_en}
	  And Delivery Date Min Should Be Equal   ${expected_delivery_min}
	  And Delivery Date Max Should Be Equal   ${expected_delivery_max}
	[Teardown]   Run keywords   Delete prepared order
	 ...   AND   Restore shop delivery day
	 ...   AND   Remove Holiday

# TC5 Delivery Time Min > Max (7-3)
# 	[Tags]  TC5  ITMA-2871  api_get_orders  order_tracking  regression
# 	${delivery_min}=                Set Variable   7
# 	${delivery_max}=                Set Variable   3
# 	${expected_delivery_min}=       Set Variable   16 มิ.ย. 69
# 	${expected_delivery_max}=       Set Variable   16 มิ.ย. 69
# 	${expected_delivery_text_th}=   Set Variable   หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย

# 	Given Prepare Order For Test Case
# 	  And Prepare Product Delivery Day   ${delivery_min}   ${delivery_max}
# 	  And Create Holiday   2050-06-08
# 	 When Call Api Get Order By Custormer Ref ID   ${customer_ref_id}  th
# 	 Then Delivery Text From Api Get Order Should Be Equal   ${expected_delivery_text_th}
# 	  And Delivery Date Min Should Be Equal   ${expected_delivery_min}
# 	  And Delivery Date Max Should Be Equal   ${expected_delivery_max}
# 	[Teardown]   Run keywords   Delete prepared order
# 	 ...   AND   Restore shop delivery day
# 	 ...   AND   Remove Holiday











