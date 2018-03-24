*** Settings ***
Suite Setup       Open Browser and Maximize Window    ${WEMALL_WEB}    ${BROWSER}
Suite Teardown    Run Keywords    Close All Browsers

Test Template     Verify Open Graph Tag

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/seo/og_tag.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot

*** Variables ***
&{desktop_url}
...    portal=${WEMALL_WEB}/
...    storefront=${WEMALL_WEB}/shop/canon
...    brand=${WEMALL_WEB}/brand/aiko-6158699057219.html
...    category=${WEMALL_WEB}/category/all-mobile-tablet-3193015175820.html
...    wow=${WEMALL_WEB}/everyday-wow
...    search=${WEMALL_WEB}/search2?q=iphone
...    level_d=${WEMALL_WEB}/products/aiko-ak-125gs-5549-stone-skunk-v.2-2557653043206.html
...    itm_shop=${WEMALL_WEB}/itruemart
...    contact_us=${WEMALL_WEB}/contact_us

&{mobile_url}
...    portal=${WEMALL_MOBILE}/
...    actual_portal=${WEMALL_MOBILE}/portal/page1
...    storefront=${WEMALL_MOBILE}/shop/canon
...    brand=${WEMALL_MOBILE}/brand/aiko-6158699057219.html
...    category=${WEMALL_MOBILE}/category/all-mobile-tablet-3193015175820.html
...    wow=${WEMALL_MOBILE}/everyday-wow
...    search=${WEMALL_MOBILE}/search2?q=iphone
...    level_d=${WEMALL_MOBILE}/products/aiko-ak-125gs-5549-stone-skunk-v.2-2557653043206.html
...    itm_shop=${WEMALL_MOBILE}/itruemart
...    contact_us=${WEMALL_MOBILE}/contact_us

&{levelD}
...    exp_og_title=AIKO เครื่องชั่งน้ำหนัก AK-125/GS-5549 STONE SKUNK V.2
...    exp_og_desc=\tเครื่องชั่งน้ำหนัก แบบเข็ม\tรองรับน้ำหนักได้สูงสุด 130 กิโลกรัม\tดีไซน์ลายการ์ตูน น่ารัก สดใส\tมาตรวัดเที่ยงตรง ได้มาตรฐาน\tสามารถปรับตั้งศูนย์ให้ตรงได้ด้วยตนเอง

@{wow_image}
...   http://www.wemall.com/themes/itruemart/assets/images/meta-og/everydaywow-24-oct-2014.jpg

&{wow}
...    exp_og_title=Everyday Wow | Wemall.com
...    exp_og_desc=ช้อปปิ้งออนไลน์ สินค้าแบรนด์ชั้นนำ ผู้นำธุรกิจ e-commerce ครบวงจร ซื้อของออนไลน์ สะดวก ง่าย มั่นใจ ได้ของเร็ว ส่งฟรี ระบบชำระเงินปลอดภัย เชื่อถือได้100%
...    exp_og_url=http://www.itruemart.com/everyday-wow
...    exp_og_image=${wow_image}
...    exp_type=website

${no_cache}    no-cache=1
${preview}     preview=678e45fa792c0a865d0eaee1b19e834d
${expected_og_type}           website
${expected_og_site_name}      WeMall
${expected_og_fb_admins}      100008235725896
${expected_og_fb_app_id}      748821641889252
@{expected_og_images}
...    http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/09/seo/wemall_logo_1200x1200.jpg
...    http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/09/seo/wemall_logo_1200x627.jpg
...    http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/09/seo/wemall_promotion_1200x627.jpg
@{expected_og_images_itm_portal}
...    http://www.wemall.com/themes/itruemart/assets/images/meta-og/logo-itruemart.jpg
...    http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/09/seo/wemall_logo_1200x627.jpg
...    http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/09/seo/wemall_logo_1200x1200.jpg
...    http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/09/seo/wemall_logo_1200x627.jpg
...    http://cdn-edm.itruemart.com/pcms/uploads/files/edm/16/06/09/seo/wemall_promotion_1200x627.jpg
${expected_suffix_og_url}     utm_source=Facebook&utm_medium=FB_Share&utm_campaign=ShareLink 

*** Test Cases ***
### Desktop ###
TC_iTM_03744 - Desktop - Portal Page should Show Open Graph Tags
    ${desktop_url.portal}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    ${desktop_url.portal}?${expected_suffix_og_url}    #${exp_og_full_url}
    [Tags]    og_tag    desktop    regression    TC_iTM_03744

TC_iTM_03746 - Desktop - Brand Page should Show Open Graph Tags
    ${desktop_url.brand}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    Has    #${exp_og_full_url}
    ...    Has    #${exp_og_title}
    ...    Has    #${exp_og_description}
    ...    Has    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    desktop    regression    TC_iTM_03746

TC_iTM_03747 - Desktop - Category Page should Show Open Graph Tags
    ${desktop_url.category}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    Has    #${exp_og_full_url}
    ...    Has    #${exp_og_title}
    ...    Has    #${exp_og_description}
    ...    Has    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    desktop    regression    TC_iTM_03747

TC_iTM_03748 - Desktop - Wow Page should Show Open Graph Tags
    ${desktop_url.wow}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    ${desktop_url.wow}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    ${wow.exp_og_title}    #${exp_og_title}
    ...    ${wow.exp_og_desc}    #${exp_og_description}
    ...    ${wow.exp_type}    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    ${wow.exp_og_image}    #${exp_og_images}
    [Tags]    og_tag    desktop    regression    TC_iTM_03748

TC_iTM_03749 - Desktop - Search Page should Show Open Graph Tags
    ${desktop_url.search}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    Has    #${exp_og_full_url}
    ...    Has    #${exp_og_title}
    ...    Has    #${exp_og_description}
    ...    Has    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    ${expected_og_images}    #${exp_og_images}
    [Tags]    og_tag    desktop    regression    TC_iTM_03749

TC_iTM_03750 - Desktop - Level D Page should Show Open Graph Tags
    ${desktop_url.level_d}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    ${desktop_url.level_d}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    ${levelD.exp_og_title}    #${exp_og_title}
    ...    ${levelD.exp_og_desc}    #${exp_og_description}
    ...    ${expected_og_type}    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    Has    #${exp_og_images}
    [Tags]    og_tag    desktop    regression    TC_iTM_03750

TC_iTM_03751 - Desktop - iTruemart Shop Page should Show Open Graph Tags
    ${desktop_url.itm_shop}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    ${desktop_url.itm_shop}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    EQ    #${exp_og_title}
    ...    EQ    #${exp_og_description}
    ...    ${expected_og_type}    #${exp_og_type}
    ...    ${expected_og_site_name}    #${exp_og_site_name}
    ...    ${expected_og_fb_admins}    #${exp_og_fb_admins}
    ...    ${expected_og_fb_app_id}    #${exp_og_fb_app_id}
    ...    ${expected_og_images_itm_portal}    #${exp_og_images}
    ...    ${FALSE}    #${is_contain_itm}
    [Tags]    og_tag    desktop    regression    TC_iTM_03751

TC_iTM_03752 - Desktop - Contact Us Page should Show Open Graph Tags
    ${desktop_url.contact_us}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    None    #${exp_og_full_url}
    ...    None    #${exp_og_title}
    ...    None    #${exp_og_description}
    ...    None    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    desktop    regression    TC_iTM_03752

### Mobile ###
TC_iTM_03753 - Mobile - Portal Page should Show Open Graph Tags
    ${mobile_url.portal}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    ${mobile_url.actual_portal}?${expected_suffix_og_url}    #${exp_og_full_url}
    [Tags]    og_tag    mobile    regression    TC_iTM_03753

TC_iTM_03755 - Mobile - Brand Page should Show Open Graph Tags
    ${mobile_url.brand}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    None    #${exp_og_full_url}
    ...    None    #${exp_og_title}
    ...    None    #${exp_og_description}
    ...    None    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    mobile    regression    TC_iTM_03755

TC_iTM_03756 - Mobile - Category Page should Show Open Graph Tags
    ${mobile_url.category}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    None    #${exp_og_full_url}
    ...    None    #${exp_og_title}
    ...    None    #${exp_og_description}
    ...    None    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    mobile    regression    TC_iTM_03756

TC_iTM_03757 - Mobile - Wow Page should Show Open Graph Tags
    ${mobile_url.wow}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    ${mobile_url.wow}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    ${wow.exp_og_title}    #${exp_og_title}
    ...    ${wow.exp_og_desc}    #${exp_og_description}
    ...    ${expected_og_type}    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    ${wow.exp_og_image}    #${exp_og_images}
    [Tags]    og_tag    mobile    regression    TC_iTM_03757

TC_iTM_03758 - Mobile - Search Page should Show Open Graph Tags
    ${mobile_url.search}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    None    #${exp_og_full_url}
    ...    None    #${exp_og_title}
    ...    None    #${exp_og_description}
    ...    None    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    ${expected_og_images}    #${exp_og_images}
    [Tags]    og_tag    mobile    regression    TC_iTM_03758

TC_iTM_03759 - Mobile - Level D Page should Show Open Graph Tags
    ${mobile_url.level_d}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    None    #${exp_og_full_url}
    ...    None    #${exp_og_title}
    ...    None    #${exp_og_description}
    ...    None    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    mobile    regression    TC_iTM_03759

TC_iTM_03760 - Mobile - iTruemart Shop Page should Show Open Graph Tags
    ${mobile_url.itm_shop}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    ${mobile_url.itm_shop}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    EQ    #${exp_og_title}
    ...    EQ    #${exp_og_description}
    ...    ${expected_og_type}    #${exp_og_type}
    ...    ${expected_og_site_name}    #${exp_og_site_name}
    ...    ${expected_og_fb_admins}    #${exp_og_fb_admins}
    ...    ${expected_og_fb_app_id}    #${exp_og_fb_app_id}
    ...    ${expected_og_images_itm_portal}    #${exp_og_images}
    [Tags]    og_tag    mobile    regression    TC_iTM_03760

TC_iTM_03761 - Mobile - Contact Us Page should Show Open Graph Tags
    ${mobile_url.contact_us}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    None    #${exp_og_full_url}
    ...    None    #${exp_og_title}
    ...    None    #${exp_og_description}
    ...    None    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    mobile    regression    TC_iTM_03761

### Desktop No-Cache & Preview ###
TC_iTM_03762 - Desktop No Cache - Portal Page should Show Open Graph Tags
    ${desktop_url.portal}?${no_cache}&${preview}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    ${desktop_url.portal}?${expected_suffix_og_url}    #${exp_og_full_url}
    [Tags]    og_tag    desktop    TC_iTM_03762    no_cache    regression

TC_iTM_03764 - Desktop No Cache - Wow Page should Show Open Graph Tags
    ${desktop_url.wow}?${no_cache}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    ${desktop_url.wow}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    ${wow.exp_og_title}    #${exp_og_title}
    ...    ${wow.exp_og_desc}    #${exp_og_description}
    ...    ${wow.exp_type}    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    ${wow.exp_og_image}    #${exp_og_images}
    [Tags]    og_tag    desktop    TC_iTM_03764    no_cache    regression

TC_iTM_03765 - Desktop No Cache - Search Page should Show Open Graph Tags
    ${desktop_url.search}&${no_cache}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    Has    #${exp_og_full_url}
    ...    Has    #${exp_og_title}
    ...    Has    #${exp_og_description}
    ...    Has    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    None    #${exp_og_images}
    [Tags]    og_tag    desktop    TC_iTM_03765    no_cache    regression

TC_iTM_03766 - Desktop No Cache - iTruemart Shop Page should Show Open Graph Tags
    ${desktop_url.itm_shop}?${no_cache}    #${full_url}
    ...    ${FALSE}    #${is_mobile}
    ...    ${desktop_url.itm_shop}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    EQ    #${exp_og_title}
    ...    EQ    #${exp_og_description}
    ...    ${expected_og_type}    #${exp_og_type}
    ...    ${expected_og_site_name}    #${exp_og_site_name}
    ...    ${expected_og_fb_admins}    #${exp_og_fb_admins}
    ...    ${expected_og_fb_app_id}    #${exp_og_fb_app_id}
    ...    ${expected_og_images_itm_portal}    #${exp_og_images}
    ...    ${FALSE}    #${is_contain_itm}
    [Tags]    og_tag    desktop    TC_iTM_03766    no_cache    regression

### Mobile No-Cache & Preview ###
TC_iTM_03767 - Mobile No Cache - Portal Page should Show Open Graph Tags
    ${mobile_url.portal}?${no_cache}&${preview}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    ${mobile_url.actual_portal}?${expected_suffix_og_url}    #${exp_og_full_url}
    [Tags]    og_tag    mobile    TC_iTM_03767    no_cache    regression

TC_iTM_03769 - Mobile No Cache - Wow Page should Show Open Graph Tags
    ${mobile_url.wow}?${no_cache}    #${full_url}
    ...    ${TRUE}    #${is_mobile}
    ...    ${mobile_url.wow}?${expected_suffix_og_url}    #${exp_og_full_url}
    ...    ${wow.exp_og_title}    #${exp_og_title}
    ...    ${wow.exp_og_desc}    #${exp_og_description}
    ...    ${expected_og_type}    #${exp_og_type}
    ...    None    #${exp_og_site_name}
    ...    None    #${exp_og_fb_admins}
    ...    None    #${exp_og_fb_app_id}
    ...    ${wow.exp_og_image}    #${exp_og_images}
    [Tags]    og_tag    mobile    TC_iTM_03769    no_cache    regression

*** Keywords ***
Verify Open Graph Tag
    [Arguments]    
    ...    ${full_url}
    ...    ${is_mobile}
    ...    ${exp_og_full_url}
    ...    ${exp_og_title}=EQ
    ...    ${exp_og_description}=EQ
    ...    ${exp_og_type}=${expected_og_type}
    ...    ${exp_og_site_name}=${expected_og_site_name}
    ...    ${exp_og_fb_admins}=${expected_og_fb_admins}
    ...    ${exp_og_fb_app_id}=${expected_og_fb_app_id}
    ...    ${exp_og_images}=${expected_og_images}
    ...    ${is_contain_itm}=${TRUE}
    #end param
    Run Keyword If    ${is_mobile}
    ...               Go To Wemall Mobile URL      ${full_url}
    ...    ELSE       Go To Wemall Desktop URL     ${full_url}
    #Check title
    Run Keyword If    '${exp_og_title}'=='EQ'           Open Graph Title Should Be Equal With Title
    ...    ELSE IF    "${exp_og_title}"=="Has"          Open Graph Has Title
    ...    ELSE IF    '${exp_og_title}'!='None'         Open Graph Title Should Be    ${exp_og_title}
    #Check desc
    Run Keyword If    '${exp_og_description}'=='EQ'     Open Graph Description Should Be Equal With Meta Description
    ...    ELSE IF    "${exp_og_description}"=="Has"    Open Graph Has Description
    ...    ELSE IF    '${exp_og_description}'!='None'   Open Graph Description Should Be    ${exp_og_description}
    #Check
    Run Keyword If    ${is_contain_itm} and '${exp_og_title}'!='None'          Open Graph Title Not Contain          iTruemart.com
    Run Keyword If    ${is_contain_itm} and '${exp_og_description}'!='None'    Open Graph Description Not Contain    iTruemart.com
    #Check others
    Run Keyword If    "${exp_og_type}"=="Has"           Open Graph Has Type
    ...    ELSE IF    '${exp_og_type}'!='None'          Open Graph Type Should Be               ${exp_og_type}

    Run Keyword If    "${exp_og_site_name}"=="Has"      Open Graph Has Site
    ...    ELSE IF    '${exp_og_site_name}'!='None'     Open Graph Site Should Be               ${exp_og_site_name}

    Run Keyword If    "${exp_og_fb_admins}"=="Has"      Open Graph Has Facebook Admin
    ...    ELSE IF    '${exp_og_fb_admins}'!='None'     Open Graph Facebook Admin Should Be     ${exp_og_fb_admins}
    
    Run Keyword If    "${exp_og_fb_app_id}"=="Has"      Open Graph Has Facebook App ID
    ...    ELSE IF    '${exp_og_fb_app_id}'!='None'     Open Graph Facebook App ID Should Be    ${exp_og_fb_app_id}

    Run Keyword If    "${exp_og_images}"=="Has"         Open Graph Has Images
    ...    ELSE IF    "${exp_og_images}"!="None"        Open Graph Images Should Be             ${exp_og_images}
    
    Run Keyword If    "${exp_og_full_url}"=="Has"       Open Graph Has URL
    ...    ELSE IF    '${exp_og_full_url}'!='None'      Open Graph URL Should Be                ${exp_og_full_url}
    