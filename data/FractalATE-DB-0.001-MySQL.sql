-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Mon Jul 27 20:14:02 2009
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS `aspects`;

--
-- Table: `aspects`
--
CREATE TABLE `aspects` (
  `aspect_id` integer NOT NULL auto_increment,
  `aspect` text NOT NULL,
  PRIMARY KEY (`aspect_id`),
  UNIQUE `aspects_aspect` (`aspect`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `items`;

--
-- Table: `items`
--
CREATE TABLE `items` (
  `item_id` integer NOT NULL auto_increment,
  `name` text NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE `items_name` (`name`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `tags`;

--
-- Table: `tags`
--
CREATE TABLE `tags` (
  `tag_id` integer NOT NULL auto_increment,
  `tag` text NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE `tags_tag` (`tag`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `item_aspect_bridges`;

--
-- Table: `item_aspect_bridges`
--
CREATE TABLE `item_aspect_bridges` (
  `item_id` integer NOT NULL,
  `aspect_id` integer NOT NULL,
  INDEX item_aspect_bridges_idx_aspect_id (`aspect_id`),
  INDEX item_aspect_bridges_idx_item_id (`item_id`),
  PRIMARY KEY (`item_id`, `aspect_id`),
  CONSTRAINT `item_aspect_bridges_fk_aspect_id` FOREIGN KEY (`aspect_id`) REFERENCES `aspects` (`aspect_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `item_aspect_bridges_fk_item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `item_tag_bridges`;

--
-- Table: `item_tag_bridges`
--
CREATE TABLE `item_tag_bridges` (
  `item_id` integer NOT NULL,
  `tag_id` integer NOT NULL,
  INDEX item_tag_bridges_idx_item_id (`item_id`),
  INDEX item_tag_bridges_idx_tag_id (`tag_id`),
  PRIMARY KEY (`item_id`, `tag_id`),
  CONSTRAINT `item_tag_bridges_fk_item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `item_tag_bridges_fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks=1;

