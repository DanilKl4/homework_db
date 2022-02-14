-- Однотабличные запросы

-- 1
SELECT *
FROM student
    WHERE score >= 4 AND score <= 4.5;

SELECT *
FROM student
    WHERE score BETWEEN 4 AND 4.5;

-- 2
SELECT name, surname, n_group::varchar
FROM student
WHERE name LIKE 'А%' OR surname LIKE '%х%';

-- 3
SELECT *
FROM student
    ORDER BY n_group DESC, name;

-- 4 
SELECT *
FROM student
    WHERE score > 4
    ORDER BY score DESC;

-- 5 (вместо футбола и хоккея - баскетбол и плавание)
SELECT name, risk
FROM hobby
    WHERE name IN ('баскетбол', 'плавание');

-- 6
SELECT student_id, hobby_id
FROM student_hobby
    WHERE (date_start BETWEEN '01-01-2018' AND '12-31-2019')
        AND date_end IS NOT NULL;

-- 7
SELECT *
FROM student
    WHERE score > 4.5
    ORDER BY score DESC;

-- 8
SELECT *
FROM student
    WHERE score > 4.5
    ORDER BY score DESC
    LIMIT 5;

SELECT *
FROM student
    WHERE score > 4.5
    ORDER BY score DESC
	FETCH FIRST 5 ROWS ONLY;

-- 9
SELECT *,
	CASE
		WHEN risk >= 8 THEN 'очень высокий'
		WHEN (risk >= 6 AND risk < 8) THEN 'высокий'
		WHEN (risk >= 4 AND risk < 6) THEN 'средний'
		WHEN (risk >= 2 AND risk < 4) THEN 'низкий'
		ELSE 'очень низкий'
	END as risk_assessment
FROM hobby;

-- 10
SELECT *
FROM hobby
    ORDER BY risk DESC
    LIMIT 3;