*** Variables ***

${URLMEGA_MENU}         http://sandbox-portal-cms.wemall-dev.com/#/mega-menu
${mega_menubutton}      jquery=a[href='#/mega-menu']
${add_button}           jquery=a.btn.btn-default.purple[data-id="add-menu"]
${manage_portal}        jquery=li a.menu-dropdown span.menu-text:eq(0)

## Button ##
${add_level1_btn}       jquery=a#btn-add-level-1
${add_level2_btn}       jquery=a.btn.btn-default.purple.ng-scope
${ok_btn}               jquery=div.modal-footer button[data-id='btn-save']
${publish_btn}          jquery=a.btn.btn-success[ng-click='savePublish()']
${save_btn}             jquery=a.btn.btn-blue[data-id='btn-draft']

## MENU FIELD ##
${menu_name_th}         jquery=div.col-sm-10 input[id='form_data.data.name.th']
${menu_name_en}         jquery=div.col-sm-10 input[id='form_data.data.name.en']
${menu_link_th}         jquery=div.col-sm-10 input[id='form_data.data.link_url.th']
${menu_link_en}         jquery=div.col-sm-10 input[id='form_data.data.link_url.en']
${check_box}            jquery=div.checkbox input#target
${mega_menulvl1}        jquery=span[data-id='menu-name']

${menu_namelvl2_th}     jquery=div.col-sm-10 input[id='form_data.data.name.th']
${menu_namelvl2_en}     jquery=div.col-sm-10 input[id='form_data.data.name.en']
${menu_linklvl2_th}     jquery=div.col-sm-10 input[id='form_data.data.link_url.th']
${menu_linklvl2_en}     jquery=div.col-sm-10 input[id='form_data.data.link_url.en']
${menu_level1_list}     jquery=#level-1
${last_banner_group_edit}            jquery=.dd2-content .item-tools--edit:last
${button_remove_banner_data}    jquery=.banner-detail .item-tools--remove
${button_confirm_remove_banner_data}    jquery=.modal-content .modal-footer .btn-blue:contains("Remove")



## Mega Menu Page ##
${publish_all_button}       jquery=div.col-lg-12.col-sm-12.col-xs-12 a.btn.btn-blue[data-id='btn-preview']

${parent_lv1}                               jquery=.dd-item.dd2-item
${banner_group_management}                  jquery=a.btn.btn-xs.banner-add
${button_add_banner_group}                  jquery=a[id='btn-add-banner-group']
${button_add_banner_group_disable}          jquery=a.disabled[id='btn-add-banner-group']

${input_banner_group_th}                    jquery=input[id="form_data.nameTh"]
${input_banner_group_en}                    jquery=input[id="form_data.nameEn"]
${button_submit_banner}                     jquery=button[type="submit"]:eq(1)
${banner_item}                              jquery=.item-name
${button_delete_first_banner}               jquery=.dd2-content:first a:eq(1)
${button_delete_last_banner}                jquery=.dd2-content:last a:eq(1)
${button_submit_remove_banner}              jquery=button:contains("Remove")
${button_save_banner_group}                 jquery=a.btn.btn-blue:contains("Save")
${first_banner}                             jquery=.dd-item.dd2-item:first
${last_banner}                              jquery=.dd-item.dd2-item:last
${banner_list}                              jquery=span.item-name
${button_create_banner_content}             jquery=.banner-add
${input_text_banner_th}                     jquery=input[id="bannerTh.title"]
${input_text_banner_link_th}                jquery=input[id="bannerTh.link_url"]
${input_text_banner_en}                     jquery=input[id="bannerEn.title"]
${input_text_banner_link_en}                jquery=input[id="bannerEn.link_url"]
${file_input}                               jquery=input[ngf-select]
${button_save_banner_detail}                jquery=button:contains("Save Banner")

${button_preview}                           jquery=a:contains("Preview")
${button_edit_detail}                       jquery=div.banner-detail .item-tools--edit


${web_image_th_on_banner_editor}
${mobile_image_th_on_banner_editor}

${web_image_position_1}                     jquery=img[id="1webImage"]
${web_image_position_2}                     jquery=img[id="2webImage"]
${web_image_position_3}                     jquery=img[id="3webImage"]
${mobile_image_position_1}                  jquery=img[id="1mobileImage"]
${mobile_image_position_2}                  jquery=img[id="2mobileImage"]
${mobile_image_position_3}                  jquery=img[id="3mobileImage"]

${alert_label_text}                              jquery=.control-label:contains("Please enter")
${alert_label_img}                         jquery=.control-label:contains("select")

# ${btn_lang_menu}                                 jquery=.btn-select-lang
# ${btn_lang_th}                                   jquery=.btn-select-lang li a[data-lang="th"]
# ${btn_lang_en}                                   jquery=.btn-select-lang li a[data-lang="en"]

${btn_lang_menu}          jquery=.iwm-header .btn-select-lang
${btn_lang_th}         ${btn_lang_menu} .dropdown-menu li a[data-lang='th']:not('.ng-hide')
${btn_lang_en}         ${btn_lang_menu} .dropdown-menu li a[data-lang='en']:not('.ng-hide')

${btn_mega_menu}                                 jquery=span:contains("Mega Menu")
${btn_mega_menu_preview}                         jquery=a:contains("Preview")
${btn_mega_menu_publish}                         jquery=a:contains("Publish")