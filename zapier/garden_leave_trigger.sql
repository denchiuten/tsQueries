SELECT
	e.full_name,
	e.id AS bob_employee_id,
	e.work_employee_id_in_company AS ts_employee_id,
	h.effective_date,
	LOWER(e.email) AS email
FROM bob.employee AS e
INNER JOIN bob.employee_life_cycle_history AS h
	ON e.id = h.employee_id
	AND h._fivetran_deleted IS FALSE
	AND h.status = 'garden leave'
	AND h.effective_date = CURRENT_DATE
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
