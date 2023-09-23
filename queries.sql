
/*Queries that provide answers to the questions from all projects.*/

/* all animals whose name ends in "mon" */
SELECT * FROM animals 
WHERE name LIKE '%mon';

/* name of all animals born between 2016 and 2019.*/
SELECT name FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals 
WHERE neutered = true AND escape_attempts < 3;

/* date of birth of all animals named either "Agumon" or "Pikachu".*/
SELECT date_of_birth FROM animals 
WHERE name IN ('Agumon', 'Pikachu');

/* name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name, escape_attempts FROM animals 
WHERE weight_kg > 10.5;

/* all animals that are neutered.*/
SELECT * FROM animals 
WHERE neutered = true;

/* all animals not named Gabumon*/
SELECT * FROM animals 
WHERE name <> 'Gabumon';

/* all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Inside a  delete all records in the animals table, then roll back*/
BEGIN ;
DELETE FROM animals;
ROLLBACK;

/*Verify changes*/
SELECT * FROM animals;

/*beigin */

BEGIN ;
/*Delete all animals born after Jan 1st, 2022*/
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the 
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET  weight_kg =  weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET  weight_kg =  weight_kg * -1
WHERE weight_kg < 0;

-- commit 
COMMIT;

-- How many animals are there
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals
SELECT neutered, SUM(escape_attempts) AS total_escapes
FROM animals
GROUP BY neutered
ORDER BY total_escapes DESC
LIMIT 1;



SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name, COUNT(*) as animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) as animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;