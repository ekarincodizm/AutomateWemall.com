*** Keywords ***
Update Customer Info - Login and Clear Cart
    User Login From login page          ${username_login}           ${password_login}
    Clear Cart Current User

Update Customer Info - Add To Cart and Checkout
    Go To Cart Page
    Wait For Cart Loading
    Wait Until Element Is Visible           //*[@class="cart-item"]             30s
    Go To Checkout 2
    User Click First Member Address

Update Customer Info - Pay Failed
    Update Customer Info - Add To Cart and Checkout
    Display All CCW Information
    User Enter Valid Card Holder Name
    User Enter Invalid Credit Card Number
    User Enter Valid CVC
    User Select Valid Card Expired
    Sleep               5s
    User Click Submit Button On Checkout3
    Sleep               5s
    Display Confirm Payment Popup
    Sleep               5s
    User Click Confirm Payment Button On Checkout3
#    Sleep               15s
#    Confirm Action

Update Customer Info - Pay Success
    Update Customer Info - Add To Cart and Checkout
    Display All CCW Information
    User Enter Valid Card Holder Name
    Checkout 3 - User Enter Valid Credit Card Number As Master Card
    User Enter Valid CVC
    User Select Valid Card Expired
    Sleep               5s
    User Click Submit Button On Checkout3
    Sleep               5s
    Display Confirm Payment Popup
    Sleep               5s
    User Click Confirm Payment Button On Checkout3
#    Sleep               15s
#    Confirm Action

Update Customer Info - Get Order Id
    ${pcms_order_id}=           Thankyou - Get Order ID II
    Set Test Variable           ${var_update_customer_info_pcms_order_id}       ${pcms_order_id}

Update Customer Info - Update Customer Address on Pcms
    Login Pcms
    Order Detail - Go to Order Detail Page              ${var_update_customer_info_pcms_order_id}
    Order Detail - Input Customer Address               ${var_update_customer_info_pcms_order_id}           test_customer_bp
    Order Detail - Save Customer Info

Update Customer Info - Expect Not found TMH Number Available on web [Sim Only]
    Sleep               5s
    TruemoveH - Get Mobile Number Hold By Customer              ${var_tmh_sim_mobile}      ${TV_user_id}
    TruemoveH Common - Check hold expired date is 100Years      ${var_tmh_mobile_hold_expired_date}

Update Customer Info - Expect Not found TMH Number Available on web [Bundle]
    Sleep               5s
    TruemoveH - Get Mobile Number Hold By Customer                  ${var_data_mobile_number}           ${TV_user_id}
    TruemoveH Common - Check hold expired date is 100Years          ${var_tmh_mobile_hold_expired_date}

Update Customer Info - Hold Cancel [Sim]
    TruemoveH Sim - Hold Cancel Mobile Number           ${var_tmh_sim_mobile_id}       ${TV_user_id}       ${var_random_id_card}

Update Customer Info - Hold Cancel [Bndle]
    TruemoveH Sim - Hold Cancel Mobile Number           ${var_data_mobile_id}       ${TV_user_id}       ${var_random_id_card}

Update Customer Info - Delete Promotion Bundle on Camp
    Delete Promotion Bundle On Camp                     ${var_camp_bundle_prodmotion_id}


