SELECT
	 e.work_title AS title,
	 e.work_department AS department,
	 e.email,
	 e.full_name
FROM bob.employee AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.work_title NOT IN (SELECT DISTINCT role FROM google_sheets.capex_mapping)