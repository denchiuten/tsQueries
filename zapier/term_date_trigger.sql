SELECT
	e.full_name,
	e.id AS bob_employee_id,
	e.employee_id_in_company AS ts_employee_id,
	h.effective_date,
	e.email,
	boss.email AS manager_email
FROM bob.employee AS e
INNER JOIN bob.employee_life_cycle_history AS h
	ON e.id = h.employee_id
	AND h.status = 'terminated'
	AND h.effective_date = CURRENT_DATE - 1
-- add'l join to check whether employee has already done gardening leave
-- will filter these cases out since they will have already been deactivated in systems
LEFT JOIN bob.employee_life_cycle_history AS g
	ON e.id = g.employee_id
	AND g._fivetran_deleted IS FALSE
	AND g.status = 'garden leave'
	AND g.effective_date < CURRENT_DATE
LEFT JOIN bob.employee AS boss
	ON e.reports_to_id_in_company = boss.employee_id_in_company
	AND boss._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND g.effective_date IS NULL


