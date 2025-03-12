DELIMITER $$
CREATE TRIGGER `insert_buy` AFTER INSERT ON `bid` FOR EACH ROW
BEGIN
	IF NOT EXISTS (
        SELECT 1 FROM buy WHERE userNo = NEW.userNo AND itemNo = NEW.itemNo
    ) THEN
        INSERT INTO buy (itemNo, userNo, bidNo) VALUES (NEW.itemNo, NEW.userNo, NEW.bidNo);
    ELSE
        UPDATE buy SET bidNo = NEW.bidNo WHERE userNo = NEW.userNo AND itemNo = NEW.itemNo;
    END IF;
END$$

CREATE TRIGGER `confirm_beforeClosed` BEFORE UPDATE ON `item` FOR EACH ROW
BEGIN
	IF NEW.itemAuction = 'closed' AND
       (SELECT count(*) FROM bid WHERE itemNo = NEW.itemNo) > 0 THEN
        SET NEW.itemAuction = 'sold';
    END IF;
END$$
DELIMITER ;