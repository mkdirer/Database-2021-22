
CREATE TABLE luke.Wykladowca (
                id_wykladowca INTEGER NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                CONSTRAINT wykladowca_pk PRIMARY KEY (id_wykladowca)
);


CREATE TABLE luke.Kurs_opis (
                id_kurs INTEGER NOT NULL,
                opis VARCHAR(200) NOT NULL,
                CONSTRAINT kurs_opis_pk PRIMARY KEY (id_kurs)
);


CREATE TABLE luke.Kurs (
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                id_kurs_nazwa INTEGER NOT NULL,
                termin VARCHAR NOT NULL,
                CONSTRAINT kurs_pk PRIMARY KEY (id_kurs, id_grupa)
);


CREATE TABLE luke.wykl_kurs (
                id_wykl INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL
);


CREATE TABLE luke.Uczestnik (
                id_uczestnik INTEGER NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                CONSTRAINT uczestnik_pk PRIMARY KEY (id_uczestnik)
);


CREATE TABLE luke.uczest_kurs (
                id_uczest INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL
);


ALTER TABLE luke.wykl_kurs ADD CONSTRAINT wykladowca_wykl_kurs_fk
FOREIGN KEY (id_wykl)
REFERENCES luke.Wykladowca (id_wykladowca)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE luke.Kurs ADD CONSTRAINT kurs_opis_kurs_fk
FOREIGN KEY (id_kurs)
REFERENCES luke.Kurs_opis (id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE luke.uczest_kurs ADD CONSTRAINT kurs_uczest_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES luke.Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE luke.wykl_kurs ADD CONSTRAINT kurs_wykl_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES luke.Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE luke.uczest_kurs ADD CONSTRAINT uczestnik_uczest_kurs_fk
FOREIGN KEY (id_uczest)
REFERENCES luke.Uczestnik (id_uczestnik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
