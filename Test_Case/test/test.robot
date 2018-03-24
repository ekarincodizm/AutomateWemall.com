*** Settings ***
Library           Selenium2Library
Resource          ../../Resource/init.robot
Library           Collections

*** Test Cases ***
test
    Open Browser    http://www.wemall.com/category/watches-3259084765891.html    chrome
    ${Count}    Get Matching Xpath Count    //*[@class="over_lvb"]
    ${All_Product}=    Create List    ${EMPTY}
    : FOR    ${INDEX}    IN RANGE    1    ${Count}
    \    ${Product_Name}    Get Text    //*[@class="over_lvb"][${INDEX}]//*[@class="name-display p-box-slide"]
    \    Append To List    ${All_Product}    ${Product_Name}
    Log    ${All_Product}
    [Teardown]    close browser
