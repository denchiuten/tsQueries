SELECT
	e.full_name,
	e.id AS bob_employee_id,
	e.work_employee_id_in_company AS ts_employee_id,
	h.effective_date,
	LOWER(e.email) AS email,
	l.id AS linear_manager_id
FROM bob.employee AS e
INNER JOIN bob.employee_life_cycle_history AS h
	ON e.id = h.employee_id
	AND h._fivetran_deleted IS FALSE
	AND h.status = 'terminated'
-- 	AND h.effective_date = CURRENT_DATE
-- add'l join to check whether employee has already done gardening leave
-- will filter these cases out since they will have already been deactivated in systems
LEFT JOIN bob.employee_life_cycle_history AS g
	ON e.id = g.employee_id
	AND g._fivetran_deleted IS FALSE
	AND g.status = 'garden leave'
-- 	AND g.effective_date < CURRENT_DATE
LEFT JOIN bob.employee AS boss
	ON e.work_reports_to_id = boss.id
	AND boss._fivetran_deleted IS FALSE
LEFT JOIN linear.users AS l
	ON LOWER(boss.email) = LOWER(l.email)
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND g.effective_date IS NULL


