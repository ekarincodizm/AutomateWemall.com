*** Settings ***
Resource    ${CURDIR}/webelement_og_tag.robot

*** Keywords ***
Open Graph Title Should Be Equal With Title
    ${og_title_elm}=     Get Webelement    ${meta_og_title}
    ${title}=    Get Title
    Should Be Equal As Strings    ${title}    ${og_title_elm.get_attribute('content')}

Open Graph Title Should Be
    [Arguments]    ${expected_og_title}
    ${og_title_elm}=     Get Webelement    ${meta_og_title}
    Should Be Equal As Strings    ${og_title_elm.get_attribute('content')}    ${expected_og_title}

Open Graph Title Not Contain
    [Arguments]    ${expected_og_title}
    ${og_title_elm}=     Get Webelement    ${meta_og_title}
    Should Not Contain    ${og_title_elm.get_attribute('content')}    ${expected_og_title}

Open Graph Has Title
    Page Should Contain Element    ${meta_og_title}

Open Graph Description Should Be Equal With Meta Description
    ${og_desc_elm}=      Get Webelement    ${meta_og_description}
    ${desc_elm}=      Get Webelement    ${meta_description}
    Should Be Equal As Strings    ${og_desc_elm.get_attribute('content')}     ${desc_elm.get_attribute('content')}

Open Graph Description Should Be 
    [Arguments]    ${expected_og_description}
    ${og_desc_elm}=      Get Webelement    ${meta_og_description}
    Should Be Equal As Strings    ${og_desc_elm.get_attribute('content')}     ${expected_og_description}

Open Graph Description Not Contain
    [Arguments]    ${expected_og_description}
    ${og_desc_elm}=      Get Webelement    ${meta_og_description}
    Should Not Contain    ${og_desc_elm.get_attribute('content')}     ${expected_og_description}

Open Graph Has Description
    Page Should Contain Element    ${meta_og_description}

Open Graph Type Should Be 
    [Arguments]    ${expected_og_type}
    ${og_type_elm}=      Get Webelement    ${meta_og_type}
    Should Be Equal As Strings    ${og_type_elm.get_attribute('content')}     ${expected_og_type}

Open Graph Has Type
    Page Should Contain Element    ${meta_og_type}

Open Graph Site Should Be 
    [Arguments]    ${expected_og_site}
    ${og_site_elm}=      Get Webelement    ${meta_og_site_name}
    Should Be Equal As Strings    ${og_site_elm.get_attribute('content')}     ${expected_og_site}

Open Graph Has Site
    Page Should Contain Element    ${meta_og_site_name}

Open Graph Facebook Admin Should Be
    [Arguments]    ${expected_fb_admin}
    ${fb_admin_elm}=     Get Webelement    ${meta_fb_admins} 
    Should Be Equal As Strings    ${fb_admin_elm.get_attribute('content')}    ${expected_fb_admin}

Open Graph Has Facebook Admin
    Page Should Contain Element    ${meta_fb_admins}

Open Graph Facebook App ID Should Be 
    [Arguments]    ${expected_fb_app_id}
    ${fb_app_id_elm}=    Get Webelement    ${meta_fb_app_id}
    Should Be Equal As Strings    ${fb_app_id_elm.get_attribute('content')}    ${expected_fb_app_id}

Open Graph Has Facebook App ID
    Page Should Contain Element    ${meta_fb_app_id}

Open Graph URL Should Be 
    [Arguments]    ${expected_og_url}
    ${og_url_elm}=       Get Webelement    ${meta_og_url}
    Should Be Equal As Strings    ${og_url_elm.get_attribute('content')}    ${expected_og_url}

Open Graph Has URL
    Page Should Contain Element    ${meta_og_url}

Open Graph Images Should Be 
    [Arguments]    ${expected_og_images}
    # Verify that lengths are equal
    ${expected_og_images_len}=    Get Length    ${expected_og_images}
    ${og_images}=                 Get Webelements    ${meta_og_image} 
    ${og_images_len}=             Get Length    ${og_images}   
    Should Be Equal As Integers    ${og_images_len}    ${expected_og_images_len}
    # Verify each item
    : FOR    ${INDEX}    IN RANGE    0    ${og_images_len} 
    \        ${og_image}=             Set Variable    @{og_images}[${INDEX}]
    \        ${expected_og_image}=    Set Variable    @{expected_og_images}[${INDEX}]
    \        Should Contain    ${expected_og_image}    ${og_image.get_attribute('content')}

Open Graph Has Images
    Page Should Contain Element    ${meta_og_image}
