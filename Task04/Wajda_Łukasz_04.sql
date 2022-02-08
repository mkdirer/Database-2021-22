--zadanie 1--
SELECT data_rozpoczecia, data_zakonczenia, opis, oplata, ocena, imie, nazwisko
FROM lab04.uczestnik u 
LEFT JOIN lab04.uczest_kurs uk ON u.id_uczestnik = uk.id_uczest
LEFT JOIN lab04.kurs k USING (id_kurs)
LEFT JOIN lab04.kurs_opis ko ON ko.id_kurs = k.id_nazwa
WHERE uk.id_uczest IS NULL
ORDER BY u.nazwisko;


SELECT data_rozpoczecia, data_zakonczenia, opis, oplata, ocena, imie, nazwisko
FROM lab04.uczestnik u 
LEFT JOIN lab04.uczest_kurs uk ON u.id_uczestnik = uk.id_uczest
RIGHT JOIN lab04.kurs k USING (id_kurs)
RIGHT JOIN lab04.kurs_opis ko ON ko.id_kurs = k.id_nazwa
WHERE uk.id_uczest IS NULL
ORDER BY u.nazwisko;

SELECT data_rozpoczecia, data_zakonczenia, opis, oplata, ocena, imie, nazwisko
FROM lab04.uczestnik u 
LEFT JOIN lab04.uczest_kurs uk ON u.id_uczestnik = uk.id_uczest
FULL JOIN lab04.kurs k USING (id_kurs)
FULL JOIN lab04.kurs_opis ko ON ko.id_kurs = k.id_nazwa
WHERE uk.id_uczest IS NULL
OR uk.id_kurs IS NULL
ORDER BY u.nazwisko;

--zadanie 2--

SELECT lab04.kurs_opis.opis, zm.avg,  zm.min, zm.max
FROM lab04.kurs_opis,
(SELECT uk.id_kurs,MAX(Ocena) max ,MIN(ocena) min, AVG(ocena) avg
FROM lab04.uczest_kurs uk, lab04.uczestnik u,lab04.kurs k, lab04.kurs_opis ko
WHERE uk.id_uczest=u.id_uczestnik and k.id_kurs=uk.id_kurs and ko.id_kurs=uk.id_kurs
GROUP BY uk.id_kurs) zm WHERE lab04.kurs_opis.id_kurs=zm.id_kurs;

--zadanie 3--

SELECT nazwisko, imie, COUNT(id_uczest) as "suma"
FROM lab04.wykladowca wy
JOIN lab04.wykl_kurs wk ON wy.id_wykladowca = wk.id_wykl
JOIN lab04.kurs ku ON ku.id_kurs = wk.id_kurs
JOIN lab04.uczest_kurs uk ON ku.id_kurs = uk.id_kurs
GROUP BY wy.id_wykladowca ORDER BY "suma" DESC;
