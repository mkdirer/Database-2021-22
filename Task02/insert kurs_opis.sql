create table kurs_opis ( id_kurs int, opis varchar(30) ) ;
alter table kurs_opis add primary key (id_kurs) ;

insert into kurs_opis ( id_kurs, opis ) values
( 1, 'Jêzyk angielski, stopieñ 1'),
( 2, 'Jêzyk angielski, stopieñ 2'),
( 3, 'Jêzyk angielski, stopieñ 3'), 
( 4, 'Jêzyk angielski, stopieñ 4'),
( 5, 'Jêzyk angielski, stopieñ 5'),
( 6, 'Jêzyk niemiecki, stopieñ 1'),
( 7, 'Jêzyk niemiecki, stopieñ 2'),
( 8, 'Jêzyk niemiecki, stopieñ 3'),
( 9, 'Jêzyk niemiecki, stopieñ 4'),
(10, 'Jêzyk hiszpañski, stopieñ 1'),
(11, 'Jêzyk hiszpañski, stopieñ 2'),
(12, 'Jêzyk hiszpañski, stopieñ 3') ;
