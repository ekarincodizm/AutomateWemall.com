*** Settings ***
Library     Selenium2Library
Resource    ${CURDIR}/../../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_c_page/webelement_lv_c.robot

*** Keywords ***
Open All Category Mobile Page
	Open Browser   ${WEMALL_MOBILE_URL}/categories    ${BROWSER}

Get 1st Catagory Level C URI From Mobile
	Open All Category Mobile Page
	Wait Until Element Is Visible     ${CATEGORY_LIST}
	${url}=   Selenium2Library.Get Element Attribute   ${CATEGORY_LIST}@href
	${uri}=   Replace String        ${url}   ${WEMALL_MOBILE_URL}   ${EMPTY}
	Log to console    catagorty_uri=${uri}
	[return]   ${uri}

Mobile Level C - Open ITM Catagory With Category Slug-Pkey
    [Arguments]  ${slug-pkey}  ${lang}=th  ${query_str}=${EMPTY}
    Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_MOBILE_URL}/category/${slug-pkey}.html${query_str}   ${BROWSER}
     ...  ELSE   Open Browser   ${ITM_MOBILE_URL}/${lang}/category/${slug-pkey}.html${query_str}   ${BROWSER}

Mobile Level C - Open Merchant Category With Merchant Slug And Category Slug-Pkey
     [Arguments]  ${merchant_slug}  ${slug-pkey}  ${lang}=th  ${query_str}=${EMPTY}
     Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_MOBILE_URL}/m-${merchant_slug}-category-${slug-pkey}.html${query_str}   ${BROWSER}
     ...  ELSE   Open Browser   ${ITM_MOBILE_URL}/${lang}/m-${merchant_slug}-category-${slug-pkey}.html${query_str}   ${BROWSER}

Mobile Level C - Open ITM Everyday Wow Page
	[Arguments]  ${lang}=th
	Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_MOBILE_URL}/everyday-wow   ${BROWSER}
	 ...      ELSE   Open Browser   ${ITM_MOBILE_URL}/${lang}/everyday-wow   ${BROWSER}

Mobile Level C - Open ITM Brand With Brand Slug-Pkey
    [Arguments]    ${slug-pkey}   ${lang}=th   ${query_str}=${EMPTY}
    Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_MOBILE_URL}/brand/${slug-pkey}.html${query_str}   ${BROWSER}
     ...      ELSE   Open Browser   ${ITM_MOBILE_URL}/${lang}/brand/${slug-pkey}.html${query_str}   ${BROWSER}

Mobile Level C - Open ITM Search With Search String
    [Arguments]  ${key}=iphone  ${lang}=th
    Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_MOBILE_URL}/search2?q=${key}&per_page=60&page=1%3Fno-cache%3D1%3Fno-cache%3D1      ${BROWSER}
     ...      ELSE   Open Browser   ${ITM_MOBILE_URL}/${lang}/search2?q=${key}&per_page=60&page=1%3Fno-cache%3D1%3Fno-cache%3D1           ${BROWSER}

Mobile Level C - Display Catagory Page
	[Arguments]  ${cat_pkey}=${EMPTY}
    Wait Until Page Contains Element   //*[@data-type="categories"]
    Page Should Contain Element        //*[@data-type="categories"]
    Run Keyword If  "${cat_pkey}"!="${EMPTY}"  Wait Until Element Is Visible   //*[@data-collection-pkey="${cat_pkey}"]  20
    Run Keyword If  "${cat_pkey}"!="${EMPTY}"  Element Should Be Visible        //*[@data-collection-pkey="${cat_pkey}"]

Mobile Level C - Display Brand Page
	[Arguments]  ${brand_pkey}=${EMPTY}
    Wait Until Page Contains Element   //*[@data-type="brands"]
    Page Should Contain Element        //*[@data-type="brands"]
    Run Keyword If  "${brand_pkey}"!="${EMPTY}"  Wait Until Element Is Visible   //*[@data-collection-pkey="${brand_pkey}"]  20
    Run Keyword If  "${brand_pkey}"!="${EMPTY}"  Element Should Be Visible        //*[@data-collection-pkey="${brand_pkey}"]

Mobile Level C - Display Everyday Wow Page
	Wait Until Element Is Visible      ${m_wow_list}
	Wait Until Element Is Visible      ${m_totay_wow}
	Wait Until Page Contains Element   ${m_tomorrow_wow}
	Element Should Be Visible          ${m_wow_list}
	Element Should Be Visible          ${m_totay_wow}
	Page Should Contain Element        ${m_tomorrow_wow}

Mobile Level C - Display Search Page
    Wait Until Element Is Visible   ${m_search_result}
    Element Should Be Visible       ${m_search_result}

Mobile Level C - Scroll Down
    Execute JavaScript    window.scrollTo(0, 2000);

Mobile Level C - Scroll Over Live Chat
    Execute JavaScript    window.scrollTo(0, 300);

Open ITM Mobile level C Web With URI
    [Arguments]    ${uri}    ${lang}=th
    # ex. uri=/category/clearance-3776607921569.html
    Run Keyword If    '${lang}'=='th'    Open Browser    ${ITM_MOBILE_URL}${uri}    ${BROWSER}
    ...    ELSE    Open Browser    ${ITM_MOBILE_URL}/${lang}${uri}    ${BROWSER}
