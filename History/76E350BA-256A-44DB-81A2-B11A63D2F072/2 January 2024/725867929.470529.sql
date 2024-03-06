SELECT
		'Jira' AS tool,
		LOWER(jira_u.email) AS email,
		jira_u.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM jra.user AS jira_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(jira_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND jira_u.active IS TRUE