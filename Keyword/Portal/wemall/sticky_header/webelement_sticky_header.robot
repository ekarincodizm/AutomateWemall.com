*** Variables ***
${wm_sticky_header}                jquery=#portal-sticky-header
${sticky_wm_logo}                  ${wm_sticky_header} .logo-wemall-white
${sticky_search_box}               ${wm_sticky_header} .search-input-box.header
${sticky_search_button}            ${wm_sticky_header} .btn-search.icon-search
${sticky_suggestion_box}           ${wm_sticky_header} .angucomplete-dropdown
${sticky_cart_icon}                ${wm_sticky_header} #wm-cbx-btn-cart
${sticky_cart_quantity_badge}      ${sticky_cart_icon} .icon-cart
${sticky_wow_logo}                 ${wm_sticky_header} .go-to-everyday-wow
${back_to_top_button}              jquery=#btn-back-to-top
${itm_back_to_top_button}          jquery=.productScrolltop