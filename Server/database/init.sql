-- Table structure for table raspberries
USE serverdb;

DROP TABLE IF EXISTS `raspberries`;
CREATE TABLE IF NOT EXISTS `raspberries` (
    `id` VARCHAR(26) NOT NULL,
    `mac_addr` VARCHAR(999) NOT NULL,
    `port` INT,
    `last_seen` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ssh_key` VARCHAR(255),
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `sessions` (
    `id` BLOB(100) NOT NULL,
    `payload` BLOB(1024) NOT NULL,
    PRIMARY KEY (`id`)
);