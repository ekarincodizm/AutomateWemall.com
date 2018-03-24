*** Settings ***
#Resource          ${CURDIR}/../../../itruemart-robot-ux/Resources/TestData/data/checkout_test_data.robot

*** Keywords ***
Api Set Customer Info
	[Arguments]  ${customer_ref}=${DATA_CHECKOUT.valid_ssoid}  ${customer_type}=user  ${customer_address_id}=${EMPTY}  ${customer_email}=${DATA_CHECKOUT.valid_email}  ${customer_tel}=${DATA_CHECKOUT.valid_mobile}  ${customer_name}=Robot Automate  ${customer_address}=Robot Address  ${customer_district_id}=2942  ${customer_city_id}=367  ${customer_province_id}=29  ${customer_postcode}=40290

	Create Http Context   ${PCMS-HOST-API}   http

	Set Request Body    customer_ref_id=${customer_ref}&customer_type=${customer_type}&customer_address_id=${customer_address_id}&customer_email=${customer_email}&customer_tel=${customer_tel}&customer_name=${customer_name}&customer_address=${customer_address}&customer_district_id=${customer_district_id}&customer_city_id=${customer_city_id}&customer_province_id=${customer_province_id}&customer_postcode=${customer_postcode}

	Next Request Should Succeed
	HttpLibrary.HTTP.POST   /api/45311375168544/checkout/set-customer-info
	${body}=  Get Response Body
	${message}=   Get Json Value   ${body}   /message
	Log To console   message = ${message}