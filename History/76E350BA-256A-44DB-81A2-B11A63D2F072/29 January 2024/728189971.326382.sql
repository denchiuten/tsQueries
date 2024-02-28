SELECT
		'Tableau' AS tool,
		LOWER(t.email) AS email,
		t.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM tableau.users AS t
	LEFT JOIN bob.employee AS emp
		ON LOWER(t.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND t._fivetran_deleted IS FALSE
		AND qb.email IS NOT NULL