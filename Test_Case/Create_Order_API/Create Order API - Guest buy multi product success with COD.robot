*** Settings ***
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ../../Resource/init.robot


*** Test Cases ***
Create Order API - Guest buy multi product success with COD
    ${order_id}    Create Order API - Guest buy multi product success with COD
    [Teardown]    close browser