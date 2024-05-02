SELECT
	e.full_name,
	e.id AS bob_employee_id,
	e.employee_id_in_company AS ts_employee_id,
	h.effective_date::DATE AS effective_date,
	h.creation_date::DATE AS creation_date,
	e.email AS email,
	e.site,
	boss.email AS manager_email
FROM bob.employee AS e
INNER JOIN bob.employee_life_cycle_history AS h
	ON e.id = h.employee_id
	AND h.status = 'garden leave'
LEFT JOIN bob.employee AS boss
	ON e.reports_to_id_in_company = boss.employee_id_in_company
	AND boss._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND h.creation_date = CURRENT_DATE