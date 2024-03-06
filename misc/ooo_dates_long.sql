WITH RECURSIVE date_series (employee_id, vacation_date, vacation_end_date) AS (
    SELECT 
        ooo.employee_id, 
        ooo.start_date::DATE AS vacation_date, 
        ooo.end_date::DATE AS vacation_end_date
    FROM bob.employee_out_of_office AS ooo

    UNION ALL

    SELECT 
        employee_id, 
        (vacation_date + INTERVAL '1 day')::DATE, 
        vacation_end_date
    FROM date_series
    WHERE vacation_date <= vacation_end_date
)

SELECT employee_id, vacation_date
FROM date_series
ORDER BY employee_id, vacation_date;


