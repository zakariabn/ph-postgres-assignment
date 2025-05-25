
-- if we need to change on delete or on remove constrain 

ALTER TABLE sightings
DROP CONSTRAINT sightings_fk_species_id;

-- Step 2: Add the foreign key constraint with the new delete rule
ALTER TABLE sightings
ADD CONSTRAINT sightings_fk_species_id FOREIGN KEY (species_id)
REFERENCES species(species_id)
ON DELETE CASCADE;