SELECT
	emp.full_name,
	ooo.start_date,
	ooo.end_date
FROM bob.employee_out_of_office AS ooo
INNER JOIN bob.employee AS emp
	ON ooo.employee_id = emp.id
	AND emp.internal_status = 'Active'
WHERE
	1 = 1
	AND ooo._fivetran_deleted IS FALSE
	AND CURRENT_DATE BETWEEN ooo.start_date AND ooo.end_date
ORDER BY emp.surname