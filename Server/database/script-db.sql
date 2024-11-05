-- Table structure for table `raspberries`
use serverdb;
DROP TABLE IF EXISTS `raspberries`;
CREATE TABLE IF NOT EXISTS `raspberries` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `mac_addr` VARCHAR(999) NOT NULL,
    `port` INT NOT NULL,
    `last_seen` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `ssh_key` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

COMMIT;