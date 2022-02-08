--1--
SELECT ucz.nazwisko,ucz.imie, 
	CASE
		WHEN CAST(SUM(obecnosc) AS decimal)/(2 * COUNT(obecnosc)) >= 0.9 THEN 'duza'
		WHEN CAST(SUM(obecnosc) AS decimal)/(2 * COUNT(obecnosc)) >= 0.5 THEN 'srednia'
		WHEN CAST(SUM(obecnosc) AS decimal)/(2 * COUNT(obecnosc)) > 0.0 THEN 'mala'
		ELSE 'brak'
	END
FROM lab04.uczestnik ucz
LEFT JOIN lab04.aktywnosc akt USING (id_uczestnik)
GROUP BY ucz.nazwisko,ucz.imie ORDER BY 1;

--2--
SELECT nazwisko, imie,
    CASE
        WHEN liczba_uczestnikow < 15 THEN 'ponizej limitu'
        WHEN liczba_uczestnikow = 15 THEN 'limit'
        WHEN liczba_uczestnikow > 15 THEN 'powyzej limitu'
    END
FROM (SELECT imie,nazwisko, COUNT(id_uczest) AS liczba_uczestnikow FROM lab04.uczest_kurs uczk
	JOIN lab04.wykl_kurs wyk ON wyk.id_kurs = uczk.id_kurs
	JOIN lab04.wykladowca wy ON wy.id_wykladowca = wyk.id_wykl
    GROUP BY nazwisko, imie
    ORDER BY liczba_uczestnikow) AS fun;

--3--
WITH CTEstud AS (SELECT COUNT(id_uczest)::float AS u FROM lab04.uczest_kurs),
CTEkurs AS (SELECT COUNT(id_kurs)::float AS k FROM lab04.kurs)
SELECT ((CTEstud.u/CTEkurs.k)::decimal(5, 1)) sr FROM CTEkurs, CTEstud, lab04.kurs_opis kuo
JOIN lab04.kurs ku ON ku.id_kurs = kuo.id_kurs GROUP BY sr;







