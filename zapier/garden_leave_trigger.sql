SELECT
	e.full_name,
	e.id AS bob_employee_id,
	e.work_employee_id_in_company AS ts_employee_id,
	h.effective_date,
	LOWER(e.email) AS email,
	l.id AS manager_linear_id
FROM bob.employee AS e
INNER JOIN bob.employee_life_cycle_history AS h
	ON e.id = h.employee_id
	AND h._fivetran_deleted IS FALSE
	AND h.status = 'garden leave'
	AND h.effective_date = CURRENT_DATE - 1
LEFT JOIN bob.employee AS boss
	ON e.work_reports_to_id_in_company = boss.work_employee_id_in_company
	AND boss._fivetran_deleted IS FALSE
LEFT JOIN linear.users AS l
	ON LOWER(boss.email) = LOWER(l.email)
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE