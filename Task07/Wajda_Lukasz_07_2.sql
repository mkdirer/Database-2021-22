--1. Utworzyć funkcję,  która dostarcza listę z nazwiskami, imionami i adresem email uczestników dla organizacji. Identyfikator organizacji jest argumentem funkcji.
create or replace function lab04.zad1(organizacja int) returns table (imie varchar, nazw varchar, email varchar) as
$$
begin
return query
select ucz.imie, ucz.nazwisko, ucz.email from lab04.uczestnik ucz join lab04.uczestnik_organizacja uczo using (id_uczestnik) where uczo.id_organizacja=organizacja;
end
$$ language 'plpgsql';

--przykadowe wywoania
select * from lab04.zad1(1);
select * from lab04.zad1(2);

--usuniecie funkcji
drop function lab04.zad1(int);



--2. Utworzyć funkcję, która dostarcza ilość studentów dla kursów danego języka. Nazwa języka jest argumentem funkcji.
create or replace function lab04.zad2(nazwa varchar)
returns table (ilosc_studentow bigint) as
$$
begin
	return query
			select count(uczk.id_uczest) from lab04.kurs_opis ko
			join lab04.kurs k on k.id_kurs = ko.id_kurs
			join lab04.uczest_kurs uczk on uczk.id_kurs = k.id_kurs
			where strpos(ko.opis, nazwa) != 0;
end;
$$
language 'plpgsql';

--przykadowe wywoania
select * from lab04.zad2('niemiecki');
select * from lab04.zad2('angielski');

--usuniecie funkcji
drop function lab04.zad2(varchar);



--3. Utworzyć funkcję,  która dostarcza listę wykładowców prowadzących kursy dla zadanej organizacji. Argumentem funkcji jest adres strony np. www.uj.edu.pl.
create or replace function lab04.zad3(str varchar)
returns table (nazw varchar, imie varchar) as
$$
begin
    return query
        select w.nazwisko, w.imie from lab04.wykladowca w
        join lab04.uczestnik_organizacja uczo on w.id_wykladowca = uczo.id_wykladowca
        join lab04.organizacja org on org.id_organizacja = uczo.id_organizacja
        where org.strona_www = str;
end;
$$
language 'plpgsql';

--przykadowe wywoania
select * from lab04.zad3('www.uj.edu.pl');
select * from lab04.zad3('www.agh.edu.pl');

--usuniecie funkcji
drop function lab04.zad3(varchar);


--4. Utworzyć funkcję,  która zwraca napis ( string) którego zawartością jest lista. 
--Wiersze listy zawierają  opis kursu, data rozpoczęcia, data zakończenia oddzielone średnikami. Każdy wiersz jest umieszczony w nawiasach () i oddzielony przecinkiem.

create or replace function lab04.zad4() returns text as
$$
declare
 rec text default '';
 rec_kurs record;
 obec_kurs cursor for select kuo.opis, k.data_rozpoczecia, k.data_zakonczenia from lab04.kurs_opis kuo join lab04.kurs k using (id_kurs) ;
begin
 open obec_kurs ;
 loop
 fetch obec_kurs into rec_kurs;
 exit when not found;
 rec := rec || '(' || rec_kurs.opis || ',' || rec_kurs.data_rozpoczecia || ' , ' || rec_kurs.data_zakonczenia || ')';
 end loop;
 close obec_kurs;
 return rec;
end;
$$ language plpgsql;

--przykadowe wywoania
select lab04.zad4();

--usuniecie funkcji
drop function lab04.zad4();

















