*** Settings ***

*** Keywords ***
CKEditor Input Text
    [Arguments]    ${ckeditor_id}    ${text}
    Run Keyword    CKEditor Wait Util Ready    ${ckeditor_id}
    Execute Javascript
    ...    CKEDITOR.instances['${ckeditor_id}'].setData('${text}');

CKEditor Clear Text
    [Arguments]    ${ckeditor_id}
    Run Keyword    CKEditor Input Text    ${ckeditor_id}    ${EMPTY}

CKEditor Wait Util Ready
    [Arguments]    ${ckeditor_id}
    Wait For Condition    return typeof $('#${ckeditor_id}').isolateScope().model !== "undefined" && $('#${ckeditor_id}').isolateScope().model !== null     60
    Sleep    500 milliseconds
