*** Settings ***
Suite Setup         Run Keywords    Open Browser and Go to iTrueMart Portal
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Common/keywords_common.robot
Test Template       Verify Portal Element

*** Variables ***
#${ITM_URL}               http://www.itruemart.com

*** Test Cases ***
TC_iTM_02296 - iTrueMart portal TH page Check Element      ${ITM_URL}
     [tags]    regression    iTM_portal    iTM_banner

TC_iTM_02297 - iTrueMart portal EN page Check Element      ${ITM_URL}/en
     [tags]    regression    iTM_portal    iTM_banner

