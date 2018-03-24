*** Variables ***
#   Menu Bar
${add_menu_bar_web}         jquery=a:contains("Add"):eq(0)
${name_th}                  jquery=div input.form-control:eq(0)
${link_th}                  jquery=div input.form-control:eq(1)
${name_en}                  jquery=div input.form-control:eq(2)
${link_en}                  jquery=div input.form-control:eq(3)
${checkbox_open_new_tab}    jquery=#target
${ok_button}                jquery=button:contains("OK")
${manage_portal_dropdown}   jquery=a.menu-dropdown:eq(0)
${submenu_menu_bar}         jquery=ul.submenu li a span:contains("Menubar")
${dropdown_lang}            jquery=.btn-select-lang div.dropdown
${en_btn}                   jquery=.btn-lang:contains("English"):eq(1)
${preview_btn}              jquery=a:contains("Preview"):eq(0)
${save_btn}                 jquery=a:contains("Save"):eq(0)
${dotdotdot_btn}            jquery=#portal-menu-bars-dropdown
${publish_btn}              jquery=a:contains("Publish"):eq(0)
${confirm_delete}           jquery=button.btn:contains("OK")

#Mobile
${add_menu_bar_mobile}         jquery=a:contains("Add"):eq(1)
${preview_btn_mobile}              jquery=a:contains("Preview"):eq(1)
${save_btn_mobile}                 jquery=a:contains("Save"):eq(1)
${publish_btn_mobile}              jquery=a:contains("Publish"):eq(1)