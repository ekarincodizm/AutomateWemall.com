*** Variables ***
&{MSG}    shipping_info_heading=รายละเอียดการจัดส่ง
 ...      shipping_info_content=สินค้ารายการนี้ดำเนินการจัดส่งโดยตัวแทนจำหน่าย หรือไปรษณีย์ไทย อาจส่งผลให้ระยะเวลาการจัดส่งแตกต่างไปจากที่กำหนดไว้
 ...      discount_tmvh=ลดค่าเครื่อง
 ...      new_tmvh_number=เมื่อเปิดเบอร์ใหม่
 ...      buy_with_package=เลือกซื้อพร้อมโปรโมชั่น
 ...      buy_with_package_en=Buy with Package
 ...      coupon_code_en=Coupon Code
  ...     coupon_code=ใส่โค้ดลดเพิ่ม

&{XPATH}    info_tab=//*[@href="#itm-product-details"]
 ...        search_box=//*[@ng-model="searchStr"]
 ...        search_button=//*[@class="btn-search icon-search"]
 ...        buy_with_package_button=//*[@id="btnProductBundleContainer"]/button
 ...        coupon_code_div=//*[@class="coupon-codes-li"]
