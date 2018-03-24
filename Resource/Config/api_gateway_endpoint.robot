*** Variables ***

&{STOREFRONT_API_URI}  storefront_detail=/css/v3/storefronts/^^STOREFRONT_ID^^/web?version=published
 ...   merchant_detail_by_id=/css/v3/shops/merchant_id/^^MERCHANT_CODE^^
 ...   merchant_detail_by_slug=/css/v3/shops/slug/^^SLUG^^
 ...   wrapper_merchant=/api/storefront?is_mobile=false&is_preview=false&merchant_code=^^MERCHANT_CODE^^
  # ...   wrapper_merchant=/api/storefront