CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `mp2`@`%` 
    SQL SECURITY DEFINER
VIEW `buylist` AS
    SELECT 
        `buy`.`userNo` AS `userNo`,
        `buy`.`itemNo` AS `itemNo`,
        `item`.`itemName` AS `itemName`,
        (SELECT 
                `image`.`imageFile`
            FROM
                `image`
            WHERE
                (`buy`.`itemNo` = `image`.`itemNo`)
            LIMIT 1) AS `imageFile`,
        `item`.`itemAuction` AS `itemAuction`,
        `bid`.`bidPrice` AS `bidPrice`,
        `item`.`itemPrice` AS `itemPrice`,
        `bid`.`bidTime` AS `bidTime`,
        `item`.`itemEnd` AS `itemEnd`
    FROM
        ((`buy`
        JOIN `item`)
        JOIN `bid`)
    WHERE
        ((`buy`.`itemNo` = `item`.`itemNo`)
            AND (`buy`.`bidNo` = `bid`.`bidNo`));

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `mp2`@`%` 
    SQL SECURITY DEFINER
VIEW `iteminclude` AS
    SELECT 
        `i`.`itemNo` AS `itemNo`,
        `i`.`userNo` AS `userNo`,
        `i`.`itemGender` AS `itemGender`,
        `i`.`itemCate` AS `itemCate`,
        `i`.`itemAuction` AS `itemAuction`,
        `i`.`itemStatus` AS `itemStatus`,
        `i`.`itemName` AS `itemName`,
        `i`.`itemContent` AS `itemContent`,
        `i`.`itemPrice` AS `itemPrice`,
        `i`.`itemStart` AS `itemStart`,
        `i`.`itemEnd` AS `itemEnd`,
        `u`.`userNick` AS `userNick`,
        COUNT(`b`.`itemNo`) AS `bidCount`
    FROM
        ((`item` `i`
        LEFT JOIN `user` `u` ON ((`i`.`userNo` = `u`.`userNo`)))
        LEFT JOIN `bid` `b` ON ((`i`.`itemNo` = `b`.`itemNo`)))
    WHERE
        (`i`.`itemAuction` IN ('bidding' , 'waiting'))
    GROUP BY `i`.`itemNo` , `u`.`userNick`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `mp2`@`%` 
    SQL SECURITY DEFINER
VIEW `user` AS
    SELECT 
        `alluser`.`userNo` AS `userNo`,
        `alluser`.`userId` AS `userId`,
        `alluser`.`userPw` AS `userPw`,
        `alluser`.`userName` AS `userName`,
        `alluser`.`userNick` AS `userNick`,
        `alluser`.`userAdd` AS `userAdd`,
        `alluser`.`userEmail` AS `userEmail`,
        `alluser`.`userPhone` AS `userPhone`
    FROM
        `alluser`
    WHERE
        (`alluser`.`userStatus` = 'active');
