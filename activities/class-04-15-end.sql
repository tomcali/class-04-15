USE top5000_db;

DROP TABLE songs;

CREATE TABLE songs (
id INT(4) AUTO_INCREMENT NOT NULL,
artist VARCHAR(60) NOT NULL,
title VARCHAR(80) NOT NULL,
year INT(4),
popall DECIMAL(10,4),
popusa DECIMAL(10,4),
popuk DECIMAL(10,4),
popeurope DECIMAL(10,4),
popworld DECIMAL(10,4),
PRIMARY KEY(id));

-- https://dev.mysql.com/doc/refman/5.7/en/load-data.html --
-- THIS IS THE STRUCTURE FOR THE SQL STATEMENTS --
-- HERE WORKING WITH FILE WITHOUT HEADER ROWS --
LOAD DATA LOCAL INFILE  
"/Users/poweruser/Desktop/TopSongs.csv"
INTO TABLE songs  
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(id,artist,title,year,popall,popusa,popuk,popeurope,popworld);

-- SOME QUERIES TO TRY --
-- A query which returns all data for songs sung by a specific artist --
SELECT * FROM songs WHERE artist = 'Eminem';
SELECT * FROM songs WHERE artist = 'Blondie';
SELECT * FROM songs WHERE artist = 'Supertramp';

SELECT artist, COUNT(artist) as artist_count FROM songs GROUP BY artist;

SELECT artist, COUNT(artist) as artist_count FROM songs GROUP BY artist
  ORDER BY artist_count DESC;

DROP TABLE artist_count_table;

CREATE TEMPORARY TABLE artist_count_table  AS (    
    SELECT artist, COUNT(artist) as artist_count FROM songs GROUP BY artist
  ORDER BY artist_count DESC
)

-- A query which returns all artists who appear within the top 5000 more than once --
-- 783 of these artists --
SELECT COUNT(artist) FROM artist_count_table WHERE artist_count > 1; 
-- shows the names of the artists --
SELECT artist FROM artist_count_table WHERE artist_count > 1;

--  A query which searches for a specific song in the top 5000 --
SELECT * FROM songs WHERE title = 'The Logical Song';
SELECT * FROM songs WHERE title = 'The Logical Song' AND artist = 'Supertramp';

-- show the top ten artists in terms of number of songs --
SELECT * FROM artist_count_table LIMIT 10;

-- this is another way of setting things up --
-- GROUP BY artist HAVING COUNT(*) > 1 --


-- ALBUMS --
CREATE TABLE albums (
id INT(4) AUTO_INCREMENT NOT NULL,
artist VARCHAR(60) NOT NULL,
title VARCHAR(80) NOT NULL,
year INT(4),
popall DECIMAL(10,4),
popusa DECIMAL(10,4),
popuk DECIMAL(10,4),
popeurope DECIMAL(10,4),
popworld DECIMAL(10,4),
PRIMARY KEY(id));


-- THIS IS THE STRUCTURE FOR THE SQL STATEMENTS --
-- HERE WORKING WITH FILE WITHOUT HEADER ROWS --
LOAD DATA LOCAL INFILE  
"/Users/poweruser/Desktop/TopAlbums.csv"
INTO TABLE albums  
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(id,artist,title,year,popall,popusa,popuk,popeurope,popworld);


-- It is your task to take these two large sets of data --
-- and come up with a method to join them together in order --
-- to figure out if a given artist’s song and album made it --
-- into the charts at the time of their release. --

CREATE TEMPORARY TABLE album_table  AS (    
    SELECT id as album_id,
artist as album_artist,
title as album_title,
year as album_year,
popall as album_popall,
popusa as album_popusa,
popuk as album_popuk,
popeurope as album_popeurope,
popworld as album_popworld
FROM albums);










