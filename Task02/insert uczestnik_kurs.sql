create table uczest_kurs ( id_uczest int, id_kurs int , id_grupa int) ;
alter table uczest_kurs add primary key (id_uczest, id_kurs, id_grupa) ;
alter table uczest_kurs add foreign key (id_uczest) references uczestnik ( id_uczestnik) ;
alter table uczest_kurs add foreign key (id_kurs, id_grupa) references kurs ( id_kurs, id_grupa) ;
insert into uczest_kurs ( id_kurs, id_grupa, id_uczest ) values
-- kurs 1 - angielski 1 gr 1
( 1, 1,  1 ),
( 1, 1,  3 ),
( 1, 1,  5 ),
( 1, 1,  7 ),
( 1, 1,  8 ),
( 1, 1, 10 ),
( 1, 1, 11 ),
( 1, 1, 12 ),
-- kurs 2 - angielski 1 gr 2
( 2, 2,  2 ),
( 2, 2, 16 ),
( 2, 2, 17 ),
( 2, 2, 18 ),
( 2, 2, 20 ),
-- kurs 3 - angielski 2 gr 1
( 3, 1,  1 ),
( 3, 1,  2 ),
( 3, 1,  3 ),
( 3, 1,  5 ),
( 3, 1,  7 ),
( 3, 1, 17 ),
( 3, 1, 18 ),
( 3, 1, 20 ),
-- kurs 4 - angielski 3 gr 1
( 4, 1,  1 ),
( 4, 1,  2 ),
( 4, 1,  3 ),
( 4, 1,  5 ),
( 4, 1, 21 ),
( 4, 1, 22 ),
( 4, 1, 25 ),
-- kurs 5 - angielski 4 gr 1
( 5, 1,  1 ),
( 5, 1,  2 ),
( 5, 1,  3 ),
( 5, 1,  5 ),
( 5, 1, 21 ),
( 5, 1, 22 ),
-- kurs 6 - niemiecki 1 gr 1
( 6, 1,  8 ),
( 6, 1,  9 ),
( 6, 1, 13 ),
( 6, 1, 15 ),
( 6, 1, 19 ),
( 6, 1, 24 ),
( 6, 1, 27 ),
-- kurs 7 - niemiecki 1 gr 2
( 7, 2, 11 ),
( 7, 2, 17 ),
( 7, 2, 18 ),
( 7, 2, 23 ),
( 7, 2, 25 ),
( 7, 2, 28 ),
( 7, 2, 30 ),
-- kurs 8 - niemiecki 2 gr 1
( 8, 1,  8 ),
( 8, 1,  9 ),
( 8, 1, 13 ),
( 8, 1, 15 ),
( 8, 1, 19 ),
( 8, 1, 24 ),
( 8, 1, 27 ),
-- kurs 9 - niemiecki 3 gr 1
( 9, 1,  8 ),
( 9, 1,  9 ),
( 9, 1, 13 ),
( 9, 1, 24 ),
( 9, 1, 27 ),
-- kurs 10 - hiszpanski 1 gr 1
(10, 1,  6 ),
(10, 1, 16 ),
(10, 1, 18 ),
(10, 1, 22 ),
(10, 1, 24 ),
(10, 1, 29 ),
(10, 1, 30 ),
-- kurs 11 - hiszpanski 2 gr 1
(11, 1,  6 ),
(11, 1, 16 ),
(11, 1, 18 ),
(11, 1, 22 ),
(11, 1, 24 ),
(11, 1, 29 ),
(11, 1, 30 ) ; 

