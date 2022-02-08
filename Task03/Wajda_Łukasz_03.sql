--autor Łukasz Wajda
-- dla bazy lab
create schema lab03;

--SET SEARCH_PATH TO lab03 ;
--GRANT USAGE ON SCHEMA lab03 TO andlem;
--create table lab03.uczestnik ( id_uczestnik int, nazwisko varchar(50), imie varchar(50) ) ;
--select * from lab03.uczestnik;
create table lab03.uczestnik ( id_uczestnik int, nazwisko varchar(50), imie varchar(50) ) ;
create table lab03.kurs ( id_kurs int, id_grupa int, id_nazwa int, termin varchar(50) ) ;
create table lab03.wykladowca ( id_wykladowca int, nazwisko varchar(50), imie varchar(50) ) ;
create table lab03.kurs_opis ( id_kurs int, opis varchar(50) ) ;
create table lab03.uczest_kurs ( id_uczest int, id_kurs int ) ;
create table lab03.wykl_kurs ( id_wykl int, id_kurs int ) ;
--
-- modyfikacja tabel - dodanie klucza glownego --
alter table lab03.kurs add primary key (id_kurs) ;
alter table lab03.uczestnik add primary key (id_uczestnik) ;
alter table lab03.wykladowca add primary key (id_wykladowca) ;
alter table lab03.kurs_opis add primary key (id_kurs) ;
alter table lab03.uczest_kurs add primary key (id_uczest, id_kurs) ;
alter table lab03.wykl_kurs add primary key (id_wykl, id_kurs) ;
--
-- modyfikacja tabel - dodanie refencji klucza obcego --
alter table lab03.uczest_kurs add foreign key (id_uczest) references lab03.uczestnik ( id_uczestnik) ;
alter table lab03.uczest_kurs add foreign key (id_kurs) references lab03.kurs ( id_kurs) ;
alter table lab03.wykl_kurs add foreign key (id_kurs) references lab03.kurs ( id_kurs) ;
alter table lab03.wykl_kurs add foreign key (id_wykl) references lab03.wykladowca ( id_wykladowca) ;
alter table lab03.kurs add foreign key (id_nazwa) references lab03.kurs_opis ( id_kurs) ;


insert into lab03.uczestnik ( id_uczestnik, nazwisko, imie ) values 
( 1, 'Flisikowski', 'Jan'),
( 2, 'Olech', 'Andrzej'       ),
( 3, 'Płochocki', 'Piotr'    ),
( 4, 'Stachyra', 'Krzysztof' ),
( 5, 'Sztuka', 'Stanisław'   ),
( 6, 'Sosin', 'Tomasz'       ),
( 7, 'Głowala', 'Paweł'      ),
( 8, 'Straszewski', 'Józef'  ),
( 9, 'Dwojak', 'Marcin'      ),
(10, 'Kotulski', 'Marek'    ),
(11, 'Łaski', 'Michał'       ),
(12, 'Iwanowicz', 'Grzegorz' ),
(13, 'Barnaś', 'Jerzy'       ),
(14, 'Stachera', 'Tadeusz'   ),
(15, 'Gzik', 'Adam'          ),
(16, 'Całus', 'Łukasz'       ),
(17, 'Kołodziejek', 'Zbigniew'),
(18, 'Bukowiecki', 'Ryszard' ),
(19, 'Sielicki', 'Dariusz'   ),
(20, 'Radziszewski', 'Henryk'),
(21, 'Szcześniak', 'Mariusz' ),
(22, 'Nawara', 'Kazimierz'   ),
(23, 'Kęski', 'Wojciech'     ),
(24, 'Rafalski', 'Robert'    ),
(25, 'Hołownia', 'Mateusz'   ),
(26, 'Niedziałek', 'Marian'  ),
(27, 'Matuszczak', 'Rafał'   ),
(28, 'Wolf', 'Jacek'         ),
(29, 'Kolczyński', 'Janusz'  ),
(30, 'Chrobok', 'Mirosław'   )  ;
--
-- wstawienie danych - tabela kurs_opis
insert into lab03.kurs_opis ( id_kurs, opis ) values
( 1, 'Język angielski, stopień 1'),
( 2, 'Język angielski, stopień 2'),
( 3, 'Język angielski, stopień 3'), 
( 4, 'Język angielski, stopień 4'),
( 5, 'Język angielski, stopień 5'),
( 6, 'Język niemiecki, stopień 1'),
( 7, 'Język niemiecki, stopień 2'),
( 8, 'Język niemiecki, stopień 3'),
( 9, 'Język niemiecki, stopień 4'),
(10, 'Język hiszpański, stopień 1'),
(11, 'Język hiszpański, stopień 2'),
(12, 'Język hiszpański, stopień 3') ;
--
-- wstawienie danych - tabela wykladowca
insert into lab03.wykladowca ( id_wykladowca, imie, nazwisko ) values 
( 1, 'Marcin','Szymczak'),
( 2, 'Joanna','Baranowska'),
( 3, 'Maciej','Szczepański'),
( 4, 'Czesław','Wróbel'),
( 5, 'Grażyna','Górska'),
( 6, 'Wanda','Krawczyk'),
( 7, 'Renata','Urbańska'),
( 8, 'Wiesława','Tomaszewska'),
( 9, 'Bożena','Baranowska'),
(10, 'Ewelina','Malinowska'),
(11, 'Anna','Krajewska'),
(12, 'Mieczysław','Zając'),
(13, 'Wiesław','Przybylski'),
(14, 'Dorota','Tomaszewska'),
(15, 'Jerzy','Wróblewski') ;
--
-- wstawienie danych - tabela kurs
insert into lab03.kurs ( id_kurs, id_grupa, id_nazwa, termin ) values
( 1, 1, 1, '1.01.2021-31.03.2021'),
( 2, 2, 1, '1.01.2021-31.03.2021'),
( 3, 1, 2, '1.04.2021-30.06.2021'),
( 4, 1, 3, '1.08.2021-10.10.2021'),
( 5, 1, 4, '1.11.2021-23.12.2021'),
( 6, 1, 6, '1.01.2021-31.03.2021'),
( 7, 2, 6, '1.01.2021-31.03.2021'),
( 8, 1, 7, '1.04.2021-30.06.2021'),
( 9, 1, 8, '1.07.2021-31.07.2021'),
(10, 1, 10, '1.02.2021-31.05.2021'),
(11, 1, 11, '1.09.2021-30.11.2021') ; 
--
-- wstawienie danych - tabela wykl_kurs - wykladowcy na kursach
insert into lab03.wykl_kurs ( id_kurs, id_wykl ) values
( 1, 1 ),
( 2, 2 ),
( 3, 1 ),
( 4, 1 ),
( 5, 3 ),
( 6, 4 ),
( 7, 5 ),
( 8, 4 ),
( 9, 4 ),
(10, 11 ),
(11, 11 ) ; 
--
-- wstawienie danych - tabela uczest_kurs - uczestnicy na kursach
insert into lab03.uczest_kurs ( id_kurs, id_uczest ) values
-- kurs 1 - angielski 1 gr 1
( 1, 1 ),
( 1, 3 ),
( 1, 5 ),
( 1, 7 ),
( 1, 8 ),
( 1, 10 ),
( 1, 11 ),
( 1, 12 ),
-- kurs 2 - angielski 1 gr 2
( 2, 2 ),
( 2, 16 ),
( 2, 17 ),
( 2, 18 ),
( 2, 20 ),
-- kurs 3 - angielski 2 gr 1
( 3, 1 ),
( 3, 2 ),
( 3, 3 ),
( 3, 5 ),
( 3, 7 ),
( 3, 17 ),
( 3, 18 ),
( 3, 20 ),
-- kurs 4 - angielski 3 gr 1
( 4, 1 ),
( 4, 2 ),
( 4, 3 ),
( 4, 5 ),
( 4, 21 ),
( 4, 22 ),
( 4, 25 ),
-- kurs 5 - angielski 4 gr 1
( 5, 1 ),
( 5, 2 ),
( 5, 3 ),
( 5, 5 ),
( 5, 21 ),
( 5, 22 ),
-- kurs 6 - niemiecki 1 gr 1
( 6, 8 ),
( 6, 9 ),
( 6, 13 ),
( 6, 15 ),
( 6, 19 ),
( 6, 24 ),
( 6, 27 ),
-- kurs 7 - niemiecki 1 gr 2
( 7, 11 ),
( 7, 17 ),
( 7, 18 ),
( 7, 23 ),
( 7, 25 ),
( 7, 28 ),
( 7, 30 ),
-- kurs 8 - niemiecki 2 gr 1
( 8, 8 ),
( 8, 9 ),
( 8, 13 ),
( 8, 15 ),
( 8, 19 ),
( 8, 24 ),
( 8, 27 ),
-- kurs 9 - niemiecki 3 gr 1
( 9, 8 ),
( 9, 9 ),
( 9, 13 ),
( 9, 24 ),
( 9, 27 ),
-- kurs 10 - hiszpanski 1 gr 1
(10, 6 ),
(10, 16 ),
(10, 18 ),
(10, 22 ),
(10, 24 ),
(10, 29 ),
(10, 30 ),
-- kurs 11 - hiszpanski 2 gr 1
(11, 6 ),
(11, 16 ),
(11, 18 ),
(11, 22 ),
(11, 24 ),
(11, 29 ),
(11, 30 );

--zmiany tebel --
ALTER TABLE lab.lab03.kurs ADD COLUMN data_rozpoczecia DATE;

ALTER TABLE lab.lab03.kurs ADD COLUMN data_zakonczenia DATE;

ALTER TABLE lab.lab03.kurs DROP COLUMN termin;

ALTER TABLE lab.lab03.uczestnik ADD COLUMN adres VARCHAR(50);

ALTER TABLE lab.lab03.uczestnik ADD COLUMN kod_pocztowy VARCHAR(50);

ALTER TABLE lab.lab03.uczestnik ADD COLUMN miejscowosc VARCHAR(50);
--

-- update tabeli uczestnik
update lab03.uczestnik
set adres = zm.adres, kod_pocztowy = zm.kod_pocztowy, miejscowosc = zm.miejscowosc from 
(values ( 1, 'ul. Lipce', '80-003', 'Gdańsk' ),
        ( 2, 'ul. Niegowska','80-003','Gdańsk'),
        ( 3, 'ul. Niegowo','80-003', 'Gdańsk'),
        ( 4, 'ul. Trakt Świętego Wojciecha','80-007','Gdańsk'),
        ( 5, 'ul. Tomczaka Ryszarda','80-007', 'Gdańsk'),
        ( 6, 'ul. Batalionów Chłopskich','80-008','Gdańsk'),
        ( 7, 'ul. Po Schodkach','80-008','Gdańsk'),
        ( 8, 'Poczta Gdańsk 009','80-009','Gdańsk'),
        ( 9, 'Skrytki Pocztowe Poczta Gdańsk','80-009','Gdańsk'),
        (10, 'ul. Inspektorska','80-010','Gdańsk'),
        (11, 'ul. Kątowa','80-011','Gdańsk'),
        (12, 'ul. Jagodowa','80-012','Gdańsk'),
        (13, 'ul. Stroma','80-012','Gdańsk'),
        (14, 'ul. Figowa','80-012','Gdańsk'),
        (15, 'ul. Gronowa','80-012','Gdańsk'),
        (16, 'ul. Krokusowa','80-012','Gdańsk'),
        (17, 'ul. Aroniowa','80-012','Gdańsk'),
        (18, 'ul. Zawilcowa','80-012','Gdańsk'),
        (19, 'ul. Głogowa','80-012','Gdańsk'),
        (20, 'ul. Wąwóz','80-013','Gdańsk'),
        (21, 'ul. Rzeczna','80-014','Gdańsk'),
        (22, 'ul. Zawiejska','80-016','Gdańsk'),
        (23, 'ul. Trakt Świętego Wojciecha','80-018','Gdańsk'),
        (24, 'Poczta Filia UP Gdańsk','80-019','Gdańsk'),
        (25, 'ul. Nowiny','80-020','Gdańsk'),
        (26, 'ul. Raduńska','80-021','Gdańsk'),
        (27, 'ul. Szafirowa','80-022','Gdańsk'),
        (28, 'ul. Turkusowa','80-022','Gdańsk'),
        (29, 'ul. Perłowa','80-024','Gdańsk'),
        (30, 'ul. Piaskowa','80-025','Gdańsk')) 
as zm(id_uczestnik, miejscowosc, kod_pocztowy, adres)
where lab03.uczestnik.id_uczestnik = zm.id_uczestnik;

-- update tabeli kurs
update lab03.kurs
set data_rozpoczecia = zm.data_rozpoczecia, data_zakonczenia = zm.data_zakonczenia from 
(values ( 1, TO_DATE('1.01.2021', 'D.MM.YYYY'), TO_DATE('31.03.2021', 'D.MM.YYYY')),
        ( 2, TO_DATE('1.01.2021', 'D.MM.YYYY'), TO_DATE('31.03.2021', 'D.MM.YYYY')),
        ( 3, TO_DATE('1.04.2021', 'D.MM.YYYY'), TO_DATE('30.06.2021', 'D.MM.YYYY')),
        ( 4, TO_DATE('1.08.2021', 'D.MM.YYYY'), TO_DATE('10.10.2021', 'D.MM.YYYY')),
        ( 5, TO_DATE('1.11.2021', 'D.MM.YYYY'), TO_DATE('23.12.2021', 'D.MM.YYYY')),
        ( 6, TO_DATE('1.01.2021', 'D.MM.YYYY'), TO_DATE('31.03.2021', 'D.MM.YYYY')),
        ( 7, TO_DATE('1.01.2021', 'D.MM.YYYY'), TO_DATE('31.03.2021', 'D.MM.YYYY')),
        ( 8, TO_DATE('1.04.2021', 'D.MM.YYYY'), TO_DATE('30.06.2021', 'D.MM.YYYY')),
        ( 9, TO_DATE('1.07.2021', 'D.MM.YYYY'), TO_DATE('31.07.2021', 'D.MM.YYYY')),
        (10, TO_DATE('1.02.2021', 'D.MM.YYYY'), TO_DATE('31.05.2021', 'D.MM.YYYY')),
        (11, TO_DATE('1.09.2021', 'D.MM.YYYY'), TO_DATE('30.11.2021', 'D.MM.YYYY'))) 
as zm (id_kurs, data_rozpoczecia, data_zakonczenia)
where lab03.kurs.id_kurs = zm.id_kurs;


-- poleceanie
SELECT Uczestnik.nazwisko, Uczestnik.imie, Uczestnik.adres, Uczestnik.kod_pocztowy, Uczestnik.miejscowosc, Kurs_opis.opis, Kurs.data_rozpoczecia, Kurs.data_zakonczenia

FROM lab03.Kurs, lab03.uczest_kurs, lab03.Uczestnik, lab03.Kurs_opis

WHERE Kurs.id_kurs = uczest_kurs.id_kurs and  

      Uczestnik.id_uczestnik = uczest_kurs.id_uczest and

      Kurs.id_nazwa = Kurs_opis.id_kurs ;
