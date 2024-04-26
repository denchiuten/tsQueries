SELECT
	e.full_name,
	e.id AS bob_employee_id,
	e.employee_id_in_company AS ts_employee_id,
	h.effective_date,
	LOWER(e.email) AS email,
	LOWER(boss.email) AS manager_email
FROM bob.employee AS e
INNER JOIN bob.employee_life_cycle_history AS h
	ON e.id = h.employee_id
	AND h.status = 'garden leave'
	AND h.effective_date = CURRENT_DATE - 1
LEFT JOIN bob.employee AS boss
	ON e.reports_to_id_in_company = boss.employee_id_in_company
	AND boss._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE