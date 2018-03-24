*** Settings ***
Resource        ${CURDIR}/../common/api_keywords.robot
Library         Collections
Library         HttpLibrary.HTTP

*** Keywords ***
############ Prepare Data ############

############ Get ############
Get Geolocations With Content Encoding
    [Arguments]    ${Encoding}
    HTTP Get Request    ${GENERAL_API_HOST}    ${HTTP_PROTOCAL}    ${GEOLOCATIONS}?Content-Encoding=${Encoding}

Get Geolocations Success
    HTTP Get Request    ${GENERAL_API_HOST}    ${HTTP_PROTOCAL}    ${GEOLOCATIONS}

Get Geolocation with Wrong Content Encoding
    [Arguments]    ${Encoding}
    HTTP Get Request    ${GENERAL_API_HOST}    ${HTTP_PROTOCAL}    ${GEOLOCATIONS}?Content-Encoding=${Encoding}

############ Verify ############
Verify Get Geolocations Success and Parh File Correct
    [Arguments]    ${Encoding}    ${GeolocationFilePath}
    Response Status Code Should Equal    200 OK
    ${response_body}=     Get Response Body
    Assert Node Data Value with Expected    ${response_body}    /Content-Encoding    ${Encoding}    Content-Encoding file geolocation is not matched
    Assert Node Data Value with Expected    ${response_body}    /path    ${GeolocationFilePath}    Path file geolocation is not matched