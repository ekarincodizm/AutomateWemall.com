*** Setting ***
# Library           Selenium2Library
# Library           HttpLibrary.HTTP

*** Variable ***
#place locator here
# ${items}=       Get Matching Xpath Count      //span[@class='bx-link-img']
${thumb_locator}                //span[@class='bx-link-img']
${sort_box_locator}             jquery=.order_by:eq(0)

*** Keywords ***
Merchant LevelC - Go To Category levelc merchant
    [Arguments]    ${merchant_slug}    ${category_slug}
    Open Browser    ${WEMALL_URL}/m-${merchant_slug}-category-${category_slug}.html    chrome
    Maximize Browser Window

Merchant LevelC - Select Sort By
    [Arguments]    ${sort_item_label}
    Select From List By Label    ${sort_box_locator}    ${sort_item_label}

Merchant LevelC - Verify product category sort
    [Arguments]    ${category_pk}    ${field}   ${orderBy}
    Log To Console    TODO Merchant LevelC - Verify product category sort
    #TODO


Merchant LevelC - Verify Paginate
    [Arguments]    ${category_pk}    ${item}
    Log To Console    TODO Merchant LevelC - Verify Paginate

    #check first page
    ${res}=    Merchant LevelC - Get Product Category By PK    ${category_pk}    new    asc    1    ${item}
    #check totalpage
    ${total_page}=    Get json value    ${res}    /data/total_page
    Log To Console    ${total_page}
    Element Should Be Visible    jquery=li.paging:last:contains('${total_page}')
    #check item
    ${data}=    Get Json Value and Convert to List    ${res}    /data/data
    ${dataItems}=    Get Length    ${data}
    ${items}=       Get Matching Xpath Count    ${thumb_locator}
    ${items}=    Convert To Integer    ${items}
    Should Be Equal    ${dataItems}    ${items}

    #check page 2
    Run Keyword If    ${total_page} >= 2    Merchant LevelC - SSS    ${category_pk}    ${item}   2
    #check last page
    Run Keyword If    ${total_page} != 1    Merchant LevelC - SSS    ${category_pk}    ${item}   ${total_page}

Merchant LevelC - SSS
    [Arguments]    ${category_pk}    ${item}   ${page}
    Wait Until Element Is Visible    jquery=div.sort_group_bottom li.paging:contains('${page}')    30s
    Click Element    jquery=div.sort_group_bottom li.paging:contains('${page}')
    Sleep    4s
    ${res}=    Merchant LevelC - Get Product Category By PK    ${category_pk}    new    asc    ${page}    ${item}
    # #check totalpage
    # ${total_page}=    Get json value    ${res}    /data/total_page
    # Log To Console    ${total_page}
    # Element Should Be Visible    jquery=li.paging:last:contains('${total_page}')
    #check item
    ${data}=    Get Json Value and Convert to List    ${res}    /data/data
    ${dataItems}=    Get Length    ${data}
    ${items}=       Get Matching Xpath Count    ${thumb_locator}
    ${items}=    Convert To Integer    ${items}
    Should Be Equal    ${dataItems}    ${items}

Merchant LevelC - Select item per page
    [Arguments]    ${item}
    Log To Console    TODO Merchant LevelC - Select item per page
    # Select From List By Label    ${sort_box_locator}    ${item}



Merchant LevelC - Get Product Category By PK
    [Arguments]    ${collection_id}    ${orderBy}    ${order}    ${page}=1    ${limit}=24
    Create Http Context    ${PDS_URL_API}    http
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    /categories/${collection_id}/products?page=${page}&orderBy=${orderBy}&order=${order}
    ${response}=    Get Response Body
    [Return]    ${response}


Get Json Value and Convert to List
    [Arguments]    ${json_string}    ${json_pointer}
    ${json_value}=    Get Json Value    ${json_string}    ${json_pointer}
    ${json_value}=  Parse Json  ${json_value}
    # Log List    ${json_value}
    Return From Keyword    ${json_value}