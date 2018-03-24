*** Settings ***
Library         String
Library         BuiltIn
Library         Collections
Library         Selenium2Library
Library         ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource        ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot
Resource        ${CURDIR}/../../../Resource/page_object/wemall-mobile/portal_page_resource.robot
Resource        ${CURDIR}/../../../Resource/config/${ENV}/env_config.robot
Resource        ${CURDIR}/../../../Resource/init.robot

*** Keywords ***
Open Portal Main Page
    Open Mobile Browser     ${WEMALL_WEB}/portal/${mainPage}        ${BROWSER}

Open Portal iTrueMart Mobile
    Open Mobile Browser     ${ITM_MOBILE}/${home}        ${BROWSER}

Open Portal Promotion Page
    Open Mobile Browser     ${WEMALL_WEB}/portal/${promotionPage}        ${BROWSER}

Open Portal EverydayWow Page
    Open Mobile Browser     ${WEMALL_WEB}/portal/${everydayWowPage}        ${BROWSER}

Open Portal Category Page
    Open Mobile Browser     ${WEMALL_WEB}/portal/${categoryPage}        ${BROWSER}

Open Portal Search Page
    Open Mobile Browser     ${WEMALL_WEB}/portal/${searchPage}        ${BROWSER}

Display Wemall Mobile Location
    [Arguments]   ${lang}=th
    Run Keyword If   '${lang}'=='th'  Location Should Contain   ${WEMALL_MOBILE_URL}
     ...      ELSE   Location Should Contain   ${WEMALL_MOBILE_URL}/${lang}

Display Wemall Mobile Location With URI
    [Arguments]   ${uri}   ${lang}=th
    # ${uri} = /sometihing
    Run Keyword If   '${lang}'=='th'  Location Should Contain   ${WEMALL_MOBILE_URL}${uri}
     ...      ELSE   Location Should Contain   ${WEMALL_MOBILE_URL}/${lang}${uri}

Display Wemall Mobile SSL Location With URI
    [Arguments]   ${uri}   ${lang}=th
    # ${uri} = /sometihing
    Run Keyword If   '${lang}'=='th'  Location Should Contain   ${WEMALL_MOBILE_URL_SSL}${uri}
     ...      ELSE   Location Should Contain   ${WEMALL_MOBILE_URL_SSL}/${lang}${uri}

Switch To Portal Desktop Page

Switch To Portal Mobile Page

Verify Portal Header
    Wait Until Angular Ready    30s

Verify Portal Search
    Wait Until Angular Ready    30s

Verify Portal Menu
    Wait Until Angular Ready    30s

Verify Portal Highlight Box
    Wait Until Angular Ready    30s

Verify Portal Brand Box
    Wait Until Angular Ready    30s

Verify Portal Wow Box
    Wait Until Angular Ready    30s

Verify Portal Showroom Box
    Wait Until Angular Ready    30s

Verify Portal Footer
    Wait Until Angular Ready    30s

Initialize Suite Variable
    [Arguments]  ${page}
    ${dict}=   Create Dictionary   page=${page}
    Set Test Variable   ${TEST_VAR}  ${dict}

Open Mobile Browser without resize
    [Arguments]     ${HOST}    ${BROWSER}    ${ALIAS}=None
    Open Browser    ${HOST}    ${BROWSER}    ${ALIAS}
    Add Cookie      is_mobile  true
    Reload Page
    Set Window Position   ${0}      ${0}
    # Set Window Size       ${320}    ${568}

Open Portal Main Page without resize
    Open Mobile Browser without resize     ${WEMALL_WEB}/portal/${mainPage}        ${BROWSER}
    Maximize Browser Window

###########################################################   CMS   ##############################################################
Open CMS WeMall
    Open Browser   ${PORTAL-HOST}
    Wait Until Element Is Visible   ${XPATH_CMS.link_category_manage_portal}
    Maximize Browser Window

Click Manage Portal
    Click Element   ${XPATH_CMS.link_category_manage_portal}

Click Manage Portal MenuBar
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_menubar}
    Click Element   ${XPATH_CMS.link_manage_portal_menubar}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_menubar_respond}

Click Manage Portal Mega Menu
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_megamenu}
    Click Element   ${XPATH_CMS.link_manage_portal_megamenu}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_megamenu_respond}

Click Manage Portal Mega Menu Highlights
    Wait Until Element Is Visible   ${XPATH_CMS.txt_highlights}
    Click Element   ${XPATH_CMS.txt_highlights}

Click Manage Portal Merchant Zone
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_merchantzone}
    Click Element   ${XPATH_CMS.link_manage_portal_merchantzone}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_merchantzone_respond}

Click Manage Portal ShowRoom
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_showroom}
    Click Element   ${XPATH_CMS.link_manage_portal_showroom}
    Sleep   1s
    Click Element   ${XPATH_CMS.link_manage_portal_merchantzone}
    Sleep   1s
    Click Element   ${XPATH_CMS.link_manage_portal_showroom}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_showroom_respond}

Count MenuBar Category in Manage Portal
    ${Get_Category_Number}   Get matching xpath count   ${XPATH_CMS.cnt_manage_portal_menubar_category}
    Log To Console   \n Category Number = ${Get_Category_Number} \n
    Set Test Variable   ${Check_Category_Number}   ${Get_Category_Number}

    @{Get_Category_Name_In_CMS_WeMall}=   Create List  ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Get_Category_Number}+1
    \  ${XPATH_CMS_Menubar_category_name}   Catenate  SEPARATOR=  ${XPATH_CMS.cnt_manage_portal_menubar_category}[${index}]/div[2]/span
    \  Log To Console   Category Name No.${index}

    \  ${Get_Category_Data}  Get Text   ${XPATH_CMS_Menubar_category_name}
    \  Append To List  ${Get_Category_Name_In_CMS_WeMall}   ${Get_Category_Data}

    \  ${Get_Category_Name_From_List}=  Get From List   ${Get_Category_Name_In_CMS_WeMall}   ${index}
    \  Log To Console   ${Get_Category_Name_From_List} \n

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Category_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}
    # Log To Console    ${TEST_VAR}

Count Mega Menu Category in Manage Portal
    ${Get_Category_Number}   Get matching xpath count   ${XPATH_CMS.cnt_manage_portal_megamenu_level1}
    Log To Console   \n Category Number = ${Get_Category_Number} \n
    Set Test Variable   ${Check_Category_Number}   ${Get_Category_Number}

    @{Get_Category_Name_In_CMS_WeMall}=   Create List  ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Get_Category_Number}+1
    \  ${XPATH_CMS_MegaMenu_category_name}   Catenate  SEPARATOR=  ${XPATH_CMS.cnt_manage_portal_megamenu_level1}[${index}]/div[2]/span
    \  Log To Console   Category Name No.${index}

    \  ${Get_Category_Data}   Get Text   ${XPATH_CMS_MegaMenu_category_name}
    \  Append To List  ${Get_Category_Name_In_CMS_WeMall}   ${Get_Category_Data}

    \  ${Get_Category_Name_From_List}=  Get From List   ${Get_Category_Name_In_CMS_WeMall}   ${index}
    \  Log To Console   ${Get_Category_Name_From_List} \n

    ${dict}=   Set Variable  ${TEST_VAR}
    Set To Dictionary   ${dict}    package_name=${Get_Category_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}  ${dict}
    # Log To Console    ${TEST_VAR}

Count Merchant Zone Picture in Manage Portal
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_merchantzone_respond}

    ${Get_Merchantzone_category_name}   Get Text   ${XPATH_CMS.txt_merchantzone_category_name}
    Log To Console   Merchant Zone Category Name = ${Get_Merchantzone_category_name}
    Set Test Variable   ${Check_Merchantzone_category_name}   ${Get_Merchantzone_category_name}

    ${Get_pic_banner_left}   Selenium2Library.Get Element Attribute   ${XPATH_CMS.get_attribute_banner_left}
    Log To Console   \n ${Get_pic_banner_left}
    Set Test Variable   ${Check_pic_banner_left}   ${Get_pic_banner_left}

    ${Get_pic_banner_right}   Selenium2Library.Get Element Attribute   ${XPATH_CMS.get_attribute_banner_right}
    Log To Console   ${Get_pic_banner_right}
    Set Test Variable   ${Check_pic_banner_right}   ${Get_pic_banner_right}

    ${Get_Pic_Number}   Get matching xpath count   ${XPATH_CMS.cnt_pic_number}
    Log To Console   Picture Number = ${Get_Pic_Number}

    @{Get_Picture_Name_In_CMS_WeMall}=   Create List   ${EMPTY}

    # :FOR  ${index}  IN RANGE  1  ${Get_Pic_Number}+1
    # \  Log To Console   Picture Name No. ${index}

    # \  ${XPATH_Picture}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_pic_number}[${index}]/img@src
    # \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}

    # \  @{Split_String}   Split String   ${Get_Pic_Attribute}   /
    # \  ${Max_length}   Get Length   ${Split_String}
    # \  ${Last_Index}   Evaluate  ${Max_length}-1
    # # \  Log To Console   @{Split_String}[${Last_Index}] \n

    # \  ${Get_Pic_Data}   Set Variable   @{Split_String}[${Last_Index}]
    # \  Append To List  ${Get_Picture_Name_In_CMS_WeMall}   ${Get_Pic_Data}

    # \  ${Get_Picture_Name_From_List}=  Get From List   ${Get_Picture_Name_In_CMS_WeMall}   ${index}
    # \  Log To Console   ${Get_Picture_Name_From_List} \n

    :FOR  ${index}  IN RANGE  1  ${Get_Pic_Number}+1
    \  Log To Console   Picture Name No. ${index}

    \  ${XPATH_Picture}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_pic_number}[${index}]/img@src
    \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}

    \  ${Get_Pic_Data}   Set Variable   ${Get_Pic_Attribute}
    \  Append To List  ${Get_Picture_Name_In_CMS_WeMall}   ${Get_Pic_Data}

    \  ${Get_Picture_Name_From_List}=  Get From List   ${Get_Picture_Name_In_CMS_WeMall}   ${index}
    \  Log To Console   ${Get_Picture_Name_From_List} \n

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Picture_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}

Count Showroom Category Name In Manage Portal
    ${Get_Category_Number}   Get matching xpath count   ${XPATH_CMS.cnt_manage_portal_showroom_category}
    Log To Console   \n Category Number = ${Get_Category_Number}
    Set Test Variable   ${Check_Category_Number}   ${Get_Category_Number}

    @{Get_Category_Name_In_CMS_WeMall}=   Create List   ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Get_Category_Number}+1
    \  ${XPATH_CMS_Showroom_category_name}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_manage_portal_showroom_category}[${index}]/div[2]/span
    \  Log To Console   Category Name No. ${index}

    \  ${Get_Category_Data}   Get Text   ${XPATH_CMS_Showroom_category_name}
    \  Append To List  ${Get_Category_Name_In_CMS_WeMall}   ${Get_Category_Data}

    \  ${Get_Category_Name_From_List}=  Get From List   ${Get_Category_Name_In_CMS_WeMall}   ${index}
    \  Log To Console   ${Get_Category_Name_From_List} \n

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Category_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}
    # Log To Console   ${TEST_VAR}

# Get Showroom Picture Attribute
    # :FOR  ${index}  IN RANGE  1  ${Check_Showroom_Max_Picture}+1
    # \  ${XPATH_Picture}   Catenate  SEPARATOR=  //li[@class='mock-banner ng-scope'][${index}]/div/img@src
    # # \  Log To Console   XPATH = ${XPATH_Picture}
    # \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}
    # \  Log To Console   Get Attribute = ${Get_Pic_Attribute}
    # \  Append To List  ${Get_Showroom_Picture_Name_In_CMS_WeMall1}   ${Get_Pic_Attribute}

#     Click Element   ${XPATH_CMS.btn_back_to_manage_showroom}
#     Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_showroom_respond}

Verify Showroom Picture In Manage Portal
    @{Get_Showroom_Picture_Name_In_CMS_WeMall}=   Create List   ${EMPTY}

    ${Get_First_Showroom_Name}   Get Text   ${XPATH_CMS.txt_first_showroom}
    Log To Console   Verify Showroom Name = ${Get_First_Showroom_Name}
    Set Test Variable   ${Check_First_Showroom_Name}   ${Get_First_Showroom_Name}

    Wait Until Element Is Visible   ${XPATH_CMS.btn_showroom_manage_pic}
    Click Element   ${XPATH_CMS.btn_showroom_manage_pic}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_showroom_pic_respond}
    ${Get_Showroom_Max_Picture}   Get matching xpath Count   ${XPATH_CMS.cnt_max_showroom_pic}
    Log To Console   Max Picture = ${Get_Showroom_Max_Picture}

    :FOR  ${index}  IN RANGE  1  ${Get_Showroom_Max_Picture}+1
    \  ${XPATH_Picture}   Catenate  SEPARATOR=  //li[@class='mock-banner ng-scope'][${index}]/div/img@src
    \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}
    \  Log To Console   Get Attribute = ${Get_Pic_Attribute}
    \  Append To List  ${Get_Showroom_Picture_Name_In_CMS_WeMall}   ${Get_Pic_Attribute}

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Showroom_Picture_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}

#THIS CODE BELOW USE FOR GET ATTRIBUTE EVERY PICTURE IN CMS
    # @{Get_Showroom_Picture_Name_In_CMS_WeMall}=   Create List   ${EMPTY}
    # Set Test Variable   @{Get_Showroom_Picture_Name_In_CMS_WeMall1}   @{Get_Showroom_Picture_Name_In_CMS_WeMall}

    # Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_showroom_respond}

    # ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    # :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1
    # \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}
    # \  ${XPATH_Click_Manage_Category}   Catenate  SEPARATOR=  //li//div[span[contains(.,'${Get_Category_Name_From_List2}')]]/div/div/a[1]
    # \  Click Element   ${XPATH_Click_Manage_Category}
    # \  Wait Until Element Is Visible   ${XPATH_CMS.wait_showroom_pic_respond}
    # \  ${Get_Showroom_Max_Picture}   Get matching xpath Count   ${XPATH_CMS.cnt_max_showroom_pic}
    # \  Set Test Variable   ${Check_Showroom_Max_Picture}   ${Get_Showroom_Max_Picture}

    # \  Get Showroom Picture Attribute

Verify Showroom Manage Brand Picture In Manage Portal
    @{Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}=   Create List   ${EMPTY}

    ${Get_First_Showroom_Name}   Get Text   ${XPATH_CMS.txt_first_showroom}
    Log To Console   Verify Showroom Name = ${Get_First_Showroom_Name}
    Set Test Variable   ${Check_First_Showroom_Name}   ${Get_First_Showroom_Name}

    Wait Until Element Is Visible   ${XPATH_CMS.btn_showroom_manage_pic}
    Click Element   ${XPATH_CMS.btn_showroom_manage_pic}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_showroom_pic_respond}
    Click Element   ${XPATH_CMS.btn_manage_showroom_brand_pic}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_showroom_brand_respond}
    ${Get_Showroom_Brand_Pic_Number}   Get matching xpath Count   ${XPATH_CMS.cnt_showroom_brand_pic}
    Set Test Variable   ${Check_Showroom_Brand_Pic_Number}   ${Get_Showroom_Brand_Pic_Number}
    Log To Console   \n Showroom Brand Number = ${Get_Showroom_Brand_Pic_Number}

    :FOR  ${index}  IN RANGE  1  ${Get_Showroom_Brand_Pic_Number}+1
    \  ${XPATH_showroom_brand_attribute}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_showroom_brand_pic}[${index}]/div[2]/img@src
    \  ${Get_showroom_brand_attribute}   Selenium2Library.Get Element Attribute   ${XPATH_showroom_brand_attribute}

    # \  ${Get_showroom_brand_data}   Set Variable   ${Get_showroom_brand_attribute}
    \  Append To List  ${Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}   ${Get_showroom_brand_attribute}
    \  ${Get_showroom_brand_attribute_from_list}=  Get From List   ${Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}   ${index}

    \  Log To Console   \n Showroom Brand No. ${index}
    \  Log To Console   Get Attribute = ${Get_showroom_brand_attribute_from_list}

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}

Get CMS Mobile Preview Picture Attibute
    @{Get_preview_pic_attribute}=   Create List   ${EMPTY}

    ${Get_preview_pic_number}   Get matching xpath Count   ${XPATH_CMS.cnt_mobile_preview_pic}
    Set Test Variable   ${Check_preview_pic_number}   ${Get_preview_pic_number}
    :FOR  ${index}  IN RANGE  1  ${Get_preview_pic_number}+1
    \  ${XPATH_pic}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_mobile_preview_pic}[${index}]//img@src
    \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_pic}

    \  @{Split_String}   Split String   ${Get_Pic_Attribute}   /
    \  ${Max_length}   Get Length   ${Split_String}
    \  ${Last_Index}   Evaluate   ${Max_length}-1
    \  ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # \  Log To Console   Get Attribute = ${String}
    \  Append To List   ${Get_preview_pic_attribute}   ${String}
    \  ${Get_preview_pic_attribute_from_list}=   Get From List   ${Get_preview_pic_attribute}   ${index}
    # \  Log To Console   Mobile Preview Picture No.${pic_number} - ${index}
    \  Log To Console   Mobile Preview Picture Attribute [${index}] = ${Get_preview_pic_attribute_from_list}

    ${dict1}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict1}   package_name=${Get_preview_pic_attribute}
    Set Test Variable   ${Preview_attribute_data}   ${dict1}
    # Log To Console   ${Get_preview_attribute}

Get HighLights Picture Data In Manage Portal
    Click Element   //span[contains(.,'ความงามและสุขภาพ')]
    Wait Until Element Is Visible   ${XPATH_CMS.btn_highlights_banner_group_management}
    Click Element   ${XPATH_CMS.btn_highlights_banner_group_management}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_banner_group_management_respond}

    @{Get_Highlight_Picture_Attribute_In_CMS_WeMall}=   Create List   ${EMPTY}
    ${Get_pic_number}   Get matching xpath Count   ${XPATH_CMS.cnt_banner_group_pic}
    Set Test Variable   ${Check_pic_number}   ${Get_pic_number}

    :FOR  ${index}  IN RANGE  1  ${Get_pic_number}+1
    \  Set Test Variable   ${pic_number}   ${index}
    \  ${XPATH_banner_group}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_banner_group_pic}[${index}]
    \  Click Element   ${XPATH_banner_group}
    \  Wait Until Element Is Visible   ${XPATH_CMS.wait_preview_pic_respond}
    \  Log To Console   \n Picture No. ${index}

    \  Get CMS Mobile Preview Picture Attibute

    \  Append To List   ${Get_Highlight_Picture_Attribute_In_CMS_WeMall}   ${Preview_attribute_data}

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Highlight_Picture_Attribute_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}

Login CMS WeMall And Go To Manage Portal
    Open CMS WeMall
    Click Manage Portal

Login CMS WeMall To Verify Category Number In Manage Portal - Menu Bar
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal MenuBar
    Count MenuBar Category in Manage Portal

Login CMS WeMall To Verify Category Number In Manage Portal - Mega Menu
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal Mega Menu
    Count Mega Menu Category in Manage Portal

Login CMS WeMall To Verify Highlights Section In Main Page
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal Mega Menu
    Click Manage Portal Mega Menu Highlights
    Get HighLights Picture Data In Manage Portal

Login CMS WeMall To Verify Picture In Manage Portal - Merchantzone
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal Merchant Zone
    Count Merchant Zone Picture in Manage Portal

Login CMS WeMall To Verify Category Number In Manage Portal - Showroom
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal ShowRoom
    Count Showroom Category Name In Manage Portal

Login CMS WeMall To Verify Manage Picture In Manage Portal - Showroom
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal ShowRoom
    Verify Showroom Picture In Manage Portal

Login CMS WeMall To Verify Manage Brand Picture In Manage Portal - Showroom
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal ShowRoom
    Verify Showroom Manage Brand Picture In Manage Portal

Verify Highlights Section In Main Page

Verify Merchant Zone Section In Main Page

Verify Showroom Section In Main Page

Verify Footer In Main Page

#####################################################   PCMS   ###################################################################
Open PCMS iTruemart
    Open Browser   ${PCMS_WEB}
    Maximize Browser Window
    Wait Until Element Is Visible   ${XPATH_PCMS.input_email_login}
    Input Text   ${XPATH_PCMS.input_email_login}   admin@domain.com
    Input Text   ${XPATH_PCMS.input_password_login}   12345
    Click Element   ${XPATH_PCMS.btn_login}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_homepage_respond}

Click Collection
    Wait Until Element Is Visible   ${XPATH_PCMS.link_collection}
    Click Element   ${XPATH_PCMS.link_collection}
    Wait Until Element Is Visible   ${XPATH_PCMS.link_manage_collection}

Click Collection - Manage Collection
    Click Element   ${XPATH_PCMS.link_manage_collection}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_manage_collection_respond}

Back To Manage Collection
    Click Element   ${XPATH_PCMS.btn_goto_Collection_management}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_manage_collection_respond}

Get PDS Type Collection To Array
    Append To List  ${Check_PDS_Type_Collection_In_PCMS}   ${Check_Collection_Name}
    Log To Console   PDS Type Collection = ${Check_PDS_Type_Collection_In_PCMS}

    ${dict1}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict1}   package_name=${Check_PDS_Type_Collection_In_PCMS}
    Set Test Variable   ${PDS_Type_Collection}   ${dict1}

Get PDS Type Category To Array
    Append To List  ${Check_PDS_Type_Category_In_PCMS}   ${Check_Collection_Name}
    Log To Console   PDS Type Category = ${Check_PDS_Type_Category_In_PCMS}

    ${dict2}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict2}   package_name=${Check_PDS_Type_Category_In_PCMS}
    Set Test Variable   ${PDS_Type_Category}   ${dict2}

Publishes Status Is Incorrect
    ${text}=    Set Variable   it shoud be true
    Log To Console   System have something wrong with iTruemart Publishes
    Should Be Equal As Strings   ${Get_Publishes_iTruemart_status}   ${text}

Verify Category Level 1
    Click Collection
    Click Collection - Manage Collection

    ${Get_iTruemart_collection_number}   Get matching xpath Count   ${XPATH_PCMS.get_iTruemart_collection_number}
    Log To Console   \n iTruemart Collection = ${Get_iTruemart_collection_number}

    @{Get_PDS_Type_Collection_In_PCMS}=   Create List   ${EMPTY}
    @{Get_PDS_Type_Category_In_PCMS}=   Create List   ${EMPTY}
    Set Test Variable   ${Check_PDS_Type_Collection_In_PCMS}   ${Get_PDS_Type_Collection_In_PCMS}
    Set Test Variable   ${Check_PDS_Type_Category_In_PCMS}   ${Get_PDS_Type_Category_In_PCMS}

    :FOR   ${index}   IN RANGE   1   ${Get_iTruemart_collection_number}+1
    \  Wait Until Element Is Visible   ${XPATH_PCMS.get_iTruemart_collection_number}[${index}]/td[4]/a[2]
    \  Click Element   ${XPATH_PCMS.get_iTruemart_collection_number}[${index}]/td[4]/a[2]
    \  Wait Until Element Is Visible   ${XPATH_PCMS.txt_name}
    \  ${Get_Collection_Name}   Get Value   ${XPATH_PCMS.txt_name}

    \  Log To Console   \n iTruemart Collection No.${index}
    \  Log To Console   Name = ${Get_Collection_Name}
    \  Set Test Variable   ${Check_Collection_Name}   ${Get_Collection_Name}

    \  ${Get_display_status}=    Run Keyword And Return Status    Element Should Be Visible    jquery=input[name='is_category'][checked='checked']
    \  Log To Console   Display Value = ${Get_display_status}
    \  Run Keyword If  '${Get_display_status}' == 'False'    Back To Manage Collection
    \  Continue For Loop If  '${Get_display_status}' == 'False'

    \  ${Status_Collection}=    Set Variable   ${EMPTY}
    \  ${Status_Category}=    Set Variable   ${EMPTY}
    \  ${Status_Collection}=    Run Keyword And Return Status    Element Should Be Visible    jquery=input[checked='checked'][value='1'][type='radio']
    \  ${Status_Category}=     Run Keyword And Return Status    Element Should Be Visible    jquery=input[checked='checked'][value='2'][type='radio']
    \
    \  Log To Console    PDS Type Collection Status = ${Status_Collection}
    \  Log To Console    PDS Type Category Status = ${Status_Category}

    \  ${Get_Publishes_iTruemart_status}   Run Keyword And Return Status   Element Should Be Visible   jquery=input[name='app[1]'][value='1'][type='checkbox'][checked='checked']
    \  Log To Console   Publishes for iTruemart = ${Get_Publishes_iTruemart_status}
    \  Run Keyword If  '${Get_Publishes_iTruemart_status}' == 'False'    Publishes Status Is Incorrect

    \  Run Keyword If  '${Status_Collection}' == 'True'    Get PDS Type Collection To Array
    \  Run Keyword If  '${Status_Category}' == 'True'    Get PDS Type Category To Array

    \  Click Element   ${XPATH_PCMS.btn_goto_Collection_management}
    \  Wait Until Element Is Visible   ${XPATH_PCMS.wait_manage_collection_respond}

Click Promotion
    Wait Until Element Is Visible   ${XPATH_PCMS.link_promotion}
    Click Element   ${XPATH_PCMS.link_promotion}
    Wait Until Element Is Visible   ${XPATH_PCMS.link_discount_campiagn}

Click Promotion - Discount Campaign
    Click Element   ${XPATH_PCMS.link_discount_campiagn}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_discount_campiagn_respond}

Select Promotion - Discount Campaign
    Wait Until Element Is Visible   ${XPATH_PCMS.btn_select_discount_campiagn}
    Click Element   ${XPATH_PCMS.btn_select_discount_campiagn}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_discount_campaign_product_respond}

Get Product Name In PCMS iTrueMart - Discount Campaign
    @{Get_Product_Name_In_PCMS}=   Create List   ${EMPTY}
    ${Count_pcms_wow_product_number}   Get matching xpath Count   ${XPATH_PCMS.cnt_pcms_wow_product}
    Set Test Variable   ${Check_pcms_wow_product_number}   ${Count_pcms_wow_product_number}
    Log To Console   PCMS Everyday Wow Product = ${Count_pcms_wow_product_number}

    :FOR  ${index}  IN RANGE  1  ${Count_pcms_wow_product_number}+1
    \  ${XPATH_pcms_wow_name}   Catenate  SEPARATOR=   ${XPATH_PCMS.cnt_pcms_wow_product}[${index}]/td/h4
    \  ${Get_wow_product_name}   Get Text   ${XPATH_pcms_wow_name}

    \  Append To List  ${Get_Product_Name_In_PCMS}   ${Get_wow_product_name}
    \  ${Get_Product_Name_In_PCMS2}=  Get From List   ${Get_Product_Name_In_PCMS}   ${index}
    \  Log To Console   PCMS Product No.${index}
    \  Log To Console   PCMS Product Name =${Get_Product_Name_In_PCMS2} \n

    ${dict1}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict1}   package_name=${Get_Product_Name_In_PCMS}
    Set Test Variable   ${Get_PCMS_Product_Name}   ${dict1}
    # Log To Console   ${Get_PCMS_Product_Name}

# Get Product Picture Attribute In PCMS iTrueMart - Discount Campaign
#     @{Get_Product_Picture_Attribute_In_PCMS}=   Create List   ${EMPTY}

#     :FOR  ${index}  IN RANGE  1  ${Check_pcms_wow_product_number}+1
#     \  ${XPATH_pcms_wow_pic}   Catenate  SEPARATOR=   ${XPATH_PCMS.cnt_pcms_wow_product}[${index}]/td/img@src
#     \  ${Get_wow_pic_attribute}   Selenium2Library.Get Element Attribute   ${XPATH_pcms_wow_pic}

    # \  @{Split_String}   Split String   ${Get_wow_pic_attribute}   /
    # \  ${Max_length}   Get Length   ${Split_String}
    # \  ${Last_Index}   Evaluate   ${Max_length}-1
    # \  ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # # \  Log To Console   Get Attribute = ${String}
    # \  @{Split_String1}   Split String   ${String}   _
    # \  ${Max_lenght1}   Get Length   ${Split_String1}
    # \  ${String1}=   Set Variable   @{Split_String1}[0]
#     # \  Log To Console   Everyday Wow Attribute = ${String1}

#     \  Append To List  ${Get_Product_Picture_Attribute_In_PCMS}   ${String1}
#     \  ${Get_Product_Picture_Attribute_In_PCMS2}=  Get From List   ${Get_Product_Picture_Attribute_In_PCMS}   ${index}
#     \  Log To Console   PCMS Product No.${index}
#     \  Log To Console   PCMS Product Picture Attribute =${Get_Product_Picture_Attribute_In_PCMS2} \n

#     ${dict2}=   Create Dictionary   test=TestData
#     Set To Dictionary   ${dict2}   package_name=${Get_Product_Picture_Attribute_In_PCMS}
#     Set Test Variable   ${Get_PCMS_Product_Pic_Attribute}   ${dict2}
#     # Log To Console   ${PCMS_Product_Pic_Attribute}

Login PCMS To Verify Promotion - Discount Promotion Product
    Open PCMS iTruemart
    Click Promotion
    Click Promotion - Discount Campaign
    Select Promotion - Discount Campaign
    Get Product Name In PCMS iTrueMart - Discount Campaign
    # Get Product Picture Attribute In PCMS iTrueMart - Discount Campaign

#####################################################   WeMall Mobile SIte   #####################################################
Login WeMall And Go To Portal
    Open Browser   ${XPATH_iTrueMart.login_default}   chrome
    Set Window Position   ${0}      ${0}
    Maximize Browser Window
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element   ${XPATH_iTrueMart.btn_submit_login}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.txt_id}
    Go To   ${WEMALL_WEB}/portal/${mainPage}
    Add Cookie      is_mobile  true
    Reload Page

Go To Promotion Page
    # Click Element   ${XPATH_WeMall.btn_Promotion_page}
    Go To   ${WEMALL_WEB}/portal/page2
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_Promotion_page_respond}

Verify WeMall icon Button In WeMall Mobile Site
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_wemall_icon}
    Click Element   ${XPATH_WeMall.btn_wemall_icon}
    Location Should Be   ${Check_URL.home}
    Log To Console   \n  WeMall Icon button is Active

Verify Shop Cart Button In WeMall Mobile Site
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_cart_main_page}
    Click Element   ${XPATH_WeMall.btn_cart_main_page}
    Wait Until Element Is Visible   ${Check_URL.wait_cart_respond}
    Location Should Be   ${Check_URL.cart}
    Log To Console   \n  Shop Cart button is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}
    Log To Console   Login Success

Verify Footer Change View Button In WeMall Mobile Site
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_footer_change_view}
    Click Element   ${XPATH_WeMall.btn_footer_change_view}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_footer_change_view_respond}
    Log To Console   \n  Footer Change View button is Active

Check Everyday Wow Name Is Exist
    ${Get_PCMS_Product_Name_From_List}   Get From Dictionary   ${Get_PCMS_Product_Name}   package_name
    :FOR  ${index}  IN RANGE  1  ${Check_pcms_wow_product_number}+1
    \  ${Get_PCMS_Product_Name_From_List1}=  Get From List   ${Get_PCMS_Product_Name_From_List}   ${index}

    \  Set Test Variable   ${Current_Wow_Name}   ${Get_PCMS_Product_Name_From_List1}

    \  Log To Console   Get Current Everyday Wow Name In ARRAY[${index}] = ${Current_Wow_Name}

    \  Run Keyword If  '${Check_wow_product_name}' == '${Current_Wow_Name}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_pcms_wow_product_number}'   Log To Console   Everyday Wow Name = ${Check_wow_product_name} Is Not Exist In PCMS

Check Everyday Wow Attribute Is Exist
    ${Get_PCMS_Product_Attribute_From_List}   Get From Dictionary   ${Get_PCMS_Product_Pic_Attribute}   package_name
    :FOR  ${index}  IN RANGE  1  ${Check_pcms_wow_product_number}+1
    \  ${Get_PCMS_Product_Attribute_From_List1}=  Get From List   ${Get_PCMS_Product_Attribute_From_List}   ${index}

    \  Set Test Variable   ${Current_Wow_Attribute}   ${Get_PCMS_Product_Attribute_From_List1}

    \  Log To Console   Get Current Everyday Wow Attribute In ARRAY[${index}] = ${Current_Wow_Attribute}

    \  Run Keyword If  '${Check_wow_product_attribute}' == '${Current_Wow_Attribute}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_pcms_wow_product_number}'   Log To Console   Everyday Wow Attribute = ${Check_wow_product_name} Is Not Exist In PCMS

Check Everyday Wow PKey Is Exist
    :FOR  ${index}  IN RANGE  1  ${Check_length_Pkey}+1

    \  ${pkey_index}   Evaluate   ${index}-1

    \  Set Test Variable   ${Current_Pkey}   @{promotion_discount_wow_pkey}[${pkey_index}]

    \  Log To Console   Get Current Everyday Wow PKey In ARRAY[${index}] = ${Current_Pkey}

    \  Run Keyword If  '${Check_wow_Pkey}' == '${Current_Pkey}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_length_Pkey}'   Log To Console   Everyday Wow Attribute = ${Check_wow_Pkey} Is Not Exist In ARRAY

Compare Everyday Wow In Wemall Mobile SIte with PCMS
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_wow_respond}

    ${Get_Wow_pic_number}   Get matching xpath Count   ${XPATH_WeMall.cnt_wow_product}
    Log To Console   \n Everyday Wow Product = ${Get_Wow_pic_number}

    ${Max_length_Pkey}   Get Length   ${promotion_discount_wow_pkey}
    Set Test Variable   ${Check_length_Pkey}   ${Max_length_Pkey}
    Log To Console   Max Length Pkey = ${Check_length_Pkey}

    #FOR LOOP of Everyday Wow Name
    :FOR  ${index}  IN RANGE  1  ${Get_Wow_pic_number}+1
    \  ${XPATH_wow_product}   Catenate  SEPARATOR=   ${XPATH_WeMall.cnt_wow_product}[${index}]//h5
    \  ${Get_wow_product_name}   Get Text   ${XPATH_wow_product}
    \  Set Test Variable   ${Check_wow_product_name}   ${Get_wow_product_name}
    \  Log To Console   \n Get Product Name No.${index}
    \  Log To Console   Portal Product Name = ${Get_wow_product_name}
    \  Check Everyday Wow Name Is Exist
    \  Log To Console   PCMS Found Everyday Wow Name = ${Current_Wow_Name}
    \  Should Be Equal As Strings   ${Get_wow_product_name}   ${Current_Wow_Name}
    \  Log To Console   Portal Everyday Wow Name No.${index} Is Retrieve Data From PCMS Correct \n

    # # #FOR LOOP of Everyday Wow Attribute
    # \  ${XPATH_wow_product}   Catenate  SEPARATOR=   ${XPATH_WeMall.cnt_wow_product}[${index}]//img@src
    # \  ${Get_wow_product_attribute}   Selenium2Library.Get Element Attribute   ${XPATH_wow_product}

    # \  @{Split_String}   Split String   ${Get_wow_product_attribute}   /
    # \  ${Max_length}   Get Length   ${Split_String}
    # \  ${Last_Index}   Evaluate   ${Max_length}-1
    # \  ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # # \  Log To Console   Get Attribute = ${String}
    # \  @{Split_String1}   Split String   ${String}   _
    # \  ${Max_lenght1}   Get Length   ${Split_String1}
    # \  ${String1}=   Set Variable   @{Split_String1}[0]
    # # \  Log To Console   Everyday Wow Attribute = ${String1}

    # \  Set Test Variable   ${Check_wow_product_attribute}   ${String1}
    # \  Log To Console   Get Product Attribute No.${index}
    # \  Log To Console   Portal Product Attribute = ${String1}
    # \  Check Everyday Wow Attribute Is Exist
    # \  Log To Console   PCMS Found Everyday Wow Attribute = ${Current_Wow_Attribute}
    # \  Should Be Equal As Strings   ${String1}   ${Current_Wow_Attribute}
    # \  Log To Console   Portal Everyday Wow Attribute No.${index} Is Retrieve Data From PCMS Correct \n

    #FOR LOOP of Pkey
    \  ${XPATH_wow_product}   Catenate  SEPARATOR=   ${XPATH_WeMall.cnt_wow_product}[${index}]/div/a@href
    \  ${Get_wow_Element}   Selenium2Library.Get Element Attribute   ${XPATH_wow_product}

    \  @{Split_String2}   Split String   ${Get_wow_Element}   -
    \  ${Max_length}   Get Length   ${Split_String2}
    \  ${Last_Index}   Evaluate   ${Max_length}-1
    \  ${String2}=   Set Variable   @{Split_String2}[${Last_Index}]
    # \  Log To Console   Get Attribute = ${String}
    \  @{Split_String3}   Split String   ${String2}   .
    \  ${Max_lenght2}   Get Length   ${Split_String3}
    \  ${String4}=   Set Variable   @{Split_String3}[0]
    # \  Log To Console   Everyday Wow Pkey = ${String4}
    \  Set Test Variable   ${Check_wow_Pkey}   ${String4}
    \  Log To Console   Get Product PKey No.${index}
    \  Log To Console   Portal Product PKey = ${String4}
    \  Check Everyday Wow PKey Is Exist
    \  Should Be Equal As Strings   ${Current_Pkey}   ${Check_wow_Pkey}
    \  Log To Console   Everyday Wow PKey No.${index} Is Retrieve Data Correct
    \  Log TO Console   ========================================================================================================\n

Click Main Menu In WeMall Mobile Sites
    Sleep   2s
    Wait Until Element Is Visible    ${XPATH_WeMall.btn_main_menu}
    Click Element   ${XPATH_WeMall.btn_main_menu}

Not Found Item In Cart
    Log To Console   Item in cart = ${Check_item_number}
    Log To Console   Not Found Item In Cart
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}
    Click Element   ${XPATH_iTrueMart.icon_cart}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}
    Log To Console   Login Success

Verify Login link
    Wait Until Element Is Visible   ${Mega_Menu.login}
    Click Element   ${Mega_Menu.login}
    # Wait Until Element Is Visible   ${Check_URL.wait_login_respond}
    Location Should Be   ${Check_URL.login}
    Log To Console   \n Login link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element   ${XPATH_iTrueMart.btn_submit_login}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}

    ${Get_item_number}   Get matching xpath count   ${XPATH_iTrueMart.icon_item_number_in_cart}
    Set Test Variable   ${Check_item_number}   ${Get_item_number}

    Run Keyword If   '${Get_item_number}' > '0'   Log To Console   Item in cart = ${Get_item_number} \n Login Success

    Run Keyword If   '${Get_item_number}' == '0'   Not Found Item In Cart

Verify Home link
    Wait Until Element Is Visible   ${Mega_Menu.home}
    Click Element   ${Mega_Menu.home}
    # Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}
    Location Should Be   ${Check_URL.home}
    Log To Console   \n Home link is Active

Verify Everyday Wow link
    Wait Until Element Is Visible   ${Mega_Menu.wow}
    Click Element   ${Mega_Menu.wow}
    # Wait Until Element Is Visible   ${Check_URL.wait_wow_respond}
    Location Should Be   ${Check_URL.wow}
    Log To Console   \n Wow link is Active

Verify Category Main Link
    Wait Until Element Is Visible   ${Mega_Menu.category}
    Click Element   ${Mega_Menu.category}
    Wait Until Element Is Visible   ${Mega_Menu.wait_category_respond}
    Log To Console   \n Category Main link is Active

Check Mega Menu Category Name Is Exist
    ${Max_length}   Get Length   ${Check_Category_Name_From_Dic}

    :FOR  ${index}  IN RANGE  1  ${Max_length}+1
    \  ${Get_Category_Name_From_List}=  Get From List   ${Check_Category_Name_From_Dic}   ${index}

    \  Set Test Variable   ${Current_Category_Name}   ${Get_Category_Name_From_List}

    \  Log To Console   Get Current Category Name In ARRAY = ${Current_Category_Name}

    \  Run Keyword If  '${Check_Category_Name}' == '${Get_Category_Name_From_List}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Max_length}'   Log To Console   Category Name Is Not Exist In PCMS

Compare Mega Menu Category In WeMall Mobile Site with PCMS
    Click Main Menu In WeMall Mobile Sites
    Wait Until Element Is Visible   ${Mega_Menu.category}
    Sleep   1s
    Click Element   ${Mega_Menu.category}
    Wait Until Element Is Visible   ${Mega_Menu.wait_category_respond}

    ${Get_Category_number}   Get Matching xpath count   ${Mega_Menu.cnt_category_number}
    Log To Console   \n Category Number = ${Get_Category_number}

    ${Get_Category_Name_From_Dic}   Get From Dictionary   ${PDS_Type_Category}   package_name
    Set Test Variable   ${Check_Category_Name_From_Dic}   ${Get_Category_Name_From_Dic}

    :FOR   ${index}   IN RANGE   1   ${Get_Category_number}+1
    \  ${XPATH_Category}   Catenate  SEPARATOR   ${Mega_Menu.cnt_category_number}//span
    \  ${Category_Name}   Get Text   ${XPATH_Category}
    \  Log To Console   \n Mega Menu Category No.${index}
    \  Log To Console   Mega Menu Category Name = ${Category_Name}
    \  Set Test Variable   ${Check_Category_Name}   ${Category_Name}

    \  Check Mega Menu Category Name Is Exist

    \  Log To Console   Category Name = ${Current_Category_Name} Is Found

    \  Should Be Equal As Strings   ${Current_Category_Name}   ${Category_Name}
    \  Log To Console   Mega Menu Category Name No.${index} Is Retrieve Data Correct \n

Verify Promotion Main Link
    Wait Until Element Is Visible   ${Mega_Menu.promotion}
    Click Element   ${Mega_Menu.promotion}
    Wait Until Element Is Visible   ${Mega_Menu.wait_promotion_respond}
    Log To Console   \n Promotion Main link is Active

Check Mega Menu Promotion Name Is Exist
    ${Max_length}   Get Length   ${Check_Promotion_Name_From_Dic}

    :FOR  ${index}  IN RANGE  1  ${Max_length}+1
    \  ${Get_Promotion_Name_From_List}=  Get From List   ${Check_Promotion_Name_From_Dic}   ${index}

    \  Set Test Variable   ${Current_Promotion_Name}   ${Get_Promotion_Name_From_List}

    \  Log To Console   Get Current Category Name In ARRAY = ${Current_Promotion_Name}

    \  Run Keyword If  '${Check_Promotion_Name}' == '${Get_Promotion_Name_From_List}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Max_length}'   Log To Console   Promotion Name Is Not Exist In PCMS

Compare Mega Menu Promotion In WeMall Mobile Site with PCMS
    Click Main Menu In WeMall Mobile Sites
    Wait Until Element Is Visible   ${Mega_Menu.promotion}
    Sleep   1s
    Click Element   ${Mega_Menu.promotion}
    Wait Until Element Is Visible   ${Mega_Menu.wait_promotion_respond}

    ${Get_Promotion_number}   Get Matching xpath count   ${Mega_Menu.cnt_promotion_number}
    Log To Console   \n Promotion Number = ${Get_Promotion_number}

    ${Get_Promotion_Name_From_Dic}   Get From Dictionary   ${PDS_Type_Collection}   package_name
    Set Test Variable   ${Check_Promotion_Name_From_Dic}   ${Get_Promotion_Name_From_Dic}

    :FOR   ${index}   IN RANGE   1   ${Get_Promotion_number}+1
    \  ${XPATH_Promotion}   Catenate  SEPARATOR   ${Mega_Menu.cnt_promotion_number}//span
    \  ${Promotion_Name}   Get Text   ${XPATH_Promotion}
    \  Log To Console   \n Mega Menu Promotion No.${index}
    \  Log To Console   Mega Menu Promotion Name = ${Promotion_Name}
    \  Set Test Variable   ${Check_Promotion_Name}   ${Promotion_Name}

    \  Check Mega Menu Promotion Name Is Exist

    \  Log To Console   Category Name = ${Current_Promotion_Name} Is Found

    \  Should Be Equal As Strings   ${Current_Promotion_Name}   ${Promotion_Name}
    \  Log To Console   Mega Menu Promotion Name No.${index} Is Retrieve Data Correct \n

Verify Itruemart link
    Wait Until Element Is Visible   ${Mega_Menu.itruemart}
    Click Element   ${Mega_Menu.itruemart}
    # Wait Until Element Is Visible   ${Check_URL.wait_itruemart_respond}
    Location Should Be   ${Check_URL.itruemart}
    Log To Console   \n Itruemart link is Active

Verify Cart link
    Wait Until Element Is Visible   ${Mega_Menu.cart}
    Click Element   ${Mega_Menu.cart}
    # Wait Until Element Is Visible   ${Check_URL.wait_cart_respond}
    Location Should Be   ${Check_URL.cart}
    Log To Console   \n Cart link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}
    Log To Console   Login Success

Verify Order Tracking link
    Wait Until Element Is Visible   ${Mega_Menu.order_tracking}
    Click Element   ${Mega_Menu.order_tracking}
    Location Should Be   ${Check_URL.order_tracking}
    Log To Console   \n Order Tracking link is Active

Verify Return Policy link
    Wait Until Element Is Visible   ${Mega_Menu.return_policty}
    Click Element   ${Mega_Menu.return_policty}
    # Wait Until Element Is Visible   ${Check_URL.wait_return_policty_respond}
    Location Should Be   ${Check_URL.return_policty}
    Log To Console   \n Return Policy link is Active

Verify Shipment Policy link
    Wait Until Element Is Visible   ${Mega_Menu.shipment_policy}
    Click Element   ${Mega_Menu.shipment_policy}
    # Wait Until Element Is Visible   ${Check_URL.wait_shipment_policy_respond}
    Location Should Be   ${Check_URL.shipment_policy}
    Log To Console   \n Shipment Policy link is Active

Verify Refund Policy link
    Wait Until Element Is Visible   ${Mega_Menu.refund_policy}
    Click Element   ${Mega_Menu.refund_policy}
    # Wait Until Element Is Visible   ${Check_URL.wait_refund_policy_respond}
    Location Should Be   ${Check_URL.refund_policy}
    Log To Console   \n Refund Policy link is Active

Verify Discount Code link
    Wait Until Element Is Visible   ${Mega_Menu.discount_code}
    Click Element   ${Mega_Menu.discount_code}
    # Wait Until Element Is Visible   ${Check_URL.wait_discount_code_respond}
    Location Should Be   ${Check_URL.discount_code}
    Log To Console   \n Discount Code link is Active

Verify Contact Us link
    Wait Until Element Is Visible   ${Mega_Menu.contact_us}
    Click Element   ${Mega_Menu.contact_us}
    # Wait Until Element Is Visible   ${Check_URL.wait_contact_us_respond}
    Location Should Be   ${Check_URL.contact_us}
    Log To Console   \n Contact Us link is Active

Verify Thai language
    Wait Until Element Is Visible   ${Mega_Menu.ENG_language}
    Log To Console   Ready To Click ENG language
    Click Element   ${Mega_Menu.ENG_language}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}

    Click Main Menu In WeMall Mobile Sites
    Wait Until Element Is Visible   ${Mega_Menu.TH_language}
    Click Element   ${Mega_Menu.TH_language}
    Log To Console   Ready To Click ENG language
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}
    Location Should Be   ${Check_URL.th_language}
    Log To Console   \n TH language link is Active

Verify English language
    Wait Until Element Is Visible   ${Mega_Menu.ENG_language}
    # Sleep   2s
    Log To Console   Ready To Click ENG language
    Click Element   ${Mega_Menu.ENG_language}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}
    Location Should Be   ${Check_URL.en_language}
    Log To Console   \n EN language link is Active

Verify View More Button In WeMall Mobile Site
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_view_more}
    Sleep   1s
    Click Element   ${XPATH_WeMall.btn_view_more}
    Wait Until Element Is Visible   ${Check_URL.wait_view_more_respond}
    Location Should Be   ${Check_URL.view_more}
    Log To Console   \n View More button link is Active

Compare Menubar In WeMall Mobile Site with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //ul[@class='list-menu']/li[${index}+2]/a
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall MenuBar Category No.${index}
    \  Log To Console   WeMall MenuBar Category Name = ${Get_WeMall_Category_Name}

    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}
    \  Log To Console   CMS MenuBar Category No.${index}
    \  Log To Console   CMS MenuBar Category Name = ${Get_Category_Name_From_List2}

    \  Should Be Equal As Strings   ${Get_Category_Name_From_List2}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall MenuBar Category Name No.${index} Is Retrieve Data Correct \n

Compare Menubar In WeMall Mobile Site Is Infinite Skirt
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    Set Test Variable   ${Check_Infinite_Skirt}   ${Check_Category_Number}

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //ul[@class='list-menu']/li[${index}+${Check_Infinite_Skirt}+4]/a
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall MenuBar Infinite Skirt No.${index}
    \  Log To Console   WeMall MenuBar Infinite Skirt Name = ${Get_WeMall_Category_Name}

    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}
    \  Log To Console   CMS MenuBar Infinite Skirt No.${index}
    \  Log To Console   CMS MenuBar Infinite Skirt Name = ${Get_Category_Name_From_List2}

    \  Should Be Equal As Strings   ${Get_Category_Name_From_List2}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall MenuBar Infinite Skirt Name No.${index} Is Retrieve Data Correct \n

Compare Mega Menu In WeMall Mobile Site - Promotion Page with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}

    # Click Element   ${XPATH_WeMall.btn_Promotion_page}
    Go To   ${WEMALL_WEB}/portal/page2

    Wait Until Element Is Visible   ${XPATH_WeMall.wait_Promotion_page_respond}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //div[${index}]/h3
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall Promotion Category No.${index}
    \  Log To Console   WeMall Promotion Category Name = ${Get_WeMall_Category_Name}

    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}
    \  Log To Console   CMS Promotion Category No.${index}
    \  Log To Console   CMS Promotion Category Name = ${Get_Category_Name_From_List2}

    \  Should Be Equal As Strings   ${Get_Category_Name_From_List2}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall Promotion Category Name No.${index} Is Retrieve Data Correct \n

Check Preview Picture Is1
    ${XPATH_Pic1}   Catenate  SEPARATOR=   //div[@class='lb-section-content']//div[@class='owl-item active']//img@src
    ${verify_attribute_pic1}   Selenium2Library.Get Element Attribute   ${XPATH_Pic1}

    @{Split_String}   Split String   ${verify_attribute_pic1}   /
    ${Max_length}   Get Length   ${Split_String}
    ${Last_Index}   Evaluate   ${Max_length}-1
    ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # Log To Console   String =${String}
    Set Test Variable   ${Get_Attribute_pic}   ${String}
    # Log To Console   Check Preview Picture Is1

Check Preview Picture Is2
    ${XPATH_Pic2}   Catenate  SEPARATOR=   //div[@class='lb-section-content']//div[@class='items-container']/div[1]//img@src
    ${verify_attribute_pic2}   Selenium2Library.Get Element Attribute   ${XPATH_Pic2}

    @{Split_String}   Split String   ${verify_attribute_pic2}   /
    ${Max_length}   Get Length   ${Split_String}
    ${Last_Index}   Evaluate   ${Max_length}-1
    ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # Log To Console   String =${String}
    Set Test Variable   ${Get_Attribute_pic}   ${String}
    # Log To Console   Check Preview Picture Is2

Check Preview Picture Is3
    ${XPATH_Pic3}   Catenate  SEPARATOR=   //div[@class='lb-section-content']//div[@class='items-container']/div[2]//img@src
    ${verify_attribute_pic3}   Selenium2Library.Get Element Attribute   ${XPATH_Pic3}

    @{Split_String}   Split String   ${verify_attribute_pic3}   /
    ${Max_length}   Get Length   ${Split_String}
    ${Last_Index}   Evaluate   ${Max_length}-1
    ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # Log To Console   String =${String}
    Set Test Variable   ${Get_Attribute_pic}   ${String}
    # Log To Console   Check Preview Picture Is3

Verify Preview Picture Data In WeMall Mobile Site with CMS
    @{Get_Preview_Attribute_Pic}=   Create List   ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Check_preview_pic_number}+1

    \  Run Keyword If   '${index}' == '1'   Check Preview Picture Is1

    \  Run Keyword If   '${index}' == '2'   Check Preview Picture Is2

    \  Run Keyword If   '${index}' == '3'   Check Preview Picture Is3

    \  Append To List  ${Get_Preview_Attribute_Pic}   ${Get_Attribute_pic}

    \  Set Test Variable   ${Check_Preview_Attribute_Pic}   ${Get_Preview_Attribute_Pic}
    \  Log To Console   Get Current Attribute No.[${index}] = ${Get_Attribute_pic}

Get Preview Picture Sub Array
    :FOR  ${index}  IN RANGE  1  ${Check_preview_pic_number}+1
    \  ${Get_sub_list_from_dic}   Get From Dictionary   ${Check_Preview_Attribute_From_List}   package_name
    \  ${Get_sub_list_from_list}=   Get From List   ${Get_sub_list_from_dic}   ${index}
    \  ${Get_Portal_highlight_attribute}=   Get From List   ${Check_Preview_Attribute_Pic}   ${index}
    \  Log To Console   Compare Attribute Portal No.[${index}] = ${Get_sub_list_from_list}
    \  Log To Console   Compare Attribute CMS No.[${index}] = ${Get_Portal_highlight_attribute}
    \  Should Be Equal As Strings   ${Get_sub_list_from_list}   ${Get_Portal_highlight_attribute}
    \  Log To Console   Picture Attribute No.${index} Is Correct As CMS \n

Compare Highlights Picture In WeMall Mobile Site with CMS
    ${Get_Preview_Attribute_From_Dic}   Get From Dictionary   ${TEST_VAR}   package_name

    Wait Until Element Is Visible   ${XPATH_WeMall.pic_highlight}

    :FOR  ${index}  IN RANGE  1  ${Check_pic_number}+1
    \  ${XPATH_btn_change_highlight_pic}   Catenate  SEPARATOR=   ${XPATH_WeMall.btn_change_highlight_pic}[${index}]
    \  Click Element   ${XPATH_btn_change_highlight_pic}

    \  Log To Console   \n Verify Highlight Picture No.${index}
    \  Verify Preview Picture Data In WeMall Mobile Site with CMS

    \  ${Get_Preview_Attribute_From_List}=  Get From List   ${Get_Preview_Attribute_From_Dic}   ${index}
    \  Set Test Variable   ${Check_Preview_Attribute_From_List}   ${Get_Preview_Attribute_From_List}
    \  Get Preview Picture Sub Array

    \  Log To Console   Banner Group Picture No. ${index} Is Retrieve Data Correct
    \  Log To Console  =========================================================================================================\n

Compare MerchantZone In WeMall Mobile Site with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_Merchantzone_respond}
    # ${Get_Merchantzone_Name}   Get Text   ${XPATH_WeMall.Merchantzone_name}
    # Log To Console   Merchant Zone Name In CMS = ${Check_Merchantzone_category_name}
    # Log To Console   Merchant Zone Name In Wemall = ${Get_Merchantzone_Name}
    # Should Be Equal As Strings   ${Get_Merchantzone_Name}   ${Check_Merchantzone_category_name}
    # Log To Console   Merchant Zone Category Name Is Retrieve Data Correct \n

    ${XPATH_banner_right}   Catenate  SEPARATOR=   ${XPATH_WeMall.get_attribute_banner_right}@src
    ${Get_pic_banner_right}   Selenium2Library.Get Element Attribute   ${XPATH_banner_right}
    Log To Console   WeMall Right Banner Attribute = ${Get_pic_banner_right}
    Log To Console   CMS Right Banner Attribute = ${Check_pic_banner_right}
    Should Be Equal As Strings   ${Get_pic_banner_right}   ${Check_pic_banner_right}
    Log To Console   Right Banner Picture Is Retrieve Data Correct \n

    ${Get_Merchant_Brand_Attribute_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR   ${index}   IN RANGE   1   10+1
    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  ${XPATH_Wemall.Merchant_brand}[${index}]//img@src
    \  ${Get_WeMall_Merchant_Brand_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall Merchant Brand No.${index}
    \  Log To Console   WeMall Merchant Brand Attribute = ${Get_WeMall_Merchant_Brand_Attribute}

    \  ${Get_Merchant_Brand_Attribute_From_List1}=  Get From List   ${Get_Merchant_Brand_Attribute_From_List}   ${index}
    \  Log To Console   CMS MerchantZone Attribute No.${index}
    \  Log To Console   CMS MerchantZone Attribute = ${Get_Merchant_Brand_Attribute_From_List1}

    \  Should Be Equal As Strings   ${Get_Merchant_Brand_Attribute_From_List1}   ${Get_WeMall_Merchant_Brand_Attribute}
    \  Log To Console   WeMall MerchantZone Attribute No.${index} Is Retrieve Data Correct \n

    Wait Until Element Is Visible   ${XPATH_WeMall.btn_change_Merchantzone_banner}
    Click Element   ${XPATH_WeMall.btn_change_Merchantzone_banner}

    ${XPATH_banner_left}   Catenate  SEPARATOR=   ${XPATH_WeMall.get_attribute_banner_left}@src
    ${Get_pic_banner_left}   Selenium2Library.Get Element Attribute   ${XPATH_banner_left}
    Log To Console   WeMall Left Banner Attribute = ${Get_pic_banner_left}
    Log To Console   CMS Left Banner Attribute = ${Check_pic_banner_left}
    Should Be Equal As Strings   ${Get_pic_banner_left}   ${Check_pic_banner_left}
    Log To Console   Left Banner Picture Is Retrieve Data Correct

    :FOR   ${index}   IN RANGE   11   20+1
    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  ${XPATH_Wemall.Merchant_brand}[${index}-10]//img@src
    \  ${Get_WeMall_Merchant_Brand_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall Merchant Brand No.${index}
    \  Log To Console   WeMall Merchant Brand Attribute = ${Get_WeMall_Merchant_Brand_Attribute}

    \  ${Get_Merchant_Brand_Attribute_From_List2}=  Get From List   ${Get_Merchant_Brand_Attribute_From_List}   ${index}
    \  Log To Console   CMS MerchantZone Attribute No.${index}
    \  Log To Console   CMS MerchantZone Attribute = ${Get_Merchant_Brand_Attribute_From_List2}

    \  Should Be Equal As Strings   ${Get_Merchant_Brand_Attribute_From_List2}   ${Get_WeMall_Merchant_Brand_Attribute}
    \  Log To Console   WeMall MerchantZone Attribute No.${index} Is Retrieve Data Correct \n

Check Showroom Name Is Exist
    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name
    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1
    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}

    \  Set Test Variable   ${Current_Category_Name}   ${Get_Category_Name_From_List2}

    \  Log To Console   Get Current Showroom Name In ARRAY = ${Current_Category_Name}

    \  Run Keyword If  '${Check_WeMall_Category_Name}' == '${Get_Category_Name_From_List2}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_Category_Number}'   Log To Console   Showroom Name Is Not Exist In CMS

Compare Showroom Name In WeMall Mobile Site with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_showroom_respond}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //div[@class='ng-scope'][${index}]//span[@class='title-text ng-binding']
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}
    \  Set Test Variable   ${Check_WeMall_Category_Name}   ${Get_WeMall_Category_Name}

    \  Log To Console   \n WeMall Showroom Category No.${index}
    \  Log To Console   WeMall Showroom Category Name = ${Get_WeMall_Category_Name}

    \  Check Showroom Name Is Exist

    \  Log To Console   CMS Showroom Found Category Name = ${Current_Category_Name}

    \  Should Be Equal As Strings   ${Current_Category_Name}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall Showroom Category Name No.${index} Is Retrieve Data Correct \n

Compare Showroom Picture In WeMall Mobile Site with CMS
    ${XPATH_First_Showroom}   Catenate  SEPARATOR=  //div[a/div/div/span[contains(.,'${Check_First_Showroom_Name}')]]
    Wait Until Element Is Visible   ${XPATH_First_Showroom}
    Log To Console   \n Verify Showroom Name = ${Check_First_Showroom_Name}

    ${Get_Showroom_Picture_Attribute}   Get From Dictionary   ${TEST_VAR}   package_name

    Log To Console   Verify Showroom Picture Big Banner
    ${XPATH_Big_Banner}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='banner-big']//img@src
    ${Get_Big_Banner_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Big_Banner}
    ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   1
    Should Be Equal As Strings   ${Get_Big_Banner_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Big Banner = ${Get_Big_Banner_Attribute}
    Log To Console   CMS Big Banner = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Big Banner Picture Is Retrieve Data From CMS Correct \n

    Log To Console   Verify Showroom Picture Banner
    ${XPATH_Banner}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='showroom']//img@src
    ${Get_Banner_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Banner}
    ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   7
    Should Be Equal As Strings   ${Get_Banner_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Banner = ${Get_Banner_Attribute}
    Log To Console   CMS Banner = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Banner Picture Is Retrieve Data From CMS Correct \n

    :FOR  ${index}   IN RANGE  1  3+1
    \  ${XPATH_mini_showroom}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='showroom']/ul/li[${index}]/a/img@src
    \  ${Get_mini_showroom_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_mini_showroom}

    \  ${set_mini_showroom_count}=   Evaluate  ${index} + 1
    \  ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   ${set_mini_showroom_count}
    \  Should Be Equal As Strings   ${Get_mini_showroom_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Mini Showroom No.${index} = ${Get_mini_showroom_Attribute}
    \  Log To Console   CMS Mini Showroom No.${index} = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Mini Showroom Picture Is Retrieve Data From CMS Correct \n

    Log To Console   Verify Showroom Picture Container
    ${XPATH_Container}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='wm-container']//img@src
    ${Get_Container_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Container}
    ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   8
    Should Be Equal As Strings   ${Get_Container_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Container = ${Get_Container_Attribute}
    Log To Console   CMS Container = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Container Picture Is Retrieve Data From CMS Correct \n

Compare Showroom Manage Brand Picture In WeMall Mobile Site with CMS
    ${XPATH_First_Showroom}   Catenate  SEPARATOR=  //div[a/div/div/span[contains(.,'${Check_First_Showroom_Name}')]]
    Wait Until Element Is Visible   ${XPATH_First_Showroom}
    Log To Console   \n Verify Showroom Name = ${Check_First_Showroom_Name}

    ${Get_Showroom_Brand_Picture_Attribute}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}   IN RANGE  1  ${Check_Showroom_Brand_Pic_Number}+1
    \  ${XPATH_showroom_brand}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}//div[@class='slide-wrapper not-swipe ng-scope']//li[${index}]//img@src
    \  ${Get_showroom_brand_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_showroom_brand}
    \  ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Brand_Picture_Attribute}   ${index}
    \  Should Be Equal As Strings   ${Get_showroom_brand_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Showroom Brand Picture Attribute No.${index} = ${Get_showroom_brand_Attribute}
    \  Log To Console   CMS Showroom Brand Picture Attribute No.${index} = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Showroom Brand Picture No.${index} Is Retrieve Data From CMS Correct \n

# Verify Current Page Value
#     Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}
#     ${Get_current_page_value}   Get Text   ${XPATH_WeMall.txt_current_page}
#     Log To Console   \n Current Page = ${Get_current_page_value} \n
#     Set Test Variable   ${Check_current_page_value}   ${Get_current_page_value}

Click Search Icon To Go To Search Function
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_search_main_page}
    Sleep   2s
    Click Element   ${XPATH_WeMall.btn_search_main_page}
    Log To Console   \n Click Search Icon
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_search}

Verify Search Auto Suggestion
    Input Text   ${XPATH_WeMall.txt_search}   ${SAMPLE_DATA.VALID.txt_search_auto_suggestion}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_auto_suggestion_field}
    ${Get_Auto_Suggestion}   Get matching xpath Count   ${XPATH_WeMall.txt_auto_suggestion}
    Run Keyword If   '${Get_Auto_Suggestion}' > '0'   Log To console   \n Auto Suggestion Active \n
     ...  ELSE IF  '${Get_Auto_Suggestion}' == '0'   Log To Console   \n No Data Found \n

    ${Xpath_keyword_url}   Catenate  SEPARATOR=   ${XPATH_WeMall.txt_auto_suggestion}[1]/span/span[1]/strong
    ${Get_Keyword_url}   Get Text   ${Xpath_keyword_url}
    Log To Console   Click Keyword = ${Get_Keyword_url}
    ${Get_Keyword_url_Lowercase}   Convert To Lowercase   ${Get_Keyword_url}
    Click Element   ${XPATH_WeMall.txt_auto_suggestion}[1]
    Wait Until Element Is Visible   //div[@class='col-xs-15 mi-product-card-container-mobile ng-isolate-scope']
    Location Should Be   ${ITM_MOBILE}/search2?q=${Get_Keyword_url_Lowercase}

Verify Search When No Data Found
    Input Text   ${XPATH_WeMall.txt_search}   ${SAMPLE_DATA.INVALID.txt_search_not_found}
    Sleep   5s
    ${Get_Auto_Suggestion}   Get matching xpath Count   ${XPATH_WeMall.txt_auto_suggestion}
    Run Keyword If   '${Get_Auto_Suggestion}' > '0'   Log To console   \n Auto Suggestion Active \n
     ...  ELSE IF  '${Get_Auto_Suggestion}' == '0'   Log To Console   \n No Data Found \n

Click Cancel Button On Search Page
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_cancle_search_page}
    Click Element   ${XPATH_WeMall.btn_cancle_search_page}

Verify Page After Click Cancle On Search Page
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}
    # ${Get_current_page_value2}   Get Text   ${XPATH_WeMall.txt_current_page}
    # Log To Console   \n Current Page After Back From Search Page = ${Get_current_page_value2} \n
    # Should Be Equal As Strings  ${Check_current_page_value}  ${Get_current_page_value2}
    Location Should Be   ${WEMALL_WEB}portal/page1
    Log To Console   Back to previous page correct

#AFTER SEARCH > GO TO iTruemart
Search Item And Go To iTruemart Site
    Input Text   ${XPATH_WeMall.txt_search}   ${SAMPLE_DATA.VALID.txt_search_auto_suggestion}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_select_auto_suggestion}
    Click Element   ${XPATH_Wemall.txt_select_auto_suggestion}
#BELOW THIS LINE IS WORK AROUND WHILE WAITING FOR FIX BUG
    Wait Until Element Is Visible   ${iTruemart.wait_search_respond}
    Input Text   ${iTruemart.txt_input_search_keyword}   ${SAMPLE_DATA.VALID.txt_search_auto_suggestion}
    Wait Until Element Is Visible   ${iTruemart.txt_auto_suggestion_field}
    Click Element   ${iTruemart.txt_select_auto_suggestion}
#ABOVE THIS LINE IS WORK AROUND WHILE WAITING FOR FIX BUG
    Wait Until Element Is Visible   ${iTruemart.select_item}

# Verify Next View Button
#     ${XPATH_next_button_view}   Catenate  SEPARATOR=   ${iTruemart.btn_next_view_attribute}@class
#     ${Get_btn_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_next_button_view}
#     Log To Console   Get Attribute = ${Get_btn_Attribute}

#     @{Split_String}   Split String   ${Get_btn_Attribute}   ${SPACE}
#     ${Max_length}   Get Length   ${Split_String}
#     ${Last_Index}   Evaluate   ${Max_length}-1
#     Log To Console   Next Button View = @{Split_String}[${Last_Index}]

#     ${Get_btn_view}   Set Variable   @{Split_String}[${Last_Index}]
#     Set Test Variable   ${Check_btn_view}   ${Get_btn_view}

# Click Next View Button
#     Wait Until Element Is Visible   ${iTruemart.btn_next_view}
#     Click Element   ${iTruemart.btn_next_view}

# Verify Current View
#     ${XPATH_item_view}   Catenate  SEPARATOR=   ${iTruemart.select_item}@class
#     ${Get_item_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_item_view}
#     Log To Console   Get Attribute = ${Get_item_Attribute}

#     @{Split_String}   Split String   ${Get_item_Attribute}   -
#     ${Max_length}   Get Length   ${Split_String}
#     ${Last_Index}   Evaluate  ${Max_length}-1
#     Log To Console   Item View = @{Split_String}[${Last_Index}] \n

#     ${Get_item_view}   Set Variable   @{Split_String}[${Last_Index}]
#     Set Test Variable   ${Check_item_view}   ${Get_item_view}

#     Should Be Equal As Strings   ${Check_item_view}   ${Check_btn_view}

# Verify View After Click Next View Button

#######################################   SEARCH IN WE MALL MOBILE SITE   ########################################################
Go To Skrit That Content Is Search
    Click Element   ${XPATH_WeMall.btn_search_skrit}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

Click Sort
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_sort}
    Click Element   ${XPATH_WeMall.btn_sort}
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_sort_expand}

Click Sort By Keyword
    Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_keyword}
    Click Element   ${XPATH_Wemall.cbo_sort_keyword}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

Verify Sort By Keyword

Click Sort By Latest Product
    Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_latest}
    Click Element   ${XPATH_Wemall.cbo_sort_latest}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

Verify Sort By Latest Product

Click Sort By Low To High Price
    Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_low_to_high_price}
    Click Element   ${XPATH_Wemall.cbo_sort_low_to_high_price}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

Verify Sort By Low To High Price

Click Sort By High To Low Price
    Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_high_to_low_price}
    Click Element   ${XPATH_Wemall.cbo_sort_high_to_low_price}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

Verify Sort By High To Low Price

Click Sort By Low To High Discount
    Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_low_to_high_discount}
    Click Element   ${XPATH_Wemall.cbo_sort_low_to_high_discount}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

Verify Sort By Low To High Discount
    ${Count_Product_Number}   Get matching xpath count   ${XPATH_WeMall.cnt_item_in_search_skrit}
    Log To Console   Product Number = ${Count_Product_Number}

    Run Keyword If   '${Count_Product_Number}' == '0'

    Run Keyword If   '${Count_Product_Number}' < '10'

    Run Keyword If   '${Count_Product_Number}' > '20'

    //div[@class='product-list']/div[@class='over_lvb ng-scope'][${index}]//span[@class='price-display']
    //div[@class='product-list']/div[@class='over_lvb ng-scope'][1]//span[@class='price-display']/span[1]

Click Sort By High To Low Discount
    Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_high_to_low_discount}
    Click Element   ${XPATH_Wemall.cbo_sort_high_to_low_discount}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

Verify Sort By High To Low Discount

Click Filter
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_filter}
    Click Element   ${XPATH_WeMall.btn_filter}
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_filter_expand}

####################################################### Keyword iTruemart Header #################################################
Open Portal iTrueMart Mobile rebrand
    [Arguments]    ${home}
    Open Mobile Browser     ${ITM_MOBILE}/${home}        ${BROWSER}
    Maximize Browser Window
    Add Cookie      is_mobile  true
    Reload Page

Open Portal iTrueMart Mobile without resize rebrand
    [Arguments]    ${home}
    Open Mobile Browser without resize     ${ITM_MOBILE}/${home}        ${BROWSER}
    Maximize Browser Window
    Add Cookie      is_mobile  true
    Reload Page

Login iTruemart And Go To Portal rebrand
    [Arguments]    ${home}
    Open Browser   ${XPATH_iTrueMart.login_default}   chrome
    Add Cookie      is_mobile  true
    Reload Page
    Set Window Position   ${0}      ${0}
    Maximize Browser Window
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element   ${XPATH_iTrueMart.btn_submit_login}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.txt_id}
    Go To   ${ITM_MOBILE}/${home}

Not Found Item In Cart For Test iTruemart Header
    Log To Console   Item in cart = ${Check_item_number}
    Log To Console   Not Found Item In Cart
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}
    Click Element   ${XPATH_iTrueMart.icon_cart}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}
    Log To Console   Login Success

Verify Login link For Test iTruemart Header rebrand
    [Arguments]    ${home}
    Wait Until Element Is Visible   ${Mega_Menu.login}
    Click Element   ${Mega_Menu.login}
    Location Should Be   ${ITM_MOBILE}/auth/login?continue=${ITM_MOBILE}/${home}
    Log To Console   \n Login link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element   ${XPATH_iTrueMart.btn_submit_login}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}

    ${Get_item_number}   Get matching xpath count   ${XPATH_iTrueMart.icon_item_number_in_cart}
    Set Test Variable   ${Check_item_number}   ${Get_item_number}

    Run Keyword If   '${Get_item_number}' > '0'   Log To Console   Item in cart = ${Get_item_number} \n Login Success

    Run Keyword If   '${Get_item_number}' == '0'   Not Found Item In Cart For Test iTruemart Header

Verify Home link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.home}
    Click Element   ${Mega_Menu.home}
    Location Should Be   ${Check_URL_iTrueMart.home}
    Log To Console   \n Home link is Active

Verify Everyday Wow link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.wow}
    Click Element   ${Mega_Menu.wow}
    Location Should Be   ${Check_URL_iTrueMart.wow}
    Log To Console   \n Wow link is Active

Verify Category Main Link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.category}
    Sleep   2s
    Double Click Element   ${Mega_Menu.category}
    Sleep   1s
    Click Element   ${Mega_Menu.category}
    Wait Until Element Is Visible   ${Mega_Menu.wait_category_respond}
    Log To Console   \n Category Main link is Active

Verify Promotion Main Link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.promotion}
    Sleep   2s
    Double Click Element   ${Mega_Menu.promotion}
    Sleep   1s
    Click Element   ${Mega_Menu.promotion}
    Wait Until Element Is Visible   ${Mega_Menu.wait_promotion_respond}
    Log To Console   \n Promotion Main link is Active

Verify Itruemart link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.itruemart}
    Click Element   ${Mega_Menu.itruemart}
    Location Should Be   ${Check_URL_iTrueMart.itruemart}
    Log To Console   \n Itruemart link is Active

Verify Cart link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.cart}
    Click Element   ${Mega_Menu.cart}
    Location Should Be   ${Check_URL_iTrueMart.cart}
    Log To Console   \n Cart link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}
    Log To Console   Login Success

Verify Order Tracking link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.order_tracking}
    Click Element   ${Mega_Menu.order_tracking}
    Location Should Be   ${Check_URL_iTrueMart.order_tracking}
    Log To Console   \n Order Tracking link is Active

Verify Return Policy link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.return_policty}
    Click Element   ${Mega_Menu.return_policty}
    Location Should Be   ${Check_URL_iTrueMart.return_policty}
    Log To Console   \n Return Policy link is Active

Verify Shipment Policy link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.shipment_policy}
    Click Element   ${Mega_Menu.shipment_policy}
    Location Should Be   ${Check_URL_iTrueMart.shipment_policy}
    Log To Console   \n Shipment Policy link is Active

Verify Refund Policy link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.refund_policy}
    Click Element   ${Mega_Menu.refund_policy}
    Location Should Be   ${Check_URL_iTrueMart.refund_policy}
    Log To Console   \n Refund Policy link is Active

Verify Discount Code link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.discount_code}
    Click Element   ${Mega_Menu.discount_code}
    Location Should Be   ${Check_URL_iTrueMart.discount_code}
    Log To Console   \n Discount Code link is Active

Verify Contact Us link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.contact_us}    30
    Click Element   ${Mega_Menu.contact_us}
    Location Should Be   ${Check_URL_iTrueMart.contact_us}
    Log To Console   \n Contact Us link is Active

Verify Thai language For Test iTruemart Header rebrand
    [Arguments]    ${home}
    Wait Until Element Is Visible   ${Mega_Menu.TH_language}
    Log To Console   \n Ready To Click TH language
    Click Element   ${Mega_Menu.TH_language}
    ${Get_TH_URL}   Catenate  SEPARATOR=   ${ITM_MOBILE}/${home}

    @{Split_String}   Split String   ${Get_TH_URL}   ?
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Convert URL = ${String}

    Location Should Be   ${String}
    Log To Console   TH language link is Active

Verify English language For Test iTruemart Header rebrand
    [Arguments]    ${home}
    Wait Until Element Is Visible   ${Mega_Menu.ENG_language}
    Log To Console   \n Ready To Click ENG language
    Click Element   ${Mega_Menu.ENG_language}
    ${Get_ENG_URL}   Catenate  SEPARATOR=   ${ITM_MOBILE}/en/${home}

    @{Split_String}   Split String   ${Get_ENG_URL}   ?
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Convert URL = ${String}

    Location Should Be   ${String}
    Log To Console   EN language link is Active

Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand
    [Arguments]    ${home}
    Location Should Be   ${ITM_MOBILE}/${home}
    Log To Console   Back to previous page correct

Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header
    Wait Until Element Is Visible   ${Check_URL_iTrueMart.btn_cart_main_page}
    Click Element   ${Check_URL_iTrueMart.btn_cart_main_page}
    Wait Until Element Is Visible   ${Check_URL.wait_cart_respond}
    Location Should Be   ${Check_URL.cart}
    Log To Console   Shop Cart button is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}
    Log To Console   Login Success

Close popup
    Click Element   ${Check_URL_iTrueMart.btn_popup}
    Log To Console   Close Popup success

Verify Popup
    ${Check_popup_exist}   Get Matching xpath count   ${Check_URL_iTrueMart.btn_popup}

    Run Keyword If   '${Check_popup_exist}' == '0'   Log To Console   Popup dosen't Exist

    Run Keyword If   '${Check_popup_exist}' == '1'   Close popup

Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_wemall_icon}
    Sleep   2s
    Click Element   ${XPATH_WeMall.btn_wemall_icon}
    Location Should Be   ${Check_URL_iTrueMart.home}
    Log To Console   \n  WeMall Icon button is Active

# Verify Footer Change View Button In WeMall Mobile Site For Test iTruemart Header
#     Wait Until Element Is Visible   ${XPATH_WeMall.btn_footer_change_view}
#     Click Element   ${XPATH_WeMall.btn_footer_change_view}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_footer_change_view_respond}
#     Log To Console   \n  Footer Change View button is Active

