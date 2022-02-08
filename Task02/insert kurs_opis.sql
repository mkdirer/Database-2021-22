create table kurs_opis ( id_kurs int, opis varchar(30) ) ;
alter table kurs_opis add primary key (id_kurs) ;

insert into kurs_opis ( id_kurs, opis ) values
( 1, 'J�zyk angielski, stopie� 1'),
( 2, 'J�zyk angielski, stopie� 2'),
( 3, 'J�zyk angielski, stopie� 3'), 
( 4, 'J�zyk angielski, stopie� 4'),
( 5, 'J�zyk angielski, stopie� 5'),
( 6, 'J�zyk niemiecki, stopie� 1'),
( 7, 'J�zyk niemiecki, stopie� 2'),
( 8, 'J�zyk niemiecki, stopie� 3'),
( 9, 'J�zyk niemiecki, stopie� 4'),
(10, 'J�zyk hiszpa�ski, stopie� 1'),
(11, 'J�zyk hiszpa�ski, stopie� 2'),
(12, 'J�zyk hiszpa�ski, stopie� 3') ;
