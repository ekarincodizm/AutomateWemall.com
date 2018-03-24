*** Settings ***
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ../../Resource/init.robot
Library           String

*** Test Cases ***
test
    ${order_id}    Guest Buy Product Unsuccess with TM    nongluck.ler@ascendcorp.com    P@ssw0rd
    [Teardown]    close browser

testttt
    ${remove}    replace string    "<html><head><meta charset=\\"utf-8\\"></head><body><form id=\\"formSubmit\\" method=\\"POST\\" action=\\"https://testsecureacceptance.cybersource.com/silent/pay\\"><input type=\\"hidden\\" name=\\"access_key\\" value=\\"20a96be6272f36bbab908d00369ab00e\\"><input type=\\"hidden\\" name=\\"profile_id\\" value=\\"03AA23AB-9AB4-49D5-B8E7-DBC68933A814\\"><input type=\\"hidden\\" name=\\"transaction_uuid\\" value=\\"fb3eacda-e8b2-4ed6-9f59-7b9d1f42841a\\"><input type=\\"hidden\\" name=\\"signed_date_time\\" value=\\"2016-07-26T03:56:33Z\\"><input type=\\"hidden\\" name=\\"locale\\" value=\\"en\\"><input type=\\"hidden\\" name=\\"transaction_type\\" value=\\"authorization\\"><input type=\\"hidden\\" name=\\"reference_number\\" value=\\"9160726171259\\"><input type=\\"hidden\\" name=\\"amount\\" value=\\"750.00\\"><input type=\\"hidden\\" name=\\"currency\\" value=\\"THB\\"><input type=\\"hidden\\" name=\\"payment_method\\" value=\\"card\\"><input type=\\"hidden\\" name=\\"bill_to_forename\\" value=\\"Test\\"><input type=\\"hidden\\" name=\\"bill_to_surname\\" value=\\"Payer\\"><input type=\\"hidden\\" name=\\"bill_to_email\\" value=\\"Loki@Loki.com\\"><input type=\\"hidden\\" name=\\"bill_to_address_line1\\" value=\\"Loki Zone 19 floor\\"><input type=\\"hidden\\" name=\\"bill_to_address_city\\" value=\\"\u0e1a\u0e49\u0e32\u0e19\u0e23\u0e30\u0e01\u0e32\u0e28 \u0e1b\u0e17\u0e38\u0e21\u0e27\u0e31\u0e19\\"><input type=\\"hidden\\" name=\\"bill_to_address_state\\" value=\\"\u0e01\u0e23\u0e38\u0e07\u0e40\u0e17\u0e1e\u0e21\u0e2b\u0e32\u0e19\u0e04\u0e23\\"><input type=\\"hidden\\" name=\\"bill_to_address_country\\" value=\\"TH\\"><input type=\\"hidden\\" name=\\"bill_to_address_postal_code\\" value=\\"10400\\"><input type=\\"hidden\\" name=\\"signed_field_names\\" value=\\"\\"/><input type=\\"hidden\\" name=\\"unsigned_field_names\\" value=\\"\\"/><input type=\\"hidden\\" name=\\"signature\\" value=\\"\\"/><input type=\\"hidden\\" name=\\"payment_token\\" value=\\"\\"/></form><script language=\\"javascript\\"> document.getElementById(\\"formSubmit\\").submit();</script></body></html>"    \\    ${EMPTY}
    @{result}    Get Regexp Matches    ${remove}    name="access_key" value="(.*)    1
    @{result1}    Split String    @{result}[0]    "
    Comment    @{result2}    Split String    @{result1}[0]    "
    Comment    ${profile_id}    Set Variable    @{result2}[0]
