SELECT 
    		ooo.employee_id, 
		ooo.start_date AS vacation_date, 
		ooo.end_date AS vacation_end_date
    FROM bob.employee_out_of_office AS ooo

    UNION ALL

    SELECT 
    		employee_id, 
    		vacation_date + INTERVAL '1 day', 
    		vacation_end_date
    FROM date_series
    WHERE vacation_date < vacation_end_date