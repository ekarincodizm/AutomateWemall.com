*** Variables ***
${Checkout1_NextBtn}    //*[@id="btnNext"]
${Checkout1_InputEmail}    //*[@id="step1-username"]
${Checkout1_InputPassword}    //*[@id="password"]
${Checkout1_LoadingImg}    //*[@class="ajaxloading-widget-background"]
${Checkout1_RadioMember}    //*[@id="user1"]
&{XPATH_CHECKOUT_STEP1}    rdo_guest=logintype
 ...   rdo_member=logintype
 ...   rdo_guest_val=guest
 ...   rdo_member_val=user1
 ...   txt_username=//input[@id="step1-username"]
 ...   txt_password=//input[@id="password"]
 ...   btn_next=//*[@id="btnNext"]
 ...   lnk_full_cart=//a[@id="btn-edit-cart"]
 ...   container=//form[@id="form-checkout"]

${FBloginBtn_LoginPage_locator}    //button[contains(@class, "btn btn-social-sign-in fill-fb-color")]
${Checkout1_Login_ErrorMessage_Locator}    //div[contains(@class, "error_msg")]
