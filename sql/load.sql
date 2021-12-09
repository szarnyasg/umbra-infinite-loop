create table person (
   p_personid bigint not null,
   p_firstname varchar not null,
   p_lastname varchar not null,
   p_gender varchar not null,
   p_birthday date not null,
   p_creationdate timestamp with time zone not null,
   p_locationip varchar not null,
   p_browserused varchar not null,
   p_placeid bigint not null
);

create table knows (
   k_person1id bigint not null,
   k_person2id bigint not null,
   k_creationdate timestamp with time zone not null
);

COPY person FROM 'PATHVAR/person_0_0.csv' WITH DELIMITER '|' CSV HEADER;

COPY knows (k_person1id, k_person2id, k_creationdate) FROM 'PATHVAR/person_knows_person_0_0.csv' WITH DELIMITER '|' CSV HEADER;
COPY knows (k_person2id, k_person1id, k_creationdate) FROM 'PATHVAR/person_knows_person_0_0.csv' WITH DELIMITER '|' CSV HEADER;
