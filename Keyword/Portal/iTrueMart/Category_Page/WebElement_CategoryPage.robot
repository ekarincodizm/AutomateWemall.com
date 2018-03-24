*** Variables ***
${Category_OutOfStock_Img}    //div[@class='over_lvb']//span[contains(@class,'bx-link-img')]/img[contains(@alt,'REPLACE_ME')]/../div[contains(@class,'out-of-stock')]
${Category_OutOfStock_Img_Multi_Valiance}    //div[@class='over_lvb']//span[@id='REPLACE_ME']//div[contains(@class,'out-of-stock')]
${CategoryPage}    all-mobile-tablet-3193015175820.html?all=1
${category_page_expain_all}    all-mobile-tablet-3193015175820.html?all=1
${collection_page_expain_all}   hulk-promotion-9-3698907895179.html?all=1
${category_tree_box}         jquery=._iwm_ .wm-search-filter
${button_language}           jquery=#language
${box_language_th}              jquery=ul[aria-labelledby="language"] li:eq(0)
${box_language_en}              jquery=ul[aria-labelledby="language"] li:eq(1)
${button_see_more_category}              jquery=a[href="#see-more-category"]
${button_see_more_collection}              jquery=a[href="#see-more-collection"]
${link_category_menu_item}                          jquery=div#menu-category a.list-item
${link_collection_menu_item}                        jquery=div#menu-collection a.list-item
