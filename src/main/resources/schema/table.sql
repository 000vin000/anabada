CREATE TABLE `alluser` (
  `userNo` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(20) NOT NULL,
  `userPw` varchar(255) NOT NULL,
  `userName` varchar(20) NOT NULL,
  `userNick` varchar(20) NOT NULL,
  `userAdd` varchar(255) NOT NULL,
  `userEmail` varchar(255) NOT NULL,
  `userPhone` varchar(20) NOT NULL,
  `userStatus` enum('active','deactive') NOT NULL DEFAULT 'active',
  `userDeactiveDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`userNo`),
  UNIQUE KEY `userId_UNIQUE` (`userId`),
  UNIQUE KEY `userNick_UNIQUE` (`userNick`),
  UNIQUE KEY `userEmail_UNIQUE` (`userEmail`),
  UNIQUE KEY `userPhone_UNIQUE` (`userPhone`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `answer` (
  `aNo` int NOT NULL AUTO_INCREMENT,
  `qNo` int NOT NULL,
  `userNo` int NOT NULL,
  `aContent` text NOT NULL,
  `aDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`aNo`),
  KEY `answer_ibfk_1_idx` (`qNo`),
  KEY `answer_ibfk_2_idx` (`userNo`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`qNo`) REFERENCES `question` (`qNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`userNo`) REFERENCES `alluser` (`userNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `bid` (
  `bidNo` int NOT NULL AUTO_INCREMENT,
  `itemNo` int NOT NULL,
  `userNo` int NOT NULL,
  `bidPrice` int NOT NULL,
  `bidTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bidNo`),
  UNIQUE KEY `uk1` (`itemNo`,`userNo`,`bidPrice`),
  KEY `userNo` (`userNo`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`itemNo`) REFERENCES `item` (`itemNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`userNo`) REFERENCES `alluser` (`userNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `buy` (
  `buyNo` int NOT NULL AUTO_INCREMENT,
  `itemNo` int NOT NULL,
  `userNo` int NOT NULL,
  `bidNo` int NOT NULL,
  PRIMARY KEY (`buyNo`),
  UNIQUE KEY `uk1` (`itemNo`,`userNo`) /*!80000 INVISIBLE */,
  KEY `buy_ibfk_2` (`userNo`) /*!80000 INVISIBLE */,
  KEY `buy_ibfk_3_idx` (`bidNo`),
  CONSTRAINT `buy_ibfk_1` FOREIGN KEY (`itemNo`) REFERENCES `item` (`itemNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `buy_ibfk_2` FOREIGN KEY (`userNo`) REFERENCES `alluser` (`userNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `buy_ibfk_3` FOREIGN KEY (`bidNo`) REFERENCES `bid` (`bidNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `favor` (
  `favorNo` int NOT NULL AUTO_INCREMENT,
  `itemNo` int NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`favorNo`),
  UNIQUE KEY `uk1` (`itemNo`,`userNo`),
  UNIQUE KEY `unique_user_item` (`userNo`,`itemNo`),
  KEY `userNo` (`userNo`),
  CONSTRAINT `favor_ibfk_1` FOREIGN KEY (`itemNo`) REFERENCES `item` (`itemNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favor_ibfk_2` FOREIGN KEY (`userNo`) REFERENCES `alluser` (`userNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `image` (
  `imageNo` int NOT NULL AUTO_INCREMENT,
  `itemNo` int NOT NULL,
  `imageFile` mediumblob NOT NULL,
  PRIMARY KEY (`imageNo`),
  KEY `image_ibfk_1_idx` (`itemNo`) /*!80000 INVISIBLE */,
  CONSTRAINT `image_ibfk_1` FOREIGN KEY (`itemNo`) REFERENCES `item` (`itemNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `item` (
  `itemNo` int NOT NULL AUTO_INCREMENT,
  `userNo` int NOT NULL,
  `itemGender` enum('m','w') NOT NULL,
  `itemCate` enum('top','bottom','outer','dress','etc','set') NOT NULL,
  `itemAuction` enum('waiting','bidding','sold','closed') NOT NULL,
  `itemStatus` enum('low','mid','high') NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `itemContent` varchar(255) DEFAULT NULL,
  `itemPrice` int NOT NULL,
  `itemStart` timestamp NOT NULL,
  `itemEnd` timestamp NOT NULL,
  PRIMARY KEY (`itemNo`),
  KEY `idx_item_status` (`itemEnd`,`itemAuction`),
  KEY `idx_item_start` (`itemStart`,`itemAuction`),
  KEY `fk_user_idx` (`userNo`),
  CONSTRAINT `fk_user` FOREIGN KEY (`userNo`) REFERENCES `alluser` (`userNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `question` (
  `qNo` int NOT NULL AUTO_INCREMENT,
  `itemNo` int NOT NULL,
  `userNo` int NOT NULL,
  `qTitle` varchar(255) NOT NULL,
  `qContent` text NOT NULL,
  `qDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`qNo`),
  KEY `question_ibfk_2_idx` (`userNo`),
  KEY `question_ibfk_1` (`itemNo`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`itemNo`) REFERENCES `item` (`itemNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`userNo`) REFERENCES `alluser` (`userNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
