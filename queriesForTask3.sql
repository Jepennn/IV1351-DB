
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

-- Task 3.2
