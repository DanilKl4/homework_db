CREATE TABLE student(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	surname VARCHAR(255),
	address VARCHAR(255),
	n_group INT,
	CHECK (n_group >= 1000 AND n_group <= 9999),
	score REAL, 
	CHECK (score >= 2 AND score <= 5)
);

CREATE TABLE hobby(
	id SERIAL PRIMARY KEY,
	name varchar(255) NOT NULL,
	risk NUMERIC(3, 2) NOT NULL
);

CREATE TABLE student_hobby(
	id SERIAL PRIMARY KEY,
	student_id INT NOT NULL REFERENCES student(id),
	hobby_id INT NOT NULL REFERENCES hobby(id),
	date_start TIMESTAMP NOT NULL,
	date_end DATE
);

INSERT INTO student (name, surname, address, n_group, score) VALUES ('Владимир', 'Михайлов', 'Москва', 3412, 4.3);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Иван', 'Березин', 'Владивосток', 2271, 4.5);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Михаил', 'Чепухин', 'Дубна', 3412, 2.5);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Наталья', 'Мирская', 'Саратов', 5555, 4.9);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Вера', 'Витебская', 'Самара', 1281, 4.1);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Даниил', 'Волевой', 'Владимир', 3412, 3.5);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Александра', 'Солидная', 'Астрахань', 2271, 4.2);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Евгений', 'Максимов', 'Москва', 2271, 4.9);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Федор', 'Кольченко', 'Симферополь', 2271, 2.7);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Андрей', 'Степанов', 'Дубна', 1281, 3.3);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Степан', 'Андреев', 'Тверь', 1281, 4.3);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Арсений', 'Железнов', 'Новгород', 1281, 2.8);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Светлана', 'Сидорова', 'Ростов', 5555, 3.1);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Марина', 'Михалева', 'Львов', 5555, 4.0);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Виктор', 'Авксеньтьев', 'Одесса', 3412, 2.1);

INSERT INTO hobby (name, risk) VALUES ('программирование', 0);
INSERT INTO hobby (name, risk) VALUES ('баскетбол', 0.6);
INSERT INTO hobby (name, risk) VALUES ('пейнтбол', 1.5);
INSERT INTO hobby (name, risk) VALUES ('плавание', 0.8);
INSERT INTO hobby (name, risk) VALUES ('шахматы', 0);

INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (1, 1, '07-01-2010 12:03:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (2, 2, '05-01-2019 12:12:59', '07-08-2021');
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (2, 3, '12-01-2022 12:14:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (3, 2, '01-01-2012 12:15:59', '12-12-2020');
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (3, 3, '07-12-2020 11:01:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (3, 4, '12-12-2011 10:14:59', '02-01-2012');
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (4, 4, '08-08-2015 09:14:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (5, 5, '12-12-2017 14:32:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (15, 1, '05-06-2018 12:14:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (10, 2, '03-04-2018 14:14:59', '04-06-2018');
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (9, 3, '03-05-2019 11:11:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (8, 2, '03-11-2020 13:13:59', null);