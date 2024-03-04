-- 1 Selezionare tutti gli studenti nati nel 1990 (160)

SELECT * FROM `students` WHERE YEAR(date_of_birth) = 1990;

--2 Selezionare tutti i corsi che valgono più di 10 crediti (479)

SELECT * FROM `courses` WHERE cfu > 10;

--3 Selezionare tutti gli studenti che hanno più di 30 anni

SELECT *
FROM `students`
WHERE
    DATEDIFF(curdate(), date_of_birth) > 30;

--4 Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

SELECT * FROM `courses` where period = 'I semestre' AND year = 1;

--5 Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

SELECT *
FROM `exams`
WHERE
    DATE(date) = '2020-06-20'
    AND hour > '14:00:00';

--6 Selezionare tutti i corsi di laurea magistrale (38)

SELECT * FROM `degrees` WHERE name LIKE '%laurea magistrale%';

--7 Da quanti dipartimenti è composta l'università? (12)

SELECT count(*)
FROM `departments`
    --8 Quanti sono gli insegnanti che non hanno un numero di telefono ? (50)

SELECT count(*) FROM `teachers` where phone is null;

-- 1group Contare quanti iscritti ci sono stati ogni anno

SELECT count(*) as studenti_iscritti, year(enrolment_date)
FROM `students`
GROUP by
    YEAR(enrolment_date);

--2group  Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT
    count(*) as number_of_teachers,
    office_address
FROM `teachers`
GROUP BY
    office_address;

--3group Calcolare la media dei voti di ogni appello d'esame

SELECT
    ROUND(AVG(vote), 2) as media_voto,
    exam_id as numero_appello
FROM `exam_student`
GROUP by
    numero_appello;

--4group Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT count(name) as numero_corsi, department_id
FROM `degrees`
GROUP by
    department_id;

--1join Selezionare tutti gli studenti al Corso di Laurea in Economia

SELECT *
FROM `students`
    JOIN `degrees` ON `degrees`.`id` = `students`.`degree_id`
WHERE
    `degrees`.`name` = 'Corso di Laurea in Economia';

--2join Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT `degrees`.`name` AS 'Corso di Laurea', `departments`.`name` AS 'Dipartimento di competenza'
FROM `degrees`
    JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
WHERE
    `departments`.`name` = 'Dipartimento di Neuroscienze';

--3join Selezionare tutti i corsi in cui insegna Fulvio Amato
SELECT `courses`.`name` as 'Nome corso', `teachers`.`name` as 'Nome insegnamente del corso', `teachers`.`surname` as 'Cognome insegnamente del corso'
FROM
    `courses`
    JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
    JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE
    `teachers`.`name` = 'Fulvio' && `teachers`.`surname` = 'Amato';

--4 Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`name` as 'Nome studente', `students`.`surname` as 'Cognome studente', `degrees`.*, `departments`.`name` AS 'Nome dipartimento'
FROM
    `students`
    JOIN `degrees` ON `degrees`.`id` = `students`.`degree_id`
    JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname` ASC, `students`.`name` ASC;

--5 Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `degrees`.`name` AS 'Nome corso di laurea', `courses`.`name` as 'nome corso', `teachers`.`name` as 'Nome insegnante', `teachers`.`surname` AS 'Cognome insegnante'
FROM
    `degrees`
    JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
    JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
    JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`;