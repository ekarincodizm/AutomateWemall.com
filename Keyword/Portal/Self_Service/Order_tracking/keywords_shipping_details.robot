*** Settings ***
Resource          web_element_shipping_details.robot

*** Keywords ***
SS Shipping Details - Display Shipping Step
    Wait Until Element Is Visible               ${SS_Shipping_Step_Table}            15s
    Element Should Be Visible                   ${SS_Shipping_Step_Table}

SS Shipping Details - Display Caption as Data and shipping status
    Wait Until Element Is Visible               ${SS_Shipping_Title}            15s
    Element Should Contain                      ${SS_Shipping_Title}               ข้อมูลและสถานะการจัดส่ง

SS Shipping Details - Display Product Name
    [Arguments]   ${product_name}
    Wait Until Element Is Visible               ${SS_Shipping_Product_Name}            15s
    Element Should Contain                      ${SS_Shipping_Product_Name}             ${product_name}

SS Shipping Details - Display Product Qty
    [Arguments]   ${qty}
    ${qty}=                                     Convert To String                     ${qty}
    Wait Until Element Is Visible               ${SS_Shipping_Product_Qty}            15s
    Element Should Contain                      ${SS_Shipping_Product_Qty}             ${qty}

SS Shipping Details - Display Customer Name
    [Arguments]     ${customer_name}
    Wait Until Element Is Visible               ${SS_Shipping_Customer_Name}            15s
    Element Should Contain                      ${SS_Shipping_Customer_Name}             ${customer_name}

SS Shipping Details - Display Customer Adderss
    Wait Until Element Is Visible               ${SS_Shipping_Customer_Address}            15s
    Element Should Contain                      ${SS_Shipping_Customer_Address}            ${var_order_customer_district}
    Element Should Contain                      ${SS_Shipping_Customer_Address}            ${var_order_customer_city}
    Element Should Contain                      ${SS_Shipping_Customer_Address}            ${var_order_customer_province}
    Element Should Contain                      ${SS_Shipping_Customer_Address}            ${var_order_customer_postcode}

SS Shipping Details - Display Customer Tel
    [Arguments]         ${customer_tel}
    Wait Until Element Is Visible               ${SS_Shipping_Customer_Tel}            15s
    Element Should Contain                      ${SS_Shipping_Customer_Tel}             ${customer_tel}
