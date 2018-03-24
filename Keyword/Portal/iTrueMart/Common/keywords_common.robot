*** Keywords ***
Go To Current Page No Cache Version
    ${url}=    Get Location
    Go to    ${url}?no-cache=1

Go To With Cache Version
    [Arguments]    ${url}
    Go to    ${url}?no-cache=1