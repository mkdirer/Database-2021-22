
alter table kurs add primary key (id_kurs, id_grupa) ;
alter table uczestnik add primary key (id_uczestnik) ;

insert into uczestnik ( id_uczestnik, nazwisko, imie ) values 
( 1, 'Flisikowski', 'Jan'),
( 2, 'Olech', 'Andrzej'       ),
( 3, 'P³ochocki', 'Piotr'    ),
( 4, 'Stachyra', 'Krzysztof' ),
( 5, 'Sztuka', 'Stanis³aw'   ),
( 6, 'Sosin', 'Tomasz'       ),
( 7, 'G³owala', 'Pawe³'      ),
( 8, 'Straszewski', 'Józef'  ),
( 9, 'Dwojak', 'Marcin'      ),
(10, 'Kotulski', 'Marek'    ),
(11, '£aski', 'Micha³'       ),
(12, 'Iwanowicz', 'Grzegorz' ),
(13, 'Barna¶', 'Jerzy'       ),
(14, 'Stachera', 'Tadeusz'   ),
(15, 'Gzik', 'Adam'          ),
(16, 'Ca³us', '£ukasz'       ),
(17, 'Ko³odziejek', 'Zbigniew'),
(18, 'Bukowiecki', 'Ryszard' ),
(19, 'Sielicki', 'Dariusz'   ),
(20, 'Radziszewski', 'Henryk'),
(21, 'Szcze¶niak', 'Mariusz' ),
(22, 'Nawara', 'Kazimierz'   ),
(23, 'Kêski', 'Wojciech'     ),
(24, 'Rafalski', 'Robert'    ),
(25, 'Ho³ownia', 'Mateusz'   ),
(26, 'Niedzia³ek', 'Marian'  ),
(27, 'Matuszczak', 'Rafa³'   ),
(28, 'Wolf', 'Jacek'         ),
(29, 'Kolczyñski', 'Janusz'  ),
(30, 'Chrobok', 'Miros³aw'   )  ;

insert into kurs ( id_kurs, id_grupa, id_kurs_nazwa, termin ) values
( 1, 1, 1, '1.01.2017-31.03.2017'),
( 2, 2, 1, '1.01.2017-31.03.2017'),
( 3, 1, 2, '1.04.2017-30.06.2017'),
( 4, 1, 3, '1.08.2017-10.10.2017'),
( 5, 1, 4, '1.11.2017-23.12.2017'),
( 6, 1, 6, '1.01.2017-31.03.2017'),
( 7, 2, 6, '1.01.2017-31.03.2017'),
( 8, 1, 7, '1.04.2017-30.06.2017'),
( 9, 1, 8, '1.07.2017-31.07.2017'),
(10, 1, 10, '1.02.2017-31.05.2017'),
(11, 1, 11, '1.09.2017-30.11.2017') ; 
