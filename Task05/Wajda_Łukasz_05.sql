--1--
SELECT 
	nazwisko, imie 
FROM 
	lab04.kurs_opis kuo
JOIN lab04.uczest_kurs uczk ON uczk.id_kurs = kuo.id_kurs
JOIN lab04.uczestnik ucz ON ucz.id_uczestnik = uczk.id_uczest
WHERE 
	kuo.opis LIKE 'Język angielski%'
UNION
SELECT 
	nazwisko, imie 
FROM 
	lab04.kurs_opis kuo
JOIN lab04.uczest_kurs uczk ON uczk.id_kurs = kuo.id_kurs
JOIN lab04.uczestnik ucz ON ucz.id_uczestnik = uczk.id_uczest
WHERE 
	kuo.opis LIKE 'Język niemiecki%';

--2--
SELECT 
	nazwisko, imie 
FROM 
	lab04.kurs_opis kuo
JOIN lab04.uczest_kurs uczk ON uczk.id_kurs = kuo.id_kurs
JOIN lab04.uczestnik ucz ON ucz.id_uczestnik = uczk.id_uczest
WHERE 
	kuo.opis LIKE 'Język angielski%'
INTERSECT
SELECT 
	nazwisko, imie 
FROM 
	lab04.kurs_opis kuo
JOIN lab04.uczest_kurs uczk ON uczk.id_kurs = kuo.id_kurs
JOIN lab04.uczestnik ucz ON ucz.id_uczestnik = uczk.id_uczest
WHERE 
	kuo.opis LIKE 'Język niemiecki%';

--3--
SELECT 
	nazwisko, imie 
FROM 
	lab04.kurs_opis kuo
JOIN lab04.uczest_kurs uczk ON uczk.id_kurs = kuo.id_kurs
JOIN lab04.uczestnik ucz ON ucz.id_uczestnik = uczk.id_uczest
WHERE 
	kuo.opis LIKE 'Język niemiecki%'
EXCEPT
SELECT 
	nazwisko, imie 
FROM 
	lab04.kurs_opis kuo
JOIN lab04.uczest_kurs uczk ON uczk.id_kurs = kuo.id_kurs
JOIN lab04.uczestnik ucz ON ucz.id_uczestnik = uczk.id_uczest
WHERE 
	kuo.opis LIKE 'Język angielski%';

--4--
SELECT opis, id_kurs, sum_op 
FROM (SELECT kuo.opis, uczk.id_kurs, SUM(uczk.oplata) AS sum_op FROM lab04.uczest_kurs uczk JOIN lab04.kurs_opis kuo ON kuo.id_kurs = uczk.id_kurs
GROUP BY kuo.opis, uczk.id_kurs ORDER BY sum_op) AS fun WHERE sum_op > 4631.82;

--5--
SELECT w.nazwisko, w.imie, COUNT(w.id_wykladowca) AS sum_uczest
FROM lab04.uczest_kurs uczk
JOIN lab04.wykl_kurs wk ON wk.id_kurs = uczk.id_kurs
JOIN lab04.wykladowca w ON w.id_wykladowca = wk.id_wykl
GROUP BY w.nazwisko, w.imie
ORDER BY sum_uczest DESC
LIMIT 1;

--6--
SELECT DISTINCT ucz.nazwisko, ucz.imie,  o.nazwa, uo.id_organizacja, uk.ocena, ucz.id_uczestnik 
FROM lab04.uczestnik ucz
JOIN lab04.uczestnik_organizacja uo USING(id_uczestnik)
JOIN lab04.organizacja o USING(id_organizacja)
JOIN lab04.uczest_kurs uk ON ucz.id_uczestnik=uk.id_uczest
WHERE uk.ocena=ANY(SELECT MAX(ocena) FROM lab04.uczest_kurs)
ORDER BY uo.id_organizacja DESC;

