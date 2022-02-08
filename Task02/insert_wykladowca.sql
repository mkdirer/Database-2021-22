create table wykladowca ( id_wykladowca int, nazwisko varchar(30), imie varchar(30) ) ;
create table wykl_kurs ( id_wykl int, id_kurs int , id_grupa int) ;

alter table wykladowca add primary key (id_wykladowca) ;
alter table wykl_kurs add primary key (id_wykl, id_kurs, id_grupa) ;
--
alter table wykl_kurs add foreign key (id_kurs, id_grupa) references kurs ( id_kurs, id_grupa) ;
alter table wykl_kurs add foreign key (id_wykl) references wykladowca ( id_wykladowca) ;
--
insert into wykladowca ( id_wykladowca, imie, nazwisko ) values 
( 1, 'Marcin','Szymczak'),
( 2, 'Joanna','Baranowska'),
( 3, 'Maciej','Szczepa�ski'),
( 4, 'Czes�aw','Wr�bel'),
( 5, 'Gra�yna','G�rska'),
( 6, 'Wanda','Krawczyk'),
( 7, 'Renata','Urba�ska'),
( 8, 'Wies�awa','Tomaszewska'),
( 9, 'Bo�ena','Baranowska'),
(10, 'Ewelina','Malinowska'),
(11, 'Anna','Krajewska'),
(12, 'Mieczys�aw','Zaj�c'),
(13, 'Wies�aw','Przybylski'),
(14, 'Dorota','Tomaszewska'),
(15, 'Jerzy','Wr�blewski') ;
--
insert into wykl_kurs ( id_kurs, id_grupa, id_wykl ) values
( 1, 1, 1 ),
( 2, 2, 2 ),
( 3, 1, 1 ),
( 4, 1, 1 ),
( 5, 1, 3 ),
( 6, 1, 4 ),
( 7, 2, 5 ),
( 8, 1, 4 ),
( 9, 1, 4 ),
(10, 1, 11 ),
(11, 1, 11 ) ; 
