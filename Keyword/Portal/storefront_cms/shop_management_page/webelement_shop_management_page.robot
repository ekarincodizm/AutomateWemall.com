*** Variables ***
${tableButtonsId}                       jquery=table[data-id=storefrontButtonTable]
${table_shop_management}                jquery=table[data-id='merchantManagementTable']

${tag_shop_name}                        jquery=div.header-title.ng-scope h1
${link_shop_list_page}                  jquery=ul.breadcrumb.ng-scope.ng-isolate-scope li a[href='#/merchantList'
${link_storefront_management_page}      jquery=ul.breadcrumb.ng-scope.ng-isolate-scope li a:contains('Storefront Management')

${alert_storefront_management}          jquery=div[id="cmsAlert"] div
${collapse_storefront_page_layout}      jquery=.page-body.ng-scope #cmsWidget .fa.fa-minus
${previewButtonId}                      btnPreview
${publishButtonId}                      btnPublish
${backButtonId}                         btnBack

#### Pages list table ####
${table_pages_list}                     jquery=.table.table-striped.table-hover.table-custom
${page_manage_alert}                    jquery=#pageManagementAlert div

###  Page Management Element ###
${createPageButton}             id=btnCreatePage
${pageNameInput}                id=sfmPageName
${pageSlugInput}                id=sfmPageSlug
${onOffBanner}                  id=sfbMainBanner
${activePage}                   id=sfbStatus
${savePageButton}               id=pageSave
${cancelPageButton}             id=pageCancel
${confirmDialog}                jquery=.modal-title:contains('confirm')
${toolTipInfoIcon}              jquery=.tooltip-info
${toolTipInfo}                  jquery=.tooltip:contains('Page url cannot be changed')
