*** Variables ***
${table_shop_list}          jquery=table.table-striped.table-hover
${column_shop_name}         ${table_shop_list} thead tr th:eq(0)
${column_content_status}       ${table_shop_list} thead tr th:eq(3)
${column_shop_status}            ${table_shop_list} thead tr th:eq(2)

${textbox_filter_shop_name}         jquery=div[id="shopFilter"] input
${textbox_filter_shop_content_status}       jquery=div[id="contentStatusFilter"] input
${textbox_filter_shop_status}       jquery=div[id="statusFilter"] input
${filter_shop_name}                 jquery=ul[id="ui-select-choices-0"]
${filter_shop_status}               jquery=ul[id="ui-select-choices-1"]
${filter_shop_content_status}               jquery=ul[id="ui-select-choices-2"]

${page_not_found}                    pageNotFound

${shop_id_status_inactive_content_status_draft}         big
${shop_id_status_inactive_content_status_waiting}       hulkslug
${shop_id_status_inactive_content_status_published}     asdfasdfffffff
${shop_id_status_inactive_content_status_modified}      asdfasdf
${shop_id_status_active_content_status_draft}           itruemart
${shop_id_status_active_content_status_waiting}         addidas
${shop_id_status_active_content_status_modified}        itruemart01
${shop_id_status_active_content_status_published}       efefefe