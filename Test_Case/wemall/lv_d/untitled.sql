-- Update order_shipment_items
UPDATE `order_shipment_items` SET `item_status` = 'order_pending', `payment_status` = 'success' WHERE `order_id` = 2030749;

-- Update stock_holds
UPDATE `stock_holds` SET `status` = 'permanent' WHERE `order_id` = 2030749;