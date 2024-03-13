WITH RECURSIVE date_series (employee_id, vacation_date, vacation_end_date) AS (
    SELECT 
        ooo.employee_id, 
        CAST(ooo.start_date AS DATE) AS vacation_date, 
        CAST(ooo.end_date AS DATE) AS vacation_end_date
    FROM bob.employee_out_of_office AS ooo

    UNION ALL

    SELECT 
        employee_id, 
        vacation_date + INTERVAL '1 day', 
        vacation_end_date
    FROM date_series
    WHERE vacation_date < vacation_end_date
)

SELECT employee_id, vacation_date
FROM date_series
ORDER BY employee_id, vacation_date;