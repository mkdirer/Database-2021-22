--1. Napisać wyzwalacz walidujący fname i lname w tabeli person, tylko litery, bez spacji i tabulatorów. W lname dopuszczalny znak - (myślnik, pauza).

CREATE OR REPLACE FUNCTION lab04.validate_person ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
    IF (LOWER(NEW.fname) ~ '^[a-z]*$' AND LOWER(NEW.lname) ~ '^[a-z]*$') THEN
		RETURN NEW;
    END IF;
	RAISE EXCEPTION 'Niepoprawne fname i/lub lname';
    END;
    $$;
	
CREATE TRIGGER validate_person
    AFTER INSERT OR UPDATE ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.validate_person(); 

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group) VALUES ('Kol', 'Jon', '$', '');

-- DROP TRIGGER group_count ON lab04.person;

--2. Napisać wyzwalacz normalizujący fname i lname w tabeli person, fname i skladowe lname ( przy podwójnym nazwisku) powinny zaczynać się od dużej litery, reszta małe. Usuwamy spacje.

CREATE OR REPLACE FUNCTION lab04.norma() RETURNS TRIGGER AS $$
BEGIN
	NEW.fname:=upper(substring(NEW.fname for 1))||lower(substring(NEW.fname from 2));
	NEW.lname:=upper(substring(NEW.lname for 1))||lower(substring(NEW.lname from 2));
  RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER normat 
    BEFORE INSERT OR UPDATE ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.norma();

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group) VALUES ('Kol', 'Jon', '$', '');

-- DROP TRIGGER normat ON lab04.person;

--3. Napisać wyzwalacz aktualizujący tabelę zawierającą liczbę wszystkich osób w danej grupie. Uwzględnić insert, delete i update.

CREATE OR REPLACE FUNCTION lab04.update ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
		IF (NEW.primary_group LIKE (SELECT pg.name FROM lab04.person_group pg WHERE pg.name LIKE NEW.primary_group)) THEN
			UPDATE lab04.person_group SET nc=nc+1 WHERE name LIKE NEW.primary_group;
		ELSE
			INSERT INTO lab04.person_group VALUES (NEW.primary_group, 1);
		END IF;
	RETURN NEW;
    END;
    $$;
	
CREATE TRIGGER count_group
	AFTER INSERT OR UPDATE ON lab04.person
	FOR EACH ROW EXECUTE PROCEDURE lab04.update();

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group) VALUES ('Kol', 'Jon', '$', '');

-- DROP TRIGGER count_group ON lab04.person;