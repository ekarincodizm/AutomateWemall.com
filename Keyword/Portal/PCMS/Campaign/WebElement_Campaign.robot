*** Variables ***
${Camp_activate}    //*[@value="activate"]
${Camp_Input_CampaignName}    //*[@id="campaign_name"]
${Camp_Input_note}    //*[@name="note"]
${Camp_start_datepicker}    //*[@id="start_datepicker"]
${Camp_Datepicker_Done}    //button[contains(text(),'Done')]
${Camp_end_datepicker}    //*[@id="end_datepicker"]
${Camp_Next_datepicker}    //*[@class="ui-datepicker-next ui-corner-all"]
${Camp_Date_datepicker}    //*[@class="ui-datepicker-calendar"]//a[contains(text(),'17')]
${Camp_Save}      //*[@value="Save"]
${Camp_Filter}    //*[@id='DataTables_Table_0_filter']/label/input
${Camp_Table_Selected_Campaign}    //*[contains(@class,'mws-datatable-fn')]//tbody//tr/td[1][contains(text(),'REPLACE_ME')]/../td[7]/div/a[1]
