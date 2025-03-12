DELIMITER $$
CREATE EVENT start_item
ON SCHEDULE EVERY 1 MINUTE
STARTS TIMESTAMP(CURRENT_DATE, '00:00:00')
DO
BEGIN
    UPDATE item
    SET itemAuction = 'bidding'
    WHERE itemAuction = 'waiting' AND itemStart <= NOW();
END$$

CREATE EVENT close_item
ON SCHEDULE EVERY 1 MINUTE
STARTS TIMESTAMP(CURRENT_DATE, '00:00:00')
DO
BEGIN
    UPDATE item
    SET itemAuction = 'closed'
    WHERE itemAuction = 'bidding' AND itemEnd <= NOW();
END$$

ALTER EVENT delete_deactivated_users
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '00:00:00')
DO
BEGIN
    DELETE FROM alluser
    WHERE userStatus = 'deactive' 
    AND userDeactiveDate <= NOW() - INTERVAL 7 DAY;
END$$
DELIMITER ;