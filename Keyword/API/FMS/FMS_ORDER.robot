*** Settings ***
Library           HttpLibrary.HTTP
Resource          ../../Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../API/CAMP_API/Keywords_CAMPS_API.robot
Library          ${CURDIR}/../../../Python_Library/order_shipment_items_library.py

*** Keywords ***
Order Should Be Valid On FMS Service
    [Arguments]    ${order_id}
	Create Http Context    ${FMS_API}    http
    HttpLibrary.HTTP.Get    /fmsServices/v2/outbounds/${order_id}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

Get item status On FMS Service
    [Arguments]    ${item_id}
	Create Http Context    ${FMS_API}    http
    HttpLibrary.HTTP.Get    /fmsServices/v2/sourcing/list_orders/?searchKey=ob_line_item_number&searchValue=${item_id}&sort=ob_number&item_per_page=50&page=1&obStatus=&buCode=BTH001&ob_start_created_at=&ob_end_created_at=&order_source=ITM
    ${response}=    Get Response Body
    ${item_status}=    Get Json Value and Convert to List    ${response}    /data/0/status
    Return From Keyword    ${item_status}

Verify item status on FMS
    [Arguments]    ${item_id}    ${status}
    ${item_status}=     Get item status On FMS Service    ${item_id}
    Should Be Equal    ${item_status}    ${status}

Verify Item Status Create Date Is Less Than
    [Arguments]    ${item_id}    ${days}
    ${result}=    verify_item_status_create_date    ${item_id}    ${days}
    Log to Console    ${result}
    Should Be True    ${result}

Verify item status on FMS is not cancel
    [Arguments]    ${item_id}
	${item_status}=     Get item status On FMS Service    ${item_id}
	Log To Console     ${item_status}
    Should Not Be Equal    ${item_status}    cancelled


Verify item status on FMS should not be
    [Arguments]    ${item_id}    ${status}
    ${item_status}=     Get item status On FMS Service    ${item_id}
    Log To Console     ${item_status}
    Should Not Be Equal    ${item_status}    ${status}
