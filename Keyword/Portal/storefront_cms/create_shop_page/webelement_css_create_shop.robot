*** Variable ***

##### Text On Page ####
${addShop_btn}           jquery=div.widget-body #btnCreateShop
${newShop_title}         jquery=h3#title
${nameShop_text}         jquery=#sfmLblShopName    #Shop name
${merchantId_text}       jquery=#sfmLblMerchantId  #Merchant code (optional)
${shopUrl_text}          jquery=#sfmLblShopUrl  #Shop url
${logo157x85_text}       jquery=#sfbLblLogoWeb  #Logo(157x85)
${logo130x130_text}      jquery=#sfbLblLogoMobile  #Logo(130x130)

##### Field Input #####
${shopName_field}        jquery=div.col-sm-9 #sfmShopName
${merchantId_field}      jquery=div.col-sm-9 #sfmMerchantId
${shopUrl_field}         jquery=div.col-sm-9 #sfmShopUrl
${logo157x85_button}     jquery=div#btnLogoWeb
${logo130x130_button}    jquery=div#btnLogoMobile
${statusShop_switch}     jquery=input#sfbStatus[ng-click='onStatusChange()']
${modalLogo_Desktop}     jquery=input:file[ng-model="shop.logoDesktop.file"]
${modalLoga_DesktopPre}  jquery=div img#sfbImgLogoDesktopF
${modalLogo_Mobile}      jquery=input:file[ng-model="shop.logoMobile.file"]
${modalLogo_MobilePre}   jquery=div img#sfbImgLogoMobileF
${ok_status_button}      jquery=div.modal-footer .btn.btn-blue[ng-click='ok()']
${create_button}         jquery=div.modal-footer .btn.btn-blue[ng-click='save()'
${cancel_status_button}   jquery=div.modal-footer .btn.btn-warning[ng-click='cancel()']
${disable_save_button}    jquery=div.modal-footer button.btn.btn-blue[ng-click='save()']:disabled
${status_confirm_title}    jquery=div.modal-header h3.modal-title.ng-binding
${edit_title}             jquery=div.modal-header span.ng-binding.ng-scope
${disable_shopUrl}        jquery=div.col-sm-9 #sfmShopUrl:disabled

#### Varidata Create New Shop ####

${shopname}            jquery=i.fa.fa-check
${errmsg_shopname}     jquery=div.col-sm-9 span[ng-show='shopForm.sfmShopName.$error.duplicated']
${errmsg_urlshop}      jquery=div.col-sm-9 span[ng-show='shopForm.sfmShopUrl.$error.duplicated && (shopForm.sfmShopUrl.$touched || shopForm.sfmShopName.$touched)']

#### Error message Create New Shop ####
${exist_shopname}      Shop name already exists
${exist_shopurl}       Shop url  already exists

#### Edit shop ####
# ${edit_webshop}        jquery=table.table-striped.table-hover tr[id='${shopId}-web'] td:eq(1)
# ${edit_mobileshop}     jquery=table.table-striped.table-hover tr[id='${shopId}-mobile'] td:eq(1)
