
CREATE TABLE nowy.Wykadowca (
                id_wykadowca INTEGER NOT NULL,
                nazwisko VARCHAR,
                imie VARCHAR,
                CONSTRAINT wykadowca_pk PRIMARY KEY (id_wykadowca)
);


CREATE TABLE nowy.Kurs_opis (
                id_kurs INTEGER NOT NULL,
                opis VARCHAR NOT NULL,
                CONSTRAINT kurs_opis_pk PRIMARY KEY (id_kurs)
);


CREATE TABLE nowy.Kurs (
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                id_kurs_nazwa INTEGER NOT NULL,
                CONSTRAINT kurs_pk PRIMARY KEY (id_kurs, id_grupa)
);


CREATE TABLE nowy.wykl_kurs (
                id_wykadowca INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL
);


CREATE TABLE nowy.Uczestnik (
                id_uczestnik INTEGER NOT NULL,
                nazwisko VARCHAR,
                imie VARCHAR,
                CONSTRAINT uczestnik_pk PRIMARY KEY (id_uczestnik)
);


CREATE TABLE nowy.uczest_kurs (
                id_uczestnik INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL
);


ALTER TABLE nowy.wykl_kurs ADD CONSTRAINT wyk_adowca_wykl_kurs_fk
FOREIGN KEY (id_wykadowca)
REFERENCES nowy.Wykadowca (id_wykadowca)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE nowy.Kurs ADD CONSTRAINT kurs_opis_kurs_fk
FOREIGN KEY (id_kurs)
REFERENCES nowy.Kurs_opis (id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE nowy.uczest_kurs ADD CONSTRAINT kurs_uczest_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES nowy.Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE nowy.wykl_kurs ADD CONSTRAINT kurs_wykl_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES nowy.Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE nowy.uczest_kurs ADD CONSTRAINT uczestnik_uczest_kurs_fk
FOREIGN KEY (id_uczestnik)
REFERENCES nowy.Uczestnik (id_uczestnik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
