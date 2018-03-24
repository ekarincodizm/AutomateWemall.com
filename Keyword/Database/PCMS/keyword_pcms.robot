*** Settings ***
Library           DatabaseLibrary
Resource          ${CURDIR}../../../../Resource/Config/${ENV}/Env_config.robot
Resource          ${CURDIR}../../../../Resource/Config/${ENV}/database.robot
Resource          ../../Common/Keywords_Common.robot

*** Keywords ***
Obsolete Delete Campaign
    [Arguments]    ${Text_CampaignName}
    Connect DB ITM
    Execute Sql String    DELETE FROM promotion_code_logs WHERE promotion_code_logs.promotion_code_id = (SELECT promotion_codes.id FROM campaigns, promotions, promotion_codes WHERE campaigns.name = '${Text_CampaignName}' AND campaigns.id = promotions.campaign_id AND promotions.id = promotion_codes.promotion_id)
    Execute Sql String    DELETE FROM promotion_codes WHERE promotion_codes.promotion_id IN (SELECT promotions.id FROM campaigns, promotions WHERE campaigns.name = '${Text_CampaignName}' AND campaigns.id = promotions.campaign_id)
    Execute Sql String    DELETE FROM promotions WHERE promotions.campaign_id IN (SELECT campaigns.id FROM campaigns WHERE campaigns.name = '${Text_CampaignName}')
    Execute Sql String    DELETE FROM campaigns WHERE campaigns.name = '${Text_CampaignName}'

Remove Proposition Group Map
    [Arguments]    ${Text_GroupPropositionName}    ${Text_SubPropositionName}
    Connect DB ITM
    Execute Sql String    DELETE FROM `truemoveh_proposition_group_maps` WHERE `proposition_group_id` IN (SELECT id FROM `truemoveh_proposition_groups` where `name` = "${Text_GroupPropositionName}") AND `proposition_id` IN (SELECT id FROM `truemoveh_propositions` where `proposition_name` = "${Text_SubPropositionName}")

Remove Proposition Map
    [Arguments]    ${Text_SubPropositionName}    ${Text_PricePlanCode}
    Connect DB ITM
    Execute Sql String    DELETE FROM `truemoveh_proposition_maps` WHERE `proposition_id` IN (SELECT id FROM `truemoveh_propositions` where `proposition_name` = "${Text_SubPropositionName}") AND `price_plan_id` IN (SELECT id FROM `truemoveh_price_plans` WHERE `pp_code` = "${Text_PricePlanCode}")

Remove Device Proposition Group Map
    [Arguments]    ${Text_DeviceName}    ${Text_GroupPropositionName}
    Connect DB ITM
    Execute Sql String    DELETE FROM `truemoveh_device_proposition_group_maps` WHERE `device_id` IN (SELECT id FROM `truemoveh_device` where `name` like "%${Text_DeviceName}%") AND `group_id` IN (SELECT id FROM `truemoveh_proposition_groups` where `name` = "${Text_GroupPropositionName}")

Delete Proposition
    [Arguments]    ${Text_SubPropositionName}
    Connect DB ITM
    Execute Sql String    DELETE FROM `truemoveh_propositions` where `proposition_name` = "${Text_SubPropositionName}"

Delete Price Plan
    [Arguments]    ${Text_PricePlanCode}
    Connect DB ITM
    Execute Sql String    DELETE FROM `truemoveh_price_plans` WHERE `pp_code` = "${Text_PricePlanCode}"

Delete Proposition Group
    [Arguments]    ${Text_GroupPropositionName}
    Connect DB ITM
    Execute Sql String    DELETE FROM `truemoveh_proposition_groups` where `name` = "${Text_GroupPropositionName}"

Update to Full stock
    [Arguments]    ${SKU_ID}
    Connect DB ITM
    Execute Sql String    UPDATE stock_sums SET quantity = '9999' WHERE sku_id = "${SKU_ID}"

Update to Out of Stock
    [Arguments]    ${SKU_ID}
    Connect DB ITM
    Execute Sql String    UPDATE stock_sums SET quantity = '0' WHERE sku_id = "${SKU_ID}"

Delete Hold stock from DB by SKU
    [Arguments]    ${SKU_ID}
    Connect DB ITM
    Execute Sql String    delete from stock_holds where `sku_id` = '${SKU_ID}'

Delete Hold stock from DB by Order ID
    [Arguments]    ${ORDER_ID}
    Connect DB ITM
    Execute Sql String    delete from stock_holds where `order_id` = '${ORDER_ID}'

Update to specific stock number by SKUID
    [Arguments]    ${SKU_ID}    ${stock}
    Connect To Database    pymysql    pcms_db_prod    pcms_app    FDewe923l    pcmsdb-rw.itruemart-dev.com    3306
    Execute Sql String    UPDATE stock_sums SET quantity = '${stock}' WHERE sku_id = "${SKU_ID}"

Get pkey from DB by Product ID
    [Arguments]    ${ProductID}
    Connect DB ITM
    ${pkey}=    Query    SELECT pkey FROM `products` where `id`= '${ProductID}'
    log    ${pkey[0][0]}
    [Return]    ${pkey[0][0]}

Get Meterial ID frome DB by SKU ID
    [Arguments]    ${SKU_ID}
    Connect DB ITM
    ${MeterialID}=    Query    SELECT id FROM `imported_materials` where `inventory_id` = '${SKU_ID}'
    log    ${MeterialID[0][0]}
    [Return]    ${MeterialID[0][0]}

Get Variant ID from DB by SKU ID
    [Arguments]    ${SKU_ID}
    Connect DB ITM
    ${VariantID}=    Query    SELECT id FROM `variants` where `inventory_id` = '${SKU_ID}'
    log    ${VariantID[0][0]}
    [Return]    ${VariantID[0][0]}

Insert Image from S3 to Attachments Table
    [Arguments]    ${Img_ID_Original}    ${Img_Scale_Original}    ${Img_Path_Original}    ${Img_Name_Original}    ${Img_Location_Original}    ${Img_Size_Original}
    ...    ${Img_Mime_Original}    ${Img_Dimension_Original}    ${Img_ID_M}    ${Img_ID_Original}    ${Img_Scale_M}    ${Img_Path_M}
    ...    ${Img_Name_M}    ${Img_Location_M}    ${Img_Size_M}    ${Img_Mime_M}    ${Img_Dimension_M}    ${Img_ID_L}
    ...    ${Img_ID_Original}    ${Img_Scale_L}    ${Img_Path_L}    ${Img_Name_L}    ${Img_Location_L}    ${Img_Size_L}
    ...    ${Img_Mime_L}    ${Img_Dimension_L}    ${Img_ID_XL}    ${Img_ID_Original}    ${Img_Scale_XL}    ${Img_Path_XL}
    ...    ${Img_Name_XL}    ${Img_Location_XL}    ${Img_Size_XL}    ${Img_Mime_XL}    ${Img_Dimension_XL}    ${Img_ID_S}
    ...    ${Img_ID_Original}    ${Img_Scale_S}    ${Img_Path_S}    ${Img_Name_S}    ${Img_Location_S}    ${Img_Size_S}
    ...    ${Img_Mime_S}    ${Img_Dimension_S}    ${Img_ID_Square}    ${Img_ID_Original}    ${Img_Scale_Square}    ${Img_Path_Square}
    ...    ${Img_Name_Square}    ${Img_Location_Square}    ${Img_Size_Square}    ${Img_Mime_Square}    ${Img_Dimension_Square}
    Connect DB ITM
    #Image size Original
    Execute Sql String    INSERT INTO `attachments` (id, scale, path, name, location, size, mime, dimension, created_at) VALUES ('${Img_ID_Original}','${Img_Scale_Original}', '${Img_Path_Original}', '${Img_Name_Original}', '${Img_Location_Original}', '${Img_Size_Original}', '${Img_Mime_Original}', '${Img_Dimension_Original}', CURRENT_TIMESTAMP);
    #Image size M
    Execute Sql String    INSERT INTO `attachments` (id, master, scale, path, name, location, size, mime, dimension, created_at) VALUES ('${Img_ID_M}', '${Img_ID_Original}', '${Img_Scale_M}', '${Img_Path_M}', '${Img_Name_M}', '${Img_Location_M}', '${Img_Size_M}', '${Img_Mime_M}', '${Img_Dimension_M}', CURRENT_TIMESTAMP);
    #Image size L
    Execute Sql String    INSERT INTO `attachments` (id, master, scale, path, name, location, size, mime, dimension, created_at) VALUES ('${Img_ID_L}', '${Img_ID_Original}', '${Img_Scale_L}', '${Img_Path_L}', '${Img_Name_L}', '${Img_Location_L}', '${Img_Size_L}', '${Img_Mime_L}', '${Img_Dimension_L}', CURRENT_TIMESTAMP);
    #Image size XL
    Execute Sql String    INSERT INTO `attachments` (id, master, scale, path, name, location, size, mime, dimension, created_at) VALUES ('${Img_ID_XL}', '${Img_ID_Original}', '${Img_Scale_XL}', '${Img_Path_XL}', '${Img_Name_XL}', '${Img_Location_XL}', '${Img_Size_XL}', '${Img_Mime_XL}', '${Img_Dimension_XL}', CURRENT_TIMESTAMP);
    #Image size S
    Execute Sql String    INSERT INTO `attachments` (id, master, scale, path, name, location, size, mime, dimension, created_at) VALUES ('${Img_ID_S}', '${Img_ID_Original}', '${Img_Scale_S}', '${Img_Path_S}', '${Img_Name_S}', '${Img_Location_S}', '${Img_Size_S}', '${Img_Mime_S}', '${Img_Dimension_S}', CURRENT_TIMESTAMP);
    #Image size Square
    Execute Sql String    INSERT INTO `attachments` (id, master, scale, path, name, location, size, mime, dimension, created_at) VALUES ('${Img_ID_Square}', '${Img_ID_Original}', '${Img_Scale_Square}', '${Img_Path_Square}', '${Img_Name_Square}', '${Img_Location_Square}', '${Img_Size_Square}', '${Img_Mime_Square}', '${Img_Dimension_Square}', CURRENT_TIMESTAMP);

Insert Image from Attachment table to Media Contents Table
    [Arguments]    ${pkey}    ${ProductID}    ${Img_ID_Original}
    Connect DB ITM
    #Image size Original
    Execute Sql String    INSERT INTO `media_contents` (pkey, mediable_id, mediable_type, attachment_id) VALUES ('${pkey}', '${ProductID}', 'Product', '${Img_ID_Original}');

Obsolete delete customer address by email
    [Arguments]    ${Text_email}
    Connect DB ITM
    Execute Sql String    DELETE FROM customer_addresses WHERE customer_addresses.customer_ref_id in (SELECT members.sso_id FROM members WHERE members.email = '${Text_email}')
