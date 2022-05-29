-- 1
SELECT
	s.name, 
	s.surname, 
	h.name as hobby_name
FROM 
	student as s,
	student_hobby as sh,
	hobby as h
WHERE s.id = sh.student_id and h.id = sh.hobby_id;


-- 2
SELECT s.id
FROM
	student s
INNER JOIN student_hobby sh on sh.student_id = s.id and sh.date_finish IS NULL
ORDER BY sh.date_start
LIMIT 1;

-- 3
SELECT s.name,
	   s.surname,
	   s.date_birth,
	   SUM(h.risk) as sum_risk
FROM student s,
	 hobby h,
	 student_hobby sh
WHERE s.id = sh.student_id AND h.id = sh.hobby_id AND
	  s.score > (SELECT AVG(score)
				FROM student)
GROUP BY s.id
HAVING SUM(h.risk) > 0.9;

-- 4
SELECT s.id,
	   s.name,
	   s.surname,
	   s.date_birth,
	   h.name as hobby_name,
	   12 * extract(year from age(date_finish, date_start))
FROM student s,
	 hobby h,
	 student_hobby sh
WHERE s.id = sh.student_id AND h.id = sh.hobby_id AND
	  date_finish IS NOT NULL;

-- 5
SELECT s.id,
	   s.name,
	   s.surname,
	   s.date_birth,
	   COUNT(sh.date_finish) AS hobby_count
FROM student s,
	 hobby h,
	 student_hobby sh
WHERE s.id = sh.student_id AND h.id = sh.hobby_id AND
	  extract(year from age(now()::timestamp::date, s.date_birth)) = 24
	  AND sh.date_finish IS NOT NULL
GROUP BY s.id
HAVING COUNT(sh.date_finish) > 1;

-- 6
SELECT s.n_group, round(avg(s.score), 2)
FROM
	student s
INNER JOIN student_hobby sh on sh.student_id = s.id and sh.date_finish IS NULL
GROUP BY n_group;

-- 7
SELECT s.id,
	   s.name, 
	   h.name as hobby_name, 
	   h.risk as hobby_risk,
	   12 * extract(year from age(now()::date, sh.date_start)) as hobby_time
FROM 
	 student_hobby sh
INNER JOIN student s on sh.student_id = s.id
INNER JOIN hobby h on sh.hobby_id = h.id
WHERE date_finish IS NULL
ORDER BY hobby_time DESC
LIMIT 1;

-- 8
SELECT s.name,
	   s.surname,
	   s.score,
	   h.name as hobby_name
FROM 
	 student_hobby sh
INNER JOIN student s on sh.student_id = s.id
INNER JOIN hobby h on sh.hobby_id = h.id
WHERE score = (SELECT MAX(score) FROM student);

-- 9
SELECT s.name,
	   s.surname,
	   div(s.n_group, 1000) as course,
	   s.score,
	   h.name as hobby_name
FROM 
	 student_hobby sh
INNER JOIN student s on sh.student_id = s.id
INNER JOIN hobby h on sh.hobby_id = h.id
WHERE s.score >= 2.5 and s.score < 3.5 and div(s.n_group, 1000) = 2;

-- 10 (переделать)
-- SELECT s.n_group, count(h.id) all_st_in_group, count(h.id) filter(WHERE sh.date_finish IS NULL) st
-- FROM student_hobby sh
-- INNER JOIN student s ON s.id = sh.student_id
-- INNER JOIN hobby h ON h.id = sh.hobby_id
-- GROUP BY s.n_group
-- HAVING count(h.id) filter(WHERE sh.date_finish IS NULL) / count(h.id) > 0.5;

-- 11
SELECT s.n_group, round(count(s.id) filter(WHERE s.score > 4)*1.0 /count(s.id), 2)
FROM student s
GROUP BY s.n_group
HAVING (count(s.id) filter(WHERE s.score > 4)*1.0 /count(s.id)) > 0.6

-- 12
SELECT s.n_group, COUNT(DISTINCT h.id) as hobby_count
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
GROUP BY s.n_group

-- 13
SELECT s.*
FROM student_hobby sh
RIGHT JOIN student s ON s.id = sh.student_id
WHERE sh.id IS NULL AND s.score >= 4.5

-- 14
CREATE OR REPLACE VIEW Students_V1 AS
SELECT DISTINCT s.*
FROM student s
LEFT JOIN student_hobby sh on s.id = sh.student_id
WHERE sh.date_finish IS NULL AND extract(year from age(now()::date, sh.date_start)) >= 5;

-- 15
SELECT h.name as hobby_name,
	   COUNT(s.id) as count_students
FROM 
	hobby h,
	student s,
	student_hobby sh
WHERE s.id = sh.student_id and h.id = sh.hobby_id
GROUP BY hobby_name;

-- 16
SELECT h.id
FROM 
	student_hobby sh
INNER JOIN hobby h on sh.hobby_id = h.id
GROUP BY h.id
ORDER BY count(1) DESC
LIMIT 1;

-- 17
SELECT s.*
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id AND sh.hobby_id = 
(
	SELECT h.id
	FROM 
		student_hobby sh
	INNER JOIN hobby h on sh.hobby_id = h.id
	GROUP BY h.id
	ORDER BY count(1) DESC
	LIMIT 1
);

-- 18
SELECT id
FROM hobby
ORDER BY risk DESC
LIMIT 3;

-- 19
SELECT s.*
FROM student_hobby sh
INNER JOIN student s ON sh.student_id = s.id
WHERE sh.date_finish IS NULL 
GROUP BY s.id, sh.date_start
ORDER BY (now() - sh.date_start) DESC
LIMIT 10;

-- 20
SELECT DISTINCT s.n_group
FROM student s
WHERE s.n_group IN
(SELECT s.n_group
FROM student_hobby sh
INNER JOIN student s ON sh.student_id = s.id
WHERE sh.date_finish IS NULL 
GROUP BY s.id, sh.date_start
ORDER BY (now() - sh.date_start) DESC
LIMIT 10);

-- 21
CREATE OR REPLACE VIEW Student_data AS
SELECT s.id, s.name, s.surname
FROM student s
ORDER BY s.score DESC;

-- 22
CREATE OR REPLACE VIEW Students_V1 AS
SELECT ph.course, ph.hobby
FROM (SELECT s.n_group / 1000 course, h.name hobby, COUNT(h.name) h_count
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
GROUP BY h.name, s.n_group / 1000
ORDER BY h_count DESC) ph

-- 23
CREATE OR REPLACE VIEW Students_V1 AS
SELECT h.name hobby, COUNT(h.name) h_count, h.risk
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
WHERE s.n_group / 1000 = 2
GROUP BY h.name, h.risk
ORDER BY h_count DESC, h.risk DESC
LIMIT 1;

-- 24
CREATE OR REPLACE VIEW Students_V1 AS
SELECT s.n_group / 1000 course, COUNT(s.id) count_all
FROM student s
RIGHT JOIN (
	SELECT s.n_group / 1000 c, COUNT(s.id) count_otl
	FROM student s
	WHERE s.score >= 4.5
	GROUP BY s.n_group / 1000
) otl on otl.c = s.n_group / 1000
GROUP BY s.n_group / 1000

-- 25
CREATE OR REPLACE VIEW popular_hobby AS
SELECT h.name hobby, COUNT(*)
FROM hobby h
LEFT JOIN student_hobby sh ON h.id = sh.hobby_id
GROUP BY h.name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 26
CREATE OR REPLACE VIEW update_view AS
SELECT id, name, surname, n_group 
FROM student
WITH CHECK OPTION;

-- 27
SELECT left(s.name, 1), MAX(s.score), ROUND(AVG(s.score),2), MIN(s.score)
FROM student s
WHERE s.score > 3.6
GROUP BY left(s.name, 1)
ORDER BY left(s.name, 1)

-- 28
SELECT s.n_group / 1000 course, s.surname, MAX(s.score), MIN(s.score)
FROM student s
GROUP BY s.n_group / 1000, s.surname

-- 29
SELECT EXTRACT(YEAR FROM date_birth), COUNT(h.id)
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
WHERE h.id IS NOT NULL
GROUP BY EXTRACT(YEAR FROM date_birth)
ORDER BY EXTRACT(YEAR FROM date_birth);

-- 30
SELECT left(s.name, 1), MAX(h.risk), MIN(h.risk)
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
GROUP BY left(s.name, 1)

-- 31
SELECT EXTRACT(MONTH FROM s.date_birth), ROUND(AVG(s.score), 2) 
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
WHERE h.name = 'Футбол'
GROUP BY EXTRACT(MONTH FROM s.date_birth)

-- 32
SELECT DISTINCT s.name Имя, s.surname Фамилия, s.n_group Группа
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id

-- 33
SELECT 
CASE WHEN strpos(surname, 'ов') != 0 THEN strpos(surname, 'ов')::VARCHAR(3)
	 ELSE 'не найдено'
END
FROM student;

-- 34
SELECT rpad(surname, 10, '#') FROM student;

-- 35
SELECT replace(surname, '#', '') FROM student;

-- 36
SELECT DATE_TRUNC('month', '2018-04-01'::timestamp) + '1 MONTH'::INTERVAL - DATE_TRUNC('month', '2018-04-01'::timestamptz);

-- 38
SELECT 
	EXTRACT(CENTURY FROM now()),
	EXTRACT(WEEK FROM now()),
	EXTRACT(DOY FROM now());

-- 39
SELECT DISTINCT s.name, s.surname, h.name,
CASE
	WHEN sh.date_finish IS NULL THEN 'занимается'
	ELSE 'закончил'
END 
FROM student_hobby sh
INNER JOIN student s ON sh.student_id = s.id
INNER JOIN hobby h ON h.id = sh.hobby_id;22

