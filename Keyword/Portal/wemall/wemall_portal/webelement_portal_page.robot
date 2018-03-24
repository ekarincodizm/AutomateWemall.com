*** Variables ***
#Header
${button-account}            css=div.main-menu div.btn-my-profile
${button-signin}             css=div.main-menu div.login-box div.btn-login-black
${mega-menu-list}            jquery=.mega-menu-list li
${mega-menu-banner-index}    jquery=#mega-menu-banner-index
${mega-menu-list-lv1}        jquery=.wm-container .mega-menu ul.mega-menu-list li a
${mega-menu-list-lv2}        jquery=.wm-container .mega-menu .mega-content:not(.ng-hide) ul li
${mega_menu_lvl2_list}       jquery=.wm-container .mega-menu .mega-content:not(.ng-hide)
${mege-menu-icon-button}     css=.btn-cetagory
${mege-menu-element}         css=.mega-menu.active
${background-megamenu}       css=.main-banner
${brand-link}        //div[contains(@class,"brand-item")]/a
${icon_hamburger}            jquery=.btn-cetagory-mini .icon-menu-hamburger
${button_select_lang}        jquery=.btn-select-lang
${button_change_lang}        jquery=.btn-select-lang .dropdown-menu li:not(.active)

${save_button}               jquery=a.btn.btn-blue[data-id='btn-draft']

${mega-menu-mobile}          jquery=.owl-stage-outer
${main-banner}               jquery=.main-banner