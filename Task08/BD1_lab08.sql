
CREATE SEQUENCE lab04.person_person_id_seq;

CREATE TABLE lab04.person (
                person_id INTEGER NOT NULL DEFAULT nextval('lab04.person_person_id_seq'),
                fname VARCHAR(20) NOT NULL,
                lname VARCHAR(20) NOT NULL,
                primary_group CHAR(1) NOT NULL,
                secondary_group CHAR(2) NOT NULL,
                CONSTRAINT person_pk PRIMARY KEY (person_id)
);


ALTER SEQUENCE lab04.person_person_id_seq OWNED BY lab04.person.person_id;


CREATE TABLE lab04.lab04_log (
    table_name varchar(20) not null,
    operation varchar,
    newrecord text,
    tgname text,
    tgwhen text,
    tglevel text,
    time_at timestamp not null default now(),
    userid name not null default session_user
);
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA lab04 TO andlem;

-- Funkcja zapisujaca operacje do tabeli lab04_log
CREATE OR REPLACE FUNCTION lab04.write_to_log ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
 
    INSERT INTO lab04.lab04_log (table_name, operation, newrecord, tgname, tgwhen, tglevel) 
        VALUES (TG_TABLE_NAME, TG_OP, NEW::text, TG_NAME, TG_WHEN, TG_LEVEL);
     RETURN NEW;                                                          
    END;
    $$;
  
  
  -- Wyzwalacz monitorujacy dzialania na tabeli person 
CREATE TRIGGER person_log 
    AFTER INSERT OR UPDATE OR DELETE ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.write_to_log();   
    
  
     
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Lem', 'And', 'P', 'WY' ); 
SELECT * FROM lab04.person;
SELECT * FROM lab04.lab04_log;


-- poprawiona
CREATE OR REPLACE FUNCTION write_to_log ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN                                                                                  
		    INSERT INTO lab04_log (table_name, operation, newrecord, tgname, tgwhen, tglevel)
	        VALUES (TG_TABLE_NAME, TG_OP, NEW::text, TG_NAME, TG_WHEN, TG_LEVEL);
            RETURN NEW;
    	ELSIF TG_OP = 'UPDATE' THEN
  		    INSERT INTO lab04_log (table_name, operation, newrecord, tgname, tgwhen, tglevel)
	        VALUES (TG_TABLE_NAME, TG_OP, NEW::text, TG_NAME, TG_WHEN, TG_LEVEL);
   		    INSERT INTO lab04_log (table_name, operation, newrecord, tgname, tgwhen, tglevel)
	        VALUES (TG_TABLE_NAME, TG_OP, OLD::text, TG_NAME, TG_WHEN, TG_LEVEL);
	      RETURN NEW;                                                                                             
    	ELSIF TG_OP = 'DELETE' THEN 
   		    INSERT INTO lab04_log (table_name, operation, newrecord, tgname, tgwhen, tglevel)
	        VALUES (TG_TABLE_NAME, TG_OP, OLD::text, TG_NAME, TG_WHEN, TG_LEVEL);
	      RETURN NULL;                                                                                            
    	END IF;
    END;
    $$;
  
  
--DROP TRIGGER person_log ON lab04.person;
--DROP FUNCTION lab04.write_to_log ();

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Dyd', 'Ant', 'P', 'WY' ); 
UPDATE lab04.person SET primary_group = 'S' WHERE fname = 'Ant' AND lname = 'Dyd';

--DELETE FROM person_data WHERE id = (SELECT person_id FROM person WHERE fname = 'Ant' AND lname = 'Dyd');
DELETE FROM lab04.person WHERE fname = 'Ant' AND lname = 'Dyd';

SELECT * FROM lab04.lab04_log;
 
--


-- Funkcja sprawdzajaca poprawnosc wprowadzonych danych i wyzwalacz dla tabeli person
CREATE OR REPLACE FUNCTION lab04.validate_input ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
    IF LENGTH(TRIM(NEW.secondary_group)) = 0 OR (NEW.primary_group != 'P' AND NEW.primary_group != 'S') THEN
        RAISE EXCEPTION 'Niepoprawne wartości primary i/lub secondary group.';
    END IF;
  
    RETURN NEW;                                                          
    END;
    $$;


CREATE TRIGGER person_valid 
    AFTER INSERT OR UPDATE OR DELETE ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.validate_input(); 

CREATE TRIGGER person_valid 
    AFTER INSERT OR UPDATE ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.validate_input(); 

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Dyd', 'Ant', 'P', 'WY' ); -- 'Q', '', NULL
SELECT * FROM lab04.person;
UPDATE lab04.person SET primary_group = 'A' WHERE fname = 'Ant' AND lname = 'Dyd';
DELETE FROM lab04.person WHERE fname = 'Ant' AND lname = 'Dyd'; 
----

-- Funkcja normalizujaca wprowadzone dane do bazy danych  
CREATE OR REPLACE FUNCTION lab04.normalizuj_data () RETURNS TRIGGER AS $$
BEGIN
	IF LENGTH(TRIM(NEW.secondary_group)) = 0 THEN
        RAISE EXCEPTION 'Brak wartości secondary group.';
    END IF;
     NEW.primary_group := upper(NEW.primary_group);
     NEW.secondary_group := upper(NEW.secondary_group);
  RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


-- Przypisanie wyzwalacza do tabeli person
CREATE TRIGGER person_normalizuj
  BEFORE INSERT OR UPDATE ON lab04.person
  FOR EACH ROW
  EXECUTE PROCEDURE lab04.normalizuj_data();
 

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Mic', 'Jan', 'S', '' );  
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Mic', 'Jan', 'A', 'Wy' );  
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Mic', 'Jan', 's', 'wy' );
SELECT * FROM lab04.person;

-------

-- Testowanie danych na podstawie informacji z innych tabel

CREATE TABLE lab04.person_group ( name varchar(20), nc int ) ;  
INSERT INTO lab04.person_group VALUES ( 'DB', 2), ( 'C+', 3 ), ( 'PY', 4 ) ;


CREATE OR REPLACE FUNCTION lab04.group_count() RETURNS TRIGGER AS $$
    BEGIN
        IF EXISTS(SELECT 1 FROM lab04.person_group WHERE name = New.secondary_group 
           and nc > (SELECT count(*) FROM lab04.person WHERE secondary_group = New.secondary_group )) THEN
            
            RETURN NEW;
        ELSE
            RETURN NULL;
        END IF;
    END;
$$ LANGUAGE 'plpgsql';  

CREATE TRIGGER person_test_insert 
    BEFORE INSERT OR UPDATE ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.group_count();  
    
    
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES 
	( 'Bab', 'Ada', 'S', 'DB'), 
    ( 'Cab', 'Kry', 'S', 'DB'), 
    ( 'Dob', 'Jan', 'S', 'DB'),
    ( 'Ewe', 'Aga', 'S', 'DB');     

SELECT * FROM lab04.person;
    
DROP TRIGGER person_test_insert ON lab04.person;   
---------------

-- Wprowadzanie danych do tabel powiązanych.

CREATE TABLE lab04.person_data ( id int, city varchar(30), email varchar(30), telefon varchar(15) );
ALTER TABLE lab04.person_data ADD PRIMARY KEY (id);
INSERT INTO lab04.person_data (id) SELECT person_id FROM lab04.person;
ALTER TABLE lab04.person_data ADD FOREIGN KEY (id) REFERENCES lab04.person(person_id);

--
CREATE OR REPLACE FUNCTION lab04.insert_data () RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO lab04.person_data (id) VALUES (New.person_id) ;
  RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--

CREATE TRIGGER person_insert
    AFTER INSERT ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.insert_data();

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Bie', 'Zyg', 'S', 'C+' ); 

SELECT * FROM lab04.person;
SELECT * FROM lab04.person_data;
SELECT * FROM lab04.lab04_log;

DROP TABLE lab04.person_data;

------------------------------------

create view lab04.person_view AS 
SELECT p.person_id,p.fname,p.lname,p.primary_group, p.secondary_group, pd.city,pd.email,pd.telefon 
FROM (lab04.person p JOIN lab04.person_data pd ON pd.id = p.person_id) ;

SELECT * FROM lab04.person_view;

CREATE OR REPLACE FUNCTION lab04.person_view_dml () RETURNS TRIGGER AS $$
	DECLARE last_id INTEGER;
   BEGIN                                                                                                      
    IF TG_OP = 'INSERT' THEN                                                                                  
      INSERT INTO  lab04.person (fname, lname, primary_group, secondary_group) 
      VALUES (NEW.fname,NEW.lname, NEW.primary_group, NEW.secondary_group)
      RETURNING person_id INTO last_id;
--      SELECT currval(pg_get_serial_sequence('person','person_id')) INTO last_id;
      INSERT INTO lab04.person_data VALUES(last_id, NEW.city, NEW.email, NEW.telefon);
      RETURN NEW;                                                                                             
    ELSIF TG_OP = 'UPDATE' THEN                                                                               
      UPDATE lab04.person SET fname=NEW.fname, lname=NEW.lname WHERE person_id=OLD.person_id;                   
      UPDATE lab04.person_data SET id=NEW.person_id, city=NEW.city, email=NEW.email, telefon=NEW.telefon WHERE id=OLD.person_id;
      RETURN NEW;                                                                                             
    ELSIF TG_OP = 'DELETE' THEN                                                                               
      DELETE FROM lab04.person WHERE person_id=OLD.person_id;                                                                     
      DELETE FROM lab04.person_data WHERE id=OLD.person_id;                                                                
      RETURN NULL;                                                                                            
    END IF;                                                                                                   
    RETURN NEW;                                                                                               
  END; 
$$ LANGUAGE 'plpgsql';

--DROP TRIGGER person_v_dml_trig ON lab04.person_v;

CREATE TRIGGER person_v_dml_trig  
    INSTEAD OF INSERT OR UPDATE OR DELETE ON lab04.person_view
    FOR EACH ROW EXECUTE PROCEDURE lab04.person_view_dml(); 
    
UPDATE lab04.person_view SET city = 'Cracow' WHERE person_id = 12;

INSERT INTO lab04.person_view ( fname, lname, primary_group, secondary_group, city, email, telefon )
VALUES ( 'Maz', 'Kam', 's', 'py', 'Wrocław', 'maz.kam@agh.edu.pl', NULL)

INSERT INTO lab04.person_view ( fname, lname, primary_group, secondary_group, city, email, telefon )
VALUES ( 'Nal', 'Zyg', 'S', 'PY', 'Gdańsk', 'nal.zyg@agh.edu.pl', NULL) 
   
  
--    DROP TRIGGER person_view_dml_trig ON lab04.person_v;
--    DROP FUNCTION  lab04.person_view_dml ();


