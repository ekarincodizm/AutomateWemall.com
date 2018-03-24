*** Variables ***
${Input_PropositionGroupName}    //*[@id="proposition_group_name"]
${Btn_CreateNewGroupProposition}    //*[contains(@class,"btn btn-default")]
${Input_GroupPropositionName}    //*[@id="txtName"]
${Input_GroupPropositionDesc}    //*[@id="txtDescription"]
${Btn_CreateGroupProposition}    //*[@value="Create"]
${Btn_Search}     //*[@value="Search"]
${Link_ProrositionMap}    //*[@id='tb-order']/tbody/tr[1]/td[2][contains(text(),"REPLACE_ME")]/../td[3]
${Btn_Save}       //*[@value="Save"]
${List_Proposition}    //*[@id="m-selectable"]
${Btn_Select}     //*[@class="multis-right"]
${Assert_PropositionMap}    ${EMPTY}
