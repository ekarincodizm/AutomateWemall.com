*** Variables ***
${Login_mainpage_locator}    //span[contains(@class, "text ng-binding ng")]
${Input_username_locator}    //*[@id="login_username"]
${Input_password_locator}    //*[@id="login_password"]
${Submit_login_locator}    //*[@id="btn_login"]
${FBloginBtn_LoginPage_locator}    //button[contains(@class, "btn btn-social-sign-in fill-fb-color")]
${Input_FBemail_locator}    //*[@id="email"]
${Input_FBpassword_locator}    //*[@id="pass"]
${FaceBook_Submitlogin_locator}    //*[@id="loginbutton"]
${FaceBook_Canclelogin_locator}    //*[@id="u_0_3"]
${Facebook_allowPermission_locator}    //*[@id="platformDialogForm"]/div[3]/div/table/tbody/tr/td[2]/button[2]
${Facebook_NotallowPermission_locator}    //*[@id="platformDialogForm"]/div[3]/div/table/tbody/tr/td[2]/button[1]
${Facebook_EditPermission_locator}    //*[@id="u_0_4"]
${Facebook_Uncheck_email_locator}    //div[contains(@class, "uiScrollableAreaGripper")]
${Header_displayname_locator}    //span[contains(@class, "text ng-binding ng-scope")]
${Top_banner_locator}   //div[contains(@class, "home__top_banner")]
${login_errorMessage_locator}   //*[@id="formLogin"]/table/tbody/tr[4]/td[2]/div[1]