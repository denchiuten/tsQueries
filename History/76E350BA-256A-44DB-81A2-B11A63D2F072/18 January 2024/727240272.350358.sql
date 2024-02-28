SELECT
	e.payroll_employment_type AS employment_type,
	e.email,
	e.first_name,
	e.surname,
	e.full_name,
	e.work_manager AS direct_manager,
	b1.work_manager AS work_second_level_manager
	b2.work_manager AS work_third_level_manager
FROM bob.employee AS e
LEFT JOIN bob.employee AS b1
	ON e.work_reports_to_id_in_company = b1.work_employee_id_in_company
LEFT JOIN bob.employee AS b2
	ON b1.work_reports_to_id_in_company = b2.work_employee_id_in_company
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.internal_status = 'Active'
	AND (
			e.work_employee_id_in_company IN (100002, 100147) 
			OR e.work_reports_to_id_in_company IN (100002, 100147) 
			OR b1.work_reports_to_id_in_company IN (100002, 100147)
			OR b2.work_reports_to_id_in_company IN (100002, 100147)
	)