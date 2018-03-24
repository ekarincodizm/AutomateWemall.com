*** Variables ***
${SS_MainForm}                  //*[@id="SScontainer"]
${SS_TopicList}                 //*[@id="SSdropdown"]
${SS_ContainerFooter}           //*[@id="SScontainerFoot"]
${SS_txt_email}                 //*[@id="SSemail"]
${SS_txt_order_id}              //*[@id="SSorderid"]
${SS_btn_submit_disabled}       //*[@id="SSbottom" and @disabled="disabled"]
${SS_btn_submit_enabled}        //*[@id="SSbottom"]


&{XPATH_LEVEL_D}   tab_bundle=//*[@id="bundle-tab"]
 ...   tab_mnp=//*[@id="mnp-device-tab"]