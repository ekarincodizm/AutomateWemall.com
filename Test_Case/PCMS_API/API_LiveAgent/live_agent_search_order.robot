*** Settings ***
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Api_LiveAgent/keywords_live_agent_search_order.robot
#Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot
#Resource    ${CURDIR}/../../../Keyword/Database/PCMS/keyword_order.robot
#Resource    ${CURDIR}/../../../Keyword/Database/PCMS/keyword_holiday.robot
#Resource    ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
#Library     ${CURDIR}/../../../Python_Library/order_history_library.py
#Library     ${CURDIR}/../../../Python_Library/holidays_library.py

Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String

#Test Teardown     End Test Case

*** Test Cases ***
TC_iTM_00960: To verify that the API return customer information when send request with customer name and peroid create order date
      [Tags]   TC_iTM_00960    Ready    Success
        Input Type Api Search Order                     customer_name
        Input Name Api Search Order                         test
        Input Date Start Api Search Order                2015-01-02
        Input Date End Api Search Order                  2016-02-29
        Input Page Number                                    1
        Input Payment Status Api Search Order
        Input Item Status Api Search Order
        Call Api Search Order
        Expect Api Search Order Success Status Is200

TC_iTM_00961: To verify that the API return customer information when send request with customer name and peroid create order date and to view page 2
     [Tags]   TC_iTM_00961    Ready    Success
        Input Type Api Search Order                     customer_name
        Input Name Api Search Order                         test
        Input Date Start Api Search Order                2015-01-02
        Input Date End Api Search Order                  2016-02-29
        Input Page Number                                    2
        Input Payment Status Api Search Order
        Input Item Status Api Search Order
        Call Api Search Order
        Expect Api Search Order Success Status Is200

TC_iTM_00962: To verify that the API return customer information when send request with customer name and peroid create order date and payment status
   [Tags]   TC_iTM_00962    Ready    Success
       Input Type Api Search Order                                          customer_name
       Input Name Api Search Order                                                test
       Input Date Start Api Search Order                                     2015-1-02
       Input Date End Api Search Order                                       2016-02-29
       Input Page Number                                                           1
       Input Payment Status Api Search Order                                    success
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00963: To verify that the API return customer information when send request with customer name and period create order date and payment status and Item status
    [Tags]   TC_iTM_00963    Ready    Success
       Input Type Api Search Order                                          customer_name
       Input Name Api Search Order                                              test
       Input Date Start Api Search Order                                     2015-1-02
       Input Date End Api Search Order                                       2016-02-29
       Input Page Number                                                           1
       Input Payment Status Api Search Order                                    success
       Input Item Status Api Search Order                                    order_pending
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00964: To verify that the API return customer information when send request with customer email and period create order date
    [Tags]   TC_iTM_00964    Ready    Success
       Input Type Api Search Order                                           customer_email
       Input Name Api Search Order                                       systemtestel2@gmail.com
       Input Date Start Api Search Order                                     2015-01-02
       Input Date End Api Search Order                                       2016-01-03
       Input Page Number                                                           1
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00965: To verify that the API return customer information when send request with customer email and period create order date and to view page 2
    [Tags]   TC_iTM_00965    Ready    Success
       Input Type Api Search Order                                           customer_email
       Input Name Api Search Order                                           e2e@gmail.com
       Input Date Start Api Search Order                                     2016-01-01
       Input Date End Api Search Order                                       2016-03-20
       Input Page Number                                                           2
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00966: To verify that the API return customer information when send request with customer email and period create order date and payment status
    [Tags]   TC_iTM_00966    Ready    Success
       Input Type Api Search Order                                           customer_email
       Input Name Api Search Order                                       systemtestel2@gmail.com
       Input Date Start Api Search Order                                     2015-02-29
       Input Date End Api Search Order                                       2016-01-03
       Input Page Number                                                           1
       Input Payment Status Api Search Order                                   expired
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00967: To verify that the API return customer information when send request with customer email and period create order date and payment status and Item status
     [Tags]   TC_iTM_00967    Ready    Success
       Input Type Api Search Order                                           customer_email
       Input Name Api Search Order                                           e2e@gmail.com
       Input Date Start Api Search Order                                     2016-03-01
       Input Date End Api Search Order                                       2016-03-20
       Input Page Number
       Input Payment Status Api Search Order                                   success
       Input Item Status Api Search Order                                  pending_shipment
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00968: To verify that the API return customer information when send request with customer tel and period create order date
     [Tags]   TC_iTM_00968    Ready    Success
       Input Type Api Search Order                                      customer_tel
       Input Name Api Search Order                                           0863707690
       Input Date Start Api Search Order                                     2015-02-29
       Input Date End Api Search Order                                       2016-01-03
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00969: To verify that the API return customer information when send request with customer tel and period create order date and to view page 1
     [Tags]   TC_iTM_00969    Ready    Success
       Input Type Api Search Order                                      customer_tel
       Input Name Api Search Order                                           0863707690
       Input Date Start Api Search Order                                     2015-02-29
       Input Date End Api Search Order                                       2016-01-03
       Input Page Number                                                          1
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00970: To verify that the API return customer information when send request with customer tel and period create order date and payment status is waitting
     [Tags]   TC_iTM_00970    Ready    Success
       Input Type Api Search Order                                           customer_tel
       Input Name Api Search Order                                           0900000000
       Input Date Start Api Search Order                                     2016-03-01
       Input Date End Api Search Order                                       2016-03-20
       Input Page Number
       Input Payment Status Api Search Order                                 waiting
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00971: To verify that the API return customer information when send request with customer tel and period create order date and payment status = reconcile
     [Tags]   TC_iTM_00971    Ready    Success
       Input Type Api Search Order                                           customer_tel
       Input Name Api Search Order                                           0873600219
       Input Date Start Api Search Order                                     2016-03-01
       Input Date End Api Search Order                                       2016-03-20
       Input Page Number
       Input Payment Status Api Search Order                                 reconcile
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00972: To verify that the API return customer information when send request with customer tel and period create order date and Item status = shipped
     [Tags]   TC_iTM_00972    Ready    Success
       Input Type Api Search Order                                           customer_tel
       Input Name Api Search Order                                           0863707690
       Input Date Start Api Search Order                                     2015-03-01
       Input Date End Api Search Order                                       2016-03-20
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order                                     shipped
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00973: To verify that the API return customer information when send request with customer tel and period create order date and Item status = delivered
     [Tags]   TC_iTM_00973    Ready    Success
       Input Type Api Search Order                                           customer_tel
       Input Name Api Search Order                                           0863707690
       Input Date Start Api Search Order                                     2015-02-29
       Input Date End Api Search Order                                       2016-01-03
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order                                     delivered
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00974: To verify that the API return customer information when send request with customer tel and period create order date and Item status = new
     [Tags]   TC_iTM_00974    Ready    Success
       Input Type Api Search Order                                           customer_tel
       Input Name Api Search Order                                           0863707690
       Input Date Start Api Search Order                                     2015-02-29
       Input Date End Api Search Order                                       2016-01-03
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order                                       new
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00975: To verify that the API return customer information when send request with customer tel and period create order date and Item status = customer cancelled
     [Tags]   TC_iTM_00975    Ready    Success
       Input Type Api Search Order                                           customer_tel
       Input Name Api Search Order                                             0831371445
       Input Date Start Api Search Order                                       2016-03-01
       Input Date End Api Search Order                                         2016-03-21
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order                                   customer_cancelled
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00976: To verify that the API return customer information when send request with order id and period create order date
     [Tags]    TC_iTM_00976    Ready    Success
       Input Type Api Search Order                                         id
       Input Name Api Search Order                                        1000019
       Input Date Start Api Search Order                                2015-02-29
       Input Date End Api Search Order                                  2016-01-03
       Input Page Number                                                    1
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order Success Status Is200

TC_iTM_00977: To verify that the API return code 422 when no send value request
     [Tags]   TC_iTM_00977    Fail    422
       Input Type Api Search Order                                         id
       Input Name Api Search Order
       Input Date Start Api Search Order
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00978: To verify that the API return code 422 when send request with customer name only
     [Tags]   TC_iTM_00978    Fail    422
       Input Type Api Search Order                                         customer_name
       Input Name Api Search Order                                              test
       Input Date Start Api Search Order
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00979: To verify that the API return code 422 when send request with customer email only
       [Tags]   TC_iTM_00979    Fail    422
       Input Type Api Search Order                                         customer_email
       Input Name Api Search Order                                       samart.exe@gmail.com
       Input Date Start Api Search Order
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00980: To verify that the API return code 422 when send request with customer tel only
    [Tags]   TC_iTM_00980    Fail    422
       Input Type Api Search Order                                         customer_tel
       Input Name Api Search Order                                          0863707690
       Input Date Start Api Search Order                                    2014-11-10
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00981: To verify that the API return code 422 when send request with order id only
    [Tags]   TC_iTM_00981    Fail    422
       Input Type Api Search Order                                         id
       Input Name Api Search Order                                       99789
       Input Date Start Api Search Order                             2014-11-10
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00982: To verify that the API return code 422 when send request with start date only
    [Tags]   TC_iTM_00982    Fail    422
       Input Type Api Search Order
       Input Name Api Search Order
       Input Date Start Api Search Order                             2014-11-10
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00983: To verify that the API return code 422 when send request with end date only
    [Tags]   TC_iTM_00983    Fail    422
       Input Type Api Search Order
       Input Name Api Search Order
       Input Date Start Api Search Order
       Input Date End Api Search Order                           2016-01-03
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00984: To verify that the API return code 422 when send request with payment status only
    [Tags]   TC_iTM_00984    Fail    422
       Input Type Api Search Order                          customer_name
       Input Name Api Search Order                             test
       Input Date Start Api Search Order                    2014-11-101
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order                       success
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00985: To verify that the API return code 422 when send request with item status only
    [Tags]   TC_iTM_00985    Fail    422
       Input Type Api Search Order                          customer_name
       Input Name Api Search Order                             test
       Input Date Start Api Search Order                    2014-11-101
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order                       order_pending
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00986: To verify that the API return code 422 when send request with customer name and start date
    [Tags]   TC_iTM_00986    Fail    422
       Input Type Api Search Order                          customer_name
       Input Name Api Search Order                             test
       Input Date Start Api Search Order                    2014-11-101
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00987: To verify that the API return code 422 when send request with customer email and start date
    [Tags]   TC_iTM_00987    Fail    422
       Input Type Api Search Order                          customer_email
       Input Name Api Search Order                             test
       Input Date Start Api Search Order                    2014-11-101
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00988: To verify that the API return code 422 when send request with customer tel and start date
    [Tags]   TC_iTM_00988    Fail    422
       Input Type Api Search Order                          customer_tel
       Input Name Api Search Order                             test
       Input Date Start Api Search Order                    2014-11-101
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00989: To verify that the API return code 422 when send request with order id and start date
    [Tags]   TC_iTM_00989    Fail    422
       Input Type Api Search Order                          id
       Input Name Api Search Order                          test
       Input Date Start Api Search Order                 2016-01-01
       Input Date End Api Search Order
       Input Page Number
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422


TC_iTM_00990: To verify that the API return code 422 when send request with start date and end date
    [Tags]   TC_iTM_00990    Fail    422
       Input Type Api Search Order
       Input Name Api Search Order
       Input Date Start Api Search Order                 2016-01-01
       Input Date End Api Search Order                  2016-02-29
       Input Page Number                   1
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 422 Unprocessable Entity Is422

TC_iTM_00991: To verify that the API return code 404 when the requested information is not found in the database.
    [Tags]   TC_iTM_00991    Fail    422
      Input Type Api Search Order                     customer_name
       Input Name Api Search Order                         abc
       Input Date Start Api Search Order                2016-11-10
       Input Date End Api Search Order                  2016-02-29
       Input Page Number                   1
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 404 Notfound Status Is404


TC_iTM_00992: To verify that the API return code 404 when the requested information is not matching the request
    [Tags]   TC_iTM_00992    Fail    422
       Input Type Api Search Order                     customer_name
       Input Name Api Search Order                         test
       Input Date Start Api Search Order                2016-11-10
       Input Date End Api Search Order                  2016-02-29
       Input Page Number                   1
       Input Payment Status Api Search Order
       Input Item Status Api Search Order
       Call Api Search Order
       Expect Api Search Order 404 Notfound Status Is404





