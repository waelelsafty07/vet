/* Populate database with sample data. */

INSERT INTO animals 
VALUES (DEFAULT, 'Agumon', '2020-02-03', 0, true, 10.23),
       (DEFAULT, 'Gabumon', '2018-11-15', 2, true, 8.0),
       (DEFAULT, 'Pikachu', '2021-01-07', 1, false, 15.04),
       (DEFAULT, 'Devimon', '2017-05-12', 5, true, 11.0);

/* Insert new animals into the table */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES 
('Charmander', '2020-02-08', -11, false, 0),
('Plantmon', '2021-11-15', -5.7, true, 2),
('Squirtle', '1993-04-02', -12.13, false, 3),
('Angemon', '2005-06-12', -45, true, 1),
('Boarmon', '2005-06-07', 20.4, true, 7),
('Blossom', '1998-10-13', 17, true, 3),
('Ditto', '2022-05-14', 22, true, 4);


-- Insert data into the owners table
INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

-- Update animals table with species_id and owner_id
UPDATE animals
SET species_id = CASE
  WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
  ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END,
owner_id = CASE
  WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
  WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END
WHERE species_id IS NULL AND owner_id IS NULL;