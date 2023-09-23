/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INTEGER PRIMARY KEY  ,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(10,2)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

ALTER TABLE animals DROP column species;
CREATE TABLE species (
  id INTEGER PRIMARY KEY  ,
  name VARCHAR(255)
);
CREATE TABLE owners (
  id INTEGER PRIMARY KEY  ,
  full_name VARCHAR(255),
  age INTEGER
);
  ALTER TABLE animals ADD species_id int REFERENCES species(id);
  ALTER TABLE animals ADD owner_id int REFERENCES owners(id);
  
CREATE TABLE vets (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  age INT,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  id INTEGER PRIMARY KEY,
  vet_id INTEGER,
  species_id INTEGER,
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
  id INTEGER PRIMARY KEY,
  vet_id INTEGER,
  animal_id INTEGER,
  visit_date DATE,
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (animal_id) REFERENCES animals (id)
);