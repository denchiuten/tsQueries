SELECT
	n.name,
	n.email,
	b.payroll_employment_type,
	COALESCE(b.internal_status, 'Not in Bob') AS bob_status
FROM notion.users AS n
LEFT JOIN bob.employee AS b
	ON LOWER(n.email) = LOWER(b.email)
	AND b._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND n._fivetran_deleted IS FALSE
-- 	AND (b.internal_status IS NULL OR b.internal_status <> 'Active')
	AND n.email IS NOT NULL