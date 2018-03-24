*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Library           ${CURDIR}/../../../../Python_Library/stock_holds_library.py

*** Keywords ***
Count Stock Hold By Order Id
    [Arguments]    ${order_id}
    ${qty_items}=    py_count_stock_hold_by_order_id    ${order_id}
    [Return]    ${qty_items}

Count Stock Hold Permanent By Order Id
    [Arguments]    ${order_id}
    ${qty_items}=    py_count_stock_hold_permanent_by_order_id    ${order_id}
    [Return]    ${qty_items}

Count Stock Hold Temporary By Order Id
    [Arguments]    ${order_id}
    ${qty_items}=    py_count_stock_hold_temporary_by_order_id    ${order_id}
    [Return]    ${qty_items}
