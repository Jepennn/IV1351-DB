
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