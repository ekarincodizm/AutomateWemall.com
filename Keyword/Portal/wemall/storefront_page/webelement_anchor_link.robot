*** Variables ***
${merchant_id}         TOSHIBA00813
${shop_name}           Toshiba
${status}              active
${shop_slug}           toshiba

${module}              Content
${web}                 Web
${mobile}              Mobile

${ckidprimary}         contents_html_primary
${ckidsecondary}       contents_html_secondary
${imgsource}           <img alt="" src="http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg" style="width: 1920px; height: 116px;">
${pic}                 http://alpha-cdn.wemall-dev.com/th/content/MTH10000_web_images/content-storefront.jpg
${merchant_data}       ${CURDIR}/../../../../Resource/TestData/merchant/css_merchants_create_retail_merchant.json

${cssFilePath}         ${CURDIR}/../../../../Resource/TestData/storefronts/menu_template.css
${test_content_en}     ${CURDIR}/../../../../Resource/TestData/storefronts/merchant_template_en.txt
${test_content_th}     ${CURDIR}/../../../../Resource/TestData/storefronts/merchant_template_th.txt
${stikyHeaderHieght}   53

${menuLv11Element}        jquery=ul.menu li.sub:eq(0)
${menuLevel11NameTh}    เมนูเลเวล 1-1
${menuLevel11NameEn}    Menu Level 1-1
${menuLevel11LinkTh}    \#content_footer
${menuLevel11LinkEn}    \#content_footer
${menuLevel11NewTab}    ${FALSE}
@{menuLevel11}          ${menuLevel11NameTh}    ${menuLevel11NameEn}     ${menuLevel11LinkTh}    ${menuLevel11LinkEn}    ${menuLevel11NewTab}

${menuLv21Element}        jquery=ul.menu li.sub:eq(1)
${menuLevel21NameTh}     เมนูเลเวล 2-1
${menuLevel21NameEn}    Menu Level 2-1
${menuLevel21LinkTh}    /shop/${shop_name}\#content_footer
${menuLevel21LinkEn}    /shop/en/${shop_name}\#content_footer
${menuLevel21NewTab}    ${FALSE}
@{menuLevel21}          ${menuLevel21NameTh}    ${menuLevel21NameEn}     ${menuLevel21LinkTh}    ${menuLevel21LinkEn}    ${menuLevel21NewTab}

${menuLv31Element}        jquery=ul.menu li.sub:eq(2)
${menuLevel31NameTh}     เมนูเลเวล 3-1
${menuLevel31NameEn}    Menu Level 3-1
${menuLevel31LinkTh}    ${WEMALL_WEB}/shop/en${shop_name}\#content_footer
${menuLevel31LinkEn}    ${WEMALL_WEB}/shop/${shop_name}\#content_footer
${menuLevel31NewTab}    ${FALSE}
@{menuLevel31}          ${menuLevel31NameTh}    ${menuLevel31NameEn}     ${menuLevel31LinkTh}    ${menuLevel31LinkEn}    ${menuLevel31NewTab}