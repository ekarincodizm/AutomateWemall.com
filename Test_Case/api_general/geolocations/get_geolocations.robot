*** Settings ***
Resource     ${CURDIR}/../../../Resource/init.robot
Resource     ${CURDIR}/../../../Keyword/API/api_general/geolocations_keyword.robot

*** Variables ***
${GZip_Encoding}=          gzip
${Binary_Encoding}=        binary/octet-stream
${GeolocationGzipPath}=    ${CDN_SERVER}th/general/geolocation/geolocation.json.gz
${GeolocationJsonPath}=    ${CDN_SERVER}th/general/geolocation/geolocation.json

*** Test Cases ***
TC_WMALL_01241 Get Geolocations File
    [Tags]    get_geolocations    api_geolocations    api_general
    Get Geolocations Success
    Verify Get Geolocations Success and Parh File Correct    ${GZip_Encoding}    ${GeolocationGzipPath}

TC_WMALL_01242 Get Geolocations File with Query Content-Encoding is gzip
    [Tags]    get_geolocations    api_geolocations    api_general
    Get Geolocations With Content Encoding    ${GZip_Encoding}
    Verify Get Geolocations Success and Parh File Correct    ${GZip_Encoding}    ${GeolocationGzipPath}

TC_WMALL_01243 Get Geolocations File with Query Content-Encoding is Binary
    [Tags]    get_geolocations    api_geolocations    api_general
    Get Geolocations With Content Encoding    ${Binary_Encoding}
    Verify Get Geolocations Success and Parh File Correct    ${Binary_Encoding}    ${GeolocationJsonPath}

TC_WMALL_01244 Get Geolocations File with Wrong Query Content-Encoding
    [Tags]    get_geolocations    api_geolocations    api_general
    Get Geolocation with Wrong Content Encoding    wrong-content-encoding
    Verify Get Geolocations Success and Parh File Correct    ${GZip_Encoding}    ${GeolocationGzipPath}
