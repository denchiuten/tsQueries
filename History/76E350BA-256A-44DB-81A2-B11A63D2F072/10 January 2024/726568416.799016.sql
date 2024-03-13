SELECT
	b.email,
	b.work_manager,
	b.work_reports_to_id_in_company
FROM bob.employee AS b
-- INNER JOIN bob.employee AS boss
-- 	ON b.work_reports_to_id_in_company
WHERE
	1 = 1
	AND b._fivetran_deleted IS FALSE
	AND b.email = 'dennis@terrascope.com'