*** Variables ***
${Checkout1_NextBtn_Mobile}    //*[@id="btnNext"]
${Checkout1_InputEmail_Mobile}    //*[@id="username"]
${Checkout1_InputPassword_Mobile}    //*[@id="password"]
${Checkout1_LoadingImg}    //*[@class="ajaxloading-widget-background"]
${Checkout1_RadioMember}    //*[@id="user1"]
&{XPATH_CHECKOUT_STEP1_MOBILE}    rdo_guest=logintype
 ...   rdo_member=logintype
 ...   rdo_guest_val=guest
 ...   rdo_member_val=user1
 ...   txt_username=//input[@id="username"]
 ...   txt_password=//input[@id="password"]
 ...   btn_next=//*[@id="btnNext"]
 ...   lnk_full_cart=//a[@id="btn-edit-cart"]
 ...   container=//form[@id="form-checkout"]

${FBloginBtn_LoginPage_locator}    //button[contains(@class, "btn btn-social-sign-in fill-fb-color")]
