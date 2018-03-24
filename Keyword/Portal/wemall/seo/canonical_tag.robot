*** Settings ***
Resource    ${CURDIR}/webelement_canonical_tag.robot

*** Keywords ***
Canonical Tag Should Be
    [Arguments]    ${expected_canonical_url}
    ${href}=       Selenium2Library.Get Element Attribute     ${canonical_href}
    Should Be Equal As Strings    ${href}    ${expected_canonical_url}

One of Alternate Tags Should Be
    [Arguments]         ${expected_alternate_url}
    Get Webelement      xpath=//link[@rel='alternate' and @href='${expected_alternate_url}']
