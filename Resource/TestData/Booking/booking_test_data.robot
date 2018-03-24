*** Variables ***
&{BOOKING_PREORDER_VALID}  person_id=7603327955028
 ...  firstname=Robot
 ...  lastname=Booking
 ...  customer_tel=0837333396
 ...  customer_email=blackpantherautomate@gmail.com
 ...  customer_address_no=111 Robot Test
 ...  customer_address_moo=1
 ...  customer_address_village=Village Robot
 ...  customer_address_floor=Floor 5 Robot Room
 ...  customer_address_soi=Robot Soi
 ...  customer_address_road=Robot Road
 ...  customer_province_id=1
 ...  customer_city_id=2
 ...  customer_district_id=13
 ...  customer_postcode=10300
 ...  customer_billing_no=222
 ...  customer_billing_moo=2
 ...  customer_billing_village=Billing Village Robot
 ...  customer_billing_floor=Billing Floor Robot
 ...  customer_billing_soi=Billing Soi Robot
 ...  customer_billing_road=Billing Road Robot
 ...  billing_province_id=29
 ...  billing_city_id=363
 ...  billing_district_id=2901
 ...  billing_postcode=40000
 ...  capacity=1
 ...  color=1
...  inventory_id=APAAA1116211
#...  inventory_id=APAAA1116311
#...  inventory_id=APAAA1116611

&{BOOKING_PAYMENT_CCW}    valid_card_holder_name=Robot Automate
 ...   valid_credit_card_number=5555555555554444
 ...   valid_cvc=123
 ...   invalid_credit_card_number=5555555555554445

&{BOOKING_DATA_TH}    deposit=5,340.00

&{BOOKING_DATA_EN}    deposit=5,340.00

&{BOOKING_TRANS_TH}    number_type=พร้อมเบอร์สวย
 ...   bath=บาท
 ...   out_of_stock_title=สินค้าหมดชั่วคราว
 ...   out_of_stock_desc=ทางเราต้องขออภัยอย่างสูงค่ะ เพราะขณะนี้สินค้าที่คุณต้องการมีลูกค้าหลายท่านสนใจ และชิ้นสุดท้ายเพิ่งถูกซื้อไป
 ...   wrong_title=ระบบเกิดข้อผิดพลาด
 ...   wrong_desc=เกิดความผิดพลาดทางระบบ กรุณาลองใหม่อีกครั้ง ทางเราต้องขออภัยอย่างสูงค่ะ

&{BOOKING_TRANS_EN}    number_type=with nice number package
 ...   bath=Baht
 ...   out_of_stock_title=Temporarily Out of Stock
 ...   out_of_stock_desc=We apologise for any inconvenience this may cause you. Because there are many customers who seem to be actively looking for this item and the last item just sold.
 ...   wrong_title=Something went wrong.
 ...   wrong_desc=Something went wrong, Please try again. Sorry for the inconvenience.

