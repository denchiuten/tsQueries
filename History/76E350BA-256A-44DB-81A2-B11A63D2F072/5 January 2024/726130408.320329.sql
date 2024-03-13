SELECT -
FROM bob.employee_out_of_office AS ooo
WHERE
	1 = 1
	AND ooo._fivetran_deleted IS FALSE
	AND CURRENT_DATE BETWEEN ooo.start_date AND ooo.end_date