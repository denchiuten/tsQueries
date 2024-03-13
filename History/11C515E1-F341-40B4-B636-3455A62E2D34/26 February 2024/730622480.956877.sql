SELECT
	cpm.role,
	cpm.department,
	cpm.team,
	cpm.development_share,
	COUNT(DISTINCT e.id) AS n
FROM google_sheets.capex_mapping AS cpm
LEFT JOIN bob.employee AS e
	ON cpm.role = e.work_title
	AND e.internal_status = 'Active'
GROUP BY 1,2,3,4
ORDER BY 1,2