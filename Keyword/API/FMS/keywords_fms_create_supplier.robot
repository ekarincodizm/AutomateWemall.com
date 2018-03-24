*** Settings ***
Library           HttpLibrary.HTTP
Resource          ${CURDIR}/../../../Resource/init.robot

*** Keywords ***
Create Supplier Marketplace From FMS
   Create Http Context    ${FMS_API_V1}    http
   Set Request Body    {"bu_code":"BTH001","company_name":"Flash-test-robot","tax_id":"99999","branch_id":"00000","username":"-","supplier_code":"","vat_supplier":"Y","wht_supplier":"Y","preferred_day_for_po":0,"default_supplier_type":"MF","default_payment_terms":"2","delivery_days":"1000000","pickup_days":"0000000","sap_vendor_id":"2","bank_name":"","bank_account_number":"","account_holder":"","default_po_lead_time":0,"mov_normal_retail":0,"moq_normal_retail":0,"mov_consignment":0,"moq_consignment":0,"mov_marketplace":0,"moq_marketplace":0,"crossdock":"N","option_to_return":"","office_address":{"name":"Business Address","province_id":"1","city_id":"2","district_id":"1","address_line1":"aaa","zip_code":"10200"},"username_login":"developer","supplier_type":"M","contacts":[{"name":"aaa","phone_number1":"aaa","email":"a@sss"}],"warehouses":[{"name":"test","province_id":"3","city_id":"231","district_id":"58","address_line1":"asasas","zip_code":"11130","contacts":[{"name":"sss","phone_number1":"ss","email":"a@a.aa"}]}]}
   Set Request Header     Content-Type      \ \ \ application/json
   HttpLibrary.HTTP.POST    ${supplier_created}
   ${respone}    Get Response Body
   ${header}    Get Response Status
   ${data}    Get Json Value    ${respone}    /data
   ${supplier_code}    Get Json Value    ${data}    /supplier_code
   Should Be Equal    ${header}    200 OK
   [Return]    ${supplier_code}