*** Variables ***
&{MNP_INVALID}   thai_id_length_not_enough=889697149983
 ...  thai_id_with_special_character=8-9+97,49983a
 ...  thai_id_is_wrong_format=1192414558730
 ...  thai_id_exist=8896971499831
 ...  thai_id_is_max_allow=3473897579341
 ...  thai_id_is_collection=3779847594803
 ...  thai_id_is_fraud=2011112995087
 ...  thai_id_is_blacklist=3878959689588
 ...  mobile_length_not_enough=081234567
 ...  mobile_with_special_character=089-3+3,69
 ...  mobile_tmh=0812345679
 ...  mobile_tmh2=0864162479


&{MNP_VALID}  thai_id=7819984486711
 ...  mobile=0812345678
 ...  mobile_no_tmh=0879745772
 ...  mobile_no_tmh2=0879745772

&{VERIFY_SAMPLE_DATA}
 ...  cld_birth_year=1988
 ...  cld_birth_month=9
 ...  cld_birth_day=7


&{DATA_MNP}   VERIFY_SAMPLE_DATA=&{VERIFY_SAMPLE_DATA}  INVALID=&{MNP_INVALID}   VALID=&{MNP_VALID}