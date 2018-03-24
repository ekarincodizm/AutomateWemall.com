*** Settings ***
Resource                    ${CURDIR}/../mega_menu_banner_group/cms_mega_menu_banner_group_keywords.robot
Resource                    ${CURDIR}/webelement_mega_menu_page.robot
Resource                    ${CURDIR}/../common/common.resource.robot
Library                     ${CURDIR}/../../../../Python_Library/seleniumutility.py
Resource                    ${CURDIR}/../../../API/api_portals/megamenus_keywords.robot

*** Keywords ***
# Open Brower AND Go To Manage Mega Menu
#     Open Browser    ${PORTAL-HOST}    chrome

Select Mega Menu Page
    Sleep    5s
    Wait Until Element Is Visible    ${manage_portal}    5s
    Click Element and Wait Angular Ready    ${manage_portal}
    Wait Until Element Is Visible    ${mega_menubutton}    5s
    Click Element and Wait Angular Ready    ${mega_menubutton}
    Sleep    2s

Click Add Mega Menu Level1 And Verify Field Mega Menu Level1
    Wait Until Element Is Visible    ${add_level1_btn}
    Click Element and Wait Angular Ready    ${add_level1_btn}
    Wait Until Element Is Visible    ${menu_name_th}
    Wait Until Element Is Visible    ${menu_name_en}
    Wait Until Element Is Visible    ${menu_link_th}
    Wait Until Element Is Visible    ${menu_link_en}

Update Mega Menu Level1
    [Arguments]    ${namelvl1_th}    ${name_th}   ${name_en}   ${link_th}    ${link_en}
    Click Edit Mega Menu Level1    ${namelvl1_th}
    Input Text    ${menu_name_th}    ${name_th}
    Input Text    ${menu_name_en}    ${name_en}
    Input Text    ${menu_link_th}    ${link_th}
    Input Text    ${menu_link_en}    ${link_en}
    Click Element and Wait Angular Ready    ${ok_btn}

Verify Required Message On Mega Menu Level1
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Name TH')
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Name EN')
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Link TH')
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Link EN')

Verify Required Message On Mega Menu Level2 Type Link
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Name TH')
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Name EN')
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Link TH')
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Link EN')

Verify Required Message On Mega Menu Level2 Type Header
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Name TH')
    Wait Until Element Is Visible    jquery=span:contains(Please enter 'Name EN')

Create Mega Menu Level1
    [Arguments]    ${name_th}    ${name_en}    ${link_th}    ${link_en}
    Wait Until Element Is Visible    ${add_level1_btn}
    Click Element and Wait Angular Ready    ${add_level1_btn}
    Wait Until Element Is Visible    ${menu_name_th}
    Input Text    ${menu_name_th}    ${name_th}
    Input Text    ${menu_name_en}    ${name_en}
    Input Text    ${menu_link_th}    ${link_th}
    Input Text    ${menu_link_en}    ${link_en}
    Click Element and Wait Angular Ready    ${ok_btn}

Create Mega Menu Level2
    [Arguments]    ${name_th}    ${name_en}    ${link_th}    ${link_en}    ${type}=link
    Wait Until Element Is Visible    ${add_level2_btn}
    Click Element and Wait Angular Ready    ${add_level2_btn}
    Wait Until Element Is Visible    ${menu_namelvl2_th}
    Input Text    ${menu_namelvl2_th}    ${name_th}
    Input Text    ${menu_namelvl2_en}    ${name_en}
    Click Element and Wait Angular Ready    jquery=div.radio span[data-id='lb-${type}']
    Run Keyword If    '${type}'=='link'    Input Text    ${menu_linklvl2_th}    ${link_th}
    Run Keyword If    '${type}'=='link'    Input Text    ${menu_linklvl2_en}    ${link_en}
    Run Keyword If    '${type}'=='header'    Element Should Not Be Visible    ${menu_linklvl2_th}
    Run Keyword If    '${type}'=='header'    Element Should Not Be Visible    ${menu_linklvl2_en}
    Click Element and Wait Angular Ready    ${ok_btn}

Click Edit Mega Menu Level2
    [Arguments]    ${name}
    ${is_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    jquery=div.dd2-content:contains(${name}) a[data-id='lv2-edit-menu']    10s
    Run Keyword If    '${is_visible}' == 'False'    Create Mega Menu Level2    ${name}    ${namelvl2_en}    ${linklvl2_th}    ${linklvl2_en}    ${header}
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}) a[data-id='lv2-edit-menu']

Update Mega Menu Level2
    [Arguments]    ${namelvl1_th}    ${name_th}   ${name_en}   ${link_th}    ${link_en}    ${type}=link
    Click Edit Mega Menu Level2    ${namelvl1_th}
    Wait Until Element Is Visible    ${menu_namelvl2_th}
    Input Text    ${menu_namelvl2_th}    ${name_th}
    Input Text    ${menu_namelvl2_en}    ${name_en}
    Click Element and Wait Angular Ready    jquery=div.radio span[data-id='lb-${type}']
    Run Keyword If    '${type}'=='link'    Input Text    ${menu_linklvl2_th}    ${link_th}
    Run Keyword If    '${type}'=='link'    Input Text    ${menu_linklvl2_en}    ${link_en}
    Run Keyword If    '${type}'=='header'    Element Should Not Be Visible    ${menu_linklvl2_th}
    Run Keyword If    '${type}'=='header'    Element Should Not Be Visible    ${menu_linklvl2_en}
    Click Element and Wait Angular Ready    ${ok_btn}

Click All Publish Mega Menu
    Wait Until Element Is Visible    ${publish_btn}
    Click Element and Wait Angular Ready    ${publish_btn}
    Wait Until Element Is Visible    jquery=div#cmsAlert

Click Delete Mega Menu Level1
    [Arguments]    ${name}
    ${is_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    jquery=div.dd2-content:contains(${name}) a[data-id='delete-menu']    10s
    Run Keyword If    '${is_visible}' == 'True'    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}) a[data-id='delete-menu']
    Run Keyword If    '${is_visible}' == 'True'    Wait Until Element Is Visible    jquery=button:contains(Confirm)     10s
    Run Keyword If    '${is_visible}' == 'True'    Click Element and Wait Angular Ready    jquery=button:contains(Confirm)

Click Delete Mega Menu Level2
    [Arguments]    ${name}
    Wait Until Element Is Visible    jquery=div.dd2-content:contains(${name}) a[data-id='lv2-delete-menu']    5s
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}) a[data-id='lv2-delete-menu']
    Wait Until Element Is Visible    jquery=button:contains(Confirm)
    Click Element and Wait Angular Ready    jquery=button:contains(Confirm)

Click Edit Mega Menu Level1
    [Arguments]    ${name}
    Wait Until Element Is Visible    jquery=div.dd2-content:contains(${name}) a[data-id='edit-menu']    5s
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}) a[data-id='edit-menu']

Click Mega Menu Level1
    [Arguments]    ${name}
    ${is_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    jquery=div.dd2-content:contains(${name}):last    10s
    Run Keyword If    '${is_visible}' == 'False'    Create Mega Menu Level1    ${name}    ${namelvl1_en}    ${linklvl1_th}    ${linklvl1_en}
    Click Element and Wait Angular Ready    jquery=div.dd2-content:contains(${name}):last

Click All Draft Mega Menu
    Wait Until Element Is Visible    ${save_btn}
    Click Element and Wait Angular Ready    ${save_btn}

Select Mega Menu Level 1
    [Arguments]    ${line}
    Click Element and Wait Angular Ready    ${mega_menulvl1}:eq(${line})

Verify that check Mega Menu Lvl2 with API
    [Arguments]    ${length}    ${res}
    :FOR    ${index}    IN RANGE    0    ${length}
    # \    ${upper_res}=    Convert To Uppercase    ${res[${index}]}
    \    Verify Mega Menu Level2 Show Data Correctly    ${index}    ${res[${index}]}

Click Preview All Mega Menu Page
    Wait Until Element Is Visible    ${publish_all_button}
    Click Element and Wait Angular Ready    ${publish_all_button}

Mouse Over On Mega Menu Level1
    [Arguments]    ${list_line_menu}
    Mouse Over    jquery=li[ng-repeat='menu in mega'] span.ng-binding:eq(${list_line_menu})

Select Window On Preview Portal Page
    Select Window    url=${WEMALL_WEB}/?${PRIVIEW_TOKEN}

Verify that check Mega Menu Lvl2 On Portal Page with API
    [Arguments]    ${length}    ${res}    ${countlvl2}
    :FOR    ${index}    IN RANGE    0    ${length}
    # \    ${upper_res}=    Convert To Uppercase    ${res[${index}]}
    \    Verify Mega Menu On Portal Page Show Level2 Correctly    ${index}    ${res[${index}]}    ${countlvl2}
    # \    ${countlvl2}=     Set Variable    ${countlvl2}+1
    \    ${countlvl2}=    Convert To Integer    ${countlvl2}
    \    ${countlvl2}=     Evaluate    ${countlvl2}+1

Get Data Dictionary Of API CMS PROTAL
    [Arguments]    ${menu_id}
    GET Mega Menu Data        ${menu_id}?version=draft
    ${raw_menu_body}=    Get Response Body
    ${raw_menu_dict}=    Convert json to Dict    ${raw_menu_body}
    ${raw_menu_dict}=    Get From Dictionary     ${raw_menu_dict}    data
    ${raw_menu_dict}=    Get From Dictionary     ${raw_menu_dict}    1
    ${raw_menu_dict}=    Get From Dictionary     ${raw_menu_dict}    child
    ${raw_menu_dict}=    Convert Child To List    ${raw_menu_dict}
    [Return]    ${raw_menu_dict}

Get All Mega Menu Level1 From API CMS Portal
    [Arguments]    ${menu_id}
    ${raw_menu_dict}=    Get Data Dictionary Of API CMS PROTAL    ${menu_id}
    Log     ${raw_menu_dict}
    ${length}=    Get Length    ${raw_menu_dict}
    ${listmenu}=    Create List
    :FOR     ${index}    IN RANGE    0    ${length}
    \    ${list}=    Get From Dictionary    ${raw_menu_dict[${index}]}    label
    \    Append To List    ${listmenu}    ${list}
    Log    ${listmenu}
    [Return]    ${listmenu}

Get Mega Menu Level2 From API CMS Portal
    [Arguments]    ${menu_id}    ${linelevel1}
    ${raw_menu_dict}=    Get Data Dictionary Of API CMS PROTAL    ${menu_id}

    ${listmenulvl2}=    Create List
    ${list}=    Get From Dictionary    ${raw_menu_dict[${linelevel1}]}    child
    ${list}=    Convert Child To List    ${list}
    ${length}=    Get Length    ${list}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${listmenu2}=    Get From Dictionary    ${list[${index}]}    label
    \    Append To List    ${listmenulvl2}    ${listmenu2}
    Log    ${listmenulvl2}
    [Return]    ${listmenulvl2}

Verify Mega Menu Level1 Show Data Correctly
    [Arguments]    ${list_line_menu}    ${list_megaapi}
    ${name_mega}=     Get Text    jquery=div.dd2-content span[data-id='menu-name']:eq(${list_line_menu})
    Log    ${name_mega} AND ${list_megaapi}
    Should Be Equal    ${name_mega}    ${list_megaapi}

Verify Mega Menu On Portal Page Show Level1 Data Correctly
    [Arguments]    ${list_line_menu}    ${list_megaapi}
    ${name_mega}=     Get Text    jquery=li[ng-repeat='menu in mega'] span.ng-binding:eq(${list_line_menu})
    Log    ${name_mega} AND ${list_megaapi}
    Should Be Equal    ${name_mega}    ${list_megaapi}

Verify Mega Menu Level2 Show Data Correctly
    [Arguments]    ${list_line_menulvl2}    ${list_megalvl2api}
    ${name_megalvl2}=     Get Text    jquery=div.dd2-content span[data-id='lv2-menu-name']:eq(${list_line_menulvl2})
    # ${name_megalvl2_uppercase}=    Convert To Uppercase    ${name_megalvl2}
    ${class_css}=    Selenium2Library.Get Element Attribute    jquery=div.dd2-content span[data-id='lv2-menu-name']:eq(${list_line_menulvl2})@class
    ${status}=    Run Keyword And Return Status    Should Contain    ${class_css}    megamenu-lv2-header
    Log    ${status}
    ${lvl2Upper}=    Convert To Uppercase    ${list_megalvl2api}
    Run Keyword If    ${status} == True     Should Be Equal    ${name_megalvl2}    ${lvl2Upper}
    Run Keyword If    ${status} == False    Should Be Equal    ${name_megalvl2}    ${list_megalvl2api}

Verify Mega Menu On Portal Page Show Level2 Correctly
    [Arguments]    ${list_line_menulvl2}    ${list_megalvl2api}    ${countlevel2}
    ${name_megalvl2}=     Get Text    jquery=div.mega-sub-list li.ng-scope:eq(${${countlevel2}})
    # ${name_megalvl2_uppercase}=    Convert To Uppercase    ${name_megalvl2}
    # $("li[ng-repeat='list in menu.subLists']")
    ${class_css}=    Selenium2Library.Get Element Attribute    jquery=li[ng-repeat='list in menu.subLists']:eq(${${countlevel2}})@class

    ${element}=    Get WebElement    jquery=li[ng-repeat='list in menu.subLists']:eq(${${countlevel2}})

    ${status}=    Find Element By Css    ${element}    'p'
    Log    ${status}
    ${lvl2Upper}=    Convert To Uppercase    ${list_megalvl2api}
    Run Keyword If    ${status} != None     Should Be Equal    ${name_megalvl2}    ${lvl2Upper}
    Run Keyword If    ${status} == None    Should Be Equal    ${name_megalvl2}    ${list_megalvl2api}

Create New Banner Group
    [Arguments]     ${textTest}    ${img_with_path1}    ${img_with_path2}    ${img_with_path3}    ${notuse}=None
    Run Keyword If    '${notuse}'=='None'    Click Banner Group Management

    Click Add Banner Group
    Input Text Banner Group Th              ${textTest}
    Input Text Banner Group En              ${textTest}
    Click Submit Banner
    Selenium2Library.Element Text Should Be    ${banner_item}:contains("${textTest}")            ${textTest}
    Click Element and Wait Angular Ready           ${banner_item}:contains("${textTest}")
    Add Banner Content         ${img_with_path1}    ${img_with_path2}    ${img_with_path3}     ${textTest}
    Click Save Banner Group

