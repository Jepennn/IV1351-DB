
-- Task 3.1 Query to get the total number of lessons per month in 2024
SELECT
    Month,
    SUM(Individual + GroupLesson + Ensemble) AS Total,
    SUM(Individual) AS Individual,
    SUM(GroupLesson) AS Group,
    SUM(Ensemble) AS Ensemble
FROM (
    SELECT TO_CHAR(date, 'YYYY-MM') AS Month, COUNT(*) AS Individual, 0 AS GroupLesson, 0 AS Ensemble
    FROM individual_lesson
    WHERE EXTRACT(YEAR FROM date) = 2024
    GROUP BY TO_CHAR(date, 'YYYY-MM')
    UNION ALL
    SELECT TO_CHAR(date, 'YYYY-MM') AS Month, 0 AS Individual, COUNT(*) AS GroupLesson, 0 AS Ensemble
    FROM group_lesson
    WHERE EXTRACT(YEAR FROM date) = 2024
    GROUP BY TO_CHAR(date, 'YYYY-MM')
    UNION ALL
    SELECT TO_CHAR(date, 'YYYY-MM') AS Month, 0 AS Individual, 0 AS GroupLesson, COUNT(*) AS Ensemble
    FROM ensemble
    WHERE EXTRACT(YEAR FROM date) = 2024
    GROUP BY TO_CHAR(date, 'YYYY-MM')
) AS sub
GROUP BY Month
ORDER BY Month;

-- Alternative query to get the total number of lessons per month in 2024
SELECT 
    TO_CHAR(date, 'YYYY-MM') AS date,
    COUNT(*) AS total_lessons,
    SUM(CASE WHEN lesson_type = 'individual_lesson' THEN 1 ELSE 0 END) AS individual_lessons,
    SUM(CASE WHEN lesson_type = 'group_lesson' THEN 1 ELSE 0 END) AS group_lessons,
    SUM(CASE WHEN lesson_type = 'ensemble' THEN 1 ELSE 0 END) AS ensemble_lessons
FROM (
    SELECT 'group_lesson' AS lesson_type, id, instructor_id, instrument_id, min_students, max_students, level, start_time, end_time, date
    FROM group_lesson
    UNION ALL
    SELECT 'individual_lesson' AS lesson_type, id, instructor_id, NULL AS instrument_id, NULL AS min_students, NULL AS max_students, NULL AS level, start_time, end_time, date
    FROM individual_lesson
    UNION ALL
    SELECT 'ensemble' AS lesson_type, id, instructor_id, NULL AS instrument_id, min_students, max_students, level, start_time, end_time, date
    FROM ensemble
) AS all_lessons
WHERE EXTRACT(YEAR FROM date) = 2024
GROUP BY TO_CHAR(date, 'YYYY-MM')
ORDER BY date;

-- Task 3.2 to get the number of students with a certain number of siblings
SELECT
    no_of_siblings,
    COUNT(*) AS no_of_students
FROM (
    SELECT 
        s.id AS student_id,
        COUNT(ss.sibling_id) AS no_of_siblings
    FROM student s
    LEFT JOIN student_sibling ss ON s.id = ss.student_id
    GROUP BY s.id
) AS x
GROUP BY no_of_siblings
ORDER BY no_of_siblings;

-- Task 3.3 Query to get the instructors with the most lessons in September 2024
SELECT i.id, i.first_name, i.last_name, COUNT(all_lessons.id) AS total_lessons, TO_CHAR(all_lessons.date, 'YYYY-MM') AS month
FROM instructor i
JOIN (
    SELECT 'group_lesson' AS lesson_type, id, instructor_id, date
    FROM group_lesson
    UNION ALL
    SELECT 'individual_lesson' AS lesson_type, id, instructor_id, date
    FROM individual_lesson
    UNION ALL
    SELECT 'ensemble' AS lesson_type, id, instructor_id, date
    FROM ensemble
) AS all_lessons
ON i.id = all_lessons.instructor_id
WHERE EXTRACT(YEAR FROM all_lessons.date) = 2024 AND EXTRACT(MONTH FROM all_lessons.date) = 9
GROUP BY i.id, i.first_name, i.last_name, month
HAVING COUNT(i.id) > 0
ORDER BY total_lessons DESC;

-- Task 3.4 Query to get the total seats available in each ensemble for next week
SELECT 
    e.id, 
    e.date, 
    e.genre, 
    CASE 
        WHEN e.max_students - COUNT(se.student_id) = 0 THEN 'No seats'
        WHEN e.max_students - COUNT(se.student_id) IN (1, 2) THEN '1 or 2 seats'
        WHEN e.max_students - COUNT(se.student_id) > 2 THEN 'many seats'
    END AS free_seats
FROM ensemble e
LEFT JOIN student_ensemble se ON e.id = se.ensemble_id
WHERE e.date >= CURRENT_DATE AND e.date < CURRENT_DATE + INTERVAL '7 days'
GROUP BY e.id;



-- For testing purposes, you can use the following query to get the total seats available in each ensemble for the next week:
WITH custom_date AS (
    SELECT DATE '2025-07-04' AS current_date -- Change this date to your desired current date
)
SELECT e.id, e.date, e.genre,
CASE 
    WHEN e.max_students - COUNT(se.student_id) = 0 THEN 'No seats'
    WHEN e.max_students - COUNT(se.student_id) IN (1, 2) THEN '1 or 2 seats'
    WHEN e.max_students - COUNT(se.student_id) > 2 THEN 'many seats'
END AS free_seats 
FROM ensemble e
LEFT JOIN student_ensemble se ON e.id = se.ensemble_id
JOIN custom_date cd ON TRUE
WHERE e.date >= cd.current_date AND e.date < cd.current_date + INTERVAL '7 days'
GROUP BY e.id;
