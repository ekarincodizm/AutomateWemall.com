*** Settings ***
Resource          web_element_shipping_details.robot

*** Keywords ***
SS Mobile Shipping Details - Display Shipping Step Info
    SS Mobile Shipping Details - Display Shipping Tracking Title
    SS Mobile Shipping Details - Display Shipping Step Datetime
    SS Mobile Shipping Details - Display Shipping Step Description

SS Mobile Shipping Details - Display Shipping Step
    Wait Until Element Is Visible               ${SS_Shipping_Step_Table}               15s
    Element Should Be Visible                   ${SS_Shipping_Step_Table}

SS Mobile Shipping Details - Display Shipping Title
    Wait Until Element Is Visible               ${SS_Shipping_Title}                    15s
    Element Should Contain                      ${SS_Shipping_Title}                    รายละเอียดการจัดส่ง

SS Mobile Shipping Details - Display Shipping Order Title
    Wait Until Element Is Visible               ${SS_Shipping_Order_Title}              15s
    Element Should Contain                      ${SS_Shipping_Order_Title}              ข้อมูลการจัดส่ง

SS Mobile Shipping Details - Display Shipping Tracking Title
    Wait Until Element Is Visible               ${SS_Shipping_Tracking_Title}           15s
    Element Should Contain                      ${SS_Shipping_Tracking_Title}           สถานะการจัดส่งสินค้า

SS Mobile Shipping Details - Display Shipping Step Datetime
    Wait Until Element Is Visible               ${SS_Shipping_Step.txt_datetime}        15s

SS Mobile Shipping Details - Display Shipping Step Description
    Wait Until Element Is Visible               ${SS_Shipping_Step.txt_description}     15s

SS Mobile Shipping Details - Display Order Info
    SS Mobile Shipping Details - Display Product Name               ${var_item_name}
    SS Mobile Shipping Details - Display Product Qty                ${var_item_quantity}
    SS Mobile Shipping Details - Display Customer Adderss
    SS Mobile Shipping Details - Display Customer Name              ${var_order_customer_name}
    SS Mobile Shipping Details - Display Customer Tel               ${var_order_customer_tel}

SS Mobile Shipping Details - Display Product Name
    [Arguments]   ${product_name}
    Wait Until Element Is Visible               ${SS_Shipping_Product_Name_Title}           15s
    Wait Until Element Is Visible               ${SS_Shipping_Product_Name}                 15s
    Element Should Contain                      ${SS_Shipping_Product_Name}                 ${product_name}

SS Mobile Shipping Details - Display Product Qty
    [Arguments]   ${qty}
    ${qty}=                                     Convert To String                           ${qty}
    Wait Until Element Is Visible               ${SS_Shipping_Product_Qty}                  15s
    Element Should Contain                      ${SS_Shipping_Product_Qty}                  ${qty}

SS Mobile Shipping Details - Display Customer Name
    [Arguments]     ${customer_name}
    Wait Until Element Is Visible               ${SS_Shipping_Customer_Name}                15s
    Element Should Contain                      ${SS_Shipping_Customer_Name}                ${customer_name}

SS Mobile Shipping Details - Display Customer Adderss
    Wait Until Element Is Visible               ${SS_Shipping_Customer_Address_Tiltle}      15s
    Wait Until Element Is Visible               ${SS_Shipping_Customer_Address}             15s
    Element Should Contain                      ${SS_Shipping_Customer_Address}             ${var_order_customer_district}
    Element Should Contain                      ${SS_Shipping_Customer_Address}             ${var_order_customer_city}
    Element Should Contain                      ${SS_Shipping_Customer_Address}             ${var_order_customer_province}
    Element Should Contain                      ${SS_Shipping_Customer_Address}             ${var_order_customer_postcode}

SS Mobile Shipping Details - Display Customer Tel
    [Arguments]         ${customer_tel}
    Wait Until Element Is Visible               ${SS_Shipping_Customer_Tel}                 15s
    Element Should Contain                      ${SS_Shipping_Customer_Tel}                 ${customer_tel}

SS Mobile Shipping Details - Display Close Button
    Wait Until Element Is Visible               ${SS_Shipping_Close_Btn}                    15s