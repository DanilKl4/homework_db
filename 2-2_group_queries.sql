-- 1
SELECT n_group, COUNT(n_group)
FROM student
GROUP BY n_group;

-- 2
SELECT n_group, MAX(score) AS max_score
FROM student
GROUP BY n_group
ORDER BY max_score DESC;

-- 3
SELECT surname, COUNT(surname)
FROM student
GROUP BY surname;

-- 4
SELECT date_part('year', date_birth) as year, COUNT(id)
FROM student
GROUP BY year
HAVING date_part('year', date_birth) IS NOT NULL;

-- или же так
SELECT EXTRACT(year from date_birth) as year, COUNT(id)
FROM student
GROUP BY year 
HAVING EXTRACT(year from date_birth) IS NOT NULL;

-- 5
SELECT n_group, AVG(score)
FROM student 
GROUP BY n_group
ORDER BY n_group;

-- 6
SELECT n_group
FROM
	student
WHERE score IN 
	(SELECT MAX(score)
 	FROM student)
LIMIT 1;

-- 7
SELECT n_group, AVG(score) as avg_score
FROM
	student
GROUP BY n_group
HAVING AVG(score) <= 3.5
ORDER BY avg_score;

-- 8
SELECT n_group, AVG(score) as avg_score, MAX(score) as max_score, MIN(score) as min_score
FROM
	student
GROUP BY n_group;

-- 9 Студент с max баллом в 5555
SELECT *
FROM student
WHERE (n_group, score) IN
	(SELECT n_group, MAX(score)
	FROM
		student
	GROUP BY n_group
	HAVING n_group = 5555);

-- 10
SELECT *
FROM student
WHERE (n_group, score) IN
	(SELECT n_group, MAX(score)
	FROM
		student
	GROUP BY n_group);