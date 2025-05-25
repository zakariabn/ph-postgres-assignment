-- Active: 1747473278606@@127.0.0.1@5432@conservation_db

-- creating the database for wildlife sighting
CREATE DATABASE conservation_db;

-- ranger table
CREATE TABLE rangers(
  ranger_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(50) NOT NULL,
  region VARCHAR (50) NOT NULL DEFAULT 'not provided'
);

-- species table
CREATE TABLE species(
  species_id SERIAL PRIMARY KEY NOT NULL,
  common_name VARCHAR(50) UNIQUE NOT NULL,
  scientific_name VARCHAR (100) UNIQUE,
  discovery_date DATE,
  conservation_status VARCHAR(30)
);


--sightings table
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY NOT NULL,
  ranger_id INT REFERENCES rangers(ranger_id),
  species_id INT,
  sighting_time TIMESTAMP,
  "location" VARCHAR(30) NOT NULL,
  notes TEXT,  
  CONSTRAINT sightings_fk_species_id FOREIGN KEY (species_id) REFERENCES species(species_id) ON DELETE CASCADE
);


-- solution for the assignment

-- creating views for easy data access
CREATE VIEW ranger_with_sighting_info
AS (
SELECT 
  r.name,
  r.region,
  s.sighting_id,
  s.species_id,
  s.sighting_time,
  s.location 
FROM rangers r
left JOIN sightings s 
ON r.ranger_id = s.ranger_id
)

CREATE VIEW species_with_sight_info
AS (
  SELECT 
    sp.common_name,
    sp.discovery_date,
    sp.conservation_status,
    si.sighting_id,
    si.ranger_id,
    si.sighting_time,
    si.location,
    si.notes
FROM species sp
LEFT JOIN sightings si ON sp.species_id = si.species_id
);
--

-- problem 1
-- Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains' );


--problem 2
-- Count unique species ever sighted.
SELECT COUNT(species_id) AS unique_species_count
FROM sightings;


--problem 3
-- Find all sightings where the location includes "Pass"
SELECT * FROM sightings 
  WHERE "location" 
  ILIKE '%Pass%';


-- problem 4
-- List each ranger's name and their total number of sightings.
Select 
    "name", 
    COUNT(sighting_id) AS total_sightings 
  From ranger_with_sighting_info
  GROUP BY "name";


-- problem 5
-- List species that have never been sighted
SELECT *
  FROM species_with_sight_info
  WHERE sighting_id IS NULL;


--problem 6 
-- Show the most recent 2 sightings
SELECT * FROM sightings
  ORDER BY sighting_time DESC
  LIMIT 2


-- problem 7
-- Update all species discovered before year 1800 to have status 'Historic'
UPDATE species
  SET conservation_status = 'Historic'
  WHERE discovery_date < '1800-01-01';

-- problem 8
-- Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'
SELECT
  sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;


-- problem 9
-- Delete rangers who have never sighted any species
DELETE FROM rangers
WHERE NOT EXISTS (
    SELECT 1
    FROM sightings
    WHERE sightings.ranger_id = rangers.ranger_id
);

-- for checking problem 9
SELECT name, COUNT(sighting_id) as sighting_count  FROM ranger_with_sighting_info 
  GROUP BY name 
  HAVING COUNT(sighting_id) = 0;
