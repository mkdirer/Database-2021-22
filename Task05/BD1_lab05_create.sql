

ALTER TABLE ONLY "DB1lab01"."lab04"."kurs" ALTER COLUMN "id_nazwa" TYPE INTEGER, ALTER COLUMN "id_nazwa" SET NOT NULL;

CREATE TABLE "DB1lab01"."lab04"."organizacja" (
                "id_organizacja" INTEGER NOT NULL,
                "nazwa" VARCHAR(250) NOT NULL,
                "strona_www" VARCHAR(150) NOT NULL,
                CONSTRAINT "organizacja_pk" PRIMARY KEY ("id_organizacja")
);


CREATE TABLE "DB1lab01"."lab04"."uczestnik_organizacja" (
                "id_organizacja" INTEGER NOT NULL,
                "id_wykladowca" INTEGER,
                "id_uczestnik" INTEGER
);


ALTER TABLE "DB1lab01"."lab04"."uczestnik_organizacja" ADD CONSTRAINT "organizacja_uczestnik_organizacja_fk"
FOREIGN KEY ("id_organizacja")
REFERENCES "DB1lab01"."lab04"."organizacja" ("id_organizacja")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "DB1lab01"."lab04"."uczestnik_organizacja" ADD CONSTRAINT "uczestnik_uczestnik_organizacja_fk"
FOREIGN KEY ("id_uczestnik")
REFERENCES "DB1lab01"."lab04"."uczestnik" ("id_uczestnik")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "DB1lab01"."lab04"."uczestnik_organizacja" ADD CONSTRAINT "wykladowca_uczestnik_organizacja_fk"
FOREIGN KEY ("id_wykladowca")
REFERENCES "DB1lab01"."lab04"."wykladowca" ("id_wykladowca")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
