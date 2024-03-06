SELECT 
    		ooo.employee_id, 
		ooo.start_date AS vacation_date, 
		ooo.end_date AS vacation_end_date
    FROM bob.employee_out_of_office AS ooo