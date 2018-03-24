*** Variables ***
${text_menu}    //a[@class="mws-panel-header"]
${header_category}    //a[@class='header__nav_category']
${side_bar_collection}    //ul[@class='sidebar_1']/li[4]/a

${link_to_all_category}    //a[@class='list-item']

${filter_list_category_element}    //*[@id='filter-list-category']
${back_to_all_category_link}    ${filter_list_category_element}/div/a[1]
${see_more_category_button}    ${filter_list_category_element}/div/div[@class="filter-show-all"]/a

${link_to_all_collection}    //div[@class='filter-show-all']//a

${flash_cate_elements}    //*[@class='filter-list filter-list-type-link']//a[1]

${flash_coll_elements}    //div[@id='filter-list-collection']//a
${productlist_wrapper}    //div[@class="productlist_wrapper"]

${total_items}    //div[@class='total_items']

# ${level_c_thumbnail}    //*[@id='wrapper_content']/div/div[6]/div[3]/div
# ${level_c_thumbnail}    //div[@class='promotionlist_lvb']
# ${level_c_thumbnail}    //*[@class="product_lvb"]//div[@class='promotionlist_lvb']
${level_c_thumbnail}    //*[@class="product_lvb"]//div[@class='promotionlist_lvb']/a/span[@class="p-box-info"]/span[@class="name-display p-box-slide"]

