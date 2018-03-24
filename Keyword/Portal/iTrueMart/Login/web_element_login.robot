*** Variables ***
&{XPATH_LOGIN}    txt_username=//input[@id="login_username"]    txt_password=//input[@id="login_password"]    btn_login=jquery=#formLogin #btn_login
&{XPATH_LOGIN_MOBILE}    txt_username=//input[@id="username"]    txt_password=//input[@id="password"]    btn_login=//button[@data-id="login-submit"]
${Input_username}    //*[@id="login_username"]
${Input_password}    //*[@id="login_password"]
${Btn_login}      //*[@id="btn_login"]
${Btn_register}   //*[@id="btn-register-link"]
${img_loading}    //*[@class="ajaxloading-widget-icon-container ng-loading-icn"]
