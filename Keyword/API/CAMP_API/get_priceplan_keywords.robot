
*** Keywords ***
API Return Price Plan Status The Same As Prepare Data Step For 2 Price Plan Diable 1 and Enable 1
	[Arguments]    ${invenID}    ${priceplan_2_status}    ${type_price_plan}
	${expect_code}=    Set Variable    200
	${expect_message}=    Set Variable    "200 OK"
	${expect_priceplan_status}=    Set Variable    "${priceplan_2_status}"

	Create Http Context    ${PCMS_API_URL}    http
    HttpLibrary.HTTP.GET    /api/45311375168544/truemoveh/promotion/camp?inventory_id=${invenID}
    ${result}=    Get Response Body
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message
    ${actual_priceplan_status}=    Get Json Value    ${result}    /data/${type_price_plan}/price_plans/0/status
    ${priceplan_content}=    Get Json Value    ${result}    /data/${type_price_plan}/price_plans
    ${parse_priceplan}=    Parse Json    ${priceplan_content}

    Length Should Be    ${parse_priceplan}    1
    Should Be Equal    ${expect_priceplan_status}    ${actual_priceplan_status}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

API Return Price Plan Status The Same As Prepare Data Step For 1 Price Plan and Disable
    [Arguments]    ${invenID}    ${type_price_plan}
    ${expect_code}=    Set Variable    200
    ${expect_message}=    Set Variable    "200 OK"

    Create Http Context    ${PCMS_API_URL}    http
    HttpLibrary.HTTP.GET    /api/45311375168544/truemoveh/promotion/camp?inventory_id=${invenID}
    ${result}=    Get Response Body
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message
    ${priceplan_content}=    Get Json Value    ${result}    /data/${type_price_plan}/price_plans
    ${parse_priceplan}=    Parse Json    ${priceplan_content}

    Length Should Be    ${parse_priceplan}    0
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}


API Return Price Plan Status The Same As Prepare Data Step For 1 Price Plan And Enable
    [Arguments]    ${invenID}    ${priceplan_1_status}    ${type_price_plan}
    ${expect_code}=    Set Variable    200
    ${expect_message}=    Set Variable    "200 OK"
    ${expect_priceplan_status}=    Set Variable    "${priceplan_1_status}"

    Create Http Context    ${PCMS_API_URL}    http
    HttpLibrary.HTTP.GET    /api/45311375168544/truemoveh/promotion/camp?inventory_id=${invenID}
    ${result}=    Get Response Body
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message
    ${actual_priceplan_status}=    Get Json Value    ${result}    /data/${type_price_plan}/price_plans/0/status
    ${priceplan_content}=    Get Json Value    ${result}    /data/${type_price_plan}/price_plans
    ${parse_priceplan}=    Parse Json    ${priceplan_content}

    Length Should Be    ${parse_priceplan}    1
    Should Be Equal    ${expect_priceplan_status}    ${actual_priceplan_status}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

API Return Price Plan Status The Same As Prepare Data Step For 2 Price Plan And Enable
	[Arguments]    ${invenID}    ${priceplan_1_status}    ${priceplan_2_status}    ${type_price_plan}
	${expect_code}=    Set Variable    200
	${expect_message}=    Set Variable    "200 OK"
	${expect_priceplan_1_status}=    Set Variable    "${priceplan_1_status}"
	${expect_priceplan_2_status}=    Set Variable    "${priceplan_2_status}"

	Create Http Context    ${PCMS_API_URL}    http
    HttpLibrary.HTTP.GET    /api/45311375168544/truemoveh/promotion/camp?inventory_id=${invenID}
    ${result}=    Get Response Body

    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message
    ${actual_priceplan_1_status}    Get Json Value    ${result}    /data/${type_price_plan}/price_plans/0/status
    ${actual_priceplan_2_status}    Get Json Value    ${result}    /data/${type_price_plan}/price_plans/1/status
    ${priceplan_content}=    Get Json Value    ${result}    /data/${type_price_plan}/price_plans
    ${parse_priceplan}=    Parse Json    ${priceplan_content}

    Length Should Be    ${parse_priceplan}    2
    Should Be Equal    ${expect_priceplan_1_status}    ${actual_priceplan_1_status}
    Should Be Equal    ${expect_priceplan_2_status}    ${actual_priceplan_2_status}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

API Return Price Plan Status The Same As Prepare Data Step For 2 Price Plan And Disable
    [Arguments]    ${invenID}    ${type_price_plan}
    ${expect_code}=    Set Variable    200
    ${expect_message}=    Set Variable    "200 OK"

    Create Http Context    ${PCMS_API_URL}    http
    HttpLibrary.HTTP.GET    /api/45311375168544/truemoveh/promotion/camp?inventory_id=${invenID}
    ${result}=    Get Response Body
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message
    ${priceplan_content}=    Get Json Value    ${result}    /data/${type_price_plan}/price_plans
    ${parse_priceplan}=    Parse Json    ${priceplan_content}

    Length Should Be    ${parse_priceplan}    0
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}





