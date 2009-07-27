-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Mon Jul 27 20:14:02 2009
-- 


BEGIN TRANSACTION;

--
-- Table: aspects
--
DROP TABLE aspects;

CREATE TABLE aspects (
  aspect_id INTEGER PRIMARY KEY NOT NULL,
  aspect text NOT NULL
);

CREATE UNIQUE INDEX aspects_aspect ON aspects (aspect);

--
-- Table: items
--
DROP TABLE items;

CREATE TABLE items (
  item_id INTEGER PRIMARY KEY NOT NULL,
  name text NOT NULL
);

CREATE UNIQUE INDEX items_name ON items (name);

--
-- Table: tags
--
DROP TABLE tags;

CREATE TABLE tags (
  tag_id INTEGER PRIMARY KEY NOT NULL,
  tag text NOT NULL
);

CREATE UNIQUE INDEX tags_tag ON tags (tag);

--
-- Table: item_aspect_bridges
--
DROP TABLE item_aspect_bridges;

CREATE TABLE item_aspect_bridges (
  item_id integer NOT NULL,
  aspect_id integer NOT NULL,
  PRIMARY KEY (item_id, aspect_id)
);

CREATE INDEX item_aspect_bridges_idx_aspect_id ON item_aspect_bridges (aspect_id);

CREATE INDEX item_aspect_bridges_idx_item_id ON item_aspect_bridges (item_id);

--
-- Table: item_tag_bridges
--
DROP TABLE item_tag_bridges;

CREATE TABLE item_tag_bridges (
  item_id integer NOT NULL,
  tag_id integer NOT NULL,
  PRIMARY KEY (item_id, tag_id)
);

CREATE INDEX item_tag_bridges_idx_item_id ON item_tag_bridges (item_id);

CREATE INDEX item_tag_bridges_idx_tag_id ON item_tag_bridges (tag_id);

COMMIT;
