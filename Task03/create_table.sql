--SET SEARCH_PATH TO lab01 ;
--GRANT USAGE ON SCHEMA lab01 TO andlem;
--create table lab01.uczestnik ( id_uczestnik int, nazwisko varchar(50), imie varchar(50) ) ;
--select * from lab01.uczestnik;
create table lab01.uczestnik ( id_uczestnik int, nazwisko varchar(50), imie varchar(50) ) ;
create table lab01.kurs ( id_kurs int, id_grupa int, id_nazwa int, termin varchar(50) ) ;
create table lab01.wykladowca ( id_wykladowca int, nazwisko varchar(50), imie varchar(50) ) ;
create table lab01.kurs_opis ( id_kurs int, opis varchar(50) ) ;
create table lab01.uczest_kurs ( id_uczest int, id_kurs int ) ;
create table lab01.wykl_kurs ( id_wykl int, id_kurs int ) ;
--
-- modyfikacja tabel - dodanie klucza glownego --
alter table lab01.kurs add primary key (id_kurs) ;
alter table lab01.uczestnik add primary key (id_uczestnik) ;
alter table lab01.wykladowca add primary key (id_wykladowca) ;
alter table lab01.kurs_opis add primary key (id_kurs) ;
alter table lab01.uczest_kurs add primary key (id_uczest, id_kurs) ;
alter table lab01.wykl_kurs add primary key (id_wykl, id_kurs) ;
--
-- modyfikacja tabel - dodanie refencji klucza obcego --
alter table lab01.uczest_kurs add foreign key (id_uczest) references lab01.uczestnik ( id_uczestnik) ;
alter table lab01.uczest_kurs add foreign key (id_kurs) references lab01.kurs ( id_kurs) ;
alter table lab01.wykl_kurs add foreign key (id_kurs) references lab01.kurs ( id_kurs) ;
alter table lab01.wykl_kurs add foreign key (id_wykl) references lab01.wykladowca ( id_wykladowca) ;
alter table lab01.kurs add foreign key (id_nazwa) references lab01.kurs_opis ( id_kurs) ;