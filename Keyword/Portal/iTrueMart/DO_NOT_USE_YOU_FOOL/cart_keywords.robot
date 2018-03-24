*** Settings ***
Library     Selenium2Library
Resource    ${CURDIR}/webelement_cart.robot

*** Keywords ***
Open iTureMart
    Open Browser    ${ITM_URL}    ${BROWSER}
    Maximize Browser Window

Add To Cart
    Wait Until Element Is Visible    ${box-status-has-stock}
    Click Button    ${button-add-to-cart}
    Wait Until Element Is Not Visible    ${ajaxloading-widget-background}

Go To Cart
    Go To    ${ITM_URL}${PAGE_CART}

Go To Product Tefal
    Go To    ${ITM_URL}${PAGE_PRODUCT_TEFAL}

Go To Product Nikon
    Go To    ${ITM_URL}${PAGE_PRODUCT_NIKON}

Go To Checkout
    Click Button    ${button-go-to-checkout}
    Wait Until Element Is Not Visible    ${ajaxloading-widget-background}
    Location Should Be    ${ITM_URL}${PAGE_CHECKOUT}

Expect Prodouct On Cart
    Wait Until Page Contains Element    ${element-products-on-cart}
    Element Should Contain    ${element-products-on-cart}    ${word-products-on-cart}

Add More
    Select From List By Label    ${menulist-on-cart}    ${word-menulist-on-cart}
    Wait Until Element Is Not Visible    ${ajaxloading-widget-background}

Delete Product
    Click Element    ${element-Delete-cart}
    Confirm Action
    Wait Until Element Is Not Visible    ${ajaxloading-widget-background}

Delete Product By Inventory Id
    [arguments]     ${inventory_id}
    Click Element    css=.cartbox-delete-item[data-inventory-id="${inventory_id}"]
    Sleep    5s
    Confirm Action
    Wait Until Element Is Not Visible    ${ajaxloading-widget-background}

Web Will Redirect To Ituremart Full-cart Page
    Wait Until Location Contains        ${ITM_URL}${PAGE_CART}
    # Wait Until Angular Ready    30s

Web Will Redirect To Ituremart Full-cart Page - Secondary Language
    Wait Until Location Contains        ${ITM_URL}/en${PAGE_CART}
    # Wait Until Angular Ready    30s

Cart Badge Amount Should Be Equal
    [arguments]     ${expected}
    ${actual}=    Selenium2Library.Get Element Attribute    ${CART_BADGE}
    Should Be Equal As Strings    ${expected}    ${actual}

Cart Badge Amount Should Not Be Equal
    [arguments]     ${expected}
    ${actual}=    Selenium2Library.Get Element Attribute    ${CART_BADGE}
    Should Not Be Equal As Strings    ${expected}    ${actual}

Click Back to Shopping
    Execute Javascript    window.scrollTo(0,300);
    Sleep    1s
    Wait Until Element Is Visible    ${back_to_previous_page}    20s
    Click Element    ${back_to_previous_page}
